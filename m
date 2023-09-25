Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8277ADC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjIYPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjIYPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:47:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AEF112
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3214d4ecd39so5655187f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656836; x=1696261636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biCoK57H9w4x0GlQBz339du1frh/6bO6nSXoupCi++g=;
        b=Wx2UE+QunD2vZ8W/HAWaOVRHGKT8uTYagoyuHomYFsAa5tJsIjmPm/GtjSYhlgnDSr
         SRxbXQrBB2GaNOcby1/RbNcIGXqU4OzfHmJI1Vv/Kscsd4uLvfhgERdYczZz+UrQ8BmK
         nwNd/DQU0nytohQQl0e3PJf2BD3xWj7qdqbqnF3ZZQoTRfIuOiDD+6njzSox22dkpE0t
         1TFkg2G84vOCZiSbLCgL13pqaARTl029EiQSdBI/kFIND4qVuy/srFMJk2ybpB5zX0NP
         MK6PibIkTvGnvkYOsgqVp4qePHxWOzkwFEAH3E1Ix+6GRrwY834nlAVgl8JGZPRfJ8nw
         cjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656836; x=1696261636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biCoK57H9w4x0GlQBz339du1frh/6bO6nSXoupCi++g=;
        b=uVL/H7NLXBbnoStOrwqJzNUl+95+Rx1I0ob/mWQfGuXZ8Mdj4f6scQvoteZmz3dQAY
         xflILvcC8MLEoyMdsYd3R5HEmHyt7kGPUgMGNhaJhaj/rHORyZSrYMCi1GkwpFXSmPgU
         N3w/aYD8yu5lk1yZa+nTLg6feTxj9UGHqDtX7ODSLGI+pzCrhjs1niv0+91HvfID3O7B
         BIVkDDjeCGsR9ohy7o1XaE4EX1Yyz9+phoZ/LqLiadk2Z3n6dassfg8UbjcxIIBZkbq9
         ZKTjMoglxgHZXS1wTU1EOK1oVYc+UWed1ojyzuVpKCwNLIAtspbnANVu4ejTnaC4CYBF
         hkfg==
X-Gm-Message-State: AOJu0Yx4L/g8h5B8YPlTPSUS3PxtA5ObDhnjcNBmKcQ1CVMG6RL6nPXe
        aRkWV8Ciwt2ikS4FI7X/njDeEg==
X-Google-Smtp-Source: AGHT+IFCqoh/xTMTGcgF8sY+Zsab2ymBdjzXyQAmDptTqMJEn/apKKDMJEE7f3tTp63DNyD2iAwP6g==
X-Received: by 2002:a05:6000:10d:b0:31f:9b4f:1910 with SMTP id o13-20020a056000010d00b0031f9b4f1910mr5343308wrx.63.1695656836190;
        Mon, 25 Sep 2023 08:47:16 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b0031f34a395e7sm12077536wrr.45.2023.09.25.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:47:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [RESEND PATCH v6 05/17] media: qcom: camss: Pass remainder of variables as resources
Date:   Mon, 25 Sep 2023 16:46:55 +0100
Message-ID: <20230925154707.837542-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
References: <20230925154707.837542-1-bryan.odonoghue@linaro.org>
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

The following variables are being assigned statically based on
compatible strings in the probe path.

* enum camss_version version;
* unsigned int csiphy_num;
* unsigned int csid_num;
* unsigned int vfe_num;
* unsigned int vfe_lite_num;
* unsigned int vfe_total_num;

Migrate those variables to resource parameters passed in on platform
probe arguments. The one caveat is for VFE it has been necessary to
intoduce a new variable vfe_total_num to capture the aggregate value of
vfe_num + vfe_lite_num.

All the rest of the changes are rote camss->variable to
camss->res->variable with the parameter tables now populating the listed
variables.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../media/platform/qcom/camss/camss-csid.c    |  14 +--
 .../qcom/camss/camss-csiphy-3ph-1-0.c         |   8 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  16 +--
 .../media/platform/qcom/camss/camss-ispif.c   |  28 ++---
 .../media/platform/qcom/camss/camss-vfe-170.c |   4 +-
 .../media/platform/qcom/camss/camss-vfe-480.c |   4 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |  26 ++--
 .../media/platform/qcom/camss/camss-video.c   |  10 +-
 drivers/media/platform/qcom/camss/camss.c     | 115 ++++++++----------
 drivers/media/platform/qcom/camss/camss.h     |  11 +-
 10 files changed, 113 insertions(+), 123 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index b1113decdb305..14abb7a7ceb47 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -159,7 +159,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 	struct camss *camss = csid->camss;
 	struct device *dev = camss->dev;
 	struct vfe_device *vfe = &camss->vfe[csid->id];
-	u32 version = camss->version;
+	u32 version = camss->res->version;
 	int ret = 0;
 
 	if (on) {
@@ -576,13 +576,13 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 	csid->camss = camss;
 	csid->id = id;
 
-	if (camss->version == CAMSS_8x16) {
+	if (camss->res->version == CAMSS_8x16) {
 		csid->ops = &csid_ops_4_1;
-	} else if (camss->version == CAMSS_8x96 ||
-		   camss->version == CAMSS_660) {
+	} else if (camss->res->version == CAMSS_8x96 ||
+		   camss->res->version == CAMSS_660) {
 		csid->ops = &csid_ops_4_7;
-	} else if (camss->version == CAMSS_845 ||
-		   camss->version == CAMSS_8250) {
+	} else if (camss->res->version == CAMSS_845 ||
+		   camss->res->version == CAMSS_8250) {
 		csid->ops = &csid_ops_gen2;
 	} else {
 		return -EINVAL;
@@ -591,7 +591,7 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 
 	/* Memory */
 
-	if (camss->version == CAMSS_8250) {
+	if (camss->res->version == CAMSS_8250) {
 		/* for titan 480, CSID registers are inside the VFE region,
 		 * between the VFE "top" and "bus" registers. this requires
 		 * VFE to be initialized before CSID
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index 4dba61b8d3f2a..f50e2235c37fc 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -402,7 +402,7 @@ static void csiphy_gen1_config_lanes(struct csiphy_device *csiphy,
 	val = CSIPHY_3PH_LNn_CFG1_SWI_REC_DLY_PRG;
 	writel_relaxed(val, csiphy->base + CSIPHY_3PH_LNn_CFG1(l));
 
-	if (csiphy->camss->version == CAMSS_660)
+	if (csiphy->camss->res->version == CAMSS_660)
 		val = CSIPHY_3PH_LNn_CFG4_T_HS_CLK_MISS_660;
 	else
 		val = CSIPHY_3PH_LNn_CFG4_T_HS_CLK_MISS;
@@ -419,7 +419,7 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
 	int i, l, array_size;
 	u32 val;
 
-	switch (csiphy->camss->version) {
+	switch (csiphy->camss->res->version) {
 	case CAMSS_845:
 		r = &lane_regs_sdm845[0][0];
 		array_size = ARRAY_SIZE(lane_regs_sdm845[0]);
@@ -468,8 +468,8 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 				s64 link_freq, u8 lane_mask)
 {
 	struct csiphy_lanes_cfg *c = &cfg->csi2->lane_cfg;
-	bool is_gen2 = (csiphy->camss->version == CAMSS_845 ||
-			csiphy->camss->version == CAMSS_8250);
+	bool is_gen2 = (csiphy->camss->res->version == CAMSS_845 ||
+			csiphy->camss->res->version == CAMSS_8250);
 	u8 settle_cnt;
 	u8 val;
 	int i;
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index b1b6c4cf18385..48e6a101ec9c9 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -557,17 +557,17 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	csiphy->id = id;
 	csiphy->cfg.combo_mode = 0;
 
-	if (camss->version == CAMSS_8x16) {
+	if (camss->res->version == CAMSS_8x16) {
 		csiphy->ops = &csiphy_ops_2ph_1_0;
 		csiphy->formats = csiphy_formats_8x16;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x16);
-	} else if (camss->version == CAMSS_8x96 ||
-		   camss->version == CAMSS_660) {
+	} else if (camss->res->version == CAMSS_8x96 ||
+		   camss->res->version == CAMSS_660) {
 		csiphy->ops = &csiphy_ops_3ph_1_0;
 		csiphy->formats = csiphy_formats_8x96;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x96);
-	} else if (camss->version == CAMSS_845 ||
-		   camss->version == CAMSS_8250) {
+	} else if (camss->res->version == CAMSS_845 ||
+		   camss->res->version == CAMSS_8250) {
 		csiphy->ops = &csiphy_ops_3ph_1_0;
 		csiphy->formats = csiphy_formats_sdm845;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
@@ -581,8 +581,8 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	if (IS_ERR(csiphy->base))
 		return PTR_ERR(csiphy->base);
 
-	if (camss->version == CAMSS_8x16 ||
-	    camss->version == CAMSS_8x96) {
+	if (camss->res->version == CAMSS_8x16 ||
+	    camss->res->version == CAMSS_8x96) {
 		csiphy->base_clk_mux =
 			devm_platform_ioremap_resource_byname(pdev, res->reg[1]);
 		if (IS_ERR(csiphy->base_clk_mux))
@@ -664,7 +664,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 		    !strcmp(clock->name, "csiphy5_timer"))
 			csiphy->rate_set[i] = true;
 
-		if (camss->version == CAMSS_660 &&
+		if (camss->res->version == CAMSS_660 &&
 		    (!strcmp(clock->name, "csi0_phy") ||
 		     !strcmp(clock->name, "csi1_phy") ||
 		     !strcmp(clock->name, "csi2_phy")))
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 75b8a60806b22..be9d2f0a10c18 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -270,7 +270,7 @@ static int ispif_vfe_reset(struct ispif_device *ispif, u8 vfe_id)
 	unsigned long time;
 	u32 val;
 
-	if (vfe_id > (camss->vfe_num - 1)) {
+	if (vfe_id > camss->res->vfe_num - 1) {
 		dev_err(camss->dev,
 			"Error: asked reset for invalid VFE%d\n", vfe_id);
 		return -ENOENT;
@@ -829,8 +829,8 @@ static int ispif_set_stream(struct v4l2_subdev *sd, int enable)
 		ispif_select_csid(ispif, intf, csid, vfe, 1);
 		ispif_select_cid(ispif, intf, cid, vfe, 1);
 		ispif_config_irq(ispif, intf, vfe, 1);
-		if (camss->version == CAMSS_8x96 ||
-		    camss->version == CAMSS_660)
+		if (camss->res->version == CAMSS_8x96 ||
+		    camss->res->version == CAMSS_660)
 			ispif_config_pack(ispif,
 					  line->fmt[MSM_ISPIF_PAD_SINK].code,
 					  intf, cid, vfe, 1);
@@ -847,8 +847,8 @@ static int ispif_set_stream(struct v4l2_subdev *sd, int enable)
 			return ret;
 
 		mutex_lock(&ispif->config_lock);
-		if (camss->version == CAMSS_8x96 ||
-		    camss->version == CAMSS_660)
+		if (camss->res->version == CAMSS_8x96 ||
+		    camss->res->version == CAMSS_660)
 			ispif_config_pack(ispif,
 					  line->fmt[MSM_ISPIF_PAD_SINK].code,
 					  intf, cid, vfe, 0);
@@ -1109,10 +1109,10 @@ int msm_ispif_subdev_init(struct camss *camss,
 	ispif->camss = camss;
 
 	/* Number of ISPIF lines - same as number of CSID hardware modules */
-	if (camss->version == CAMSS_8x16)
+	if (camss->res->version == CAMSS_8x16)
 		ispif->line_num = 2;
-	else if (camss->version == CAMSS_8x96 ||
-		 camss->version == CAMSS_660)
+	else if (camss->res->version == CAMSS_8x96 ||
+		 camss->res->version == CAMSS_660)
 		ispif->line_num = 4;
 	else
 		return -EINVAL;
@@ -1126,12 +1126,12 @@ int msm_ispif_subdev_init(struct camss *camss,
 		ispif->line[i].ispif = ispif;
 		ispif->line[i].id = i;
 
-		if (camss->version == CAMSS_8x16) {
+		if (camss->res->version == CAMSS_8x16) {
 			ispif->line[i].formats = ispif_formats_8x16;
 			ispif->line[i].nformats =
 					ARRAY_SIZE(ispif_formats_8x16);
-		} else if (camss->version == CAMSS_8x96 ||
-			   camss->version == CAMSS_660) {
+		} else if (camss->res->version == CAMSS_8x96 ||
+			   camss->res->version == CAMSS_660) {
 			ispif->line[i].formats = ispif_formats_8x96;
 			ispif->line[i].nformats =
 					ARRAY_SIZE(ispif_formats_8x96);
@@ -1159,11 +1159,11 @@ int msm_ispif_subdev_init(struct camss *camss,
 	ispif->irq = ret;
 	snprintf(ispif->irq_name, sizeof(ispif->irq_name), "%s_%s",
 		 dev_name(dev), MSM_ISPIF_NAME);
-	if (camss->version == CAMSS_8x16)
+	if (camss->res->version == CAMSS_8x16)
 		ret = devm_request_irq(dev, ispif->irq, ispif_isr_8x16,
 			       IRQF_TRIGGER_RISING, ispif->irq_name, ispif);
-	else if (camss->version == CAMSS_8x96 ||
-		 camss->version == CAMSS_660)
+	else if (camss->res->version == CAMSS_8x96 ||
+		 camss->res->version == CAMSS_660)
 		ret = devm_request_irq(dev, ispif->irq, ispif_isr_8x96,
 			       IRQF_TRIGGER_RISING, ispif->irq_name, ispif);
 	else
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 168baaa80d4e6..82d2392022dd1 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -673,7 +673,7 @@ static void vfe_pm_domain_off(struct vfe_device *vfe)
 {
 	struct camss *camss = vfe->camss;
 
-	if (vfe->id >= camss->vfe_num)
+	if (vfe->id >= camss->res->vfe_num)
 		return;
 
 	device_link_del(camss->genpd_link[vfe->id]);
@@ -688,7 +688,7 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
 	struct camss *camss = vfe->camss;
 	enum vfe_line_id id = vfe->id;
 
-	if (id >= camss->vfe_num)
+	if (id >= camss->res->vfe_num)
 		return 0;
 
 	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id],
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index 8ddb8016434ae..074fa4e38163e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -499,7 +499,7 @@ static void vfe_pm_domain_off(struct vfe_device *vfe)
 {
 	struct camss *camss = vfe->camss;
 
-	if (vfe->id >= camss->vfe_num)
+	if (vfe->id >= camss->res->vfe_num)
 		return;
 
 	device_link_del(camss->genpd_link[vfe->id]);
@@ -514,7 +514,7 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
 	struct camss *camss = vfe->camss;
 	enum vfe_line_id id = vfe->id;
 
-	if (id >= camss->vfe_num)
+	if (id >= camss->res->vfe_num)
 		return 0;
 
 	camss->genpd_link[id] = device_link_add(camss->dev, camss->genpd[id],
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index e84dcf0f4b2da..94ee7c7039eb3 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -170,7 +170,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 {
 	struct vfe_device *vfe = to_vfe(line);
 
-	if (vfe->camss->version == CAMSS_8x16)
+	if (vfe->camss->res->version == CAMSS_8x16)
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -218,10 +218,10 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 
 			return sink_code;
 		}
-	else if (vfe->camss->version == CAMSS_8x96 ||
-		 vfe->camss->version == CAMSS_660 ||
-		 vfe->camss->version == CAMSS_845 ||
-		 vfe->camss->version == CAMSS_8250)
+	else if (vfe->camss->res->version == CAMSS_8x96 ||
+		 vfe->camss->res->version == CAMSS_660 ||
+		 vfe->camss->res->version == CAMSS_845 ||
+		 vfe->camss->res->version == CAMSS_8250)
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -1286,7 +1286,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	int i, j;
 	int ret;
 
-	switch (camss->version) {
+	switch (camss->res->version) {
 	case CAMSS_8x16:
 		vfe->ops = &vfe_ops_4_1;
 		break;
@@ -1392,7 +1392,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		init_completion(&l->output.sof);
 		init_completion(&l->output.reg_update);
 
-		if (camss->version == CAMSS_8x16) {
+		if (camss->res->version == CAMSS_8x16) {
 			if (i == VFE_LINE_PIX) {
 				l->formats = formats_pix_8x16;
 				l->nformats = ARRAY_SIZE(formats_pix_8x16);
@@ -1400,8 +1400,8 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 				l->formats = formats_rdi_8x16;
 				l->nformats = ARRAY_SIZE(formats_rdi_8x16);
 			}
-		} else if (camss->version == CAMSS_8x96 ||
-			   camss->version == CAMSS_660) {
+		} else if (camss->res->version == CAMSS_8x96 ||
+			   camss->res->version == CAMSS_660) {
 			if (i == VFE_LINE_PIX) {
 				l->formats = formats_pix_8x96;
 				l->nformats = ARRAY_SIZE(formats_pix_8x96);
@@ -1409,8 +1409,8 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 				l->formats = formats_rdi_8x96;
 				l->nformats = ARRAY_SIZE(formats_rdi_8x96);
 			}
-		} else if (camss->version == CAMSS_845 ||
-			   camss->version == CAMSS_8250) {
+		} else if (camss->res->version == CAMSS_845 ||
+			   camss->res->version == CAMSS_8250) {
 			l->formats = formats_rdi_845;
 			l->nformats = ARRAY_SIZE(formats_rdi_845);
 		} else {
@@ -1542,8 +1542,8 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
 		}
 
 		video_out->ops = &vfe->video_ops;
-		if (vfe->camss->version == CAMSS_845 ||
-		    vfe->camss->version == CAMSS_8250)
+		if (vfe->camss->res->version == CAMSS_845 ||
+		    vfe->camss->res->version == CAMSS_8250)
 			video_out->bpl_alignment = 16;
 		else
 			video_out->bpl_alignment = 8;
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 1d686aef92eaf..46a89b5f6c171 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -1006,7 +1006,7 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 
 	mutex_init(&video->lock);
 
-	if (video->camss->version == CAMSS_8x16) {
+	if (video->camss->res->version == CAMSS_8x16) {
 		if (is_pix) {
 			video->formats = formats_pix_8x16;
 			video->nformats = ARRAY_SIZE(formats_pix_8x16);
@@ -1014,8 +1014,8 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 			video->formats = formats_rdi_8x16;
 			video->nformats = ARRAY_SIZE(formats_rdi_8x16);
 		}
-	} else if (video->camss->version == CAMSS_8x96 ||
-		   video->camss->version == CAMSS_660) {
+	} else if (video->camss->res->version == CAMSS_8x96 ||
+		   video->camss->res->version == CAMSS_660) {
 		if (is_pix) {
 			video->formats = formats_pix_8x96;
 			video->nformats = ARRAY_SIZE(formats_pix_8x96);
@@ -1023,8 +1023,8 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 			video->formats = formats_rdi_8x96;
 			video->nformats = ARRAY_SIZE(formats_rdi_8x96);
 		}
-	}  else if (video->camss->version == CAMSS_845 ||
-		    video->camss->version == CAMSS_8250) {
+	}  else if (video->camss->res->version == CAMSS_845 ||
+		    video->camss->res->version == CAMSS_8250) {
 		video->formats = formats_rdi_845;
 		video->nformats = ARRAY_SIZE(formats_rdi_845);
 	} else {
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index f502b4d9e07c5..d1152a7db9cd2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1005,7 +1005,7 @@ int camss_pm_domain_on(struct camss *camss, int id)
 {
 	int ret = 0;
 
-	if (id < camss->vfe_num) {
+	if (id < camss->res->vfe_num) {
 		struct vfe_device *vfe = &camss->vfe[id];
 
 		ret = vfe->ops->pm_domain_on(vfe);
@@ -1016,7 +1016,7 @@ int camss_pm_domain_on(struct camss *camss, int id)
 
 void camss_pm_domain_off(struct camss *camss, int id)
 {
-	if (id < camss->vfe_num) {
+	if (id < camss->res->vfe_num) {
 		struct vfe_device *vfe = &camss->vfe[id];
 
 		vfe->ops->pm_domain_off(vfe);
@@ -1125,7 +1125,7 @@ static int camss_init_subdevices(struct camss *camss)
 	unsigned int i;
 	int ret;
 
-	for (i = 0; i < camss->csiphy_num; i++) {
+	for (i = 0; i < camss->res->csiphy_num; i++) {
 		ret = msm_csiphy_subdev_init(camss, &camss->csiphy[i],
 					     &res->csiphy_res[i], i);
 		if (ret < 0) {
@@ -1137,7 +1137,7 @@ static int camss_init_subdevices(struct camss *camss)
 	}
 
 	/* note: SM8250 requires VFE to be initialized before CSID */
-	for (i = 0; i < camss->vfe_num + camss->vfe_lite_num; i++) {
+	for (i = 0; i < camss->vfe_total_num; i++) {
 		ret = msm_vfe_subdev_init(camss, &camss->vfe[i],
 					  &res->vfe_res[i], i);
 		if (ret < 0) {
@@ -1147,7 +1147,7 @@ static int camss_init_subdevices(struct camss *camss)
 		}
 	}
 
-	for (i = 0; i < camss->csid_num; i++) {
+	for (i = 0; i < camss->res->csid_num; i++) {
 		ret = msm_csid_subdev_init(camss, &camss->csid[i],
 					   &res->csid_res[i], i);
 		if (ret < 0) {
@@ -1179,7 +1179,7 @@ static int camss_register_entities(struct camss *camss)
 	int i, j, k;
 	int ret;
 
-	for (i = 0; i < camss->csiphy_num; i++) {
+	for (i = 0; i < camss->res->csiphy_num; i++) {
 		ret = msm_csiphy_register_entity(&camss->csiphy[i],
 						 &camss->v4l2_dev);
 		if (ret < 0) {
@@ -1190,7 +1190,7 @@ static int camss_register_entities(struct camss *camss)
 		}
 	}
 
-	for (i = 0; i < camss->csid_num; i++) {
+	for (i = 0; i < camss->res->csid_num; i++) {
 		ret = msm_csid_register_entity(&camss->csid[i],
 					       &camss->v4l2_dev);
 		if (ret < 0) {
@@ -1209,7 +1209,7 @@ static int camss_register_entities(struct camss *camss)
 		goto err_reg_ispif;
 	}
 
-	for (i = 0; i < camss->vfe_num + camss->vfe_lite_num; i++) {
+	for (i = 0; i < camss->vfe_total_num; i++) {
 		ret = msm_vfe_register_entities(&camss->vfe[i],
 						&camss->v4l2_dev);
 		if (ret < 0) {
@@ -1220,8 +1220,8 @@ static int camss_register_entities(struct camss *camss)
 		}
 	}
 
-	for (i = 0; i < camss->csiphy_num; i++) {
-		for (j = 0; j < camss->csid_num; j++) {
+	for (i = 0; i < camss->res->csiphy_num; i++) {
+		for (j = 0; j < camss->res->csid_num; j++) {
 			ret = media_create_pad_link(
 				&camss->csiphy[i].subdev.entity,
 				MSM_CSIPHY_PAD_SRC,
@@ -1240,7 +1240,7 @@ static int camss_register_entities(struct camss *camss)
 	}
 
 	if (camss->ispif) {
-		for (i = 0; i < camss->csid_num; i++) {
+		for (i = 0; i < camss->res->csid_num; i++) {
 			for (j = 0; j < camss->ispif->line_num; j++) {
 				ret = media_create_pad_link(
 					&camss->csid[i].subdev.entity,
@@ -1260,7 +1260,7 @@ static int camss_register_entities(struct camss *camss)
 		}
 
 		for (i = 0; i < camss->ispif->line_num; i++)
-			for (k = 0; k < camss->vfe_num; k++)
+			for (k = 0; k < camss->res->vfe_num; k++)
 				for (j = 0; j < camss->vfe[k].line_num; j++) {
 					struct v4l2_subdev *ispif = &camss->ispif->line[i].subdev;
 					struct v4l2_subdev *vfe = &camss->vfe[k].line[j].subdev;
@@ -1280,8 +1280,8 @@ static int camss_register_entities(struct camss *camss)
 					}
 				}
 	} else {
-		for (i = 0; i < camss->csid_num; i++)
-			for (k = 0; k < camss->vfe_num + camss->vfe_lite_num; k++)
+		for (i = 0; i < camss->res->csid_num; i++)
+			for (k = 0; k < camss->vfe_total_num; k++)
 				for (j = 0; j < camss->vfe[k].line_num; j++) {
 					struct v4l2_subdev *csid = &camss->csid[i].subdev;
 					struct v4l2_subdev *vfe = &camss->vfe[k].line[j].subdev;
@@ -1305,7 +1305,7 @@ static int camss_register_entities(struct camss *camss)
 	return 0;
 
 err_link:
-	i = camss->vfe_num + camss->vfe_lite_num;
+	i = camss->vfe_total_num;
 err_reg_vfe:
 	for (i--; i >= 0; i--)
 		msm_vfe_unregister_entities(&camss->vfe[i]);
@@ -1313,12 +1313,12 @@ static int camss_register_entities(struct camss *camss)
 err_reg_ispif:
 	msm_ispif_unregister_entities(camss->ispif);
 
-	i = camss->csid_num;
+	i = camss->res->csid_num;
 err_reg_csid:
 	for (i--; i >= 0; i--)
 		msm_csid_unregister_entity(&camss->csid[i]);
 
-	i = camss->csiphy_num;
+	i = camss->res->csiphy_num;
 err_reg_csiphy:
 	for (i--; i >= 0; i--)
 		msm_csiphy_unregister_entity(&camss->csiphy[i]);
@@ -1336,15 +1336,15 @@ static void camss_unregister_entities(struct camss *camss)
 {
 	unsigned int i;
 
-	for (i = 0; i < camss->csiphy_num; i++)
+	for (i = 0; i < camss->res->csiphy_num; i++)
 		msm_csiphy_unregister_entity(&camss->csiphy[i]);
 
-	for (i = 0; i < camss->csid_num; i++)
+	for (i = 0; i < camss->res->csid_num; i++)
 		msm_csid_unregister_entity(&camss->csid[i]);
 
 	msm_ispif_unregister_entities(camss->ispif);
 
-	for (i = 0; i < camss->vfe_num + camss->vfe_lite_num; i++)
+	for (i = 0; i < camss->vfe_total_num; i++)
 		msm_vfe_unregister_entities(&camss->vfe[i]);
 }
 
@@ -1463,7 +1463,7 @@ static int camss_configure_pd(struct camss *camss)
 		}
 	}
 
-	if (i > camss->vfe_num) {
+	if (i > camss->res->vfe_num) {
 		camss->genpd_link[i - 1] = device_link_add(camss->dev, camss->genpd[i - 1],
 							   DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
 							   DL_FLAG_RPM_ACTIVE);
@@ -1506,7 +1506,7 @@ static void camss_genpd_cleanup(struct camss *camss)
 	if (camss->genpd_num == 1)
 		return;
 
-	if (camss->genpd_num > camss->vfe_num)
+	if (camss->genpd_num > camss->res->vfe_num)
 		device_link_del(camss->genpd_link[camss->genpd_num - 1]);
 
 	for (i = 0; i < camss->genpd_num; i++)
@@ -1523,7 +1523,8 @@ static int camss_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct camss *camss;
-	int num_subdevs, ret;
+	int num_subdevs;
+	int ret;
 
 	camss = devm_kzalloc(dev, sizeof(*camss), GFP_KERNEL);
 	if (!camss)
@@ -1535,59 +1536,25 @@ static int camss_probe(struct platform_device *pdev)
 	camss->dev = dev;
 	platform_set_drvdata(pdev, camss);
 
-	if (of_device_is_compatible(dev->of_node, "qcom,msm8916-camss")) {
-		camss->version = CAMSS_8x16;
-		camss->csiphy_num = 2;
-		camss->csid_num = 2;
-		camss->vfe_num = 1;
-	} else if (of_device_is_compatible(dev->of_node,
-					   "qcom,msm8996-camss")) {
-		camss->version = CAMSS_8x96;
-		camss->csiphy_num = 3;
-		camss->csid_num = 4;
-		camss->vfe_num = 2;
-	} else if (of_device_is_compatible(dev->of_node,
-					   "qcom,sdm660-camss")) {
-		camss->version = CAMSS_660;
-		camss->csiphy_num = 3;
-		camss->csid_num = 4;
-		camss->vfe_num = 2;
-	} else if (of_device_is_compatible(dev->of_node,
-					   "qcom,sdm845-camss")) {
-		camss->version = CAMSS_845;
-		camss->csiphy_num = 4;
-		camss->csid_num = 3;
-		camss->vfe_num = 2;
-		camss->vfe_lite_num = 1;
-	} else if (of_device_is_compatible(dev->of_node,
-					   "qcom,sm8250-camss")) {
-		camss->version = CAMSS_8250;
-		camss->csiphy_num = 6;
-		camss->csid_num = 4;
-		camss->vfe_num = 2;
-		camss->vfe_lite_num = 2;
-	} else {
-		return -EINVAL;
-	}
-
-	camss->csiphy = devm_kcalloc(dev, camss->csiphy_num,
+	camss->csiphy = devm_kcalloc(dev, camss->res->csiphy_num,
 				     sizeof(*camss->csiphy), GFP_KERNEL);
 	if (!camss->csiphy)
 		return -ENOMEM;
 
-	camss->csid = devm_kcalloc(dev, camss->csid_num, sizeof(*camss->csid),
+	camss->csid = devm_kcalloc(dev, camss->res->csid_num, sizeof(*camss->csid),
 				   GFP_KERNEL);
 	if (!camss->csid)
 		return -ENOMEM;
 
-	if (camss->version == CAMSS_8x16 ||
-	    camss->version == CAMSS_8x96) {
+	if (camss->res->version == CAMSS_8x16 ||
+	    camss->res->version == CAMSS_8x96) {
 		camss->ispif = devm_kcalloc(dev, 1, sizeof(*camss->ispif), GFP_KERNEL);
 		if (!camss->ispif)
 			return -ENOMEM;
 	}
 
-	camss->vfe = devm_kcalloc(dev, camss->vfe_num + camss->vfe_lite_num,
+	camss->vfe_total_num = camss->res->vfe_num + camss->res->vfe_lite_num;
+	camss->vfe = devm_kcalloc(dev, camss->vfe_total_num,
 				  sizeof(*camss->vfe), GFP_KERNEL);
 	if (!camss->vfe)
 		return -ENOMEM;
@@ -1706,38 +1673,60 @@ static void camss_remove(struct platform_device *pdev)
 }
 
 static const struct camss_resources msm8916_resources = {
+	.version = CAMSS_8x16,
 	.csiphy_res = csiphy_res_8x16,
 	.csid_res = csid_res_8x16,
 	.ispif_res = &ispif_res_8x16,
 	.vfe_res = vfe_res_8x16,
+	.csiphy_num = ARRAY_SIZE(csiphy_res_8x16),
+	.csid_num = ARRAY_SIZE(csid_res_8x16),
+	.vfe_num = ARRAY_SIZE(vfe_res_8x16),
 };
 
 static const struct camss_resources msm8996_resources = {
+	.version = CAMSS_8x96,
 	.csiphy_res = csiphy_res_8x96,
 	.csid_res = csid_res_8x96,
 	.ispif_res = &ispif_res_8x96,
 	.vfe_res = vfe_res_8x96,
+	.csiphy_num = ARRAY_SIZE(csiphy_res_8x96),
+	.csid_num = ARRAY_SIZE(csid_res_8x96),
+	.vfe_num = ARRAY_SIZE(vfe_res_8x96),
 };
 
 static const struct camss_resources sdm660_resources = {
+	.version = CAMSS_660,
 	.csiphy_res = csiphy_res_660,
 	.csid_res = csid_res_660,
 	.ispif_res = &ispif_res_660,
 	.vfe_res = vfe_res_660,
+	.csiphy_num = ARRAY_SIZE(csiphy_res_660),
+	.csid_num = ARRAY_SIZE(csid_res_660),
+	.vfe_num = ARRAY_SIZE(vfe_res_660),
 };
 
 static const struct camss_resources sdm845_resources = {
+	.version = CAMSS_845,
 	.csiphy_res = csiphy_res_845,
 	.csid_res = csid_res_845,
 	.vfe_res = vfe_res_845,
+	.csiphy_num = ARRAY_SIZE(csiphy_res_845),
+	.csid_num = ARRAY_SIZE(csid_res_845),
+	.vfe_num = 2,
+	.vfe_lite_num = 1,
 };
 
 static const struct camss_resources sm8250_resources = {
+	.version = CAMSS_8250,
 	.csiphy_res = csiphy_res_8250,
 	.csid_res = csid_res_8250,
 	.vfe_res = vfe_res_8250,
 	.icc_res = icc_res_sm8250,
 	.icc_path_num = ARRAY_SIZE(icc_res_sm8250),
+	.csiphy_num = ARRAY_SIZE(csiphy_res_8250),
+	.csid_num = ARRAY_SIZE(csid_res_8250),
+	.vfe_num = 2,
+	.vfe_lite_num = 2,
 };
 
 static const struct of_device_id camss_dt_match[] = {
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 8b2e4adb923ef..3b6562b515d46 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -80,27 +80,27 @@ enum icc_count {
 };
 
 struct camss_resources {
+	enum camss_version version;
 	const struct camss_subdev_resources *csiphy_res;
 	const struct camss_subdev_resources *csid_res;
 	const struct camss_subdev_resources *ispif_res;
 	const struct camss_subdev_resources *vfe_res;
 	const struct resources_icc *icc_res;
 	const unsigned int icc_path_num;
+	const unsigned int csiphy_num;
+	const unsigned int csid_num;
+	const unsigned int vfe_num;
+	const unsigned int vfe_lite_num;
 };
 
 struct camss {
-	enum camss_version version;
 	struct v4l2_device v4l2_dev;
 	struct v4l2_async_notifier notifier;
 	struct media_device media_dev;
 	struct device *dev;
-	int csiphy_num;
 	struct csiphy_device *csiphy;
-	int csid_num;
 	struct csid_device *csid;
 	struct ispif_device *ispif;
-	int vfe_num;
-	int vfe_lite_num;
 	struct vfe_device *vfe;
 	atomic_t ref_count;
 	int genpd_num;
@@ -108,6 +108,7 @@ struct camss {
 	struct device_link **genpd_link;
 	struct icc_path *icc_path[ICC_SM8250_COUNT];
 	const struct camss_resources *res;
+	unsigned int vfe_total_num;
 };
 
 struct camss_camera_interface {
-- 
2.42.0

