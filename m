Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2480EF56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376952AbjLLOwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbjLLOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:52:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FCD5;
        Tue, 12 Dec 2023 06:52:41 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4z8tpZKqZ4UtXMm//5sO6ZKH1IbaOHgpQQp7lY2ai5U=;
        b=3zfsLQscP/6RK9Dr7FHmjpSo+JO0zkF+VZVtR/iToB6gwWwGTko7C6o4yctrhDyUstTmNt
        i4/5s9aNQtp8HHW2BAoauk3T6aZKsa6gJVCtc4w+BVzYDNQkIrVJt+FL+yfL69QHvLJJ/8
        PmFQEf6UA7o7u5BfMN2J0UYiiyLSORhVQFSsS6ZLCcyZn011MZ3VaAbEfEMKw6Owgq3vZ9
        UP8lrYcDke70mSH6gVC36KO2AQ+gcfcCMM2w1FFpX3mXzuiqQ0eRSby/BK92lNpXPRPrVG
        6UT3S4ARoaRDV+tyqFInoYCP0QWi071/z0hmh5j9s2iEMoG435qtkhZAVEN0KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4z8tpZKqZ4UtXMm//5sO6ZKH1IbaOHgpQQp7lY2ai5U=;
        b=Vd+sjz6PcIbYtijpY7NH47GvJWvwifNCec8CA7txEFDPVhky3UxDo63BtQyLSoWYb4mbmx
        nW6hsz5PtOSE/LDQ==
From:   "tip-bot2 for Max Filippov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-xtensa-pic: Clean up
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231208163857.82644-1-jcmvbkbc@gmail.com>
References: <20231208163857.82644-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Message-ID: <170239275928.398.14591907265015447414.tip-bot2@tip-bot2>
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

Commit-ID:     69ffab9b9e698248cbb4042e47f82afb00dc1bb4
Gitweb:        https://git.kernel.org/tip/69ffab9b9e698248cbb4042e47f82afb00dc1bb4
Author:        Max Filippov <jcmvbkbc@gmail.com>
AuthorDate:    Fri, 08 Dec 2023 08:38:57 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:45:39 +01:00

irqchip/irq-xtensa-pic: Clean up

  - get rid of the cached_irq_mask variable
  - use BIT() macro instead of bit shifts
  - drop .disable and .enable as they are equivalent to the default
    implementations

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231208163857.82644-1-jcmvbkbc@gmail.com
---
 drivers/irqchip/irq-xtensa-pic.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index 0c18d1f..f9d6fce 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -12,6 +12,7 @@
  * Kevin Chea
  */
 
+#include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
@@ -19,8 +20,6 @@
 #include <linux/irqchip/xtensa-pic.h>
 #include <linux/of.h>
 
-unsigned int cached_irq_mask;
-
 /*
  * Device Tree IRQ specifier translation function which works with one or
  * two cell bindings. First cell value maps directly to the hwirq number.
@@ -44,34 +43,30 @@ static const struct irq_domain_ops xtensa_irq_domain_ops = {
 
 static void xtensa_irq_mask(struct irq_data *d)
 {
-	cached_irq_mask &= ~(1 << d->hwirq);
-	xtensa_set_sr(cached_irq_mask, intenable);
-}
+	u32 irq_mask;
 
-static void xtensa_irq_unmask(struct irq_data *d)
-{
-	cached_irq_mask |= 1 << d->hwirq;
-	xtensa_set_sr(cached_irq_mask, intenable);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask &= ~BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
 }
 
-static void xtensa_irq_enable(struct irq_data *d)
+static void xtensa_irq_unmask(struct irq_data *d)
 {
-	xtensa_irq_unmask(d);
-}
+	u32 irq_mask;
 
-static void xtensa_irq_disable(struct irq_data *d)
-{
-	xtensa_irq_mask(d);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask |= BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
 }
 
 static void xtensa_irq_ack(struct irq_data *d)
 {
-	xtensa_set_sr(1 << d->hwirq, intclear);
+	xtensa_set_sr(BIT(d->hwirq), intclear);
 }
 
 static int xtensa_irq_retrigger(struct irq_data *d)
 {
-	unsigned int mask = 1u << d->hwirq;
+	unsigned int mask = BIT(d->hwirq);
 
 	if (WARN_ON(mask & ~XCHAL_INTTYPE_MASK_SOFTWARE))
 		return 0;
@@ -81,8 +76,6 @@ static int xtensa_irq_retrigger(struct irq_data *d)
 
 static struct irq_chip xtensa_irq_chip = {
 	.name		= "xtensa",
-	.irq_enable	= xtensa_irq_enable,
-	.irq_disable	= xtensa_irq_disable,
 	.irq_mask	= xtensa_irq_mask,
 	.irq_unmask	= xtensa_irq_unmask,
 	.irq_ack	= xtensa_irq_ack,
