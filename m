Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E05D75F3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjGXKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjGXKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:49:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36C133
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:49:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7589b187so6157143e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690195763; x=1690800563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tspcZNQVAOG/ieMod7hnD09w/Zkh9+fCIQ92xXCkBLc=;
        b=F1y7Jb/sB8vSZVzJSTj5xNrMEMdkG/YTC4HVDQEqpo1Ne3vUZ7qSvO61+XB1TQyfrC
         lvrZtaZlwbldcyOSR3UQVf20I93gzAd+LtHegQ9JHJKJmvrSxrPMbWDeEymj4QY3mWZK
         C2SxG4uS6GtsAe3/CEey0jB0fdnoE1xy8CB1lrq14hiz0ASYmmfIiDWyNV4ppnQNAUau
         x6pu6O1x+cpXqBJiVXMLa7rVGK0CuT0EZ3grM/TxWDPj38wpHA1Jg6ahTq4o27SCrfPx
         KYf4940aedsfbDh6fZ/rhHA/xYQeVz56yLSQl2Cod6O5HQXJOtKDlMWxDCxYOtcKqn38
         TIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690195763; x=1690800563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tspcZNQVAOG/ieMod7hnD09w/Zkh9+fCIQ92xXCkBLc=;
        b=DujTNRoe4woIvFxlFvOo3/BYH11sERdEnfrpHZhO5IZp4l7TrOXeVRwYnZ22Wx4h7b
         U5et3B+sr2IEF1s32NVaXtCFVb3ETmcHZ+O2b/umKqshdGj7wZH+DF0LdFx7zJo+ahHw
         /uYwMW3FKFD64FYGik6UsPsMsXjrYPtEYgm7FWvCt3OSvveEQbpbt8N88oJ+TvBMClz3
         osgmkiEUaHf8V15j69yn0HqM4Ovl51i3zHh03oJ41KOvyK3BVvPwoip4Xu28DEjjD7br
         59VuW9t/JvcLKkWhBB8OiksX4fRf+soDKDxtKIhCvqHrCemFeaIF7WI+RSvTF0bHcxxW
         FhNw==
X-Gm-Message-State: ABy/qLYpGtm8zNSvUU1iQ1Lo6YTzb/Y00QOqmrq4sxRWxwoNToXE0x6X
        jAoXPUR/Uv39q38/G6Z52bLepg==
X-Google-Smtp-Source: APBJJlEwXJB35Nb6TMn2RVO69zWIWFwJqML6uzgXHwanY0fy/RbxMQCdF+D3OH+BIk47fl0wmPoIcQ==
X-Received: by 2002:a19:4307:0:b0:4f8:7513:8cb0 with SMTP id q7-20020a194307000000b004f875138cb0mr4178532lfa.2.1690195763428;
        Mon, 24 Jul 2023 03:49:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl203.neoplus.adsl.tpnet.pl. [83.9.31.203])
        by smtp.gmail.com with ESMTPSA id o14-20020ac2494e000000b004fdc7ec5cbesm2164201lfi.300.2023.07.24.03.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:49:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 12:49:21 +0200
Subject: [PATCH v2 1/2] interconnect: qcom: qcm2290: Enable keep_alive on
 all buses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-topic-qcm2290_icc-v2-1-a2ceb9d3e713@linaro.org>
References: <20230720-topic-qcm2290_icc-v2-0-a2ceb9d3e713@linaro.org>
In-Reply-To: <20230720-topic-qcm2290_icc-v2-0-a2ceb9d3e713@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690195761; l=2327;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=M+tTNuP99ZlFEyDR5+8/cKdgpuX5eZVJzdsdG4DBXsU=;
 b=BDv36n1rFgFABCjKXG+/dWbSU1zxH8X5nMzcYLN1qZxzo7vaiPfbpzIbhUUTLzDs1dZMRnVy8
 2zkEZOS3XpBAI+d9Be+x+iaF42M1AMWCNvoMC3KH/Rq5SAlIMoEYKU6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCM2290 expects all buses to be up at all times when the CPU is
active. Enable keep_alive on all of them to achieve that.

Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 3c3b24264a5b..c22354f3e667 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1196,6 +1196,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.num_nodes = ARRAY_SIZE(qcm2290_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
+	.keep_alive = true,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
 };
@@ -1252,6 +1253,7 @@ static const struct qcom_icc_desc qcm2290_cnoc = {
 	.num_nodes = ARRAY_SIZE(qcm2290_cnoc_nodes),
 	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &qcm2290_cnoc_regmap_config,
+	.keep_alive = true,
 };
 
 static struct qcom_icc_node * const qcm2290_snoc_nodes[] = {
@@ -1294,6 +1296,7 @@ static const struct qcom_icc_desc qcm2290_snoc = {
 	.num_nodes = ARRAY_SIZE(qcm2290_snoc_nodes),
 	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
+	.keep_alive = true,
 	/* Vendor DT node fab-sys_noc property 'qcom,base-offset' */
 	.qos_offset = 0x15000,
 };
@@ -1308,6 +1311,7 @@ static const struct qcom_icc_desc qcm2290_qup_virt = {
 	.nodes = qcm2290_qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_qup_virt_nodes),
 	.bus_clk_desc = &qup_clk,
+	.keep_alive = true,
 };
 
 static struct qcom_icc_node * const qcm2290_mmnrt_virt_nodes[] = {
@@ -1323,6 +1327,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.num_nodes = ARRAY_SIZE(qcm2290_mmnrt_virt_nodes),
 	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
+	.keep_alive = true,
 	.qos_offset = 0x15000,
 };
 
@@ -1338,6 +1343,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.num_nodes = ARRAY_SIZE(qcm2290_mmrt_virt_nodes),
 	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
+	.keep_alive = true,
 	.qos_offset = 0x15000,
 };
 

-- 
2.41.0

