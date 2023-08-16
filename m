Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059877DFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjHPK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244123AbjHPKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446613E;
        Wed, 16 Aug 2023 03:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26E464FFF;
        Wed, 16 Aug 2023 10:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BBCC433CA;
        Wed, 16 Aug 2023 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183347;
        bh=aK6+S+7t1XjbCYZWYAvH3oq+O1bDCKqIuzMFLq9adSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUO/agXF5SJIYVd1b6FJjwrV7WG6+KA44ikB9ADlRtGzhz8Y3j3RBJR65ub6k3WX8
         bqS2qtSZs7TnVKFDUK2wUf/MbpfcsRpn57Ier2lyVswAvOmYjj8WIIKcg867g933yI
         Ou94V3Bxt6le/PVQPvgImqDtW15uouZ/dTIiJTrOkl5xQGaM9T3mhEFS+4tjkIJJjs
         DX65uX66bXc1z+Ej5vCkYWZ4mDry+v2ztAN7eQGWxJNElUFsfDDDtkV8kDei3trSnB
         OJTqM22wtZDw0rorE3So9zuV98cBWFsKWqPxa3rsrEGRLkRBSKN+/CUCX3mPKOWhSD
         qbXmTWls0LSAA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/10] tty: tty_buffer: initialize variables in initializers already
Date:   Wed, 16 Aug 2023 12:55:29 +0200
Message-ID: <20230816105530.3335-10-jirislaby@kernel.org>
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

It makes the code both more compact, and more understandable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 414bb7f9155f..44c0adaec850 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -262,17 +262,10 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 				     bool flags)
 {
 	struct tty_bufhead *buf = &port->buf;
-	struct tty_buffer *b, *n;
-	size_t left;
-	bool change;
+	struct tty_buffer *n, *b = buf->tail;
+	size_t left = (b->flags ? 1 : 2) * b->size - b->used;
+	bool change = !b->flags && flags;
 
-	b = buf->tail;
-	if (!b->flags)
-		left = 2 * b->size - b->used;
-	else
-		left = b->size - b->used;
-
-	change = !b->flags && flags;
 	if (change || left < size) {
 		/* This is the slow path - looking for new buffers to use */
 		n = tty_buffer_alloc(port, size);
-- 
2.41.0

