Return-Path: <linux-kernel+bounces-55384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11F84BBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A437B28707B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF01134AF;
	Tue,  6 Feb 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP6l12jE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F20DDD1;
	Tue,  6 Feb 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240771; cv=none; b=mq8xwMeCFuNy3+v+fI8661bjWIZ/cHKSxCAjEaTy2w5PxyfwaTJ6qlhxn6qWkRcJ9Vo72Ep6DIttojLnWA6ueK7aQ1hxIfsVPTWZ0yQC9k7VyYqCy4M351Joty113lbKpr+jpWlbPO+MMXUAlJY585EjmZjEuAQy2oj9Pk6a1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240771; c=relaxed/simple;
	bh=QUMd/pymTNWROMEPvOP0tST5nIvBnoIZpBFhJ64dhxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBHqz+aDmbKEJ1v6KI2phuNQBkFNf8O7lXUWv+CUIBO0IUcpWGY2X8e60W52bilGTXILUrH3uFJ3S2Rss6c4pJII9QkY7AtfvGV+mS66mXBMZAJ+q6wwqq9AjFfVPABtLopN5j/eUpW5Ibi1relvhHjBQxA9ARGy9aFeRqzw9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP6l12jE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso40290525e9.0;
        Tue, 06 Feb 2024 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240768; x=1707845568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozVMLwHgKVfJzWQo5tW7oNNWQr0MV/j4f/0n469yn4M=;
        b=dP6l12jEDwL0nFb2AG91RjSGYMfHO++HC1L4NsGxRLDj9d3W9XmKMTDNXNYqq0vrXa
         ZSXu0UIqjSyNgSmvmFwahQa974iHwCTPLr5g7hOeG9st8+Zk42c2gvTFclOCr1sDhXD0
         e9hE5k601cg4gIGQqTbF0vgtQsKXMMKD4iDuzMkqJ/DM494IguOZSXLrncUQ0A9setDS
         9iX5/zT+T8UhxrejNS84PdcM/cAoy9DozoewJ9dOaIg/wq4Ii1kHbtQjkLnIpA7/aIdy
         ARuNXZ59dQ3CIBcMIRrc/lVXlXv8V4+3c9EEzpwrUQae4JBdPg/ln8iXCk50bJEhJZSR
         oS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240768; x=1707845568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozVMLwHgKVfJzWQo5tW7oNNWQr0MV/j4f/0n469yn4M=;
        b=LVP/l9mJQqs3tI7Q1rjtQAV8QS/qo3u/9kxZEZPHZuwYgf0WGT5KFh0FsIlNwNst6I
         xGv69RR1WeFV4bu7r1vVH5z5IJ6N8nwPL0KbEyIptov5DQhaG2ipuBQf46tV5mscCCTX
         g1qYF9aLOz+478pNsSTHFxMJMcUFpxSElwvPxcxb8vwdSY5efntr83MB6s/p3t8ZGwt9
         4xobkXSCz4njYMkeSQPHa45hSFxqs52Ch2AC8uJZBwtGpJFBigXO/MwiH73E611BBCko
         J3Yiq8r1TraxxgYFU8rOsox96zxHuf+q+b06c/HJzwja3zAAWvgCQtrKjURzh23lcR7r
         lCPw==
X-Gm-Message-State: AOJu0YxES0I8iZrW5RFSP41nY4PC5Hx3HJk9JLHX+zOn+kqsametl2A1
	9WCERznsiFqh3NwIiEyK3DW/PsIOVxg1i7nJuN8jDf3SS5W2QAgv
X-Google-Smtp-Source: AGHT+IEBLpApb+LxBXAabUuA8e10rK+BQT+ZJjUfzWLg9z2FjfwHSKf72/VG6KVh++I8NCyD9vgs2g==
X-Received: by 2002:a05:600c:3110:b0:40f:b45c:85a5 with SMTP id g16-20020a05600c311000b0040fb45c85a5mr2638988wmo.22.1707240768263;
        Tue, 06 Feb 2024 09:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMk2tfBb85O2ZSqSWF0VUoKPMlWjcKdDOxIqrvE6crIr3rihFepAjlUmvhZDBIFrlXguD2NHeHPdmVd0IdxtcrUb2XCSn/TegFddWNlmB4U2vLZPq/TZzGm2go2JowvzVEflqddhd5TOQkPXQfjVa3r0LVu/AphoxVVW2PqibxLivJKLjzhF9K1OsaMwG3K70LeedXZQbaA1eqSGIXq2X5WgqgV6A/kDdnV0iJJPbXsKr/9uo2vyk0OpYCndVB32U/PlEl9uvfY1aAFO2CEfcSUxzHlpB7n7U2UB9/TDUJdqygdAKd6OguxeTi3MyKGHfZkPDhsKkhHaO8EMHFdkA1ehhc8q+4lTNdXepnPrqS6O3ZIwYSd3A3oc9RiY7/CFr+/fYp7LkMQ+hmMf8t0IdQObX6AUzWpaSwlPxzYRNZgUNkz58xbCuEQgTHwHPuppnbob7zMFAr8CqmLt5gBbKVOIjXDKa7l1pixeza86o2uNWbdQpPqdn53JfXD5kd+IubhBfP3fFe+evqukCtlibhHR5xeuKoY0sItFjQhTfh7ccpxB8jdabPKyeXcLnJMY60MDGNBW8qhJpJ4d0nPmLzqV4fMDMsHdsXzrL2nrb99G7XNp8oz+N0tD0nNqfbptTgxA0L65lT2IrQFeLhXGV/eAejtLGfaL1qTthHv5Z7aSxZd0yWMQ==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:32:35 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 02/10] net: phy: add support for scanning PHY in PHY packages nodes
Date: Tue,  6 Feb 2024 18:31:05 +0100
Message-ID: <20240206173115.7654-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for scanning PHY in PHY package nodes. PHY packages nodes
are just container for actual PHY on the MDIO bus.

Their PHY address defined in the PHY package node are absolute and
reflect the address on the MDIO bus.

mdio_bus.c and of_mdio.c is updated to now support and parse also
PHY package subnode by checking if the node name match
"ethernet-phy-package".

As PHY package reg is mandatory and each PHY in the PHY package must
have a reg, every invalid PHY Package node is ignored and will be
skipped by the autoscan fallback.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 79 +++++++++++++++++++++++++++-----------
 drivers/net/phy/mdio_bus.c | 44 +++++++++++++++++----
 2 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 64ebcb6d235c..08e607f62e10 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -139,6 +139,53 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 }
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
+static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
+				   bool *scanphys)
+{
+	struct device_node *child;
+	int addr, rc = 0;
+
+	/* Loop over the child nodes and register a phy_device for each phy */
+	for_each_available_child_of_node(np, child) {
+		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			/* Ignore invalid ethernet-phy-package node */
+			if (!of_property_present(child, "reg"))
+				continue;
+
+			rc = __of_mdiobus_parse_phys(mdio, child, NULL);
+			if (rc && rc != -ENODEV)
+				goto exit;
+
+			continue;
+		}
+
+		addr = of_mdio_parse_addr(&mdio->dev, child);
+		if (addr < 0) {
+			/* Skip scanning for invalid ethernet-phy-package node */
+			if (scanphys)
+				*scanphys = true;
+			continue;
+		}
+
+		if (of_mdiobus_child_is_phy(child))
+			rc = of_mdiobus_register_phy(mdio, child, addr);
+		else
+			rc = of_mdiobus_register_device(mdio, child, addr);
+
+		if (rc == -ENODEV)
+			dev_err(&mdio->dev,
+				"MDIO device at address %d is missing.\n",
+				addr);
+		else if (rc)
+			goto exit;
+	}
+
+	return 0;
+exit:
+	of_node_put(child);
+	return rc;
+}
+
 /**
  * __of_mdiobus_register - Register mii_bus and create PHYs from the device tree
  * @mdio: pointer to mii_bus structure
@@ -180,33 +227,18 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		return rc;
 
 	/* Loop over the child nodes and register a phy_device for each phy */
-	for_each_available_child_of_node(np, child) {
-		addr = of_mdio_parse_addr(&mdio->dev, child);
-		if (addr < 0) {
-			scanphys = true;
-			continue;
-		}
-
-		if (of_mdiobus_child_is_phy(child))
-			rc = of_mdiobus_register_phy(mdio, child, addr);
-		else
-			rc = of_mdiobus_register_device(mdio, child, addr);
-
-		if (rc == -ENODEV)
-			dev_err(&mdio->dev,
-				"MDIO device at address %d is missing.\n",
-				addr);
-		else if (rc)
-			goto unregister;
-	}
+	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys);
+	if (rc)
+		goto unregister;
 
 	if (!scanphys)
 		return 0;
 
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
-		/* Skip PHYs with reg property set */
-		if (of_property_present(child, "reg"))
+		/* Skip PHYs with reg property set or ethernet-phy-package node */
+		if (of_property_present(child, "reg") ||
+		    of_node_name_eq(child, "ethernet-phy-package"))
 			continue;
 
 		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
@@ -227,15 +259,16 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 				if (!rc)
 					break;
 				if (rc != -ENODEV)
-					goto unregister;
+					goto put_unregister;
 			}
 		}
 	}
 
 	return 0;
 
-unregister:
+put_unregister:
 	of_node_put(child);
+unregister:
 	mdiobus_unregister(mdio);
 	return rc;
 }
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index afbad1ad8683..08624f073014 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -459,19 +459,34 @@ EXPORT_SYMBOL(of_mdio_find_bus);
  * found, set the of_node pointer for the mdio device. This allows
  * auto-probed phy devices to be supplied with information passed in
  * via DT.
+ * If a PHY package is found, PHY is searched also there.
  */
-static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
-				    struct mdio_device *mdiodev)
+static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
+			       struct device_node *np)
 {
-	struct device *dev = &mdiodev->dev;
 	struct device_node *child;
 
-	if (dev->of_node || !bus->dev.of_node)
-		return;
-
-	for_each_available_child_of_node(bus->dev.of_node, child) {
+	for_each_available_child_of_node(np, child) {
 		int addr;
 
+		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			/* Validate PHY package reg presence */
+			if (!of_property_present(child, "reg")) {
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			if (!of_mdiobus_find_phy(dev, mdiodev, child)) {
+				/* The refcount for the PHY package will be
+				 * incremented later when PHY join the Package.
+				 */
+				of_node_put(child);
+				return 0;
+			}
+
+			continue;
+		}
+
 		addr = of_mdio_parse_addr(dev, child);
 		if (addr < 0)
 			continue;
@@ -481,9 +496,22 @@ static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
 			/* The refcount on "child" is passed to the mdio
 			 * device. Do _not_ use of_node_put(child) here.
 			 */
-			return;
+			return 0;
 		}
 	}
+
+	return -ENODEV;
+}
+
+static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
+				    struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+
+	if (dev->of_node || !bus->dev.of_node)
+		return;
+
+	of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
 }
 #else /* !IS_ENABLED(CONFIG_OF_MDIO) */
 static inline void of_mdiobus_link_mdiodev(struct mii_bus *mdio,
-- 
2.43.0


