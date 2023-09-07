Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858EE7978A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243830AbjIGQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbjIGQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:50:51 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494381FE9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:50:24 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-402d0eda361so13947175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105057; x=1694709857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYC+BO4g5oTHRDZDWzjxJL3LHVv+wyIe2Onv6IGcb8w=;
        b=fVV6Jxj1VJX3sg2tc2RoJxuCnUpkSPcfeBIQ0rkK/IDmZnSohn5k7Z5X/Ajcbhqggz
         ZKVJ1sYe+vkY1MPgcQsKymLTnpkg/BYrgB50Zq0BJ892KRKk/WCUlexwLmOAcbSm08nS
         2+vSw2jDGPmTRp+nx7ALFXJfys7406P5l4NDxHdwDf54sdy4rwhfpZsaw/lkUvdxjWQF
         MUlD1iWEjsbqEpUm5N8v1fjOrWxnRwWeDts0PODLvI1nlNhUJMs331s1QR3ABLAHVDZW
         gvh7URwYOpeFrf9eawHxWef05QJuHY+dGS+Mw1TS+yqwRtfRbYDAQGzePGEqzq7KVVxC
         efpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105057; x=1694709857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYC+BO4g5oTHRDZDWzjxJL3LHVv+wyIe2Onv6IGcb8w=;
        b=NhF8mKUlVVh7YjpehYtWbgMIEmc625NZN+Vrcb0M3hljQJY4WYWTccLVNHzS2MxF7Q
         i092QRHd1rYSp2s3cQKyGrDfo8KH0rX+XjuROhqKY3DNnC9ybo82IwqykE92cQEZHWwR
         iDrSYtRU8nX/s3U0J+taiC9FGmYYrm6lvPp5i892MKoS9bcfwwSrgh59ubuTxPJgVpVX
         lglS2IVJItZaiea5+QrOhseMYs57AO+jQIqQyml6D94vFJJ/aea63AJOCCVOclCB9HVS
         QdUxgd0/NNSH099PZcedoA8sPhDbs6unIYzV/2Nk/36rkrZ1Fwtz1UL8rXskhud/4WEp
         9a7A==
X-Gm-Message-State: AOJu0YwM98WfxUBhjCPJCarY83lnZ7v2juSTKX4sx63tF8CYSqpMSDlJ
        1LslcGXiesaPkK8b8q71+atXnQ==
X-Google-Smtp-Source: AGHT+IH58JOMVJkJQTXziWMLSctU7Mh0KznBuqW0N3Bdt4Kffvekz45e17vGsrqKjrzQSNllW+7xCA==
X-Received: by 2002:a7b:c7cd:0:b0:3fe:2b8c:9f0b with SMTP id z13-20020a7bc7cd000000b003fe2b8c9f0bmr187266wmk.23.1694105057223;
        Thu, 07 Sep 2023 09:44:17 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm23822145wrr.49.2023.09.07.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:44:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/17] media: qcom: camss: Start to move to module compat matched resources
Date:   Thu,  7 Sep 2023 17:43:56 +0100
Message-ID: <20230907164410.36651-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Subsequent patches will address the other somewhat disparate strutures
which we are also doing if/else on and assigning statically.

Squashed down a commit to drop useless NULL assignment for ispif resources.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 90 ++++++++++++-----------
 drivers/media/platform/qcom/camss/camss.h |  8 ++
 2 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 718ef8e4f5938..8fa5dee75672d 100644
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
@@ -1120,47 +1121,13 @@ static int camss_of_parse_ports(struct camss *camss)
  */
 static int camss_init_subdevices(struct camss *camss)
 {
-	const struct camss_subdev_resources *csiphy_res;
-	const struct camss_subdev_resources *csid_res;
-	const struct camss_subdev_resources *ispif_res;
-	const struct camss_subdev_resources *vfe_res;
+	const struct camss_resources *res = camss->res;
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
+					     &res->csiphy_res[i], i);
 		if (ret < 0) {
 			dev_err(camss->dev,
 				"Failed to init csiphy%d sub-device: %d\n",
@@ -1172,7 +1139,7 @@ static int camss_init_subdevices(struct camss *camss)
 	/* note: SM8250 requires VFE to be initialized before CSID */
 	for (i = 0; i < camss->vfe_num + camss->vfe_lite_num; i++) {
 		ret = msm_vfe_subdev_init(camss, &camss->vfe[i],
-					  &vfe_res[i], i);
+					  &res->vfe_res[i], i);
 		if (ret < 0) {
 			dev_err(camss->dev,
 				"Fail to init vfe%d sub-device: %d\n", i, ret);
@@ -1182,7 +1149,7 @@ static int camss_init_subdevices(struct camss *camss)
 
 	for (i = 0; i < camss->csid_num; i++) {
 		ret = msm_csid_subdev_init(camss, &camss->csid[i],
-					   &csid_res[i], i);
+					   &res->csid_res[i], i);
 		if (ret < 0) {
 			dev_err(camss->dev,
 				"Failed to init csid%d sub-device: %d\n",
@@ -1191,7 +1158,7 @@ static int camss_init_subdevices(struct camss *camss)
 		}
 	}
 
-	ret = msm_ispif_subdev_init(camss, ispif_res);
+	ret = msm_ispif_subdev_init(camss, res->ispif_res);
 	if (ret < 0) {
 		dev_err(camss->dev, "Failed to init ispif sub-device: %d\n",
 		ret);
@@ -1568,6 +1535,8 @@ static int camss_probe(struct platform_device *pdev)
 	if (!camss)
 		return -ENOMEM;
 
+	camss->res = of_device_get_match_data(dev);
+
 	atomic_set(&camss->ref_count, 0);
 	camss->dev = dev;
 	platform_set_drvdata(pdev, camss);
@@ -1742,12 +1711,45 @@ static void camss_remove(struct platform_device *pdev)
 	camss_genpd_cleanup(camss);
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
+	.vfe_res = vfe_res_845,
+};
+
+static const struct camss_resources sm8250_resources = {
+	.csiphy_res = csiphy_res_8250,
+	.csid_res = csid_res_8250,
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
index 9d6ba7b17ff02..20c84e8328880 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -79,6 +79,13 @@ enum icc_count {
 	ICC_SM8250_COUNT = 4,
 };
 
+struct camss_resources {
+	const struct camss_subdev_resources *csiphy_res;
+	const struct camss_subdev_resources *csid_res;
+	const struct camss_subdev_resources *ispif_res;
+	const struct camss_subdev_resources *vfe_res;
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

