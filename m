Return-Path: <linux-kernel+bounces-153374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B38ACD58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83F7281E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB814F133;
	Mon, 22 Apr 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dcIjrTZQ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A614A09B;
	Mon, 22 Apr 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790244; cv=none; b=rRO8SGs1D167hBMJxuU8E9/l1Bilbxrv6pbJOn4JrShwA2wxt+3S5zzvtbbw5NYOYJGZbjiYuf3Sq2vCVU16k1Iu/zntgcjvLq9lpiBGu5cFybMqgFanbuemuLoV7IkDjoQqFje6KnYz9SVa8G2dpPcRC32nLlxmYANLcAhdPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790244; c=relaxed/simple;
	bh=eseBCskPSg4WVGvkmioam0sVYMVGwxL8LYH8PMHq564=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EljmJoD2uzztCgg1KC8pv3q2Iu/Z44yaRLOszpGn2tLuUYrIhEwqefalDhgQkLEE56pDFQPRK22U53FJmIhQIZXPnOEZdqiSSZpPDC8Yk5TuxdbvrY4buA4vfT6t5l47BJDWOrZ5VSum1j6X5GaANNUmGugLHUC8vp+5mE2fQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dcIjrTZQ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B44B1E000D;
	Mon, 22 Apr 2024 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GW1EUhkixGoA3ieTWA1LS3MlMuOIAnpKPeBtTAyhr4w=;
	b=dcIjrTZQ/dTaOInRTeiePpl7J17mhE7Tp2i/6FkmFbKR95Pc5Dd9PTQXYCYIh9GSTVGz9c
	LedcqQSpYacW903ZsxBV3vB5WBJ3BTQc3zjfQeT1vp+wJ41smLCaZJ8keRCbubgFciKhLO
	uqLnf6ZNvHtG/I/WI/YpKMmLBIl8sf7v6WFZiDirAD9fiA/MXTscpbajxX+ef7TbvF9cOO
	xv9+Num8QC1n7Qna3Fr1D3A/TnWIFwPlXMsD57itJfslbnS43CBfIuH9SE0lOlh+U0DmGQ
	jgDzsgm9/iRwoR+44mb2x9gwybp/bLqCBdfn9/30CvYW9LJFCTn65hL813agHw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v11 00/13] net: Make timestamping selectable
Date: Mon, 22 Apr 2024 14:50:15 +0200
Message-Id: <20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAddJmYC/3XQzU7DMAwA4FeZcibIzpwm2Yn3QGhKi8MiQVOlo
 Rqa+u5kFWigdkf/fbZ8ESPnyKM47C4i8xTHmPoaID7sRHfy/RvL+FoTQoHaIyDKwL58Zj4OZTj
 2XHo+F7kPylhtLFtqRZ0cMod4XthnUZvktUu81MopjiXlr2Xf1Cz1H9ltylMjQRr0IXTKtMD6q
 U2pvMf+sUsfiziZm4JI24qpChnFxjiNTLBW7K9CoLDZVmxVNEIgFYgotGvF/VHUHcVdb9G6QdT
 kgsK1gnBjCO48BqE6ELxirzvrvPvvzPP8DTGePsTdAQAA
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
 Willem de Bruijn <willemb@google.com>, 
 Alexandra Winter <wintera@linux.ibm.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Up until now, there was no way to let the user select the hardware
PTP provider at which time stamping occurs. The stack assumed that PHY time
stamping is always preferred, but some MAC/PHY combinations were buggy.

This series updates the default MAC/PHY default timestamping and aims to
allow the user to select the desired hwtstamp provider administratively.

Changes in v11:
- Add netlink examples.
- Remove a change of my out of tree marvell_ptp patch in the patch series.
- Remove useless extern.
- Link to v10: https://lore.kernel.org/r/20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com

Changes in v10:
- Move declarations to net/core/dev.h instead of netdevice.h
- Add netlink documentation.
- Add ETHTOOL_A_TSINFO_GHWTSTAMP netlink attributes instead of a bit in
  ETHTOOL_A_TSINFO_TIMESTAMPING bitset.
- Send "Move from simple ida to xarray" patch standalone.
- Add tsinfo ntf command.
- Add rcu_lock protection mechanism to avoid memory leak.
- Fixed doc and kdoc issue.
- Link to v9: https://lore.kernel.org/r/20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com

Changes in v9:
- Remove the RFC prefix.
- Correct few NIT fixes.
- Link to v8: https://lore.kernel.org/r/20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com

Changes in v8:
- Drop the 6 first patch as they are now merged.
- Change the full implementation to not be based on the hwtstamp layer
  (MAC/PHY) but on the hwtstamp provider which mean a ptp clock and a
  phc qualifier.
- Made some patch to prepare the new implementation.
- Expand netlink tsinfo instead of a new ts command for new hwtstamp
  configuration uAPI and for dumping tsinfo of specific hwtstamp provider.
- Link to v7: https://lore.kernel.org/r/20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com

Changes in v7:
- Fix a temporary build error.
- Link to v6: https://lore.kernel.org/r/20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com

Changes in v6:
- Few fixes from the reviews.
- Replace the allowlist to default_timestamp flag to know which phy is
  using old API behavior.
- Rename the timestamping layer enum values.
- Move to a simple enum instead of the mix between enum and bitfield.
- Update ts_info and ts-set in software timestamping case.

Changes in v5:
- Update to ndo_hwstamp_get/set. This bring several new patches.
- Add few patches to make the glue.
- Convert macb to ndo_hwstamp_get/set.
- Add netlink specs description of new ethtool commands.
- Removed netdev notifier.
- Split the patches that expose the timestamping to userspace to separate
  the core and ethtool development.
- Add description of software timestamping.
- Convert PHYs hwtstamp callback to use kernel_hwtstamp_config.

Changes in v4:
- Move on to ethtool netlink instead of ioctl.
- Add a netdev notifier to allow packet trapping by the MAC in case of PHY
  time stamping.
- Add a PHY whitelist to not break the old PHY default time-stamping
  preference API.

Changes in v3:
- Expose the PTP choice to ethtool instead of sysfs.
  You can test it with the ethtool source on branch feature_ptp of:
  https://github.com/kmaincent/ethtool
- Added a devicetree binding to select the preferred timestamp.

Changes in v2:
- Move selected_timestamping_layer variable of the concerned patch.
- Use sysfs_streq instead of strmcmp.
- Use the PHY timestamp only if available.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (13):
      net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
      net: Move dev_set_hwtstamp_phylib to net/core/dev.h
      net: Make dev_get_hwtstamp_phylib accessible
      net: Make net_hwtstamp_validate accessible
      net: Change the API of PHY default timestamp to MAC
      net: net_tstamp: Add unspec field to hwtstamp_source enumeration
      net: Add struct kernel_ethtool_ts_info
      ptp: Add phc source and helpers to register specific PTP clock or get information
      net: Add the possibility to support a selected hwtstamp in netdevice
      net: netdevsim: ptp_mock: Convert to netdev_ptp_clock_register
      net: macb: Convert to netdev_ptp_clock_register
      net: ethtool: tsinfo: Add support for hwtstamp provider and get/set hwtstamp config
      netlink: specs: tsinfo: Enhance netlink attributes and add a set command

 Documentation/netlink/specs/ethtool.yaml           |  43 +-
 Documentation/networking/ethtool-netlink.rst       |  38 +-
 Documentation/networking/timestamping.rst          |  35 +-
 drivers/net/bonding/bond_main.c                    |   4 +-
 drivers/net/can/dev/dev.c                          |   2 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |   2 +-
 drivers/net/can/usb/gs_usb.c                       |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |   2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c    |   2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h    |   2 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |   2 +-
 drivers/net/dsa/microchip/ksz_ptp.h                |   2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c               |   2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h               |   4 +-
 drivers/net/dsa/ocelot/felix.c                     |   2 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |   2 +-
 drivers/net/dsa/sja1105/sja1105_ptp.h              |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |   2 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   2 +-
 drivers/net/ethernet/cadence/macb.h                |   2 +-
 drivers/net/ethernet/cadence/macb_main.c           |   4 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |   2 +-
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |   2 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |   2 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |   2 +-
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |   2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |   2 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   2 +-
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |   2 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h |   2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |   4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h |  10 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |   2 +-
 .../ethernet/microchip/lan966x/lan966x_ethtool.c   |   2 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   2 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |   2 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             |   2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.h        |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 drivers/net/ethernet/renesas/rswitch.c             |   2 +-
 drivers/net/ethernet/sfc/ethtool.c                 |   2 +-
 drivers/net/ethernet/sfc/falcon/nic.h              |   2 +-
 drivers/net/ethernet/sfc/ptp.c                     |   2 +-
 drivers/net/ethernet/sfc/ptp.h                     |   5 +-
 drivers/net/ethernet/sfc/siena/ethtool.c           |   2 +-
 drivers/net/ethernet/sfc/siena/ptp.c               |   2 +-
 drivers/net/ethernet/sfc/siena/ptp.h               |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |   2 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |   4 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |   2 +-
 drivers/net/ethernet/ti/netcp_ethss.c              |   4 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |   2 +-
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/netdevsim/ethtool.c                    |   2 +-
 drivers/net/netdevsim/netdev.c                     |  19 +-
 drivers/net/phy/bcm-phy-ptp.c                      |   5 +-
 drivers/net/phy/dp83640.c                          |   4 +-
 drivers/net/phy/micrel.c                           |  10 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |   5 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |   5 +-
 drivers/net/phy/phy_device.c                       |  11 +
 drivers/ptp/ptp_clock.c                            | 182 ++++++
 drivers/ptp/ptp_ines.c                             |   2 +-
 drivers/ptp/ptp_mock.c                             |   4 +-
 drivers/ptp/ptp_private.h                          |   5 +
 drivers/s390/net/qeth_ethtool.c                    |   2 +-
 include/linux/can/dev.h                            |   2 +-
 include/linux/ethtool.h                            |  29 +-
 include/linux/mii_timestamper.h                    |   2 +-
 include/linux/net_tstamp.h                         |  16 +
 include/linux/netdevice.h                          |   8 +-
 include/linux/phy.h                                |  19 +-
 include/linux/ptp_clock_kernel.h                   | 151 +++++
 include/linux/ptp_mock.h                           |   4 +-
 include/net/dsa.h                                  |   2 +-
 include/soc/mscc/ocelot.h                          |   2 +-
 include/uapi/linux/ethtool_netlink.h               |  14 +
 include/uapi/linux/net_tstamp.h                    |  11 +
 net/8021q/vlan_dev.c                               |   2 +-
 net/core/dev.h                                     |   7 +
 net/core/dev_ioctl.c                               |  56 +-
 net/core/timestamping.c                            |  49 +-
 net/dsa/user.c                                     |   2 +-
 net/ethtool/common.c                               |  40 +-
 net/ethtool/common.h                               |   5 +-
 net/ethtool/ioctl.c                                |  12 +-
 net/ethtool/netlink.c                              |  16 +-
 net/ethtool/netlink.h                              |   6 +-
 net/ethtool/tsinfo.c                               | 641 ++++++++++++++++++++-
 net/sched/sch_taprio.c                             |   2 +-
 120 files changed, 1462 insertions(+), 195 deletions(-)
---
base-commit: c4567f2b476f9fc2816f619b4a78ec656a92f2a5
change-id: 20231011-feature_ptp_netnext-3f278578e84b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


