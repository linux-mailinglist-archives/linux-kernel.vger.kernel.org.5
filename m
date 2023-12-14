Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D189F8125A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjLNC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443065AbjLNC7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:59:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBECE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:59:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E775AC433C7;
        Thu, 14 Dec 2023 02:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702522754;
        bh=2PDdCkzYRYMbH7gMJ9Uk5YKya+wjQAkRvmkxwtVpVRM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=SPPIe89oP4nZf3Berwbm93xKWj1/0zTybtEEuGWdgXEhFzxoWZs05VICa3zv06zkJ
         2G75HXqFHjuySFSKOU+kd+gC4tee4AXeDFmkKDzWa3QZxmnEtpZUg2W/GhaQ0bvYc7
         qHIffH11sAv/w5T6GwnwHFbiAexl/LssAxeAL2Wq2L0iEJZ921panlUfo9ddTc8MPi
         c4pfnif5/+77HaQMu2FPPMad6zALZMao3yC1Lu14o6yWQtXKy9EmffjBzbvnu4DxDz
         H/GlPlBjhr8WSggRdmPpq/fdZrNqvv6I5LLXLn4kwlRuk5Z9t5PygiFv21EN2wa70Y
         BUJCikL8kIVdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C90B2C4167D;
        Thu, 14 Dec 2023 02:59:13 +0000 (UTC)
From:   Fenglin Wu via B4 Relay 
        <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date:   Thu, 14 Dec 2023 10:59:11 +0800
Subject: [PATCH v2 1/5] regulator: qcom-rpmh: extend to support multiple
 linear voltage ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-pm8010-regulator-v2-1-82131df6b97b@quicinc.com>
References: <20231214-pm8010-regulator-v2-0-82131df6b97b@quicinc.com>
In-Reply-To: <20231214-pm8010-regulator-v2-0-82131df6b97b@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702522752; l=12744;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=rhSNQHhJ4BoR834XJA41hJO4JXmdTXrlGTyQ3g8EEzw=;
 b=df2PpJIz6xDpm2avIqilQ5xWWUM7KsZufqHkdHXIZmfM9C60m5HDAcJagaTwjaZZP1YuCU30v
 1Sdy2Eu9VjRCVU62MeRvjVGNV2mNgqdQiO3fkNVr/Tjx5WnFP0HECIz
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Update rpmh_vreg_hw_data to support multiple linear voltage ranges for
potential regulators which have discrete voltage program ranges.

Suggested-by: David Collins <quic_collinsd@quicinc.com>
Reviewed-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 115 ++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index cf502eec0915..43b45feb02e6 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
+// Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
@@ -68,10 +69,11 @@ enum rpmh_regulator_type {
  * @regulator_type:		RPMh accelerator type used to manage this
  *				regulator
  * @ops:			Pointer to regulator ops callback structure
- * @voltage_range:		The single range of voltages supported by this
- *				PMIC regulator type
+ * @voltage_ranges:		The possible ranges of voltages supported by this
+ * 				PMIC regulator type
+ * @n_linear_ranges:		Number of entries in voltage_ranges
  * @n_voltages:			The number of unique voltage set points defined
- *				by voltage_range
+ *				by voltage_ranges
  * @hpm_min_load_uA:		Minimum load current in microamps that requires
  *				high power mode (HPM) operation.  This is used
  *				for LDO hardware type regulators only.
@@ -85,7 +87,8 @@ enum rpmh_regulator_type {
 struct rpmh_vreg_hw_data {
 	enum rpmh_regulator_type		regulator_type;
 	const struct regulator_ops		*ops;
-	const struct linear_range	voltage_range;
+	const struct linear_range		*voltage_ranges;
+	int					n_linear_ranges;
 	int					n_voltages;
 	int					hpm_min_load_uA;
 	const int				*pmic_mode_map;
@@ -449,8 +452,8 @@ static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
 	vreg->mode = REGULATOR_MODE_INVALID;
 
 	if (rpmh_data->hw_data->n_voltages) {
-		vreg->rdesc.linear_ranges = &rpmh_data->hw_data->voltage_range;
-		vreg->rdesc.n_linear_ranges = 1;
+		vreg->rdesc.linear_ranges = rpmh_data->hw_data->voltage_ranges;
+		vreg->rdesc.n_linear_ranges = rpmh_data->hw_data->n_linear_ranges;
 		vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
 	}
 
@@ -613,7 +616,10 @@ static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int rpmh_mode)
 static const struct rpmh_vreg_hw_data pmic4_pldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 256,
 	.hpm_min_load_uA = 10000,
 	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
@@ -623,7 +629,10 @@ static const struct rpmh_vreg_hw_data pmic4_pldo = {
 static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+	       REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 128,
 	.hpm_min_load_uA = 10000,
 	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
@@ -633,7 +642,10 @@ static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
 static const struct rpmh_vreg_hw_data pmic4_nldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 128,
 	.hpm_min_load_uA = 30000,
 	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
@@ -643,7 +655,10 @@ static const struct rpmh_vreg_hw_data pmic4_nldo = {
 static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 216,
 	.pmic_mode_map = pmic_mode_map_pmic4_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -652,7 +667,10 @@ static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
 static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 259,
 	.pmic_mode_map = pmic_mode_map_pmic4_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -661,7 +679,10 @@ static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
 static const struct rpmh_vreg_hw_data pmic4_bob = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_bypass_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 84,
 	.pmic_mode_map = pmic_mode_map_pmic4_bob,
 	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
@@ -676,7 +697,10 @@ static const struct rpmh_vreg_hw_data pmic4_lvs = {
 static const struct rpmh_vreg_hw_data pmic5_pldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 256,
 	.hpm_min_load_uA = 10000,
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
@@ -686,7 +710,10 @@ static const struct rpmh_vreg_hw_data pmic5_pldo = {
 static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 63,
 	.hpm_min_load_uA = 10000,
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
@@ -696,7 +723,10 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 188,
 	.hpm_min_load_uA = 10000,
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
@@ -706,7 +736,10 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
 static const struct rpmh_vreg_hw_data pmic5_nldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 124,
 	.hpm_min_load_uA = 30000,
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
@@ -716,7 +749,10 @@ static const struct rpmh_vreg_hw_data pmic5_nldo = {
 static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 211,
 	.hpm_min_load_uA = 30000,
 	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
@@ -726,7 +762,10 @@ static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
 static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 216,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -735,7 +774,10 @@ static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
 static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 264,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -744,7 +786,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
 static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 264,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -753,7 +798,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
 static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 268,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -762,7 +810,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
 static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 268,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -771,7 +822,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
 static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 215,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -780,7 +834,10 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
 static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 236,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -789,7 +846,10 @@ static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
 static const struct rpmh_vreg_hw_data pmic5_hfsmps515_1 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(900000, 0, 4, 16000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(900000, 0, 4, 16000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 5,
 	.pmic_mode_map = pmic_mode_map_pmic5_smps,
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
@@ -798,7 +858,10 @@ static const struct rpmh_vreg_hw_data pmic5_hfsmps515_1 = {
 static const struct rpmh_vreg_hw_data pmic5_bob = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_bypass_ops,
-	.voltage_range = REGULATOR_LINEAR_RANGE(3000000, 0, 31, 32000),
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(3000000, 0, 31, 32000),
+	},
+	.n_linear_ranges = 1,
 	.n_voltages = 32,
 	.pmic_mode_map = pmic_mode_map_pmic5_bob,
 	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,

-- 
2.25.1

