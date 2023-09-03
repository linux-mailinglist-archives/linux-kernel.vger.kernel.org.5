Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1A790E7A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349120AbjICVmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349218AbjICVmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:42:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A800F0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:42:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ffa248263cso1325259e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777320; x=1694382120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRU3YcmHhtMgrEwiKr0jiCPmTZjWFsu5C3QySeLjrFk=;
        b=THFkBtld5ZsUEWb6H7JLFiGSPRQ+dD2nTuY9ZyosTxdnMQYrFpMp996995G4SsnEOz
         mxkG6hcuNZC1NM94capcIUbsN2NWauNTEZQn56ShrcMvd2rsWkuct8PwtmO7xnVJQ3xN
         J6zAH3jpoNu/dPEW6LYdWUQ5JqOHYXDRjyN1T0P/Oi3IxUDOTPsdnpEzJb3mAImzsHAZ
         vOMzaxYVA0fAD+52jn5f+yfeoIeKkGm6XTgbuPPdUZIctJCOhKszdt+MeE23/o4hezBT
         BXJLu2R+Vn4wtKxbgD22lxYH18rs7QX2uJpSFk6sf6t14Yr85rS9e7bE9ltN5Vf5X2n8
         yLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777320; x=1694382120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRU3YcmHhtMgrEwiKr0jiCPmTZjWFsu5C3QySeLjrFk=;
        b=gW86xxjSbILPxxPVzCP6sroKyctES4SZ7/wrA4QPnY0d9rcQMAyEOLcEGyPlNrSHsV
         7Zj9V2x9eW5IV6fJbp25KDbTNkoFmq0It9JoQxGl6YI/0ZX09XTOw7eWjkisAyS8IyhC
         o+ByJsuqpR8fwbS+v1AwnTsHiRetLTXDQjPtJHt5h6SlGg0WX+OScahwAy7pzI1X/zc2
         YA/PV1cyMKeIRd/pLv2AE7y+6mIAfMFlzC7TLYf0rdQNKEzZcfhhRg4m93Nr5cF4/u0q
         dGooa0sXADga5OxmFgxcVUdsls4bSnpWxD2JaxY5r3lwe5n6H26RO97swjdTaBqnc/Gk
         EG0g==
X-Gm-Message-State: AOJu0YwxhZCkI0ZwNDATSRNn0DM+uAMQppY9tDdcoLkidw53JpCOTLss
        zga7H7rurAdM++RPTmO9gVRk0g==
X-Google-Smtp-Source: AGHT+IFsqgNhsNbkZVa3cNm+AdNIgulADr18z4rrsHYsJZU44KXFgwMqPl+5UxHTsBskue63qdvb8w==
X-Received: by 2002:a05:6512:3b26:b0:4fb:caed:95c3 with SMTP id f38-20020a0565123b2600b004fbcaed95c3mr5991678lfv.53.1693777320290;
        Sun, 03 Sep 2023 14:42:00 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.59
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
Subject: [RFC PATCH v1 12/12] usb: typec: qcom: define the bridge's path
Date:   Mon,  4 Sep 2023 00:41:50 +0300
Message-Id: <20230903214150.2877023-13-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to notify the userspace about the DRM connector's USB-C port,
export the corresponding port's name as the bridge's path field.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c     | 11 +++++++----
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c |  4 +++-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h |  6 ++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index b9d4856101c7..452dc6437861 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -156,6 +156,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct pmic_typec_resources *res;
 	struct regmap *regmap;
+	char *tcpm_name;
 	u32 base[2];
 	int ret;
 
@@ -211,10 +212,6 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
-	tcpm->pmic_typec_drm = qcom_pmic_typec_init_drm(dev);
-	if (IS_ERR(tcpm->pmic_typec_drm))
-		return PTR_ERR(tcpm->pmic_typec_drm);
-
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (!tcpm->tcpc.fwnode)
 		return -EINVAL;
@@ -225,6 +222,12 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 		goto fwnode_remove;
 	}
 
+	tcpm_name = tcpm_port_get_name(tcpm->tcpm_port);
+	tcpm->pmic_typec_drm = qcom_pmic_typec_init_drm(dev, tcpm_name);
+	kfree(tcpm_name);
+	if (IS_ERR(tcpm->pmic_typec_drm))
+		return PTR_ERR(tcpm->pmic_typec_drm);
+
 	ret = qcom_pmic_typec_port_start(tcpm->pmic_typec_port,
 					 tcpm->tcpm_port);
 	if (ret)
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c
index e202eb7b52db..7bd7f4bf3539 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.c
@@ -21,7 +21,8 @@ static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
 	.attach = qcom_pmic_typec_attach,
 };
 
-struct pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev)
+struct pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev,
+						const char *path)
 {
 	struct pmic_typec_drm *tcpm_drm;
 
@@ -33,6 +34,7 @@ struct pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev)
 	tcpm_drm->bridge.of_node = of_get_child_by_name(dev->of_node, "connector");
 	tcpm_drm->bridge.ops = DRM_BRIDGE_OP_HPD;
 	tcpm_drm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+	tcpm_drm->bridge.path = devm_kstrdup(dev, path, GFP_KERNEL);
 
 	return ERR_PTR(devm_drm_bridge_add(dev, &tcpm_drm->bridge));
 }
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h
index 01f4bb71346b..259c047265f7 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_drm.h
@@ -9,9 +9,11 @@
 struct pmic_typec_drm;
 
 #if IS_ENABLED(CONFIG_DRM)
-struct pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev);
+struct pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev,
+						const char *path);
 #else
-static inline pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev)
+static inline pmic_typec_drm *qcom_pmic_typec_init_drm(struct device *dev,
+						       const char *path)
 {
 	return NULL;
 }
-- 
2.39.2

