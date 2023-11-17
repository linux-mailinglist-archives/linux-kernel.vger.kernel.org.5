Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1977EF566
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjKQPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:40:23 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC183D57;
        Fri, 17 Nov 2023 07:40:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 728561BF20A;
        Fri, 17 Nov 2023 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h9GGc7/PGEK31JSPiSs46CqoEYQ/oyaRsB8OJiWb9ho=;
        b=kkq0lXuP0evrmetGjiY5sJ6HBbMjEq01oOG8+eTKhSBjUjHkBxvxvuUCuMQSSmZLG4U2WS
        CfxtULM667y1eda5y0mTnCQ3K8Soaznbeu2ekr6hOsGA3I0lhHo75bztfcf2oxBOxE7pCe
        7mgwJOn7KxK2Ae7/L64u24vqwhUta1Y2HU6QLGLlPWQoK280rY6bUWhb3n4/j5o73nzuiT
        Ay8MEDjVRzfxSTu4xg3rZPMundd1BhMLZhpB0egKHzbLQVLvZyTm6BkA0FotK/yTD9l9dQ
        dD5dsyW4A2dosyGWeA4bFzU73+IJni47e72FSrLTYslHTPV2PNxjaGXhwmk0+A==
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
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [RFC PATCH net-next v2 00/10] Introduce PHY listing and link_topology tracking
Date:   Fri, 17 Nov 2023 17:23:11 +0100
Message-ID: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

As part of the ongoing effort to better describe the ethernet link
topology, this series introduces the first step by allowing to maintain
a list of all the ethernet PHYs that are connected to a given netdevice.

For now, this can happen when using a PHY as a media converter :

   MAC - PHYa - SFP - PHYb (in SFP module)

The issue with the above is that from userspace, we can only interact
with PHYa, as it's referenced by netdev->phydev, used in PHY-specific
netlink commands. This series therefore proposes to keep track of all
PHYs, through the struct link_topology, owned by struct
net_device. Phylib is therefore registering all PHYs and information on
their parent device, through direct attachment to a MAC or as part of an
SFP bus. This is done by patches 1 to 3.

Patches 4 to 6 introduce a new netlink command to get/dump the PHYs on a
given interface, with enough information to reconstruct the whole
topology, especially if we have chained PHYs.

Patches 7 to 10 are a proposition to extend the PLCA, PSE-PD, Cabletest
and stats reporting commands to take the PHY index into account, however
I only did minimal testing on these, and I'd like feedback on the idea.

Although more complete, this is still RFC, but I have some followup
series for a better port representation that depends on it, which I can
include for next revisions, but I don't want to make the series too big.

The first RFC was much less compete, but can be found here [1].

The overall topic was presented at Netdev 0x17 [2]

Best regards,

Maxime

[1] : https://lore.kernel.org/netdev/20230907092407.647139-1-maxime.chevallier@bootlin.com/
[2] : https://bootlin.com/pub/conferences/2023/netdev/multi-port-multi-phy-interfaces.pdf

Maxime Chevallier (10):
  net: phy: Introduce ethernet link topology representation
  net: sfp: pass the phy_device when disconnecting an sfp module's PHY
  net: phy: add helpers to handle sfp phy connect/disconnect
  net: sfp: Add helper to return the SFP bus name
  net: ethtool: Allow passing a phy index for some commands
  net: ethtool: Introduce a command to list PHYs on an interface
  net: ethtool: plca: Target the command to the requested PHY
  net: ethtool: pse-pd: Target the command to the requested PHY
  net: ethtool: cable-test: Target the command to the requested PHY
  net: ethtool: strset: Allow querying phy stats by index

 Documentation/netlink/specs/ethtool.yaml     |  69 ++++-
 Documentation/networking/ethtool-netlink.rst |  51 ++++
 MAINTAINERS                                  |   1 +
 drivers/net/phy/Makefile                     |   2 +-
 drivers/net/phy/at803x.c                     |   2 +
 drivers/net/phy/link_topology.c              |  78 ++++++
 drivers/net/phy/marvell-88x2222.c            |   2 +
 drivers/net/phy/marvell.c                    |   2 +
 drivers/net/phy/marvell10g.c                 |   2 +
 drivers/net/phy/phy_device.c                 |  54 ++++
 drivers/net/phy/phylink.c                    |   3 +-
 drivers/net/phy/sfp-bus.c                    |  13 +-
 include/linux/ethtool_netlink.h              |   5 +
 include/linux/link_topology.h                |  59 ++++
 include/linux/link_topology_core.h           |  17 ++
 include/linux/netdevice.h                    |   3 +-
 include/linux/phy.h                          |   5 +
 include/linux/sfp.h                          |   8 +-
 include/uapi/linux/ethtool.h                 |   7 +
 include/uapi/linux/ethtool_netlink.h         |  30 ++
 net/core/dev.c                               |   4 +
 net/ethtool/Makefile                         |   2 +-
 net/ethtool/cabletest.c                      |  12 +-
 net/ethtool/netlink.c                        |  30 ++
 net/ethtool/netlink.h                        |  11 +-
 net/ethtool/phy.c                            | 279 +++++++++++++++++++
 net/ethtool/plca.c                           |  13 +-
 net/ethtool/pse-pd.c                         |  14 +-
 net/ethtool/strset.c                         |  15 +-
 29 files changed, 752 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/phy/link_topology.c
 create mode 100644 include/linux/link_topology.h
 create mode 100644 include/linux/link_topology_core.h
 create mode 100644 net/ethtool/phy.c

-- 
2.41.0

