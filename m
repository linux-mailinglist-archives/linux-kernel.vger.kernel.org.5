Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58F07E02E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376711AbjKCM30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376553AbjKCM3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:29:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB5FD5B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:29:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-408425c7c10so14914175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699014546; x=1699619346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kfmsv1+9a7xxjyHODu3lURwTZ23LFgQq1tCajTllXGQ=;
        b=hNfv1JGpj5M/h6XSF9pm1tlKSQKiMhZHAaDy/fCYFbNmPknyUPlPUyVH/Mdtajxzx7
         WIoC82Hv910kMCKIS/AXRiOUAEZUUM2y8Rb8uFKlRVWzbGxJIy9I4o3sbgvAK1X/WCMg
         OZfcQDCJNWoqGhV3akDq+fBRf9twxhoWyPNCP8spEYSwsAFgoyZWW4kKXEvJnZwp2guC
         OF14Ygo0sNpp9oHjr7NXM+4BECO8Fsv8wlOcQBR3tlgtqjqTLrfbz+BaXFvJupEtUXia
         d1VJq/dA2TDaKBosGn3AmIlB2XhpUdN7j+4dY6BUgBMSrPgftMIPxe+zm5ztepb2LSdG
         F+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014546; x=1699619346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfmsv1+9a7xxjyHODu3lURwTZ23LFgQq1tCajTllXGQ=;
        b=EaQtVScD/4mqezGULdMLAxs5j5g/xoRqSZymeM3uIvM4hmJ1y3NymH2Lb2GES64T85
         xXUAX6P+BVT6Pz7gSQiesjiAvLYNTdIf7A+UtmF5jiztJ4X47YImkRjsMELgNQYx/yAM
         /FU4MJH3hWJlZ+CW+DnRe8JRTBzYm7+lsjYCmYGwLqmHzXRAEDD4kjOFqwlNetOoXOhF
         Z5b/bzL7mYy9xHCvo1cINMITLqXG91iy6PrFqqqWWkzaNx3e+4bBU5YGXV49Fi6SMdNa
         6clZ2M1lSDL4/XWHjFtzrO9h55XQFw6ggW1TVdmUBOOWnEkbcQp1DDxYUT20nz2z5q/9
         J52A==
X-Gm-Message-State: AOJu0YzdaAAe9aEdty9XD5EwzT7VFI+hx2Fa3/BurK2klbLJTm800ca1
        rV0gKn3qh06PHYTHdi0f+ixTbw==
X-Google-Smtp-Source: AGHT+IE4lIhsKBaURieeZTScfYBWF0zYielGo2SjTzn0k/QM/wK27e+idd46GZUocyi6msJTXDOoCQ==
X-Received: by 2002:a05:600c:4748:b0:408:53d4:52dd with SMTP id w8-20020a05600c474800b0040853d452ddmr17182240wmo.22.1699014546138;
        Fri, 03 Nov 2023 05:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b0040772138bb7sm2402918wmb.2.2023.11.03.05.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 05:29:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Fri, 03 Nov 2023 12:29:01 +0000
Subject: [PATCH v4 4/7] media: qcom: camss: Move VFE power-domain specifics
 into vfe.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231103-b4-camss-named-power-domains-v4-4-33a905359dbc@linaro.org>
References: <20231103-b4-camss-named-power-domains-v4-0-33a905359dbc@linaro.org>
In-Reply-To: <20231103-b4-camss-named-power-domains-v4-0-33a905359dbc@linaro.org>
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

Moving the location of the hooks to VFE power domains has several
advantages.

1. Separation of concerns and functional decomposition.
   vfe.c should be responsible for and know best how manage
   power-domains for a VFE, excising from camss.c follows this
   principle.

2. Embedding a pointer to genpd in struct camss_vfe{} meas that we can
   dispense with a bunch of kmalloc array inside of camss.c.

3. Splitting up titan top gdsc from vfe/ife gdsc provides a base for
   breaking up magic indexes in dtsi.

Suggested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 24 +++++++++-
 drivers/media/platform/qcom/camss/camss-vfe.h |  2 +
 drivers/media/platform/qcom/camss/camss.c     | 68 +++++++++++++++------------
 drivers/media/platform/qcom/camss/camss.h     |  4 +-
 4 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 5172eb5612a1c..defff24f07ce3 100644
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
@@ -1381,8 +1382,13 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
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
@@ -1506,6 +1512,20 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
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
+	if (vfe->genpd)
+		dev_pm_domain_detach(vfe->genpd, true);
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
index ed01a3ac7a38e..f10a47f1aee7d 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1487,7 +1487,9 @@ static const struct media_device_ops camss_media_ops = {
 static int camss_configure_pd(struct camss *camss)
 {
 	struct device *dev = camss->dev;
+	const struct camss_resources *res = camss->res;
 	int i;
+	int vfepd_num;
 	int ret;
 
 	camss->genpd_num = of_count_phandle_with_args(dev->of_node,
@@ -1506,45 +1508,42 @@ static int camss_configure_pd(struct camss *camss)
 	if (camss->genpd_num == 1)
 		return 0;
 
-	camss->genpd = devm_kmalloc_array(dev, camss->genpd_num,
-					  sizeof(*camss->genpd), GFP_KERNEL);
-	if (!camss->genpd)
-		return -ENOMEM;
+	/* count the # of VFEs which have flagged power-domain */
+	for (vfepd_num = i = 0; i < camss->vfe_total_num; i++) {
+		if (res->vfe_res[i].has_pd)
+			vfepd_num++;
+	}
 
-	camss->genpd_link = devm_kmalloc_array(dev, camss->genpd_num,
-					       sizeof(*camss->genpd_link),
-					       GFP_KERNEL);
-	if (!camss->genpd_link)
-		return -ENOMEM;
+	/*
+	 * If the number of power-domains is greater than the number of VFEs
+	 * then the additional power-domain is for the entire CAMSS block the
+	 * 'top' power-domain.
+	 */
+	if (camss->genpd_num <= vfepd_num)
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
@@ -1566,18 +1565,25 @@ static int camss_icc_get(struct camss *camss)
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

