Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A224175B6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjGTSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGTSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:24:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55C30C4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:24:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95efb9d89so17495431fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689877446; x=1690482246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tspcZNQVAOG/ieMod7hnD09w/Zkh9+fCIQ92xXCkBLc=;
        b=vg8+1CRHxoL5vxPCuBwVapRXpUEpKouHaWSXqSYFr1/UTLahqqiduUJRN0PlZLXR2p
         Xi/MadEmVMIb6OftU03VnQYYbj6Iy1LEFWQ8ub5fG4P6vN8ZQ91zGt5bryw13HixFkzO
         FX8qdF/Ld4WFCrBha152saeZ4QghGZflEG3fBBGSVpHh+7utFbCYb8qvFT/9Tgj7zfxq
         TCISjA1kC7ytMv8uEd0gKzP/MZsQ4B6WVJDqZ/aQlaWUhj6AYjxvckvDKd91NO4x8nMY
         UCg+F90Mhz/QDubqGOzm016kgkvb4fY2zhOeIZrfVIn1vVVJeQqKWQQln8J+Tnu5UbU3
         vdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877446; x=1690482246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tspcZNQVAOG/ieMod7hnD09w/Zkh9+fCIQ92xXCkBLc=;
        b=k//7MVI+CUZciMnuk63w6uouHZ0MUHQnVzD2hFzWxBlIcKyJdnux5dnIceYutL4ZEz
         rdKwO8L0CQ+Djz4XC4dn7h82lJ1yMVlSlc55zwyyUfUdA8/pHV3Ttsj2+PfOlFpmiANz
         CBQEJERBDKIIc/KIUOtp8qs2pulxz5ED6Ps1pXbHF5SXulyPC+wBK5fbCAYjmjMMYZmx
         TDIO+85ploTuYRlWcZCVqr4wJk5Pd0BMTwJB1DB0/oyh/dKuBUEPE3os4h8VKDoP72F0
         Je/inGKNkxGdLH5PIdsMWsQrCpKoPXzrLRyQSQOXKAwe5V33ZQXrlVPGRG+hBHm4e9jj
         7K6w==
X-Gm-Message-State: ABy/qLaJX7qgE+NXfnDC8DsGiztW0yOaxjvQ5f6qTzOihc94GJKx1xhW
        A9YOJkMOHi7hkARVvtoNE3Cgd9FkuNJ9MdHmPhX8JA==
X-Google-Smtp-Source: APBJJlFuZ8olSZ9+XRNTbPJbaoFcV1p1XdMpYAD4No0WSu6ZS1Hi1oYCBrdnRPtJjKzmYYKDd96wgA==
X-Received: by 2002:a2e:9989:0:b0:2b1:c1ae:73e3 with SMTP id w9-20020a2e9989000000b002b1c1ae73e3mr2947830lji.15.1689877446252;
        Thu, 20 Jul 2023 11:24:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id g23-20020a2e9397000000b002b31ec01c97sm428304ljh.15.2023.07.20.11.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 11:24:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 20 Jul 2023 20:24:00 +0200
Subject: [PATCH 1/2] interconnect: qcom: qcm2290: Enable keep_alive on all
 buses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-topic-qcm2290_icc-v1-1-7f67f2e259c1@linaro.org>
References: <20230720-topic-qcm2290_icc-v1-0-7f67f2e259c1@linaro.org>
In-Reply-To: <20230720-topic-qcm2290_icc-v1-0-7f67f2e259c1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689877443; l=2327;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=M+tTNuP99ZlFEyDR5+8/cKdgpuX5eZVJzdsdG4DBXsU=;
 b=+hkuq62A1BXLSpnGgub7KQFGH1nrKkS85Db+gSeHpEYzRKijuNd8LBM/pqroBcGtZE52dwU0E
 NYdDt8T8LO0Bs4PDPwMhfPDs5dNPCfeG/Kgp1MyMx1eoGViYIV/4sz1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

