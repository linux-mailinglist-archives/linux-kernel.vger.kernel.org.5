Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047AD7D8641
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbjJZPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbjJZPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:50:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D18196
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso15057261fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698335449; x=1698940249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tg3pNzu9GGZkIp555oWCbdMkPug26qMvCCiasLz7nk=;
        b=D6b+9IQxumT7r94I2f1HW5dCZkH43MY/cTB9kQva4NbfQbvlgvu3hyTr1Na7VZBgZn
         mkfO3St7oI0x3XD0f88uwpndcMNGtaKWc0qEz3ivutdTchBn9ldMiCBrmfe5hhgxHea/
         tFdlvkcBHMpEA63fZ9Ou/Ff/xaPspvB86KPF24fal5NYZK0MHvnAwfoqGyjkRLfDp7hT
         icOqNdMOkT0EgTGabuZPIk07DaULr0uqRjkjl9O1E4FZpipMhjN+YOQL7eiL04N6j3oG
         aLZ12WscNJWji8anKj2brpOssojjMvdOsmYqgdoMBtPRCXzLBdcrQW8/OKZrVCvhdktC
         zLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335449; x=1698940249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tg3pNzu9GGZkIp555oWCbdMkPug26qMvCCiasLz7nk=;
        b=UG7pBh8YiNNWr4CUTG4TNQqtzQz6CQjfuog9+WmqlSdiEQwN80fjxfoFnpJCyXpDYv
         6zoY+xHObjs8AqQKFzbvLt8OFYxK76/mjLL+7st5mLFx5g/xQscJ/pDVYctvuE+GANHk
         5pPQzXnNL55BobSkncMKBteeikiuPAlggeGAmJ6p1O8YTqDtiY5qM6cPPgSFy6v6iTrr
         AVENzUVikaIFnTjUcvRqPFETDsH81DE9+j7YwF487tCedm3fLpsty+9VGhypz4D9GHSH
         Nne2D69UHcVKJl1DQv8v/VTErsQE2B1kWbJy/e/vZ19JaEQr/FoKRMjHlVac8t9o40e9
         caOg==
X-Gm-Message-State: AOJu0YyAK/fMTMwoTfHDTIrc8lpGBbz1+xHYqx1xdJ86MyL7cgvKGapq
        Ka5QaSSIbgoMEnReZBICYM2BoA==
X-Google-Smtp-Source: AGHT+IGUEMQHj2jGMdrAh3lUTJKvsP83xJieqaDFmO4EpT8bEXe1kv3HD/g0CaDzYI7cSQgk/7aBXQ==
X-Received: by 2002:a05:651c:1038:b0:2c5:1bd9:f95c with SMTP id w24-20020a05651c103800b002c51bd9f95cmr12484896ljm.53.1698335448987;
        Thu, 26 Oct 2023 08:50:48 -0700 (PDT)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003feae747ff2sm2938289wms.35.2023.10.26.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:50:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 3/5] media: qcom: camss: Use common VFE pm_domain_on/pm_domain_off where applicable
Date:   Thu, 26 Oct 2023 16:50:40 +0100
Message-ID: <20231026155042.551731-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the various versions of VFE we have a boiler-plate
pm_domain_on/pm_domain_off callback pair of the general form.

- Error check.
  Not always done but applicable to all.

- device_link_add (DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
                   DL_FLAG_RPM_ACTIVE);

- Error check returning -EINVAL on error.

- Return 0

Reduce the pattern down to a common callback. VFE 4.1 is a special case
which to me also indicates that it is worthwhile maintaining an indirection
for the vfe_pm_domain_{on|off} for now.

Otherwise lets chuck out a bunch of needlessly replicated code.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-vfe-170.c | 35 -------------------
 .../media/platform/qcom/camss/camss-vfe-4-1.c |  8 ++---
 .../media/platform/qcom/camss/camss-vfe-4-7.c | 31 ----------------
 .../media/platform/qcom/camss/camss-vfe-4-8.c | 28 ---------------
 .../media/platform/qcom/camss/camss-vfe-480.c | 35 -------------------
 drivers/media/platform/qcom/camss/camss-vfe.c | 33 +++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h | 12 +++++++
 7 files changed, 49 insertions(+), 133 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 7451484317cc3..795ac3815339a 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -627,41 +627,6 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 }
 
-/*
- * vfe_pm_domain_off - Disable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static void vfe_pm_domain_off(struct vfe_device *vfe)
-{
-	struct camss *camss = vfe->camss;
-
-	if (vfe->id >= camss->res->vfe_num)
-		return;
-
-	device_link_del(vfe->genpd_link);
-}
-
-/*
- * vfe_pm_domain_on - Enable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static int vfe_pm_domain_on(struct vfe_device *vfe)
-{
-	struct camss *camss = vfe->camss;
-
-	if (vfe->id >= camss->res->vfe_num)
-		return 0;
-
-	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd,
-					  DL_FLAG_STATELESS |
-					  DL_FLAG_PM_RUNTIME |
-					  DL_FLAG_RPM_ACTIVE);
-	if (!vfe->genpd_link)
-		return -EINVAL;
-
-	return 0;
-}
-
 /*
  * vfe_queue_buffer - Add empty buffer
  * @vid: Video device structure
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index 2911e4126e7ad..ef6b34c915df1 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -936,7 +936,7 @@ static irqreturn_t vfe_isr(int irq, void *dev)
  * vfe_pm_domain_off - Disable power domains specific to this VFE.
  * @vfe: VFE Device
  */
-static void vfe_pm_domain_off(struct vfe_device *vfe)
+static void vfe_4_1_pm_domain_off(struct vfe_device *vfe)
 {
 	/* nop */
 }
@@ -945,7 +945,7 @@ static void vfe_pm_domain_off(struct vfe_device *vfe)
  * vfe_pm_domain_on - Enable power domains specific to this VFE.
  * @vfe: VFE Device
  */
-static int vfe_pm_domain_on(struct vfe_device *vfe)
+static int vfe_4_1_pm_domain_on(struct vfe_device *vfe)
 {
 	return 0;
 }
@@ -999,8 +999,8 @@ const struct vfe_hw_ops vfe_ops_4_1 = {
 	.hw_version = vfe_hw_version,
 	.isr_read = vfe_isr_read,
 	.isr = vfe_isr,
-	.pm_domain_off = vfe_pm_domain_off,
-	.pm_domain_on = vfe_pm_domain_on,
+	.pm_domain_off = vfe_4_1_pm_domain_off,
+	.pm_domain_on = vfe_4_1_pm_domain_on,
 	.reg_update_clear = vfe_reg_update_clear,
 	.reg_update = vfe_reg_update,
 	.subdev_init = vfe_subdev_init,
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 2b4e7e039407b..7655d22a9fda2 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1103,37 +1103,6 @@ static void vfe_isr_read(struct vfe_device *vfe, u32 *value0, u32 *value1)
 	writel_relaxed(VFE_0_IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_0_IRQ_CMD);
 }
 
-/*
- * vfe_pm_domain_off - Disable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static void vfe_pm_domain_off(struct vfe_device *vfe)
-{
-	if (!vfe)
-		return;
-
-	device_link_del(vfe->genpd_link);
-}
-
-/*
- * vfe_pm_domain_on - Enable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static int vfe_pm_domain_on(struct vfe_device *vfe)
-{
-	struct camss *camss = vfe->camss;
-
-	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
-					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
-
-	if (!vfe->genpd_link) {
-		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", vfe->id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void vfe_violation_read(struct vfe_device *vfe)
 {
 	u32 violation = readl_relaxed(vfe->base + VFE_0_VIOLATION_STATUS);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index 5e95343241304..f52fa30f3853e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -1093,34 +1093,6 @@ static void vfe_isr_read(struct vfe_device *vfe, u32 *value0, u32 *value1)
 	writel_relaxed(VFE_0_IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_0_IRQ_CMD);
 }
 
-/*
- * vfe_pm_domain_off - Disable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static void vfe_pm_domain_off(struct vfe_device *vfe)
-{
-	device_link_del(vfe->genpd_link);
-}
-
-/*
- * vfe_pm_domain_on - Enable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static int vfe_pm_domain_on(struct vfe_device *vfe)
-{
-	struct camss *camss = vfe->camss;
-
-	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
-					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
-
-	if (!vfe->genpd_link) {
-		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", vfe->id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void vfe_violation_read(struct vfe_device *vfe)
 {
 	u32 violation = readl_relaxed(vfe->base + VFE_0_VIOLATION_STATUS);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index a70b8633bb3eb..4652e8b4cff58 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -452,41 +452,6 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 }
 
-/*
- * vfe_pm_domain_off - Disable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static void vfe_pm_domain_off(struct vfe_device *vfe)
-{
-	struct camss *camss = vfe->camss;
-
-	if (vfe->id >= camss->res->vfe_num)
-		return;
-
-	device_link_del(vfe->genpd_link);
-}
-
-/*
- * vfe_pm_domain_on - Enable power domains specific to this VFE.
- * @vfe: VFE Device
- */
-static int vfe_pm_domain_on(struct vfe_device *vfe)
-{
-	struct camss *camss = vfe->camss;
-
-	if (vfe->id >= camss->res->vfe_num)
-		return 0;
-
-	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd,
-					  DL_FLAG_STATELESS |
-					  DL_FLAG_PM_RUNTIME |
-					  DL_FLAG_RPM_ACTIVE);
-	if (!vfe->genpd_link)
-		return -EINVAL;
-
-	return 0;
-}
-
 /*
  * vfe_queue_buffer - Add empty buffer
  * @vid: Video device structure
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 94267b9974554..d6799408a8c78 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -474,6 +474,39 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
 	complete(&vfe->reset_complete);
 }
 
+/*
+ * vfe_pm_domain_off - Disable power domains specific to this VFE.
+ * @vfe: VFE Device
+ */
+void vfe_pm_domain_off(struct vfe_device *vfe)
+{
+	if (!vfe->genpd)
+		return;
+
+	device_link_del(vfe->genpd_link);
+}
+
+/*
+ * vfe_pm_domain_on - Enable power domains specific to this VFE.
+ * @vfe: VFE Device
+ */
+int vfe_pm_domain_on(struct vfe_device *vfe)
+{
+	struct camss *camss = vfe->camss;
+
+	if (!vfe->genpd)
+		return 0;
+
+	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd,
+					  DL_FLAG_STATELESS |
+					  DL_FLAG_PM_RUNTIME |
+					  DL_FLAG_RPM_ACTIVE);
+	if (!vfe->genpd_link)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int vfe_match_clock_names(struct vfe_device *vfe,
 				 struct camss_clock *clock)
 {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index c1c50023d4876..992a2103ec44c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -203,6 +203,18 @@ int vfe_reset(struct vfe_device *vfe);
  */
 int vfe_disable(struct vfe_line *line);
 
+/*
+ * vfe_pm_domain_off - Disable power domains specific to this VFE.
+ * @vfe: VFE Device
+ */
+void vfe_pm_domain_off(struct vfe_device *vfe);
+
+/*
+ * vfe_pm_domain_on - Enable power domains specific to this VFE.
+ * @vfe: VFE Device
+ */
+int vfe_pm_domain_on(struct vfe_device *vfe);
+
 extern const struct vfe_hw_ops vfe_ops_4_1;
 extern const struct vfe_hw_ops vfe_ops_4_7;
 extern const struct vfe_hw_ops vfe_ops_4_8;
-- 
2.42.0

