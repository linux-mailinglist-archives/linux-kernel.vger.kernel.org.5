Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4817F14CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjKTNvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjKTNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D24D65;
        Mon, 20 Nov 2023 05:51:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso13342015e9.3;
        Mon, 20 Nov 2023 05:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488283; x=1701093083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkZZkQ+fhxkG3W91GuOjhKRxuNJAr/jVw9bM/JNE+9s=;
        b=J1+btUUb5WrurF6QYxTmgcKDcBACAHe7JecqQG9TaU/nGjgjop+jVcw2UQwd8WD/zT
         qTDGlnckUUg5WW/j0+38PGul3U7gP3YxWTG4fJFwPAsepM5vFu8wwc35hdWldFSFAqRW
         tX+HHQLCDRv47891OnVmT+Oc424B+olrIast+XdLvX2LmnCL1baWlGZoXc9yzhoAD9zO
         FWk/zGq3Ukfx7NKJw4Jmq2m3OFAdixqvSAGP4I75A2V9kSverqRZSeB7W34XpF7ogD3l
         f8M94ws1diEFoAeFvq2i49Gk7/NQF4aK+TnTnvP5zrzdxKBVfQceY1GKCukfSvx4Ku40
         psIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488283; x=1701093083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkZZkQ+fhxkG3W91GuOjhKRxuNJAr/jVw9bM/JNE+9s=;
        b=stdnmm8qSa9QElTAyfvX67b42xAa5++eTyBcrTR316hCI3MILRXebDCZ6sq/YKghFo
         xde2+fUnECCJHqMfeY+My2PmgjRVFnvxDlDR/HX8GjvGwyIGyUBbiO4o4DJTUJwqNSy5
         Kap7h8jMBRc8wTogYTDB+/sETDg0LhGbBW2SG9H7x0wNXfxJY/oqiRXupxLhttoypcUe
         fZb+DADfK8SSEujFu4bP6lBrJvnnP2yW0KIvhbDZ+wptQHV+FUvm/lvbPnkX3ePAb/xb
         zoxhjX0t/sL2mVrVqsiDoWzyOeWiA4kLN8gsabpxZHnpHLPzuJF5M6j8cdhcJjPynWyG
         kPzQ==
X-Gm-Message-State: AOJu0YzlDcGdYhlStmYAG2xt6J0BmumwSdCd/pWc0lbI48J/cNZO0QQP
        vSnepkRDCKGWOf/wkRWm128=
X-Google-Smtp-Source: AGHT+IHHHmLbo0ls+ZfdjXnfQDFKRg9UMz3ucecEJfw4iq5blHC0EFBdWzjf+AlCouNSkFhaXzhm/Q==
X-Received: by 2002:a05:600c:3b8c:b0:407:5b54:bb10 with SMTP id n12-20020a05600c3b8c00b004075b54bb10mr5935396wms.8.1700488283168;
        Mon, 20 Nov 2023 05:51:23 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:22 -0800 (PST)
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 07/14] net: phy: add support for driver specific PHY package probe/config
Date:   Mon, 20 Nov 2023 14:50:34 +0100
Message-Id: <20231120135041.15259-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
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
index 91d17129b774..0b7ba6995929 100644
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
@@ -3386,6 +3393,13 @@ static int phy_probe(struct device *dev)
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
index 7c47c12cffa0..1849fc637196 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -924,12 +924,33 @@ struct phy_driver {
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

