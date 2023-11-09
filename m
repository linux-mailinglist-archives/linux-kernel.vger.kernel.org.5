Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B177E6DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbjKIPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbjKIPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC7135B6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWgdpB1RBpu2oN1tZdpNZiyez3R7RR3/B1JgO269mJA=;
        b=AwgipVyHy4R3B9HkQP7PVK8fSFDBbMdrC5Atzb3ojKtiIbu4cVEuaOuuD/BI8SIU3Bit5y
        Ck+5ElbritTe9kLl06tzIKUKrtPUYdEn9uvkOunF4D2o0A3hHIT9tMV6uhfUA8wco7xdiw
        Z3kjxlrcrv0EoXJV5PxEcB/+2Te9zl4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-wr3d_UkmOfmwBt5SEoVuIQ-1; Thu, 09 Nov 2023 10:40:37 -0500
X-MC-Unique: wr3d_UkmOfmwBt5SEoVuIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75D3290F943;
        Thu,  9 Nov 2023 15:40:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5ADC0FE05;
        Thu,  9 Nov 2023 15:40:34 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/41] afs: Handle the VIO abort explicitly
Date:   Thu,  9 Nov 2023 15:39:36 +0000
Message-ID: <20231109154004.3317227-14-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When processing the result of a call, handle the VIO abort specifically
rather than leaving it to a default case.  Rather than erroring out
unconditionally, see if there's another server if the volume has more than
one server available, otherwise return -EREMOTEIO.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 0f59f2a81f23..342afc951fe4 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -329,6 +329,12 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 			goto restart_from_beginning;
 
+		case VIO:
+			op->error = -EREMOTEIO;
+			if (op->volume->type != AFSVL_RWVOL)
+				goto next_server;
+			goto failed;
+
 		case VDISKFULL:
 		case UAENOSPC:
 			/* The partition is full.  Only applies to RWVOLs.

