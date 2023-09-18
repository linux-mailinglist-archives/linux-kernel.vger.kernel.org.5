Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8C7A49CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbjIRMe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241517AbjIRMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:34:45 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5272E4C;
        Mon, 18 Sep 2023 05:34:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,156,1688396400"; 
   d="scan'208";a="176398360"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Sep 2023 21:34:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.107])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E14174005E22;
        Mon, 18 Sep 2023 21:34:02 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 1/2] pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()
Date:   Mon, 18 Sep 2023 13:33:54 +0100
Message-Id: <20230918123355.262115-2-biju.das.jz@bp.renesas.com>
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

We usually do reverse order of enable() for disable(). Currently, the
ordering of irq_chip_disable_parent() is not correct in
rzg2l_gpio_irq_disable(). Fix the incorrect order.

Fixes: db2e5f21a48e ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 37cdfe4b04f9..2ea6ef99cc70 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1175,6 +1175,8 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	u32 port;
 	u8 bit;
 
+	irq_chip_disable_parent(d);
+
 	port = RZG2L_PIN_ID_TO_PORT(hwirq);
 	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 
@@ -1189,7 +1191,6 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	gpiochip_disable_irq(gc, hwirq);
-	irq_chip_disable_parent(d);
 }
 
 static void rzg2l_gpio_irq_enable(struct irq_data *d)
-- 
2.25.1

