Return-Path: <linux-kernel+bounces-164319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEB8B7C43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBD51C22810
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AED17A931;
	Tue, 30 Apr 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eudrSFcT"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD130174ED4;
	Tue, 30 Apr 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492257; cv=none; b=rjqvCoTcuUeVWNtdDhz+jJ4IZhAqUuyc6iCu5EDVwzC/3ulV870b9q2Ua8VHmU0TBugo1V9oeDYKEE6FS6k5OkVtL0hyjlrQ4PznsxgfrwN/Tl1TeDkhpiYQd7DTklYFR7nHqUMTpLum6nlsWtDq3Szc1WmCCMZFFTirGauMlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492257; c=relaxed/simple;
	bh=/D2unnWYMx3wu4eBZTZde5UsM2l842xNj3K/0HomAcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NEI2EQzoEDIWOZxtyOISCt3wD4wN5TrR/1C/K7LQh3VChnVSzIEraC+4DX2nXw98J3DdurACX9KgE8+5HwDyBF31NH8jC1GI0c98nLpHEnRHe1rEJiMA/g86upM8Gr/pOFEeNS5tjlx92pLit2hQb91tHlL34VhMih9Imfua2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eudrSFcT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA11220017;
	Tue, 30 Apr 2024 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QeyJrKgww9DWfo6uJq4NMsS7VIr2JtgkYND+QhzpYE=;
	b=eudrSFcTk82H32Jr3w69DEN6YKNvwSkelYJMS19PBqnwFQDuvH7KHlBT6g4ZPiwjke59WR
	QKesEVLYuobL+RVG0g7TAWNzXRhgT43WuF8BYGDO4BLKbKWa6oGijBNHW+rnIb6FcYXeSP
	+HHWmrSzbBTNhFEiC/2cZOzmCAYHEzjftosbQCcSFW/DY4GppLsHFvwKZjfuM+TTeLLZGM
	Ymgsc9fEx3sKhNXs+5OWT3lnzUYpZ8HF62cLy3yJl8AuRSwya937GvGr5sitBwsnFg1Eqm
	3DxZhGB03bzfDvaM7Tf/bO7Am4vEBE49935mT9BKbmULQ4omohOjpzeELYJuAw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Apr 2024 17:49:55 +0200
Subject: [PATCH net-next v12 12/13] net: ethtool: tsinfo: Add support for
 hwtstamp provider and get/set hwtstamp config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-feature_ptp_netnext-v12-12-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
In-Reply-To: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
network topology and read current hwtstamp configuration.

Introduce support for ETHTOOL_MSG_TSINFO_SET ethtool netlink socket to
configure hwtstamp of a PHC provider. Note that simultaneous hwtstamp
isn't supported; configuring a new one disables the previous setting.

Also, add support for a specific dump command to retrieve all hwtstamp
providers within the network topology, with added functionality for
filtered dump to target a single interface.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Pointer attached_dev is used to know if the phy is on the net topology.
This might not be enough and might need Maxime Chevallier link topology
patch series:
https://lore.kernel.org/netdev/20240213150431.1796171-1-maxime.chevallier@bootlin.com/

Change in v8:
- New patch

Change in v9:
- Fix nit in done callback.

Change in v10:
- Add documentation.
- Add extack error messages.
- Add NLA_POLICY_* checks.
- Fix few nits.
- Add ETHTOOL_A_TSINFO_GHWTSTAMP netlink attributes instead of a bit in
  ETHTOOL_A_TSINFO_TIMESTAMPING bitset.
- Add tsinfo_parse_hwtstamp_provider function for more readability.
- Move netdev_support_hwtstamp_qualifier function in core ptp instead of
  core net.
- Add refcount put to release the ptp object.
- Use rcu lock to avoid memory leak.

Change in v12:
- Add missing return description in the kdoc.
- Fix possible leak due to uninitialised variable.
- Add a missing static.
---
 Documentation/networking/ethtool-netlink.rst |  38 +-
 Documentation/networking/timestamping.rst    |  35 +-
 drivers/net/phy/phy_device.c                 |   9 +-
 drivers/ptp/ptp_clock.c                      |  68 +++
 include/linux/ethtool.h                      |   4 +
 include/linux/netdevice.h                    |   2 +-
 include/linux/ptp_clock_kernel.h             |  53 +++
 include/uapi/linux/ethtool_netlink.h         |  14 +
 net/core/dev_ioctl.c                         |  15 +-
 net/core/timestamping.c                      |  36 +-
 net/ethtool/common.c                         |  32 ++
 net/ethtool/common.h                         |   3 +
 net/ethtool/netlink.c                        |  16 +-
 net/ethtool/netlink.h                        |   6 +-
 net/ethtool/tsinfo.c                         | 639 ++++++++++++++++++++++++++-
 15 files changed, 904 insertions(+), 66 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 8bc71f249448..66d8c41acf05 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1228,24 +1228,28 @@ callback supports.
 TSINFO_GET
 ==========
 
-Gets timestamping information like ``ETHTOOL_GET_TS_INFO`` ioctl request.
+Gets timestamping information like ``ETHTOOL_GET_TS_INFO`` ioctl request or
+get hardware timestamping configuration like ``SIOCGHWTSTAMP`` ioctl request.
 
 Request contents:
 
-  =====================================  ======  ==========================
-  ``ETHTOOL_A_TSINFO_HEADER``            nested  request header
-  =====================================  ======  ==========================
+  ===========================================  ======  ============================
+  ``ETHTOOL_A_TSINFO_HEADER``                  nested  request header
+  ``ETHTOOL_A_TSINFO_GHWTSTAMP``               bool    get hwtstamp configuration
+  ``ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST``  nested  PTP hw clock provider
+  ===========================================  ======  ============================
 
 Kernel response contents:
 
-  =====================================  ======  ==========================
+  =====================================  ======  ==================================
   ``ETHTOOL_A_TSINFO_HEADER``            nested  request header
   ``ETHTOOL_A_TSINFO_TIMESTAMPING``      bitset  SO_TIMESTAMPING flags
-  ``ETHTOOL_A_TSINFO_TX_TYPES``          bitset  supported Tx types
-  ``ETHTOOL_A_TSINFO_RX_FILTERS``        bitset  supported Rx filters
+  ``ETHTOOL_A_TSINFO_TX_TYPES``          bitset  supported or configured Tx types
+  ``ETHTOOL_A_TSINFO_RX_FILTERS``        bitset  supported or configured Rx filters
   ``ETHTOOL_A_TSINFO_PHC_INDEX``         u32     PTP hw clock index
   ``ETHTOOL_A_TSINFO_STATS``             nested  HW timestamping statistics
-  =====================================  ======  ==========================
+  ``ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS``    u32     hwstamp flags
+  =====================================  ======  ==================================
 
 ``ETHTOOL_A_TSINFO_PHC_INDEX`` is absent if there is no associated PHC (there
 is no special value for this case). The bitset attributes are omitted if they
@@ -1259,6 +1263,24 @@ Additional hardware timestamping statistics response contents:
   ``ETHTOOL_A_TS_STAT_TX_ERR``           uint    HW error request Tx timestamp count
   =====================================  ======  ===================================
 
+TSINFO_SET
+==========
+
+Sets hardware timestamping configuration like ``SIOCSHWTSTAMP`` ioctl request.
+
+Request contents:
+
+  ===========================================  ======  ========================
+  ``ETHTOOL_A_TSINFO_HEADER``                  nested  request header
+  ``ETHTOOL_A_TSINFO_TX_TYPES``                bitset  configured Tx type
+  ``ETHTOOL_A_TSINFO_RX_FILTERS``              bitset  configured Rx filter
+  ``ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS``          u32     hwstamp flags
+  ``ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST``  nested  PTP hw clock provider
+  ===========================================  ======  ========================
+
+If ``ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST`` is absent, set the hwtstamp
+configuration of the current hwtstamp.
+
 CABLE_TEST
 ==========
 
diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..2303e4927c9e 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -493,8 +493,8 @@ implicitly defined. ts[0] holds a software timestamp if set, ts[1]
 is again deprecated and ts[2] holds a hardware timestamp if set.
 
 
-3. Hardware Timestamping configuration: SIOCSHWTSTAMP and SIOCGHWTSTAMP
-=======================================================================
+3. Hardware Timestamping configuration: ETHTOOL_MSG_TSINFO_SET/GET
+==================================================================
 
 Hardware time stamping must also be initialized for each device driver
 that is expected to do hardware time stamping. The parameter is defined in
@@ -507,10 +507,16 @@ include/uapi/linux/net_tstamp.h as::
 	};
 
 Desired behavior is passed into the kernel and to a specific device by
-calling ioctl(SIOCSHWTSTAMP) with a pointer to a struct ifreq whose
-ifr_data points to a struct hwtstamp_config. The tx_type and
-rx_filter are hints to the driver what it is expected to do. If
-the requested fine-grained filtering for incoming packets is not
+calling the tsinfo netlink socket ETHTOOL_MSG_TSINFO_SET.
+The ETHTOOL_A_TSINFO_TX_TYPES, ETHTOOL_A_TSINFO_RX_FILTERS and
+ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS netlink attributes are then used to set the
+struct hwtstamp_config accordingly.
+
+The legacy configuration is the use of the ioctl(SIOCSHWTSTAMP) with a pointer
+to a struct ifreq whose ifr_data points to a struct hwtstamp_config.
+
+The tx_type and rx_filter are hints to the driver what it is expected to do.
+If the requested fine-grained filtering for incoming packets is not
 supported, the driver may time stamp more than just the requested types
 of packets.
 
@@ -531,9 +537,13 @@ Only a processes with admin rights may change the configuration. User
 space is responsible to ensure that multiple processes don't interfere
 with each other and that the settings are reset.
 
-Any process can read the actual configuration by passing this
-structure to ioctl(SIOCGHWTSTAMP) in the same way.  However, this has
-not been implemented in all drivers.
+Any process can read the actual configuration by requesting tsinfo netlink
+socket ETHTOOL_MSG_TSINFO_GET with ETHTOOL_MSG_TSINFO_GHWTSTAMP netlink
+attribute set.
+
+The legacy usage is to pass this structure to ioctl(SIOCGHWTSTAMP) in the
+same way as the ioctl(SIOCSHWTSTAMP).  However, this has not been implemented
+in all drivers.
 
 ::
 
@@ -578,9 +588,10 @@ not been implemented in all drivers.
 --------------------------------------------------------
 
 A driver which supports hardware time stamping must support the
-SIOCSHWTSTAMP ioctl and update the supplied struct hwtstamp_config with
-the actual values as described in the section on SIOCSHWTSTAMP.  It
-should also support SIOCGHWTSTAMP.
+ndo_hwtstamp_set NDO or the legacy SIOCSHWTSTAMP ioctl and update the
+supplied struct hwtstamp_config with the actual values as described in
+the section on SIOCSHWTSTAMP. It should also support ndo_hwtstamp_get or
+the legacy SIOCGHWTSTAMP.
 
 Time stamps for received packets must be stored in the skb. To get a pointer
 to the shared time stamp structure of the skb call skb_hwtstamps(). Then
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7d1f03195661..13dbe6a30106 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1991,12 +1991,13 @@ void phy_detach(struct phy_device *phydev)
 
 	phy_suspend(phydev);
 	if (dev) {
-		struct hwtstamp_provider *hwtstamp = dev->hwtstamp;
+		struct hwtstamp_provider *hwtstamp;
 
+		hwtstamp = rtnl_dereference(dev->hwtstamp);
 		/* Disable timestamp if selected */
-		if (hwtstamp &&
-		    ptp_clock_phydev(hwtstamp->ptp) == phydev) {
-			dev->hwtstamp = NULL;
+		if (hwtstamp && ptp_clock_phydev(hwtstamp->ptp) == phydev) {
+			rcu_assign_pointer(dev->hwtstamp, NULL);
+			synchronize_rcu();
 			kfree(hwtstamp);
 		}
 
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index f962f460ec9d..496318fe8c1a 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -626,6 +626,74 @@ void ptp_clock_put(struct device *dev, struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_clock_put);
 
+struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
+					unsigned long *indexp)
+{
+	struct ptp_clock *ptp;
+	unsigned long index;
+
+	xa_for_each_start(&ptp_clocks_map, index, ptp, *indexp) {
+		if ((ptp->phc_source == HWTSTAMP_SOURCE_NETDEV &&
+		     ptp->netdev == dev) ||
+		    (ptp->phc_source == HWTSTAMP_SOURCE_PHYLIB &&
+		     ptp->phydev->attached_dev == dev)) {
+			*indexp = index;
+			return ptp;
+		}
+	}
+
+	return NULL;
+};
+
+bool
+netdev_support_hwtstamp_qualifier(struct net_device *dev,
+				  enum hwtstamp_provider_qualifier qualifier)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	if (!ops)
+		return false;
+
+	/* Return true with precise qualifier and with NIC without
+	 * qualifier description to not break the old behavior.
+	 */
+	if (!ops->supported_hwtstamp_qualifiers &&
+	    qualifier == HWTSTAMP_PROVIDER_QUALIFIER_PRECISE)
+		return true;
+
+	if (ops->supported_hwtstamp_qualifiers & BIT(qualifier))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(netdev_support_hwtstamp_qualifier);
+
+bool netdev_support_hwtstamp(struct net_device *dev,
+			     struct hwtstamp_provider *hwtstamp)
+{
+	struct ptp_clock *tmp_ptp;
+	unsigned long index = 0;
+
+	netdev_for_each_ptp_clock_start(dev, index, tmp_ptp, 0) {
+		if (tmp_ptp != hwtstamp->ptp)
+			continue;
+
+		if (ptp_clock_from_phylib(hwtstamp->ptp) &&
+		    hwtstamp->qualifier == HWTSTAMP_PROVIDER_QUALIFIER_PRECISE)
+			return true;
+
+		if (ptp_clock_from_netdev(hwtstamp->ptp) &&
+		    netdev_support_hwtstamp_qualifier(dev,
+						      hwtstamp->qualifier))
+			return true;
+
+		return false;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(netdev_support_hwtstamp);
+
 /* module operations */
 
 static void __exit ptp_exit(void)
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d92e2cd13b81..a39fe9b8231b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -667,6 +667,7 @@ struct ethtool_rxfh_param {
  * @cmd: command number = %ETHTOOL_GET_TS_INFO
  * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
  * @phc_index: device index of the associated PHC, or -1 if there is none
+ * @phc_qualifier: qualifier of the associated PHC
  * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
  * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
  */
@@ -674,6 +675,7 @@ struct kernel_ethtool_ts_info {
 	u32 cmd;
 	u32 so_timestamping;
 	int phc_index;
+	enum hwtstamp_provider_qualifier phc_qualifier;
 	enum hwtstamp_tx_types tx_types;
 	enum hwtstamp_rx_filters rx_filters;
 };
@@ -688,6 +690,7 @@ struct kernel_ethtool_ts_info {
  *	RSS.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
+ * @supported_hwtstamp_qualifiers: bitfield of supported hwtstamp qualifier.
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
  *	correctly filled in by the core using system information, or
@@ -871,6 +874,7 @@ struct ethtool_ops {
 	u32	cap_rss_sym_xor_supported:1;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
+	u32	supported_hwtstamp_qualifiers;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
 	int	(*get_regs_len)(struct net_device *);
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f6333b8a630d..003b3919fe99 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2404,7 +2404,7 @@ struct net_device {
 	struct hlist_head	page_pools;
 #endif
 
-	struct hwtstamp_provider	*hwtstamp;
+	struct hwtstamp_provider __rcu	*hwtstamp;
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 3453dba1e4f2..5322e0a592f5 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -442,6 +442,49 @@ struct ptp_clock *ptp_clock_get_by_index(struct device *dev, int index);
 
 void ptp_clock_put(struct device *dev, struct ptp_clock *ptp);
 
+/**
+ * netdev_ptp_clock_find() - obtain the next PTP clock in the netdev
+ *			     topology
+ *
+ * @dev:    Pointer of the net device.
+ * @indexp:  Pointer of ptp clock index start point.
+ *
+ * Return: Pointer of the PTP clock found, NULL otherwise.
+ */
+
+struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
+					unsigned long *indexp);
+
+#define netdev_for_each_ptp_clock_start(dev, index, entry, start) \
+	for (index = start, entry = netdev_ptp_clock_find(dev, &index); \
+	     entry; index++, entry = netdev_ptp_clock_find(dev, &index))
+
+/**
+ * netdev_support_hwtstamp_qualifier() - Verify if the net device support the
+ *					 hwtstamp qualifier
+ *
+ * @dev:        Pointer of the net device.
+ * @qualifier:  hwtstamp provider qualifier.
+ *
+ * Return: True if the net device support the htstamp qualifier false otherwise.
+ */
+
+bool netdev_support_hwtstamp_qualifier(struct net_device *dev,
+				       enum hwtstamp_provider_qualifier qualifier);
+
+/**
+ * netdev_support_hwtstamp() - Verify if the hwtstamp belong to the netdev
+ *			       topology
+ *
+ * @dev:       Pointer of the net device
+ * @hwtstamp:  Pointer of the hwtstamp provider
+ *
+ * Return: True if the hwtstamp belong to the netdev topology false otherwise.
+ */
+
+bool netdev_support_hwtstamp(struct net_device *dev,
+			     struct hwtstamp_provider *hwtstamp);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -525,6 +568,16 @@ static inline struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
 { return NULL; }
 static inline struct ptp_clock *ptp_clock_get_by_index(int index);
 { return NULL; }
+static inline struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
+						      unsigned long *indexp)
+{ return NULL; }
+static inline bool
+netdev_support_hwtstamp_qualifier(struct net_device *dev,
+				  enum hwtstamp_provider_qualifier qualifier);
+{ return false; }
+static inline bool netdev_support_hwtstamp(struct net_device *dev,
+					   struct hwtstamp_provider *hwtst);
+{ return false; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index f17dbe54bf5e..b313a7e52983 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_TSINFO_SET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +110,7 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_TSINFO_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -470,6 +472,15 @@ enum {
 };
 
 /* TSINFO */
+enum {
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_UNSPEC,
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX,		/* u32 */
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER,		/* u32 */
+
+	__ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_CNT,
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_MAX = (__ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_CNT - 1)
+};
+
 
 enum {
 	ETHTOOL_A_TSINFO_UNSPEC,
@@ -479,6 +490,9 @@ enum {
 	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
 	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
 	ETHTOOL_A_TSINFO_STATS,				/* nest - _A_TSINFO_STAT */
+	ETHTOOL_A_TSINFO_GHWTSTAMP,			/* u8 */
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST,	/* nest - *_TSINFO_HWTSTAMP_PROVIDER_* */
+	ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_TSINFO_CNT,
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index acb0cadb7512..ec6dd81a5add 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -270,10 +270,13 @@ static int dev_eth_ioctl(struct net_device *dev,
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg)
 {
-	if (dev->hwtstamp) {
-		struct ptp_clock *ptp = dev->hwtstamp->ptp;
+	struct hwtstamp_provider *hwtstamp;
 
-		cfg->qualifier = dev->hwtstamp->qualifier;
+	hwtstamp = rtnl_dereference(dev->hwtstamp);
+	if (hwtstamp) {
+		struct ptp_clock *ptp = hwtstamp->ptp;
+
+		cfg->qualifier = hwtstamp->qualifier;
 		if (ptp_clock_from_phylib(ptp))
 			return phy_hwtstamp_get(ptp_clock_phydev(ptp), cfg);
 
@@ -340,13 +343,15 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	struct kernel_hwtstamp_config old_cfg = {};
+	struct hwtstamp_provider *hwtstamp;
 	struct phy_device *phydev;
 	bool changed = false;
 	bool phy_ts;
 	int err;
 
-	if (dev->hwtstamp) {
-		struct ptp_clock *ptp = dev->hwtstamp->ptp;
+	hwtstamp = rtnl_dereference(dev->hwtstamp);
+	if (hwtstamp) {
+		struct ptp_clock *ptp = hwtstamp->ptp;
 
 		if (ptp_clock_from_phylib(ptp)) {
 			phy_ts = true;
diff --git a/net/core/timestamping.c b/net/core/timestamping.c
index 1bc9dc76efff..f8522fefd468 100644
--- a/net/core/timestamping.c
+++ b/net/core/timestamping.c
@@ -22,6 +22,7 @@ static unsigned int classify(const struct sk_buff *skb)
 
 void skb_clone_tx_timestamp(struct sk_buff *skb)
 {
+	struct hwtstamp_provider *hwtstamp;
 	struct mii_timestamper *mii_ts;
 	struct phy_device *phydev;
 	struct sk_buff *clone;
@@ -30,18 +31,23 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
 	if (!skb->sk || !skb->dev)
 		return;
 
-	if (skb->dev->hwtstamp) {
-		struct ptp_clock *ptp = skb->dev->hwtstamp->ptp;
-
-		if (!ptp_clock_from_phylib(ptp))
+	rcu_read_lock();
+	hwtstamp = rcu_dereference(skb->dev->hwtstamp);
+	if (hwtstamp) {
+		if (!ptp_clock_from_phylib(hwtstamp->ptp)) {
+			rcu_read_unlock();
 			return;
+		}
 
-		phydev = ptp_clock_phydev(ptp);
+		phydev = ptp_clock_phydev(hwtstamp->ptp);
 	} else {
 		phydev = skb->dev->phydev;
-		if (!phy_is_default_hwtstamp(phydev))
+		if (!phy_is_default_hwtstamp(phydev)) {
+			rcu_read_unlock();
 			return;
+		}
 	}
+	rcu_read_unlock();
 
 	type = classify(skb);
 	if (type == PTP_CLASS_NONE)
@@ -59,6 +65,7 @@ EXPORT_SYMBOL_GPL(skb_clone_tx_timestamp);
 
 bool skb_defer_rx_timestamp(struct sk_buff *skb)
 {
+	struct hwtstamp_provider *hwtstamp;
 	struct mii_timestamper *mii_ts;
 	struct phy_device *phydev;
 	unsigned int type;
@@ -66,18 +73,23 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
 	if (!skb->dev)
 		return false;
 
-	if (skb->dev->hwtstamp) {
-		struct ptp_clock *ptp = skb->dev->hwtstamp->ptp;
-
-		if (!ptp_clock_from_phylib(ptp))
+	rcu_read_lock();
+	hwtstamp = rcu_dereference(skb->dev->hwtstamp);
+	if (hwtstamp) {
+		if (!ptp_clock_from_phylib(hwtstamp->ptp)) {
+			rcu_read_unlock();
 			return false;
+		}
 
-		phydev = ptp_clock_phydev(ptp);
+		phydev = ptp_clock_phydev(hwtstamp->ptp);
 	} else {
 		phydev = skb->dev->phydev;
-		if (!phy_is_default_hwtstamp(phydev))
+		if (!phy_is_default_hwtstamp(phydev)) {
+			rcu_read_unlock();
 			return false;
+		}
 	}
+	rcu_read_unlock();
 
 	if (skb_headroom(skb) < ETH_HLEN)
 		return false;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 461017a37955..532332e708fb 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -629,10 +629,42 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
 	return 0;
 }
 
+int ethtool_get_ts_info_by_phc(struct net_device *dev,
+			       struct kernel_ethtool_ts_info *info,
+			       struct hwtstamp_provider *hwtstamp)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	memset(info, 0, sizeof(*info));
+	info->cmd = ETHTOOL_GET_TS_INFO;
+	info->phc_qualifier = hwtstamp->qualifier;
+
+	if (!netdev_support_hwtstamp(dev, hwtstamp))
+		return -ENODEV;
+
+	if (ptp_clock_from_phylib(hwtstamp->ptp) &&
+	    phy_has_tsinfo(ptp_clock_phydev(hwtstamp->ptp)))
+		return phy_ts_info(ptp_clock_phydev(hwtstamp->ptp), info);
+
+	if (ptp_clock_from_netdev(hwtstamp->ptp) && ops->get_ts_info)
+		return ops->get_ts_info(dev, info);
+
+	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE;
+	info->phc_index = -1;
+
+	return 0;
+}
+
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
+	struct hwtstamp_provider *hwtstamp;
+
+	hwtstamp = rtnl_dereference(dev->hwtstamp);
+	if (hwtstamp)
+		return ethtool_get_ts_info_by_phc(dev, info, hwtstamp);
 
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index b9daeecbd84d..83bf82a4e75a 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -45,6 +45,9 @@ bool convert_legacy_settings_to_link_ksettings(
 int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max);
 int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max);
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
+int ethtool_get_ts_info_by_phc(struct net_device *dev,
+			       struct kernel_ethtool_ts_info *info,
+			       struct hwtstamp_provider *hwtst);
 
 extern const struct ethtool_phy_ops *ethtool_phy_ops;
 extern const struct ethtool_pse_ops *ethtool_pse_ops;
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 563e94e0cbd8..e72304787121 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -350,6 +350,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_TSINFO_SET]	= &ethnl_tsinfo_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -679,6 +680,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= &ethnl_module_request_ops,
 	[ETHTOOL_MSG_PLCA_NTF]		= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_TSINFO_NTF]	= &ethnl_tsinfo_request_ops,
 };
 
 /* default notification handler */
@@ -777,6 +779,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MODULE_NTF]	= ethnl_default_notify,
 	[ETHTOOL_MSG_PLCA_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
+	[ETHTOOL_MSG_TSINFO_NTF]	= ethnl_default_notify,
 };
 
 void ethtool_notify(struct net_device *dev, unsigned int cmd, const void *data)
@@ -1018,9 +1021,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_TSINFO_GET,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_default_start,
-		.dumpit	= ethnl_default_dumpit,
-		.done	= ethnl_default_done,
+		.start	= ethnl_tsinfo_start,
+		.dumpit	= ethnl_tsinfo_dumpit,
+		.done	= ethnl_tsinfo_done,
 		.policy = ethnl_tsinfo_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_tsinfo_get_policy) - 1,
 	},
@@ -1169,6 +1172,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mm_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mm_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_TSINFO_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_tsinfo_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_tsinfo_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index d57a890b5d9e..b223348d7fac 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -427,7 +427,7 @@ extern const struct nla_policy ethnl_pause_get_policy[ETHTOOL_A_PAUSE_STATS_SRC
 extern const struct nla_policy ethnl_pause_set_policy[ETHTOOL_A_PAUSE_TX + 1];
 extern const struct nla_policy ethnl_eee_get_policy[ETHTOOL_A_EEE_HEADER + 1];
 extern const struct nla_policy ethnl_eee_set_policy[ETHTOOL_A_EEE_TX_LPI_TIMER + 1];
-extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_HEADER + 1];
+extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1];
 extern const struct nla_policy ethnl_cable_test_act_policy[ETHTOOL_A_CABLE_TEST_HEADER + 1];
 extern const struct nla_policy ethnl_cable_test_tdr_act_policy[ETHTOOL_A_CABLE_TEST_TDR_CFG + 1];
 extern const struct nla_policy ethnl_tunnel_info_get_policy[ETHTOOL_A_TUNNEL_INFO_HEADER + 1];
@@ -446,6 +446,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_tsinfo_set_policy[ETHTOOL_A_TSINFO_MAX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -453,6 +454,9 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_tsinfo_start(struct netlink_callback *cb);
+int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_tsinfo_done(struct netlink_callback *cb);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 88e59ca8d4c0..aafa81b32d83 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -1,67 +1,219 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
 
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
+#include "../core/dev.h"
+
+struct hwtst_provider {
+	int index;
+	u32 qualifier;
+};
 
 struct tsinfo_req_info {
 	struct ethnl_req_info		base;
+	struct hwtst_provider		hwtst;
+	bool				get_hwtstamp;
 };
 
 struct tsinfo_reply_data {
 	struct ethnl_reply_data		base;
-	struct kernel_ethtool_ts_info	ts_info;
+	union {
+		struct kernel_ethtool_ts_info	ts_info;
+		struct {
+			u32 tx_type;
+			u32 rx_filter;
+			u32 flags;
+		} hwtst_config;
+	};
 	struct ethtool_ts_stats		stats;
 };
 
+#define TSINFO_REQINFO(__req_base) \
+	container_of(__req_base, struct tsinfo_req_info, base)
+
 #define TSINFO_REPDATA(__reply_base) \
 	container_of(__reply_base, struct tsinfo_reply_data, base)
 
 #define ETHTOOL_TS_STAT_CNT \
 	(__ETHTOOL_A_TS_STAT_CNT - (ETHTOOL_A_TS_STAT_UNSPEC + 1))
 
-const struct nla_policy ethnl_tsinfo_get_policy[] = {
+static const struct nla_policy
+ethnl_tsinfo_hwtstamp_provider_policy[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_MAX + 1] = {
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] =
+		NLA_POLICY_MIN(NLA_S32, 0),
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER] =
+		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
+};
+
+const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
 	[ETHTOOL_A_TSINFO_HEADER]		=
 		NLA_POLICY_NESTED(ethnl_header_policy_stats),
+	[ETHTOOL_A_TSINFO_GHWTSTAMP] =
+		NLA_POLICY_MAX(NLA_U8, 1),
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST] =
+		NLA_POLICY_NESTED(ethnl_tsinfo_hwtstamp_provider_policy),
 };
 
+static int tsinfo_parse_hwtstamp_provider(const struct nlattr *nest,
+					  struct hwtst_provider *hwtst,
+					  struct netlink_ext_ack *extack,
+					  bool *mod)
+{
+	struct nlattr *tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)];
+	int ret;
+
+	ret = nla_parse_nested(tb,
+			       ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy) - 1,
+			       nest,
+			       ethnl_tsinfo_hwtstamp_provider_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, nest, tb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX) ||
+	    NL_REQ_ATTR_CHECK(extack, nest, tb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER))
+		return -EINVAL;
+
+	ethnl_update_u32(&hwtst->index,
+			 tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX],
+			 mod);
+	ethnl_update_u32(&hwtst->qualifier,
+			 tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER],
+			 mod);
+
+	return 0;
+}
+
+static int
+tsinfo_parse_request(struct ethnl_req_info *req_base, struct nlattr **tb,
+		     struct netlink_ext_ack *extack)
+{
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
+	bool mod = false;
+
+	req->hwtst.index = -1;
+
+	if (tb[ETHTOOL_A_TSINFO_GHWTSTAMP]) {
+		req->get_hwtstamp = nla_get_u8(tb[ETHTOOL_A_TSINFO_GHWTSTAMP]);
+
+		/* We support only the get of the current hwtstamp config
+		 * for now.
+		 */
+		if (req->get_hwtstamp &&
+		    tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST]) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+					    "only getting the current hwtstamp configuration is supported");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST])
+		return 0;
+
+	return tsinfo_parse_hwtstamp_provider(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+					      &req->hwtst, extack, &mod);
+}
+
 static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
 			       struct ethnl_reply_data *reply_base,
 			       const struct genl_info *info)
 {
 	struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
 	struct net_device *dev = reply_base->dev;
 	int ret;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
+
+	if (req->get_hwtstamp) {
+		struct kernel_hwtstamp_config cfg = {};
+
+		if (!dev->netdev_ops->ndo_hwtstamp_get) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		ret = dev_get_hwtstamp_phylib(dev, &cfg);
+		data->hwtst_config.tx_type = BIT(cfg.tx_type);
+		data->hwtst_config.rx_filter = BIT(cfg.rx_filter);
+		data->hwtst_config.flags = BIT(cfg.flags);
+		goto out;
+	}
+
 	if (req_base->flags & ETHTOOL_FLAG_STATS &&
 	    dev->ethtool_ops->get_ts_stats) {
 		ethtool_stats_init((u64 *)&data->stats,
 				   sizeof(data->stats) / sizeof(u64));
 		dev->ethtool_ops->get_ts_stats(dev, &data->stats);
 	}
-	ret = __ethtool_get_ts_info(dev, &data->ts_info);
+
+	if (req->hwtst.index != -1) {
+		struct hwtstamp_provider hwtstamp;
+
+		hwtstamp.ptp = ptp_clock_get_by_index(&dev->dev, req->hwtst.index);
+		if (!hwtstamp.ptp) {
+			ret = -ENODEV;
+			goto out;
+		}
+		hwtstamp.qualifier = req->hwtst.qualifier;
+
+		ret = ethtool_get_ts_info_by_phc(dev, &data->ts_info,
+						 &hwtstamp);
+		ptp_clock_put(&dev->dev, hwtstamp.ptp);
+	} else {
+		ret = __ethtool_get_ts_info(dev, &data->ts_info);
+	}
+
+out:
 	ethnl_ops_complete(dev);
 
 	return ret;
 }
 
-static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
-			     const struct ethnl_reply_data *reply_base)
+static int
+tsinfo_reply_size_hwtstamp_config(const struct tsinfo_reply_data *data,
+				  u32 req_flags)
 {
-	const struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
-	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
-	const struct kernel_ethtool_ts_info *ts_info = &data->ts_info;
+	bool compact = req_flags & ETHTOOL_FLAG_COMPACT_BITSETS;
 	int len = 0;
 	int ret;
 
-	BUILD_BUG_ON(__SOF_TIMESTAMPING_CNT > 32);
-	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
-	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+	if (data->hwtst_config.flags)
+		len += nla_total_size(sizeof(u32));
+
+	if (data->hwtst_config.tx_type) {
+		ret = ethnl_bitset32_size(&data->hwtst_config.tx_type,
+					  NULL, __HWTSTAMP_TX_CNT,
+					  ts_tx_type_names, compact);
+		if (ret < 0)
+			return ret;
+		len += ret;	/* _TSINFO_TX_TYPES */
+	}
+	if (data->hwtst_config.rx_filter) {
+		ret = ethnl_bitset32_size(&data->hwtst_config.rx_filter,
+					  NULL, __HWTSTAMP_FILTER_CNT,
+					  ts_rx_filter_names, compact);
+		if (ret < 0)
+			return ret;
+		len += ret;	/* _TSINFO_RX_FILTERS */
+	}
+
+	return len;
+}
+
+static int
+tsinfo_reply_size_ts_info(const struct kernel_ethtool_ts_info *ts_info,
+			  u32 req_flags)
+{
+	bool compact = req_flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	int len = 0;
+	int ret;
 
 	if (ts_info->so_timestamping) {
 		ret = ethnl_bitset32_size(&ts_info->so_timestamping, NULL,
@@ -87,9 +239,12 @@ static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 			return ret;
 		len += ret;	/* _TSINFO_RX_FILTERS */
 	}
-	if (ts_info->phc_index >= 0)
+	if (ts_info->phc_index >= 0) {
+		/* _TSINFO_HWTSTAMP_PROVIDER_NEST */
+		len += 2 * nla_total_size(sizeof(u32));
 		len += nla_total_size(sizeof(u32));	/* _TSINFO_PHC_INDEX */
-	if (req_base->flags & ETHTOOL_FLAG_STATS)
+	}
+	if (req_flags & ETHTOOL_FLAG_STATS)
 		len += nla_total_size(0) + /* _TSINFO_STATS */
 		       nla_total_size_64bit(sizeof(u64)) * ETHTOOL_TS_STAT_CNT;
 
@@ -130,13 +285,30 @@ static int tsinfo_put_stats(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int tsinfo_fill_reply(struct sk_buff *skb,
-			     const struct ethnl_req_info *req_base,
+static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 			     const struct ethnl_reply_data *reply_base)
 {
 	const struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
-	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
+
+	BUILD_BUG_ON(__SOF_TIMESTAMPING_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+
+	if (req->get_hwtstamp)
+		return tsinfo_reply_size_hwtstamp_config(data,
+							 req_base->flags);
+
+	return tsinfo_reply_size_ts_info(&data->ts_info, req_base->flags);
+}
+
+static int tsinfo_fill_ts_info(struct sk_buff *skb,
+			       const struct tsinfo_reply_data *data,
+			       u32 req_flags)
+{
 	const struct kernel_ethtool_ts_info *ts_info = &data->ts_info;
+	bool compact = req_flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	struct nlattr *nest;
 	int ret;
 
 	if (ts_info->so_timestamping) {
@@ -163,16 +335,438 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
 		if (ret < 0)
 			return ret;
 	}
-	if (ts_info->phc_index >= 0 &&
-	    nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX, ts_info->phc_index))
-		return -EMSGSIZE;
-	if (req_base->flags & ETHTOOL_FLAG_STATS &&
+	if (ts_info->phc_index >= 0) {
+		ret = nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX,
+				  ts_info->phc_index);
+		if (ret)
+			return -EMSGSIZE;
+
+		nest = nla_nest_start(skb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST);
+		if (!nest)
+			return -EMSGSIZE;
+
+		if (nla_put_u32(skb, ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX,
+				ts_info->phc_index) ||
+		    nla_put_u32(skb,
+				ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER,
+				ts_info->phc_qualifier)) {
+			nla_nest_cancel(skb, nest);
+			return -EMSGSIZE;
+		}
+
+		nla_nest_end(skb, nest);
+	}
+	if (req_flags & ETHTOOL_FLAG_STATS &&
 	    tsinfo_put_stats(skb, &data->stats))
 		return -EMSGSIZE;
 
 	return 0;
 }
 
+static int
+tsinfo_fill_hwtstamp_config(struct sk_buff *skb,
+			    const struct tsinfo_reply_data *data,
+			    u32 req_flags)
+{
+	bool compact = req_flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	int ret;
+
+	if (data->hwtst_config.flags) {
+		ret = nla_put_u32(skb, ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS,
+				  data->hwtst_config.flags);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (data->hwtst_config.tx_type) {
+		ret = ethnl_put_bitset32(skb, ETHTOOL_A_TSINFO_TX_TYPES,
+					 &data->hwtst_config.tx_type, NULL,
+					 __HWTSTAMP_TX_CNT,
+					 ts_tx_type_names, compact);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (data->hwtst_config.rx_filter) {
+		ret = ethnl_put_bitset32(skb, ETHTOOL_A_TSINFO_RX_FILTERS,
+					 &data->hwtst_config.rx_filter,
+					 NULL, __HWTSTAMP_FILTER_CNT,
+					 ts_rx_filter_names, compact);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int tsinfo_fill_reply(struct sk_buff *skb,
+			     const struct ethnl_req_info *req_base,
+			     const struct ethnl_reply_data *reply_base)
+{
+	const struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
+
+	if (req->get_hwtstamp)
+		return tsinfo_fill_hwtstamp_config(skb, data,
+						   req_base->flags);
+
+	return tsinfo_fill_ts_info(skb, data, req_base->flags);
+}
+
+struct ethnl_tsinfo_dump_ctx {
+	struct tsinfo_req_info		*req_info;
+	struct tsinfo_reply_data	*reply_data;
+	unsigned long			pos_ifindex;
+	unsigned long			pos_phcindex;
+	enum hwtstamp_provider_qualifier pos_phcqualifier;
+};
+
+static int ethnl_tsinfo_dump_one_ptp(struct sk_buff *skb, struct net_device *dev,
+				     struct netlink_callback *cb,
+				     struct ptp_clock *ptp)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct tsinfo_reply_data *reply_data;
+	struct tsinfo_req_info *req_info;
+	void *ehdr = NULL;
+	int ret = 0;
+
+	reply_data = ctx->reply_data;
+	req_info = ctx->req_info;
+	req_info->hwtst.index = ptp_clock_index(ptp);
+
+	for (; ctx->pos_phcqualifier < HWTSTAMP_PROVIDER_QUALIFIER_CNT;
+	     ctx->pos_phcqualifier++) {
+		if (!netdev_support_hwtstamp_qualifier(dev,
+						       ctx->pos_phcqualifier))
+			continue;
+
+		ehdr = ethnl_dump_put(skb, cb,
+				      ETHTOOL_MSG_TSINFO_GET_REPLY);
+		if (!ehdr)
+			return -EMSGSIZE;
+
+		memset(reply_data, 0, sizeof(*reply_data));
+		reply_data->base.dev = dev;
+		req_info->hwtst.qualifier = ctx->pos_phcqualifier;
+		ret = tsinfo_prepare_data(&req_info->base,
+					  &reply_data->base,
+					  genl_info_dump(cb));
+		if (ret < 0)
+			break;
+
+		ret = ethnl_fill_reply_header(skb, dev,
+					      ETHTOOL_A_TSINFO_HEADER);
+		if (ret < 0)
+			break;
+
+		ret = tsinfo_fill_reply(skb, &req_info->base,
+					&reply_data->base);
+		if (ret < 0)
+			break;
+	}
+
+	reply_data->base.dev = NULL;
+	if (!ret && ehdr)
+		genlmsg_end(skb, ehdr);
+	else
+		genlmsg_cancel(skb, ehdr);
+	return ret;
+}
+
+static int ethnl_tsinfo_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
+				     struct netlink_callback *cb)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct ptp_clock *ptp;
+	int ret;
+
+	netdev_for_each_ptp_clock_start(dev, ctx->pos_phcindex, ptp,
+					ctx->pos_phcindex) {
+		ret = ethnl_tsinfo_dump_one_ptp(skb, dev, cb, ptp);
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			break;
+		ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
+	}
+
+	return ret;
+}
+
+int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
+	int ret = 0;
+
+	rtnl_lock();
+	if (ctx->req_info->base.dev) {
+		ret = ethnl_tsinfo_dump_one_dev(skb,
+						ctx->req_info->base.dev,
+						cb);
+	} else {
+		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
+			ret = ethnl_tsinfo_dump_one_dev(skb, dev, cb);
+			if (ret < 0 && ret != -EOPNOTSUPP)
+				break;
+			ctx->pos_phcindex = 0;
+		}
+	}
+	rtnl_unlock();
+
+	if (ret == -EMSGSIZE && skb->len)
+		return skb->len;
+	return ret;
+}
+
+static int
+tsinfo_dump_parse_request(struct nlattr **tb, struct netlink_ext_ack *extack)
+{
+	if (tb[ETHTOOL_A_TSINFO_GHWTSTAMP] &&
+	    nla_get_u8(tb[ETHTOOL_A_TSINFO_GHWTSTAMP])) {
+		/* We do not support simultaneous hwtstamp for now */
+		NL_SET_ERR_MSG_ATTR(extack,
+				    tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+				    "only getting the current hwtstamp configuration is supported");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int ethnl_tsinfo_start(struct netlink_callback *cb)
+{
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct nlattr **tb = info->info.attrs;
+	struct tsinfo_reply_data *reply_data;
+	struct tsinfo_req_info *req_info;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
+
+	req_info = kzalloc(sizeof(*req_info), GFP_KERNEL);
+	if (!req_info)
+		return -ENOMEM;
+	reply_data = kzalloc(sizeof(*reply_data), GFP_KERNEL);
+	if (!reply_data) {
+		ret = -ENOMEM;
+		goto free_req_info;
+	}
+
+	ret = ethnl_parse_header_dev_get(&req_info->base,
+					 tb[ETHTOOL_A_TSINFO_HEADER],
+					 sock_net(cb->skb->sk), cb->extack,
+					 false);
+	if (ret < 0)
+		goto free_reply_data;
+
+	ret = tsinfo_dump_parse_request(tb, cb->extack);
+	if (ret < 0)
+		goto put_header_dev;
+
+	ctx->req_info = req_info;
+	ctx->reply_data = reply_data;
+	ctx->pos_ifindex = 0;
+	ctx->pos_phcindex = 0;
+	ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
+
+	return 0;
+
+put_header_dev:
+	if (req_info->base.dev) {
+		ethnl_parse_header_dev_put(&req_info->base);
+		req_info->base.dev = NULL;
+	}
+free_reply_data:
+	kfree(reply_data);
+free_req_info:
+	kfree(req_info);
+
+	return ret;
+}
+
+int ethnl_tsinfo_done(struct netlink_callback *cb)
+{
+	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct tsinfo_req_info *req_info = ctx->req_info;
+
+	ethnl_parse_header_dev_put(&req_info->base);
+	kfree(ctx->reply_data);
+	kfree(ctx->req_info);
+
+	return 0;
+}
+
+/* TSINFO_SET (set hwtstamp config) */
+const struct nla_policy ethnl_tsinfo_set_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
+	[ETHTOOL_A_TSINFO_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST] = { .type = NLA_NESTED },
+	[ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS] = { .type = NLA_U32 },
+	[ETHTOOL_A_TSINFO_RX_FILTERS] = { .type = NLA_NESTED },
+	[ETHTOOL_A_TSINFO_TX_TYPES] = { .type = NLA_NESTED },
+};
+
+static int ethnl_set_tsinfo_validate(struct ethnl_req_info *req_base,
+				     struct genl_info *info)
+{
+	const struct net_device_ops *ops = req_base->dev->netdev_ops;
+
+	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
+		return -EOPNOTSUPP;
+
+	return 1;
+}
+
+static int ethnl_set_tsinfo(struct ethnl_req_info *req_base,
+			    struct genl_info *info)
+{
+	unsigned long mask = 0, req_rx_filter, req_tx_type;
+	struct kernel_hwtstamp_config hwtst_config = {0};
+	struct hwtstamp_provider *hwtstamp = NULL;
+	struct net_device *dev = req_base->dev;
+	struct nlattr **tb = info->attrs;
+	bool mod = false;
+	int ret;
+
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
+	if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST]) {
+		struct hwtst_provider __hwtst = {.index = -1};
+		struct hwtstamp_provider *__hwtstamp;
+
+		__hwtstamp = rtnl_dereference(dev->hwtstamp);
+		if (__hwtstamp) {
+			__hwtst.index = ptp_clock_index(__hwtstamp->ptp);
+			__hwtst.qualifier = __hwtstamp->qualifier;
+		}
+
+		ret = tsinfo_parse_hwtstamp_provider(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+						     &__hwtst, info->extack,
+						     &mod);
+		if (ret < 0)
+			return ret;
+
+		if (mod) {
+			hwtstamp = devm_kzalloc(&dev->dev, sizeof(*hwtstamp),
+						GFP_KERNEL);
+			if (!hwtstamp)
+				return -ENOMEM;
+
+			hwtstamp->ptp = ptp_clock_get_by_index(&dev->dev,
+							       __hwtst.index);
+			if (!hwtstamp->ptp) {
+				NL_SET_ERR_MSG_ATTR(info->extack,
+						    tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+						    "no phc at such index");
+				ret = -ENODEV;
+				goto err_free_hwtstamp;
+			}
+			hwtstamp->qualifier = __hwtst.qualifier;
+
+			/* Does the hwtstamp supported in the netdev topology */
+			if (!netdev_support_hwtstamp(dev, hwtstamp)) {
+				NL_SET_ERR_MSG_ATTR(info->extack,
+						    tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+						    "phc not in this net device topology");
+				ret = -ENODEV;
+				goto err_clock_put;
+			}
+		}
+	}
+
+	/* Get current hwtstamp config if we are not changing the hwtstamp
+	 * source
+	 */
+	if (!mod) {
+		ret = dev_get_hwtstamp_phylib(dev, &hwtst_config);
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			goto err_clock_put;
+	}
+
+	/* Get the hwtstamp config from netlink */
+	if (tb[ETHTOOL_A_TSINFO_TX_TYPES]) {
+		ret = ethnl_parse_bitset(&req_tx_type, &mask,
+					 __HWTSTAMP_TX_CNT,
+					 tb[ETHTOOL_A_TSINFO_TX_TYPES],
+					 ts_tx_type_names, info->extack);
+		if (ret < 0)
+			goto err_clock_put;
+
+		/* Select only one tx type at a time */
+		if (ffs(req_tx_type) != fls(req_tx_type)) {
+			ret = -EINVAL;
+			goto err_clock_put;
+		}
+
+		hwtst_config.tx_type = ffs(req_tx_type) - 1;
+	}
+	if (tb[ETHTOOL_A_TSINFO_RX_FILTERS]) {
+		ret = ethnl_parse_bitset(&req_rx_filter, &mask,
+					 __HWTSTAMP_FILTER_CNT,
+					 tb[ETHTOOL_A_TSINFO_RX_FILTERS],
+					 ts_rx_filter_names, info->extack);
+		if (ret < 0)
+			goto err_clock_put;
+
+		/* Select only one rx filter at a time */
+		if (ffs(req_rx_filter) != fls(req_rx_filter)) {
+			ret = -EINVAL;
+			goto err_clock_put;
+		}
+
+		hwtst_config.rx_filter = ffs(req_rx_filter) - 1;
+	}
+	if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS]) {
+		ret = nla_get_u32(tb[ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS]);
+		if (ret < 0)
+			goto err_clock_put;
+		hwtst_config.flags = ret;
+	}
+
+	ret = net_hwtstamp_validate(&hwtst_config);
+	if (ret)
+		goto err_clock_put;
+
+	/* Disable current time stamping if we try to enable another one */
+	if (mod && (hwtst_config.tx_type || hwtst_config.rx_filter)) {
+		struct kernel_hwtstamp_config zero_config = {0};
+
+		ret = dev_set_hwtstamp_phylib(dev, &zero_config, info->extack);
+		if (ret < 0)
+			goto err_clock_put;
+	}
+
+	/* Changed the selected hwtstamp source if needed */
+	if (mod) {
+		struct hwtstamp_provider *__hwtstamp;
+
+		__hwtstamp = rcu_replace_pointer_rtnl(dev->hwtstamp, hwtstamp);
+		synchronize_rcu();
+		if (__hwtstamp) {
+			ptp_clock_put(&dev->dev, __hwtstamp->ptp);
+			kfree(__hwtstamp);
+		}
+	}
+
+	ret = dev_set_hwtstamp_phylib(dev, &hwtst_config, info->extack);
+	if (ret < 0)
+		goto err_clock_put;
+
+	return 1;
+
+err_clock_put:
+	if (hwtstamp)
+		ptp_clock_put(&dev->dev, hwtstamp->ptp);
+err_free_hwtstamp:
+	devm_kfree(&dev->dev, hwtstamp);
+
+	return ret;
+}
+
 const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_TSINFO_GET,
 	.reply_cmd		= ETHTOOL_MSG_TSINFO_GET_REPLY,
@@ -180,7 +774,12 @@ const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.req_info_size		= sizeof(struct tsinfo_req_info),
 	.reply_data_size	= sizeof(struct tsinfo_reply_data),
 
+	.parse_request		= tsinfo_parse_request,
 	.prepare_data		= tsinfo_prepare_data,
 	.reply_size		= tsinfo_reply_size,
 	.fill_reply		= tsinfo_fill_reply,
+
+	.set_validate		= ethnl_set_tsinfo_validate,
+	.set			= ethnl_set_tsinfo,
+	.set_ntf_cmd		= ETHTOOL_MSG_TSINFO_NTF,
 };

-- 
2.34.1


