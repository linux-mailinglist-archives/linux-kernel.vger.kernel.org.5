Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B379B1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbjIKVI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241619AbjIKPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:11:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453FCE50
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500cfb168c6so7427493e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445054; x=1695049854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvaPKLQHScYQL75NptLuZiJ3oU9JIQjkuER4G14i9nw=;
        b=QX3bWFBY/D9qPrzP8I/jl0O0jOHrSGNCbAQe+YUrEnHM0XWx9uw3VnFkVhBGkE1hAC
         wtLNSCKIHh1EnvWAlYi+HvoFHIcxKKbQnp3N2/f6GckazCRD5tPZ8rwUgBMTDVAomI1V
         xUehEVhKGnLqAxo7zDCeunK4a+PYrbZh23QoqZi0I331ttC9sgaMv0yPZTESWtVPbz/C
         l5B9Ap07iV/QrctrBSqz62bPnRWalW9a5J0hTdWv9XaNUvhdASsND0yMc3yZCTv6H9JH
         1PSQOvOf8ghmzOAyB0MhRdG3oh8BDGHGu1nzTAr5TlaiITnmExqCpIa/8wO9yn5ubqhY
         00/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445054; x=1695049854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvaPKLQHScYQL75NptLuZiJ3oU9JIQjkuER4G14i9nw=;
        b=vjw6y5Lr/Hyeg0TfSnH8Bzw8Fco9Ihi+X2wctpaugpoylgXKzDnbqj3H1uR1eb0FNQ
         zSXBNBdAM7G2wO7C0AhlyTlQ/nqcKTg2wkm4r6syyj07oNKz4/vxagZPodQJ1LiHc9rQ
         6jXX3h0Na0J3WJe6fyo4XlXh1TaCtpF2aCaBLfFaIUMciwYM07UpRfZUT5YUFcKG/ZVY
         eYdNVCc/OZMLVMRAmzGgOSn61JpvymqNu7O53XBgkG1frzmw00T6dhkoXe7JSJJRr8KU
         MOg5PypiSE3c4xk4Iny2yuSX0vkZ4nuaDqJk13ufvLP8vH8qOKn4owU7JTvUnrjw+EHH
         2gig==
X-Gm-Message-State: AOJu0YxaBO1D7lFEwDRCfaPaBD2+8fdIz7f5B7R+SVXm3i91VMgc9TDg
        7nRsXgWwn/4L6MjaRf+M5xxrJQ==
X-Google-Smtp-Source: AGHT+IFRjHjMg9FMe97CBZIsu6FfosSdU73i223AsKTo+cLsnJy2LpkS9EDuYbzgskvudOnK3RPUrg==
X-Received: by 2002:a05:6512:33cf:b0:502:a942:d7a8 with SMTP id d15-20020a05651233cf00b00502a942d7a8mr6878275lfg.69.1694445054562;
        Mon, 11 Sep 2023 08:10:54 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:29 +0200
Subject: [PATCH RFT 15/20] media: venus: pm_helpers: Remove
 pm_ops->core_put
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-15-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=3955;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VFHAXP0bCqoE65EEy0HuBDwB4xJnqOaz01+cugNoC1s=;
 b=qbXg229K/TQjVjjbaca1jaxrvPPICpMOZ4V4ZMrNygnlbBOWJzI3VWWWe5SuTxoa4tyjwpJUu
 XqtCLLeSD8oC7PoC59MdQWmft1EKPBCfADaFVTRKfm+nHV0K2oL+zvH
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

Without and OPP table and with vcodec_pmdomains_num (so, v1, v3 and
sdm845_legacy targets), core_put_v4 is a NOP, jut like core_put_v1.
Unify them!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  8 +++-----
 drivers/media/platform/qcom/venus/pm_helpers.c | 17 +----------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 0ae118257296..9a1b0be5d067 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -429,15 +429,14 @@ static int venus_probe(struct platform_device *pdev)
 err_core_deinit:
 	hfi_core_deinit(core, false);
 err_core_put:
-	if (core->pm_ops->core_put)
-		core->pm_ops->core_put(core);
+	vcodec_domains_put(core);
+
 	return ret;
 }
 
 static void venus_remove(struct platform_device *pdev)
 {
 	struct venus_core *core = platform_get_drvdata(pdev);
-	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	struct device *dev = core->dev;
 	int ret;
 
@@ -455,8 +454,7 @@ static void venus_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-	if (pm_ops->core_put)
-		pm_ops->core_put(core);
+	vcodec_domains_put(core);
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index ddaa9944fa44..9a0e2a00f383 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -318,13 +318,8 @@ static int load_scale_v1(struct venus_inst *inst)
 	return ret;
 }
 
-static void core_put_v1(struct venus_core *core)
-{
-}
-
 static const struct venus_pm_ops pm_ops_v1 = {
 	.core_get = venus_clks_get,
-	.core_put = core_put_v1,
 	.load_scale = load_scale_v1,
 };
 
@@ -396,7 +391,6 @@ static int venc_power_v3(struct device *dev, int on)
 
 static const struct venus_pm_ops pm_ops_v3 = {
 	.core_get = venus_clks_get,
-	.core_put = core_put_v1,
 	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
@@ -899,7 +893,7 @@ static int vcodec_domains_get(struct venus_core *core)
 	return ret;
 }
 
-static void vcodec_domains_put(struct venus_core *core)
+void vcodec_domains_put(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;
 	unsigned int i;
@@ -974,14 +968,6 @@ static int core_get_v4(struct venus_core *core)
 	return 0;
 }
 
-static void core_put_v4(struct venus_core *core)
-{
-	if (legacy_binding)
-		return;
-
-	vcodec_domains_put(core);
-}
-
 int venus_core_power(struct venus_core *core, int on)
 {
 	struct device *dev = core->dev;
@@ -1128,7 +1114,6 @@ static int load_scale_v4(struct venus_inst *inst)
 
 static const struct venus_pm_ops pm_ops_v4 = {
 	.core_get = core_get_v4,
-	.core_put = core_put_v4,
 	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 77db940a265c..3014b39aa6e3 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -11,7 +11,6 @@ struct venus_core;
 
 struct venus_pm_ops {
 	int (*core_get)(struct venus_core *core);
-	void (*core_put)(struct venus_core *core);
 
 	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
@@ -28,6 +27,7 @@ struct venus_pm_ops {
 
 const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
 int venus_core_power(struct venus_core *core, int on);
+void vcodec_domains_put(struct venus_core *core);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {

-- 
2.42.0

