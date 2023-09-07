Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A4379790C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbjIGRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbjIGRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:00:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893D268A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:00:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5007f3d3235so1961736e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105917; x=1694710717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3z4bbmKCuqNXhi6+jCpU8FeEUQHehDy7ati4HRipes=;
        b=eLtqjEfVAPhXppvHZoHBlZl6gJ+qt/3EAiLp9AHyiHe5BSLnuHHhf4iXQgAcNVPc6a
         nkbq0/KONnGlwmS+cxKuCYJ6yDTSBiFb9SZLTgPqYaDah7GxhbHQV067m8ktmCv688wc
         2T0OQpSF8GfHu4E1gBUPSRt6/VcyohH7mqd3fTMbPkXwz+EZOU4Z277IGGlM6G6fnR7Q
         l/4ccVy1d14EidAtpC5ruOblFsBADDWOUbe38C/eXQL6DwdN9h6XOVRnRWBv4VStGnfh
         d/H0DLTFnL0OGQIZT/mDznhg0q+b/4l06GGpUU02AT5YbpxJI2EV+Ba6Rmy7OpJ/mBZe
         gdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105917; x=1694710717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3z4bbmKCuqNXhi6+jCpU8FeEUQHehDy7ati4HRipes=;
        b=uJoPqKruowUzax2mWWHWlEF6Ard/5eeROx4owI7OnbLgV+8MZ62DuSSsBYuEsbErKS
         C4h1Iern4kRKSGbSLaLOUxSNGfDzRtfvmLgrnv+XK1rSWkAV5ufh1eS6LDWDhtRPNP0d
         DQ4UKd75O2jCtkq0j/mxU8x9ZI6ORnN/jQRtuxy928151G1S4DdDXTE2xNwg1xfD4EfD
         O4j+wCm2zbYht/Bqnp3Vofe6o15Nk6IsKXbwqrJTkH8uk7q5R/xMTbEHtbpYi+HOQB7Z
         4Wp9GJ3OPDurMKmfmiQB78o2E74gjawg8eYMbBfb7ab6VE7lksmyxP/RARska/+CF7WX
         kGOw==
X-Gm-Message-State: AOJu0Yw9OU5le0NHpe78VErd0vKPr/D8RDdEDbBZLtUMZvK3/0sIspJt
        Oj4CAKWGK2InpLNMfmVO6WeuK4lFuEyzhxDg7RA=
X-Google-Smtp-Source: AGHT+IFz0apguPB/MYG7ETDtmZBWdV5vuxGZYZXDuL7reHJRxxEyuYfa01oTpLf/Vc5mFNN/Dk4Zcw==
X-Received: by 2002:adf:ce05:0:b0:31c:6525:770d with SMTP id p5-20020adfce05000000b0031c6525770dmr11658wrn.1.1694105067571;
        Thu, 07 Sep 2023 09:44:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm23822145wrr.49.2023.09.07.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:44:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/17] media: qcom: camss: Untangle if/else spaghetti in camss
Date:   Thu,  7 Sep 2023 17:44:03 +0100
Message-ID: <20230907164410.36651-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a very convoluted if/else legacy here which needs to be
rationalised to make it more sustainable.

Adding in another Soc or two will make some of these if statements into
increasingly large multi-clause behemoths.

Introduce switches in the obvious places to despaghetiify.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../media/platform/qcom/camss/camss-csiphy.c  | 16 +++++----
 drivers/media/platform/qcom/camss/camss-vfe.c | 33 +++++++++++--------
 .../media/platform/qcom/camss/camss-video.c   | 17 +++++-----
 3 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 4310a132dcbe2..18f9a4defb2a4 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -558,19 +558,21 @@ int msm_csiphy_subdev_init(struct camss *camss,
 	csiphy->cfg.combo_mode = 0;
 	csiphy->ops = res->ops;
 
-	if (camss->res->version == CAMSS_8x16) {
+	switch (camss->res->version) {
+	case CAMSS_8x16:
 		csiphy->formats = csiphy_formats_8x16;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x16);
-	} else if (camss->res->version == CAMSS_8x96 ||
-		   camss->res->version == CAMSS_660) {
+		break;
+	case CAMSS_8x96:
+	case CAMSS_660:
 		csiphy->formats = csiphy_formats_8x96;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x96);
-	} else if (camss->res->version == CAMSS_845 ||
-		   camss->res->version == CAMSS_8250) {
+		break;
+	case CAMSS_845:
+	case CAMSS_8250:
 		csiphy->formats = csiphy_formats_sdm845;
 		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
-	} else {
-		return -EINVAL;
+		break;
 	}
 
 	/* Memory */
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 4d5c32d3dddbf..db8f68819ded9 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -170,7 +170,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 {
 	struct vfe_device *vfe = to_vfe(line);
 
-	if (vfe->camss->res->version == CAMSS_8x16)
+	switch (vfe->camss->res->version) {
+	case CAMSS_8x16:
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -218,10 +219,11 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 
 			return sink_code;
 		}
-	else if (vfe->camss->res->version == CAMSS_8x96 ||
-		 vfe->camss->res->version == CAMSS_660 ||
-		 vfe->camss->res->version == CAMSS_845 ||
-		 vfe->camss->res->version == CAMSS_8250)
+		break;
+	case CAMSS_8x96:
+	case CAMSS_660:
+	case CAMSS_845:
+	case CAMSS_8250:
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
 		{
@@ -281,8 +283,9 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 
 			return sink_code;
 		}
-	else
-		return 0;
+		break;
+	}
+	return 0;
 }
 
 int vfe_reset(struct vfe_device *vfe)
@@ -1379,7 +1382,8 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 		init_completion(&l->output.sof);
 		init_completion(&l->output.reg_update);
 
-		if (camss->res->version == CAMSS_8x16) {
+		switch (camss->res->version) {
+		case CAMSS_8x16:
 			if (i == VFE_LINE_PIX) {
 				l->formats = formats_pix_8x16;
 				l->nformats = ARRAY_SIZE(formats_pix_8x16);
@@ -1387,8 +1391,9 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 				l->formats = formats_rdi_8x16;
 				l->nformats = ARRAY_SIZE(formats_rdi_8x16);
 			}
-		} else if (camss->res->version == CAMSS_8x96 ||
-			   camss->res->version == CAMSS_660) {
+			break;
+		case CAMSS_8x96:
+		case CAMSS_660:
 			if (i == VFE_LINE_PIX) {
 				l->formats = formats_pix_8x96;
 				l->nformats = ARRAY_SIZE(formats_pix_8x96);
@@ -1396,12 +1401,12 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 				l->formats = formats_rdi_8x96;
 				l->nformats = ARRAY_SIZE(formats_rdi_8x96);
 			}
-		} else if (camss->res->version == CAMSS_845 ||
-			   camss->res->version == CAMSS_8250) {
+			break;
+		case CAMSS_845:
+		case CAMSS_8250:
 			l->formats = formats_rdi_845;
 			l->nformats = ARRAY_SIZE(formats_rdi_845);
-		} else {
-			return -EINVAL;
+			break;
 		}
 	}
 
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 46a89b5f6c171..a89da5ef47109 100644
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
@@ -1023,13 +1025,12 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
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
-		ret = -EINVAL;
-		goto error_video_register;
+		break;
 	}
 
 	ret = msm_video_init_format(video);
-- 
2.41.0

