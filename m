Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE980EF23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376951AbjLLOoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376866AbjLLOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:44:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA2F7;
        Tue, 12 Dec 2023 06:44:25 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBj7xDJIEq6D0WsMhoB3LPit7gFoN547baL40Uvxv0U=;
        b=aX6B9r0QNHPLjCa5ALDjUKdfxb0iWi8YrfmcS1o9/TVzAjI5AHs0RzW+npfdo4w2Kt+skW
        3QEl6g+mg7xSkL6R4nh5i5oOyMKU8SKMKNghvk5kNHIh7MUX78LEs4Pf/0IF4tRBu1eiRV
        qNXx9fFcGuqKRra9eG+7VfjqfBsWyVVHyFYcKnveDiF/u3CAkbL4LB5Re3PHC4Eim9lkXv
        AmTjDo1hJm+0DHXE8g1aj/Tar5GLkPqkAb+hyJLkhd7L8HHWQoECZmbSs7Nns0jMe0vJCR
        cgvIxPLxRztIp8gEnGPKcnh9RzLN1t/sOOMeAjFpM44BYNmphVZyaAkKPsPK3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBj7xDJIEq6D0WsMhoB3LPit7gFoN547baL40Uvxv0U=;
        b=wi1j/KpziizDDNrVB3LwU5p06OmyQYPsJRsiAZSYCdgAB9a5h+jQboiZLPHxbAnqs6GxDg
        MurvbeKGocmrUoBw==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Implement restriction when
 writing ISCR register
Cc:     Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <170239226360.398.4471792176265602283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ef88eefb1a81a8701eabb7d5ced761a66a465a49
Gitweb:        https://git.kernel.org/tip/ef88eefb1a81a8701eabb7d5ced761a66a465a49
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:41 +01:00

irqchip/renesas-rzg2l: Implement restriction when writing ISCR register

The RZ/G2L manual (chapter "IRQ Status Control Register (ISCR)") describes
the operation to clear interrupts through the ISCR register as follows:

[Write operation]

  When "Falling-edge detection", "Rising-edge detection" or
  "Falling/Rising-edge detection" is set in IITSR:

    - In case ISTAT is 1
	0: IRQn interrupt detection status is cleared.
	1: Invalid to write.
    - In case ISTAT is 0
	Invalid to write.

  When "Low-level detection" is set in IITSR.:
        Invalid to write.

Take the interrupt type into account when clearing interrupts through the
ISCR register to avoid writing the ISCR when the interrupt type is level.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 0a77927..d450417 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -78,11 +78,17 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	u32 bit = BIT(hw_irq);
-	u32 reg;
+	u32 iitsr, iscr;
 
-	reg = readl_relaxed(priv->base + ISCR);
-	if (reg & bit)
-		writel_relaxed(reg & ~bit, priv->base + ISCR);
+	iscr = readl_relaxed(priv->base + ISCR);
+	iitsr = readl_relaxed(priv->base + IITSR);
+
+	/*
+	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
+	 * falling/rising-edge.
+	 */
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
+		writel_relaxed(iscr & ~bit, priv->base + ISCR);
 }
 
 static void rzg2l_tint_eoi(struct irq_data *d)
