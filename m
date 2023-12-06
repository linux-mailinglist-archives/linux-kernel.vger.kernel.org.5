Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CC80688A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376726AbjLFHhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjLFHhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:37:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D7D44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C59C433C9;
        Wed,  6 Dec 2023 07:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848243;
        bh=ZDmoAy6WV6x6U4PKECQB462q+EjbB6bBRjNbii6C7fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3KiKHVniZzYbU8D8vr744J7b2uywgMPYUR+NYQ6DcyhlD3V0fYP1CeaxrUx7VDMO
         fS4KSaoDurVYT0tzpiK+DFon2qU8eAhP0wJJJpGfaRZ33EkURpLM23eSWl+i8M6JF/
         a3uFnM1AeZtr1RPKY15XNbbu38HVOhocc8i7MrtK88ecdVVg+LZdDd5SKUC5Ift1vh
         Ix+RtPFOXck+w782fYIgzP/BYW4ysFeqFSVRnDjcki/zODJJbj+I1V17qElzYC3Dsm
         etHUSVAkVg/Y98AiK1h9nSgKYNmvvML/4k/bOvTspgTsg0LCsLZVL+eSECn9yFT8qU
         Pj96PL3xbwoQg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/27] tty: goldfish: use bool for is_write parameter
Date:   Wed,  6 Dec 2023 08:36:46 +0100
Message-ID: <20231206073712.17776-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_rw_io()'s is_write parameter is boolean, but typed int. Switch to the
former, so that it's obvious. (And the two users too.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index dccf6c6c69c6..7ad7fa66cb27 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -53,7 +53,7 @@ static struct goldfish_tty *goldfish_ttys;
 static void do_rw_io(struct goldfish_tty *qtty,
 		     unsigned long address,
 		     unsigned int count,
-		     int is_write)
+		     bool is_write)
 {
 	unsigned long irq_flags;
 	void __iomem *base = qtty->base;
@@ -76,7 +76,7 @@ static void do_rw_io(struct goldfish_tty *qtty,
 static void goldfish_tty_rw(struct goldfish_tty *qtty,
 			    unsigned long addr,
 			    unsigned int count,
-			    int is_write)
+			    bool is_write)
 {
 	dma_addr_t dma_handle;
 	enum dma_data_direction dma_dir;
@@ -129,7 +129,7 @@ static void goldfish_tty_do_write(int line, const u8 *buf, unsigned int count)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[line];
 
-	goldfish_tty_rw(qtty, (unsigned long)buf, count, 1);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, true);
 }
 
 static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
@@ -145,7 +145,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 
 	count = tty_prepare_flip_string(&qtty->port, &buf, count);
 
-	goldfish_tty_rw(qtty, (unsigned long)buf, count, 0);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, false);
 
 	tty_flip_buffer_push(&qtty->port);
 	return IRQ_HANDLED;
-- 
2.43.0

