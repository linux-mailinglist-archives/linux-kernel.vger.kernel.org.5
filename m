Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B87D54A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJXPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJXPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:03:54 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE6D7F;
        Tue, 24 Oct 2023 08:03:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 65EA2C0009;
        Tue, 24 Oct 2023 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698159829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mnkAD7DkJI94ZoXAZ/b9DAALS/X6VFawfu3j3rG7d3E=;
        b=HlMf3ubEdI6c9l2+/oyORY3sLlA40G1P7Vm5nLQ/AMYXbOMVRdQG5P5qwh69k59tCRx9Bh
        o3PrM0DEB6ROXgjOneSl0lxdH31proVxENNo9ml32/qFSvIsctMBfpyL02CL2JaUsl33BL
        HHOPrZEd1Hg194pBPdLsKSWXCAHVtvMJp7FkjBkh2uwFWu8s50VOSfpNISgDzxLjoPr+fc
        X5otw/klEF8OZxNx5obWwHbHWyD15ia3v/IEHmwTmt2Mb53Df/mbg8TKxo4CIzrrlLb9xv
        pf7KcDRbuYItSrmO4AjSuEHeyS2rILXo+vwiH2uVn53HODq35CUSGZ6nC4nHZw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH 1/1] genirq/generic_chip: Fix irq_remove_generic_chip() when an irq domain is used
Date:   Tue, 24 Oct 2023 17:03:35 +0200
Message-ID: <20231024150335.322282-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_remove_generic_chip() can call (depending on the msk parameter
value) several operations on irqs based on gc->irq_base such as
irq_set_handler(irq, NULL) to remove an handler.

When the generic chip is present in an irq domain (created with a call
to irq_alloc_domain_generic_chips()), gc->irq_base is the base hardware
irq for this chip. It is set to 0 for the first chip in the domain,
0 + n for the next chip (with n the number of hardware irqs per chip)
and so on.
In that case, the operations done on irqs based on gc->irq_base touch
some irqs not related to the chip nor the domain breaking some unrelated
components in the system.

In order to avoid touching these "outside" irqs, take care of the domain
irq mapping and translate the chip hardware irq to an irq number
suitable for the several operations done.

Fixes: cfefd21e693d ("genirq: Add chip suspend and resume callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/generic-chip.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c653cd31548d..494584e25ef4 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -544,21 +544,28 @@ EXPORT_SYMBOL_GPL(irq_setup_alt_chip);
 void irq_remove_generic_chip(struct irq_chip_generic *gc, u32 msk,
 			     unsigned int clr, unsigned int set)
 {
-	unsigned int i = gc->irq_base;
+	unsigned int irq;
+	unsigned int i;
 
 	raw_spin_lock(&gc_lock);
 	list_del(&gc->list);
 	raw_spin_unlock(&gc_lock);
 
-	for (; msk; msk >>= 1, i++) {
+	for (i = 0; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
 			continue;
 
+		irq = gc->domain ?
+			irq_find_mapping(gc->domain, gc->irq_base + i) :
+			gc->irq_base + i;
+		if (!irq)
+			continue;
+
 		/* Remove handler first. That will mask the irq line */
-		irq_set_handler(i, NULL);
-		irq_set_chip(i, &no_irq_chip);
-		irq_set_chip_data(i, NULL);
-		irq_modify_status(i, clr, set);
+		irq_set_handler(irq, NULL);
+		irq_set_chip(irq, &no_irq_chip);
+		irq_set_chip_data(irq, NULL);
+		irq_modify_status(irq, clr, set);
 	}
 }
 EXPORT_SYMBOL_GPL(irq_remove_generic_chip);
-- 
2.41.0

