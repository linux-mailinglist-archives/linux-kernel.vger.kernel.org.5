Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078FB763C63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGZQ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjGZQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:25:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237CB2698
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso10915812e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690388753; x=1690993553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGPPZn4sgCGUmcJX5BOGkg/nNi/FbYofOgGSdq2+5ZA=;
        b=Z7JdDrDpDcynE/cL3sUx8QxPcA6i4sdt8bCmLmHRO65ZxtoA1fLoGTjj1rWbhfnC3C
         160N1/EHVbvGOr/qMSG4zocFDkzMVeqQTfQ+vil2G86FxzFW0tG+nS3lCcmdEH3zioQb
         VE1ohMBThkm7krh70G48UxJ/gVrX+qACKi7o+AZHn0RKUwoNK+Lo7ow6c1VnQFy2YZbs
         PUk+/sU7ByqZTIwRiSZ1BZfe0HKTvfmOAhP9J+4kLagQbDgtc1kWwCgwxjNeSg2/wWTa
         3BiF7lAsU92xwsJaVo9bbtsquH6n2eKg+b1d4Aw69NDmb99huwLtXo7H/sk4YyJbPfX4
         nMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388753; x=1690993553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGPPZn4sgCGUmcJX5BOGkg/nNi/FbYofOgGSdq2+5ZA=;
        b=gCJ9LAVyqFRwHiBxsrJawK8+VehsbFrwFvXeqhESiCiweTKoFx3BlKdLQslGsP1tUj
         mtmrCfDsqR+2kaYf4Zj40gcwH92UVBRDRBldy7JMk1Gisoq4rJTrFjCNHpKmFYHu8EAJ
         t794u/a22CcS4uMsLoWnfUa7/T2cZ8DrCRhKGrS7hXPImi2y1lar9b5eJ9ISw8yxkx3x
         kCZSzNpXCsQiH3Z2Dz9o6dqyfyadImhznJZ0dAi33qBsP+jNqrK43d4SPdqsXI3fYtiL
         cTfw55w6wiv8L4u76pvYrmwVaUB0hYNGLxUdQx3ZD+L5empedZXDvvw6m9ebBdLsMjqY
         Ni6g==
X-Gm-Message-State: ABy/qLbpBwsP3zdIgYRyPcvRgHBjpXTjE1vgSaevqiRP7sPOQdJG73JI
        HuS7Z1/rCDg4lhwURKQNz/swIQ==
X-Google-Smtp-Source: APBJJlHrBIpEiLV7UKJUG2SgVZt/Wtf+FSvMB+UvdyahNOit7eWZ9Qf0c1x8b9rFBNEGa9vcqhGnrg==
X-Received: by 2002:a19:4f5e:0:b0:4fd:fef7:95ae with SMTP id a30-20020a194f5e000000b004fdfef795aemr1816753lfk.9.1690388753510;
        Wed, 26 Jul 2023 09:25:53 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b004fba5c20ab1sm3336299lfs.167.2023.07.26.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:25:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 26 Jul 2023 18:25:45 +0200
Subject: [PATCH 3/4] interconnect: qcom: sdm660: Set AB/IB coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v1-3-31616960818c@linaro.org>
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690388749; l=1529;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1GzH+Tims+63zaTkCSn7UYBh9oQwB5PWYLl4YDuX6gw=;
 b=m+5HpYLUmYNcucjW7LR19Qvv3UrwPKwD8DfdpA41cB+UyCgC62DtO4QDo+oCWJCtD+VR/dz5d
 d5tPAgapkXPB6FEyItGULvgKFj+I5cspYL3Qo1qIPo6szk5/ckNGP0M
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buses and nodes need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 36962f7bd7bb..cb93e2f2c2f4 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -602,6 +602,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.name = "mas_mdp_p0",
 	.id = SDM660_MASTER_MDP_P0,
 	.buswidth = 16,
+	.ib_percent = 200,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -621,6 +622,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.name = "mas_mdp_p1",
 	.id = SDM660_MASTER_MDP_P1,
 	.buswidth = 16,
+	.ib_percent = 200,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -1540,6 +1542,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
+	.ab_percent = 153,
 };
 
 static struct qcom_icc_node * const sdm660_cnoc_nodes[] = {
@@ -1659,6 +1662,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
+	.ab_percent = 153,
 };
 
 static struct qcom_icc_node * const sdm660_snoc_nodes[] = {

-- 
2.41.0

