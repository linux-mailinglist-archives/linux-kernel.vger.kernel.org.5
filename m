Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FB7D5E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbjJXWnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbjJXWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:43:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0421FB0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:43:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so75020301fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698187392; x=1698792192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkACzb7psfwrF2ylOIwNjRys80z1c/kWNppo4uFItzk=;
        b=jJixoakFDtnSRnmPrPFXzw0/vsJI/hiA6KXHtxNlg5zUjttyqXOIlmvzgOwCOA+gCZ
         /bjfgdfu1TAp36/VHs16SdoVG2OvdJS1bzVDDpD5Ud/0tqTb9M0LTEnV2S4NcMOKOhRy
         XMT/BOnaJV2TlqxY671Cg1xqxNo6aXW0++wudyQCfrVSE6Y0SdnZffFh6FjWkqFbgANx
         jEeh2CsFtVC+p0s6VUJL8ii6cL1SOnbM8H/Bd2CAbs+Tn7SpMKlYD8Nm5csp43lVMNjO
         VcFxtxOavnj3+HL1pl3i5hvEezm1zzLq321nhENIqXn8HRBhQ00UNNqFL70sxQYqMSzM
         5YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698187392; x=1698792192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkACzb7psfwrF2ylOIwNjRys80z1c/kWNppo4uFItzk=;
        b=g9WmNqkICAepaueBxJAG5qGqCtaxTwXosKlFZ09zq3E+EGvstklUrW4PDlkf2i6NnC
         DGKgzWUQIfDpLCOYByUYnBx7MfLYvJapWWOC160fgjRZOdC3oSm3Rb4wFUOrJRHPlfzJ
         cK6tCvOVthzABdPBzvlLK8BGpHci7toxurVAB2ZHx5Aor7s+a90gbBtUgCJwEOYhmXrR
         s3UGzYI0OfsbpLwmpnfONUxc4theAX3MylocfLBRf8nIB5UndRMUNqgU9EkljbAgD7/F
         QAMcSQH8Oc8MISEwEUOzatVLvWJ/qOJB9VdtOBXPW8Cx787l1W/mU3MleWj8cRGnzwt+
         ALUA==
X-Gm-Message-State: AOJu0YwOLlpegU0KyKNluZ2toVdgTJ0O4L08Zg9I7C72NSS2DxSozm+Q
        AAjDQpNJvG/u4e6fLT4gEW9/Fg==
X-Google-Smtp-Source: AGHT+IFm9hZ76V6UiwyitE61nx7oNkEi1F9vqgVXj4aFJ1Y22vRm82vR14VpGzq8T8CkpAq4FtAt6A==
X-Received: by 2002:a2e:a22c:0:b0:2c5:1bd3:5658 with SMTP id i12-20020a2ea22c000000b002c51bd35658mr9502780ljm.28.1698187392142;
        Tue, 24 Oct 2023 15:43:12 -0700 (PDT)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0040641a9d49bsm13049531wmq.17.2023.10.24.15.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 15:43:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 2/4] media: qcom: camss: Use common VFE pm_domain_on/pm_domain_off where applicable
Date:   Tue, 24 Oct 2023 23:42:53 +0100
Message-ID: <20231024224255.754779-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024224255.754779-1-bryan.odonoghue@linaro.org>
References: <20231024224255.754779-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-vfe-170.c | 36 -------------------
 .../media/platform/qcom/camss/camss-vfe-4-1.c |  8 ++---
 .../media/platform/qcom/camss/camss-vfe-4-7.c | 32 -----------------
 .../media/platform/qcom/camss/camss-vfe-4-8.c | 29 ---------------
 .../media/platform/qcom/camss/camss-vfe-480.c | 36 -------------------
 drivers/media/platform/qcom/camss/camss-vfe.c | 34 ++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h | 12 +++++++
 7 files changed, 50 insertions(+), 137 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 59b0ea0aac48f..795ac3815339a 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -627,42 +627,6 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
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
-	enum vfe_line_id id = vfe->id;
-
-	if (id >= camss->res->vfe_num)
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
index c668494ee1e98..7655d22a9fda2 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1103,38 +1103,6 @@ static void vfe_isr_read(struct vfe_device *vfe, u32 *value0, u32 *value1)
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
-	enum vfe_line_id id = vfe->id;
-
-	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
-					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
-
-	if (!vfe->genpd_link) {
-		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", id);
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
index 5bd5b6b3c992a..f52fa30f3853e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -1093,35 +1093,6 @@ static void vfe_isr_read(struct vfe_device *vfe, u32 *value0, u32 *value1)
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
-	enum vfe_line_id id = vfe->id;
-
-	vfe->genpd_link = device_link_add(camss->dev, vfe->genpd, DL_FLAG_STATELESS |
-					  DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
-
-	if (!vfe->genpd_link) {
-		dev_err(vfe->camss->dev, "Failed to add VFE#%d to power domain\n", id);
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
index ca16a7ebb2903..4652e8b4cff58 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -452,42 +452,6 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
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
-	enum vfe_line_id id = vfe->id;
-
-	if (id >= camss->res->vfe_num)
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
index 3d31f4289b724..fc3733baa668d 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -474,6 +474,40 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
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
+	enum vfe_line_id id = vfe->id;
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

