Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623937BE564
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377079AbjJIPvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377063AbjJIPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:51:48 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C525D6;
        Mon,  9 Oct 2023 08:51:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55EF11C0003;
        Mon,  9 Oct 2023 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696866705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d+vplipnnIWIzmNSzthBNOqx4T8NoqkpkC2gykdesK8=;
        b=FNpZC8N6MIxp3OfN4IJMd1lHXfjnF2RXmlnDiH3Lx6GEdspNWJYG84yxHvA4GBA+AHeyOF
        kaU+5AM3NDtGR1Ew+fpdjwD7Vhtp5bv+ZrDNk7PcHAXR8cxdYRyaVac4llbF4BsOgPf9dA
        Lukykm3s1ERmcXdIff/lBjWYXtLSUH6cU0trifpPLlqOAXcOe6/y+x+UO4lyOaY5S7SmNV
        cD3VX09c3pmNC2zdX0PVBAeiu7HmGZU/1S3gZ6XGsLC/daCTLoVrOCD++KuI4oJxtiCIeD
        IV7GhOJ4aovV1tjG70sSYLaANw8hJOrHJMN0kAAXlzopIeiyZ7A77uqp1bl2EQ==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 00/16] net: Make timestamping selectable
Date:   Mon,  9 Oct 2023 17:51:22 +0200
Message-Id: <20231009155138.86458-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

Up until now, there was no way to let the user select the layer at
which time stamping occurs. The stack assumed that PHY time stamping
is always preferred, but some MAC/PHY combinations were buggy.

This series updates the default MAC/PHY default timestamping and aims to
allow the user to select the desired layer administratively.

Changes in v2:
- Move selected_timestamping_layer variable of the concerned patch.
- Use sysfs_streq instead of strmcmp.
- Use the PHY timestamp only if available.

Changes in v3:
- Expose the PTP choice to ethtool instead of sysfs.
  You can test it with the ethtool source on branch feature_ptp of:
  https://github.com/kmaincent/ethtool
- Added a devicetree binding to select the preferred timestamp.

Changes in v4:
- Move on to ethtool netlink instead of ioctl.
- Add a netdev notifier to allow packet trapping by the MAC in case of PHY
  time stamping.
- Add a PHY whitelist to not break the old PHY default time-stamping
  preference API.

Change in v5:
- Update to ndo_hwstamp_get/set. This bring several new patches.
- Add few patches to make the glue.
- Convert macb to ndo_hwstamp_get/set.
- Add netlink specs description of new ethtool commands.
- Removed netdev notifier.
- Split the patches that expose the timestamping to userspace to separate
  the core and ethtool development.
- Add description of software timestamping.
- Convert PHYs hwtstamp callback to use kernel_hwtstamp_config.

Kory Maincent (15):
  net: Convert PHYs hwtstamp callback to use kernel_hwtstamp_config
  net: phy: Remove the call to phy_mii_ioctl in phy_hwstamp_get/set
  net: macb: Convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  net: Make dev_set_hwtstamp_phylib accessible
  net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
  net: phy: micrel: fix ts_info value in case of no phc
  net: ethtool: Add a command to expose current time stamping layer
  netlink: specs: Introduce new netlink command to get current timestamp
  net: ethtool: Add a command to list available time stamping layers
  netlink: specs: Introduce new netlink command to list available time
    stamping layers
  net: Replace hwtstamp_source by timestamping layer
  net: Change the API of PHY default timestamp to MAC
  net: ethtool: ts: Update GET_TS to reply the current selected
    timestamp
  net ethtool: net: Let the active time stamping layer be selectable
  netlink: specs: Introduce time stamping set command

Richard Cochran (1):
  net: ethtool: Refactor identical get_ts_info implementations.

 Documentation/netlink/specs/ethtool.yaml      |  57 +++++
 Documentation/networking/ethtool-netlink.rst  |  63 ++++++
 drivers/net/bonding/bond_main.c               |  27 +--
 drivers/net/ethernet/cadence/macb.h           |  15 +-
 drivers/net/ethernet/cadence/macb_main.c      |  42 +++-
 drivers/net/ethernet/cadence/macb_ptp.c       |  28 +--
 .../ethernet/microchip/lan966x/lan966x_main.c |   6 +-
 drivers/net/macvlan.c                         |  14 +-
 drivers/net/phy/bcm-phy-ptp.c                 |  15 +-
 drivers/net/phy/dp83640.c                     |  24 +-
 drivers/net/phy/micrel.c                      |  44 ++--
 drivers/net/phy/mscc/mscc_ptp.c               |  18 +-
 drivers/net/phy/nxp-c45-tja11xx.c             |  17 +-
 drivers/net/phy/phy.c                         |  28 ++-
 drivers/net/phy/phy_device.c                  |  68 ++++++
 drivers/ptp/ptp_ines.c                        |  16 +-
 include/linux/ethtool.h                       |   8 +
 include/linux/mii_timestamper.h               |   4 +-
 include/linux/net_tstamp.h                    |  11 +-
 include/linux/netdevice.h                     |   8 +
 include/linux/phy.h                           |   6 +-
 include/uapi/linux/ethtool_netlink.h          |  29 +++
 include/uapi/linux/net_tstamp.h               |  22 ++
 net/8021q/vlan_dev.c                          |  15 +-
 net/core/dev.c                                |   3 +
 net/core/dev_ioctl.c                          |  42 ++--
 net/core/timestamping.c                       |   9 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/common.c                          |  22 +-
 net/ethtool/common.h                          |   1 +
 net/ethtool/netlink.c                         |  28 +++
 net/ethtool/netlink.h                         |   4 +
 net/ethtool/ts.c                              | 210 ++++++++++++++++++
 33 files changed, 707 insertions(+), 199 deletions(-)
 create mode 100644 net/ethtool/ts.c

-- 
2.25.1

