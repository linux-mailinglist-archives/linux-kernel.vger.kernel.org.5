Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFB7E1598
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKERpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjKERpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:45:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:45:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859c464daso27864275e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 09:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699206309; x=1699811109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOdiUJmEPnovv7huGull2/1/i6yjUoXYCLLeBsJfSRM=;
        b=WCfZyME0gfSgZKPGA5EyHS73Vja068JgYNn1TFHDnC+zex30FN+R/KZVpl2o4mfuOn
         niMK9Br3mF8jD1grgLkO0w0xd+txyitJsqaMU3TWAgUR6CkiOJbgMyIsKPyjD+XZf9+S
         O5O8ZFapHMtxUCe2un0q10triGOL0wkbTZXnwouF0lvys28dWZXy2LYivJDbh08tPORZ
         g+LB2OPRrtTEivYPAg8UbpGeO8iEimsEqqAe24Xd49Phz8bIA/ipIElkBsYsQ5cehzvE
         GLxy5oM65hLwKqiwSFK5+IioFPOnEKaqlL1sM7IKSsF7p5zvnPSB0uv8BDiIzUnDa26+
         Lssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699206309; x=1699811109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOdiUJmEPnovv7huGull2/1/i6yjUoXYCLLeBsJfSRM=;
        b=qrJm6rQWOj6XOAmDOhMEVtVXi3X/2UVu1DZr2jGlO2dyc0sQ9nH71K0jZZ0R6qG4z5
         w38lLBSZevu94/SyzTUeaymdDd2ouWQmYAVNibXDpz+9cV+5D0fgGPtp9m88vV52gPu/
         C80SLcgJWLgurMSpiDeICIIb4VmlOYD9dEn+xHX3TPErVnLKWomf7ldFXUbHLt/J/CS8
         sxtfHVhxOAY75OgAiCZ9LNmJy1SVgj9uDQhpmbCZuFti5BINKQ8BURauAC+0MDV5J1A4
         w+2GaHw/3Jiz3FNPZe8PPoyz7BZXGg67XedoWM5tfpibWGDTwxdtsS6Bz3pyKekM+ff/
         btCQ==
X-Gm-Message-State: AOJu0YyfdU19UmovaYe56eHlppO9b12GTyEsakiwFnutEZykxJLNWJyF
        TmQGKzOmsV7fqeAGBonYXdmgsA==
X-Google-Smtp-Source: AGHT+IFRIKKqxVH6W/RxbcfLe7D1ZuXGOvdHWvbBvsBwP/Qec//ANrLzw03yMaY99ZonZSRNPmc0Sw==
X-Received: by 2002:a05:600c:4748:b0:408:53d4:52dd with SMTP id w8-20020a05600c474800b0040853d452ddmr21226803wmo.22.1699206309546;
        Sun, 05 Nov 2023 09:45:09 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b004064ac107cfsm9553346wmq.39.2023.11.05.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:45:09 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Sun, 05 Nov 2023 17:45:04 +0000
Subject: [PATCH v3 5/6] media: qcom: camss: Add sc8280xp support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-b4-camss-sc8280xp-v3-5-4b3c372ff0f4@linaro.org>
References: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
In-Reply-To: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in functional logic throughout the code to support the sc8280xp.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 23 +++++++++++++++++---
 drivers/media/platform/qcom/camss/camss-csiphy.c   |  1 +
 drivers/media/platform/qcom/camss/camss-vfe.c      | 25 +++++++++++++++++-----
 drivers/media/platform/qcom/camss/camss-video.c    |  1 +
 4 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index 2eb3531ffd00b..2810d0fa06c13 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -513,6 +513,10 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
 		r = &lane_regs_sm8250[0][0];
 		array_size = ARRAY_SIZE(lane_regs_sm8250[0]);
 		break;
+	case CAMSS_8280XP:
+		r = &lane_regs_sc8280xp[0][0];
+		array_size = ARRAY_SIZE(lane_regs_sc8280xp[0]);
+		break;
 	default:
 		WARN(1, "unknown cspi version\n");
 		return;
@@ -548,13 +552,26 @@ static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
 	return lane_mask;
 }
 
+static bool csiphy_is_gen2(u32 version)
+{
+	bool ret = false;
+
+	switch (version) {
+	case CAMSS_845:
+	case CAMSS_8250:
+	case CAMSS_8280XP:
+		ret = true;
+		break;
+	}
+
+	return ret;
+}
+
 static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 				struct csiphy_config *cfg,
 				s64 link_freq, u8 lane_mask)
 {
 	struct csiphy_lanes_cfg *c = &cfg->csi2->lane_cfg;
-	bool is_gen2 = (csiphy->camss->res->version == CAMSS_845 ||
-			csiphy->camss->res->version == CAMSS_8250);
 	u8 settle_cnt;
 	u8 val;
 	int i;
@@ -576,7 +593,7 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 	val = 0x00;
 	writel_relaxed(val, csiphy->base + CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(0));
 
-	if (is_gen2)
+	if (csiphy_is_gen2(csiphy->camss->res->version))
 		csiphy_gen2_config_lanes(csiphy, settle_cnt);
 	else
 		csiphy_gen1_config_lanes(csiphy, cfg, settle_cnt);
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index edd573606a6ae..8241acf789865 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -579,6 +579,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 		break;
 	case CAMSS_845:
 	case CAMSS_8250:
+	case CAMSS_8280XP:
 		csiphy->formats = csiphy_formats_sdm845;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
 		break;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 50929c3cbb831..28cf63af1ec08 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -225,6 +225,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_660:
 	case CAMSS_845:
 	case CAMSS_8250:
+	case CAMSS_8280XP:
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -1522,6 +1523,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 			break;
 		case CAMSS_845:
 		case CAMSS_8250:
+		case CAMSS_8280XP:
 			l->formats = formats_rdi_845;
 			l->nformats = ARRAY_SIZE(formats_rdi_845);
 			break;
@@ -1600,6 +1602,23 @@ static const struct media_entity_operations vfe_media_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
+static int vfe_bpl_align(struct vfe_device *vfe)
+{
+	int ret = 8;
+
+	switch (vfe->camss->res->version) {
+	case CAMSS_845:
+	case CAMSS_8250:
+	case CAMSS_8280XP:
+		ret = 16;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 /*
  * msm_vfe_register_entities - Register subdev node for VFE module
  * @vfe: VFE device
@@ -1666,11 +1685,7 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
 		}
 
 		video_out->ops = &vfe->video_ops;
-		if (vfe->camss->res->version == CAMSS_845 ||
-		    vfe->camss->res->version == CAMSS_8250)
-			video_out->bpl_alignment = 16;
-		else
-			video_out->bpl_alignment = 8;
+		video_out->bpl_alignment = vfe_bpl_align(vfe);
 		video_out->line_based = 0;
 		if (i == VFE_LINE_PIX) {
 			video_out->bpl_alignment = 16;
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index a89da5ef47109..54cd82f741154 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -1028,6 +1028,7 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 		break;
 	case CAMSS_845:
 	case CAMSS_8250:
+	case CAMSS_8280XP:
 		video->formats = formats_rdi_845;
 		video->nformats = ARRAY_SIZE(formats_rdi_845);
 		break;

-- 
2.42.0

