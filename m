Return-Path: <linux-kernel+bounces-119106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D955C88C44F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0012E1F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EDA7868D;
	Tue, 26 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQagXrOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B374BF7;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461693; cv=none; b=lwbbspPXZ9Y6e491b36Nxx0nGgBSmJdPkOiW4a4siMLJiqTkotSUTxzYl6y9uBABXDx9ICCGjwGOjsi9PU7qRKO2L78ND9QV+f4sKF0k4+IlfP61nVoC3ZIL+gi+SP9n/iYWT/55cRLVzLhfYxlMfTvaIs5rM+AzWi4hjN3L2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461693; c=relaxed/simple;
	bh=YduINrvbMOueuJqN2WQd7cwXtw1eGBZDNUU5mHMNzIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEPxj8XIz4+7lGSXUbs/0jHSVLZ1pQo7qyFNXtSRhkJdYb30owsqy8YJANUJ+lndsBBGyvQ2R3eHAN5O+KrBJvV/zCSUNwnqXJ6M5yhaxZn90DC+wTap1ezIoQbKODZH6OUXUp8wTSImFRu5qeXeGe+YlhYKFYdltNSaBJrjR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQagXrOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11A5C433C7;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461692;
	bh=YduINrvbMOueuJqN2WQd7cwXtw1eGBZDNUU5mHMNzIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQagXrOkDJ2nzKNDuwk6S4AAezeSSR8JOpJLcaLy8rgL47JDF4P8jAZY3nCet63x9
	 zU0jkCBKKXH6jWvEmYpycxC0Z/NVwVADNCoQDQxdjOibYv4Neamv1rwVUfAzoDYzhj
	 fKgr+wqgcE5mbXP4sn4xkdjUZdzioZib1KiASBiVDGHWlAT1Ke41nnSpMHYJfQpCgr
	 W7e3h7Tqsg0LsKGsWrWy4HBmI3JplnsITQm0NK98D5+k2+X2B462hg/IdETJxzRdnK
	 wJthC9ChHQ9v3VwZ7MkbZ0RENxGDW4Aual8D2O0DMLWbTbZ8tdDXucUkHEode64xyM
	 5KTsBeKu1XaWg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rp7Mz-000000005Yv-00Jt;
	Tue, 26 Mar 2024 15:01:41 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/5] clk: qcom: gpucc-sc8280xp: fix GX external supply lookup
Date: Tue, 26 Mar 2024 15:01:07 +0100
Message-ID: <20240326140108.21307-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326140108.21307-1-johan+linaro@kernel.org>
References: <20240326140108.21307-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SA8540P platform is closely related to SC8280XP but differs in that
it uses an external supply for the GX power domain.

Use the new SA8540P compatible to determine whether to look up the
external supply.

This specifically avoids warnings such as:

	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator

on SC8280XP.

Note that this also avoids triggering a potential deadlock on SC8280XP
even if the underlying issue still remains for the derivative platforms
like SA8540P and SA8295P that actually use the supply.

Fixes: deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external supply for GX gdsc")
Link: https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gpucc-sc8280xp.c | 40 +++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index df6b01768767..48a2e8df14f2 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -390,7 +390,7 @@ static struct gdsc cx_gdsc = {
 	.flags = VOTABLE | RETAIN_FF_ENABLE,
 };
 
-static struct gdsc gx_gdsc = {
+static struct gdsc sa8540p_gx_gdsc = {
 	.gdscr = 0x100c,
 	.clamp_io_ctrl = 0x1508,
 	.pd = {
@@ -402,9 +402,25 @@ static struct gdsc gx_gdsc = {
 	.supply = "vdd-gfx",
 };
 
+static struct gdsc sc8280xp_gx_gdsc = {
+	.gdscr = 0x100c,
+	.clamp_io_ctrl = 0x1508,
+	.pd = {
+		.name = "gx_gdsc",
+		.power_on = gdsc_gx_do_nothing_enable,
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = CLAMP_IO | RETAIN_FF_ENABLE,
+};
+
+static struct gdsc *gpu_cc_sa8540p_gdscs[] = {
+	[GPU_CC_CX_GDSC] = &cx_gdsc,
+	[GPU_CC_GX_GDSC] = &sa8540p_gx_gdsc,
+};
+
 static struct gdsc *gpu_cc_sc8280xp_gdscs[] = {
 	[GPU_CC_CX_GDSC] = &cx_gdsc,
-	[GPU_CC_GX_GDSC] = &gx_gdsc,
+	[GPU_CC_GX_GDSC] = &sc8280xp_gx_gdsc,
 };
 
 static const struct regmap_config gpu_cc_sc8280xp_regmap_config = {
@@ -415,6 +431,14 @@ static const struct regmap_config gpu_cc_sc8280xp_regmap_config = {
 	.fast_io = true,
 };
 
+static const struct qcom_cc_desc gpu_cc_sa8540p_desc = {
+	.config = &gpu_cc_sc8280xp_regmap_config,
+	.clks = gpu_cc_sc8280xp_clocks,
+	.num_clks = ARRAY_SIZE(gpu_cc_sc8280xp_clocks),
+	.gdscs = gpu_cc_sa8540p_gdscs,
+	.num_gdscs = ARRAY_SIZE(gpu_cc_sa8540p_gdscs),
+};
+
 static const struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
 	.config = &gpu_cc_sc8280xp_regmap_config,
 	.clks = gpu_cc_sc8280xp_clocks,
@@ -425,9 +449,14 @@ static const struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
 
 static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 {
+	const struct qcom_cc_desc *desc;
 	struct regmap *regmap;
 	int ret;
 
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
 		return ret;
@@ -436,7 +465,7 @@ static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	regmap = qcom_cc_map(pdev, &gpu_cc_sc8280xp_desc);
+	regmap = qcom_cc_map(pdev, desc);
 	if (IS_ERR(regmap)) {
 		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
@@ -449,14 +478,15 @@ static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 	qcom_branch_set_clk_en(regmap, 0x1170); /* GPU_CC_CB_CLK */
 	qcom_branch_set_clk_en(regmap, 0x109c); /* GPU_CC_CXO_CLK */
 
-	ret = qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, desc, regmap);
 	pm_runtime_put(&pdev->dev);
 
 	return ret;
 }
 
 static const struct of_device_id gpu_cc_sc8280xp_match_table[] = {
-	{ .compatible = "qcom,sc8280xp-gpucc" },
+	{ .compatible = "qcom,sa8540p-gpucc", &gpu_cc_sa8540p_desc },
+	{ .compatible = "qcom,sc8280xp-gpucc", &gpu_cc_sc8280xp_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gpu_cc_sc8280xp_match_table);
-- 
2.43.0


