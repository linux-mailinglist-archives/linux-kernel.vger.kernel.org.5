Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF669802365
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjLCLnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjLCLng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:43:36 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC03FF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:43:41 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9b956c68cso37426321fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701603819; x=1702208619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKrvC1va3zOXcp6YVKcTFgaHzs/W3SOKPJn+fUfNRVg=;
        b=i1CtVHMj1QPOlv60fO4WklXqp9md/WEZC/PBPskl+OMw7P6dtoPu5WYVA+h+/6fsJz
         wLb36uYV/PIhgsAogmCzM6NB6W1poUmKTcnU7FZwC/3LyqChWvMMBqF2uw/rXBzRrCDW
         +/v9pBOmTazCAp9iNPhthh/Bfvq/KOq/2Jt0TQm5y1Oo+XmBDxtnOLrIVyIbU8dzc6vH
         wRzLulK0RBIOAa/P2DE+WtzCsZ5qzYRJOzxKmxuJ5NzXbL4UudCS4+/o6lutqtOpLv71
         AQlTEjG/X8acvHAEwlKjVmqDMVCYM8InhQKkZFU7wobczH9/SEFYn5GFw+aQH4j4bq39
         H4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701603819; x=1702208619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKrvC1va3zOXcp6YVKcTFgaHzs/W3SOKPJn+fUfNRVg=;
        b=HpNWiqahjykbWpQJpNfm4P4TA9YwbMAuA+mb8Ukm+AW4u8XNE4X5YHU4aVfwr99wsp
         p6E6ZkGfglMoERYdxcL//GnxY1Vw54chn80ZeXT9aoTiSuL4+7l+LJzhe4l4UYOMmnvJ
         6GBTM85BPANUblma/+43aOX6a+GIjTf09YNE9jiYIDndNPGb77EEmTzRCMkZ3LU+u9ty
         7wV/aUW3kuT3Lhy+6MmEz6NoEDfH97NA8Imds6/Lb/Ylyd4/FFRlJ5CciLBZrzhtL0Dl
         52C34uML+pnylHieEoEd2hSzvy3IT9qvXeMDGMufoUt6XmYMzq20gVTnm2xtMMI1d3lt
         AeAw==
X-Gm-Message-State: AOJu0YzvoRwyUJLavBrJUKuJgBLlMbgj3syNw4zpkXsdkwtud3BGQKE/
        RIwYqmGqvi2UKMdwHrrbcCivrA==
X-Google-Smtp-Source: AGHT+IHlCnMXqlHuC6gKdZ/CQQO1yqOzIBskrtxlMb/o+gHL9SMYk7yhl6JtGqmZs37Q6toY2GUfug==
X-Received: by 2002:a2e:8751:0:b0:2c9:f8fa:f1cb with SMTP id q17-20020a2e8751000000b002c9f8faf1cbmr520349ljj.23.1701603819537;
        Sun, 03 Dec 2023 03:43:39 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o17-20020a2e90d1000000b002c993c5d4c6sm894666ljg.105.2023.12.03.03.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:43:39 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH RESEND 6/6] usb: typec: qcom-pmic-typec: switch to DRM_AUX_HPD_BRIDGE
Date:   Sun,  3 Dec 2023 14:43:33 +0300
Message-Id: <20231203114333.1305826-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231203114333.1305826-1-dmitry.baryshkov@linaro.org>
References: <20231203114333.1305826-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the freshly defined DRM_AUX_HPD_BRIDGE instead of open-coding the
same functionality for the DRM bridge chain termination.

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/Kconfig                |  1 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 41 +++----------------
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 0b2993fef564..64d5421c69e6 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -80,6 +80,7 @@ config TYPEC_QCOM_PMIC
 	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on DRM || DRM=n
+	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE
 	help
 	  A Type-C port and Power Delivery driver which aggregates two
 	  discrete pieces of silicon in the PM8150b PMIC block: the
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 581199d37b49..1a2b4bddaa97 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -18,7 +18,7 @@
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
 
-#include <drm/drm_bridge.h>
+#include <drm/bridge/aux-bridge.h>
 
 #include "qcom_pmic_typec_pdphy.h"
 #include "qcom_pmic_typec_port.h"
@@ -36,7 +36,6 @@ struct pmic_typec {
 	struct pmic_typec_port	*pmic_typec_port;
 	bool			vbus_enabled;
 	struct mutex		lock;		/* VBUS state serialization */
-	struct drm_bridge	bridge;
 };
 
 #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
@@ -150,35 +149,6 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_DRM)
-static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
-				     enum drm_bridge_attach_flags flags)
-{
-	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
-}
-
-static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
-	.attach = qcom_pmic_typec_attach,
-};
-
-static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
-{
-	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
-#ifdef CONFIG_OF
-	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
-#endif
-	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
-	tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
-
-	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
-}
-#else
-static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
-{
-	return 0;
-}
-#endif
-
 static int qcom_pmic_typec_probe(struct platform_device *pdev)
 {
 	struct pmic_typec *tcpm;
@@ -186,6 +156,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct pmic_typec_resources *res;
 	struct regmap *regmap;
+	struct device *bridge_dev;
 	u32 base[2];
 	int ret;
 
@@ -241,14 +212,14 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
-	ret = qcom_pmic_typec_init_drm(tcpm);
-	if (ret)
-		return ret;
-
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (!tcpm->tcpc.fwnode)
 		return -EINVAL;
 
+	bridge_dev = drm_dp_hpd_bridge_register(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
+	if (IS_ERR(bridge_dev))
+		return PTR_ERR(bridge_dev);
+
 	tcpm->tcpm_port = tcpm_register_port(tcpm->dev, &tcpm->tcpc);
 	if (IS_ERR(tcpm->tcpm_port)) {
 		ret = PTR_ERR(tcpm->tcpm_port);
-- 
2.39.2

