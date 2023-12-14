Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081308131CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444155AbjLNNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572941AbjLNMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:10:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056E10F;
        Thu, 14 Dec 2023 04:10:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso50526485e9.1;
        Thu, 14 Dec 2023 04:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702555850; x=1703160650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmB3Hg5mUnAiKtjFslnmuImNUyMjHJbR340xJtomTLQ=;
        b=DJv9+txKRAAWgqKCcb9CccS2ZzWTl5LkFSQtltcZDgrdRDrrmjGOetY8YSJGqOY3yo
         ln4qL1fJ4vK6Rfntkalj550zEmzIENbNSdF4NEpJLy3pQq/jTVUhaU4TwYNZ5+SNiKvi
         yvBymzAjp9uKbyjBnJK/zVH1FjWU3yhBzIvLsrPsqdq7D7m58i5jX6tq8eavTv/cliAX
         7C+daRrjAb9i2dL+3kVWOSGSmVsgD9Cap8W8W/V8EBdYPMrEXtvP5dhneFQajMYGEXuQ
         kdKvXIIv2mvjUtt6gz/Zx7k2tq6DWWHq13igG1iUpG34DYhx9rV55bMjqEa9RFg2d4yF
         wD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555850; x=1703160650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmB3Hg5mUnAiKtjFslnmuImNUyMjHJbR340xJtomTLQ=;
        b=DtYFduIM7GrkcktD5Vu4Qhs/PcLmrRefwCsm7j3ZfmjYwb+NqwB+3kS06DK3CQs4Gy
         L2VeRrmx/zfmt8v7++joBuWYGPfIbwWvfQU/lqFKXpoHRkDGdU+bTdRh0wKDVxlfUEpJ
         ZP6OoYc2PiyjtB57xlMVt2OPkolyhsHis13jsWYKQPcqhCOwpeYxwVpEI4vLCcSuOKIv
         vzMaVYvAt38urc/RNE+dX/X1FSwRtqwO3OyQ3Rn8Uae8qHZc+khzgAiOfPKWhNqrw8oh
         lwSgYzzW81FuDkGFXYf3p/JRExJBMBc0DaGcFp8aWJLzccr6LzkUw2X3NWz+QGT4eLM+
         M/GA==
X-Gm-Message-State: AOJu0YzR59W5kCa0Y4ktYFSxzpR2I5++ooT7185btF0d6Ya08RKYRBfP
        N4zLs989aCQQXtphcJpju1g=
X-Google-Smtp-Source: AGHT+IGnOsBJcyHXfSiGryt9Xm7YhzHAkIb1dw6Vksv7QU5sWlYMDKwMCEX+uzb3TMLgsu1xR5OcEw==
X-Received: by 2002:a5d:654a:0:b0:336:48fc:1c1f with SMTP id z10-20020a5d654a000000b0033648fc1c1fmr435394wrv.107.1702555849455;
        Thu, 14 Dec 2023 04:10:49 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d12-20020adfa40c000000b003333fa3d043sm16026765wra.12.2023.12.14.04.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:10:49 -0800 (PST)
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
Subject: [net-next PATCH v7 2/4] net: phy: extend PHY package API to support multiple global address
Date:   Thu, 14 Dec 2023 13:10:24 +0100
Message-Id: <20231214121026.4340-3-ansuelsmth@gmail.com>
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

Current API for PHY package are limited to single address to configure
global settings for the PHY package.

It was found that some PHY package (for example the qca807x, a PHY
package that is shipped with a bundle of 5 PHY) requires multiple PHY
address to configure global settings. An example scenario is a PHY that
have a dedicated PHY for PSGMII/serdes calibrarion and have a specific
PHY in the package where the global PHY mode is set and affects every
other PHY in the package.

Change the API in the following way:
- Change phy_package_join() to take the base addr of the PHY package
  instead of the global PHY addr.
- Make __/phy_package_write/read() require an additional arg that
  select what global PHY address to use by passing the offset from the
  base addr passed on phy_package_join().

Each user of this API is updated to follow this new implementation
following a pattern where an enum is defined to declare the offset of the
addr.

We also drop the check if shared is defined as any user of the
phy_package_read/write is expected to use phy_package_join first. Misuse
of this will correctly trigger a kernel panic for NULL pointer
exception.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v7:
- Change addr to u8
Changes v2:
- Make kernel panic if shared is not init (bugged scenario)
- Fix some confusing comments

 drivers/net/phy/bcm54140.c       | 16 +++++++++----
 drivers/net/phy/mscc/mscc.h      |  5 ++++
 drivers/net/phy/mscc/mscc_main.c |  4 ++--
 drivers/net/phy/phy_device.c     | 35 ++++++++++++++-------------
 include/linux/phy.h              | 41 +++++++++++++++++++-------------
 5 files changed, 63 insertions(+), 38 deletions(-)

diff --git a/drivers/net/phy/bcm54140.c b/drivers/net/phy/bcm54140.c
index d43076592f81..2eea3d09b1e6 100644
--- a/drivers/net/phy/bcm54140.c
+++ b/drivers/net/phy/bcm54140.c
@@ -128,6 +128,10 @@
 #define BCM54140_DEFAULT_DOWNSHIFT 5
 #define BCM54140_MAX_DOWNSHIFT 9
 
+enum bcm54140_global_phy {
+	BCM54140_BASE_ADDR = 0,
+};
+
 struct bcm54140_priv {
 	int port;
 	int base_addr;
@@ -429,11 +433,13 @@ static int bcm54140_base_read_rdb(struct phy_device *phydev, u16 rdb)
 	int ret;
 
 	phy_lock_mdio_bus(phydev);
-	ret = __phy_package_write(phydev, MII_BCM54XX_RDB_ADDR, rdb);
+	ret = __phy_package_write(phydev, BCM54140_BASE_ADDR,
+				  MII_BCM54XX_RDB_ADDR, rdb);
 	if (ret < 0)
 		goto out;
 
-	ret = __phy_package_read(phydev, MII_BCM54XX_RDB_DATA);
+	ret = __phy_package_read(phydev, BCM54140_BASE_ADDR,
+				 MII_BCM54XX_RDB_DATA);
 
 out:
 	phy_unlock_mdio_bus(phydev);
@@ -446,11 +452,13 @@ static int bcm54140_base_write_rdb(struct phy_device *phydev,
 	int ret;
 
 	phy_lock_mdio_bus(phydev);
-	ret = __phy_package_write(phydev, MII_BCM54XX_RDB_ADDR, rdb);
+	ret = __phy_package_write(phydev, BCM54140_BASE_ADDR,
+				  MII_BCM54XX_RDB_ADDR, rdb);
 	if (ret < 0)
 		goto out;
 
-	ret = __phy_package_write(phydev, MII_BCM54XX_RDB_DATA, val);
+	ret = __phy_package_write(phydev, BCM54140_BASE_ADDR,
+				  MII_BCM54XX_RDB_DATA, val);
 
 out:
 	phy_unlock_mdio_bus(phydev);
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 7a962050a4d4..6a3d8a754eb8 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -416,6 +416,11 @@ struct vsc8531_private {
  * gpio_lock: used for PHC operations. Common for all PHYs as the load/save GPIO
  * is shared.
  */
+
+enum vsc85xx_global_phy {
+	VSC88XX_BASE_ADDR = 0,
+};
+
 struct vsc85xx_shared_private {
 	struct mutex gpio_lock;
 };
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 4171f01d34e5..6f74ce0ab1aa 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -711,7 +711,7 @@ int phy_base_write(struct phy_device *phydev, u32 regnum, u16 val)
 		dump_stack();
 	}
 
-	return __phy_package_write(phydev, regnum, val);
+	return __phy_package_write(phydev, VSC88XX_BASE_ADDR, regnum, val);
 }
 
 /* phydev->bus->mdio_lock should be locked when using this function */
@@ -722,7 +722,7 @@ int phy_base_read(struct phy_device *phydev, u32 regnum)
 		dump_stack();
 	}
 
-	return __phy_package_read(phydev, regnum);
+	return __phy_package_read(phydev, VSC88XX_BASE_ADDR, regnum);
 }
 
 u32 vsc85xx_csr_read(struct phy_device *phydev,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 478126f6b5bc..424cbb13de13 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1648,20 +1648,22 @@ EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
 /**
  * phy_package_join - join a common PHY group
  * @phydev: target phy_device struct
- * @addr: cookie and PHY address for global register access
+ * @base_addr: cookie and base PHY address of PHY package for offset
+ *   calculation of global register access
  * @priv_size: if non-zero allocate this amount of bytes for private data
  *
  * This joins a PHY group and provides a shared storage for all phydevs in
  * this group. This is intended to be used for packages which contain
  * more than one PHY, for example a quad PHY transceiver.
  *
- * The addr parameter serves as a cookie which has to have the same value
- * for all members of one group and as a PHY address to access generic
- * registers of a PHY package. Usually, one of the PHY addresses of the
- * different PHYs in the package provides access to these global registers.
+ * The base_addr parameter serves as cookie which has to have the same values
+ * for all members of one group and as the base PHY address of the PHY package
+ * for offset calculation to access generic registers of a PHY package.
+ * Usually, one of the PHY addresses of the different PHYs in the package
+ * provides access to these global registers.
  * The address which is given here, will be used in the phy_package_read()
- * and phy_package_write() convenience functions. If your PHY doesn't have
- * global registers you can just pick any of the PHY addresses.
+ * and phy_package_write() convenience functions as base and added to the
+ * passed offset in those functions.
  *
  * This will set the shared pointer of the phydev to the shared storage.
  * If this is the first call for a this cookie the shared storage will be
@@ -1671,17 +1673,17 @@ EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
  * Returns < 1 on error, 0 on success. Esp. calling phy_package_join()
  * with the same cookie but a different priv_size is an error.
  */
-int phy_package_join(struct phy_device *phydev, int addr, size_t priv_size)
+int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size)
 {
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct phy_package_shared *shared;
 	int ret;
 
-	if (addr < 0 || addr >= PHY_MAX_ADDR)
+	if (base_addr < 0 || base_addr >= PHY_MAX_ADDR)
 		return -EINVAL;
 
 	mutex_lock(&bus->shared_lock);
-	shared = bus->shared[addr];
+	shared = bus->shared[base_addr];
 	if (!shared) {
 		ret = -ENOMEM;
 		shared = kzalloc(sizeof(*shared), GFP_KERNEL);
@@ -1693,9 +1695,9 @@ int phy_package_join(struct phy_device *phydev, int addr, size_t priv_size)
 				goto err_free;
 			shared->priv_size = priv_size;
 		}
-		shared->addr = addr;
+		shared->base_addr = base_addr;
 		refcount_set(&shared->refcnt, 1);
-		bus->shared[addr] = shared;
+		bus->shared[base_addr] = shared;
 	} else {
 		ret = -EINVAL;
 		if (priv_size && priv_size != shared->priv_size)
@@ -1733,7 +1735,7 @@ void phy_package_leave(struct phy_device *phydev)
 		return;
 
 	if (refcount_dec_and_mutex_lock(&shared->refcnt, &bus->shared_lock)) {
-		bus->shared[shared->addr] = NULL;
+		bus->shared[shared->base_addr] = NULL;
 		mutex_unlock(&bus->shared_lock);
 		kfree(shared->priv);
 		kfree(shared);
@@ -1752,7 +1754,8 @@ static void devm_phy_package_leave(struct device *dev, void *res)
  * devm_phy_package_join - resource managed phy_package_join()
  * @dev: device that is registering this PHY package
  * @phydev: target phy_device struct
- * @addr: cookie and PHY address for global register access
+ * @base_addr: cookie and base PHY address of PHY package for offset
+ *   calculation of global register access
  * @priv_size: if non-zero allocate this amount of bytes for private data
  *
  * Managed phy_package_join(). Shared storage fetched by this function,
@@ -1760,7 +1763,7 @@ static void devm_phy_package_leave(struct device *dev, void *res)
  * phy_package_join() for more information.
  */
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
-			  int addr, size_t priv_size)
+			  int base_addr, size_t priv_size)
 {
 	struct phy_device **ptr;
 	int ret;
@@ -1770,7 +1773,7 @@ int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 	if (!ptr)
 		return -ENOMEM;
 
-	ret = phy_package_join(phydev, addr, priv_size);
+	ret = phy_package_join(phydev, base_addr, priv_size);
 
 	if (!ret) {
 		*ptr = phydev;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5e29fca4d17..aaec34389f48 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -327,7 +327,8 @@ struct mdio_bus_stats {
 
 /**
  * struct phy_package_shared - Shared information in PHY packages
- * @addr: Common PHY address used to combine PHYs in one package
+ * @base_addr: Base PHY address of PHY package used to combine PHYs
+ *   in one package and for offset calculation of phy_package_read/write
  * @refcnt: Number of PHYs connected to this shared data
  * @flags: Initialization of PHY package
  * @priv_size: Size of the shared private data @priv
@@ -338,7 +339,7 @@ struct mdio_bus_stats {
  * phy_package_leave().
  */
 struct phy_package_shared {
-	u8 addr;
+	u8 base_addr;
 	refcount_t refcnt;
 	unsigned long flags;
 	size_t priv_size;
@@ -1972,10 +1973,10 @@ int phy_ethtool_get_link_ksettings(struct net_device *ndev,
 int phy_ethtool_set_link_ksettings(struct net_device *ndev,
 				   const struct ethtool_link_ksettings *cmd);
 int phy_ethtool_nway_reset(struct net_device *ndev);
-int phy_package_join(struct phy_device *phydev, int addr, size_t priv_size);
+int phy_package_join(struct phy_device *phydev, int base_addr, size_t priv_size);
 void phy_package_leave(struct phy_device *phydev);
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
-			  int addr, size_t priv_size);
+			  int base_addr, size_t priv_size);
 
 int __init mdio_bus_init(void);
 void mdio_bus_exit(void);
@@ -1998,46 +1999,54 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 		       struct kernel_hwtstamp_config *config,
 		       struct netlink_ext_ack *extack);
 
-static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
+static inline int phy_package_read(struct phy_device *phydev,
+				   unsigned int addr_offset, u32 regnum)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	u8 addr = shared->base_addr + addr_offset;
 
-	if (!shared)
+	if (addr >= PHY_MAX_ADDR)
 		return -EIO;
 
-	return mdiobus_read(phydev->mdio.bus, shared->addr, regnum);
+	return mdiobus_read(phydev->mdio.bus, addr, regnum);
 }
 
-static inline int __phy_package_read(struct phy_device *phydev, u32 regnum)
+static inline int __phy_package_read(struct phy_device *phydev,
+				     unsigned int addr_offset, u32 regnum)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	u8 addr = shared->base_addr + addr_offset;
 
-	if (!shared)
+	if (addr >= PHY_MAX_ADDR)
 		return -EIO;
 
-	return __mdiobus_read(phydev->mdio.bus, shared->addr, regnum);
+	return __mdiobus_read(phydev->mdio.bus, addr, regnum);
 }
 
 static inline int phy_package_write(struct phy_device *phydev,
-				    u32 regnum, u16 val)
+				    unsigned int addr_offset, u32 regnum,
+				    u16 val)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	u8 addr = shared->base_addr + addr_offset;
 
-	if (!shared)
+	if (addr >= PHY_MAX_ADDR)
 		return -EIO;
 
-	return mdiobus_write(phydev->mdio.bus, shared->addr, regnum, val);
+	return mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
 static inline int __phy_package_write(struct phy_device *phydev,
-				      u32 regnum, u16 val)
+				      unsigned int addr_offset, u32 regnum,
+				      u16 val)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	u8 addr = shared->base_addr + addr_offset;
 
-	if (!shared)
+	if (addr >= PHY_MAX_ADDR)
 		return -EIO;
 
-	return __mdiobus_write(phydev->mdio.bus, shared->addr, regnum, val);
+	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
 static inline bool __phy_package_set_once(struct phy_device *phydev,
-- 
2.40.1

