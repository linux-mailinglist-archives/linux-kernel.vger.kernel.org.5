Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FBB812598
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443075AbjLNC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443062AbjLNC7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:59:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597EF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:59:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01E1CC433C9;
        Thu, 14 Dec 2023 02:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702522754;
        bh=2dt1n4XraV4qw7ENdAg+lG7vXsiwEsdYO3JNzc/c6y0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Zfo8aySrTkR2SRlA7GznxQfDkFSTVpcKNTv+XFmnhPkK78ddi4DZC0nqWJfZoaWv8
         8qLmP5HXMxWf8fJvSQVAD2arsn2AkZ06B99+VPZ1edvQDAB4zXvMTPx+jNcmui/c2j
         GWSngnExQ+m/w7546X6E6ktqdjji22Ucjvy0ZvKJaUAT+MUaJNcpbwEmg3FsK6ATGA
         L5utcvkpp/pp7c/5kLNFWXonspohlTuMvBz7f5PTGIhrcn6DN1Cbh8ByjyF7WBDozH
         ZsHk+YWPg4LL7wlZ6I7ejpKCFzmDpY7LtEaFMmU3uw0sB1Kp7RSQEH3nn174pC2tMM
         /5juE6SxfhGIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DB3FEC38147;
        Thu, 14 Dec 2023 02:59:13 +0000 (UTC)
From:   Fenglin Wu via B4 Relay 
        <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date:   Thu, 14 Dec 2023 10:59:13 +0800
Subject: [PATCH v2 3/5] regulator: qcom-rpmh: add support for pm8010
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-pm8010-regulator-v2-3-82131df6b97b@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702522752; l=4412;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=vd754S3f7iq11y03Lq7bRtGpZERa2WUH879dDd2vxGQ=;
 b=c6AtN57+S2RfrI9K722KUnjsh+PHY4nrO9AobgEFEgyIWFRP5c85Nl4gl/rK6UnLO0f12GPls
 d57TzGsDMdQCBBYNUqzB1qXfnATuqOm8biU0I2OwzzF//RBR8xXFA2G
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

Add RPMH regulators exposed by Qualcomm Technologies, Inc. PM8010
PMIC. It has 7 LDOs with 3 different types, LDO1 - LDO2 are L502
NMOS LDOs, LDO5 and LDO7 are L502 PMOS LDOs, LDO3/LDO4/LDO6 are
L502 PMOS LDO for low noise applications. Also, LDO3 - LDO7 don't
support LPM.

Suggested-by: David Collins <quic_collinsd@quicinc.com>
Reviewed-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 62 +++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 43b45feb02e6..80e304711345 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -511,6 +511,14 @@ static const int pmic_mode_map_pmic5_ldo[REGULATOR_MODE_STANDBY + 1] = {
 	[REGULATOR_MODE_FAST]    = -EINVAL,
 };
 
+static const int pmic_mode_map_pmic5_ldo_hpm[REGULATOR_MODE_STANDBY + 1] = {
+	[REGULATOR_MODE_INVALID] = -EINVAL,
+	[REGULATOR_MODE_STANDBY] = -EINVAL,
+	[REGULATOR_MODE_IDLE]    = -EINVAL,
+	[REGULATOR_MODE_NORMAL]  = PMIC5_LDO_MODE_HPM,
+	[REGULATOR_MODE_FAST]    = -EINVAL,
+};
+
 static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
 {
 	unsigned int mode;
@@ -733,6 +741,33 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
 	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_pldo502 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 256,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo_hpm,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_pldo502ln = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1800000, 0,  2,  200000),
+		REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),
+		REGULATOR_LINEAR_RANGE(3104000, 29, 30, 96000),
+		REGULATOR_LINEAR_RANGE(3312000, 31, 31, 0),
+	},
+	.n_linear_ranges = 4,
+	.n_voltages = 32,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo_hpm,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_nldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -759,6 +794,19 @@ static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
 	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_nldo502 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_ranges = (struct linear_range[]) {
+		REGULATOR_LINEAR_RANGE(528000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
@@ -1210,6 +1258,16 @@ static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8010_vreg_data[] = {
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo502,   "vdd-l1-l2"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo502,   "vdd-l1-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_pldo502ln, "vdd-l3-l4"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo502ln, "vdd-l3-l4"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo502,   "vdd-l5"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo502ln, "vdd-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo502,   "vdd-l7"),
+};
+
 static const struct rpmh_vreg_init_data pm6150_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
@@ -1525,6 +1583,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pm8009-1-rpmh-regulators",
 		.data = pm8009_1_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8010-rpmh-regulators",
+		.data = pm8010_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
 		.data = pm8150_vreg_data,

-- 
2.25.1

