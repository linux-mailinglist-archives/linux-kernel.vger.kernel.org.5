Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4457F8749
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbjKYAgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjKYAf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:35:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6519A8;
        Fri, 24 Nov 2023 16:35:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b36339549so15978825e9.1;
        Fri, 24 Nov 2023 16:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700872523; x=1701477323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIxvgOZ7CQB51UQDLaqUtiZU2S4aMllQ5M3VTMe+bkw=;
        b=O3lnM0KD0gFyaEhZ5f9EDf6ezgsJyGvW/tpW5kn8n0HtHmhilqRAdqcBxcPe+rzff9
         BK4GlcKdkpgEZOSXDh9LL48+hoI/vL6HGa6oUCs7sYTY4u7Gc/6rm5Aa7/NJBDvuJI/9
         z4spPtudX3BXQa69GyXduuxpKblordFVfllyffaOJb5v0/q2naF/WynMIKUlpITa7zSM
         xUXlQIX6sSR9jCvZxSFulsHWbI38JtIMf+xlNP0DmN6vHOfTLMuxH6ZSWrstwIqIBLXV
         05ZsZhSJuWaFjNrXWyctaviImgKqxPkSlA1BvWsSikXvbNUEC0Tw/XEghc7KsYPWcVic
         6Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700872523; x=1701477323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIxvgOZ7CQB51UQDLaqUtiZU2S4aMllQ5M3VTMe+bkw=;
        b=AltyZkiR9xfSMXMZ6zcblmqcu/4eXafLnNbGlPa/0z0XpiPOyGzo3gzuN0yugu5mhP
         sOu88/+V1+oLt/XYHjNQr5w6b0e+Epr93PyqybN22kqGYK+RoVer3sckz9C5CZ/VP8DV
         DYhZaFVhOOsGLEEJLucaIIsoJBpDq9iSQGAPRxIh4yIFR8vkEFNPi9Yag5GWZZAO068r
         j0vwZhjwwIVY5Em55Qblc3dy+u950qx22EQCgm6LY4hjWz+OV9TbzhdoGVj6uhivmIfm
         Z9nUAgxWlMs8tcM8UPa9hA+RoPKDW3JZKKEzbMnk3zeKyvrPY4cmFXlKjt38adStWalW
         YKLw==
X-Gm-Message-State: AOJu0YxRD76Z/7QQPyZHJ052lY9aizmedYp9YMbmKmCC/W8bp4Y10of1
        GRkvyTfolrRjFEgiym/X/Fc=
X-Google-Smtp-Source: AGHT+IH/mvvyiDwu8lL8P1HQUIBWCAEL0g1NitUnqWOlQjTwYyV/wmLg6LqR3UnY3YBLKXEQ++UQuQ==
X-Received: by 2002:a05:600c:3ca0:b0:40a:48af:4820 with SMTP id bg32-20020a05600c3ca000b0040a48af4820mr4085044wmb.30.1700872523082;
        Fri, 24 Nov 2023 16:35:23 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u13-20020a05600c00cd00b00405718cbeadsm4268005wmm.1.2023.11.24.16.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 16:35:22 -0800 (PST)
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
Subject: [net-next RFC PATCH v2 04/11] net: phy: add support for shared priv data size for PHY package in DT
Date:   Sat, 25 Nov 2023 01:11:20 +0100
Message-Id: <20231125001127.5674-5-ansuelsmth@gmail.com>
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

Add support for defining shared data size for PHY package defined in DT.

A PHY driver has to define the value .phy_package_priv_data_size to make
the generic OF PHY package function alloc priv data in the shared struct
for the PHY package.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 7 ++++++-
 include/linux/phy.h          | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f25bedb69b90..454dc8256e94 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3198,6 +3198,7 @@ static int of_phy_package(struct phy_device *phydev)
 	struct device_node *node = phydev->mdio.dev.of_node;
 	struct device_node *package_node;
 	const u8 *global_phys_offset;
+	int shared_priv_data_size;
 	int *global_phys_addr;
 	u8 global_phys_num;
 	u32 base_addr;
@@ -3236,8 +3237,12 @@ static int of_phy_package(struct phy_device *phydev)
 		global_phys_addr[i] = addr;
 	}
 
+	shared_priv_data_size = 0;
+	if (phydev->drv->phy_package_priv_data_size)
+		shared_priv_data_size = phydev->drv->phy_package_priv_data_size;
+
 	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, global_phys_addr,
-				    global_phys_num, 0);
+				    global_phys_num, shared_priv_data_size);
 	if (ret)
 		goto exit;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3f75ae85b740..4ddf08e89624 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -895,6 +895,8 @@ struct phy_led {
  *  global PHYs for PHY package global configuration.
  * @phy_package_global_phys_num: Num of the required global PHYs
  *   for PHY package global configuration.
+ * @phy_package_priv_data_size: Size of the priv data to alloc
+ *   for shared struct of PHY package.
  *
  * All functions are optional. If config_aneg or read_status
  * are not implemented, the phy core uses the genphy versions.
@@ -914,6 +916,7 @@ struct phy_driver {
 	const void *driver_data;
 	const u8 *phy_package_global_phys_offset;
 	const u8 phy_package_global_phys_num;
+	unsigned int phy_package_priv_data_size;
 
 	/**
 	 * @soft_reset: Called to issue a PHY software reset
-- 
2.40.1

