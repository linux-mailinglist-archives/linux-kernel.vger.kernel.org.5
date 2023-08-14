Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8A77BE16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjHNQ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjHNQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:29:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13557E6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so31817925e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692030557; x=1692635357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzg3X0plNFdFq8mogDfi/ytxmVpikMwYLKMn9LJIoqc=;
        b=A+lz2e/yJYhSTpjM4QTBwBcI/HJiJHRCgKpARFQVfFYd547Ow5xr/1Z0jB/u/VyqG1
         GogFga1kpkoU7w6V3BwFu/YDDbJXkpLUZruZh9zHFbq3SQ85YZsSm2xcgoAKxMIwDHpW
         BmiDDgOw3d9dEMrwsmXTvarHv2cSyNZKfx8vhWb9RmrSvKg/1sVvkTiV1z6qYk4SxUy2
         3MNv8g1ni5BDflDXlQsyuHQFdXO/Dhdsod5zM18lWvc2j+TlgIU3ozc7MOnze+gsYx2c
         07RZ4Eg8tKYe0cOMpkAzCruzpYkaGYF5hTZqtexolynvzmTRCut9P88tXils91Ssczj9
         Xp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030557; x=1692635357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pzg3X0plNFdFq8mogDfi/ytxmVpikMwYLKMn9LJIoqc=;
        b=lYG8omQR4JVQD5YUc5EbQBwFzJakwfn7HLE5AelSuIUPq3Zrv7imwUJhW0ogIr7HFm
         TUt9rSLlPdavQGEpUOLvqSwQJOYhTXsatbbdReY60IJspYIbtXhvXelV9cF1MVuVHE7a
         qJELFNnp5GLfQC6LwZFepI8OYHc0Tr5609irdeQAAOX7LfuYtrPZyBFAgDFjUVNdQzTb
         KadXIdX6jh8T2d3a/rP1Km1uC8CDkKsitaxi/yoiHpzkq1+7Cn6iG1toX7yKllSq8554
         4Asoe0BfjQPdSDztyfmVrKEYdSFzf+PumWwd9qHt4TcbRBkR0gLIfB+uPSPGdz/NYLzr
         G2dQ==
X-Gm-Message-State: AOJu0Yz2csjeocXyFGOxsZfYGR/+rR+xG5IbjqdFdBG5EBAdSq9lCqy3
        NpW5wXt0+4o2HH5JLncpb7fr3w==
X-Google-Smtp-Source: AGHT+IGCE/S1HGeyrWeVSUblNVi41GPzkNKxzQcqCVRl/C7e/4Sb5u6qZftXED+TenOd5rtLjqKGGA==
X-Received: by 2002:a05:600c:820:b0:3fe:4c29:e626 with SMTP id k32-20020a05600c082000b003fe4c29e626mr10259595wmp.13.1692030557621;
        Mon, 14 Aug 2023 09:29:17 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fc16ee2864sm14743475wme.48.2023.08.14.09.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:29:17 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/14] media: qcom: camss: Pass line_num from compat resources
Date:   Mon, 14 Aug 2023 17:28:59 +0100
Message-ID: <20230814162907.3878421-7-bryan.odonoghue@linaro.org>
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

line_num indicates the number of RDI - raw data interface channels which
are associated with a given IFE/VFE - image/video front end.

On several SoCs the RDI number is not static for each VFE - for example
on sm8250 VFE Lite has four RDIs where regular VFE has three.

Assigning line_num statically in the subdev_init() phase initialises
each VFE to the lower number, meaning in practical terms that we are
lobbing off one RDI on some VFEs.

Interrupt handling uses static for (i = RDI0; i < RDI2; i++) {} in some
of our VFE blocks but this can't work for situations where we have a
mixture of VFE @ 3 RDI and VFE-lite @ 4 RDI blocks.

First step to remediate is to pass line_num from a compat string
controlled data-structure and do so on a per-VFE basis.

Later patches will assign the correct number of RDI blocks per VFE.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-vfe-170.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-4-1.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-4-7.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-4-8.c |  2 --
 .../media/platform/qcom/camss/camss-vfe-480.c |  1 -
 drivers/media/platform/qcom/camss/camss-vfe.c |  5 +++
 drivers/media/platform/qcom/camss/camss.c     | 36 ++++++++++++-------
 drivers/media/platform/qcom/camss/camss.h     |  1 +
 8 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 9905bb06b3823..8aa921400ded0 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -756,8 +756,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 {
 	vfe->isr_ops = vfe_isr_ops_170;
 	vfe->video_ops = vfe_video_ops_170;
-
-	vfe->line_num = VFE_LINE_NUM_GEN2;
 }
 
 const struct vfe_hw_ops vfe_ops_170 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index bc309f326f519..2911e4126e7ad 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -992,8 +992,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 	vfe->isr_ops = vfe_isr_ops_gen1;
 	vfe->ops_gen1 = &vfe_ops_gen1_4_1;
 	vfe->video_ops = vfe_video_ops_gen1;
-
-	vfe->line_num = VFE_LINE_NUM_GEN1;
 }
 
 const struct vfe_hw_ops vfe_ops_4_1 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 8acd76c9746ba..b65ed0fef595e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1188,8 +1188,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 	vfe->isr_ops = vfe_isr_ops_gen1;
 	vfe->ops_gen1 = &vfe_ops_gen1_4_7;
 	vfe->video_ops = vfe_video_ops_gen1;
-
-	vfe->line_num = VFE_LINE_NUM_GEN1;
 }
 
 const struct vfe_hw_ops vfe_ops_4_7 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index 3a0167ecf873a..7b3805177f037 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -1173,8 +1173,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 	vfe->isr_ops = vfe_isr_ops_gen1;
 	vfe->ops_gen1 = &vfe_ops_gen1_4_8;
 	vfe->video_ops = vfe_video_ops_gen1;
-
-	vfe->line_num = VFE_LINE_NUM_GEN1;
 }
 
 const struct vfe_hw_ops vfe_ops_4_8 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index 80338efceb9e1..b1a07e846e25b 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -572,7 +572,6 @@ static const struct camss_video_ops vfe_video_ops_480 = {
 static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
 {
 	vfe->video_ops = vfe_video_ops_480;
-	vfe->line_num = MAX_VFE_OUTPUT_LINES;
 }
 
 const struct vfe_hw_ops vfe_ops_480 = {
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 526dd4ab343fe..b789b3b2e4cfd 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1305,6 +1305,11 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	default:
 		return -EINVAL;
 	}
+
+	if (!res->line_num)
+		return -EINVAL;
+
+	vfe->line_num = res->line_num;
 	vfe->ops->subdev_init(dev, vfe);
 
 	/* Memory */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index e257559472323..0e39d123a2113 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -123,7 +123,8 @@ static const struct resources vfe_res_8x16[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	}
 };
 
@@ -263,7 +264,8 @@ static const struct resources vfe_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	},
 
 	/* VFE1 */
@@ -281,7 +283,8 @@ static const struct resources vfe_res_8x96[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	}
 };
 
@@ -442,7 +445,8 @@ static const struct resources vfe_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	},
 
 	/* VFE1 */
@@ -463,7 +467,8 @@ static const struct resources vfe_res_660[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = VFE_LINE_NUM_GEN1,
 	}
 };
 
@@ -621,7 +626,8 @@ static const struct resources vfe_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = VFE_LINE_NUM_GEN2,
 	},
 
 	/* VFE1 */
@@ -641,7 +647,8 @@ static const struct resources vfe_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = VFE_LINE_NUM_GEN2,
 	},
 
 	/* VFE-lite */
@@ -660,7 +667,8 @@ static const struct resources vfe_res_845[] = {
 				{ 19200000, 75000000, 384000000, 538666667 },
 				{ 384000000 } },
 		.reg = { "vfe_lite" },
-		.interrupt = { "vfe_lite" }
+		.interrupt = { "vfe_lite" },
+		.line_num = VFE_LINE_NUM_GEN2,
 	}
 };
 
@@ -787,7 +795,8 @@ static const struct resources vfe_res_8250[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe0" },
-		.interrupt = { "vfe0" }
+		.interrupt = { "vfe0" },
+		.line_num = 4,
 	},
 	/* VFE1 */
 	{
@@ -805,7 +814,8 @@ static const struct resources vfe_res_8250[] = {
 				{ 0 },
 				{ 0 } },
 		.reg = { "vfe1" },
-		.interrupt = { "vfe1" }
+		.interrupt = { "vfe1" },
+		.line_num = 4,
 	},
 	/* VFE2 (lite) */
 	{
@@ -822,7 +832,8 @@ static const struct resources vfe_res_8250[] = {
 				{ 400000000, 480000000 },
 				{ 0 } },
 		.reg = { "vfe_lite0" },
-		.interrupt = { "vfe_lite0" }
+		.interrupt = { "vfe_lite0" },
+		.line_num = 4,
 	},
 	/* VFE3 (lite) */
 	{
@@ -839,7 +850,8 @@ static const struct resources vfe_res_8250[] = {
 				{ 400000000, 480000000 },
 				{ 0 } },
 		.reg = { "vfe_lite1" },
-		.interrupt = { "vfe_lite1" }
+		.interrupt = { "vfe_lite1" },
+		.line_num = 4,
 	},
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index dd8c58d349685..101ce6e527931 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -48,6 +48,7 @@ struct resources {
 	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
 	char *reg[CAMSS_RES_MAX];
 	char *interrupt[CAMSS_RES_MAX];
+	u8 line_num;
 };
 
 struct icc_bw_tbl {
-- 
2.41.0

