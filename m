Return-Path: <linux-kernel+bounces-164306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828A8B7C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877911C22999
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5474172BD6;
	Tue, 30 Apr 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZhpLS3+K"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424E173359;
	Tue, 30 Apr 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492235; cv=none; b=KXE+KPbUK7bbe18KBckPKzw4nygeMblQSVDZS6l1gFAf6DQSDYHxDLPjYqDLdA3jCOvxhdZQT2nuFfAlK3ANyvcg0dSmZ8hCIVuPiMqqptNoWUMv+yOfMY8EZmY6V7a7CAxlwipkS3e5YDooHBgTbQ4sbQp6QLwO61dsPbed4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492235; c=relaxed/simple;
	bh=CYlE9etSVdcPZZiswBmnUEJRs1PTWVMSW3CppztUTrc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UPvN/u/nDgIxQ2wQLBcsVtn+ov7uG7sWUalmELTaLfgHuDQV9cdnJ7TV8AbxtXaY+QfFVW5cPlwML+fOcJ5/7o7evnyiQ2GlngMHdK/kRUUs0Nxt+aqPrABDFfEVPao6/ZluRDneI7qsZ9HlEpToa+rB8K3CGMV0OW6HlgZzTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZhpLS3+K; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B175820011;
	Tue, 30 Apr 2024 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714492224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VfIW/jKsdvyCZTWdnoPtr1zzEzu8egn0shli0o6pAo4=;
	b=ZhpLS3+KcKVlb+8/ZyIuYujHx4+TxaPeVfmHZ6crh4gCgNUyp9Ln1Oc1X0eeBTEDWxJJ4E
	d9dzYkWeCITgDSBB6rZ3UcjGSVreJe7RhEuGFFUwHG5CgUotgQ7AyHTT4/TKrx2j6pe7lA
	5FyoU54L4blK8RbGVE1fmW8vwiASH098X39v9sjL98PQsxIEuq22Pcb41y2KUrRchehi/i
	nN3M3NZcJeG/vvqnrjuDVqTI2lBe1eUQI4XdbTzI/CRLWBpndOkUhnPKsJ7o0+B7Nw5vEF
	MmdNe/3+ZnpdNBRKn+BDEtdvczxRNWeHuFsU4WXaTodaK2LMxroqerqEEPLexA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v12 00/13] net: Make timestamping selectable
Date: Tue, 30 Apr 2024 17:49:43 +0200
Message-Id: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABcTMWYC/3XQzW7DIAwA4FepOI8JuxCgp73HNFUktVekLUQJi
 zpVeffRaFM7JTnin882VzFQH2kQh91V9DTGIaa2PACfdqI5h/adZDyVgECFe1AAkinkr56OXe6
 OLeWWLlnuGa0z1pHTtSidXU8cLzP7KkqRvFWJt5I5xyGn/nueN1Zz/lf2q/JYSSUtBOYGba3Iv
 NQp5Y/YPjfpcxZHe1cA9Lpii6ItkrXeAGm1VNyfohVCta64ohhQrJG11lwvFf+g4Ibib7sYUwE
 Y7RlhqYC6M1ptfAyo4igOSME0zge/4sCDg7jhQHEYykHAGODk/jvTNP0A42sKLSUCAAA=
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

Changes in v12:
- Add missing return description in the kdoc.
- Fix few nit.
- Link to v11: https://lore.kernel.org/r/20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com

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
 include/linux/phy.h                                |  21 +-
 include/linux/ptp_clock_kernel.h                   | 173 ++++++
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
 120 files changed, 1486 insertions(+), 195 deletions(-)
---
base-commit: 7aebfd87dbb54671dd4614df8c34c1c37e8495cf
change-id: 20231011-feature_ptp_netnext-3f278578e84b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


