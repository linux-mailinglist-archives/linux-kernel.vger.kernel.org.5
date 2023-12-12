Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548B80EBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbjLLMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346535AbjLLMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:37:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B0CA;
        Tue, 12 Dec 2023 04:37:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3332f1512e8so5216691f8f.2;
        Tue, 12 Dec 2023 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702384676; x=1702989476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+NoPfid+7puCdo9sPDvLb7zjUyvTkje5iwQvI0aUXs=;
        b=WfEvKaOC7IunAbmL2INIRuNOivmbuJS9r886wPoLsBadp1m0gSBTWEVPqlF7vmw6Hv
         Int2y/nhZtrJlH6fmSB2d1bz9KEBJVp/AmB0aeHDaiKeVwDsjbXB97Fv/RqqyPNaAOHf
         DESQad97cc9HmPbylzzcyh5yLsjgOdml+Uts6MsMQMw9FSl+6x4i4Kl8ZgCdIGVh0zaP
         iZaKprjQuDyRj0GkUsdjtUM7mEQaPLzJFIPnLJDMRlM49oqW0u951zrv7vd/8iumI5GG
         Q0LMS+H5s+QdH9FakGJIyrrRSvbaTN7j52fv+V+nQFO3+nX4sY2H/e8jbCsy2XPoYio2
         vRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384676; x=1702989476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+NoPfid+7puCdo9sPDvLb7zjUyvTkje5iwQvI0aUXs=;
        b=jx2Wgqg5D0I3y1+SPWQ8YIQkT9b5uWWaDzuObjWBe3OAvOb/OO2PzkTVIAw8jpYDqn
         iSlQHLSgnHF8mT7XO4Emx8dHCD1ZKOlZEQnMICHutuweYDe/GtBVUL1rLXKCFzcTvCFy
         iJrPg4gLpM4zmTTeKOMLxgYjtMlS4ZLX2p6IfS46y0y32mCX9LvPwXvHWdB3skpp/aO2
         iArdI5B3DyzrhNx61q/qk6ImNNxv9ceUkt+Gr/Z/baFSrqFX9ly7YUWLQ3/e/FjQxoUn
         V2OpER2jqLzMlhZ8Cir6TOEn1Uge1kIN5wSTUw516JchmOvuRyXF3P6OdmsXUlCNqfvk
         30lQ==
X-Gm-Message-State: AOJu0YxZGov1QJSA5ORPnIcS+l1RcgfHMDxxlUIQ/bppCkOym2FslrTY
        9W7k4BGtwUw4mdxZe1dMRHk=
X-Google-Smtp-Source: AGHT+IEHAHhVKkWk55roEEIbIKKtUna1tr6SgO8v6ZoCpb3I8MNpNNzue8zDqGm+cu8ZJUbIJ9oo4Q==
X-Received: by 2002:a05:600c:304a:b0:40c:233f:e02a with SMTP id n10-20020a05600c304a00b0040c233fe02amr3520971wmh.7.1702384675674;
        Tue, 12 Dec 2023 04:37:55 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o12-20020a05600c4fcc00b0040c552a1338sm214890wmq.1.2023.12.12.04.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:37:55 -0800 (PST)
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
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v5 3/3] net: phy: add support for PHY package MMD read/write
Date:   Tue, 12 Dec 2023 13:37:43 +0100
Message-Id: <20231212123743.29829-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212123743.29829-1-ansuelsmth@gmail.com>
References: <20231212123743.29829-1-ansuelsmth@gmail.com>
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

Some PHY in PHY package may require to read/write MMD regs to correctly
configure the PHY package.

Add support for these additional required function in both lock and no
lock variant.

It's assumed that the entire PHY package is either C22 or C45. We use
C22 or C45 way of writing/reading to mmd regs based on the passed phydev
whether it's C22 or C45.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v5:
- Improve function description
Changes v4:
- Drop function comments in header file
Changes v3:
- Move in phy-core.c from phy.h
- Base c45 from phydev
Changes v2:
- Rework to use newly introduced helper
- Add common check for regnum and devad

 drivers/net/phy/phy-core.c | 144 +++++++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  16 +++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index b729ac8b2640..8132ed83cff8 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -650,6 +650,150 @@ int phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 }
 EXPORT_SYMBOL(phy_write_mmd);
 
+/**
+ * __phy_package_read_mmd - read MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Convenience helper for reading a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for __phy_read();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_read(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			    regnum);
+}
+EXPORT_SYMBOL(__phy_package_read_mmd);
+
+/**
+ * phy_package_read_mmd - read MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Convenience helper for reading a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for phy_read();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int phy_package_read_mmd(struct phy_device *phydev,
+			 unsigned int addr_offset, int devad,
+			 u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+	int val;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	val = mmd_phy_read(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			   regnum);
+	phy_unlock_mdio_bus(phydev);
+
+	return val;
+}
+EXPORT_SYMBOL(phy_package_read_mmd);
+
+/**
+ * __phy_package_write_mmd - write MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to write to
+ * @regnum: The register on the MMD to write
+ * @val: value to write to @regnum
+ *
+ * Convenience helper for writing a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for __phy_write();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			     regnum, val);
+}
+EXPORT_SYMBOL(__phy_package_write_mmd);
+
+/**
+ * __phy_package_write_mmd - write MMD reg relative to PHY package base addr
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to write to
+ * @regnum: The register on the MMD to write
+ * @val: value to write to @regnum
+ *
+ * Convenience helper for writing a register of an MMD on a given PHY
+ * using the PHY package base address. The base address is added to
+ * the addr_offset value.
+ *
+ * Same calling rules as for phy_write();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int phy_package_write_mmd(struct phy_device *phydev,
+			  unsigned int addr_offset, int devad,
+			  u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+	int ret;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	ret = mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			    regnum, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+EXPORT_SYMBOL(phy_package_write_mmd);
+
 /**
  * phy_modify_changed - Function for modifying a PHY register
  * @phydev: the phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 51702e349d83..f58a9ff52e0d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2049,6 +2049,22 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum);
+
+int phy_package_read_mmd(struct phy_device *phydev,
+			 unsigned int addr_offset, int devad,
+			 u32 regnum);
+
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val);
+
+int phy_package_write_mmd(struct phy_device *phydev,
+			  unsigned int addr_offset, int devad,
+			  u32 regnum, u16 val);
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1

