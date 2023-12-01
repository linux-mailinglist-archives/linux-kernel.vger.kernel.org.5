Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64AC80112B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjLAQhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLAQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:37:05 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5101DD;
        Fri,  1 Dec 2023 08:37:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BE74C0005;
        Fri,  1 Dec 2023 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701448628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WkW3OUOeXNQJ29bxSm8Xb6y1qODDZOMmGjeFQNk49MI=;
        b=oiauBO1+njTLHcLqkbr1MEnXqSw4A5+ypcfGY4oQV3Q/PDpMzDGEdIx3Fg3rd46YoXpKr+
        lfToMzzOCm6jQQHyZ3/oOM2G/OCKw3Sh4S+hRb7SbN/3F5vyJQ+iNm/gUwA9qq8zgD5fdp
        Y8FfMPMl/gbiyJgXtCIwciproKSuNtkHq6iOGM7f9pqMvgcTkwN5MFx+RQdGZvPKHyybKu
        f+jYRjFM1AS2G9oLJ9qkh7SsmtlKg+IarAQeXtEmkdRyENF3wJSKX5F8PHmz+C/lH7bQc3
        F6Bi/ChDlhjmXdv6id08Jd0UB0Vpoy3j96URYcTtzKFXP5fOc+c5L1LrGbYPJw==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Subject: [RFC PATCH net-next v3 00/13] Introduce PHY listing and link_topology tracking
Date:   Fri,  1 Dec 2023 17:36:50 +0100
Message-ID: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Here's a V3 of the multi-PHY support series. As a remainder, this ongoing
work aims ultimately at supporting complex link topologies that involve
multiplexing multiple PHYs/SFPs on a single netdevice. As a first step,
it's required that we are able to enumerate the PHYs on a given ethernet
interface.

By just doing so, we also improve already-existing use-cases, namely the
copper SFP modules support when a media-converter is used (as we have 2
PHYs on the link, but only one is referenced by net_device.phydev, which
is used on a variety of netlink commands).

The series is architectured as follows :

- The first patch adds the notion of phy_link_topology, which tracks
all PHYs attached to a netdevice.

- Patches 2, 3 and 4 adds some plumbing into SFP and phylib to be able
  to connect the dots when building the topology tree, to know which PHY
  is connected to which SFP bus, trying not to be too invasive on phylib.

- Patch 5 allows passing a PHY_INDEX to ethnl commands. I'm uncertain about
  this, as there are at least 4 netlink commands ( 5 with the one introduced
  in patch 7 ) that targets PHYs directly or indirectly, which to me makes
  it worth-it to have a generic way to pass a PHY index to commands, however
  the approach taken may be too generic.

- Patch 6 is the netlink spec update + ethtool-user.c|h autogenerated code
update (the autogenerated code triggers checkpatch warning though)

- Patch 7 introduces a new netlink command set to list PHYs on a netdevice.
It implements a custom DUMP and GET operation to allow filtered dumps,
that lists all PHYs on a given netdevice. I couldn't use most of ethnl's
plumbing though.

- Patch 8 is the netlink spec update + ethtool-user.c|h update for that
new command

- Patch 8,9,10 and 11 updates the PLCA, strset, cable-test and pse netlink
commands to use the user-provided PHY instead of net_device.phydev.

- Finally patch 12 adds some documentation for this whole work.

Examples
========

Here's a short overview of the kind of operations you can have regarding
the PHY topology. These tests were performed on a MacchiatoBin, which
has 3 interfaces :

eth0 and eth1 have the following layout:

MAC - PHY - SFP

eth2 has this more classic topology :

MAC - PHY - RJ45

finally eth3 has the following topology :

MAC - SFP

When performing a dump with all interfaces down, we don't get any
result, as no PHY has been attached to their respective net_device :

# ./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml --dump phy-get
None

The following output is with eth0, eth2 and eth3 up, but no SFP module
inserted in none of the interfaces :

# ./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml --dump phy-get
[{'downstream-sfp-name': 'sfp-eth0',
  'drvname': 'mv88x3310',
  'header': {'dev-index': 2, 'dev-name': 'eth0'},
  'id': 0,
  'index': 1,
  'name': 'f212a600.mdio-mii:00',
  'upstream-type': 'mac'},
 {'drvname': 'Marvell 88E1510',
  'header': {'dev-index': 4, 'dev-name': 'eth2'},
  'id': 21040593,
  'index': 1,
  'name': 'f212a200.mdio-mii:00',
  'upstream-type': 'mac'}]


And now is a dump operation with a copper SFP in the eth0 port :

# ./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml --dump phy-get
[{'downstream-sfp-name': 'sfp-eth0',
  'drvname': 'mv88x3310',
  'header': {'dev-index': 2, 'dev-name': 'eth0'},
  'id': 0,
  'index': 1,
  'name': 'f212a600.mdio-mii:00',
  'upstream-type': 'mac'},
 {'drvname': 'Marvell 88E1111',
  'header': {'dev-index': 2, 'dev-name': 'eth0'},
  'id': 21040322,
  'index': 2,
  'name': 'i2c:sfp-eth0:16',
  'upstream': {'index': 1, 'sfp-name': 'sfp-eth0'},
  'upstream-type': 'phy'},
 {'drvname': 'Marvell 88E1510',
  'header': {'dev-index': 4, 'dev-name': 'eth2'},
  'id': 21040593,
  'index': 1,
  'name': 'f212a200.mdio-mii:00',
  'upstream-type': 'mac'}]

 -- Note that this shouldn't actually work as the 88x3310 PHY doesn't allow
a 1G SFP to be connected to its SFP interface, and I don't have a 10G copper SFP,
so for the sake of the demo I applied the following modification, which
of courses gives a non-functionnal link, but the PHY attach still works,
which is what I want to demonstrate :

@@ -488,7 +488,7 @@ static int mv3310_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)

        if (iface != PHY_INTERFACE_MODE_10GBASER) {
                dev_err(&phydev->mdio.dev, "incompatible SFP module inserted\n");
-               return -EINVAL;
+               //return -EINVAL;
        }
        return 0;
 }

Finally an example of the filtered DUMP operation that Jakub suggested
in V1 :

# ./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
# --dump phy-get --json '{"header" : {"dev-name" : "eth0"}}'

[{'downstream-sfp-name': 'sfp-eth0',
  'drvname': 'mv88x3310',
  'header': {'dev-index': 2, 'dev-name': 'eth0'},
  'id': 0,
  'index': 1,
  'name': 'f212a600.mdio-mii:00',
  'upstream-type': 'mac'},
 {'drvname': 'Marvell 88E1111',
  'header': {'dev-index': 2, 'dev-name': 'eth0'},
  'id': 21040322,
  'index': 2,
  'name': 'i2c:sfp-eth0:16',
  'upstream': {'index': 1, 'sfp-name': 'sfp-eth0'},
  'upstream-type': 'phy'}]

And a classic GET operation allows querying a single PHY's info :

# ./cli.py --spec specs/ethtool.yaml --schema genetlink-legacy.yaml \
# --do phy-get --json '{"header" : {"dev-name" : "eth0", "phy-index" : 2}}'

{'drvname': 'Marvell 88E1111',
 'header': {'dev-index': 2, 'dev-name': 'eth0'},
 'id': 21040322,
 'index': 2,
 'name': 'i2c:sfp-eth0:16',
 'upstream': {'index': 1, 'sfp-name': 'sfp-eth0'},
 'upstream-type': 'phy'}

Changes in V3:
- Added RTNL assertions where needed
- Fixed issues in the DUMP code for PHY_GET, which crashed when running it
  twice in a row
- Added the documentation, and moved in-source docs around
- renamed link_topology to phy_link_topology

Changes in V2:
- Added the DUMP operation
- Added much more information in the reported data, to be able to reconstruct
  precisely the topology tree
- renamed phy_list to link_topology

Maxime Chevallier (13):
  net: phy: Introduce ethernet link topology representation
  net: sfp: pass the phy_device when disconnecting an sfp module's PHY
  net: phy: add helpers to handle sfp phy connect/disconnect
  net: sfp: Add helper to return the SFP bus name
  net: ethtool: Allow passing a phy index for some commands
  netlink: specs: add phy-index as a header parameter
  net: ethtool: Introduce a command to list PHYs on an interface
  netlink: specs: add ethnl PHY_GET command set
  net: ethtool: plca: Target the command to the requested PHY
  net: ethtool: pse-pd: Target the command to the requested PHY
  net: ethtool: cable-test: Target the command to the requested PHY
  net: ethtool: strset: Allow querying phy stats by index
  Documentation: networking: document phy_link_topology

 Documentation/netlink/specs/ethtool.yaml      |  68 ++
 Documentation/networking/ethtool-netlink.rst  |  51 ++
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 121 ++++
 MAINTAINERS                                   |   2 +
 drivers/net/phy/Makefile                      |   2 +-
 drivers/net/phy/at803x.c                      |   2 +
 drivers/net/phy/marvell-88x2222.c             |   2 +
 drivers/net/phy/marvell.c                     |   2 +
 drivers/net/phy/marvell10g.c                  |   2 +
 drivers/net/phy/phy_device.c                  |  55 ++
 drivers/net/phy/phy_link_topology.c           |  85 +++
 drivers/net/phy/phylink.c                     |   3 +-
 drivers/net/phy/sfp-bus.c                     |  15 +-
 include/linux/netdevice.h                     |   4 +-
 include/linux/phy.h                           |   6 +
 include/linux/phy_link_topology.h             |  64 ++
 include/linux/phy_link_topology_core.h        |  15 +
 include/linux/sfp.h                           |   8 +-
 include/uapi/linux/ethtool.h                  |  16 +
 include/uapi/linux/ethtool_netlink.h          |  30 +
 net/core/dev.c                                |   3 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cabletest.c                       |  12 +-
 net/ethtool/netlink.c                         |  33 +
 net/ethtool/netlink.h                         |  12 +-
 net/ethtool/phy.c                             | 292 ++++++++
 net/ethtool/plca.c                            |  13 +-
 net/ethtool/pse-pd.c                          |  14 +-
 net/ethtool/strset.c                          |  15 +-
 tools/net/ynl/generated/ethtool-user.c        | 265 +++++++
 tools/net/ynl/generated/ethtool-user.h        | 683 ++++++++++++++++++
 32 files changed, 1858 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/networking/phy-link-topology.rst
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 include/linux/phy_link_topology.h
 create mode 100644 include/linux/phy_link_topology_core.h
 create mode 100644 net/ethtool/phy.c

-- 
2.42.0

