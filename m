Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8456177DFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbjHPK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244125AbjHPKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3E13E;
        Wed, 16 Aug 2023 03:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AFE564C77;
        Wed, 16 Aug 2023 10:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BDFC433C8;
        Wed, 16 Aug 2023 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183348;
        bh=VEJwLY7hoPdNX4XnvykJ3RU6LGaAEAvuCCAn2+uGWxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2XDJqTl/pi4RpIiL4mEcVSC4RFSFu6dF9VdWLJNMGOyt1fMTbKbHwaOaU15B4Rs8
         NpLR5QsCB3Szt52ZVkdxT9ju8/sxRQp8yZ7eyZufL0ja6nDcq4IF/mBlbzanRcaoMg
         3YHR9LyFfb8cmb5tuzWKcb4imdnlivnrntNKaqWX4bmY92Z+BV0ceawAVY78ev2ucL
         wftcYbM/6RR2wVbf3LiW41SX32BBkut/iNUFfb/mrVmne1G3qmQy6j4jkp5WHdC0m7
         /w6TFbX/MT5a2mcSHyofaE34a+ryKAjro+N0UFW5/S5FC6/hgv2/WeKERpxLuxnmjW
         wlVtmqR8WfEIQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/10] tty: tty_buffer: invert conditions in __tty_buffer_request_room()
Date:   Wed, 16 Aug 2023 12:55:30 +0200
Message-ID: <20230816105530.3335-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are used to handle "bad" states in the 'if's in the kernel. Refactor
(invert the two conditions in) __tty_buffer_request_room(), so that the
code returns from the fast paths immediately instead of postponing to
the heavy end of the function.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 44c0adaec850..5f6d0cf67571 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -266,28 +266,28 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 	size_t left = (b->flags ? 1 : 2) * b->size - b->used;
 	bool change = !b->flags && flags;
 
-	if (change || left < size) {
-		/* This is the slow path - looking for new buffers to use */
-		n = tty_buffer_alloc(port, size);
-		if (n != NULL) {
-			n->flags = flags;
-			buf->tail = n;
-			/*
-			 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
-			 * ensures they see all buffer data.
-			 */
-			smp_store_release(&b->commit, b->used);
-			/*
-			 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
-			 * ensures the latest commit value can be read before the head
-			 * is advanced to the next buffer.
-			 */
-			smp_store_release(&b->next, n);
-		} else if (change)
-			size = 0;
-		else
-			size = left;
-	}
+	if (!change && left >= size)
+		return size;
+
+	/* This is the slow path - looking for new buffers to use */
+	n = tty_buffer_alloc(port, size);
+	if (n == NULL)
+		return change ? 0 : left;
+
+	n->flags = flags;
+	buf->tail = n;
+	/*
+	 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
+	 * ensures they see all buffer data.
+	 */
+	smp_store_release(&b->commit, b->used);
+	/*
+	 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
+	 * ensures the latest commit value can be read before the head
+	 * is advanced to the next buffer.
+	 */
+	smp_store_release(&b->next, n);
+
 	return size;
 }
 
-- 
2.41.0

