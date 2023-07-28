Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585CE766AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjG1Kcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjG1Kc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:32:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A05584;
        Fri, 28 Jul 2023 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540233; x=1722076233;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+9RuzNpYmHyqf7fIjBX42rka1JAIk57K6KkiNE8I2wU=;
  b=bPO5meYIKfMiK7y3y7VOhDAynBAglYcOKp3HT74UBn+KxwxHsL+/ye5H
   Ag6G8bO1ihKQi4BBCCUOzKmAerjDLfXDSQn9lJ5HDT9b/ragBaRnOMZPE
   v0Xpq7tuePBuNx17t51yfAr3Ivu2sZyZ5dPVGjo+mbVFGdRVJ/0b/gq8z
   kJEbWZYxXWubplH+1KhdqkWJCoOZbUo9wgVOp/9HwGwOGyO1/+J882chE
   UX95UfxZhUeOO5SIApkk88UrdNnfbUGbH28GDFoDPVyogiyF1ThnRfAI6
   ELEoSswDRLquYW1+SDYhT5yrS+ABmPlLGNzIrG4I7sFW3BZVnZrqFF1rV
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="225813731"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:29:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:29:34 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:29:30 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <varshini.rajendran@microchip.com>,
        <mripard@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 38/50] clk: at91: sam9x7: add support for HW PLL freq dividers
Date:   Fri, 28 Jul 2023 15:59:28 +0530
Message-ID: <20230728102928.267237-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for hardware dividers for PLL IDs in sam9x7 SoC. The system
PLL - PLLA and the system PLL divided by 2 - PLLADIV2 with PLL ID 0 and
4 respectively, both have a hardware divider /2. This has to taken into
account in the software to obtain the right frequencies. Support for the
same is added in the PLL driver.

fcorepllack -----> HW Div = 2 -+--> fpllack
                               |
                               +--> HW Div = 2 ---> fplladiv2ck

In this case the corepll freq is 1600 MHz. So, the plla freq is 800 MHz
after the hardware divider and the plladiv2 freq is 400 MHz after the
hardware divider (Given that the DIVPMC is 0).

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 38 ++++++++++++++++++++++++++----
 drivers/clk/at91/pmc.h             |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index b0314dfd7393..1f80759309c0 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -73,9 +73,15 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	unsigned long freq;
 
-	return parent_rate * (frac->mul + 1) +
+	freq = parent_rate * (frac->mul + 1) +
 		DIV_ROUND_CLOSEST_ULL((u64)parent_rate * frac->frac, (1 << 22));
+
+	if (core->layout->div2)
+		freq >>= 1;
+
+	return freq;
 }
 
 static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
@@ -432,6 +438,12 @@ static unsigned long sam9x60_div_pll_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST_ULL(parent_rate, (div->div + 1));
 }
 
+static unsigned long sam9x60_fixed_div_pll_recalc_rate(struct clk_hw *hw,
+						       unsigned long parent_rate)
+{
+	return parent_rate >> 1;
+}
+
 static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
 					unsigned long *parent_rate,
 					unsigned long rate)
@@ -606,6 +618,16 @@ static const struct clk_ops sam9x60_div_pll_ops_chg = {
 	.restore_context = sam9x60_div_pll_restore_context,
 };
 
+static const struct clk_ops sam9x60_fixed_div_pll_ops = {
+	.prepare = sam9x60_div_pll_prepare,
+	.unprepare = sam9x60_div_pll_unprepare,
+	.is_prepared = sam9x60_div_pll_is_prepared,
+	.recalc_rate = sam9x60_fixed_div_pll_recalc_rate,
+	.round_rate = sam9x60_div_pll_round_rate,
+	.save_context = sam9x60_div_pll_save_context,
+	.restore_context = sam9x60_div_pll_restore_context,
+};
+
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			      const char *name, const char *parent_name,
@@ -725,10 +747,16 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
-	if (flags & CLK_SET_RATE_GATE)
-		init.ops = &sam9x60_div_pll_ops;
-	else
-		init.ops = &sam9x60_div_pll_ops_chg;
+
+	if (layout->div2) {
+		init.ops = &sam9x60_fixed_div_pll_ops;
+	} else {
+		if (flags & CLK_SET_RATE_GATE)
+			init.ops = &sam9x60_div_pll_ops;
+		else
+			init.ops = &sam9x60_div_pll_ops_chg;
+	}
+
 	init.flags = flags;
 
 	div->core.id = id;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index bb9da35198d9..91d1c6305d95 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -64,6 +64,7 @@ struct clk_pll_layout {
 	u8 frac_shift;
 	u8 div_shift;
 	u8 endiv_shift;
+	u8 div2;
 };
 
 extern const struct clk_pll_layout at91rm9200_pll_layout;
-- 
2.25.1

