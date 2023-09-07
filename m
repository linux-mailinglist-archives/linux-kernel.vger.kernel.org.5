Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7945C7978B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbjIGQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245230AbjIGQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:53:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660711FD2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:52:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50078eba7afso2040095e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105503; x=1694710303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV8KpdoQDRQ8tjtNRjv68+ye669LLw2wjvu1wdeDVe4=;
        b=XIYvG04PynqQhSt+labddIArzImXIi2aHp4zIgrbbJRdTZ8XZbKUUA6o7xVPrl/GVw
         Fy+Q472rRaZIjGK6X6vL/4lOLh4izrAHw5SHgeXDE2+OB8tx1WPGszH24qk0t05UaFDV
         tgS7xgY6h4zMHevZDu8SRFYERYvP3/Z6RfL2urd9yvZfe71p5RG9e0VDq+oqTUIBT6+f
         H45d0aQoJAlmqv7Z0J6wumyRjbGPLPXRRnRActPXWBE5V1BkixPkdwym50vLZi0oZ8wG
         VJc+u3o732YWaKplxhUUDjXqyTsklhBBOChImAugFAgNmpMnvBPRvmMQAnjZ8ffIwqXE
         Rh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105503; x=1694710303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV8KpdoQDRQ8tjtNRjv68+ye669LLw2wjvu1wdeDVe4=;
        b=JAi2EaG83SjNGOjpmBZrlsg49p1bjMJbgbBq5CNyxm2XFfqis5JzPbIQQWx9SmbgSN
         Sk5ipooFwm8kCyVkGJfiOZCHNMZo8CIaKeJy302r15Oq0iX0AezBPAqBIH9fPPnWXKsm
         PQy26ijzvLTfMRrAO1TaqnoytrGl574PZpNiP0aBaOQW5myY4QyhxETRyuIuuO9Qyu7l
         PfV9PYU0iQT5Rw7sZi38VQG2+EHHGaYYtV+0XBOEZiXGnk+0TWc3f9i+vqzPQRNDuKI5
         cWge6a+/R2ESi2+Z2zNt+opNWcbduLlnWBbIG0t5H32Q/oXGJY2fBu858Vyn5/rpWi/x
         rgfA==
X-Gm-Message-State: AOJu0Yzexnnvt2JeKWp+TJP1jE5S8cb3AO6B7FWtDm8AC7EkXKFmzKEg
        fC13jqYJyhJ+5/8sOOh2S4duXrUnWRiXhIbUKls=
X-Google-Smtp-Source: AGHT+IE0XVCmwr0SmJJDDwCcla6gpiZj2pDgHCPdPQpxz2U8YdFgYjywz92eZNDZGtB8BErh4/8RYQ==
X-Received: by 2002:a7b:cbcf:0:b0:3fb:fa9f:5292 with SMTP id n15-20020a7bcbcf000000b003fbfa9f5292mr171840wmi.25.1694105055741;
        Thu, 07 Sep 2023 09:44:15 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm23822145wrr.49.2023.09.07.09.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:44:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/17] media: qcom: camss: Rename camss struct resources to camss_subdev_resources
Date:   Thu,  7 Sep 2023 17:43:55 +0100
Message-ID: <20230907164410.36651-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
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

Rename non-specific struct resources {} to struct camss_subdev_resources {}

Each logical block in CAMSS has a number of regulators, clocks and resets
associated with it. We represent these blocks as v4l subdevices.

The name "struct camss_subdev_resources" is a more descriptive and accurate
name.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-csid.c    |  2 +-
 .../media/platform/qcom/camss/camss-csid.h    |  4 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  2 +-
 .../media/platform/qcom/camss/camss-csiphy.h  |  4 +-
 .../media/platform/qcom/camss/camss-ispif.c   |  2 +-
 .../media/platform/qcom/camss/camss-ispif.h   |  4 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |  2 +-
 drivers/media/platform/qcom/camss/camss-vfe.h |  4 +-
 drivers/media/platform/qcom/camss/camss.c     | 44 +++++++++----------
 drivers/media/platform/qcom/camss/camss.h     |  2 +-
 10 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 9d7fb1adebb98..b1113decdb305 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -566,7 +566,7 @@ static const struct v4l2_ctrl_ops csid_ctrl_ops = {
  * Return 0 on success or a negative error code otherwise
  */
 int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
-			 const struct resources *res, u8 id)
+			 const struct camss_subdev_resources *res, u8 id)
 {
 	struct device *dev = camss->dev;
 	struct platform_device *pdev = to_platform_device(dev);
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index d4b48432a0973..30d94eb2eb041 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -172,7 +172,7 @@ struct csid_device {
 	const struct csid_hw_ops *ops;
 };
 
-struct resources;
+struct camss_subdev_resources;
 
 /*
  * csid_find_code - Find a format code in an array using array index or format code
@@ -200,7 +200,7 @@ const struct csid_format *csid_get_fmt_entry(const struct csid_format *formats,
 					     u32 code);
 
 int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
-			 const struct resources *res, u8 id);
+			 const struct camss_subdev_resources *res, u8 id);
 
 int msm_csid_register_entity(struct csid_device *csid,
 			     struct v4l2_device *v4l2_dev);
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index c5ae9c61ee0b1..b1b6c4cf18385 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -546,7 +546,7 @@ static int csiphy_init_formats(struct v4l2_subdev *sd,
  */
 int msm_csiphy_subdev_init(struct camss *camss,
 			   struct csiphy_device *csiphy,
-			   const struct resources *res, u8 id)
+			   const struct camss_subdev_resources *res, u8 id)
 {
 	struct device *dev = camss->dev;
 	struct platform_device *pdev = to_platform_device(dev);
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index 1c14947f92d35..c9b7fe82b1f0d 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -83,11 +83,11 @@ struct csiphy_device {
 	unsigned int nformats;
 };
 
-struct resources;
+struct camss_subdev_resources;
 
 int msm_csiphy_subdev_init(struct camss *camss,
 			   struct csiphy_device *csiphy,
-			   const struct resources *res, u8 id);
+			   const struct camss_subdev_resources *res, u8 id);
 
 int msm_csiphy_register_entity(struct csiphy_device *csiphy,
 			       struct v4l2_device *v4l2_dev);
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 61765b874b9a2..75b8a60806b22 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -1095,7 +1095,7 @@ static int ispif_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
  * Return 0 on success or a negative error code otherwise
  */
 int msm_ispif_subdev_init(struct camss *camss,
-			  const struct resources *res)
+			  const struct camss_subdev_resources *res)
 {
 	struct device *dev = camss->dev;
 	struct ispif_device *ispif = camss->ispif;
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.h b/drivers/media/platform/qcom/camss/camss-ispif.h
index c7c41f7afcaad..dff6d5b35c72e 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.h
+++ b/drivers/media/platform/qcom/camss/camss-ispif.h
@@ -66,10 +66,10 @@ struct ispif_device {
 	struct camss *camss;
 };
 
-struct resources;
+struct camss_subdev_resources;
 
 int msm_ispif_subdev_init(struct camss *camss,
-			  const struct resources *res);
+			  const struct camss_subdev_resources *res);
 
 int msm_ispif_register_entities(struct ispif_device *ispif,
 				struct v4l2_device *v4l2_dev);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index b021f81cef123..e84dcf0f4b2da 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1279,7 +1279,7 @@ static int vfe_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
  * Return 0 on success or a negative error code otherwise
  */
 int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
-			const struct resources *res, u8 id)
+			const struct camss_subdev_resources *res, u8 id)
 {
 	struct device *dev = camss->dev;
 	struct platform_device *pdev = to_platform_device(dev);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index cbc314c4e244b..b4bae9f65c68f 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -153,10 +153,10 @@ struct vfe_device {
 	struct camss_video_ops video_ops;
 };
 
-struct resources;
+struct camss_subdev_resources;
 
 int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
-			const struct resources *res, u8 id);
+			const struct camss_subdev_resources *res, u8 id);
 
 int msm_vfe_register_entities(struct vfe_device *vfe,
 			      struct v4l2_device *v4l2_dev);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index fa0eb30d77c26..718ef8e4f5938 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -31,7 +31,7 @@
 #define CAMSS_CLOCK_MARGIN_NUMERATOR 105
 #define CAMSS_CLOCK_MARGIN_DENOMINATOR 100
 
-static const struct resources csiphy_res_8x16[] = {
+static const struct camss_subdev_resources csiphy_res_8x16[] = {
 	/* CSIPHY0 */
 	{
 		.regulators = {},
@@ -57,7 +57,7 @@ static const struct resources csiphy_res_8x16[] = {
 	}
 };
 
-static const struct resources csid_res_8x16[] = {
+static const struct camss_subdev_resources csid_res_8x16[] = {
 	/* CSID0 */
 	{
 		.regulators = { "vdda" },
@@ -93,7 +93,7 @@ static const struct resources csid_res_8x16[] = {
 	},
 };
 
-static const struct resources ispif_res_8x16 = {
+static const struct camss_subdev_resources ispif_res_8x16 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
@@ -104,7 +104,7 @@ static const struct resources ispif_res_8x16 = {
 
 };
 
-static const struct resources vfe_res_8x16[] = {
+static const struct camss_subdev_resources vfe_res_8x16[] = {
 	/* VFE0 */
 	{
 		.regulators = {},
@@ -126,7 +126,7 @@ static const struct resources vfe_res_8x16[] = {
 	}
 };
 
-static const struct resources csiphy_res_8x96[] = {
+static const struct camss_subdev_resources csiphy_res_8x96[] = {
 	/* CSIPHY0 */
 	{
 		.regulators = {},
@@ -164,7 +164,7 @@ static const struct resources csiphy_res_8x96[] = {
 	}
 };
 
-static const struct resources csid_res_8x96[] = {
+static const struct camss_subdev_resources csid_res_8x96[] = {
 	/* CSID0 */
 	{
 		.regulators = { "vdda" },
@@ -234,7 +234,7 @@ static const struct resources csid_res_8x96[] = {
 	}
 };
 
-static const struct resources ispif_res_8x96 = {
+static const struct camss_subdev_resources ispif_res_8x96 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
@@ -246,7 +246,7 @@ static const struct resources ispif_res_8x96 = {
 	.interrupt = { "ispif" }
 };
 
-static const struct resources vfe_res_8x96[] = {
+static const struct camss_subdev_resources vfe_res_8x96[] = {
 	/* VFE0 */
 	{
 		.regulators = {},
@@ -284,7 +284,7 @@ static const struct resources vfe_res_8x96[] = {
 	}
 };
 
-static const struct resources csiphy_res_660[] = {
+static const struct camss_subdev_resources csiphy_res_660[] = {
 	/* CSIPHY0 */
 	{
 		.regulators = {},
@@ -328,7 +328,7 @@ static const struct resources csiphy_res_660[] = {
 	}
 };
 
-static const struct resources csid_res_660[] = {
+static const struct camss_subdev_resources csid_res_660[] = {
 	/* CSID0 */
 	{
 		.regulators = { "vdda", "vdd_sec" },
@@ -410,7 +410,7 @@ static const struct resources csid_res_660[] = {
 	}
 };
 
-static const struct resources ispif_res_660 = {
+static const struct camss_subdev_resources ispif_res_660 = {
 	/* ISPIF */
 	.clock = { "top_ahb", "ahb", "ispif_ahb",
 		   "csi0", "csi0_pix", "csi0_rdi",
@@ -422,7 +422,7 @@ static const struct resources ispif_res_660 = {
 	.interrupt = { "ispif" }
 };
 
-static const struct resources vfe_res_660[] = {
+static const struct camss_subdev_resources vfe_res_660[] = {
 	/* VFE0 */
 	{
 		.regulators = {},
@@ -466,7 +466,7 @@ static const struct resources vfe_res_660[] = {
 	}
 };
 
-static const struct resources csiphy_res_845[] = {
+static const struct camss_subdev_resources csiphy_res_845[] = {
 	/* CSIPHY0 */
 	{
 		.regulators = {},
@@ -540,7 +540,7 @@ static const struct resources csiphy_res_845[] = {
 	}
 };
 
-static const struct resources csid_res_845[] = {
+static const struct camss_subdev_resources csid_res_845[] = {
 	/* CSID0 */
 	{
 		.regulators = { "vdda-phy", "vdda-pll" },
@@ -602,7 +602,7 @@ static const struct resources csid_res_845[] = {
 	}
 };
 
-static const struct resources vfe_res_845[] = {
+static const struct camss_subdev_resources vfe_res_845[] = {
 	/* VFE0 */
 	{
 		.regulators = {},
@@ -663,7 +663,7 @@ static const struct resources vfe_res_845[] = {
 	}
 };
 
-static const struct resources csiphy_res_8250[] = {
+static const struct camss_subdev_resources csiphy_res_8250[] = {
 	/* CSIPHY0 */
 	{
 		.regulators = {},
@@ -720,7 +720,7 @@ static const struct resources csiphy_res_8250[] = {
 	}
 };
 
-static const struct resources csid_res_8250[] = {
+static const struct camss_subdev_resources csid_res_8250[] = {
 	/* CSID0 */
 	{
 		.regulators = { "vdda-phy", "vdda-pll" },
@@ -769,7 +769,7 @@ static const struct resources csid_res_8250[] = {
 	}
 };
 
-static const struct resources vfe_res_8250[] = {
+static const struct camss_subdev_resources vfe_res_8250[] = {
 	/* VFE0 */
 	{
 		.regulators = {},
@@ -1120,10 +1120,10 @@ static int camss_of_parse_ports(struct camss *camss)
  */
 static int camss_init_subdevices(struct camss *camss)
 {
-	const struct resources *csiphy_res;
-	const struct resources *csid_res;
-	const struct resources *ispif_res;
-	const struct resources *vfe_res;
+	const struct camss_subdev_resources *csiphy_res;
+	const struct camss_subdev_resources *csid_res;
+	const struct camss_subdev_resources *ispif_res;
+	const struct camss_subdev_resources *vfe_res;
 	unsigned int i;
 	int ret;
 
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index e95211cdb1fd6..9d6ba7b17ff02 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -41,7 +41,7 @@
 
 #define CAMSS_RES_MAX 17
 
-struct resources {
+struct camss_subdev_resources {
 	char *regulators[CAMSS_RES_MAX];
 	char *clock[CAMSS_RES_MAX];
 	char *clock_for_reset[CAMSS_RES_MAX];
-- 
2.41.0

