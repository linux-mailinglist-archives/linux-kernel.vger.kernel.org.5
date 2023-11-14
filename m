Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0EC7EAF01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjKNL3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjKNL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:07 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FFD44;
        Tue, 14 Nov 2023 03:28:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11CDC6000C;
        Tue, 14 Nov 2023 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BdKRTtgMkXn0lTN7kUysrsahlaVG/E8SJ2GDly5Qt98=;
        b=MOzcmmQE9gE7m48o10LS1WziTWo3ZtJkhcizoiAi3/kkupkQEFdqzImphCM+b8ekp7a3Kp
        tRxbJEQ0s8zo/gBUHWfHwsADjqtTog+KyWby2jsGYJDKuIpalekU7UJ/L9jM/1WYMf1mhb
        DkQ8o8D07PmeFJPPXpSKB7NppHUY34vBbUM+OJFTXM8Z662JfbndUWc4rj0Be0LDsTqt/p
        rWPpYkJTDcuPRgf+Tk7KG85J6w2j5pMlO9S7jeSoLsW6k6uApyCX8vXhC8BwUcG4EfnGYa
        KKMRYnS3/jJge1UoyAXljr2utMoYADjpv5zwowrzQdm3clo1QIiRSJGv9acj/w==
From:   Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v7 00/16] net: Make timestamping selectable
Date:   Tue, 14 Nov 2023 12:28:28 +0100
Message-Id: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANxZU2UC/22NQQ6CMBREr0L+2pq2CEVW3sMQQvFXfqItaSvBE
 O5ubVy6nLyZNxsE9IQB2mIDjwsFcjYFdShgnAZ7R0a3lEFyWQouBDM4xJfHfo5zbzFaXCMrjVR
 NpRpsThrScvZoaM3WK6QS+7agS2SiEJ1/57ulzvxnPv81LzXjTInBmFEqzbG6aOfig+xxdE/o9
 n3/AIMlbz7CAAAA
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
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes in v6:
- Few fixes from the reviews.
- Replace the allowlist to default_timestamp flag to know which phy is
  using old API behavior.
- Rename the timestamping layer enum values.
- Move to a simple enum instead of the mix between enum and bitfield.
- Update ts_info and ts-set in software timestamping case.

Changes in v7:
- Fix a temporary build error.
- Link to v6: https://lore.kernel.org/r/20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (15):
      net: Convert PHYs hwtstamp callback to use kernel_hwtstamp_config
      net: phy: Remove the call to phy_mii_ioctl in phy_hwstamp_get/set
      net: macb: Convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      net: Make dev_set_hwtstamp_phylib accessible
      net: phy: micrel: fix ts_info value in case of no phc
      net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
      net: ethtool: Add a command to expose current time stamping layer
      netlink: specs: Introduce new netlink command to get current timestamp
      net: ethtool: Add a command to list available time stamping layers
      netlink: specs: Introduce new netlink command to list available time stamping layers
      net: Replace hwtstamp_source by timestamping layer
      net: Change the API of PHY default timestamp to MAC
      net: ethtool: ts: Update GET_TS to reply the current selected timestamp
      net: ethtool: ts: Let the active time stamping layer be selectable
      netlink: specs: Introduce time stamping set command

Richard Cochran (1):
      net: ethtool: Refactor identical get_ts_info implementations.

 Documentation/netlink/specs/ethtool.yaml           |  57 +++++
 Documentation/networking/ethtool-netlink.rst       |  63 ++++++
 drivers/net/bonding/bond_main.c                    |  29 +--
 drivers/net/ethernet/cadence/macb.h                |  15 +-
 drivers/net/ethernet/cadence/macb_main.c           |  42 +++-
 drivers/net/ethernet/cadence/macb_ptp.c            |  28 +--
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |   6 +-
 drivers/net/macvlan.c                              |  14 +-
 drivers/net/phy/bcm-phy-ptp.c                      |  18 +-
 drivers/net/phy/dp83640.c                          |  27 +--
 drivers/net/phy/micrel.c                           |  50 ++---
 drivers/net/phy/mscc/mscc_ptp.c                    |  20 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |  20 +-
 drivers/net/phy/phy.c                              |  28 ++-
 drivers/net/phy/phy_device.c                       |  37 ++++
 drivers/ptp/ptp_ines.c                             |  16 +-
 include/linux/ethtool.h                            |   8 +
 include/linux/mii_timestamper.h                    |   4 +-
 include/linux/net_tstamp.h                         |  11 +-
 include/linux/netdevice.h                          |   8 +
 include/linux/phy.h                                |  10 +-
 include/uapi/linux/ethtool_netlink.h               |  29 +++
 include/uapi/linux/net_tstamp.h                    |  18 ++
 net/8021q/vlan_dev.c                               |  15 +-
 net/core/dev.c                                     |   3 +
 net/core/dev_ioctl.c                               |  43 ++--
 net/core/timestamping.c                            |  10 +
 net/ethtool/Makefile                               |   2 +-
 net/ethtool/common.c                               |  25 ++-
 net/ethtool/common.h                               |   1 +
 net/ethtool/netlink.c                              |  28 +++
 net/ethtool/netlink.h                              |   4 +
 net/ethtool/ts.c                                   | 244 +++++++++++++++++++++
 33 files changed, 732 insertions(+), 201 deletions(-)
---
base-commit: 5b7dd66960ba4e5cd2648692a6082a7ac6993867
change-id: 20231011-feature_ptp_netnext-3f278578e84b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

