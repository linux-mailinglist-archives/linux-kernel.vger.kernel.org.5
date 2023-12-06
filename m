Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AE8068B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjLFHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjLFHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5019B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B0CC433CC;
        Wed,  6 Dec 2023 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848263;
        bh=vx/MuvUsQSvv1EouHrNkdKzoIAgHm5f/1Px1Jg2vH4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYqDjxsNCfuFf9Y/UF2sFfxDk2DzRyPakA/MJEECRB1D6FVXT83Pvb3N9b++LtVsy
         +KoNyI3YVuhhSb7Q/4ONmBSQjtUussVES/pdP0SQQJBUEXVFoW2+q4ptjzFq5BmhHt
         WBFZ2UH3ipcY6garWdOS7jHha5OPAeA1lt4ak2sB/S8AXs88AZ0n6LvwjubHVdzQ6X
         6vvMzVTxlEcN91YLby54IGcx6NeKxsFgdQ59lXoogNoBPOPu3ChS56IKI2OfSV1oqD
         BpjFxLIgL6BQZVtSS4lq9Bv+8nBvauJg+BuJHdT69aRroeED3h1oMWeIup01LnZfnh
         NfqkBwq9ifBKQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/27] tty: goldfish: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:36:56 +0100
Message-ID: <20231206073712.17776-12-jirislaby@kernel.org>
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 7ad7fa66cb27..d27979eabfdf 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -50,10 +50,8 @@ static u32 goldfish_tty_line_count = 8;
 static u32 goldfish_tty_current_line_count;
 static struct goldfish_tty *goldfish_ttys;
 
-static void do_rw_io(struct goldfish_tty *qtty,
-		     unsigned long address,
-		     unsigned int count,
-		     bool is_write)
+static void do_rw_io(struct goldfish_tty *qtty, unsigned long address,
+		     size_t count, bool is_write)
 {
 	unsigned long irq_flags;
 	void __iomem *base = qtty->base;
@@ -73,10 +71,8 @@ static void do_rw_io(struct goldfish_tty *qtty,
 	spin_unlock_irqrestore(&qtty->lock, irq_flags);
 }
 
-static void goldfish_tty_rw(struct goldfish_tty *qtty,
-			    unsigned long addr,
-			    unsigned int count,
-			    bool is_write)
+static void goldfish_tty_rw(struct goldfish_tty *qtty, unsigned long addr,
+			    size_t count, bool is_write)
 {
 	dma_addr_t dma_handle;
 	enum dma_data_direction dma_dir;
@@ -125,7 +121,7 @@ static void goldfish_tty_rw(struct goldfish_tty *qtty,
 	}
 }
 
-static void goldfish_tty_do_write(int line, const u8 *buf, unsigned int count)
+static void goldfish_tty_do_write(int line, const u8 *buf, size_t count)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[line];
 
@@ -136,7 +132,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 {
 	struct goldfish_tty *qtty = dev_id;
 	void __iomem *base = qtty->base;
-	unsigned char *buf;
+	u8 *buf;
 	u32 count;
 
 	count = gf_ioread32(base + GOLDFISH_TTY_REG_BYTES_READY);
-- 
2.43.0

