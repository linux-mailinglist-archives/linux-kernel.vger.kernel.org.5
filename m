Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9799D81137E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441799AbjLMNvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379331AbjLMNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F295
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702475432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=At55AdxI0EVqvLoVtG7qh0zVypL7yPQ0gJ4RwZozN0o=;
        b=NjAZXPDYIU5KkbzxAwQDnGdzjUKdte4XOKtteXXmXQ5+/04qe6IP7Z+LsdiRbQNVOwf8qU
        7y0SW9/VY1oJ8+yPNh/wwwCEXk0dj0u2E2UVjZVh83/QWlRMkK3ZyqyRRBf7nzmDIUyjzW
        VN87BuoCZKKThJTE0YpeVFYq5vvws9A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-iTfH0SaSNVqQa9XMdNQ_yg-1; Wed,
 13 Dec 2023 08:50:27 -0500
X-MC-Unique: iTfH0SaSNVqQa9XMdNQ_yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5862F3C2A1C3;
        Wed, 13 Dec 2023 13:50:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D38C1121306;
        Wed, 13 Dec 2023 13:50:26 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/40] afs: Use op->nr_iterations=-1 to indicate to begin fileserver iteration
Date:   Wed, 13 Dec 2023 13:49:35 +0000
Message-ID: <20231213135003.367397-14-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set op->nr_iterations to -1 to indicate that we need to begin fileserver
iteration rather than setting error to SHRT_MAX.  This makes it easier to
eliminate the address cursor.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c |  2 +-
 fs/afs/internal.h     |  2 +-
 fs/afs/rotate.c       | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 7a3803ce3a22..3e31fae9a149 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -41,7 +41,7 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 	op->cb_v_break	= volume->cb_v_break;
 	op->debug_id	= atomic_inc_return(&afs_operation_debug_counter);
 	op->error	= -EDESTADDRREQ;
-	op->ac.error	= SHRT_MAX;
+	op->nr_iterations = -1;
 
 	_leave(" = [op=%08x]", op->debug_id);
 	return op;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 95bb37253cad..e43aef74c241 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -859,7 +859,7 @@ struct afs_operation {
 	struct afs_call		*call;
 	unsigned long		untried;	/* Bitmask of untried servers */
 	short			index;		/* Current server */
-	unsigned short		nr_iterations;	/* Number of server iterations */
+	short			nr_iterations;	/* Number of server iterations */
 
 	unsigned int		flags;
 #define AFS_OPERATION_STOP		0x0001	/* Set to cease iteration */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 0829933f4d9a..4d2317a66385 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -116,7 +116,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	unsigned int rtt;
 	int error = op->ac.error, i;
 
-	_enter("%lx[%d],%lx[%d],%d,%d",
+	op->nr_iterations++;
+
+	_enter("OP=%x+%x,%llx,%lx[%d],%lx[%d],%d,%d",
+	       op->debug_id, op->nr_iterations, op->volume->vid,
 	       op->untried, op->index,
 	       op->ac.tried, op->ac.index,
 	       error, op->ac.abort_code);
@@ -126,13 +129,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 		return false;
 	}
 
-	op->nr_iterations++;
+	if (op->nr_iterations == 0)
+		goto start;
 
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (error) {
-	case SHRT_MAX:
-		goto start;
-
 	case 0:
 	default:
 		/* Success or local failure.  Stop. */

