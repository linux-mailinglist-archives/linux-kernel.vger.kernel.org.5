Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372E477FA65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352881AbjHQPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352927AbjHQPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:09:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CF30DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:08:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so117877651fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692284908; x=1692889708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ0C4gM1MGvlXqRM+eWMYuEXR3MLstzhpSuwjlgfvLI=;
        b=e7/tjJYcUXzJ/fc5afxlyPh2GEoSNtR/Pik/2N83a5bFFYgYpqHPFzRybUOC3aYxRN
         0YAkAIX2NkCWmCkzgN3/ElWQFzS5bgm34BzASSAq9ytScx7/9lmEQcm4gTCoPSyw5dmL
         stBk8pFVBIcyx7hE2sBOg4d+vM0tx2DrfNG1VCph7yamdeID/bpyYB5v2YvZ2jin7Iuu
         mGbWB+Id7Jrko47BYDtm24ImW9z5mFEgWva65DgzmKUI67dDU9LqdoFXfE3dzq4nbRK7
         tBg3kx/vOWc3+VAAIfOJLRaxWFdAXnMGzmxMHR8CcTIF1R9myLRzbqAdUPaexCCEgXD/
         TaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284908; x=1692889708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ0C4gM1MGvlXqRM+eWMYuEXR3MLstzhpSuwjlgfvLI=;
        b=FZrAWOppvi2Axo/k5FjlQarPIeTg3KsXSc08oxvNpWfcmHQq7539sUkcSFxy6SU5j9
         q0fkp3+O7pWxE3O2ty13jj/spXYSDjnFEMQ1rgbx2mZZaMMgRa3T6cfjfLiUxUEZs2B9
         /5gkf/WdErBjxpnme1A5aIpejzAqSX085i+EI4Be3XvRcwGm1HClD5JZPxexUUg1IpxX
         4iaQWSWztVgK9fluXHw/OKDeQinuGwWRDVMYaznDt9sMecHAMe49nDFAep8u94PVVYeQ
         IlN+ZN1hWX6Yi9G/1pvJXaGy90AT0wKyxwYUTPdeh2xI1PUa4+kWqVVUYQXgEXQGBxaX
         FgfA==
X-Gm-Message-State: AOJu0YxX1k6pMnbxjPNPEjlVqAOWkf6QQqaEcBDE0DkNTe/fKsIkFTos
        ICgoM4YnusSHakB/64889HDGow==
X-Google-Smtp-Source: AGHT+IHCkGizuzzIPtIX5WMAX9krzdeHAXfQZ492o8PeshzyR0meMULw9sDdOM14ds1qMND3CXOeog==
X-Received: by 2002:a2e:994b:0:b0:2bb:a28b:58e0 with SMTP id r11-20020a2e994b000000b002bba28b58e0mr2005867ljj.14.1692284908361;
        Thu, 17 Aug 2023 08:08:28 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u8-20020a2e9b08000000b002b6ef2fca66sm4111413lji.41.2023.08.17.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 08:08:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Date:   Thu, 17 Aug 2023 18:08:24 +0300
Message-Id: <20230817150824.14371-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817150824.14371-1-dmitry.baryshkov@linaro.org>
References: <20230817150824.14371-1-dmitry.baryshkov@linaro.org>
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

The current approach to handling DP on bridge-enabled platforms requires
a chain of DP bridges up to the USB-C connector. Register a last DRM
bridge for such chain.

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/Kconfig                |  1 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 5d393f520fc2..0b2993fef564 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -79,6 +79,7 @@ config TYPEC_WCOVE
 config TYPEC_QCOM_PMIC
 	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on DRM || DRM=n
 	help
 	  A Type-C port and Power Delivery driver which aggregates two
 	  discrete pieces of silicon in the PM8150b PMIC block: the
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index af44ee4e6e86..581199d37b49 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -17,6 +17,9 @@
 #include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
+
+#include <drm/drm_bridge.h>
+
 #include "qcom_pmic_typec_pdphy.h"
 #include "qcom_pmic_typec_port.h"
 
@@ -33,6 +36,7 @@ struct pmic_typec {
 	struct pmic_typec_port	*pmic_typec_port;
 	bool			vbus_enabled;
 	struct mutex		lock;		/* VBUS state serialization */
+	struct drm_bridge	bridge;
 };
 
 #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
@@ -146,6 +150,35 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_DRM)
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
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
+#ifdef CONFIG_OF
+	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
+#endif
+	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
+	tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+
+	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
+}
+#else
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	return 0;
+}
+#endif
+
 static int qcom_pmic_typec_probe(struct platform_device *pdev)
 {
 	struct pmic_typec *tcpm;
@@ -208,6 +241,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
+	ret = qcom_pmic_typec_init_drm(tcpm);
+	if (ret)
+		return ret;
+
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (!tcpm->tcpc.fwnode)
 		return -EINVAL;
-- 
2.39.2

