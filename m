Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5328F810F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378420AbjLMK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjLMK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:58:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D429F7;
        Wed, 13 Dec 2023 02:58:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso69222025e9.2;
        Wed, 13 Dec 2023 02:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702465087; x=1703069887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjlDFU5MqEyExkF6mm44V/gH6aZZAPAMOeMwXvyUDrw=;
        b=REiI0Mf1hNfvYNbYSPmMP8QNM5wBMHmN+aIpx4YoFcrSCtmrDgpIePa64CYV/h2PlP
         BKlfdvTNOmjYPDjpfYCcNWKaQb3uVRqH5xQ6HJkIHHIMCjxXYmLCy2ffjXnCHqJPWuhw
         CiDevJkPM84E9H2BMsVfiCff08RUxyh6y4jEa4B8gfkIWI1aW3qzotG4gmQt/7TabMC8
         tbFlHJrxRit1k1Gz+Ks46YXpyU056PHb5agkKyP3zwPFnubKSHuxBDM3RZKOnsKve0I0
         xgXh7pGufbGDr75ob/0QjbfjyjHqvUYLAa7SqxMbkTmM2Jbr80S+t9c2JEkfjdzX02Jp
         JPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465087; x=1703069887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjlDFU5MqEyExkF6mm44V/gH6aZZAPAMOeMwXvyUDrw=;
        b=h1ubtXFM5nojLZ+c0SztHyOyqTjWlIapKsyL3uN9DNnXKxqjtuUlwtmy0gwUq7+nGy
         DtXV1x2VB/Va4KfCeH+0mNovCDQN+0D7zFGMBl492gZdDABpvsPCv3f45LMadW+mnxYG
         ZGZy1u9Zic//l6NzYLlOPn3HpASSzpjIGwQRKdtWRDVuKFYp/aR1DHGEGyljBeIl3Z+f
         L1DzJpajlCTC5gQFYF/OTM46zFcEqJoF7ZHuiRRBBY7yu5+bBb80XmN2ewEMq5DfUJ/v
         Eglin06lMT090qWqIBWK74LOR0olhgN2Jfom5bU+h14XpgovK5TLdmZbi4IbdailH/jT
         1Xrg==
X-Gm-Message-State: AOJu0YzyKXUrzf69XzGvuPbKMtsf1MCpa02MSLGzSKSBzlYCnanDI09l
        vf99JkD+4sQ7N4RpMmRcRnI=
X-Google-Smtp-Source: AGHT+IE4cKerE455hMpD/bdxxEDzShWroHEP1VCcHYTb3YZR+eIrXxWsJ96tc97GXeoaisea6+G84w==
X-Received: by 2002:a05:600c:4507:b0:40c:2b2b:6429 with SMTP id t7-20020a05600c450700b0040c2b2b6429mr3900738wmo.67.1702465086682;
        Wed, 13 Dec 2023 02:58:06 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05600c348b00b0040b400711f5sm22432385wmq.7.2023.12.13.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:58:06 -0800 (PST)
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
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH v6 3/3] net: phy: add support for PHY package MMD read/write
Date:   Wed, 13 Dec 2023 11:57:30 +0100
Message-Id: <20231213105730.1731-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213105730.1731-1-ansuelsmth@gmail.com>
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
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

Some PHY in PHY package may require to read/write MMD regs to correctly
configure the PHY package.

Add support for these additional required function in both lock and no
lock variant.

It's assumed that the entire PHY package is either C22 or C45. We use
C22 or C45 way of writing/reading to mmd regs based on the passed phydev
whether it's C22 or C45.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
- Fix copy paste error for kdoc
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
index b729ac8b2640..4c5927197557 100644
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
+ * phy_package_write_mmd - write MMD reg relative to PHY package base addr
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

