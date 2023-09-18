Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA527A49CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbjIRMe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241618AbjIRMew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:34:52 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B608DE;
        Mon, 18 Sep 2023 05:34:10 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,156,1688396400"; 
   d="scan'208";a="176398365"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Sep 2023 21:34:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.107])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9F6E84005E22;
        Mon, 18 Sep 2023 21:34:06 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO interrupt input
Date:   Mon, 18 Sep 2023 13:33:55 +0100
Message-Id: <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
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

As per RZ/G2L hardware manual Rev.1.30 section 8.7.3 GPIO Interrupt (TINT)
and 41.4.1 Operation for GPIO function, we need to set digital noise
filter for GPIO interrupt.

This patch enables noise filter for GPIO interrupt in
rzg2l_gpio_irq_enable() and disable it in rzg2l_gpio_irq_disable().

Fixes: db2e5f21a48e ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 2ea6ef99cc70..6d3fa962ac97 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -96,6 +96,7 @@
 #define PIN(n)			(0x0800 + 0x10 + (n))
 #define IOLH(n)			(0x1000 + (n) * 8)
 #define IEN(n)			(0x1800 + (n) * 8)
+#define FILONOFF(n)		(0x2080 + (n) * 8)
 #define ISEL(n)			(0x2c80 + (n) * 8)
 #define PWPR			(0x3014)
 #define SD_CH(n)		(0x3000 + (n) * 4)
@@ -1169,9 +1170,9 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
+	void __iomem *addr, *noise_filter_addr;
 	unsigned int hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
-	void __iomem *addr;
 	u32 port;
 	u8 bit;
 
@@ -1181,12 +1182,15 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 
 	addr = pctrl->base + ISEL(port);
+	noise_filter_addr = pctrl->base + FILONOFF(port);
 	if (bit >= 4) {
 		bit -= 4;
 		addr += 4;
+		noise_filter_addr += 4;
 	}
 
 	spin_lock_irqsave(&pctrl->lock, flags);
+	writel(readl(noise_filter_addr) & ~BIT(bit * 8), noise_filter_addr);
 	writel(readl(addr) & ~BIT(bit * 8), addr);
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
@@ -1197,9 +1201,9 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
+	void __iomem *addr, *noise_filter_addr;
 	unsigned int hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
-	void __iomem *addr;
 	u32 port;
 	u8 bit;
 
@@ -1209,13 +1213,16 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 
 	addr = pctrl->base + ISEL(port);
+	noise_filter_addr = pctrl->base + FILONOFF(port);
 	if (bit >= 4) {
 		bit -= 4;
 		addr += 4;
+		noise_filter_addr += 4;
 	}
 
 	spin_lock_irqsave(&pctrl->lock, flags);
 	writel(readl(addr) | BIT(bit * 8), addr);
+	writel(readl(noise_filter_addr) | BIT(bit * 8), noise_filter_addr);
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	irq_chip_enable_parent(d);
-- 
2.25.1

