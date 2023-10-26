Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE17D8642
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbjJZPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345507AbjJZPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:50:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC5E1AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40839652b97so7991735e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698335450; x=1698940250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BGTy9+RBMTpz8R8glCyLf29usc0ebnkTXjb8EDj74U=;
        b=PEOZ7tZhFftt/fLeEaLjCSVqOMs5D4/CB3wI2xlqapPq9cEzkshIQDXwqzJ+7PFVrC
         pjRJ9f3/yeFY7Q3CKOO00xfXijWRS31PPoMybZeTvF50AayrUnzZx684aYg88Ms15wE3
         EqkZpP8s2Pxst/DK6gKi+liqhS6103Mqgp0IerzFAPBp7sUtzZsiJ8GR/eHhx/6FN6Tf
         rggCwaTXWO8Dg9nHhrZ6KT4I2Dm/lEEjN/ospU/HMdM23IAQzBb/VvDn/YvbA2JZTVP1
         G4ihyJbAJMxlOSsS7dzkoNO1n6w4VZ2oX2937qCkFu4QBGIRWxWNJoQvjKNtGOkcn+wP
         8zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335450; x=1698940250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BGTy9+RBMTpz8R8glCyLf29usc0ebnkTXjb8EDj74U=;
        b=JgZNl1oX9yp2Ia0/ObC0syV+ZcDulVil+ZUSl1nCJCZbsiYLxQBdC3ptrs/9l6Bx1q
         UWU5m7Y0+Twj6fnH+mLzTZiKWduCy7xzBZcWh7InofrpxaKuR3PvqneOhoazo6x4K1fi
         fF0YPRyUKEK4mc0xhmWVEgW0KvmNbMegKzRBuRVF0JG/yrYZeJxIQpMtBXx2brUkznds
         vQHfCn1AT0w3z4QYTBRXklV900V9hcnEe4mLjx2yQEKYzdYpF48CjZK1y+Aifs/8pZb8
         URfXHYgkptA2D4IuL7Y/ZFKfSSvEe/JYLwZcriHKYatXIroKNOYvB+kEbHvWisy9KNeO
         shOQ==
X-Gm-Message-State: AOJu0Yx8XfuzL+o/60HOSMlNMRuB57TtdS9dt0zFHT0xDkLQMrDRgJcT
        k513M7xpPeRhOY0XyfbwJrPI7w==
X-Google-Smtp-Source: AGHT+IHb1B7gCow/1DIrC8pYX4NyVZtEaWKcWc2EVjglWHbpnPMACg7lvMqCwS5f4J+1/UP/mVj1+g==
X-Received: by 2002:a05:600c:524a:b0:407:8459:2ef9 with SMTP id fc10-20020a05600c524a00b0040784592ef9mr166240wmb.21.1698335450474;
        Thu, 26 Oct 2023 08:50:50 -0700 (PDT)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003feae747ff2sm2938289wms.35.2023.10.26.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:50:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 4/5] media: qcom: camss: Move VFE power-domain specifics into vfe.c
Date:   Thu, 26 Oct 2023 16:50:41 +0100
Message-ID: <20231026155042.551731-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the location of the hooks to VFE power domains has several
advantages.

1. Separation of concerns and functional decomposition.
   vfe.c should be responsible for and know best how manage
   power-domains for a VFE, excising from camss.c follows this
   principle.

2. Embeddeding a pointer to genpd in struct camss_vfe{} meas that we can
   dispense with a bunch of kmalloc array inside of camss.c.

3. Splitting up titan top gdsc from vfe/ife gdsc provides a base for
   breaking up magic indexes in dtsi.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 23 ++++++-
 drivers/media/platform/qcom/camss/camss-vfe.h |  2 +
 drivers/media/platform/qcom/camss/camss.c     | 63 +++++++++----------
 drivers/media/platform/qcom/camss/camss.h     |  4 +-
 4 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index d6799408a8c78..ebd5da6ad3f2f 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock_types.h>
 #include <linux/spinlock.h>
@@ -1380,8 +1381,13 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	if (!res->line_num)
 		return -EINVAL;
 
-	if (res->has_pd)
-		vfe->genpd = camss->genpd[id];
+	if (res->has_pd) {
+		vfe->genpd = dev_pm_domain_attach_by_id(camss->dev, id);
+		if (IS_ERR(vfe->genpd)) {
+			ret = PTR_ERR(vfe->genpd);
+			return ret;
+		}
+	}
 
 	vfe->line_num = res->line_num;
 	vfe->ops->subdev_init(dev, vfe);
@@ -1505,6 +1511,19 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	return 0;
 }
 
+/*
+ * msm_vfe_genpd_cleanup - Cleanup VFE genpd linkages
+ * @vfe: VFE device
+ *
+ */
+void msm_vfe_genpd_cleanup(struct vfe_device *vfe)
+{
+	if (vfe->genpd_link)
+		device_link_del(vfe->genpd_link);
+
+	dev_pm_domain_detach(vfe->genpd, true);
+}
+
 /*
  * vfe_link_setup - Setup VFE connections
  * @entity: Pointer to media entity structure
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 992a2103ec44c..cdbe59d8d437e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -159,6 +159,8 @@ struct camss_subdev_resources;
 int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 			const struct camss_subdev_resources *res, u8 id);
 
+void msm_vfe_genpd_cleanup(struct vfe_device *vfe);
+
 int msm_vfe_register_entities(struct vfe_device *vfe,
 			      struct v4l2_device *v4l2_dev);
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index ed01a3ac7a38e..03e955c7a7e4c 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1487,7 +1487,6 @@ static const struct media_device_ops camss_media_ops = {
 static int camss_configure_pd(struct camss *camss)
 {
 	struct device *dev = camss->dev;
-	int i;
 	int ret;
 
 	camss->genpd_num = of_count_phandle_with_args(dev->of_node,
@@ -1506,45 +1505,36 @@ static int camss_configure_pd(struct camss *camss)
 	if (camss->genpd_num == 1)
 		return 0;
 
-	camss->genpd = devm_kmalloc_array(dev, camss->genpd_num,
-					  sizeof(*camss->genpd), GFP_KERNEL);
-	if (!camss->genpd)
-		return -ENOMEM;
-
-	camss->genpd_link = devm_kmalloc_array(dev, camss->genpd_num,
-					       sizeof(*camss->genpd_link),
-					       GFP_KERNEL);
-	if (!camss->genpd_link)
-		return -ENOMEM;
+	/*
+	 * If the number of power-domains is greather than the number of VFEs
+	 * then the additional power-domain is for the entire CAMSS block the
+	 * 'top' power-domain.
+	 */
+	if (camss->genpd_num <= camss->res->vfe_num)
+		return 0;
 
 	/*
 	 * VFE power domains are in the beginning of the list, and while all
 	 * power domains should be attached, only if TITAN_TOP power domain is
 	 * found in the list, it should be linked over here.
 	 */
-	for (i = 0; i < camss->genpd_num; i++) {
-		camss->genpd[i] = dev_pm_domain_attach_by_id(camss->dev, i);
-		if (IS_ERR(camss->genpd[i])) {
-			ret = PTR_ERR(camss->genpd[i]);
-			goto fail_pm;
-		}
+	camss->genpd = dev_pm_domain_attach_by_id(camss->dev, camss->genpd_num - 1);
+	if (IS_ERR(camss->genpd)) {
+		ret = PTR_ERR(camss->genpd);
+		goto fail_pm;
 	}
-
-	if (i > camss->res->vfe_num) {
-		camss->genpd_link[i - 1] = device_link_add(camss->dev, camss->genpd[i - 1],
-							   DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
-							   DL_FLAG_RPM_ACTIVE);
-		if (!camss->genpd_link[i - 1]) {
-			ret = -EINVAL;
-			goto fail_pm;
-		}
+	camss->genpd_link = device_link_add(camss->dev, camss->genpd,
+					    DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
+					    DL_FLAG_RPM_ACTIVE);
+	if (!camss->genpd_link) {
+		ret = -EINVAL;
+		goto fail_pm;
 	}
 
 	return 0;
 
 fail_pm:
-	for (--i ; i >= 0; i--)
-		dev_pm_domain_detach(camss->genpd[i], true);
+	dev_pm_domain_detach(camss->genpd, true);
 
 	return ret;
 }
@@ -1566,18 +1556,25 @@ static int camss_icc_get(struct camss *camss)
 	return 0;
 }
 
-static void camss_genpd_cleanup(struct camss *camss)
+static void camss_genpd_subdevice_cleanup(struct camss *camss)
 {
 	int i;
 
+	for (i = 0; i < camss->vfe_total_num; i++)
+		msm_vfe_genpd_cleanup(&camss->vfe[i]);
+}
+
+static void camss_genpd_cleanup(struct camss *camss)
+{
 	if (camss->genpd_num == 1)
 		return;
 
-	if (camss->genpd_num > camss->res->vfe_num)
-		device_link_del(camss->genpd_link[camss->genpd_num - 1]);
+	if (camss->genpd_link)
+		device_link_del(camss->genpd_link);
+
+	dev_pm_domain_detach(camss->genpd, true);
 
-	for (i = 0; i < camss->genpd_num; i++)
-		dev_pm_domain_detach(camss->genpd[i], true);
+	camss_genpd_subdevice_cleanup(camss);
 }
 
 /*
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index b854cff1774d4..1ba824a2cb76c 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -107,8 +107,8 @@ struct camss {
 	struct vfe_device *vfe;
 	atomic_t ref_count;
 	int genpd_num;
-	struct device **genpd;
-	struct device_link **genpd_link;
+	struct device *genpd;
+	struct device_link *genpd_link;
 	struct icc_path *icc_path[ICC_SM8250_COUNT];
 	const struct camss_resources *res;
 	unsigned int vfe_total_num;
-- 
2.42.0

