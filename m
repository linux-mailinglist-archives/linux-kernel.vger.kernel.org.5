Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E347E6DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbjKIPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjKIPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:41:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB2835AB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7Bf0ubKs0gVlk4Wk6PRRBohRtCmGnBr4pYSMKODaaM=;
        b=Ex6YDh9tl4+0UBcXDPZTtK2Mz+DMx4u3TpREai3QkAdllSsRott5KH42FkXbeNA8LxIPOD
        7qcEj5JseRHPQQLrVe7Az9iguyVJ6Xup7svb6T3RzhgkB55zldxvWltUzNuV+zmW6De89x
        FsXQMtEopZW6UV1JkASlMxCp7aUmLlw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-AJOEPHdYNbKFuKRn6m8Zpg-1; Thu, 09 Nov 2023 10:40:18 -0500
X-MC-Unique: AJOEPHdYNbKFuKRn6m8Zpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C635811E7D;
        Thu,  9 Nov 2023 15:40:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6C812026D68;
        Thu,  9 Nov 2023 15:40:15 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/41] afs: Fix afs_server_list to be cleaned up with RCU
Date:   Thu,  9 Nov 2023 15:39:27 +0000
Message-ID: <20231109154004.3317227-5-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_server_list is accessed with the rcu_read_lock() held from
volume->servers, so it needs to be cleaned up correctly.

Fix this by using kfree_rcu() instead of kfree().

Fixes: 8a070a964877 ("afs: Detect cell aliases 1 - Cells with root volumes")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h    | 1 +
 fs/afs/server_list.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index da73b97e19a9..5041eae64423 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -553,6 +553,7 @@ struct afs_server_entry {
 };
 
 struct afs_server_list {
+	struct rcu_head		rcu;
 	afs_volid_t		vids[AFS_MAXTYPES]; /* Volume IDs */
 	refcount_t		usage;
 	unsigned char		nr_servers;
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index ed9056703505..b59896b1de0a 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -17,7 +17,7 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 		for (i = 0; i < slist->nr_servers; i++)
 			afs_unuse_server(net, slist->servers[i].server,
 					 afs_server_trace_put_slist);
-		kfree(slist);
+		kfree_rcu(slist, rcu);
 	}
 }
 

