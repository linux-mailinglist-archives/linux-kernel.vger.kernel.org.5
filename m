Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6E7FBBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbjK1Nge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjK1Ngd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:36:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E6BC;
        Tue, 28 Nov 2023 05:36:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so15356615e9.2;
        Tue, 28 Nov 2023 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701178597; x=1701783397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PtocJM18WUz/9bnwDNM1XbvsGaiWt5uOf7PvLbW1SQ=;
        b=X02PSeDluLYybLIckm+ByL4seOqNVOU55IoJeAjz6QE69bsGBOPEfWGBaqkude+b5q
         EViH4tKYA72QnBCzKdjqr+qLCUMd+V60F2230XkH7Gzv8I86OFaksKpgXeMMt81KDwid
         8+nt7HViMQC4bAqKCQdY8OuSPj0kOijG8Dy5tYT8kbxmSj6kai8w55caIwBtlxPD6iSs
         IgPyP5ZQKp3yRCryvj7alpYOiBJlFCSRAkOz9pMNc632Dl6gqo6UBS616HiOvKI/aSdv
         jMwprLToIbfCTtVW87Q4WkqkuQMQpCbP1M1nC/SHyzo/2s5Tjj/4HdhaTTswOr7lRWaG
         kKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701178597; x=1701783397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PtocJM18WUz/9bnwDNM1XbvsGaiWt5uOf7PvLbW1SQ=;
        b=Luf3aZYDAiraz3soz8ef8PijrL7QBLISNUVhM5oh2Ea3FheLBjkmu9PGtt6E2SkhXk
         p9L8WkOm/7cj8PrMPg2komQqqvqnLSWDJmoRXbe9pp9FUb7uTxRNkYAoj6Kw8ssFhjTA
         wh+/hprQQAkiAnViefjvXkAHx1lxbEgGjT1n4ry9NiuKqv5EY5mauofr9wWnHFMAeVJo
         2+D7SuHrgjvej7NpDbicL8udZpOaNqchRs3flSehGLHVa9In7okwxTn+RlQ6UQaph3RT
         NHyJdkxDfIkDkk24Kh7gdxMuviOMSazKMRukBHIqQi2JQjXKKClYEg9gS4X/TEpu+odL
         hc/w==
X-Gm-Message-State: AOJu0Yxa94HiGffrNLT+WfYnOMr33D12rvfqPy7tY9rOVh1o1D4nUnST
        zb+1IZW/FEc23112Lv3WD7o=
X-Google-Smtp-Source: AGHT+IFqmOoUdzxoPYBTKeyCujmYngjUtNeA+KuMG7Iz+WGTaO0M7CJC3Glb/QcHRk19sHOE/f9Rtw==
X-Received: by 2002:a05:600c:684:b0:408:56ea:f061 with SMTP id a4-20020a05600c068400b0040856eaf061mr11843153wmn.24.1701178597364;
        Tue, 28 Nov 2023 05:36:37 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a8-20020adffb88000000b00333083a20e5sm3713132wrr.113.2023.11.28.05.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:36:37 -0800 (PST)
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
Subject: [net-next PATCH v3 2/3] net: phy: restructure __phy_write/read_mmd to helper and phydev user
Date:   Tue, 28 Nov 2023 14:36:29 +0100
Message-Id: <20231128133630.7829-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128133630.7829-1-ansuelsmth@gmail.com>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
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

