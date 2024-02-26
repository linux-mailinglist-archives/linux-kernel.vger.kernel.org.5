Return-Path: <linux-kernel+bounces-81513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA2D8676F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332A728EE83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2412E1CC;
	Mon, 26 Feb 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ja1QOHPB"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206431292FE;
	Mon, 26 Feb 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954832; cv=none; b=LrEEl2DQDJD9DFaPUArFDUbwUSWTSY+grEpC+9/nc/wNKIRLN71RVLO3I5aGxd9ZXpJBveplaWyYC6GSNyH1XD/jAHsNi1NYwF8NMkXdNc6LMKWiQO4I6vyGiWsnUlES9T0fAkYiCsEeV/al11BFIEJAyK2L3UA3Vle1SF7G90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954832; c=relaxed/simple;
	bh=D1hmlqdsAFsyfqMg39BTtgb7KLnnljpR+wBwxt5uvAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZJPmJGlNGQbU9/FDTlVTacY+BIN/nwq82hd+SPaDR3OVVcTjxJeakDEGfrKGJmr0VREGTvkK17Iknn9Duw1sM7W5b8/07LqAKcOwsmBeDzG9UU9jrvkpAfWB1gM/26wyoim1VUrGHIZNvCtXSTG5j04fcVVzxs5F2Z46Yil7+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ja1QOHPB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66E2840008;
	Mon, 26 Feb 2024 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyPXzZdAggzKrd523wQ+gAGaHN3UCrZKu3KbwfxQF5k=;
	b=ja1QOHPBKLi4w8xtPhFki4LHt6E+ZeYDzhk2Bk5MsPt9w8BItAaBjsZPcVnHr4gW0aiEpj
	7wyoZF01ki42HV+WIDSEiRxxpSfbVRs+4NjLfCamMBKwDIPsaLe3sp8F7+NZvj57XY2fMV
	xWRhjKWaw2zcgn5R7JdWNIIxg49utpRNk5GfJYb7/ZYNcHnTEdlyn4gleLw12VZ8LzBFsy
	9EjobU8+jU3IU/EQUoDG88DcH322ep+k1swOH0NGuNrVARRWoW18fyR3JfrasWO9jC67OS
	0KGkJ23lj92A5EuaTDhQGTlCxkOFrF8WLc0c5PLOBSeLAq1MEalv5LuAHaZDjQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 26 Feb 2024 14:40:03 +0100
Subject: [PATCH net-next v9 12/13] net: ethtool: tsinfo: Add support for
 hwtstamp provider and get/set hwtstamp config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-feature_ptp_netnext-v9-12-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
In-Reply-To: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
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
X-Mailer: b4 0.12.4
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
---
 drivers/ptp/ptp_clock.c              |  45 +++
 include/linux/ethtool.h              |   4 +
 include/linux/netdevice.h            |   2 +
 include/linux/ptp_clock_kernel.h     |  32 ++
 include/uapi/linux/ethtool_netlink.h |  12 +
 include/uapi/linux/net_tstamp.h      |   3 +-
 net/core/dev.c                       |  23 ++
 net/ethtool/common.c                 |  31 ++
 net/ethtool/common.h                 |   3 +
 net/ethtool/netlink.c                |  14 +-
 net/ethtool/netlink.h                |   6 +-
 net/ethtool/tsinfo.c                 | 600 +++++++++++++++++++++++++++++++++--
 12 files changed, 752 insertions(+), 23 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index d7cd7e01990e..ccb81d49d2eb 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -575,6 +575,51 @@ struct ptp_clock *ptp_clock_get_by_index(int index)
 }
 EXPORT_SYMBOL(ptp_clock_get_by_index);
 
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
+EXPORT_SYMBOL(netdev_ptp_clock_find);
+
+bool netdev_support_hwtstamp(struct net_device *dev,
+			     struct hwtstamp_provider *hwtst)
+{
+	struct ptp_clock *tmp_ptp;
+	unsigned long index = 0;
+
+	netdev_for_each_ptp_clock_start(dev, index, tmp_ptp, 0) {
+		if (tmp_ptp != hwtst->ptp)
+			continue;
+
+		if (ptp_clock_from_phylib(hwtst->ptp) &&
+		    hwtst->qualifier == HWTSTAMP_PROVIDER_QUALIFIER_PRECISE)
+			return true;
+
+		if (ptp_clock_from_netdev(hwtst->ptp) &&
+		    dev_support_hwtstamp_qualifier(dev, hwtst->qualifier))
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
index f74190a8d9ee..5a00873bef48 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -650,6 +650,7 @@ struct ethtool_rxfh_param {
  * @cmd: command number = %ETHTOOL_GET_TS_INFO
  * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
  * @phc_index: device index of the associated PHC, or -1 if there is none
+ * @phc_qualifier: qualifier of the associated PHC
  * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
  * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
  */
@@ -657,6 +658,7 @@ struct kernel_ethtool_ts_info {
 	u32 cmd;
 	u32 so_timestamping;
 	int phc_index;
+	enum hwtstamp_provider_qualifier phc_qualifier;
 	enum hwtstamp_tx_types tx_types;
 	enum hwtstamp_rx_filters rx_filters;
 };
@@ -671,6 +673,7 @@ struct kernel_ethtool_ts_info {
  *	RSS.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
+ * @supported_hwtstamp_qualifier: bitfield of supported hwtstamp qualifier.
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
  *	correctly filled in by the core using system information, or
@@ -851,6 +854,7 @@ struct ethtool_ops {
 	u32	cap_rss_sym_xor_supported:1;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
+	u32	supported_hwtstamp_qualifiers;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
 	int	(*get_regs_len)(struct net_device *);
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 43e3050a99af..892366905939 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4013,6 +4013,8 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct netlink_ext_ack *extack);
 int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg);
+bool dev_support_hwtstamp_qualifier(struct net_device *dev,
+				    enum hwtstamp_provider_qualifier qualifier);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 174a0b98632b..142f755d507b 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -406,6 +406,32 @@ struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
 
 struct ptp_clock *ptp_clock_get_by_index(int index);
 
+/**
+ * netdev_ptp_clock_find() - obtain the next PTP clock in the netdev
+ *			     topology
+ *
+ * @dev:    Pointer of the net device
+ * @index:  Pointer of ptp clock index start point
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
+ * netdev_support_hwtstamp() - return true if the hwtstamp belong to the
+ *			       netdev topology
+ *
+ * @dev:    Pointer of the net device
+ * @hwtst:  Pointer of the hwtstamp provider
+ */
+
+bool netdev_support_hwtstamp(struct net_device *dev,
+			     struct hwtstamp_provider *hwtst);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -489,6 +515,12 @@ static inline struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
 { return NULL; }
 static inline struct ptp_clock *ptp_clock_get_by_index(int index);
 { return NULL; }
+static inline struct ptp_clock *netdev_ptp_clock_find(struct net_device *dev,
+						      unsigned long *indexp)
+{ return NULL; }
+static inline bool netdev_support_hwtstamp(struct net_device *dev,
+					   struct hwtstamp_provider *hwtst);
+{ return false; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..07a33522532b 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_TSINFO_SET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -470,6 +471,15 @@ enum {
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
@@ -478,6 +488,8 @@ enum {
 	ETHTOOL_A_TSINFO_TX_TYPES,			/* bitset */
 	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
 	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
+	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST,	/* nest - *_TSINFO_HWTSTAMP_PROVIDER_* */
+	ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_TSINFO_CNT,
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a9ed48ee8fc7..49675a36a0b2 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -43,8 +43,9 @@ enum {
 	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
 	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
 	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
+	SOF_TIMESTAMPING_GHWTSTAMP = (1 << 17),
 
-	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
+	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_GHWTSTAMP,
 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
 				 SOF_TIMESTAMPING_LAST
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index c588808be77f..946aaba01d28 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10800,6 +10800,29 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(netdev_set_default_ethtool_ops);
 
+bool
+dev_support_hwtstamp_qualifier(struct net_device *dev,
+			       enum hwtstamp_provider_qualifier qualifier)
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
+EXPORT_SYMBOL_GPL(dev_support_hwtstamp_qualifier);
+
 /**
  * netdev_sw_irq_coalesce_default_on() - enable SW IRQ coalescing by default
  * @dev: netdev to enable the IRQ coalescing on
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index b3f45c307301..37071929128a 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -426,6 +426,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  = "option-tx-swhw",
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
+	[const_ilog2(SOF_TIMESTAMPING_GHWTSTAMP)]    = "get-hwtstamp",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
@@ -629,11 +630,41 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
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
 
+	if (dev->hwtstamp.ptp)
+		return ethtool_get_ts_info_by_phc(dev, info, &dev->hwtstamp);
+
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
 
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 9de3d6255818..99575a403d0d 100644
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
index bd04f28d5cf4..4a4dc1765d10 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -306,6 +306,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PLCA_GET_STATUS]	= &ethnl_plca_status_request_ops,
 	[ETHTOOL_MSG_MM_GET]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_MM_SET]		= &ethnl_mm_request_ops,
+	[ETHTOOL_MSG_TSINFO_SET]	= &ethnl_tsinfo_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -974,9 +975,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
@@ -1125,6 +1126,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
index 9a333a8d04c1..8a6f767ab6db 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -422,7 +422,7 @@ extern const struct nla_policy ethnl_pause_get_policy[ETHTOOL_A_PAUSE_STATS_SRC
 extern const struct nla_policy ethnl_pause_set_policy[ETHTOOL_A_PAUSE_TX + 1];
 extern const struct nla_policy ethnl_eee_get_policy[ETHTOOL_A_EEE_HEADER + 1];
 extern const struct nla_policy ethnl_eee_set_policy[ETHTOOL_A_EEE_TX_LPI_TIMER + 1];
-extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_HEADER + 1];
+extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1];
 extern const struct nla_policy ethnl_cable_test_act_policy[ETHTOOL_A_CABLE_TEST_HEADER + 1];
 extern const struct nla_policy ethnl_cable_test_tdr_act_policy[ETHTOOL_A_CABLE_TEST_TDR_CFG + 1];
 extern const struct nla_policy ethnl_tunnel_info_get_policy[ETHTOOL_A_TUNNEL_INFO_HEADER + 1];
@@ -441,6 +441,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_tsinfo_set_policy[ETHTOOL_A_TSINFO_MAX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -448,6 +449,9 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_tsinfo_start(struct netlink_callback *cb);
+int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_tsinfo_done(struct netlink_callback *cb);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 608d270018cb..0ced8057fb53 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -8,50 +9,192 @@
 
 struct tsinfo_req_info {
 	struct ethnl_req_info		base;
+	struct {
+		int index;
+		u32 qualifier;
+	} hwtst;
+	bool				get_hwtstamp;
 };
 
 struct tsinfo_reply_data {
 	struct ethnl_reply_data		base;
-	struct kernel_ethtool_ts_info		ts_info;
+	union {
+		struct kernel_ethtool_ts_info		ts_info;
+		struct {
+			u32 tx_type;
+			u32 rx_filter;
+			u32 flags;
+		} hwtst_config;
+	};
 };
 
+#define TSINFO_REQINFO(__req_base) \
+	container_of(__req_base, struct tsinfo_req_info, base)
+
 #define TSINFO_REPDATA(__reply_base) \
 	container_of(__reply_base, struct tsinfo_reply_data, base)
 
-const struct nla_policy ethnl_tsinfo_get_policy[] = {
+const struct nla_policy
+ethnl_tsinfo_hwtstamp_provider_policy[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_MAX + 1] = {
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] = { .type = NLA_U32 },
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER] = { .type = NLA_U32 },
+};
+
+const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
 	[ETHTOOL_A_TSINFO_HEADER]		=
 		NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_TSINFO_TIMESTAMPING] = { .type = NLA_NESTED },
+	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST] = { .type = NLA_NESTED },
 };
 
+static int
+tsinfo_parse_request(struct ethnl_req_info *req_base, struct nlattr **tb,
+		     struct netlink_ext_ack *extack)
+{
+	struct nlattr *hwtst_tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)];
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
+	unsigned long val = 0, mask = 0;
+	int ret;
+
+	req->hwtst.index = -1;
+
+	if (tb[ETHTOOL_A_TSINFO_TIMESTAMPING]) {
+		ret = ethnl_parse_bitset(&val, &mask, __SOF_TIMESTAMPING_CNT,
+					 tb[ETHTOOL_A_TSINFO_TIMESTAMPING],
+					 sof_timestamping_names, extack);
+		if (ret < 0)
+			return ret;
+
+		if (val & SOF_TIMESTAMPING_GHWTSTAMP) {
+			/* We support only the get of the current hwtstamp config
+			 * for now.
+			 */
+			if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST])
+				return -EOPNOTSUPP;
+
+			req->get_hwtstamp = true;
+			return 0;
+		}
+	}
+
+	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST])
+		return 0;
+
+	ret = nla_parse_nested(hwtst_tb,
+			       ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy) - 1,
+			       tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+			       ethnl_tsinfo_hwtstamp_provider_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] ||
+	    !hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER])
+		return -EINVAL;
+
+	ret = nla_get_u32(hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX]);
+	if (ret < 0)
+		return -EINVAL;
+	req->hwtst.index = ret;
+
+	ret = nla_get_u32(hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER]);
+	if (ret < 0 || HWTSTAMP_PROVIDER_QUALIFIER_CNT <= ret)
+		return -EINVAL;
+	req->hwtst.qualifier = ret;
+
+	return 0;
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
-	ret = __ethtool_get_ts_info(dev, &data->ts_info);
+
+	if (!netif_device_present(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
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
+	if (req->hwtst.index != -1) {
+		struct hwtstamp_provider hwtstamp;
+
+		hwtstamp.ptp = ptp_clock_get_by_index(req->hwtst.index);
+		if (!hwtstamp.ptp) {
+			ret = -ENODEV;
+			goto out;
+		}
+		hwtstamp.qualifier = req->hwtst.qualifier;
+
+		ret = ethtool_get_ts_info_by_phc(dev, &data->ts_info,
+						 &hwtstamp);
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
+				  bool compact)
 {
-	const struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
-	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
-	const struct kernel_ethtool_ts_info *ts_info = &data->ts_info;
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
+			  bool compact)
+{
+	int len = 0;
+	int ret;
 
 	if (ts_info->so_timestamping) {
 		ret = ethnl_bitset32_size(&ts_info->so_timestamping, NULL,
@@ -77,19 +220,37 @@ static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 			return ret;
 		len += ret;	/* _TSINFO_RX_FILTERS */
 	}
-	if (ts_info->phc_index >= 0)
+	if (ts_info->phc_index >= 0) {
+		/* _TSINFO_HWTSTAMP_PROVIDER_NEST */
+		len += nla_total_size(sizeof(u32) * 2);
 		len += nla_total_size(sizeof(u32));	/* _TSINFO_PHC_INDEX */
+	}
 
 	return len;
 }
 
-static int tsinfo_fill_reply(struct sk_buff *skb,
-			     const struct ethnl_req_info *req_base,
+static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 			     const struct ethnl_reply_data *reply_base)
 {
 	const struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
-	const struct kernel_ethtool_ts_info *ts_info = &data->ts_info;
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
+
+	BUILD_BUG_ON(__SOF_TIMESTAMPING_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+
+	if (req->get_hwtstamp)
+		return tsinfo_reply_size_hwtstamp_config(data, compact);
+
+	return tsinfo_reply_size_ts_info(&data->ts_info, compact);
+}
+
+static int tsinfo_fill_ts_info(struct sk_buff *skb,
+			       const struct kernel_ethtool_ts_info *ts_info,
+			       bool compact)
+{
+	struct nlattr *nest;
 	int ret;
 
 	if (ts_info->so_timestamping) {
@@ -116,13 +277,412 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
 		if (ret < 0)
 			return ret;
 	}
-	if (ts_info->phc_index >= 0 &&
-	    nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX, ts_info->phc_index))
-		return -EMSGSIZE;
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
+		ret = nla_put_u32(skb,
+				  ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX,
+				  ts_info->phc_index);
+		if (ret) {
+			nla_nest_cancel(skb, nest);
+			return ret;
+		}
+
+		ret = nla_put_u32(skb,
+				  ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER,
+				  ts_info->phc_qualifier);
+		if (ret) {
+			nla_nest_cancel(skb, nest);
+			return ret;
+		}
+
+		nla_nest_end(skb, nest);
+	}
+	return 0;
+}
+
+static int
+tsinfo_fill_hwtstamp_config(struct sk_buff *skb,
+			    const struct tsinfo_reply_data *data,
+			    bool compact)
+{
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
+	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
+
+	if (req->get_hwtstamp)
+		return tsinfo_fill_hwtstamp_config(skb, data, compact);
+
+	return tsinfo_fill_ts_info(skb, &data->ts_info, compact);
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
+	void *ehdr;
+	int ret;
+
+	reply_data = ctx->reply_data;
+	req_info = ctx->req_info;
+	req_info->hwtst.index = ptp_clock_index(ptp);
+
+	for (; ctx->pos_phcqualifier < HWTSTAMP_PROVIDER_QUALIFIER_CNT;
+	     ctx->pos_phcqualifier++) {
+		if (!dev_support_hwtstamp_qualifier(dev, ctx->pos_phcqualifier))
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
+	if (ret < 0)
+		genlmsg_cancel(skb, ehdr);
+	else
+		genlmsg_end(skb, ehdr);
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
+	unsigned long val = 0, mask = 0;
+	int ret;
+
+	ret = ethnl_parse_bitset(&val, &mask, __SOF_TIMESTAMPING_CNT,
+				 tb[ETHTOOL_A_TSINFO_TIMESTAMPING],
+				 sof_timestamping_names, extack);
+	if (ret < 0)
+		return ret;
+
+	if (val & SOF_TIMESTAMPING_GHWTSTAMP)
+		/* We do not support simultaneous hwtstamp for now */
+		return -EOPNOTSUPP;
 
 	return 0;
 }
 
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
+	struct nlattr *hwtst_tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)];
+	unsigned long mask = 0, req_rx_filter, req_tx_type;
+	struct kernel_hwtstamp_config hwtst_config = {0};
+	struct net_device *dev = req_base->dev;
+	struct hwtstamp_provider hwtstamp;
+	struct nlattr **tb = info->attrs;
+	int ret, phc_index = 0;
+	bool mod = false;
+
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
+	if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST]) {
+		ret = nla_parse_nested(hwtst_tb,
+				       ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy) - 1,
+				       tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_NEST],
+				       ethnl_tsinfo_hwtstamp_provider_policy, info->extack);
+		if (ret < 0)
+			return ret;
+
+		if (!hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX] ||
+		    !hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER])
+			return -EINVAL;
+
+		memcpy(&hwtstamp, &dev->hwtstamp, sizeof(hwtstamp));
+		if (hwtstamp.ptp)
+			phc_index = ptp_clock_index(hwtstamp.ptp);
+
+		ethnl_update_u32(&phc_index,
+				 hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_INDEX],
+				 &mod);
+		ethnl_update_u32(&hwtstamp.qualifier,
+				 hwtst_tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER_QUALIFIER],
+				 &mod);
+
+		/* Does the hwtstamp supported in the netdev topology */
+		if (mod) {
+			hwtstamp.ptp = ptp_clock_get_by_index(phc_index);
+			if (!hwtstamp.ptp)
+				return -ENODEV;
+
+			if (!netdev_support_hwtstamp(dev, &hwtstamp))
+				return -ENODEV;
+		}
+	}
+
+	/* Get current hwtstamp config if we are not changing the hwtstamp
+	 * source
+	 */
+	if (!mod) {
+		ret = dev_get_hwtstamp_phylib(dev, &hwtst_config);
+		if (ret < 0 && ret != EOPNOTSUPP)
+			return ret;
+	}
+
+	/* Get the hwtstamp config from netlink */
+	if (tb[ETHTOOL_A_TSINFO_TX_TYPES]) {
+		ret = ethnl_parse_bitset(&req_tx_type, &mask,
+					 __HWTSTAMP_TX_CNT,
+					 tb[ETHTOOL_A_TSINFO_TX_TYPES],
+					 ts_tx_type_names, info->extack);
+		if (ret < 0)
+			return ret;
+
+		if (ffs(req_tx_type) != fls(req_tx_type))
+			return -EINVAL;
+
+		hwtst_config.tx_type = ffs(req_tx_type) - 1;
+	}
+	if (tb[ETHTOOL_A_TSINFO_RX_FILTERS]) {
+		ret = ethnl_parse_bitset(&req_rx_filter, &mask,
+					 __HWTSTAMP_FILTER_CNT,
+					 tb[ETHTOOL_A_TSINFO_RX_FILTERS],
+					 ts_rx_filter_names, info->extack);
+		if (ret < 0)
+			return ret;
+
+		if (ffs(req_rx_filter) != fls(req_rx_filter))
+			return -EINVAL;
+
+		hwtst_config.rx_filter = ffs(req_rx_filter) - 1;
+	}
+	if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS]) {
+		ret = nla_get_u32(tb[ETHTOOL_A_TSINFO_HWTSTAMP_FLAGS]);
+		if (ret < 0)
+			return ret;
+		hwtst_config.flags = ret;
+	}
+
+	ret = net_hwtstamp_validate(&hwtst_config);
+	if (ret)
+		return ret;
+
+	/* Disable current time stamping if we try to enable another one */
+	if (mod && (hwtst_config.tx_type || hwtst_config.rx_filter)) {
+		struct kernel_hwtstamp_config zero_config = {0};
+
+		ret = dev_set_hwtstamp_phylib(dev, &zero_config, info->extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Changed the selected hwtstamp source if needed */
+	if (mod)
+		memcpy(&dev->hwtstamp, &hwtstamp, sizeof(hwtstamp));
+
+	ret = dev_set_hwtstamp_phylib(dev, &hwtst_config, info->extack);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_TSINFO_GET,
 	.reply_cmd		= ETHTOOL_MSG_TSINFO_GET_REPLY,
@@ -130,7 +690,11 @@ const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.req_info_size		= sizeof(struct tsinfo_req_info),
 	.reply_data_size	= sizeof(struct tsinfo_reply_data),
 
+	.parse_request		= tsinfo_parse_request,
 	.prepare_data		= tsinfo_prepare_data,
 	.reply_size		= tsinfo_reply_size,
 	.fill_reply		= tsinfo_fill_reply,
+
+	.set_validate		= ethnl_set_tsinfo_validate,
+	.set			= ethnl_set_tsinfo,
 };

-- 
2.25.1


