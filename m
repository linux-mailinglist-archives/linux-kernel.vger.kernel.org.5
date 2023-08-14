Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2865477BE19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHNQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjHNQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:29:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB6170D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so45349835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692030561; x=1692635361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x4ozwHcR60yAzmxM62laa6YE67TcNzLtskHx94XiuY=;
        b=YpxlJXe4KVO2RDw8fcJYaYNJJC7CWElamn3mvs2pqvMbYOyQCC/0ll0Qj7WBxDewOl
         OBKWT8zmo9b41Oj5JgVD3uSqDdAP9RkWHGsLd2UQ/1XnMzkDYeaokv/NYuN6QGbS1CER
         GeJ98fUbi+3SyV7QbtjOpQ+3KfyN7o6eDqMyfAbradj/3B8MNNM3ATwyg0972KrRWFZO
         gC2zPTbQCj3Q5bm4bqLEwnUs54neGPSLGmZcZ1Yduvb0wHFCF5fKfrXj+ogyJCbbQTmF
         ncYVbzmB96ZccwNzQNSNQ2uurPYz9ZWZsTX/unAPnXEAqgd8HmHayz7+pS2uHCTXiilb
         VchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030561; x=1692635361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0x4ozwHcR60yAzmxM62laa6YE67TcNzLtskHx94XiuY=;
        b=HanW8Vzm2Po1RYFUS354luOr3k9uX5JddNc6d4gS8uG+It+6CtwxiVO1o8HmFrAMH6
         26ZzV65BzcMBxYVip2dsIGpT1SCG3Ym123CuKF01q/kImibK1km2JAChY/Q+2lbXteUO
         qCVlpp4h9xzgGyiA57GTyIAy8uRK2+mTzYjIPD9KJK2g8pcxFiTlsItLn7h6Q7voMJZZ
         2vWtVDNcCcD08z9UGOc4Rm3AM3xOnSHYvsBwqe/MLx7WohvkDriL3hbHa2iEQ7yv9NtB
         1oP3p4EKhRUYgGJsdCWfugVoUxMB7bsibOnyhac1jBWeEgWvWqPfDKwEUfDsPG1VUriK
         TJ9Q==
X-Gm-Message-State: AOJu0YwWdcvS8jT9PUk7ddtP07PWb5pZnIH1EpKJRK9QpF3UYjmukqIs
        A9Tw74qdAex1O5kcZ7M7UgDsHg==
X-Google-Smtp-Source: AGHT+IFRjUf4/FBZ1XzLy3z08V2+jeCWAcpcboZxLSnFJW+N5iStTffIDMTH7bSdDtw4eGWbNoPxSQ==
X-Received: by 2002:a05:600c:217:b0:3fe:10d8:e7ef with SMTP id 23-20020a05600c021700b003fe10d8e7efmr9401170wmi.19.1692030561123;
        Mon, 14 Aug 2023 09:29:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fc16ee2864sm14743475wme.48.2023.08.14.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:29:20 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/14] media: qcom: camss: Untangle if/else spaghetti in camss
Date:   Mon, 14 Aug 2023 17:29:02 +0100
Message-ID: <20230814162907.3878421-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
References: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I refuse to add another SoC to this convoluted if/else structure. By the
time we added in a third SoC we ought to have transitioned these control
flow strutures to switches.

Adding in another Soc or two will make some of these if statements into
five clause behemoths.

Introduce switches in the obvious places to despaghetiify.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-csid.c    | 16 ++++---
 .../media/platform/qcom/camss/camss-csiphy.c  | 22 ++++++---
 drivers/media/platform/qcom/camss/camss-vfe.c | 45 +++++++++++++------
 .../media/platform/qcom/camss/camss-video.c   | 16 ++++---
 4 files changed, 68 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 7ff450039ec3f..9e91d9414bebc 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -576,15 +576,19 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 	csid->camss = camss;
 	csid->id = id;
 
-	if (camss->res->version == CAMSS_8x16) {
+	switch (camss->res->version) {
+	case CAMSS_8x16:
 		csid->ops = &csid_ops_4_1;
-	} else if (camss->res->version == CAMSS_8x96 ||
-		   camss->res->version == CAMSS_660) {
+		break;
+	case CAMSS_8x96:
+	case CAMSS_660:
 		csid->ops = &csid_ops_4_7;
-	} else if (camss->res->version == CAMSS_845 ||
-		   camss->res->version == CAMSS_8250) {
+		break;
+	case CAMSS_845:
+	case CAMSS_8250:
 		csid->ops = &csid_ops_gen2;
-	} else {
+		break;
+	default:
 		return -EINVAL;
 	}
 	csid->ops->subdev_init(csid);
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 593aec5c97bc2..0e8c2a59ea241 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -557,21 +557,31 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	csiphy->id = id;
 	csiphy->cfg.combo_mode = 0;
 
-	if (camss->res->version == CAMSS_8x16) {
+	switch (camss->res->version) {
+	case CAMSS_8x16:
+	{
 		csiphy->ops = &csiphy_ops_2ph_1_0;
 		csiphy->formats = csiphy_formats_8x16;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x16);
-	} else if (camss->res->version == CAMSS_8x96 ||
-		   camss->res->version == CAMSS_660) {
+		break;
+	}
+	case CAMSS_8x96:
+	case CAMSS_660:
+	{
 		csiphy->ops = &csiphy_ops_3ph_1_0;
 		csiphy->formats = csiphy_formats_8x96;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x96);
-	} else if (camss->res->version == CAMSS_845 ||
-		   camss->res->version == CAMSS_8250) {
+		break;
+	}
+	case CAMSS_845:
+	case CAMSS_8250:
+	{
 		csiphy->ops = &csiphy_ops_3ph_1_0;
 		csiphy->formats = csiphy_formats_sdm845;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
-	} else {
+		break;
+	}
+	default:
 		return -EINVAL;
 	}
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index b789b3b2e4cfd..8f48401e31cd3 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -170,7 +170,9 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 {
 	struct vfe_device *vfe = to_vfe(line);
 
-	if (vfe->camss->res->version == CAMSS_8x16)
+	switch (vfe->camss->res->version) {
+	case CAMSS_8x16:
+	{
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -218,10 +220,13 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 
 			return sink_code;
 		}
-	else if (vfe->camss->res->version == CAMSS_8x96 ||
-		 vfe->camss->res->version == CAMSS_660 ||
-		 vfe->camss->res->version == CAMSS_845 ||
-		 vfe->camss->res->version == CAMSS_8250)
+		break;
+	}
+	case CAMSS_8x96:
+	case CAMSS_660:
+	case CAMSS_845:
+	case CAMSS_8250:
+	{
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -281,8 +286,12 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 
 			return sink_code;
 		}
-	else
-		return 0;
+		break;
+	}
+	default:
+		break;
+	}
+	return 0;
 }
 
 int vfe_reset(struct vfe_device *vfe)
@@ -1397,7 +1406,9 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		init_completion(&l->output.sof);
 		init_completion(&l->output.reg_update);
 
-		if (camss->res->version == CAMSS_8x16) {
+		switch (camss->res->version) {
+		case CAMSS_8x16:
+		{
 			if (i == VFE_LINE_PIX) {
 				l->formats = formats_pix_8x16;
 				l->nformats = ARRAY_SIZE(formats_pix_8x16);
@@ -1405,8 +1416,11 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 				l->formats = formats_rdi_8x16;
 				l->nformats = ARRAY_SIZE(formats_rdi_8x16);
 			}
-		} else if (camss->res->version == CAMSS_8x96 ||
-			   camss->res->version == CAMSS_660) {
+			break;
+		}
+		case CAMSS_8x96:
+		case CAMSS_660:
+		{
 			if (i == VFE_LINE_PIX) {
 				l->formats = formats_pix_8x96;
 				l->nformats = ARRAY_SIZE(formats_pix_8x96);
@@ -1414,11 +1428,16 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 				l->formats = formats_rdi_8x96;
 				l->nformats = ARRAY_SIZE(formats_rdi_8x96);
 			}
-		} else if (camss->res->version == CAMSS_845 ||
-			   camss->res->version == CAMSS_8250) {
+			break;
+		}
+		case CAMSS_845:
+		case CAMSS_8250:
+		{
 			l->formats = formats_rdi_845;
 			l->nformats = ARRAY_SIZE(formats_rdi_845);
-		} else {
+			break;
+		}
+		default:
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 46a89b5f6c171..e695724437ce1 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -1006,7 +1006,8 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 
 	mutex_init(&video->lock);
 
-	if (video->camss->res->version == CAMSS_8x16) {
+	switch (video->camss->res->version) {
+	case CAMSS_8x16:
 		if (is_pix) {
 			video->formats = formats_pix_8x16;
 			video->nformats = ARRAY_SIZE(formats_pix_8x16);
@@ -1014,8 +1015,9 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 			video->formats = formats_rdi_8x16;
 			video->nformats = ARRAY_SIZE(formats_rdi_8x16);
 		}
-	} else if (video->camss->res->version == CAMSS_8x96 ||
-		   video->camss->res->version == CAMSS_660) {
+		break;
+	case CAMSS_8x96:
+	case CAMSS_660:
 		if (is_pix) {
 			video->formats = formats_pix_8x96;
 			video->nformats = ARRAY_SIZE(formats_pix_8x96);
@@ -1023,11 +1025,13 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 			video->formats = formats_rdi_8x96;
 			video->nformats = ARRAY_SIZE(formats_rdi_8x96);
 		}
-	}  else if (video->camss->res->version == CAMSS_845 ||
-		    video->camss->res->version == CAMSS_8250) {
+		break;
+	case CAMSS_845:
+	case CAMSS_8250:
 		video->formats = formats_rdi_845;
 		video->nformats = ARRAY_SIZE(formats_rdi_845);
-	} else {
+		break;
+	default:
 		ret = -EINVAL;
 		goto error_video_register;
 	}
-- 
2.41.0

