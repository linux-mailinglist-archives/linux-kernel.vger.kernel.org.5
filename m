Return-Path: <linux-kernel+bounces-164316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F58B7C42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11341C22D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993031802DD;
	Tue, 30 Apr 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H1dAWrFQ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7417335C;
	Tue, 30 Apr 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492253; cv=none; b=AM93lYN3tANNndfIranM6bi/47SePCFlaEe2SLupSo9c+rdFSTKm0LwMd0xdDanfrjiEy1Hj7HxeSsixIX7c8ROjE7PurIbuiy9axUeRfmwOAnMS8MMa5oWArlRrxSTwDt/TPX20/VujznTi0aL5tXiouVq9ROXmiiL1Vx5yh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492253; c=relaxed/simple;
	bh=6UepRElJ0NNRFkYqS83A7fonjyEhGSxRwarS0AyvpR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8268dOfqoJvdNuVXfLhgbzgS88S0mBOCd4qk31pNAwX3kXAWkhpBKEt4k8oV0R+sd7ZprW/0CcBn4CVPvaHc78m3cDm4QgrE2NYSXJMT1yH9yJ7nU24i9QUqwviVm19Ht2OvTyx7fWcy0CYeUF+cQOQC/sYEG8OJ7tgsqL0JS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H1dAWrFQ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 757E92001F;
	Tue, 30 Apr 2024 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RSxEyKP8goQGCUViFd60SqFX3faTKpNxDY4+ERQlv4=;
	b=H1dAWrFQRJzXuTcWqT9Cky7PezBK5vw2eN3Y/3vkTqgd5yhr/TCyLcjfYFqurKQjK5ldRi
	2hnMtBNvikSy+/ITBkH+U1I9HF/YvpL75sGGJBD1Uxkm6LHlf8bw0oEl8t20rjgFKa7fcb
	NZrfmJsB7gtVGRAtm+JkEtb7BL9JISvS1ndy9JDYBKBrkks1l51E7BwsNdEwR9suxQ02Kf
	WrwVtIQW6gf0ruSeyuYbvXmrB5LsAakSivqzJdceLutnnU/dG03p2geqBJ30mIgqenjqjF
	3HGQoq7pNJGhzfN5mKspD3SzQribCouFaywIgEO5J1+3vDRGym18Lbir53eSbA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Apr 2024 17:49:50 +0200
Subject: [PATCH net-next v12 07/13] net: Add struct kernel_ethtool_ts_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-feature_ptp_netnext-v12-7-2c5f24b6a914@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>, 
 Alexandra Winter <wintera@linux.ibm.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

In prevision to add new UAPI for hwtstamp we will be limited to the struct
ethtool_ts_info that is currently passed in fixed binary format through the
ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
already started operating on an extensible kernel variant of that
structure, similar in concept to struct kernel_hwtstamp_config vs struct
hwtstamp_config.

Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
we introduce the kernel-only structure in include/linux/ethtool.h.
The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.

Acked-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch

Change in v11:
- Remove a change of my out of tree patch.
---
 drivers/net/bonding/bond_main.c                    |  4 ++--
 drivers/net/can/dev/dev.c                          |  2 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |  2 +-
 drivers/net/can/usb/gs_usb.c                       |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |  2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c    |  2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h    |  2 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |  2 +-
 drivers/net/dsa/microchip/ksz_ptp.h                |  2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c               |  2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h               |  4 ++--
 drivers/net/dsa/ocelot/felix.c                     |  2 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |  2 +-
 drivers/net/dsa/sja1105/sja1105_ptp.h              |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  2 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |  2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  2 +-
 drivers/net/ethernet/broadcom/tg3.c                |  2 +-
 drivers/net/ethernet/cadence/macb.h                |  2 +-
 drivers/net/ethernet/cadence/macb_main.c           |  4 ++--
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |  2 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  2 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  2 +-
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |  2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |  2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |  2 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |  2 +-
 drivers/net/ethernet/freescale/fec_main.c          |  2 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |  2 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h |  2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  4 ++--
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |  4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h | 10 ++++-----
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |  2 +-
 .../ethernet/microchip/lan966x/lan966x_ethtool.c   |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  2 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |  2 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             |  2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.h        |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  2 +-
 drivers/net/ethernet/renesas/rswitch.c             |  2 +-
 drivers/net/ethernet/sfc/ethtool.c                 |  2 +-
 drivers/net/ethernet/sfc/falcon/nic.h              |  2 +-
 drivers/net/ethernet/sfc/ptp.c                     |  2 +-
 drivers/net/ethernet/sfc/ptp.h                     |  5 +++--
 drivers/net/ethernet/sfc/siena/ethtool.c           |  2 +-
 drivers/net/ethernet/sfc/siena/ptp.c               |  2 +-
 drivers/net/ethernet/sfc/siena/ptp.h               |  4 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |  2 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |  4 ++--
 drivers/net/ethernet/ti/cpsw_priv.h                |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |  2 +-
 drivers/net/ethernet/ti/netcp_ethss.c              |  4 ++--
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |  2 +-
 drivers/net/macvlan.c                              |  2 +-
 drivers/net/netdevsim/ethtool.c                    |  2 +-
 drivers/net/phy/bcm-phy-ptp.c                      |  2 +-
 drivers/net/phy/dp83640.c                          |  2 +-
 drivers/net/phy/micrel.c                           |  4 ++--
 drivers/net/phy/mscc/mscc_ptp.c                    |  2 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |  2 +-
 drivers/ptp/ptp_ines.c                             |  2 +-
 drivers/s390/net/qeth_ethtool.c                    |  2 +-
 include/linux/can/dev.h                            |  2 +-
 include/linux/ethtool.h                            | 25 +++++++++++++++++++---
 include/linux/mii_timestamper.h                    |  2 +-
 include/linux/phy.h                                |  2 +-
 include/net/dsa.h                                  |  2 +-
 include/soc/mscc/ocelot.h                          |  2 +-
 net/8021q/vlan_dev.c                               |  2 +-
 net/dsa/user.c                                     |  2 +-
 net/ethtool/common.c                               |  6 +++---
 net/ethtool/common.h                               |  2 +-
 net/ethtool/ioctl.c                                | 12 +++++++++--
 net/ethtool/tsinfo.c                               |  6 +++---
 net/sched/sch_taprio.c                             |  2 +-
 100 files changed, 149 insertions(+), 121 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b3a7d60c3a5c..0ae6bb1a6985 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5755,10 +5755,10 @@ static void bond_ethtool_get_drvinfo(struct net_device *bond_dev,
 }
 
 static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
-				    struct ethtool_ts_info *info)
+				    struct kernel_ethtool_ts_info *info)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct ethtool_ts_info ts_info;
+	struct kernel_ethtool_ts_info ts_info;
 	struct net_device *real_dev;
 	bool sw_tx_support = false;
 	struct list_head *iter;
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3a3be5cdfc1f..0e120873bbc8 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -376,7 +376,7 @@ EXPORT_SYMBOL(can_eth_ioctl_hwts);
  * supporting hardware timestamps
  */
 int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
-				    struct ethtool_ts_info *info)
+				    struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 31c9c127e24b..b50005397463 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -777,7 +777,7 @@ static const struct net_device_ops peak_canfd_netdev_ops = {
 };
 
 static int peak_get_ts_info(struct net_device *dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 65c962f76898..7a5681ff76cf 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1145,7 +1145,7 @@ static int gs_usb_set_phys_id(struct net_device *netdev,
 }
 
 static int gs_usb_get_ts_info(struct net_device *netdev,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	struct gs_can *dev = netdev_priv(netdev);
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 1efa39e134f4..3d68fef46ded 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -897,7 +897,7 @@ int peak_usb_set_eeprom(struct net_device *netdev,
 	return 0;
 }
 
-int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
+int pcan_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index f6cf84bb718f..abab00930b9d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -145,7 +145,7 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *tv);
 int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
-int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
+int pcan_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 
 /* common 32-bit CAN channel ID ethtool management */
 int peak_usb_get_eeprom_len(struct net_device *netdev);
diff --git a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
index bd7aacc71a63..ca2500aba96f 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
@@ -16,7 +16,7 @@
 #include "hellcreek_ptp.h"
 
 int hellcreek_get_ts_info(struct dsa_switch *ds, int port,
-			  struct ethtool_ts_info *info)
+			  struct kernel_ethtool_ts_info *info)
 {
 	struct hellcreek *hellcreek = ds->priv;
 
diff --git a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h
index 71af77efb28b..7d88da2134f2 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h
+++ b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h
@@ -48,7 +48,7 @@ void hellcreek_port_txtstamp(struct dsa_switch *ds, int port,
 			     struct sk_buff *skb);
 
 int hellcreek_get_ts_info(struct dsa_switch *ds, int port,
-			  struct ethtool_ts_info *info);
+			  struct kernel_ethtool_ts_info *info);
 
 long hellcreek_hwtstamp_work(struct ptp_clock_info *ptp);
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 1fe105913c75..f0bd46e5d4ec 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -293,7 +293,7 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
 /* The function is return back the capability of timestamping feature when
  * requested through ethtool -T <interface> utility
  */
-int ksz_get_ts_info(struct dsa_switch *ds, int port, struct ethtool_ts_info *ts)
+int ksz_get_ts_info(struct dsa_switch *ds, int port, struct kernel_ethtool_ts_info *ts)
 {
 	struct ksz_device *dev = ds->priv;
 	struct ksz_ptp_data *ptp_data;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 0ca8ca4f804e..2f1783c0d723 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -38,7 +38,7 @@ int ksz_ptp_clock_register(struct dsa_switch *ds);
 void ksz_ptp_clock_unregister(struct dsa_switch *ds);
 
 int ksz_get_ts_info(struct dsa_switch *ds, int port,
-		    struct ethtool_ts_info *ts);
+		    struct kernel_ethtool_ts_info *ts);
 int ksz_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr);
 int ksz_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr);
 void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 331b4ca089ff..49e6e1355142 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -64,7 +64,7 @@ static int mv88e6xxx_ptp_read(struct mv88e6xxx_chip *chip, int addr,
 #define TX_TSTAMP_TIMEOUT	msecs_to_jiffies(40)
 
 int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
-			  struct ethtool_ts_info *info)
+			  struct kernel_ethtool_ts_info *info)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops;
 	struct mv88e6xxx_chip *chip;
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index cf7fb6d660b1..85acc758e3eb 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -121,7 +121,7 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 			     struct sk_buff *skb);
 
 int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
-			  struct ethtool_ts_info *info);
+			  struct kernel_ethtool_ts_info *info);
 
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip);
@@ -157,7 +157,7 @@ static inline void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 }
 
 static inline int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
-					struct ethtool_ts_info *info)
+					struct kernel_ethtool_ts_info *info)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 61e95487732d..b5cd7d7f47ef 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1220,7 +1220,7 @@ static int felix_get_sset_count(struct dsa_switch *ds, int port, int sset)
 }
 
 static int felix_get_ts_info(struct dsa_switch *ds, int port,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	struct ocelot *ocelot = ds->priv;
 
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index a7d41e781398..a1f4ca6ad888 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -111,7 +111,7 @@ int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
 }
 
 int sja1105_get_ts_info(struct dsa_switch *ds, int port,
-			struct ethtool_ts_info *info)
+			struct kernel_ethtool_ts_info *info)
 {
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_ptp_data *ptp_data = &priv->ptp_data;
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.h b/drivers/net/dsa/sja1105/sja1105_ptp.h
index 416461ee95d2..8add2bd5f728 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.h
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.h
@@ -101,7 +101,7 @@ void sja1105pqrs_ptp_cmd_packing(u8 *buf, struct sja1105_ptp_cmd *cmd,
 				 enum packing_op op);
 
 int sja1105_get_ts_info(struct dsa_switch *ds, int port,
-			struct ethtool_ts_info *ts);
+			struct kernel_ethtool_ts_info *ts);
 
 void sja1105_ptp_txtstamp_skb(struct dsa_switch *ds, int slot,
 			      struct sk_buff *clone);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 58e7e88aae5b..21407a26f806 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -577,7 +577,7 @@ static int xgbe_set_rxfh(struct net_device *netdev,
 }
 
 static int xgbe_get_ts_info(struct net_device *netdev,
-			    struct ethtool_ts_info *ts_info)
+			    struct kernel_ethtool_ts_info *ts_info)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index a2606ee3b0a5..d0aecd1d7357 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -652,7 +652,7 @@ static int aq_ethtool_set_wol(struct net_device *ndev,
 }
 
 static int aq_ethtool_get_ts_info(struct net_device *ndev,
-				  struct ethtool_ts_info *info)
+				  struct kernel_ethtool_ts_info *info)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 58956ed8f531..c7b56a5e5425 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -3634,7 +3634,7 @@ static int bnx2x_set_channels(struct net_device *dev,
 }
 
 static int bnx2x_get_ts_info(struct net_device *dev,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	struct bnx2x *bp = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 68444234b268..116a92a6da79 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5008,7 +5008,7 @@ static int bnxt_get_dump_data(struct net_device *dev, struct ethtool_dump *dump,
 }
 
 static int bnxt_get_ts_info(struct net_device *dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ptp_cfg *ptp;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index e6ff3c9bd7e5..bad087887deb 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6141,7 +6141,7 @@ static void tg3_refclk_write(struct tg3 *tp, u64 newval)
 
 static inline void tg3_full_lock(struct tg3 *tp, int irq_sync);
 static inline void tg3_full_unlock(struct tg3 *tp);
-static int tg3_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
+static int tg3_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 {
 	struct tg3 *tp = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index aa5700ac9c00..44fa86b0c157 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1163,7 +1163,7 @@ struct macb_ptp_info {
 	s32 (*get_ptp_max_adj)(void);
 	unsigned int (*get_tsu_rate)(struct macb *bp);
 	int (*get_ts_info)(struct net_device *dev,
-			   struct ethtool_ts_info *info);
+			   struct kernel_ethtool_ts_info *info);
 	int (*get_hwtst)(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *tstamp_config);
 	int (*set_hwtst)(struct net_device *netdev,
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 898debfd4db3..4266de5a1ee7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3376,7 +3376,7 @@ static s32 gem_get_ptp_max_adj(void)
 }
 
 static int gem_get_ts_info(struct net_device *dev,
-			   struct ethtool_ts_info *info)
+			   struct kernel_ethtool_ts_info *info)
 {
 	struct macb *bp = netdev_priv(dev);
 
@@ -3417,7 +3417,7 @@ static struct macb_ptp_info gem_ptp_info = {
 #endif
 
 static int macb_get_ts_info(struct net_device *netdev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct macb *bp = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index d3e07b6ed5e1..5835965dbc32 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -2497,7 +2497,7 @@ static int lio_set_intr_coalesce(struct net_device *netdev,
 }
 
 static int lio_get_ts_info(struct net_device *netdev,
-			   struct ethtool_ts_info *info)
+			   struct kernel_ethtool_ts_info *info)
 {
 	struct lio *lio = GET_LIO(netdev);
 
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index 34125b8cd935..6a04d2530176 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -836,7 +836,7 @@ static int nicvf_set_pauseparam(struct net_device *dev,
 }
 
 static int nicvf_get_ts_info(struct net_device *netdev,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	struct nicvf *nic = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 47eecde36285..3d091947ae00 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -1550,7 +1550,7 @@ static int set_flash(struct net_device *netdev, struct ethtool_flash *ef)
 	return ret;
 }
 
-static int get_ts_info(struct net_device *dev, struct ethtool_ts_info *ts_info)
+static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts_info)
 {
 	struct port_info *pi = netdev_priv(dev);
 	struct  adapter *adapter = pi->adapter;
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 241906697019..497c0c6a17d1 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -599,7 +599,7 @@ static int enic_set_rxfh(struct net_device *netdev,
 }
 
 static int enic_get_ts_info(struct net_device *netdev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
 				SOF_TIMESTAMPING_RX_SOFTWARE |
diff --git a/drivers/net/ethernet/engleder/tsnep_ethtool.c b/drivers/net/ethernet/engleder/tsnep_ethtool.c
index 65ec1abc9442..9aa286ba1f00 100644
--- a/drivers/net/ethernet/engleder/tsnep_ethtool.c
+++ b/drivers/net/ethernet/engleder/tsnep_ethtool.c
@@ -305,7 +305,7 @@ static void tsnep_ethtool_get_channels(struct net_device *netdev,
 }
 
 static int tsnep_ethtool_get_ts_info(struct net_device *netdev,
-				     struct ethtool_ts_info *info)
+				     struct kernel_ethtool_ts_info *info)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 5bd0b36d1feb..0e923d805732 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -394,7 +394,7 @@ static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 }
 
 static int dpaa_get_ts_info(struct net_device *net_dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct device *dev = net_dev->dev.parent;
 	struct device_node *mac_node = dev->of_node;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index e80e9388c71f..7f476519b7ad 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -794,7 +794,7 @@ int dpaa2_phc_index = -1;
 EXPORT_SYMBOL(dpaa2_phc_index);
 
 static int dpaa2_eth_get_ts_info(struct net_device *dev,
-				 struct ethtool_ts_info *info)
+				 struct kernel_ethtool_ts_info *info)
 {
 	if (!dpaa2_ptp)
 		return ethtool_op_get_ts_info(dev, info);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index f7753ea5b57e..5e684b23c5f5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -841,7 +841,7 @@ static int enetc_set_coalesce(struct net_device *ndev,
 }
 
 static int enetc_get_ts_info(struct net_device *ndev,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	int *phc_idx;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8bd213da8fb6..be7921e5c8c4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2762,7 +2762,7 @@ static void fec_enet_get_regs(struct net_device *ndev,
 }
 
 static int fec_enet_get_ts_info(struct net_device *ndev,
-				struct ethtool_ts_info *info)
+				struct kernel_ethtool_ts_info *info)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 7a15b9245698..f581402ad740 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1448,7 +1448,7 @@ static int gfar_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 }
 
 static int gfar_get_ts_info(struct net_device *dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	struct platform_device *ptp_dev;
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
index 4edd0adfc6c7..7f081e6e8c87 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
@@ -1040,7 +1040,7 @@ static int fun_set_rxfh(struct net_device *netdev,
 }
 
 static int fun_get_ts_info(struct net_device *netdev,
-			   struct ethtool_ts_info *info)
+			   struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 7c2c8bea4c06..dd9a1942b195 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -786,7 +786,7 @@ struct hnae3_ae_ops {
 	void (*get_rx_hwts)(struct hnae3_handle *handle, struct sk_buff *skb,
 			    u32 nsec, u32 sec);
 	int (*get_ts_info)(struct hnae3_handle *handle,
-			   struct ethtool_ts_info *info);
+			   struct kernel_ethtool_ts_info *info);
 	int (*get_link_diagnosis_info)(struct hnae3_handle *handle,
 				       u32 *status_code);
 	void (*clean_vf_config)(struct hnae3_ae_dev *ae_dev, int num_vfs);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 941cb529d671..b1e988347347 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -2009,7 +2009,7 @@ static int hns3_set_tunable(struct net_device *netdev,
 				 ETHTOOL_RING_USE_TX_PUSH)
 
 static int hns3_get_ts_info(struct net_device *netdev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 507d7ce26d83..5fff8ed388f8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -378,7 +378,7 @@ int hclge_ptp_set_cfg(struct hclge_dev *hdev, struct ifreq *ifr)
 }
 
 int hclge_ptp_get_ts_info(struct hnae3_handle *handle,
-			  struct ethtool_ts_info *info)
+			  struct kernel_ethtool_ts_info *info)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h
index bbee74cd8404..63483636c074 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h
@@ -138,6 +138,6 @@ int hclge_ptp_set_cfg(struct hclge_dev *hdev, struct ifreq *ifr);
 int hclge_ptp_init(struct hclge_dev *hdev);
 void hclge_ptp_uninit(struct hclge_dev *hdev);
 int hclge_ptp_get_ts_info(struct hnae3_handle *handle,
-			  struct ethtool_ts_info *info);
+			  struct kernel_ethtool_ts_info *info);
 int hclge_ptp_cfg_qry(struct hclge_dev *hdev, u32 *cfg);
 #endif
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 85da20778e0f..9364bc2b4eb1 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2263,7 +2263,7 @@ static int e1000e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 }
 
 static int e1000e_get_ts_info(struct net_device *netdev,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 42e7e6cdaa6d..ad83640c1218 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2549,7 +2549,7 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 }
 
 static int i40e_get_ts_info(struct net_device *dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct i40e_pf *pf = i40e_netdev_to_pf(dev);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..b6ca3f14c74f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3434,7 +3434,7 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 }
 
 static int
-ice_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
+ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(dev);
 
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 61d72250c0ed..06b9970dffad 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2381,7 +2381,7 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 }
 
 static int igb_get_ts_info(struct net_device *dev,
-			   struct ethtool_ts_info *info)
+			   struct kernel_ethtool_ts_info *info)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index f2c4f1966bb0..e58cabd6b538 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1559,7 +1559,7 @@ static int igc_ethtool_set_channels(struct net_device *netdev,
 }
 
 static int igc_ethtool_get_ts_info(struct net_device *dev,
-				   struct ethtool_ts_info *info)
+				   struct kernel_ethtool_ts_info *info)
 {
 	struct igc_adapter *adapter = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6e6e6f1847b6..4cac76254966 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3170,7 +3170,7 @@ static int ixgbe_set_rxfh(struct net_device *netdev,
 }
 
 static int ixgbe_get_ts_info(struct net_device *dev,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 19253a0fb4fe..29c9bba2b6ee 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5256,7 +5256,7 @@ static int mvpp2_get_ts_config(struct mvpp2_port *port, struct ifreq *ifr)
 }
 
 static int mvpp2_ethtool_get_ts_info(struct net_device *dev,
-				     struct ethtool_ts_info *info)
+				     struct kernel_ethtool_ts_info *info)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 7f786de61014..0db62eb0dab3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -954,7 +954,7 @@ static u32 otx2_get_link(struct net_device *netdev)
 }
 
 static int otx2_get_ts_info(struct net_device *netdev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 619e1c3ef7f9..0c906f3e06db 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1903,7 +1903,7 @@ static int mlx4_en_set_channels(struct net_device *dev,
 }
 
 static int mlx4_en_get_ts_info(struct net_device *dev,
-			       struct ethtool_ts_info *info)
+			       struct kernel_ethtool_ts_info *info)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index f8bd9dbf59cd..747644759b68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1206,7 +1206,7 @@ int mlx5e_set_per_queue_coalesce(struct net_device *dev, u32 queue,
 u32 mlx5e_ethtool_get_rxfh_key_size(struct mlx5e_priv *priv);
 u32 mlx5e_ethtool_get_rxfh_indir_size(struct mlx5e_priv *priv);
 int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
-			      struct ethtool_ts_info *info);
+			      struct kernel_ethtool_ts_info *info);
 int mlx5e_ethtool_flash_device(struct mlx5e_priv *priv,
 			       struct ethtool_flash *flash);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 1eb3a712930b..82af408563e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1658,7 +1658,7 @@ static int mlx5e_set_pauseparam(struct net_device *netdev,
 }
 
 int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 
@@ -1682,7 +1682,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
 }
 
 static int mlx5e_get_ts_info(struct net_device *dev,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 779d92b762d3..905bdbaffb9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -136,7 +136,7 @@ static int mlx5i_get_coalesce(struct net_device *netdev,
 }
 
 static int mlx5i_get_ts_info(struct net_device *netdev,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	struct mlx5e_priv *priv = mlx5i_epriv(netdev);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 3beb5d0847ab..aa9ce20b4ccb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -238,7 +238,7 @@ struct mlxsw_sp_ptp_ops {
 			    struct hwtstamp_config *config);
 	void (*shaper_work)(struct work_struct *work);
 	int (*get_ts_info)(struct mlxsw_sp *mlxsw_sp,
-			   struct ethtool_ts_info *info);
+			   struct kernel_ethtool_ts_info *info);
 	int (*get_stats_count)(void);
 	void (*get_stats_strings)(u8 **p);
 	void (*get_stats)(struct mlxsw_sp_port *mlxsw_sp_port,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index a755b0a901d3..837e52e611f3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -1068,7 +1068,7 @@ mlxsw_sp_get_module_eeprom_by_page(struct net_device *dev,
 }
 
 static int
-mlxsw_sp_get_ts_info(struct net_device *netdev, struct ethtool_ts_info *info)
+mlxsw_sp_get_ts_info(struct net_device *netdev, struct kernel_ethtool_ts_info *info)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(netdev);
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index cbb6c75a6620..5b174cb95eb8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -1276,7 +1276,7 @@ int mlxsw_sp1_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 }
 
 int mlxsw_sp1_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	info->phc_index = ptp_clock_index(mlxsw_sp->clock->ptp);
 
@@ -1661,7 +1661,7 @@ int mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 }
 
 int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	info->phc_index = ptp_clock_index(mlxsw_sp->clock->ptp);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
index a8b88230959a..769095d4932d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
@@ -11,7 +11,7 @@ struct mlxsw_sp;
 struct mlxsw_sp_port;
 struct mlxsw_sp_ptp_clock;
 
-static inline int mlxsw_sp_ptp_get_ts_info_noptp(struct ethtool_ts_info *info)
+static inline int mlxsw_sp_ptp_get_ts_info_noptp(struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
 				SOF_TIMESTAMPING_SOFTWARE;
@@ -50,7 +50,7 @@ int mlxsw_sp1_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 void mlxsw_sp1_ptp_shaper_work(struct work_struct *work);
 
 int mlxsw_sp1_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-			      struct ethtool_ts_info *info);
+			      struct kernel_ethtool_ts_info *info);
 
 int mlxsw_sp1_get_stats_count(void);
 void mlxsw_sp1_get_stats_strings(u8 **p);
@@ -84,7 +84,7 @@ int mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 			       struct hwtstamp_config *config);
 
 int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-			      struct ethtool_ts_info *info);
+			      struct kernel_ethtool_ts_info *info);
 
 int mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
 				  struct mlxsw_sp_port *mlxsw_sp_port,
@@ -152,7 +152,7 @@ static inline void mlxsw_sp1_ptp_shaper_work(struct work_struct *work)
 }
 
 static inline int mlxsw_sp1_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-					    struct ethtool_ts_info *info)
+					    struct kernel_ethtool_ts_info *info)
 {
 	return mlxsw_sp_ptp_get_ts_info_noptp(info);
 }
@@ -227,7 +227,7 @@ mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 }
 
 static inline int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-					    struct ethtool_ts_info *info)
+					    struct kernel_ethtool_ts_info *info)
 {
 	return mlxsw_sp_ptp_get_ts_info_noptp(info);
 }
diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index d0f4ff4ee075..bb8afb4fdc73 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1029,7 +1029,7 @@ static int lan743x_ethtool_set_rxfh(struct net_device *netdev,
 }
 
 static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
-				       struct ethtool_ts_info *ts_info)
+				       struct kernel_ethtool_ts_info *ts_info)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
index 06811c60d598..301576c66039 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
@@ -546,7 +546,7 @@ static int lan966x_set_pauseparam(struct net_device *dev,
 }
 
 static int lan966x_get_ts_info(struct net_device *dev,
-			       struct ethtool_ts_info *info)
+			       struct kernel_ethtool_ts_info *info)
 {
 	struct lan966x_port *port = netdev_priv(dev);
 	struct lan966x *lan966x = port->lan966x;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index a06dc5a9b355..4f800c1a435d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1183,7 +1183,7 @@ static void sparx5_config_port_stats(struct sparx5 *sparx5, int portno)
 }
 
 static int sparx5_get_ts_info(struct net_device *dev,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	struct sparx5_port *port = netdev_priv(dev);
 	struct sparx5 *sparx5 = port->sparx5;
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 21a87a3fc556..7c9540a71725 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -980,7 +980,7 @@ static int ocelot_port_get_sset_count(struct net_device *dev, int sset)
 }
 
 static int ocelot_port_get_ts_info(struct net_device *dev,
-				   struct ethtool_ts_info *info)
+				   struct kernel_ethtool_ts_info *info)
 {
 	struct ocelot_port_private *priv = netdev_priv(dev);
 	struct ocelot *ocelot = priv->port.ocelot;
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index cb32234a5bf1..b3c28260adf8 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -580,7 +580,7 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 EXPORT_SYMBOL(ocelot_hwstamp_set);
 
 int ocelot_get_ts_info(struct ocelot *ocelot, int port,
-		       struct ethtool_ts_info *info)
+		       struct kernel_ethtool_ts_info *info)
 {
 	info->phc_index = ocelot->ptp_clock ?
 			  ptp_clock_index(ocelot->ptp_clock) : -1;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 91183965a6b7..d98c4000e77e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -968,7 +968,7 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
 }
 
 static int ionic_get_ts_info(struct net_device *netdev,
-			     struct ethtool_ts_info *info)
+			     struct kernel_ethtool_ts_info *info)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 	struct ionic *ionic = lif->ionic;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index ae3ebf0cf999..b3b5f7b75177 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1137,7 +1137,7 @@ static int qede_set_channels(struct net_device *dev,
 }
 
 static int qede_get_ts_info(struct net_device *dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct qede_dev *edev = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.c b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
index 747cc5e2bb78..63e3dac4d5f7 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -321,7 +321,7 @@ int qede_ptp_hw_ts(struct qede_dev *edev, struct ifreq *ifr)
 			    sizeof(config)) ? -EFAULT : 0;
 }
 
-int qede_ptp_get_ts_info(struct qede_dev *edev, struct ethtool_ts_info *info)
+int qede_ptp_get_ts_info(struct qede_dev *edev, struct kernel_ethtool_ts_info *info)
 {
 	struct qede_ptp *ptp = edev->ptp;
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.h b/drivers/net/ethernet/qlogic/qede/qede_ptp.h
index 1db0f021c645..adafc894797e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.h
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.h
@@ -17,7 +17,7 @@ void qede_ptp_tx_ts(struct qede_dev *edev, struct sk_buff *skb);
 int qede_ptp_hw_ts(struct qede_dev *edev, struct ifreq *req);
 void qede_ptp_disable(struct qede_dev *edev);
 int qede_ptp_enable(struct qede_dev *edev);
-int qede_ptp_get_ts_info(struct qede_dev *edev, struct ethtool_ts_info *ts);
+int qede_ptp_get_ts_info(struct qede_dev *edev, struct kernel_ethtool_ts_info *ts);
 
 static inline void qede_ptp_record_rx_ts(struct qede_dev *edev,
 					 union eth_rx_cqe *cqe,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 384ddad65aaf..915c432f0ec0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1696,7 +1696,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
 }
 
 static int ravb_get_ts_info(struct net_device *ndev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index dcab638c57fe..7452efb58b6d 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1809,7 +1809,7 @@ static const struct net_device_ops rswitch_netdev_ops = {
 	.ndo_set_mac_address = eth_mac_addr,
 };
 
-static int rswitch_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info)
+static int rswitch_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *info)
 {
 	struct rswitch_device *rdev = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 37c69c8d90b1..8d5ecf1a9310 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -226,7 +226,7 @@ static void efx_ethtool_get_fec_stats(struct net_device *net_dev,
 }
 
 static int efx_ethtool_get_ts_info(struct net_device *net_dev,
-				   struct ethtool_ts_info *ts_info)
+				   struct kernel_ethtool_ts_info *ts_info)
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
 
diff --git a/drivers/net/ethernet/sfc/falcon/nic.h b/drivers/net/ethernet/sfc/falcon/nic.h
index 9f413474bd9f..ada6e036fd97 100644
--- a/drivers/net/ethernet/sfc/falcon/nic.h
+++ b/drivers/net/ethernet/sfc/falcon/nic.h
@@ -297,7 +297,7 @@ static inline struct falcon_board *falcon_board(struct ef4_nic *efx)
 	return &data->board;
 }
 
-struct ethtool_ts_info;
+struct kernel_ethtool_ts_info;
 
 extern const struct ef4_nic_type falcon_a1_nic_type;
 extern const struct ef4_nic_type falcon_b0_nic_type;
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index c3bffbf0ba2b..6fd2fdbaa418 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -1864,7 +1864,7 @@ static int efx_ptp_ts_init(struct efx_nic *efx, struct kernel_hwtstamp_config *i
 	return 0;
 }
 
-void efx_ptp_get_ts_info(struct efx_nic *efx, struct ethtool_ts_info *ts_info)
+void efx_ptp_get_ts_info(struct efx_nic *efx, struct kernel_ethtool_ts_info *ts_info)
 {
 	struct efx_ptp_data *ptp = efx->ptp_data;
 	struct efx_nic *primary = efx->primary;
diff --git a/drivers/net/ethernet/sfc/ptp.h b/drivers/net/ethernet/sfc/ptp.h
index 2f30dbb490d2..6946203499ef 100644
--- a/drivers/net/ethernet/sfc/ptp.h
+++ b/drivers/net/ethernet/sfc/ptp.h
@@ -12,7 +12,7 @@
 #include <linux/net_tstamp.h>
 #include "net_driver.h"
 
-struct ethtool_ts_info;
+struct kernel_ethtool_ts_info;
 int efx_ptp_probe(struct efx_nic *efx, struct efx_channel *channel);
 void efx_ptp_defer_probe_with_channel(struct efx_nic *efx);
 struct efx_channel *efx_ptp_channel(struct efx_nic *efx);
@@ -23,7 +23,8 @@ int efx_ptp_set_ts_config(struct efx_nic *efx,
 			  struct netlink_ext_ack *extack);
 int efx_ptp_get_ts_config(struct efx_nic *efx,
 			  struct kernel_hwtstamp_config *config);
-void efx_ptp_get_ts_info(struct efx_nic *efx, struct ethtool_ts_info *ts_info);
+void efx_ptp_get_ts_info(struct efx_nic *efx,
+			 struct kernel_ethtool_ts_info *ts_info);
 bool efx_ptp_is_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
 int efx_ptp_get_mode(struct efx_nic *efx);
 int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
index 14dd3893bdef..4c182d4edfc2 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool.c
@@ -226,7 +226,7 @@ static void efx_ethtool_get_fec_stats(struct net_device *net_dev,
 }
 
 static int efx_ethtool_get_ts_info(struct net_device *net_dev,
-				   struct ethtool_ts_info *ts_info)
+				   struct kernel_ethtool_ts_info *ts_info)
 {
 	struct efx_nic *efx = netdev_priv(net_dev);
 
diff --git a/drivers/net/ethernet/sfc/siena/ptp.c b/drivers/net/ethernet/sfc/siena/ptp.c
index 4b5e2f0ba350..c473a4b6dd44 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.c
+++ b/drivers/net/ethernet/sfc/siena/ptp.c
@@ -1780,7 +1780,7 @@ static int efx_ptp_ts_init(struct efx_nic *efx,
 }
 
 void efx_siena_ptp_get_ts_info(struct efx_nic *efx,
-			       struct ethtool_ts_info *ts_info)
+			       struct kernel_ethtool_ts_info *ts_info)
 {
 	struct efx_ptp_data *ptp = efx->ptp_data;
 	struct efx_nic *primary = efx->primary;
diff --git a/drivers/net/ethernet/sfc/siena/ptp.h b/drivers/net/ethernet/sfc/siena/ptp.h
index 6352f84424f6..b6133e7c5608 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.h
+++ b/drivers/net/ethernet/sfc/siena/ptp.h
@@ -12,7 +12,7 @@
 #include <linux/net_tstamp.h>
 #include "net_driver.h"
 
-struct ethtool_ts_info;
+struct kernel_ethtool_ts_info;
 void efx_siena_ptp_defer_probe_with_channel(struct efx_nic *efx);
 struct efx_channel *efx_siena_ptp_channel(struct efx_nic *efx);
 int efx_siena_ptp_set_ts_config(struct efx_nic *efx,
@@ -21,7 +21,7 @@ int efx_siena_ptp_set_ts_config(struct efx_nic *efx,
 int efx_siena_ptp_get_ts_config(struct efx_nic *efx,
 				struct kernel_hwtstamp_config *config);
 void efx_siena_ptp_get_ts_info(struct efx_nic *efx,
-			       struct ethtool_ts_info *ts_info);
+			       struct kernel_ethtool_ts_info *ts_info);
 bool efx_siena_ptp_is_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
 int efx_siena_ptp_get_mode(struct efx_nic *efx);
 int efx_siena_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 542e2633a6f5..8c92ca851a77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1199,7 +1199,7 @@ static int stmmac_set_channels(struct net_device *dev,
 }
 
 static int stmmac_get_ts_info(struct net_device *dev,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index a1d0935d1ebe..b60976947da5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -692,7 +692,7 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
 };
 
 static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
-					 struct ethtool_ts_info *info)
+					 struct kernel_ethtool_ts_info *info)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	unsigned int ptp_v2_filter;
diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index f7b283353ba2..53ed23d68722 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -717,7 +717,7 @@ int cpsw_set_ringparam(struct net_device *ndev,
 }
 
 #if IS_ENABLED(CONFIG_TI_CPTS)
-int cpsw_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info)
+int cpsw_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *info)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
 
@@ -738,7 +738,7 @@ int cpsw_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info)
 	return 0;
 }
 #else
-int cpsw_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info)
+int cpsw_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 7efa72502c86..1f448290b9f4 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -510,6 +510,6 @@ int cpsw_set_ringparam(struct net_device *ndev,
 int cpsw_set_channels_common(struct net_device *ndev,
 			     struct ethtool_channels *chs,
 			     cpdma_handler_fn rx_handler);
-int cpsw_get_ts_info(struct net_device *ndev, struct ethtool_ts_info *info);
+int cpsw_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *info);
 
 #endif /* DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_ */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index ca20325d4d3e..dd786e98e1fa 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -110,7 +110,7 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 }
 
 static int emac_get_ts_info(struct net_device *ndev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 02cb6474f6dc..d286709ca3b9 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -1999,7 +1999,7 @@ static int keystone_set_link_ksettings(struct net_device *ndev,
 
 #if IS_ENABLED(CONFIG_TI_CPTS)
 static int keystone_get_ts_info(struct net_device *ndev,
-				struct ethtool_ts_info *info)
+				struct kernel_ethtool_ts_info *info)
 {
 	struct netcp_intf *netcp = netdev_priv(ndev);
 	struct gbe_intf *gbe_intf;
@@ -2027,7 +2027,7 @@ static int keystone_get_ts_info(struct net_device *ndev,
 }
 #else
 static int keystone_get_ts_info(struct net_device *ndev,
-				struct ethtool_ts_info *info)
+				struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index e0d26148dfd9..4b09823e3713 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1015,7 +1015,7 @@ static void ixp4xx_get_drvinfo(struct net_device *dev,
 }
 
 static int ixp4xx_get_ts_info(struct net_device *dev,
-			      struct ethtool_ts_info *info)
+			      struct kernel_ethtool_ts_info *info)
 {
 	struct port *port = netdev_priv(dev);
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 0cec2783a3e7..3c625deaf4b7 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1084,7 +1084,7 @@ static int macvlan_ethtool_get_link_ksettings(struct net_device *dev,
 }
 
 static int macvlan_ethtool_get_ts_info(struct net_device *dev,
-				       struct ethtool_ts_info *info)
+				       struct kernel_ethtool_ts_info *info)
 {
 	struct net_device *real_dev = macvlan_dev_real_dev(dev);
 
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 3f9c9327f149..1436905bc106 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -148,7 +148,7 @@ nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
 }
 
 static int nsim_get_ts_info(struct net_device *dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index d3e825c951ee..874a1b64b115 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -841,7 +841,7 @@ static int bcm_ptp_hwtstamp(struct mii_timestamper *mii_ts,
 }
 
 static int bcm_ptp_ts_info(struct mii_timestamper *mii_ts,
-			   struct ethtool_ts_info *ts_info)
+			   struct kernel_ethtool_ts_info *ts_info)
 {
 	struct bcm_ptp_private *priv = mii2priv(mii_ts);
 
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index d3e72d5c1472..075d2beea716 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1395,7 +1395,7 @@ static void dp83640_txtstamp(struct mii_timestamper *mii_ts,
 }
 
 static int dp83640_ts_info(struct mii_timestamper *mii_ts,
-			   struct ethtool_ts_info *info)
+			   struct kernel_ethtool_ts_info *info)
 {
 	struct dp83640_private *dp83640 =
 		container_of(mii_ts, struct dp83640_private, mii_ts);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 5cac27fe90ef..4ee4e02254df 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2462,7 +2462,7 @@ static void lan8814_ptp_tx_ts_get(struct phy_device *phydev,
 	*seq_id = lanphy_read_page_reg(phydev, 5, PTP_TX_MSG_HEADER2);
 }
 
-static int lan8814_ts_info(struct mii_timestamper *mii_ts, struct ethtool_ts_info *info)
+static int lan8814_ts_info(struct mii_timestamper *mii_ts, struct kernel_ethtool_ts_info *info)
 {
 	struct kszphy_ptp_priv *ptp_priv = container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
 	struct phy_device *phydev = ptp_priv->phydev;
@@ -4219,7 +4219,7 @@ static irqreturn_t lan8841_handle_interrupt(struct phy_device *phydev)
 }
 
 static int lan8841_ts_info(struct mii_timestamper *mii_ts,
-			   struct ethtool_ts_info *info)
+			   struct kernel_ethtool_ts_info *info)
 {
 	struct kszphy_ptp_priv *ptp_priv;
 
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index e66d20eff7c4..c1ddae36a2ae 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1134,7 +1134,7 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 }
 
 static int vsc85xx_ts_info(struct mii_timestamper *mii_ts,
-			   struct ethtool_ts_info *info)
+			   struct kernel_ethtool_ts_info *info)
 {
 	struct vsc8531_private *vsc8531 =
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index d18c133e6013..5af5ade4fc64 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1058,7 +1058,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
 }
 
 static int nxp_c45_ts_info(struct mii_timestamper *mii_ts,
-			   struct ethtool_ts_info *ts_info)
+			   struct kernel_ethtool_ts_info *ts_info)
 {
 	struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
 						mii_ts);
diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index 385643f3f8fe..e6f7d2bf8dde 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -556,7 +556,7 @@ static bool ines_timestamp_expired(struct ines_timestamp *ts)
 }
 
 static int ines_ts_info(struct mii_timestamper *mii_ts,
-			struct ethtool_ts_info *info)
+			struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_HARDWARE |
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index c1caf7734c3e..f184c58ecf24 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -247,7 +247,7 @@ static int qeth_set_channels(struct net_device *dev,
 }
 
 static int qeth_get_ts_info(struct net_device *dev,
-			    struct ethtool_ts_info *info)
+			    struct kernel_ethtool_ts_info *info)
 {
 	struct qeth_card *card = dev->ml_priv;
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 1b92aed49363..23492213ea35 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -186,7 +186,7 @@ void close_candev(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
 int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
 int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
-				    struct ethtool_ts_info *info);
+				    struct kernel_ethtool_ts_info *info);
 
 int register_candev(struct net_device *dev);
 void unregister_candev(struct net_device *dev);
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc0..d92e2cd13b81 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/netlink.h>
 #include <uapi/linux/ethtool.h>
+#include <uapi/linux/net_tstamp.h>
 
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
@@ -661,6 +662,22 @@ struct ethtool_rxfh_param {
 	u8	input_xfrm;
 };
 
+/**
+ * struct kernel_ethtool_ts_info - kernel copy of struct ethtool_ts_info
+ * @cmd: command number = %ETHTOOL_GET_TS_INFO
+ * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
+ * @phc_index: device index of the associated PHC, or -1 if there is none
+ * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
+ * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
+ */
+struct kernel_ethtool_ts_info {
+	u32 cmd;
+	u32 so_timestamping;
+	int phc_index;
+	enum hwtstamp_tx_types tx_types;
+	enum hwtstamp_rx_filters rx_filters;
+};
+
 /**
  * struct ethtool_ops - optional netdev operations
  * @cap_link_lanes_supported: indicates if the driver supports lanes
@@ -920,7 +937,7 @@ struct ethtool_ops {
 	int	(*get_dump_data)(struct net_device *,
 				 struct ethtool_dump *, void *);
 	int	(*set_dump)(struct net_device *, struct ethtool_dump *);
-	int	(*get_ts_info)(struct net_device *, struct ethtool_ts_info *);
+	int	(*get_ts_info)(struct net_device *, struct kernel_ethtool_ts_info *);
 	void	(*get_ts_stats)(struct net_device *dev,
 				struct ethtool_ts_stats *ts_stats);
 	int     (*get_module_info)(struct net_device *,
@@ -1063,7 +1080,8 @@ int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index);
 
 /* Some generic methods drivers may use in their ethtool_ops */
 u32 ethtool_op_get_link(struct net_device *dev);
-int ethtool_op_get_ts_info(struct net_device *dev, struct ethtool_ts_info *eti);
+int ethtool_op_get_ts_info(struct net_device *dev,
+			   struct kernel_ethtool_ts_info *eti);
 
 /**
  * ethtool_mm_frag_size_add_to_min - Translate (standard) additional fragment
@@ -1112,7 +1130,8 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
  * @info: buffer to hold the result
  * Returns zero on success, non-zero otherwise.
  */
-int ethtool_get_ts_info_by_layer(struct net_device *dev, struct ethtool_ts_info *info);
+int ethtool_get_ts_info_by_layer(struct net_device *dev,
+				 struct kernel_ethtool_ts_info *info);
 
 /**
  * ethtool_sprintf - Write formatted string to ethtool string data
diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestamper.h
index 26b04f73f214..995db62570f9 100644
--- a/include/linux/mii_timestamper.h
+++ b/include/linux/mii_timestamper.h
@@ -59,7 +59,7 @@ struct mii_timestamper {
 			   struct phy_device *phydev);
 
 	int  (*ts_info)(struct mii_timestamper *mii_ts,
-			struct ethtool_ts_info *ts_info);
+			struct kernel_ethtool_ts_info *ts_info);
 
 	struct device *device;
 };
diff --git a/include/linux/phy.h b/include/linux/phy.h
index f8a3709c4dea..d3f3c751cc2d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1618,7 +1618,7 @@ static inline bool phy_rxtstamp(struct phy_device *phydev, struct sk_buff *skb,
 }
 
 static inline int phy_ts_info(struct phy_device *phydev,
-			      struct ethtool_ts_info *tsinfo)
+			      struct kernel_ethtool_ts_info *tsinfo)
 {
 	return phydev->mii_ts->ts_info(phydev->mii_ts, tsinfo);
 }
diff --git a/include/net/dsa.h b/include/net/dsa.h
index a6ef7e4c503f..46fa85d95657 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -942,7 +942,7 @@ struct dsa_switch_ops {
 	 * ethtool timestamp info
 	 */
 	int	(*get_ts_info)(struct dsa_switch *ds, int port,
-			       struct ethtool_ts_info *ts);
+			       struct kernel_ethtool_ts_info *ts);
 
 	/*
 	 * ethtool MAC merge layer
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 1e1b40f4e664..6a37b29f4b4c 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -1016,7 +1016,7 @@ void ocelot_port_get_eth_mac_stats(struct ocelot *ocelot, int port,
 void ocelot_port_get_eth_phy_stats(struct ocelot *ocelot, int port,
 				   struct ethtool_eth_phy_stats *phy_stats);
 int ocelot_get_ts_info(struct ocelot *ocelot, int port,
-		       struct ethtool_ts_info *info);
+		       struct kernel_ethtool_ts_info *info);
 void ocelot_set_ageing_time(struct ocelot *ocelot, unsigned int msecs);
 int ocelot_port_vlan_filtering(struct ocelot *ocelot, int port, bool enabled,
 			       struct netlink_ext_ack *extack);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 39876eff51d2..aa8559200446 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -677,7 +677,7 @@ static void vlan_ethtool_get_drvinfo(struct net_device *dev,
 }
 
 static int vlan_ethtool_get_ts_info(struct net_device *dev,
-				    struct ethtool_ts_info *info)
+				    struct kernel_ethtool_ts_info *info)
 {
 	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	return ethtool_get_ts_info_by_layer(vlan->real_dev, info);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index c94b868855aa..6b98ef0d6d6c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1726,7 +1726,7 @@ static int dsa_user_set_rxnfc(struct net_device *dev,
 }
 
 static int dsa_user_get_ts_info(struct net_device *dev,
-				struct ethtool_ts_info *ts)
+				struct kernel_ethtool_ts_info *ts)
 {
 	struct dsa_user_priv *p = netdev_priv(dev);
 	struct dsa_switch *ds = p->dp->ds;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 01b7550f12c6..461017a37955 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -629,7 +629,7 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
 	return 0;
 }
 
-int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
+int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
@@ -651,7 +651,7 @@ int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 
 int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index)
 {
-	struct ethtool_ts_info info = { };
+	struct kernel_ethtool_ts_info info = { };
 	int num = 0;
 
 	if (!__ethtool_get_ts_info(dev, &info))
@@ -661,7 +661,7 @@ int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index)
 }
 EXPORT_SYMBOL(ethtool_get_phc_vclocks);
 
-int ethtool_get_ts_info_by_layer(struct net_device *dev, struct ethtool_ts_info *info)
+int ethtool_get_ts_info_by_layer(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 {
 	return __ethtool_get_ts_info(dev, info);
 }
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 28b8aaaf9bcb..b9daeecbd84d 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -44,7 +44,7 @@ bool convert_legacy_settings_to_link_ksettings(
 	const struct ethtool_cmd *legacy_settings);
 int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max);
 int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max);
-int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
+int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 
 extern const struct ethtool_phy_ops *ethtool_phy_ops;
 extern const struct ethtool_pse_ops *ethtool_pse_ops;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5a55270aa86e..a8351373f4ad 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -65,7 +65,8 @@ u32 ethtool_op_get_link(struct net_device *dev)
 }
 EXPORT_SYMBOL(ethtool_op_get_link);
 
-int ethtool_op_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
+int ethtool_op_get_ts_info(struct net_device *dev,
+			   struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
@@ -2443,13 +2444,20 @@ static int ethtool_get_dump_data(struct net_device *dev,
 
 static int ethtool_get_ts_info(struct net_device *dev, void __user *useraddr)
 {
+	struct kernel_ethtool_ts_info kernel_info;
 	struct ethtool_ts_info info;
 	int err;
 
-	err = __ethtool_get_ts_info(dev, &info);
+	err = __ethtool_get_ts_info(dev, &kernel_info);
 	if (err)
 		return err;
 
+	info.cmd = kernel_info.cmd;
+	info.so_timestamping = kernel_info.so_timestamping;
+	info.phc_index = kernel_info.phc_index;
+	info.tx_types = kernel_info.tx_types;
+	info.rx_filters = kernel_info.rx_filters;
+
 	if (copy_to_user(useraddr, &info, sizeof(info)))
 		return -EFAULT;
 
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index be2755c8d8fd..88e59ca8d4c0 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -12,7 +12,7 @@ struct tsinfo_req_info {
 
 struct tsinfo_reply_data {
 	struct ethnl_reply_data		base;
-	struct ethtool_ts_info		ts_info;
+	struct kernel_ethtool_ts_info	ts_info;
 	struct ethtool_ts_stats		stats;
 };
 
@@ -55,7 +55,7 @@ static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 {
 	const struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
-	const struct ethtool_ts_info *ts_info = &data->ts_info;
+	const struct kernel_ethtool_ts_info *ts_info = &data->ts_info;
 	int len = 0;
 	int ret;
 
@@ -136,7 +136,7 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
 {
 	const struct tsinfo_reply_data *data = TSINFO_REPDATA(reply_base);
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
-	const struct ethtool_ts_info *ts_info = &data->ts_info;
+	const struct kernel_ethtool_ts_info *ts_info = &data->ts_info;
 	int ret;
 
 	if (ts_info->so_timestamping) {
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1ab17e8a7260..e6047c32b1ce 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1613,7 +1613,7 @@ static int taprio_parse_clockid(struct Qdisc *sch, struct nlattr **tb,
 
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
 		const struct ethtool_ops *ops = dev->ethtool_ops;
-		struct ethtool_ts_info info = {
+		struct kernel_ethtool_ts_info info = {
 			.cmd = ETHTOOL_GET_TS_INFO,
 			.phc_index = -1,
 		};

-- 
2.34.1


