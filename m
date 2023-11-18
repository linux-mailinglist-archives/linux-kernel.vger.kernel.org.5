Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB17EFF6D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKRML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjKRMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:11:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A5D71
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 04:11:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40842752c6eso3037325e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 04:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700309502; x=1700914302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OpluDSI7ifwDeNDFUHoJfsbGgfPas9u/8aOkEgqU+o=;
        b=YqMLC2ELD6wVFg7KKZTtU5S1rI1yCA4H8WLDeu92QO/evSpBADOFN1g69hODKarpRd
         /VoG5LlRYgsOIM1pTDqRL/W6IPu/vXfxln6rdPRIL0L7AIb6iX8oouFbgjv9weiyCg0D
         tXnJDTrisPaaggUTN11O0zXgmZJ7uCfo91/9LFPe5pM+0JJ3B96QpE2wAtz4/cHz6V4N
         rwGdwBEcJbz57drlDBERMGbrous187UskNzSv59YYT64TdOb//5PRpvu/em6LvjHHmQA
         GREmALP73wKUdfxGDGcfNcTAmyZTpPGIMXRU39/qaL6YRFLRTOoGW03XGOQtumaLEkuL
         RjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700309502; x=1700914302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OpluDSI7ifwDeNDFUHoJfsbGgfPas9u/8aOkEgqU+o=;
        b=eFzttd+2l5HGiU2EgXdImI/hLLvLjwrmtKRqKDNxvJtRtAqcS3JGyeBBSHNpOonARc
         QDyWBp3nYB9llE5AdmakF+bPZg0CE/XnjPsxf5aooHb20tQlzHH0yofM0mw423MZHnV1
         H/yxR+MMaI6F0dqnjfOUVtsoAAGwdFL/AmIMhmkDoxrfR39SgL7SPYaLDRTDKFkq743k
         xc0Ow44x6pbIKGiycv/KAGISi2mFKL33nHb3IGgno31oTK+6DVKlphXDuvpMFeJ31Utx
         7wYCd7fz8nOOSOv9midxb/97sRWnd+NCj2xGwSMCAPJZSdT/nI/9wdWYSq+3myK7az7a
         CIEA==
X-Gm-Message-State: AOJu0YyJxYV/n5CeVPeFPcltSpEAsi9sf6ZDNHWA19glpafkP2llAgln
        hMbixnj6WD+iYNhKU1cbWct6yw==
X-Google-Smtp-Source: AGHT+IEqRmhrXbObwIAQiKUOzEUnRyIr4s34qZALoEJigzMdMVzmH5ZE7S/VejU5Ww63KwPnBbMq7w==
X-Received: by 2002:a05:600c:4f4a:b0:40a:49c1:94d9 with SMTP id m10-20020a05600c4f4a00b0040a49c194d9mr1557333wmq.27.1700309502614;
        Sat, 18 Nov 2023 04:11:42 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b00407efbc4361sm10955775wms.9.2023.11.18.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 04:11:41 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Sat, 18 Nov 2023 12:11:37 +0000
Subject: [PATCH v5 3/7] media: qcom: camss: Use common VFE
 pm_domain_on/pm_domain_off where applicable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231118-b4-camss-named-power-domains-v5-3-55eb0f35a30a@linaro.org>
References: <20231118-b4-camss-named-power-domains-v5-0-55eb0f35a30a@linaro.org>
In-Reply-To: <20231118-b4-camss-named-power-domains-v5-0-55eb0f35a30a@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
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

