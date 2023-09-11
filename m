Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DD279AFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376883AbjIKWUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241598AbjIKPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F9BE40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso6017730a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445048; x=1695049848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JB7dev33CQqq2PRU515LRyfUHgQkgO8/svwIwjBxrso=;
        b=nXBvtg2cYBFaYKERUnVFQptVoWCmSUKpDt+wIKO1oTai6FfArVnq2T1YLT9ZZpdsdX
         RRWLEZ7II/wav8FWN1yUU9HXh3pa7Vn75G6AM1fFrcEfQWK2zuMnIH3BD78XGdbCdzgw
         MsK4dn9DeGiRETAcSsw+H0hBzW9qLnqa9ggd8o1yGHhyyxM6/BB5k8ljDOaXcSOyhqOJ
         SutHGuhrNQDIVFY6fTgm4nDXw+nAN5eTYru7nSOEwzRcy3eQUOiuMM5OsMInezlxfb7k
         aA31VW3sNiC1BEbiZp2lRDEqVwsHdxtSJHzAqNvIvgBzzci34zNEQ9TKUME+39PRHDiM
         /46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445048; x=1695049848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB7dev33CQqq2PRU515LRyfUHgQkgO8/svwIwjBxrso=;
        b=KnyBRij2l/ZLrkQ8byk0RQragMCkosrckjnomOJRIIkXhnjFlWd0qhym70EerHeIvZ
         7n5ulpBEpzuKwmZaYJ2K2y6OTyu/mYxB7mRJCfMoULlqCT0OcBNJ3A7lEpEhn9oUhSt0
         mM4CYXE2djJSBl2EF8gpcsAgi1eSXKcmYxZdeW+SINLB334yk4uGb88x3nwTL0ceUsqf
         NwWTb4H2QHpX1vvMRK1qr8xyC9D8A9rYgabm8Z02w7mqnVk6y4Y6/LpbbK7GiHCE+iKV
         jxbqWm6ZV05WIWAIX35bXENAS/zL3xzuswkN4J8GUcKL0aBqeJmNlfb2AFO+S2fjvDDv
         cBjA==
X-Gm-Message-State: AOJu0Ywp+Z3DlWR+wEJPD6evYU9hABRItab5YI5Iooc+ng33ZrwFhhOH
        BM8vw5FvVsMLr6gfvg+nUUPfCA==
X-Google-Smtp-Source: AGHT+IHOrUawuw+u7QVtpnfwQLDVGjW95dOdTx3R9QAqJJ8vsJmZNzqMq3h8nCnS59f0knKZHoFyuw==
X-Received: by 2002:a50:fc08:0:b0:522:31d5:ee8e with SMTP id i8-20020a50fc08000000b0052231d5ee8emr7942862edr.8.1694445048504;
        Mon, 11 Sep 2023 08:10:48 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:26 +0200
Subject: [PATCH RFT 12/20] media: venus: core: Use GENMASK for dma_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-12-a7d38bf87bdb@linaro.org>
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2674;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0i/wL/gXye6AMRW7xTiL3gEDEa6DSycySKcFuITtV7c=;
 b=9njRxETBp6BVf2eTPJnydMws8pDjU9hmhMA9EAXKj2fwspYSCUtrrbXXXzUDtbMNERpTc4XGC
 o9auiXwoKyfB6CwEhwV+FjPvOlFqusbM8zqbH2pm+pJ/7Xq5t3xAfWW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raw literals mean very little. Substitute it with more telling
bitops macros.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 5d4d62751357..4dec10d21b05 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -565,7 +565,7 @@ static const struct venus_resources msm8916_res = {
 	.clks_num = 3,
 	.max_load = 352800, /* 720p@30 + 1080p@30 */
 	.hfi_version = HFI_VERSION_1XX,
-	.dma_mask = 0xddc00000 - 1,
+	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
 	.fwname = "qcom/venus-1.8/venus.mdt",
 };
 
@@ -595,7 +595,7 @@ static const struct venus_resources msm8996_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
-	.dma_mask = 0xddc00000 - 1,
+	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
 	.fwname = "qcom/venus-4.2/venus.mdt",
 };
 
@@ -696,7 +696,7 @@ static const struct venus_resources sdm845_res = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.fwname = "qcom/venus-5.2/venus.mdt",
 };
 
@@ -718,7 +718,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
@@ -762,7 +762,7 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = pd_names_cx,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
@@ -817,7 +817,7 @@ static const struct venus_resources sm8250_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
 
@@ -871,7 +871,7 @@ static const struct venus_resources sc7280_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.fwname = "qcom/vpu-2.0/venus.mbn",
 };
 

-- 
2.42.0

