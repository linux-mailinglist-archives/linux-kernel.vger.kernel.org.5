Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3E7F90BD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjKZByB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjKZBxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:53:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D54133;
        Sat, 25 Nov 2023 17:53:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b399a6529so10317875e9.1;
        Sat, 25 Nov 2023 17:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700963638; x=1701568438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cA+b+Z27SOao2N4LtORUgnXkn4zzcEHGz0L7SXjLLnE=;
        b=QJJ7mKKHrIm6tuBMFtr1I+xWJLjVXGz3VkjeD3HzPlzyjMKegCWhFa2IkVob73B1Ys
         MPXsDE3KxXEbPenZlka6TKQeTYurc+/nSkfLyDhm1qoQTH9E5I5uvI8x/BjzYnL1LaQf
         A11S7GRWfq9emv+UcEM5oosL6K4yEpAP97roRwkBJP2nMrDNpnTC9q0QQLpR5cUa5nVk
         r/0RV+7S8f1Kz5CuO9Xx8FJODaIM7JfOvGEP4ClMTbjbIvO4Owfb3MNqgcvOzm5bmp7c
         OWi3/VAdxN+rNyAlREehJqb0csP4u9hu5uvPb79AUsojseE9seTpQnYM6FO+BXbkyWrb
         YSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700963638; x=1701568438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA+b+Z27SOao2N4LtORUgnXkn4zzcEHGz0L7SXjLLnE=;
        b=D6tgUOjvsrp0AZ8+gYoiPin1ChhKjolbLaR4jyGsglnZvIwbF0s1GiwQ3B4O5Y5kui
         epwpbiwexSum0aZm7bjRp1DQHNd9LbDKioX+qFKcb9MvJWLY4jWbq4fWHRNBMN79+7DE
         DDI7zzl5gfQRGpayUOzjU8Wju91Ei1LrjXZKQeggHBFPXTJaQOcdlW41a6XvYDGZO/6o
         W1uuFiGWgX5eXU/GHyBfetzLCyF+dFSBjgHYOYjsIZmr5zUJRYzM8dbpQTNRwyMC4KIQ
         AMAyh5keahkfdAT0UvvINCkFz8nWHkDMK7NonAEu/tF5F3j/LBriEGeFGNDYjqsLJKTE
         /DBg==
X-Gm-Message-State: AOJu0Ywh40BWaAjh5Mr81vuSc+FoyBEbsPVVWTCtSInWaalQlBQuEaNm
        uO+pO63u+TnH5F3hd+++/Yk=
X-Google-Smtp-Source: AGHT+IHc9ZwZx9ba3AOZTxai5SOo2xvppKqSsbXSzk/nEutwu5cewKivimHy3Dmbx6B/ya9WeEnOFg==
X-Received: by 2002:a05:600c:4ec8:b0:40b:3e6d:7a9d with SMTP id g8-20020a05600c4ec800b0040b3e6d7a9dmr3442845wmq.15.1700963638036;
        Sat, 25 Nov 2023 17:53:58 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id p34-20020a05600c1da200b00406408dc788sm9875344wms.44.2023.11.25.17.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:53:57 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next PATCH RFC v3 4/8] net: phy: add support for driver specific PHY package probe/config
Date:   Sun, 26 Nov 2023 02:53:42 +0100
Message-Id: <20231126015346.25208-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126015346.25208-1-ansuelsmth@gmail.com>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY driver specific function to probe and configure PHY package.
These function are run only once before the PHY probe and config_init.

They are used in conjunction with DT PHY package define for basic PHY
package implementation to setup and probe PHY package with simple
functions directly defined in the PHY driver struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 14 ++++++++++++++
 include/linux/phy.h          | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 87f06b4ecbfe..d52eb4ff4dac 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1246,6 +1246,13 @@ int phy_init_hw(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	if (phydev->drv->phy_package_config_init_once &&
+	    phy_package_init_once(phydev)) {
+		ret = phydev->drv->phy_package_config_init_once(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (phydev->drv->config_init) {
 		ret = phydev->drv->config_init(phydev);
 		if (ret < 0)
@@ -3325,6 +3332,13 @@ static int phy_probe(struct device *dev)
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
+	if (phydev->drv->phy_package_probe_once &&
+	    phy_package_probe_once(phydev)) {
+		err = phydev->drv->phy_package_probe_once(phydev);
+		if (err)
+			goto out;
+	}
+
 	if (phydev->drv->probe) {
 		err = phydev->drv->probe(phydev);
 		if (err)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c4e6d0b3a86c..7df7a854fdeb 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -910,12 +910,33 @@ struct phy_driver {
 	 */
 	int (*soft_reset)(struct phy_device *phydev);
 
+	/**
+	 * @phy_package_config_init_once: Driver specific PHY package
+	 *   config init call
+	 * @def: PHY device to use to probe PHY package
+	 *
+	 * Called to initialize the PHY package, including after
+	 * a reset.
+	 * Called BEFORE PHY config_init.
+	 */
+	int (*phy_package_config_init_once)(struct phy_device *dev);
+
 	/**
 	 * @config_init: Called to initialize the PHY,
 	 * including after a reset
 	 */
 	int (*config_init)(struct phy_device *phydev);
 
+	/**
+	 * @phy_package_probe_once: Driver specific PHY package probe
+	 * @def: PHY device to use to probe PHY package
+	 *
+	 * Called during discovery once per PHY package. Used to set
+	 * up device-specific PHY package structures, if any.
+	 * Called BEFORE PHY probe.
+	 */
+	int (*phy_package_probe_once)(struct phy_device *dev);
+
 	/**
 	 * @probe: Called during discovery.  Used to set
 	 * up device-specific structures, if any
-- 
2.40.1

