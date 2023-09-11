Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6009379B58A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359832AbjIKWSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbjIKPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:11:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8573FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:11:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso6052171a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445064; x=1695049864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVLqCA/ecvInY4c6THAO1tIs6dKSTPnQEjLvdL4WYHk=;
        b=pBXgNVDCIDhRiCpll+KwCkJAwuYSnUBAmSmJ2RfBzA0adoxzdEzuS/07u00GO10jmc
         1nprwi6uHOxrzAEg/aZf9oCALcvKChIMjEaHOyKw9NJ3uYCN0/G6RT1Tky2OTPi51IZ0
         5OgtAA3Z+q1MGLr168WDWdR7MMZVeZO8DS/mH5trz/QficRIvIXFBwSNeHF6QST+nwk4
         ScEHvVcNBkihiUg+W2vm2OUIGBVFIS+u1VWwfd+wvHGLxrBMnBaj64aHqMMecxUPwNVE
         +bfCLeZCT3dXUzmuuoZC2H2qiE2UWh74DpC9oAzJCfDYZUFOu6hqGjh26LfS0/em0HQb
         qPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445064; x=1695049864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVLqCA/ecvInY4c6THAO1tIs6dKSTPnQEjLvdL4WYHk=;
        b=fHiGia0yBCkpGn2BLaTpoejFujZVqdP2o0njMcdu7YbMnKdU8bFz4sQ3DxM0r9IwVA
         Bt0cJS5YuMpCCSV98LOWhkXnt81h82f6FO5ixccWptBIyInDDIN4AHW2qAVmeUolG8do
         7BU5+O5hYrQKkd3v39f2S9lK2QiUhH2jYFnhTUGDiKg1NwbLDZIrJlZvz/yVI4D9nah5
         19x0BA8rw/pAtqHtd4pB6S0N637YAmhghoyF9wrnTOXKz5HWNzPt/hLGVYnqdtp+fJ1q
         XPgNQEVed3eJPGISfRRKwx/89jbRCUrA5IxyfFamwSGIv0Gfn6STYDWo5fd6Lxq8Ki3V
         s1Bw==
X-Gm-Message-State: AOJu0YzkcTVH+o4F9qD18KAfBlibfcYZuz5dHg4ZV6hHDCU8UdQuOEOA
        lSL2mzDJ/2jLOc9eCmGom2KvBA==
X-Google-Smtp-Source: AGHT+IHNS4PmdSp7TCHy+BYzxHt4JAK6ZnEugthWVcBVLN+hPi2VGwGiI2QReNZ350wvDNw4TdzY3Q==
X-Received: by 2002:aa7:c904:0:b0:525:70b3:72c2 with SMTP id b4-20020aa7c904000000b0052570b372c2mr8260935edt.14.1694445064234;
        Mon, 11 Sep 2023 08:11:04 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:11:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:34 +0200
Subject: [PATCH RFT 20/20] media: venus: pm_helpers: Commonize venc_get()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-20-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=3254;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vxb2w5wVyktQxR9j1Q6sGaFooRnQRJnrKSI6AeZH57o=;
 b=33oCSwwyUM3j+SIJKcWOvs5hYfI+HUSZ161Pxwvi8UnJdtfQsPyPhxkcIPoZoYyPRQOt5RpZ5
 YIhCik1ceBvCJQ7lLPtb6OObauaxfo62YuhZh+REfQNU9nFAd5JdjmU
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

This function can be very easily commonized between the supported gens.
Do so!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 19 -------------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  1 -
 drivers/media/platform/qcom/venus/venc.c       |  9 +++++++--
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index dfb89d2e7387..9546ad577b5d 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -362,13 +362,6 @@ static int vdec_power_v3(struct device *dev, int on)
 	return ret;
 }
 
-static int venc_get_v3(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	return vcodec_clks_get(core, dev, 1);
-}
-
 static int venc_power_v3(struct device *dev, int on)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -388,7 +381,6 @@ static int venc_power_v3(struct device *dev, int on)
 
 static const struct venus_pm_ops pm_ops_v3 = {
 	.vdec_power = vdec_power_v3,
-	.venc_get = venc_get_v3,
 	.venc_power = venc_power_v3,
 	.load_scale = load_scale_v1,
 };
@@ -784,16 +776,6 @@ static int vdec_power_v4(struct device *dev, int on)
 	return ret;
 }
 
-static int venc_get_v4(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	if (!legacy_binding)
-		return 0;
-
-	return vcodec_clks_get(core, dev, 1);
-}
-
 static void venc_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -1096,7 +1078,6 @@ static int load_scale_v4(struct venus_inst *inst)
 static const struct venus_pm_ops pm_ops_v4 = {
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
-	.venc_get = venc_get_v4,
 	.venc_put = venc_put_v4,
 	.venc_power = venc_power_v4,
 	.coreid_power = coreid_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 4afc57dac865..cbf54e6c6eab 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -13,7 +13,6 @@ struct venus_pm_ops {
 	void (*vdec_put)(struct device *dev);
 	int (*vdec_power)(struct device *dev, int on);
 
-	int (*venc_get)(struct device *dev);
 	void (*venc_put)(struct device *dev);
 	int (*venc_power)(struct device *dev, int on);
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 44b13696cf82..fd3a1dd7f16c 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1557,8 +1557,13 @@ static int venc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, core);
 
-	if (core->pm_ops->venc_get) {
-		ret = core->pm_ops->venc_get(dev);
+	/*
+	 * If the vcodec core clock is missing by now, it either doesn't exist
+	 * (8916) or deprecated bindings with pre-assigned core functions and
+	 * resources under the decoder node are in use.
+	 */
+	if (!core->vcodec_core_clks[1]) {
+		ret = vcodec_clks_get(core, dev, 1);
 		if (ret)
 			return ret;
 	}

-- 
2.42.0

