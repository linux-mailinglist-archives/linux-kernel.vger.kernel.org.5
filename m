Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F577A498A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbjIRMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbjIRMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:24:38 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DB869F;
        Mon, 18 Sep 2023 05:24:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,156,1688396400"; 
   d="scan'208";a="180128606"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Sep 2023 21:24:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.107])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9B45C41F6AEF;
        Mon, 18 Sep 2023 21:24:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with edge trigger detection for TINT
Date:   Mon, 18 Sep 2023 13:24:11 +0100
Message-Id: <20230918122411.237635-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of edge trigger detection, enabling the TINT source causes a
phantum interrupt that leads to irq storm. So clear the phantum interrupt
in rzg2l_irqc_irq_enable().

This issue is observed when the irq handler disables the interrupts using
disable_irq_nosync() and scheduling a work queue and in the work queue,
re-enabling the interrupt with enable_irq().

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 33a22bafedcd..78a9e90512a6 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -144,6 +144,12 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
 		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		/*
+		 * In case of edge trigger detection, enabling the TINT source
+		 * cause a phantum interrupt that leads to irq storm. So clear
+		 * the phantum interrupt.
+		 */
+		rzg2l_tint_eoi(d);
 		raw_spin_unlock(&priv->lock);
 		irq_chip_unmask_parent(d);
 	}
-- 
2.25.1

