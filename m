Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248E1790E7F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349218AbjICVmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349169AbjICVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:42:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40975131
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:42:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500bb392ab7so1457695e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777319; x=1694382119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z9KfdzRz+e1f0Dn+tIMZYjzQ2uNwluev0VEi7a5dtY=;
        b=bLiNoc2xYPP7AyRYDhGdrqngyBpzEC0olw884TRdE1gasT/b2exvR9K4qCWnr5YBtF
         6MIXCjqUqo2JQ1i3JdI4YHxA47N1EEtd+084xcuIFWZ7tDNlkeyTnolh84j1PO5waMDq
         NhvmZQ4lJ5YFo50avGCVH25BTBJv5TkopOHljmsTkpi6dunjR/FADyOG5H5qvMF5Cppr
         EcoY7lYQMM8vpMFnHIR56G8H8SKp69NNZ5RVhYFrO7sGaTkataeHWNx6CApbmdTT7qYR
         4T9lMCOh4CoUBVtiJL+k89UnTiPWyZ7EO4bL7/lSr/7W5aQO6ueBUsYZXL6AD98la6BZ
         5z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777319; x=1694382119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z9KfdzRz+e1f0Dn+tIMZYjzQ2uNwluev0VEi7a5dtY=;
        b=fiushM0+mFg1mczQN19LYbrvdDSoQ9lPesNLZX1TXFg6h2xS9jwXnJiswMtugEUKmv
         wsmbsKS/tXVlfVyr1TGOPFvE7gFxziEZ4aGbB6G2u1G2y0gdWBiWWLm87S1F30sZTfI6
         GRJv1mvGZBFKObailg8XcReGEUwJ4UkTv71nRdFW406I2eRd7KQlYerBKq/ATHseC8xZ
         t4MUmMflJyaMpvgVLzFmD3vCcUurRyu4lMqg/SPFdGQ5mwRSVoH3ucJ2oBbq3+5VQ8mc
         sxcenduyk0lsuir8KaBDPkHZZMoxFRyy7KSlNEEVl4rh7LrKUSv08QdheSauV2frUpEt
         Xj2A==
X-Gm-Message-State: AOJu0YxOZLKg2lJ/mu1bhzgqXfhrzSngu1Mgltnz4ZPL8QMc6nhdBGLN
        QUEggIU5WWy+9KSG1P54PYN8yA==
X-Google-Smtp-Source: AGHT+IEMobz+Krc+0cqSQPSTTEZbkkDAuHF3uHKlCMRtDr3G2ANxRagameLnEyWRzywcqzd4HevbIQ==
X-Received: by 2002:a05:6512:ac3:b0:4f9:5a87:1028 with SMTP id n3-20020a0565120ac300b004f95a871028mr6541101lfu.30.1693777319560;
        Sun, 03 Sep 2023 14:41:59 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:59 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH v1 11/12] usb: typec: qcom: extract DRM bridge functionality to separate file
Date:   Mon,  4 Sep 2023 00:41:49 +0300
Message-Id: <20230903214150.2877023-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simplify source code and to reduce the amount of ifdefs in
the C files, extract the DRM bridge functionality to the separate file.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/qcom/Makefile          |  4 ++
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 40 +++----------------
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c | 38 ++++++++++++++++++
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h | 20 ++++++++++
 4 files changed, 67 insertions(+), 35 deletions(-)
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c
 create mode 100644 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h

diff --git a/drivers/usb/typec/tcpm/qcom/Makefile b/drivers/usb/typec/tcpm/qcom/Makefile
index dc1e8832e197..6d01ec97c9fd 100644
--- a/drivers/usb/typec/tcpm/qcom/Makefile
+++ b/drivers/usb/typec/tcpm/qcom/Makefile
@@ -4,3 +4,7 @@ obj-$(CONFIG_TYPEC_QCOM_PMIC)		+= qcom_pmic_tcpm.o
 qcom_pmic_tcpm-y			+= qcom_pmic_typec.o \
 					   qcom_pmic_typec_port.o \
 					   qcom_pmic_typec_pdphy.o
+
+ifneq ($(CONFIG_DRM),)
+	qcom_pmic_tcpm-y	+= qcom_pmic_typec_drm.o
+endif
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index ceda594a8d56..b9d4856101c7 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -18,8 +18,7 @@
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
 
-#include <drm/drm_bridge.h>
-
+#include "qcom_pmic_typec_drm.h"
 #include "qcom_pmic_typec_pdphy.h"
 #include "qcom_pmic_typec_port.h"
 
@@ -34,9 +33,9 @@ struct pmic_typec {
 	struct tcpc_dev		tcpc;
 	struct pmic_typec_pdphy	*pmic_typec_pdphy;
 	struct pmic_typec_port	*pmic_typec_port;
+	struct pmic_typec_drm	*pmic_typec_drm;
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
@@ -241,9 +211,9 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
-	ret = qcom_pmic_typec_init_drm(tcpm);
-	if (ret)
-		return ret;
+	tcpm->pmic_typec_drm = qcom_pmic_typec_init_drm(dev);
+	if (IS_ERR(tcpm->pmic_typec_drm))
+		return PTR_ERR(tcpm->pmic_typec_drm);
 
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (!tcpm->tcpc.fwnode)
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c
new file mode 100644
index 000000000000..e202eb7b52db
--- /dev/null
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Linaro Ltd. All rights reserved.
+ */
+
+#include <linux/of.h>
+
+#include <drm/drm_bridge.h>
+
+struct pmic_typec_drm {
+	struct drm_bridge bridge;
+};
+
+static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
+				     enum drm_bridge_attach_flags flags)
+{
+	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
+}
+
+static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
+	.attach = qcom_pmic_typec_attach,
+};
+
+struct pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev)
+{
+	struct pmic_typec_drm *tcpm_drm;
+
+	tcpm_drm = devm_kzalloc(dev, sizeof(*tcpm_drm), GFP_KERNEL);
+	if (!tcpm_drm)
+		return ERR_PTR(-ENOMEM);
+
+	tcpm_drm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
+	tcpm_drm->bridge.of_node = of_get_child_by_name(dev->of_node, "connector");
+	tcpm_drm->bridge.ops = DRM_BRIDGE_OP_HPD;
+	tcpm_drm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+
+	return ERR_PTR(devm_drm_bridge_add(dev, &tcpm_drm->bridge));
+}
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h
new file mode 100644
index 000000000000..01f4bb71346b
--- /dev/null
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Linaro Ltd. All rights reserved.
+ */
+
+#ifndef __QCOM_PMIC_DRM_H__
+#define __QCOM_PMIC_DRM_H__
+
+struct pmic_typec_drm;
+
+#if IS_ENABLED(CONFIG_DRM)
+struct pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev);
+#else
+static inline pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __QCOM_PMIC_DRM_H__ */
-- 
2.39.2

