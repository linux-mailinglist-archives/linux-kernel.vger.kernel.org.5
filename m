Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9157F22F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjKUBNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKUBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:13:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0ABC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:13:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-40b27726369so2462045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700529206; x=1701134006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+V8m9rGjlqHOkAe7opi5BbbJj9tL4XyGei+Q738HT0=;
        b=bdPhmdb7ViYO6KQ5HxaQlDsU3slAlXoMb3osv3rDP5SbAXUDmKGkvAKRjDgudW4oho
         Mh56xpcliFs/ZWiIFnp8OBW/Skyy1s/ODQdjIB2eU4BGFpS7qaN7ygWlTcMwr/NzHotv
         UglNIvx1dYNkqK26YvYxC3eDV9Wet51gRxAzeTWRDZzFgReMSe978aMxsguoq1vk7KCR
         FNXrDib4sGRC7bSjYc4tMYLGdZAMFf7SvfO9RQw0ghgAWUpn776uxf72mWtNpj0AOEHL
         xv6UF4HXkZv/sHvqygYt1kIyAyayZQEVhrfXxQWEVqp7Z/G+cOtuaYzWCDGWt/r5yy0y
         OiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700529206; x=1701134006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+V8m9rGjlqHOkAe7opi5BbbJj9tL4XyGei+Q738HT0=;
        b=cD1TTWZqHzcKmPo78g5fJplrqJVWsOgPrh4WAIpT9c8WK394KCAZuSCFQyd43utGAu
         FhtCCWXUjlmFcerDMtofb2sbL2kC2defxNjR5PqZsH1zlwIqAXaQUwfToktVAmG9oUry
         Zou4KP+wObMeXRyPO0qPK5NkUj04ZrtsdPkpSdJnlJAEid8WatKvEVoP04jx1nTuvhoR
         /KHIMn3mgSbg4EC2icuWH+a3JnqdcD6qqSj/BjjyjdFsNOdCFkFPDxodBZt640jBVPoL
         SggBBmpEZ3yF2onZs+Q16BEh7FLcMaoHpEwNw/2YuSi+Id8fH+8+5PE3QfvYZLgYS5Qi
         0PQA==
X-Gm-Message-State: AOJu0YxmD+gyt3ynaZ4NsCXaC30y9WTnRnr7sAenk9WEzk1bQFhaYEPa
        hDpAFZp3BYceDE1ssYDnLSqEhA==
X-Google-Smtp-Source: AGHT+IFEWbryaOwRrgMvz6UDDhe9oJNP3A+S6Hz+hWXIegeS61CWeU0ouIoSH95qIrQIPZ1eh70xgA==
X-Received: by 2002:a05:600c:1c0a:b0:408:3c8a:65ec with SMTP id j10-20020a05600c1c0a00b004083c8a65ecmr6849421wms.8.1700529206070;
        Mon, 20 Nov 2023 17:13:26 -0800 (PST)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c230100b003fefb94ccc9sm14913452wmo.11.2023.11.20.17.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:13:25 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, matti.lehtimaki@gmail.com,
        quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v5.1] media: qcom: camss: Flag VFE-lites to support more VFEs
Date:   Tue, 21 Nov 2023 01:13:20 +0000
Message-ID: <20231121011320.2545959-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118-b4-camss-named-power-domains-v5-6-55eb0f35a30a@linaro.org>
References: <20231118-b4-camss-named-power-domains-v5-6-55eb0f35a30a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Some platforms such as SC7280 have three VFEs and two VFE-lites. Current
code has hard-coded two as the maximum number of VFEs. Remove the
hard-coded maximum number of VFEs to handle all possible combinations of
VFEs and VFE-lites.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311200405.h6G4L9oe-lkp@intel.com
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-vfe-480.c | 33 +++++++++----------
 drivers/media/platform/qcom/camss/camss-vfe.c |  5 +++
 drivers/media/platform/qcom/camss/camss-vfe.h | 10 ++++++
 drivers/media/platform/qcom/camss/camss.c     | 26 +++++++--------
 drivers/media/platform/qcom/camss/camss.h     |  3 +-
 5 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
index 4652e8b4cff58..dc2735476c823 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
@@ -15,31 +15,28 @@
 #include "camss.h"
 #include "camss-vfe.h"
 
-/* VFE 2/3 are lite and have a different register layout */
-#define IS_LITE		(vfe->id >= 2 ? 1 : 0)
-
 #define VFE_HW_VERSION			(0x00)
 
-#define VFE_GLOBAL_RESET_CMD		(IS_LITE ? 0x0c : 0x1c)
-#define	    GLOBAL_RESET_HW_AND_REG	(IS_LITE ? BIT(1) : BIT(0))
+#define VFE_GLOBAL_RESET_CMD		(vfe_is_lite(vfe) ? 0x0c : 0x1c)
+#define	    GLOBAL_RESET_HW_AND_REG	(vfe_is_lite(vfe) ? BIT(1) : BIT(0))
 
-#define VFE_REG_UPDATE_CMD		(IS_LITE ? 0x20 : 0x34)
+#define VFE_REG_UPDATE_CMD		(vfe_is_lite(vfe) ? 0x20 : 0x34)
 static inline int reg_update_rdi(struct vfe_device *vfe, int n)
 {
-	return IS_LITE ? BIT(n) : BIT(1 + (n));
+	return vfe_is_lite(vfe) ? BIT(n) : BIT(1 + (n));
 }
 
 #define	    REG_UPDATE_RDI		reg_update_rdi
-#define VFE_IRQ_CMD			(IS_LITE ? 0x24 : 0x38)
+#define VFE_IRQ_CMD			(vfe_is_lite(vfe) ? 0x24 : 0x38)
 #define     IRQ_CMD_GLOBAL_CLEAR	BIT(0)
 
-#define VFE_IRQ_MASK(n)			((IS_LITE ? 0x28 : 0x3c) + (n) * 4)
-#define	    IRQ_MASK_0_RESET_ACK	(IS_LITE ? BIT(17) : BIT(0))
-#define	    IRQ_MASK_0_BUS_TOP_IRQ	(IS_LITE ? BIT(4) : BIT(7))
-#define VFE_IRQ_CLEAR(n)		((IS_LITE ? 0x34 : 0x48) + (n) * 4)
-#define VFE_IRQ_STATUS(n)		((IS_LITE ? 0x40 : 0x54) + (n) * 4)
+#define VFE_IRQ_MASK(n)			((vfe_is_lite(vfe) ? 0x28 : 0x3c) + (n) * 4)
+#define	    IRQ_MASK_0_RESET_ACK	(vfe_is_lite(vfe) ? BIT(17) : BIT(0))
+#define	    IRQ_MASK_0_BUS_TOP_IRQ	(vfe_is_lite(vfe) ? BIT(4) : BIT(7))
+#define VFE_IRQ_CLEAR(n)		((vfe_is_lite(vfe) ? 0x34 : 0x48) + (n) * 4)
+#define VFE_IRQ_STATUS(n)		((vfe_is_lite(vfe) ? 0x40 : 0x54) + (n) * 4)
 
-#define BUS_REG_BASE			(IS_LITE ? 0x1a00 : 0xaa00)
+#define BUS_REG_BASE			(vfe_is_lite(vfe) ? 0x1a00 : 0xaa00)
 
 #define VFE_BUS_WM_CGC_OVERRIDE		(BUS_REG_BASE + 0x08)
 #define		WM_CGC_OVERRIDE_ALL	(0x3FFFFFF)
@@ -49,13 +46,13 @@ static inline int reg_update_rdi(struct vfe_device *vfe, int n)
 #define VFE_BUS_IRQ_MASK(n)		(BUS_REG_BASE + 0x18 + (n) * 4)
 static inline int bus_irq_mask_0_rdi_rup(struct vfe_device *vfe, int n)
 {
-	return IS_LITE ? BIT(n) : BIT(3 + (n));
+	return vfe_is_lite(vfe) ? BIT(n) : BIT(3 + (n));
 }
 
 #define     BUS_IRQ_MASK_0_RDI_RUP	bus_irq_mask_0_rdi_rup
 static inline int bus_irq_mask_0_comp_done(struct vfe_device *vfe, int n)
 {
-	return IS_LITE ? BIT(4 + (n)) : BIT(6 + (n));
+	return vfe_is_lite(vfe) ? BIT(4 + (n)) : BIT(6 + (n));
 }
 
 #define     BUS_IRQ_MASK_0_COMP_DONE	bus_irq_mask_0_comp_done
@@ -90,8 +87,8 @@ static inline int bus_irq_mask_0_comp_done(struct vfe_device *vfe, int n)
 /* for titan 480, each bus client is hardcoded to a specific path
  * and each bus client is part of a hardcoded "comp group"
  */
-#define RDI_WM(n)			((IS_LITE ? 0 : 23) + (n))
-#define RDI_COMP_GROUP(n)		((IS_LITE ? 0 : 11) + (n))
+#define RDI_WM(n)			((vfe_is_lite(vfe) ? 0 : 23) + (n))
+#define RDI_COMP_GROUP(n)		((vfe_is_lite(vfe) ? 0 : 11) + (n))
 
 #define MAX_VFE_OUTPUT_LINES	4
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 123e5ead7602d..7bcf9ddb3537a 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1742,3 +1742,8 @@ void msm_vfe_unregister_entities(struct vfe_device *vfe)
 		media_entity_cleanup(&sd->entity);
 	}
 }
+
+bool vfe_is_lite(struct vfe_device *vfe)
+{
+	return vfe->camss->res->vfe_res[vfe->id].is_lite;
+}
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index cdbe59d8d437e..0572c9b08e112 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -226,4 +226,14 @@ extern const struct vfe_hw_ops vfe_ops_480;
 int vfe_get(struct vfe_device *vfe);
 void vfe_put(struct vfe_device *vfe);
 
+/*
+ * vfe_is_lite - Return if VFE is VFE lite.
+ * @vfe: VFE Device
+ *
+ * Some VFE lites have a different register layout.
+ *
+ * Return whether VFE is VFE lite
+ */
+bool vfe_is_lite(struct vfe_device *vfe);
+
 #endif /* QC_MSM_CAMSS_VFE_H */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index ee3e8cefa9b1f..ea0038f62b807 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -706,6 +706,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe_lite" },
 		.interrupt = { "vfe_lite" },
+		.is_lite = true,
 		.line_num = 4,
 		.ops = &vfe_ops_170
 	}
@@ -886,6 +887,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe_lite0" },
 		.interrupt = { "vfe_lite0" },
+		.is_lite = true,
 		.line_num = 4,
 		.ops = &vfe_ops_480
 	},
@@ -905,6 +907,7 @@ static const struct camss_subdev_resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe_lite1" },
 		.interrupt = { "vfe_lite1" },
+		.is_lite = true,
 		.line_num = 4,
 		.ops = &vfe_ops_480
 	},
@@ -1204,7 +1207,7 @@ static int camss_init_subdevices(struct camss *camss)
 	}
 
 	/* note: SM8250 requires VFE to be initialized before CSID */
-	for (i = 0; i < camss->vfe_total_num; i++) {
+	for (i = 0; i < camss->res->vfe_num; i++) {
 		ret = msm_vfe_subdev_init(camss, &camss->vfe[i],
 					  &res->vfe_res[i], i);
 		if (ret < 0) {
@@ -1276,7 +1279,7 @@ static int camss_register_entities(struct camss *camss)
 		goto err_reg_ispif;
 	}
 
-	for (i = 0; i < camss->vfe_total_num; i++) {
+	for (i = 0; i < camss->res->vfe_num; i++) {
 		ret = msm_vfe_register_entities(&camss->vfe[i],
 						&camss->v4l2_dev);
 		if (ret < 0) {
@@ -1348,7 +1351,7 @@ static int camss_register_entities(struct camss *camss)
 				}
 	} else {
 		for (i = 0; i < camss->res->csid_num; i++)
-			for (k = 0; k < camss->vfe_total_num; k++)
+			for (k = 0; k < camss->res->vfe_num; k++)
 				for (j = 0; j < camss->vfe[k].line_num; j++) {
 					struct v4l2_subdev *csid = &camss->csid[i].subdev;
 					struct v4l2_subdev *vfe = &camss->vfe[k].line[j].subdev;
@@ -1372,7 +1375,7 @@ static int camss_register_entities(struct camss *camss)
 	return 0;
 
 err_link:
-	i = camss->vfe_total_num;
+	i = camss->res->vfe_num;
 err_reg_vfe:
 	for (i--; i >= 0; i--)
 		msm_vfe_unregister_entities(&camss->vfe[i]);
@@ -1411,7 +1414,7 @@ static void camss_unregister_entities(struct camss *camss)
 
 	msm_ispif_unregister_entities(camss->ispif);
 
-	for (i = 0; i < camss->vfe_total_num; i++)
+	for (i = 0; i < camss->res->vfe_num; i++)
 		msm_vfe_unregister_entities(&camss->vfe[i]);
 }
 
@@ -1509,7 +1512,7 @@ static int camss_configure_pd(struct camss *camss)
 		return 0;
 
 	/* count the # of VFEs which have flagged power-domain */
-	for (vfepd_num = i = 0; i < camss->vfe_total_num; i++) {
+	for (vfepd_num = i = 0; i < camss->res->vfe_num; i++) {
 		if (res->vfe_res[i].has_pd)
 			vfepd_num++;
 	}
@@ -1584,7 +1587,7 @@ static void camss_genpd_subdevice_cleanup(struct camss *camss)
 {
 	int i;
 
-	for (i = 0; i < camss->vfe_total_num; i++)
+	for (i = 0; i < camss->res->vfe_num; i++)
 		msm_vfe_genpd_cleanup(&camss->vfe[i]);
 }
 
@@ -1641,8 +1644,7 @@ static int camss_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	camss->vfe_total_num = camss->res->vfe_num + camss->res->vfe_lite_num;
-	camss->vfe = devm_kcalloc(dev, camss->vfe_total_num,
+	camss->vfe = devm_kcalloc(dev, camss->res->vfe_num,
 				  sizeof(*camss->vfe), GFP_KERNEL);
 	if (!camss->vfe)
 		return -ENOMEM;
@@ -1800,8 +1802,7 @@ static const struct camss_resources sdm845_resources = {
 	.vfe_res = vfe_res_845,
 	.csiphy_num = ARRAY_SIZE(csiphy_res_845),
 	.csid_num = ARRAY_SIZE(csid_res_845),
-	.vfe_num = 2,
-	.vfe_lite_num = 1,
+	.vfe_num = ARRAY_SIZE(vfe_res_845),
 };
 
 static const struct camss_resources sm8250_resources = {
@@ -1813,8 +1814,7 @@ static const struct camss_resources sm8250_resources = {
 	.icc_path_num = ARRAY_SIZE(icc_res_sm8250),
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8250),
 	.csid_num = ARRAY_SIZE(csid_res_8250),
-	.vfe_num = 2,
-	.vfe_lite_num = 2,
+	.vfe_num = ARRAY_SIZE(vfe_res_8250),
 };
 
 static const struct of_device_id camss_dt_match[] = {
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index cd8186fe1797b..a0c2dcc779f05 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -51,6 +51,7 @@ struct camss_subdev_resources {
 	char *pd_name;
 	u8 line_num;
 	bool has_pd;
+	bool is_lite;
 	const void *ops;
 };
 
@@ -95,7 +96,6 @@ struct camss_resources {
 	const unsigned int csiphy_num;
 	const unsigned int csid_num;
 	const unsigned int vfe_num;
-	const unsigned int vfe_lite_num;
 };
 
 struct camss {
@@ -113,7 +113,6 @@ struct camss {
 	struct device_link *genpd_link;
 	struct icc_path *icc_path[ICC_SM8250_COUNT];
 	const struct camss_resources *res;
-	unsigned int vfe_total_num;
 };
 
 struct camss_camera_interface {
-- 
2.42.0

