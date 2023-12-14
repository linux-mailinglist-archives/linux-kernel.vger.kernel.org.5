Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60A48131CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444165AbjLNNkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572940AbjLNMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:10:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DA7BD;
        Thu, 14 Dec 2023 04:10:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3360ae2392eso5630233f8f.2;
        Thu, 14 Dec 2023 04:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702555851; x=1703160651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZZO03R1yzWivtorMM7YimtX2jOHr2R8ovLMDu2TRDw=;
        b=P8fYQbIPxGLn2OlTZwHbNDLXIwTXCyDNqX4WGJssxWLCjyJRfcuEMb6/EPZMWuKJfY
         FxrNt2/BtGVUBejjRedVAzbysEvr1TMGNZd7dz8bkBBjNlo962U2LfNg5KZeq8BjBv0k
         HWLxOvQuAF3P18EKL9KlBJOVyOHaVlwvdTjh7/MEQ4+J2oxyzy0HkvNAPiiNqugS/9sx
         GSk+a2mjakkT8JYOpUUyA/SFPRevKh5i/H75Mgeuv33/WLL58IDWXTD2cNj3gkRRpS/3
         GSUrMlHOg4VVMiru3LXhiwn27h4GbdWCYmeSCT0MQOftAkJwsXd9eYd32PAieTRILrsF
         NOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555851; x=1703160651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZZO03R1yzWivtorMM7YimtX2jOHr2R8ovLMDu2TRDw=;
        b=nvUoUGLBTJzBkzQz0SBBW+t+tbJWhhZo4U8lUJMhuBY8Twgurg7M+CW8/e/rSebrYo
         X4NDKhXJfDD4px0XM+N1800HWircXAXF+d+naiFXjIiHpo///Z5DPkws4/0vGb9MNl9j
         MTQhWUO1wYSE25Ck4zGGqKKFQBy7Sf+oJbtvtZ7pFlZCcb7IHdbvqyMrHPtPuaXtEcdM
         0YPuHOuyCxKkAaHdBby2mLP4D7hGLM2LOwb4Ko50mYp84//cowgnGoCZgRffQIGDU3zS
         F0xvWcGW4Ftwuf73Av1McYEmOImhPoKP2HAGpjcaABRUXax9yHRPMR4PND6RoFJxG2WY
         iv1g==
X-Gm-Message-State: AOJu0Yxzeyo4PcocpMWLd4dlolBZaL1Tyz9ABbHmnp5BJYNudgpZtLa8
        1aYKDU5gn5tQ4waxdaPIqiQ=
X-Google-Smtp-Source: AGHT+IG3cKikeGHl/K5HCTzPU73CO4vqHyc3cy1XHpFFCdexi18awmhEu9S3wo3hAkLR39VGW5VxlQ==
X-Received: by 2002:a5d:5246:0:b0:336:42a9:c5e4 with SMTP id k6-20020a5d5246000000b0033642a9c5e4mr1132646wrc.118.1702555850618;
        Thu, 14 Dec 2023 04:10:50 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d12-20020adfa40c000000b003333fa3d043sm16026765wra.12.2023.12.14.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:10:50 -0800 (PST)
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
        Christian Marangi <ansuelsmth@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v7 3/4] net: phy: restructure __phy_write/read_mmd to helper and phydev user
Date:   Thu, 14 Dec 2023 13:10:25 +0100
Message-Id: <20231214121026.4340-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214121026.4340-1-ansuelsmth@gmail.com>
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
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

Restructure phy_write_mmd and phy_read_mmd to implement generic helper
for direct mdiobus access for mmd and use these helper for phydev user.

This is needed in preparation of PHY package API that requires generic
access to the mdiobus and are deatched from phydev struct but instead
access them based on PHY package base_addr and offsets.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes v6:
- Add Reviewed-by tag
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

