Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17F797872
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbjIGQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbjIGQqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:46:30 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439831FCC;
        Thu,  7 Sep 2023 09:46:00 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id B40D5D6690;
        Thu,  7 Sep 2023 09:24:32 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E93EA40008;
        Thu,  7 Sep 2023 09:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694078652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0KUSASuywSFIdQYNEy6q9upRi360dRABnRopUM5gy1o=;
        b=PWmI2oaBmDwnUHyK6CMz0MiDc0keJx5BHjiY61H1EYOpgEfGm1AcFCwi98dfYqRBmWnYWo
        b51Wb2FdcbOc6SwRhCEPFju8H0/j20zUKIYZZPv6hMcIzEpcD2Q2XDmFPKKCkeHhMReXGt
        KgbHntroL19DpkhjCkwimawCgJXGGHGbmuqbcXwm4O2KQI2FURqRlEIbjZdp2sPLNC955R
        hPW9KtHuKlMu5kz41Ea0l11jhAu+ZRKop8ZW/Q4nK/KmkHPJisvTbkThbdrWmuU22De9xr
        U9oylmFHecb6G6rlBm3czBwq+9vgvYMu0vENVYVCCcDG5gIMYqZbckQd89iqBA==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Date:   Thu,  7 Sep 2023 11:23:58 +0200
Message-ID: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is the first RFC series introducing ethernet PHY numbering, in an
effort to better represent the link components and allow userspace to
configure these.

As of today, PHY devices are hidden behind the struct net_device from
userspace, but there exists commands such as PLCA configuration,
cable-testing, soon timestamping, that actually target the phy_device.

These commands rely on the ndev->phydev pointer to find the phy_device.

However, there exists use-cases where we have multiple PHY devices
between the MAC and the front-facing port. The most common case right
now is when a PHY acts as a media-converter, and is wired to an SFP
port :

[MAC] - [PHY] - [SFP][PHY]


Modules plugged in that port may contain a PHY too, and this is
where discrepencies start to happen.

In this case, ndev->phydev will point to the innermost PHY. Users
willing to use the SFP phy for cable-testing for example would get
unexpected results, as the middle PHY will be reached.

This is worsen by the fact that in a scenario like this :

[MAC] - [SFP][PHY]

the ndev->phydev pointer do point to the SFP PHY.

This is only the tip of the iceberg, such scenarios can happen with
other designs that include a mii mux, which isn't supported yet but
would require PHY enumeration to work.

This series therefore tries to add the ability to enumerate the PHYs
sitting behind a MAC, and assign them a unique number.

I've used the term of "phy namespace" to emphasize the fact that the PHY
numbering really is specific to an interface, each interface maintaining
its numbering scheme, starting from 0, and wrapping after all u32 values
have been exhausted.

The PHY namespace is for now contained within struct net_device, meaning
that PHYs that aren't related at all to any net_device wouldn't be
numbered as of right now. The only case I identified is when a PHY sits
between 2 DSA switches, but I don't know how relevant this is.

The phy_ns is its own struct, for now owned by net_device, but it could
be shared with struct dsa_port for example to make a MAC and the DSA CPU
port share the same phy ns.

This is early work, and it has its shortcomings :

 - I didn't include netlink notifications on PHY insersion/removal, but
   I think this could definitely be useful

 - the netlink API would need polishing, I struggle a bit with finding
   the correct netlink design pattern to return variale-length list of u32.

 - I would like to port netlink commands such as cable-test and plca to
   this new model, by adding an optional PHYINDEX field in the request.
   The idea would be that if the PHYINDEX is passed in the netlink
   request, we lookup the corresponding phy_device, and if not, we
   fallback to ndev->phydev.

 - Naming is hard, feel free to suggest any correction

Let me know what you think of this approach,

Best regards,

Maxime

Maxime Chevallier (7):
  net: phy: introduce phy numbering and phy namespaces
  net: sfp: pass the phy_device when disconnecting an sfp module's PHY
  net: phy: add helpers to handle sfp phy connect/disconnect
  net: ethtool: add a netlink command to list PHYs
  netlink: specs: add phy_list command
  net: ethtool: add a netlink command to get PHY information
  netlink: specs: add command to show individual phy information

 Documentation/netlink/specs/ethtool.yaml |  65 ++++++++++++
 drivers/net/phy/Makefile                 |   2 +-
 drivers/net/phy/at803x.c                 |   2 +
 drivers/net/phy/marvell-88x2222.c        |   2 +
 drivers/net/phy/marvell.c                |   2 +
 drivers/net/phy/marvell10g.c             |   2 +
 drivers/net/phy/phy_device.c             |  53 ++++++++++
 drivers/net/phy/phy_ns.c                 |  65 ++++++++++++
 drivers/net/phy/phylink.c                |   3 +-
 drivers/net/phy/sfp-bus.c                |   4 +-
 include/linux/netdevice.h                |   2 +
 include/linux/phy.h                      |   6 ++
 include/linux/phy_ns.h                   |  30 ++++++
 include/linux/sfp.h                      |   2 +-
 include/uapi/linux/ethtool.h             |   7 ++
 include/uapi/linux/ethtool_netlink.h     |  27 +++++
 net/core/dev.c                           |   3 +
 net/ethtool/Makefile                     |   2 +-
 net/ethtool/netlink.c                    |  20 ++++
 net/ethtool/netlink.h                    |   4 +
 net/ethtool/phy.c                        | 124 +++++++++++++++++++++++
 net/ethtool/phy_list.c                   |  99 ++++++++++++++++++
 22 files changed, 520 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/phy/phy_ns.c
 create mode 100644 include/linux/phy_ns.h
 create mode 100644 net/ethtool/phy.c
 create mode 100644 net/ethtool/phy_list.c

-- 
2.41.0

