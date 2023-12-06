Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB8807C48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377661AbjLFX0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441811AbjLFXZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:25:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94988A5;
        Wed,  6 Dec 2023 15:26:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40bda47c489so3683835e9.3;
        Wed, 06 Dec 2023 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701905161; x=1702509961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PtocJM18WUz/9bnwDNM1XbvsGaiWt5uOf7PvLbW1SQ=;
        b=SCmhFBpTsZXOgGVCmUDPh1L5tfPSp98k+meLx+yzJ38wV7A3pzvpeczxUzgSvcA28N
         wYXr900ulG4CEJ9mmVha0TgBh4Nu0UMskNFcYxwlZ22vV0+iOyT9OXZIQHzsaHnicNHA
         EBryJT+D6Wh61b/MtvF0NXlubzDIEzWQyxJUO8k+IeuNAM4nCHlEJuayd5TuePMYMoIY
         /2oEMAbJAEYvFjkyXsSbykXH4hNOr0VVANOBwzbQ+HGWAbIveyhcxw91jrMeGTkcUgXG
         Ni3XHMFRb8X3Kzhpy1nCj1jvnaz5/fK6eu1cAz1xXMKRGcDsBXQy/mF2CYh+ZjYj7CQK
         9tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905161; x=1702509961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PtocJM18WUz/9bnwDNM1XbvsGaiWt5uOf7PvLbW1SQ=;
        b=WMuFljglcTppPj8mRH49Qi5K1UzwGbkuavDr96Vgq1v88gZHzQv0HtHyeOMjqNOctI
         BFqj79uehZaCFtJScvcLo5me+6Sw1rO3P2g261vgjUhHEXH8ES3FXYC6DzWVUUk2ubxR
         evGKKPS9NIws+LO8oHrV2gTgnylm2tST7ucXAZIEKBlct9aYGF+HiQ/p4b9zKhP8asFC
         CgexEN9Y0DtKhloDx/xEodiOrk4TTh/aEhFV023RDTk0QAg9wQiUPdcKUT1rX66Y4R9L
         l+zeLRv8qrxfaQhINFYSgby/9Fc6HCkUPXv9woohlL1xwcKwugx5zQZ2+LUhhRXpfXNy
         /6Eg==
X-Gm-Message-State: AOJu0YyDR1CI182+QAo2GBTnZoGXpfBDMGnrIO1HdDqJiAPWMp1JgSiy
        mEONCz9oy9bREGt7IpobsCo=
X-Google-Smtp-Source: AGHT+IHrsCwbLNcpzvfVh2Re3MvzpONZ3N2hPGUPJGgrB/R0804mioklN35TpdRLFDWJIGhM0cacpA==
X-Received: by 2002:a05:600c:43c3:b0:40c:591:59e1 with SMTP id f3-20020a05600c43c300b0040c059159e1mr963792wmn.153.1701905160601;
        Wed, 06 Dec 2023 15:26:00 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id n2-20020a5d51c2000000b0033339027c89sm718754wrv.108.2023.12.06.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:26:00 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v4 2/3] net: phy: restructure __phy_write/read_mmd to helper and phydev user
Date:   Thu,  7 Dec 2023 00:25:46 +0100
Message-Id: <20231206232547.2501-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206232547.2501-1-ansuelsmth@gmail.com>
References: <20231206232547.2501-1-ansuelsmth@gmail.com>
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

Restructure phy_write_mmd and phy_read_mmd to implement generic helper
for direct mdiobus access for mmd and use these helper for phydev user.

This is needed in preparation of PHY package API that requires generic
access to the mdiobus and are deatched from phydev struct but instead
access them based on PHY package base_addr and offsets.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Move to phy-core.c instead of inline in phy.h
Changes v2:
- Introduce this patch

 drivers/net/phy/phy-core.c | 64 ++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..b729ac8b2640 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -540,6 +540,28 @@ static void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
 			devad | MII_MMD_CTRL_NOINCR);
 }
 
+static int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
+			int devad, u32 regnum)
+{
+	if (is_c45)
+		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
+
+	mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	/* Read the content of the MMD's selected register */
+	return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
+}
+
+static int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
+			 int devad, u32 regnum, u16 val)
+{
+	if (is_c45)
+		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
+
+	mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	/* Write the data into MMD's selected register */
+	return __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+}
+
 /**
  * __phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.
@@ -551,26 +573,14 @@ static void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
  */
 int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 {
-	int val;
-
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->read_mmd) {
-		val = phydev->drv->read_mmd(phydev, devad, regnum);
-	} else if (phydev->is_c45) {
-		val = __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
-					 devad, regnum);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
+	if (phydev->drv && phydev->drv->read_mmd)
+		return phydev->drv->read_mmd(phydev, devad, regnum);
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
-
-		/* Read the content of the MMD's selected register */
-		val = __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
-	}
-	return val;
+	return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
+			    phydev->is_c45, devad, regnum);
 }
 EXPORT_SYMBOL(__phy_read_mmd);
 
@@ -607,28 +617,14 @@ EXPORT_SYMBOL(phy_read_mmd);
  */
 int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 {
-	int ret;
-
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->write_mmd) {
-		ret = phydev->drv->write_mmd(phydev, devad, regnum, val);
-	} else if (phydev->is_c45) {
-		ret = __mdiobus_c45_write(phydev->mdio.bus, phydev->mdio.addr,
-					  devad, regnum, val);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
+	if (phydev->drv && phydev->drv->write_mmd)
+		return phydev->drv->write_mmd(phydev, devad, regnum, val);
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
-
-		/* Write the data into MMD's selected register */
-		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
-
-		ret = 0;
-	}
-	return ret;
+	return mmd_phy_write(phydev->mdio.bus, phydev->mdio.addr,
+			     phydev->is_c45, devad, regnum, val);
 }
 EXPORT_SYMBOL(__phy_write_mmd);
 
-- 
2.40.1

