Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5777D8FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjJ0HYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0HYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:24:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A3192;
        Fri, 27 Oct 2023 00:24:02 -0700 (PDT)
Date:   Fri, 27 Oct 2023 07:24:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698391441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6Dghujogbztdmwt/jqBXHDqaTSSB292Ldx3Ap8/ojs=;
        b=bxI4eeO0wIqXfcGStkvU4dBwkvt2xon/Ec3JWufxozWqkLiTOY0ucG9rlTSAwFi9OvXjwO
        bOG7dGGkdeqDS97gVPZu+Zo1EmxzD62KK0kQao0YIRbM1w11MQSate2opRQdIW4+x5Qdzb
        GjWJeu6KnPUQjcotdTbCdO6bfTSNhdkBnbUj2xW2zWvCRFKstcbIPDrlf3TS4aZcBXJeUM
        bLqbJdaA43NVPSIN428SOuIGcxG7FUm5sdfFKGpjB068ULsHyX+Ebu8oUYmOGQUpUXokNC
        uQZoF2ODvYFPafyV8bAkgdyKxTxKhRqOANSTsEyN45OTjvE1vXmixAHL90881Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698391441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6Dghujogbztdmwt/jqBXHDqaTSSB292Ldx3Ap8/ojs=;
        b=rkc7B6nRgb7TpPIOcgHz4laIoXwc2FUpnqg6b+fFot6jhA4ryoL39PrCZ0Pf3P/28Zmv4p
        4ux8QMnZ5WxqD1Cw==
From:   "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/generic_chip: Make irq_remove_generic_chip()
 irqdomain aware
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231024150335.322282-1-herve.codina@bootlin.com>
References: <20231024150335.322282-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Message-ID: <169839144046.3135.18250117406954696469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5e7afb2eb7b2a7c81e9f608cbdf74a07606fd1b5
Gitweb:        https://git.kernel.org/tip/5e7afb2eb7b2a7c81e9f608cbdf74a07606fd1b5
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Tue, 24 Oct 2023 17:03:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Oct 2023 09:15:44 +02:00

genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

irq_remove_generic_chip() calculates the Linux interrupt number for removing the
handler and interrupt chip based on gc::irq_base as a linear function of
the bit positions of set bits in the @msk argument.

When the generic chip is present in an irq domain, i.e. created with a call
to irq_alloc_domain_generic_chips(), gc::irq_base contains not the base
Linux interrupt number.  It contains the base hardware interrupt for this
chip. It is set to 0 for the first chip in the domain, 0 + N for the next
chip, where $N is the number of hardware interrupts per chip.

That means the Linux interrupt number cannot be calculated based on
gc::irq_base for irqdomain based chips without a domain map lookup, which
is currently missing.

Rework the code to take the irqdomain case into account and calculate the
Linux interrupt number by a irqdomain lookup of the domain specific
hardware interrupt number.

[ tglx: Massage changelog. Reshuffle the logic and add a proper comment. ]

Fixes: cfefd21e693d ("genirq: Add chip suspend and resume callbacks")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231024150335.322282-1-herve.codina@bootlin.com

---
 kernel/irq/generic-chip.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 81ecca0..d39a40b 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -548,21 +548,34 @@ EXPORT_SYMBOL_GPL(irq_setup_alt_chip);
 void irq_remove_generic_chip(struct irq_chip_generic *gc, u32 msk,
 			     unsigned int clr, unsigned int set)
 {
-	unsigned int i = gc->irq_base;
+	unsigned int i, virq;
 
 	raw_spin_lock(&gc_lock);
 	list_del(&gc->list);
 	raw_spin_unlock(&gc_lock);
 
-	for (; msk; msk >>= 1, i++) {
+	for (i = 0; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
 			continue;
 
+		/*
+		 * Interrupt domain based chips store the base hardware
+		 * interrupt number in gc::irq_base. Otherwise gc::irq_base
+		 * contains the base Linux interrupt number.
+		 */
+		if (gc->domain) {
+			virq = irq_find_mapping(gc->domain, gc->irq_base + i);
+			if (!virq)
+				continue;
+		} else {
+			virq = gc->irq_base + i;
+		}
+
 		/* Remove handler first. That will mask the irq line */
-		irq_set_handler(i, NULL);
-		irq_set_chip(i, &no_irq_chip);
-		irq_set_chip_data(i, NULL);
-		irq_modify_status(i, clr, set);
+		irq_set_handler(virq, NULL);
+		irq_set_chip(virq, &no_irq_chip);
+		irq_set_chip_data(virq, NULL);
+		irq_modify_status(virq, clr, set);
 	}
 }
 EXPORT_SYMBOL_GPL(irq_remove_generic_chip);
