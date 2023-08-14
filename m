Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB877BCAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjHNPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjHNPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD718F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso5670905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025969; x=1692630769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3guWzZn/6c5CIoZe7iyvq9mt4EnNY7G4PvY6L/0SGU=;
        b=vR3s4dOl1Lu5ALhgMmPvZzkP0TTEDoGBZjA2cuvSpgS5i8MdaLEjCffnROwuStBZr9
         D7DrYzHdQNTKJ0tXzHEwNPyK/mT9eR4aIrUTmtRawCqfkogs2T0+/6KUaUq1UoYb38/G
         Ag9O8QDfwW49CisDs1AWArqVc7XTQfe3PeMg5ZPpun3NbPqMLCbed5Zw+tFR/spZ+DHJ
         /Pil94RJnpzRqG1vOdepYKdIin2PPIhT3oUx6NvNmMoERmEpbhoy96Zbf6+il7izGpEQ
         8/aFt7NVZrrOPcWECAoLDHbN+W2TPXuInaaknDR1ftW2Lq1PbqmNkhQqsYROK2sjfJDb
         0x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025969; x=1692630769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3guWzZn/6c5CIoZe7iyvq9mt4EnNY7G4PvY6L/0SGU=;
        b=MrYFxMB0nDsXC2ZCheWDfBUk34SUZymNH/2oDd6eCJa8FUW9uuFXLZ7bWrDvB0wZdn
         zRj8qK/xyVJBnGFR4VUK2ucmcF6kXYMgV1mTLMPaw4AcQ/ms88Fr8ub5pyXpR6LRE5rw
         ImXXGtTIyqgQdd2HwTKXEmFljaXYKfnB0OD5Mgrx75Ob7avfAOkZ1/eFLiu2uViUgaYF
         zChStwZf8Mr/nRIkKhl1JKOn7Ira7NhHANZYiRQ7uu8mQ9/5i2L0ekPc3caeXJcAySaN
         KdieSoNTJxtZxh4fll+UC9qPADCf/EHXjCx+FGWy6xdJpcb3YkoLdU18MiT1rkFaJe9v
         zH4w==
X-Gm-Message-State: AOJu0YyoRUGeW7OStix/xx1D4QQ+XF/W7f2jVd6hy5o2CuC8FdIB5kef
        BKsUawxnkMgDcVlFpJusxUkyWQ==
X-Google-Smtp-Source: AGHT+IEksEKWVSh/XDnpfwX29OUeaNVkRbq1pFPq73ca7eluZ030PPcdcCygAruOaBN8r476zLzPrg==
X-Received: by 2002:a05:600c:217:b0:3fe:34c2:654b with SMTP id 23-20020a05600c021700b003fe34c2654bmr7224177wmi.14.1692025968914;
        Mon, 14 Aug 2023 08:12:48 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 02/13] media: qcom: camss: Start to move to module compat matched resources
Date:   Mon, 14 Aug 2023 16:12:32 +0100
Message-ID: <20230814151243.3801456-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
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

There is a lot of unnecessary if/elsing in this code that arguably
should never have made it upstream when adding a second let alone
subsequent SoC.

I'm guilty of not fixing the mess myself when adding in the sm8250.
Before adding in any new SoCs or resources lets take the time to cleanup
the resource passing.

First step is to pass the generic struct camss_resources as a parameter
per the compatible list.

Subsequent patches will address the other somewhat dispirate strutures
which we are also doing if/else on and assigning statically.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 93 ++++++++++++-----------
 drivers/media/platform/qcom/camss/camss.h |  8 ++
 2 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index de39dc987444f..d9e1672b74bd7 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
@@ -1120,47 +1121,12 @@ static int camss_of_parse_ports(struct camss *camss)
  */
 static int camss_init_subdevices(struct camss *camss)
 {
-	const struct resources *csiphy_res;
-	const struct resources *csid_res;
-	const struct resources *ispif_res;
-	const struct resources *vfe_res;
 	unsigned int i;
 	int ret;
 
-	if (camss->version == CAMSS_8x16) {
-		csiphy_res = csiphy_res_8x16;
-		csid_res = csid_res_8x16;
-		ispif_res = &ispif_res_8x16;
-		vfe_res = vfe_res_8x16;
-	} else if (camss->version == CAMSS_8x96) {
-		csiphy_res = csiphy_res_8x96;
-		csid_res = csid_res_8x96;
-		ispif_res = &ispif_res_8x96;
-		vfe_res = vfe_res_8x96;
-	} else if (camss->version == CAMSS_660) {
-		csiphy_res = csiphy_res_660;
-		csid_res = csid_res_660;
-		ispif_res = &ispif_res_660;
-		vfe_res = vfe_res_660;
-	}  else if (camss->version == CAMSS_845) {
-		csiphy_res = csiphy_res_845;
-		csid_res = csid_res_845;
-		/* Titan VFEs don't have an ISPIF  */
-		ispif_res = NULL;
-		vfe_res = vfe_res_845;
-	} else if (camss->version == CAMSS_8250) {
-		csiphy_res = csiphy_res_8250;
-		csid_res = csid_res_8250;
-		/* Titan VFEs don't have an ISPIF  */
-		ispif_res = NULL;
-		vfe_res = vfe_res_8250;
-	} else {
-		return -EINVAL;
-	}
-
 	for (i = 0; i < camss->csiphy_num; i++) {
 		ret = msm_csiphy_subdev_init(camss, &camss->csiphy[i],
-					     &csiphy_res[i], i);
+					     &camss->res->csiphy_res[i], i);
 		if (ret < 0) {
 			dev_err(camss->dev,
 				"Failed to init csiphy%d sub-device: %d\n",
@@ -1172,7 +1138,7 @@ static int camss_init_subdevices(struct camss *camss)
 	/* note: SM8250 requires VFE to be initialized before CSID */
 	for (i = 0; i < camss->vfe_num + camss->vfe_lite_num; i++) {
 		ret = msm_vfe_subdev_init(camss, &camss->vfe[i],
-					  &vfe_res[i], i);
+					  &camss->res->vfe_res[i], i);
 		if (ret < 0) {
 			dev_err(camss->dev,
 				"Fail to init vfe%d sub-device: %d\n", i, ret);
@@ -1182,7 +1148,7 @@ static int camss_init_subdevices(struct camss *camss)
 
 	for (i = 0; i < camss->csid_num; i++) {
 		ret = msm_csid_subdev_init(camss, &camss->csid[i],
-					   &csid_res[i], i);
+					   &camss->res->csid_res[i], i);
 		if (ret < 0) {
 			dev_err(camss->dev,
 				"Failed to init csid%d sub-device: %d\n",
@@ -1191,7 +1157,7 @@ static int camss_init_subdevices(struct camss *camss)
 		}
 	}
 
-	ret = msm_ispif_subdev_init(camss, ispif_res);
+	ret = msm_ispif_subdev_init(camss, camss->res->ispif_res);
 	if (ret < 0) {
 		dev_err(camss->dev, "Failed to init ispif sub-device: %d\n",
 		ret);
@@ -1554,6 +1520,10 @@ static int camss_probe(struct platform_device *pdev)
 	if (!camss)
 		return -ENOMEM;
 
+	camss->res = of_device_get_match_data(dev);
+	if (!camss->res)
+		return -ENODEV;
+
 	atomic_set(&camss->ref_count, 0);
 	camss->dev = dev;
 	platform_set_drvdata(pdev, camss);
@@ -1735,12 +1705,47 @@ static void camss_remove(struct platform_device *pdev)
 		camss_delete(camss);
 }
 
+static const struct camss_resources msm8916_resources = {
+	.csiphy_res = csiphy_res_8x16,
+	.csid_res = csid_res_8x16,
+	.ispif_res = &ispif_res_8x16,
+	.vfe_res = vfe_res_8x16,
+};
+
+static const struct camss_resources msm8996_resources = {
+	.csiphy_res = csiphy_res_8x96,
+	.csid_res = csid_res_8x96,
+	.ispif_res = &ispif_res_8x96,
+	.vfe_res = vfe_res_8x96,
+};
+
+static const struct camss_resources sdm660_resources = {
+	.csiphy_res = csiphy_res_660,
+	.csid_res = csid_res_660,
+	.ispif_res = &ispif_res_660,
+	.vfe_res = vfe_res_660,
+};
+
+static const struct camss_resources sdm845_resources = {
+	.csiphy_res = csiphy_res_845,
+	.csid_res = csid_res_845,
+	.ispif_res = NULL,
+	.vfe_res = vfe_res_845,
+};
+
+static const struct camss_resources sm8250_resources = {
+	.csiphy_res = csiphy_res_8250,
+	.csid_res = csid_res_8250,
+	.ispif_res = NULL,
+	.vfe_res = vfe_res_8250,
+};
+
 static const struct of_device_id camss_dt_match[] = {
-	{ .compatible = "qcom,msm8916-camss" },
-	{ .compatible = "qcom,msm8996-camss" },
-	{ .compatible = "qcom,sdm660-camss" },
-	{ .compatible = "qcom,sdm845-camss" },
-	{ .compatible = "qcom,sm8250-camss" },
+	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
+	{ .compatible = "qcom,msm8996-camss", .data = &msm8996_resources },
+	{ .compatible = "qcom,sdm660-camss", .data = &sdm660_resources },
+	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
+	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
 	{ }
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index e95211cdb1fd6..f632ee49ad83e 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -79,6 +79,13 @@ enum icc_count {
 	ICC_SM8250_COUNT = 4,
 };
 
+struct camss_resources {
+	const struct resources *csiphy_res;
+	const struct resources *csid_res;
+	const struct resources *ispif_res;
+	const struct resources *vfe_res;
+};
+
 struct camss {
 	enum camss_version version;
 	struct v4l2_device v4l2_dev;
@@ -99,6 +106,7 @@ struct camss {
 	struct device_link **genpd_link;
 	struct icc_path *icc_path[ICC_SM8250_COUNT];
 	struct icc_bw_tbl icc_bw_tbl[ICC_SM8250_COUNT];
+	const struct camss_resources *res;
 };
 
 struct camss_camera_interface {
-- 
2.41.0

