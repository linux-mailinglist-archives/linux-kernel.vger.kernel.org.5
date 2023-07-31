Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F77693BA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGaKyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGaKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:54:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43302D52
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so7141886e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800759; x=1691405559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc7oZvOcJDkiBa4MtO2BaU3uRCE2+ug+vLU72IFcWhs=;
        b=bIqvKa9J4ZM/+I3R6xWgQFrmjvvV+uJ/u1tgBCxtFS8pVMHw/b07zhzK8/IOhrWmIQ
         E4mI+yqQcbuETW08+GWh23k0i/rE2qiI62L+oOArgtC9p1Mcx28teRe2DKXTACqfbDD9
         /P5gY7nuGr3e4Xz2BQcpy4b3tnDoOsf5Vs6GxBJ3oDJJRDga3wpiR5lGqxLrtTnoPe6W
         jI6YXQVQqnAnGKU/xISR1UWhl5hjbnfNi1oUI/G5CfMxGCmpi3bnIpIvsCgCoTvgTRHK
         yMuANpwWKmsAVPUwmgG8Z8U5Ey9LTj68G/M5CZX4c75cWnFVvLD+Y1teSdlGQ+eDTmbK
         hXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800759; x=1691405559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc7oZvOcJDkiBa4MtO2BaU3uRCE2+ug+vLU72IFcWhs=;
        b=DQFFgJGxpGB90gy4UJpD1OTUx4cazvl0IUnC5LUJ2Jl4nfZYPkynhi7ZsI1qQ/Rlg7
         mBsLW0w3sWuZNijI33pNi+zhaQV8fgbKKtACsJc6pPwbnBnNGA15X0P340OozM6y2fZg
         xa6F7nr0iOvRNe2DA37rpFOO5hRcOPZM92WIZKeHTssVgolNbV+nlL3fgNdKI+t5A7ur
         MatitTw1ntHYgJzIBOqHj4+FJ7u+7wHlLdIKHrI8Yp/mWLDjI8Rf5BirQQwNhvuUssa8
         U828ww7qQxiFVZY1+LsyGe1xQtSRKezaCKx2BEFDS+Npd3Rar+4pY/uiJA4tW2H5PJW8
         cLow==
X-Gm-Message-State: ABy/qLbRyhNh8gYFMnJfaWyRoCo/zA5Uo7lHT+FpsKM/eA2LuBO4URlq
        KJIGv19L77PqCN/n6JilqIn4SA==
X-Google-Smtp-Source: APBJJlFtP05xjKYxQtPgx4aQW0AWXPSXMdyogsxALLHLhvmfipAVQ/5mIQQjJl25MsYFyYEzQEbVJg==
X-Received: by 2002:ac2:58c9:0:b0:4f8:7513:8cb0 with SMTP id u9-20020ac258c9000000b004f875138cb0mr5392571lfo.2.1690800759450;
        Mon, 31 Jul 2023 03:52:39 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:22 +0200
Subject: [PATCH v2 06/10] interconnect: qcom: qcm2290: Set AB coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-6-8c91c6c76076@linaro.org>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=1336;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gKAcxl1xTWi9i07xf8cB7oRhF8MPHDTJc+D4hon02Tw=;
 b=BBXibxbz5bWOvHTUGXbskyvTu2s2coTcN4lWpRlNt+MQgabHigfgQ5abPKfbysUBzTdLIX56m
 UGV56QaibM1BQepWJ0xXFG5BYjHru3LhVwtGA2ee0Jl3Z+ABcT3AcII
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buses need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 52a6eb32e832..42fa01c66e73 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1201,6 +1201,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const qcm2290_cnoc_nodes[] = {
@@ -1327,6 +1328,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
+	.ab_coeff = 142,
 };
 
 static struct qcom_icc_node * const qcm2290_mmrt_virt_nodes[] = {
@@ -1342,6 +1344,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
+	.ab_coeff = 139,
 };
 
 static const struct of_device_id qcm2290_noc_of_match[] = {

-- 
2.41.0

