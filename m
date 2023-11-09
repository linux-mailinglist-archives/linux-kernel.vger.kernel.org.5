Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF447E6DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbjKIPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbjKIPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E65F35B7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MtMwzp5cGYFmDvtK+8DfAGMya4LsJda/H6E5L1cfs5c=;
        b=DtSlm0T397+UDcGEs/NpwJl5CAY2zCc7mrDT7TYVpQluYNVSp2Evbi7+LdZzQDy1TVuUkX
        P2AiDwAKlB1YuOO9PEWSWURf8srJyupQcn/Btz59GO4WqB/d8tXkH+UnJ8yNq+P0nlTqrd
        b7eK4KvvZAwOZSsL+q4539+0HjtIK4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-AnTV_cjYNIW4RpKqNNFvlQ-1; Thu, 09 Nov 2023 10:40:40 -0500
X-MC-Unique: AnTV_cjYNIW4RpKqNNFvlQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73159848B66;
        Thu,  9 Nov 2023 15:40:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B6D3492BF6;
        Thu,  9 Nov 2023 15:40:37 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Suvanto <markus.suvanto@gmail.com>
Subject: [PATCH 15/41] afs: Return ENOENT if no cell DNS record can be found
Date:   Thu,  9 Nov 2023 15:39:38 +0000
Message-ID: <20231109154004.3317227-16-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make AFS return error ENOENT if no cell SRV or AFSDB DNS record (or
cellservdb config file record) can be found rather than returning
EDESTADDRREQ.

Also add cell name lookup info to the cursor dump.

Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/vl_rotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index af5c6cd1ed44..01c890b3d18d 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -58,6 +58,12 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 		}
 
 		/* Status load is ordered after lookup counter load */
+		if (cell->dns_status == DNS_LOOKUP_GOT_NOT_FOUND) {
+			pr_warn("No record of cell %s\n", cell->name);
+			vc->error = -ENOENT;
+			return false;
+		}
+
 		if (cell->dns_source == DNS_RECORD_UNAVAILABLE) {
 			vc->error = -EDESTADDRREQ;
 			return false;
@@ -285,6 +291,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
  */
 static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 {
+	struct afs_cell *cell = vc->cell;
 	static int count;
 	int i;
 
@@ -294,6 +301,9 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 
 	rcu_read_lock();
 	pr_notice("EDESTADDR occurred\n");
+	pr_notice("CELL: %s err=%d\n", cell->name, cell->error);
+	pr_notice("DNS: src=%u st=%u lc=%x\n",
+		  cell->dns_source, cell->dns_status, cell->dns_lookup_count);
 	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
 		  vc->untried, vc->index, vc->nr_iterations, vc->flags, vc->error);
 

