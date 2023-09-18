Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C447A4989
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbjIRMYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbjIRMYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:24:35 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B88B106;
        Mon, 18 Sep 2023 05:24:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,156,1688396400"; 
   d="scan'208";a="176397781"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Sep 2023 21:24:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.107])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3569641F6AEF;
        Mon, 18 Sep 2023 21:24:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/3] irqchip: renesas-rzg2l: Mask interrupts for changing interrupt settings
Date:   Mon, 18 Sep 2023 13:24:10 +0100
Message-Id: <20230918122411.237635-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per RZ/G2L hardware manual Rev.1.30 section 8.8.3 Precaution when
changing interrupt settings,  we need to mask the interrupts for
any changes in below settings:

 * When changing the noise filter settings.
 * When switching the GPIO pins to IRQ or GPIOINT.
 * When changing the source of TINT.
 * When changing the interrupt detection method.

This patch masks the interrupts when there is a change in the interrupt
detection method and changing the source of TINT.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 2cee5477be6b..33a22bafedcd 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -116,11 +116,13 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 		u8 tssr_index = TSSR_INDEX(offset);
 		u32 reg;
 
+		irq_chip_mask_parent(d);
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
 		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
+		irq_chip_unmask_parent(d);
 	}
 	irq_chip_disable_parent(d);
 }
@@ -137,11 +139,13 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 		u8 tssr_index = TSSR_INDEX(offset);
 		u32 reg;
 
+		irq_chip_mask_parent(d);
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
 		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
+		irq_chip_unmask_parent(d);
 	}
 	irq_chip_enable_parent(d);
 }
@@ -226,10 +230,12 @@ static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
 	unsigned int hw_irq = irqd_to_hwirq(d);
 	int ret = -EINVAL;
 
+	irq_chip_mask_parent(d);
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
 		ret = rzg2l_irq_set_type(d, type);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
 		ret = rzg2l_tint_set_edge(d, type);
+	irq_chip_unmask_parent(d);
 	if (ret)
 		return ret;
 
-- 
2.25.1

