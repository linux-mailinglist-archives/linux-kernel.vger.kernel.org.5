Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9699476B205
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjHAKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjHAKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:36:33 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864ADB;
        Tue,  1 Aug 2023 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690886192; x=1722422192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AyHQfuQ25AxPTEIiRutOr2ogGOuarDxm7sZRM0h1amw=;
  b=m9toAB7sFDDXjnctND8mrDeSnmwujAIEamfSFOwXWFt7jsxmLkBZ250Q
   x1sMXdZlYASWCmP2nZTmy8tkAGdmZFRepqemD20Hv1j4MI26dA+TcmS9R
   81fFpgk/BKtPSUncUkyvHMCKp8t3mEPcONiQHvbVraA6rWQpmdZMunTTw
   3ZYcCnEAHXdkHu1hCiEhO/svWh8xmfdxdmQRyfyWRO+r0W00vOfL5lBOB
   9bwLFRyoIizGBl/YGQQjbiDBPqu3EmrSDx0W3unwOJU2AO/fyfR7d0cOi
   jmCW4FwNHjQBQWYN08V7pOQE+ZCOhpeKiH5ZA+dJBxvg8uqHE76Jc8b5M
   g==;
X-IronPort-AV: E=Sophos;i="6.01,246,1684792800"; 
   d="scan'208";a="32226639"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Aug 2023 12:36:25 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D6DFC280084;
        Tue,  1 Aug 2023 12:36:24 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jai Luthra <j-luthra@ti.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/3] clk: keystone: syscon-clk: use struct instead of array for match data
Date:   Tue,  1 Aug 2023 12:36:07 +0200
Message-Id: <e53bcd21e62533930d518903dff52e21c6c1c15a.1690885413.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690885413.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1690885413.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to store information with the match data that is not specific to
the individual clock entries.

Counting the number of elements to a sentinel at runtime is replaced with
the usual ARRAY_SIZE() approach.

No functional change intended.

Fixes: 6acab96ee337 ("clk: keystone: syscon-clk: Add support for audio refclk")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/clk/keystone/syscon-clk.c | 55 +++++++++++++++++++------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index d33f74119488..68ac536f564e 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -18,12 +18,17 @@ struct ti_syscon_gate_clk_priv {
 	u32 idx;
 };
 
-struct ti_syscon_gate_clk_data {
+struct ti_syscon_gate_clk_entry {
 	char *name;
 	u32 offset;
 	u32 bit_idx;
 };
 
+struct ti_syscon_gate_clk_data {
+	const struct ti_syscon_gate_clk_entry *clks;
+	size_t num_clks;
+};
+
 static struct
 ti_syscon_gate_clk_priv *to_ti_syscon_gate_clk_priv(struct clk_hw *hw)
 {
@@ -64,7 +69,7 @@ static const struct clk_ops ti_syscon_gate_clk_ops = {
 static struct clk_hw
 *ti_syscon_gate_clk_register(struct device *dev, struct regmap *regmap,
 			     const char *parent_name,
-			     const struct ti_syscon_gate_clk_data *data)
+			     const struct ti_syscon_gate_clk_entry *data)
 {
 	struct ti_syscon_gate_clk_priv *priv;
 	struct clk_init_data init;
@@ -107,10 +112,10 @@ static struct clk_hw
 
 static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 {
-	const struct ti_syscon_gate_clk_data *data, *p;
+	const struct ti_syscon_gate_clk_data *data;
 	struct clk_hw_onecell_data *hw_data;
 	struct device *dev = &pdev->dev;
-	int num_clks, num_parents, i;
+	int num_parents, i;
 	const char *parent_name;
 	struct regmap *regmap;
 
@@ -123,10 +128,6 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "failed to get regmap\n");
 
-	num_clks = 0;
-	for (p = data; p->name; p++)
-		num_clks++;
-
 	num_parents = of_clk_get_parent_count(dev->of_node);
 	if (of_device_is_compatible(dev->of_node, "ti,am62-audio-refclk") &&
 	    num_parents == 0) {
@@ -134,21 +135,21 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 				     "must specify a parent clock\n");
 	}
 
-	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, num_clks),
+	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, data->num_clks),
 			       GFP_KERNEL);
 	if (!hw_data)
 		return -ENOMEM;
 
-	hw_data->num = num_clks;
+	hw_data->num = data->num_clks;
 
 	parent_name = of_clk_get_parent_name(dev->of_node, 0);
-	for (i = 0; i < num_clks; i++) {
+	for (i = 0; i < data->num_clks; i++) {
 		hw_data->hws[i] = ti_syscon_gate_clk_register(dev, regmap,
 							      parent_name,
-							      &data[i]);
+							      &data->clks[i]);
 		if (IS_ERR(hw_data->hws[i]))
 			dev_warn(dev, "failed to register %s\n",
-				 data[i].name);
+				 data->clks[i].name);
 	}
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
@@ -162,17 +163,20 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 		.bit_idx = (_bit_idx),			\
 	}
 
-static const struct ti_syscon_gate_clk_data am654_clk_data[] = {
+static const struct ti_syscon_gate_clk_entry am654_clks[] = {
 	TI_SYSCON_CLK_GATE("ehrpwm_tbclk0", 0x0, 0),
 	TI_SYSCON_CLK_GATE("ehrpwm_tbclk1", 0x4, 0),
 	TI_SYSCON_CLK_GATE("ehrpwm_tbclk2", 0x8, 0),
 	TI_SYSCON_CLK_GATE("ehrpwm_tbclk3", 0xc, 0),
 	TI_SYSCON_CLK_GATE("ehrpwm_tbclk4", 0x10, 0),
 	TI_SYSCON_CLK_GATE("ehrpwm_tbclk5", 0x14, 0),
-	{ /* Sentinel */ },
+};
+static const struct ti_syscon_gate_clk_data am654_clk_data = {
+	.clks = am654_clks,
+	.num_clks = ARRAY_SIZE(am654_clks),
 };
 
-static const struct ti_syscon_gate_clk_data am64_clk_data[] = {
+static const struct ti_syscon_gate_clk_entry am64_clks[] = {
 	TI_SYSCON_CLK_GATE("epwm_tbclk0", 0x0, 0),
 	TI_SYSCON_CLK_GATE("epwm_tbclk1", 0x0, 1),
 	TI_SYSCON_CLK_GATE("epwm_tbclk2", 0x0, 2),
@@ -182,19 +186,28 @@ static const struct ti_syscon_gate_clk_data am64_clk_data[] = {
 	TI_SYSCON_CLK_GATE("epwm_tbclk6", 0x0, 6),
 	TI_SYSCON_CLK_GATE("epwm_tbclk7", 0x0, 7),
 	TI_SYSCON_CLK_GATE("epwm_tbclk8", 0x0, 8),
-	{ /* Sentinel */ },
+};
+static const struct ti_syscon_gate_clk_data am64_clk_data = {
+	.clks = am64_clks,
+	.num_clks = ARRAY_SIZE(am64_clks),
 };
 
-static const struct ti_syscon_gate_clk_data am62_clk_data[] = {
+static const struct ti_syscon_gate_clk_entry am62_clks[] = {
 	TI_SYSCON_CLK_GATE("epwm_tbclk0", 0x0, 0),
 	TI_SYSCON_CLK_GATE("epwm_tbclk1", 0x0, 1),
 	TI_SYSCON_CLK_GATE("epwm_tbclk2", 0x0, 2),
-	{ /* Sentinel */ },
+};
+static const struct ti_syscon_gate_clk_data am62_clk_data = {
+	.clks = am62_clks,
+	.num_clks = ARRAY_SIZE(am62_clks),
 };
 
-static const struct ti_syscon_gate_clk_data am62_audio_clk_data[] = {
+static const struct ti_syscon_gate_clk_entry am62_audio_clks[] = {
 	TI_SYSCON_CLK_GATE("audio_refclk", 0x0, 15),
-	{ /* Sentinel */ },
+};
+static const struct ti_syscon_gate_clk_data am62_audio_clk_data = {
+	.clks = am62_audio_clks,
+	.num_clks = ARRAY_SIZE(am62_audio_clks),
 };
 
 static const struct of_device_id ti_syscon_gate_clk_ids[] = {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

