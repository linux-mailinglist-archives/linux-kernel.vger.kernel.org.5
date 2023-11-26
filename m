Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF87F96A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjKZXv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjKZXvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:51:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909A10F;
        Sun, 26 Nov 2023 15:51:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b402c36c4so8850715e9.1;
        Sun, 26 Nov 2023 15:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701042717; x=1701647517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF+z7Qj3nnOkw7ulJR8RUudV7hbfK2K0WF/z5k7nkeM=;
        b=I1bWzWnr7/jocbOWR2V+1WftfEUK+KNTP1JoJ9b69np04b2vKxqyEuLx9RPAqmrF63
         edeLeh/pV/R6xjQ3b/Mcq6NkhwkAcNu6YyZEbiiRfEAHm92RD9ul8JLy6AWEuAxoW8tM
         GmdQS5riR/uuhGaD7LmmN7OhEGIbzwvj5puENC7/W1RhTAMzYv87XeEPDsjanu6lmFBG
         x9s5T2Knb1ma1sgyyGzNyN/V9LqmS3BFlNFxVs61nP74KZh7oIMdC26crf6Gfiz4STyM
         BDW69dYPAMu1Mcha+CihGGd28g2fJDbDCgYles1EnBddrwnYfJItLeIzj7ip9WB5ZPVf
         HYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701042717; x=1701647517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF+z7Qj3nnOkw7ulJR8RUudV7hbfK2K0WF/z5k7nkeM=;
        b=SBpZ/6kOXotZDFujmuoDZi+imfOzDfZe51GJYOiyA8Q9zfBEO/s5o9UazpIma9sOiL
         kG66HTV7vmK5MPpj0iYyF4mfM0dA47P4E0GYPiH1/2HgrZc4dw6uXJJlmPBPwhInLtMr
         eIeyYSpFosDwqkoty+5DRt8duy4e8YHkCagdCj+Ne6uuwTxTeZsSXVaN5M5jaE+uMw8p
         zDiZScDXCnr+3OvcJ+aTrfED4C/Ps4NM7XIUsSSurYIGS9hW1daORi4DJSSyS7Zazod4
         nolugpjw07sfCZqD0k/f0iWEbUnwrAUsbPKR8Lns63lla6kAjJyAVvklWr1tk2qiQGDA
         7D/Q==
X-Gm-Message-State: AOJu0YyL1+o0WU/0Dl0zl5Aa+I8n/RjY/RcpZW/ILotnRD1HIxJHIh5a
        etoJPf/PMd+ATVWZcnvrmJw=
X-Google-Smtp-Source: AGHT+IFlAVY/HPlFFMbksINqw2y3ZoFPo4noy5Cxqd3oQu9Q7cwBHUniISeyQFfBXbHhnUaOsxyB9g==
X-Received: by 2002:a05:600c:3b16:b0:40b:4007:11f1 with SMTP id m22-20020a05600c3b1600b0040b400711f1mr3232906wms.11.1701042716716;
        Sun, 26 Nov 2023 15:51:56 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m4-20020a05600c4f4400b0040b3dbb5c93sm1202151wmq.1.2023.11.26.15.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:51:56 -0800 (PST)
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
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 3/4] net: phy: restructure __phy_write/read_mmd to helper and phydev user
Date:   Mon, 27 Nov 2023 00:51:40 +0100
Message-Id: <20231126235141.17996-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126235141.17996-1-ansuelsmth@gmail.com>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
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
Changes v2:
- Introduce this patch

 drivers/net/phy/phy-core.c | 42 ++++++++------------------------------
 include/linux/phy.h        | 22 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index b4f80847eefd..65d312889f3b 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -537,26 +537,14 @@ int phy_speed_down_core(struct phy_device *phydev)
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
-
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	if (phydev->drv && phydev->drv->read_mmd)
+		return phydev->drv->read_mmd(phydev, devad, regnum);
 
-		/* Read the content of the MMD's selected register */
-		val = __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
-	}
-	return val;
+	return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
+			    phydev->is_c45, devad, regnum);
 }
 EXPORT_SYMBOL(__phy_read_mmd);
 
@@ -593,28 +581,14 @@ EXPORT_SYMBOL(phy_read_mmd);
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
-
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
-
-		/* Write the data into MMD's selected register */
-		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+	if (phydev->drv && phydev->drv->write_mmd)
+		return phydev->drv->write_mmd(phydev, devad, regnum, val);
 
-		ret = 0;
-	}
-	return ret;
+	return mmd_phy_write(phydev->mdio.bus, phydev->mdio.addr,
+			     phydev->is_c45, devad, regnum, val);
 }
 EXPORT_SYMBOL(__phy_write_mmd);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a63d45880b1a..96f6f34be051 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1330,6 +1330,28 @@ static inline void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad
 			devad | MII_MMD_CTRL_NOINCR);
 }
 
+static inline int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
+			       int devad, u32 regnum)
+{
+	if (is_c45)
+		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
+
+	mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	/* Read the content of the MMD's selected register */
+	return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
+}
+
+static inline int mmd_phy_write(struct mii_bus *bus, int phy_addr, bool is_c45,
+				int devad, u32 regnum, u16 val)
+{
+	if (is_c45)
+		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
+
+	mmd_phy_indirect(bus, phy_addr, devad, regnum);
+	/* Write the data into MMD's selected register */
+	return __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+}
+
 /*
  * phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.
-- 
2.40.1

