Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7787669E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjG1KJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjG1KJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:09:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDB02D67
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:09:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso3223790e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690538941; x=1691143741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeuHcSlwr8k7ZjEttcrBe2bsInJmNS0h0EGzA/qhp2s=;
        b=WrqZTOfmFipQa3LmSX2vMNshbaJ2oTrq3ydUn/mUOqq91xR03OJ+FWu1P94kJw9pUH
         s97M9OzbvZHXFIYCGLky0XESYeAc1gENW5nj2lBGJvojMOp1xdpu3LG9xInsw69p0U/U
         y79+kw/vTtGmzeuXP/l4MkA0Thg4CCQm0yuO704QUawEkVY7xasCfs1P5/bFKUmt+C8E
         HvYGKBm75l2zfGFD3BLphvzR6xSzyYC7cY+jXexbrJiTOeJquGvK6vozOnX8SYIBXRUW
         vQgkUg+zzUcz+QtBeYVj8Cnitm0Yuu16yACG0DlsJpMVel3ucqID7tA8Q6cdYuCM6Aya
         Bk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538941; x=1691143741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeuHcSlwr8k7ZjEttcrBe2bsInJmNS0h0EGzA/qhp2s=;
        b=D/5fOVVuFhsQPOhblskP10DuGDwyD0vCquyDRz/rj3eiWJ9Q0UsEicp+D3neVYherT
         s9lUYbyqQtQHmaT4dSBKmmEIsx244l4shE1eP6TJjYpM9irfyrg+u0yOoYBso4XkjID3
         aOqGL2+qRv8zWjC/57LhN/TcnTUhkAbf9GffbETOXkIU4gPgq5BKE4dIRCaHab0YIIaX
         sfk8FFcMWs04W7qkQT/9Z+AJyePZjKd/mR39rKi/kBYRP1T5tLzLaaLRNdA/mX4ffWof
         SVmFeG6wXWbvSqPJVfIF0YCsxOT4kSs+owcUBoHMwxwm812Y5P4nnRJpJI8IUaJn1S6H
         kfAg==
X-Gm-Message-State: ABy/qLbyC/DyOf1IxeO5h/mA7Vh7OfUiMVQPcf8zV6MEEY187/HyQ13j
        SLGQ/HYfNbzzIZb5llBIcYeU5A==
X-Google-Smtp-Source: APBJJlGJhXZDa07Yt1+xaZ+RDBvdJhY4SzD6ngnP/kTRnzjRJL9dBiK4NJ/vDrGnNKWuZ8FAlNXANg==
X-Received: by 2002:a19:4f4c:0:b0:4fc:4f3e:9cbf with SMTP id a12-20020a194f4c000000b004fc4f3e9cbfmr1165284lfk.50.1690538941541;
        Fri, 28 Jul 2023 03:09:01 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id h16-20020ac25970000000b004fe0de39fddsm741704lfp.290.2023.07.28.03.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:09:00 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Date:   Fri, 28 Jul 2023 13:08:57 +0300
Message-Id: <20230728100857.471984-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728100857.471984-1-dmitry.baryshkov@linaro.org>
References: <20230728100857.471984-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index af44ee4e6e86..bf6f504d2160 100644
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
@@ -146,6 +150,33 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
 	return 0;
 }
 
+#ifdef CONFIG_DRM
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
+	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
+	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
+	tcpm->bridge.type = DRM_MODE_CONNECTOR_USB;
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
@@ -208,6 +239,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
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

