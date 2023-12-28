Return-Path: <linux-kernel+bounces-12483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073381F578
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CE72839F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6B4439;
	Thu, 28 Dec 2023 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZiDB7k0G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EE5232
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703748312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z5ScjGG+fLfzi4OChhexexLuOSRGIaTN7NsEav5gzyQ=;
	b=ZiDB7k0G3Bzo3Yr9CaAjKs4eVuxTUOG4YsjWKhk92n3t9XnTnH6THpFKEVR1cMoV+avgpF
	wFeCHTxlfDyXrL2chmp+xG5tX9XevvCgFe4dAKHL3k26ry/7H8qz5hHwatp6Mq9IfDtJ0V
	D7KxjpvU7jtNrHZX1PqKqK6nvdHa758=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk,
	kabel@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
Date: Thu, 28 Dec 2023 15:23:50 +0800
Message-Id: <20231228072350.1294425-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The struct mdio_driver_common is a wrapper for driver-model structure,
it contains device_driver and flags. There are only struct phy_driver
and mdio_driver that use it. The flags is used to distinguish between
struct phy_driver and mdio_driver.

We can test that if probe of device_driver is equal to phy_probe. This
way, the struct mdio_driver_common is no longer needed, and struct
phy_driver and usb_mdio_driver will be consistent with other driver
structs.

Cleanup struct mdio_driver_common and introduce is_phy_driver(). Use
is_phy_driver() test that if the driver is a phy or not.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/net/dsa/b53/b53_mdio.c          |  2 +-
 drivers/net/dsa/dsa_loop.c              |  2 +-
 drivers/net/dsa/lan9303_mdio.c          |  2 +-
 drivers/net/dsa/microchip/ksz8863_smi.c |  2 +-
 drivers/net/dsa/mt7530-mdio.c           |  2 +-
 drivers/net/dsa/mv88e6060.c             |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c        |  2 +-
 drivers/net/dsa/qca/ar9331.c            |  2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c        |  2 +-
 drivers/net/dsa/realtek/realtek-mdio.c  |  2 +-
 drivers/net/dsa/xrs700x/xrs700x_mdio.c  |  2 +-
 drivers/net/phy/mdio_bus.c              |  2 +-
 drivers/net/phy/mdio_device.c           | 21 +++++++--------
 drivers/net/phy/phy_device.c            | 35 ++++++++++++++-----------
 drivers/net/phy/xilinx_gmii2rgmii.c     |  2 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c  |  8 +++---
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c |  8 +++---
 include/linux/mdio.h                    | 16 ++---------
 include/linux/phy.h                     |  9 +++----
 19 files changed, 54 insertions(+), 69 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
index 897e5e8b3d69..1ececa4d44e4 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -392,7 +392,7 @@ static struct mdio_driver b53_mdio_driver = {
 	.probe	= b53_mdio_probe,
 	.remove	= b53_mdio_remove,
 	.shutdown = b53_mdio_shutdown,
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "bcm53xx",
 		.of_match_table = b53_of_match,
 	},
diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index c70ed67cc188..3f885878be3a 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -375,7 +375,7 @@ static void dsa_loop_drv_shutdown(struct mdio_device *mdiodev)
 }
 
 static struct mdio_driver dsa_loop_drv = {
-	.mdiodrv.driver	= {
+	.driver	= {
 		.name	= "dsa-loop",
 	},
 	.probe	= dsa_loop_drv_probe,
diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
index 167a86f39f27..7cb7e2b1478a 100644
--- a/drivers/net/dsa/lan9303_mdio.c
+++ b/drivers/net/dsa/lan9303_mdio.c
@@ -162,7 +162,7 @@ static const struct of_device_id lan9303_mdio_of_match[] = {
 MODULE_DEVICE_TABLE(of, lan9303_mdio_of_match);
 
 static struct mdio_driver lan9303_mdio_driver = {
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "LAN9303_MDIO",
 		.of_match_table = lan9303_mdio_of_match,
 	},
diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
index 5711a59e2ac9..c788cadd7595 100644
--- a/drivers/net/dsa/microchip/ksz8863_smi.c
+++ b/drivers/net/dsa/microchip/ksz8863_smi.c
@@ -213,7 +213,7 @@ static struct mdio_driver ksz8863_driver = {
 	.probe	= ksz8863_smi_probe,
 	.remove	= ksz8863_smi_remove,
 	.shutdown = ksz8863_smi_shutdown,
-	.mdiodrv.driver = {
+	.driver = {
 		.name	= "ksz8863-switch",
 		.of_match_table = ksz8863_dt_ids,
 	},
diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 088533663b83..7315654a6757 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -258,7 +258,7 @@ static struct mdio_driver mt7530_mdio_driver = {
 	.probe  = mt7530_probe,
 	.remove = mt7530_remove,
 	.shutdown = mt7530_shutdown,
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "mt7530-mdio",
 		.of_match_table = mt7530_of_match,
 	},
diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 294312b58e4f..5925f23e7ab3 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -367,7 +367,7 @@ static struct mdio_driver mv88e6060_driver = {
 	.probe	= mv88e6060_probe,
 	.remove = mv88e6060_remove,
 	.shutdown = mv88e6060_shutdown,
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "mv88e6060",
 		.of_match_table = mv88e6060_of_match,
 	},
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 383b3c4d6f59..4f24699264d1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7258,7 +7258,7 @@ static struct mdio_driver mv88e6xxx_driver = {
 	.probe	= mv88e6xxx_probe,
 	.remove = mv88e6xxx_remove,
 	.shutdown = mv88e6xxx_shutdown,
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "mv88e6085",
 		.of_match_table = mv88e6xxx_of_match,
 		.pm = &mv88e6xxx_pm_ops,
diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index 8d9d271ac3af..da392d60c9e7 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -1122,7 +1122,7 @@ static struct mdio_driver ar9331_sw_mdio_driver = {
 	.probe = ar9331_sw_probe,
 	.remove = ar9331_sw_remove,
 	.shutdown = ar9331_sw_shutdown,
-	.mdiodrv.driver = {
+	.driver = {
 		.name = AR9331_SW_NAME,
 		.of_match_table = ar9331_sw_of_match,
 	},
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec57d9d52072..fe396397f405 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -2187,7 +2187,7 @@ static struct mdio_driver qca8kmdio_driver = {
 	.probe  = qca8k_sw_probe,
 	.remove = qca8k_sw_remove,
 	.shutdown = qca8k_sw_shutdown,
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "qca8k",
 		.of_match_table = qca8k_of_match,
 		.pm = &qca8k_pm_ops,
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..8e6a951b391c 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -274,7 +274,7 @@ static const struct of_device_id realtek_mdio_of_match[] = {
 MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
 
 static struct mdio_driver realtek_mdio_driver = {
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "realtek-mdio",
 		.of_match_table = realtek_mdio_of_match,
 	},
diff --git a/drivers/net/dsa/xrs700x/xrs700x_mdio.c b/drivers/net/dsa/xrs700x/xrs700x_mdio.c
index 5f7d344b5d73..1a76d9d49f13 100644
--- a/drivers/net/dsa/xrs700x/xrs700x_mdio.c
+++ b/drivers/net/dsa/xrs700x/xrs700x_mdio.c
@@ -164,7 +164,7 @@ static const struct of_device_id __maybe_unused xrs700x_mdio_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, xrs700x_mdio_dt_ids);
 
 static struct mdio_driver xrs700x_mdio_driver = {
-	.mdiodrv.driver = {
+	.driver = {
 		.name	= "xrs700x-mdio",
 		.of_match_table = of_match_ptr(xrs700x_mdio_dt_ids),
 	},
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6cf73c15635b..a1092c641d14 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -1342,7 +1342,7 @@ static int mdio_bus_match(struct device *dev, struct device_driver *drv)
 	struct mdio_device *mdio = to_mdio_device(dev);
 
 	/* Both the driver and device must type-match */
-	if (!(mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY) !=
+	if (!(is_phy_driver(&mdiodrv->driver)) !=
 	    !(mdio->flags & MDIO_DEVICE_FLAG_PHY))
 		return 0;
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 73f6539b9e50..16232e7a1255 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -40,7 +40,7 @@ int mdio_device_bus_match(struct device *dev, struct device_driver *drv)
 	struct mdio_device *mdiodev = to_mdio_device(dev);
 	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
 
-	if (mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY)
+	if (is_phy_driver(&mdiodrv->driver))
 		return 0;
 
 	return strcmp(mdiodev->modalias, drv->name) == 0;
@@ -203,20 +203,19 @@ static void mdio_shutdown(struct device *dev)
  */
 int mdio_driver_register(struct mdio_driver *drv)
 {
-	struct mdio_driver_common *mdiodrv = &drv->mdiodrv;
 	int retval;
 
-	pr_debug("%s: %s\n", __func__, mdiodrv->driver.name);
+	pr_debug("%s: %s\n", __func__, drv->driver.name);
 
-	mdiodrv->driver.bus = &mdio_bus_type;
-	mdiodrv->driver.probe = mdio_probe;
-	mdiodrv->driver.remove = mdio_remove;
-	mdiodrv->driver.shutdown = mdio_shutdown;
+	drv->driver.bus = &mdio_bus_type;
+	drv->driver.probe = mdio_probe;
+	drv->driver.remove = mdio_remove;
+	drv->driver.shutdown = mdio_shutdown;
 
-	retval = driver_register(&mdiodrv->driver);
+	retval = driver_register(&drv->driver);
 	if (retval) {
 		pr_err("%s: Error %d in registering driver\n",
-		       mdiodrv->driver.name, retval);
+		       drv->driver.name, retval);
 
 		return retval;
 	}
@@ -227,8 +226,6 @@ EXPORT_SYMBOL(mdio_driver_register);
 
 void mdio_driver_unregister(struct mdio_driver *drv)
 {
-	struct mdio_driver_common *mdiodrv = &drv->mdiodrv;
-
-	driver_unregister(&mdiodrv->driver);
+	driver_unregister(&drv->driver);
 }
 EXPORT_SYMBOL(mdio_driver_unregister);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..55494a345bd4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -529,7 +529,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
 	int i;
 
-	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
+	if (!(is_phy_driver(&phydrv->driver)))
 		return 0;
 
 	if (phydrv->match_phy_device)
@@ -1456,9 +1456,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 */
 	if (!d->driver) {
 		if (phydev->is_c45)
-			d->driver = &genphy_c45_driver.mdiodrv.driver;
+			d->driver = &genphy_c45_driver.driver;
 		else
-			d->driver = &genphy_driver.mdiodrv.driver;
+			d->driver = &genphy_driver.driver;
 
 		using_genphy = true;
 	}
@@ -1638,14 +1638,14 @@ static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
 bool phy_driver_is_genphy(struct phy_device *phydev)
 {
 	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_driver.mdiodrv.driver);
+					 &genphy_driver.driver);
 }
 EXPORT_SYMBOL_GPL(phy_driver_is_genphy);
 
 bool phy_driver_is_genphy_10g(struct phy_device *phydev)
 {
 	return phy_driver_is_genphy_kind(phydev,
-					 &genphy_c45_driver.mdiodrv.driver);
+					 &genphy_c45_driver.driver);
 }
 EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
 
@@ -3410,6 +3410,12 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
+bool is_phy_driver(struct device_driver *driver)
+{
+	return driver->probe == phy_probe;
+}
+EXPORT_SYMBOL_GPL(is_phy_driver);
+
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3433,20 +3439,19 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	 * is backed by a struct phy_device. If such a case happens, we will
 	 * make out-of-bounds accesses and lockup in phydev->lock.
 	 */
-	if (WARN(new_driver->mdiodrv.driver.of_match_table,
+	if (WARN(new_driver->driver.of_match_table,
 		 "%s: driver must not provide a DT match table\n",
 		 new_driver->name))
 		return -EINVAL;
 
-	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
-	new_driver->mdiodrv.driver.name = new_driver->name;
-	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
-	new_driver->mdiodrv.driver.probe = phy_probe;
-	new_driver->mdiodrv.driver.remove = phy_remove;
-	new_driver->mdiodrv.driver.owner = owner;
-	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
+	new_driver->driver.name = new_driver->name;
+	new_driver->driver.bus = &mdio_bus_type;
+	new_driver->driver.probe = phy_probe;
+	new_driver->driver.remove = phy_remove;
+	new_driver->driver.owner = owner;
+	new_driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
-	retval = driver_register(&new_driver->mdiodrv.driver);
+	retval = driver_register(&new_driver->driver);
 	if (retval) {
 		pr_err("%s: Error %d in registering driver\n",
 		       new_driver->name, retval);
@@ -3479,7 +3484,7 @@ EXPORT_SYMBOL(phy_drivers_register);
 
 void phy_driver_unregister(struct phy_driver *drv)
 {
-	driver_unregister(&drv->mdiodrv.driver);
+	driver_unregister(&drv->driver);
 }
 EXPORT_SYMBOL(phy_driver_unregister);
 
diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 7fd9fe6a602b..94ba87dc1975 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -129,7 +129,7 @@ MODULE_DEVICE_TABLE(of, xgmiitorgmii_of_match);
 
 static struct mdio_driver xgmiitorgmii_driver = {
 	.probe	= xgmiitorgmii_probe,
-	.mdiodrv.driver = {
+	.driver = {
 		.name = "xgmiitorgmii",
 		.of_match_table = xgmiitorgmii_of_match,
 	},
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index 2c8b1b7dda5b..cb6e54e9a37e 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -229,11 +229,9 @@ static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 }
 
 static struct mdio_driver bcm_ns_usb3_mdio_driver = {
-	.mdiodrv = {
-		.driver = {
-			.name = "bcm_ns_mdio_usb3",
-			.of_match_table = bcm_ns_usb3_id_table,
-		},
+	.driver = {
+		.name = "bcm_ns_mdio_usb3",
+		.of_match_table = bcm_ns_usb3_id_table,
 	},
 	.probe = bcm_ns_usb3_mdio_probe,
 };
diff --git a/drivers/phy/broadcom/phy-bcm-ns2-pcie.c b/drivers/phy/broadcom/phy-bcm-ns2-pcie.c
index 2eaa41f8fc70..d23e19527379 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-pcie.c
@@ -73,11 +73,9 @@ static const struct of_device_id ns2_pci_phy_of_match[] = {
 MODULE_DEVICE_TABLE(of, ns2_pci_phy_of_match);
 
 static struct mdio_driver ns2_pci_phy_driver = {
-	.mdiodrv = {
-		.driver = {
-			.name = "phy-bcm-ns2-pci",
-			.of_match_table = ns2_pci_phy_of_match,
-		},
+	.driver = {
+		.name = "phy-bcm-ns2-pci",
+		.of_match_table = ns2_pci_phy_of_match,
 	},
 	.probe = ns2_pci_phy_probe,
 };
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 79ceee3c8673..852f838f52f5 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -50,22 +50,11 @@ static inline struct mdio_device *to_mdio_device(const struct device *dev)
 	return container_of(dev, struct mdio_device, dev);
 }
 
-/* struct mdio_driver_common: Common to all MDIO drivers */
-struct mdio_driver_common {
-	struct device_driver driver;
-	int flags;
-};
 #define MDIO_DEVICE_FLAG_PHY		1
 
-static inline struct mdio_driver_common *
-to_mdio_common_driver(const struct device_driver *driver)
-{
-	return container_of(driver, struct mdio_driver_common, driver);
-}
-
 /* struct mdio_driver: Generic MDIO driver */
 struct mdio_driver {
-	struct mdio_driver_common mdiodrv;
+	struct device_driver driver;
 
 	/*
 	 * Called during discovery.  Used to set
@@ -83,8 +72,7 @@ struct mdio_driver {
 static inline struct mdio_driver *
 to_mdio_driver(const struct device_driver *driver)
 {
-	return container_of(to_mdio_common_driver(driver), struct mdio_driver,
-			    mdiodrv);
+	return container_of(driver, struct mdio_driver, driver);
 }
 
 /* device driver data */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e9e85d347587..458bceb4a832 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -87,7 +87,6 @@ extern const int phy_10gbit_features_array[1];
 #define PHY_RST_AFTER_CLK_EN	0x00000002
 #define PHY_POLL_CABLE_TEST	0x00000004
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
-#define MDIO_DEVICE_IS_PHY	0x80000000
 
 /**
  * enum phy_interface_t - Interface Mode definitions
@@ -873,7 +872,7 @@ struct phy_led {
 /**
  * struct phy_driver - Driver structure for a particular PHY type
  *
- * @mdiodrv: Data common to all MDIO devices
+ * @driver: The driver-model core driver structure.
  * @phy_id: The result of reading the UID registers of this PHY
  *   type, and ANDing them with the phy_id_mask.  This driver
  *   only works for PHYs with IDs which match this field
@@ -894,7 +893,7 @@ struct phy_led {
  * though it is not currently supported in the driver).
  */
 struct phy_driver {
-	struct mdio_driver_common mdiodrv;
+	struct device_driver driver;
 	u32 phy_id;
 	char *name;
 	u32 phy_id_mask;
@@ -1147,8 +1146,7 @@ struct phy_driver {
 				  unsigned long *rules);
 
 };
-#define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
-				      struct phy_driver, mdiodrv)
+#define to_phy_driver(d) container_of(d, struct phy_driver, driver)
 
 #define PHY_ANY_ID "MATCH ANY PHY"
 #define PHY_ANY_UID 0xffffffff
@@ -2148,5 +2146,6 @@ module_exit(phy_module_exit)
 
 bool phy_driver_is_genphy(struct phy_device *phydev);
 bool phy_driver_is_genphy_10g(struct phy_device *phydev);
+bool is_phy_driver(struct device_driver *driver);
 
 #endif /* __PHY_H */
-- 
2.25.1


