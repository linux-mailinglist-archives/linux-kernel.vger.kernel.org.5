Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8C7DDFEB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjKAKzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjKAKze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:55:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D04127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:55:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f7db21967so2995952f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698836127; x=1699440927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu58a9RQKxZJQ71kfZd1GrHrJotRzWNjVScFmiTpkL0=;
        b=vTC0ZaNApMM6bhIEPINSvU2XVkcsxILCwiTUArIpneL/GzxybFIvWtpZsT2zEcjcf8
         Q0LlDTTJwE24Ca1LPrkh8tfGVFXCBEslc5FHQA108YpwlSimcco7pURjOerZaQ6NevZx
         rLnTYxcfJMgIu+z4Awx/tMHI1B8X98qLKH4cQDnVFKAXR6xvKIuanmG+L408kB3xEH1q
         fbLf5cV5dPOnS4DPX5SmSVbp0kMFoPuqiV754Zsjyk8Zl0V6/py360aJe96iiV4hhIC8
         AUAloVsDKi3jI/+HhuZW41Ry8da5yJAw5Zg5eQrb/h65WSPiLIW9Y1M5AgLHjjPWc+aa
         fjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698836127; x=1699440927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu58a9RQKxZJQ71kfZd1GrHrJotRzWNjVScFmiTpkL0=;
        b=xTRj7DuxUC3XPfLjXvSgB+yHDdoew4BkdXa7xKv9KWOy0oIcACKI+ml0oiqnSkx1Q7
         7KfZQxLxgQKZrro2tDqQGWR/jAEcLiES7eYXwmdZ7kqF2XNtyc2PBd6nNU9FwX6MjDXJ
         lHJKJ74TFm2v7RZioX/NHceoU75VvH0lByTO1qfXl7aNDh7q0IHCNa8zOfvMerDs+4Lt
         N2QAB35MxTWp5v+EI75EBZ0UGjmYNtflhGMOzJvgwVJfkTQdHDmJ/FoQ2yoYLBPUANfL
         aIimkdbVXzn2wUR5/lrC0+keHegK22LCiSsaoD6+JzFwtmBaTRJ5YrAbT/BGZjVXJIKl
         7XZw==
X-Gm-Message-State: AOJu0YxPJQdMU5927ePdzn+hJK6ORtnIwMCut4ynJZ0Y06/AAco49hL3
        n3aznS1ZVSjeKFIOREJ1CQI2+Q==
X-Google-Smtp-Source: AGHT+IFl9JwqjvaLc+VW4tYULPO7FWejXgDkqtNItXS3odW22KBnItnF9Si5w8sQDLUUDnfyUjM0Wg==
X-Received: by 2002:a5d:47a9:0:b0:32f:96c6:8bb with SMTP id 9-20020a5d47a9000000b0032f96c608bbmr3560242wrb.7.1698836126759;
        Wed, 01 Nov 2023 03:55:26 -0700 (PDT)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b0032d09f7a713sm3830948wrv.18.2023.11.01.03.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 03:55:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Wed, 01 Nov 2023 10:54:33 +0000
Subject: [PATCH v3 3/5] media: qcom: camss: Use common VFE
 pm_domain_on/pm_domain_off where applicable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231101-b4-camss-named-power-domains-v3-3-bbdf5f22462a@linaro.org>
References: <20231101-b4-camss-named-power-domains-v3-0-bbdf5f22462a@linaro.org>
In-Reply-To: <20231101-b4-camss-named-power-domains-v3-0-bbdf5f22462a@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Suggested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 35 -----------------------
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c |  8 +++---
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 31 --------------------
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c | 28 ------------------
 drivers/media/platform/qcom/camss/camss-vfe-480.c | 35 -----------------------
 drivers/media/platform/qcom/camss/camss-vfe.c     | 34 ++++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h     | 12 ++++++++
 7 files changed, 50 insertions(+), 133 deletions(-)

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
index 94267b9974554..5172eb5612a1c 100644
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
+	vfe->genpd_link = NULL;
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

