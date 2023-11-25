Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CDB7F873C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjKYAfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjKYAfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:35:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37B19A3;
        Fri, 24 Nov 2023 16:35:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332e42469f0so1304018f8f.1;
        Fri, 24 Nov 2023 16:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700872525; x=1701477325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AwvqFzZJu6lRLjlg2HSWxHNqqoUH9PNhraV2LjOZjE=;
        b=m07uCMjjzBaNfUSsT35g7VNUL5K0jkBMNzOT6zekSQMIBG1WbeUttlfr3pHGu0CgUQ
         sVV0Psa6vNw5Qc/2ZaeExlU6ri1aJoY/hvAr1HOUyQTyguyP7Jt+8wnXpOF4hqVquzpn
         sxVk7pbuRMn6Y+R0kpkpgyQ+RLxocsb/vANVRlfbClL3+kO95ntzhwEE9Bi25Y5puRlR
         LIwmuzEdrcGDMNBLryIDCf86KuqdHypGPC/sjSyJy3vTj083ElVNhf8HVyVe8sSSECGv
         jHy+fzx1P4/fjyjDIwPIKIYBbGDwTVAp5kHuQLsfCZxGVhadnhLm5T+xS2ojoMv4NJNz
         n5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700872525; x=1701477325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AwvqFzZJu6lRLjlg2HSWxHNqqoUH9PNhraV2LjOZjE=;
        b=T3ZsMybyAsHpHLVVJE4x+V1AUCURjctKJLdug1XpS97PClRdz80NGb1832HBkn2A6H
         xPkIb0VmygBIwO8GaCTbpszyqzMFz0oZ/mAOdVBzgyOFhQzFgRGGDspAGv68/qM2UWqd
         wn+m/k7IFgm1St8e9YBrslrK9PwiWX8U83O6vlnQqdiTnRm4M/AdXkpng+pxygkOkSog
         ot/OqZwtoDFoag6upgxZd6jwgVNtiqcA7MR0LtzEm7BS+BLfkqnk6xMLKXzRhID/cH/W
         ajFkdh7Ymh9IpkB8xnnDResvYUq42BJyd3D7ZWYnYjhvWxDcBj3qqQwB9c69aKews3pi
         kAdw==
X-Gm-Message-State: AOJu0YzqEyU2nMuzBIaaFfYNu/YuKZdDFjYu97Pc1HgkQVwgcUOAzJfu
        qY/0jL0+TeY4Sq4DaZwu7VE=
X-Google-Smtp-Source: AGHT+IFhMHZ210TeORBHK1rDSRJCNFUs5mH89ZCrVUsQ18913rgA5ad1O9jEGVX3aTh0gMhWj4aTdw==
X-Received: by 2002:adf:e911:0:b0:32d:8bf9:1990 with SMTP id f17-20020adfe911000000b0032d8bf91990mr4003007wrm.37.1700872524729;
        Fri, 24 Nov 2023 16:35:24 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u13-20020a05600c00cd00b00405718cbeadsm4268005wmm.1.2023.11.24.16.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 16:35:24 -0800 (PST)
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
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH v2 05/11] net: phy: add support for driver specific PHY package probe/config
Date:   Sat, 25 Nov 2023 01:11:21 +0100
Message-Id: <20231125001127.5674-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125001127.5674-1-ansuelsmth@gmail.com>
References: <20231125001127.5674-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 454dc8256e94..d7cfeb1011c1 100644
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
@@ -3370,6 +3377,13 @@ static int phy_probe(struct device *dev)
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
index 4ddf08e89624..677b5bceac45 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -923,12 +923,33 @@ struct phy_driver {
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

