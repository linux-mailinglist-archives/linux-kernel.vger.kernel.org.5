Return-Path: <linux-kernel+bounces-15099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024682273B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F141F2375A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A364A4A31;
	Wed,  3 Jan 2024 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzbiOiqo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71817996
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704250461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMt7lZjCiYyD0IatuGzXYEdVsPArKyHXFkUBPDO+8is=;
	b=rzbiOiqonwmAWpfAUA7RmoR8Qvz7aff/QP18gShTRo4K9/ITTdPBOBMGsQzFginEwyNYuR
	GS1Tm+z8D3XBADkl2sA26vGJdGx7xgZz97WKh8donTMzdRViHmO67seZGdknyVH26wGMbr
	RE4OZyJDrXhHqineE2q4jcdvLJACU0Q=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	przemyslaw.kitszel@intel.com,
	rmk+kernel@armlinux.org.uk,
	kabel@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next v2 2/2] net: phy: Introduce is_phy_device()
Date: Wed,  3 Jan 2024 10:53:34 +0800
Message-Id: <20240103025334.541682-3-yajun.deng@linux.dev>
In-Reply-To: <20240103025334.541682-1-yajun.deng@linux.dev>
References: <20240103025334.541682-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

MDIO_DEVICE_FLAG_PHY is the only flag that can be set in the
struct mdio_device. This flag is used to test that if it is a phy
device.

We can test that the type of the device is equal to mdio_bus_phy_type,
so that, the flags in struct mdio_device can be removed.

Introduce is_phy_device(), use it to test that if the device is a phy
device.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/net/phy/mdio_bus.c   | 7 +++----
 drivers/net/phy/phy_device.c | 8 ++++++--
 include/linux/mdio.h         | 3 ---
 include/linux/phy.h          | 1 +
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 69b8ddef9500..a80e6a7cbca5 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -75,7 +75,7 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr])
 		return -EBUSY;
 
-	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+	if (is_phy_device(&mdiodev->dev)) {
 		err = mdiobus_register_gpiod(mdiodev);
 		if (err)
 			return err;
@@ -125,7 +125,7 @@ struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr)
 	if (!mdiodev)
 		return NULL;
 
-	if (!(mdiodev->flags & MDIO_DEVICE_FLAG_PHY))
+	if (!is_phy_device(&mdiodev->dev))
 		return NULL;
 
 	return container_of(mdiodev, struct phy_device, mdio);
@@ -1345,8 +1345,7 @@ static int mdio_bus_match(struct device *dev, struct device_driver *drv)
 	struct mdio_device *mdio = to_mdio_device(dev);
 
 	/* Both the driver and device must type-match */
-	if (is_phy_driver(&mdiodrv->driver) ==
-	    !(mdio->flags & MDIO_DEVICE_FLAG_PHY))
+	if (is_phy_driver(&mdiodrv->driver) != is_phy_device(&mdio->dev))
 		return 0;
 
 	if (of_driver_match_device(dev, drv))
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 732cfec293dd..1e19956e9e8d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -640,6 +640,11 @@ static int phy_request_driver_module(struct phy_device *dev, u32 phy_id)
 	return 0;
 }
 
+bool is_phy_device(struct device *dev)
+{
+	return dev->type == &mdio_bus_phy_type;
+}
+
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 				     bool is_c45,
 				     struct phy_c45_device_ids *c45_ids)
@@ -660,7 +665,6 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	mdiodev->bus = bus;
 	mdiodev->bus_match = phy_bus_match;
 	mdiodev->addr = addr;
-	mdiodev->flags = MDIO_DEVICE_FLAG_PHY;
 	mdiodev->device_free = phy_mdio_device_free;
 	mdiodev->device_remove = phy_mdio_device_remove;
 	mdiodev->reset_state = -1;
@@ -3266,7 +3270,7 @@ struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode)
 	if (!mdiodev)
 		return NULL;
 
-	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY)
+	if (is_phy_device(&mdiodev->dev))
 		return to_phy_device(&mdiodev->dev);
 
 	put_device(&mdiodev->dev);
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 852f838f52f5..8364e2d0c269 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -37,7 +37,6 @@ struct mdio_device {
 
 	/* Bus address of the MDIO device (0-31) */
 	int addr;
-	int flags;
 	int reset_state;
 	struct gpio_desc *reset_gpio;
 	struct reset_control *reset_ctrl;
@@ -50,8 +49,6 @@ static inline struct mdio_device *to_mdio_device(const struct device *dev)
 	return container_of(dev, struct mdio_device, dev);
 }
 
-#define MDIO_DEVICE_FLAG_PHY		1
-
 /* struct mdio_driver: Generic MDIO driver */
 struct mdio_driver {
 	struct device_driver driver;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 603c440f09f6..7d10b44a475b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2156,5 +2156,6 @@ module_exit(phy_module_exit)
 bool phy_driver_is_genphy(struct phy_device *phydev);
 bool phy_driver_is_genphy_10g(struct phy_device *phydev);
 bool is_phy_driver(struct device_driver *driver);
+bool is_phy_device(struct device *dev);
 
 #endif /* __PHY_H */
-- 
2.25.1


