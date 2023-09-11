Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9E79B698
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355898AbjIKWCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbjIKPKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BA5E54
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502a4f33440so4344653e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445047; x=1695049847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoRoq/DrVvkmjCXseaDmK4CEsiQOZW3LoyiqrnjQB9s=;
        b=FL7EHe9/CZuMCn13KeDyBF2tco7gj9DSQ98KZqSXvcHD5jc7RJ3C9nRJubp9FJx9gN
         cjd2DrbiiU2nixHyI/s1/ny/xrha7MsqOeHVNf3srOTKQe6+d8sH45EkSOVcLdTwGRZe
         ncb8rkVgQr1wxxlJX5dWtvKcMC41EVn2vVkrVM/ESmxeBkZtw98+9zVERmTbpFEd52qB
         12SGYPcSQUHoaPi0olbZQwHgazt3I0m6/XGMVfJeiycK6N6ddEcNz/6jjypbnCkxxWLt
         wJ1JmlyjEYyhtJXi5jk/xcMHg4ieMISoaeG6nS42eDcfJrqb1jf57qVLnqvTNPEEibBa
         Bvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445047; x=1695049847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoRoq/DrVvkmjCXseaDmK4CEsiQOZW3LoyiqrnjQB9s=;
        b=wM3n86fNBAFM+Rh8stX7gkhlW17OENUDfUpOom53JDDBAjDv5oZt3776l+8wGTLmQW
         Vi8gEsZY2/1E1H18L98q0lDxJtq4xGk7daRaIKE2oR4g8tdSekKgvz+ETze3bFZp5vVp
         0ITNrF453G2IFDV0wP9+UwbQz+3KvD0KwOfAjj0hzD5hM+lJJ5S2dz2BkG4J/qBA4lV7
         A/evwahA07HfotcfLdnGvH7Tjnw0ejuqHacAV+wwQVGlhcpE0cwO8jEbTrtnrYPA1qnB
         tt0mzeCJ4BCNo+EzyMXONsFwbqi8iZmF9qbctjCOr4fss19J7RaefozMUfXe5Jb1sdEE
         IC9g==
X-Gm-Message-State: AOJu0Yx8L8Z+sNIGdWX/4kMTmAJUFrH6hX4hRz2R1pB4LMWlppi6LzAG
        2N/zyXrHuvcBbsMGHkRcPnc3Qg==
X-Google-Smtp-Source: AGHT+IHoUjK7egly+lD/FRgwIWWwd0EnDIrheAdA1IHTTas5hH3dS+VKbAAlXhaXrbGwZUjKW8W1UA==
X-Received: by 2002:a05:6512:32ce:b0:500:8725:1351 with SMTP id f14-20020a05651232ce00b0050087251351mr9174605lfg.47.1694445047031;
        Mon, 11 Sep 2023 08:10:47 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:25 +0200
Subject: [PATCH RFT 11/20] media: venus: core: Drop cache properties in
 resource struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-11-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=4750;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=57eNoVLc7ASkVVxqDox1DzeFGbIIkYlRHNb+x5nOma8=;
 b=jh0ibHJFu9sbgdYfiEbIJxIc6y4/EIqdz8xPYnEoE30HDEuwsQsATcGFHDvoManghaUvQqknx
 tuH6SMDJpJND4u6j71qqgAPPFNZbaCnLbKuS1YyYgEXNjLUb3PW8hU7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently VMEM/OCMEM/LLCC is disabled on all platforms.

Make it unconditional to save on space.

These caches will not be enabled until the Venus driver can reference
them as chunks of SRAM (they're modelled as separate devices) to avoid
hardcoding magic addresses and rougely accessing the hardware,
bypassing the normal accessors.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c      | 24 ------------------------
 drivers/media/platform/qcom/venus/core.h      |  3 ---
 drivers/media/platform/qcom/venus/hfi_venus.c |  7 ++++---
 3 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index e83c790ccc80..5d4d62751357 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -565,9 +565,6 @@ static const struct venus_resources msm8916_res = {
 	.clks_num = 3,
 	.max_load = 352800, /* 720p@30 + 1080p@30 */
 	.hfi_version = HFI_VERSION_1XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-1.8/venus.mdt",
 };
@@ -598,9 +595,6 @@ static const struct venus_resources msm8996_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-4.2/venus.mdt",
 };
@@ -656,9 +650,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.cp_start = 0,
 	.cp_size = 0x79000000,
 	.cp_nonpixel_start = 0x1000000,
@@ -705,9 +696,6 @@ static const struct venus_resources sdm845_res = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/venus-5.2/venus.mdt",
 };
@@ -730,9 +718,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
@@ -777,9 +762,6 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = pd_names_cx,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
@@ -835,9 +817,6 @@ static const struct venus_resources sm8250_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
@@ -892,9 +871,6 @@ static const struct venus_resources sc7280_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-2.0/venus.mbn",
 };
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index de180f8e7973..fe4cb566d8e9 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -81,9 +81,6 @@ struct venus_resources {
 	const enum vpu_version vpu_version;
 	const u8 num_vpp_pipes;
 	const u32 max_load;
-	const unsigned int vmem_id;
-	const u32 vmem_size;
-	const u32 vmem_addr;
 	const u32 cp_start;
 	const u32 cp_size;
 	const u32 cp_nonpixel_start;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 19fc6575a489..e6db820a1d5e 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1075,9 +1075,10 @@ static irqreturn_t venus_isr_thread(struct venus_core *core)
 			venus_process_msg_sys_error(hdev, pkt);
 			break;
 		case HFI_MSG_SYS_INIT:
-			venus_hfi_core_set_resource(core, res->vmem_id,
-						    res->vmem_size,
-						    res->vmem_addr,
+			/* Disable OCMEM/VMEM unconditionally until support is added */
+			venus_hfi_core_set_resource(core, VIDC_RESOURCE_NONE,
+						    0,
+						    0,
 						    hdev);
 			break;
 		case HFI_MSG_SYS_RELEASE_RESOURCE:

-- 
2.42.0

