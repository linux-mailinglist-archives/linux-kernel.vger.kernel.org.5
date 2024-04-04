Return-Path: <linux-kernel+bounces-131171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87766898401
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84211C22310
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6F75805;
	Thu,  4 Apr 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h7c0ijvT"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031627443E;
	Thu,  4 Apr 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223013; cv=none; b=D4/Z4OmosixV11bQq76g3GpcdTcUO43vBx7Fu9hoYcuiYbqhvIdhrOOxSyVLJ3z2km7kHd5WBboJIVC678uUZhPmSBX8zNmpgxHrXYc8cgY7iBIx8xuBTUaZzN3DkaaHa+WV9bJLywhlUU5bsssd4tfljU5j6U63XSvcXG4WEEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223013; c=relaxed/simple;
	bh=pGQtcE7yixraOz1GdkA161tjH6f1m3i0m+MhY8ICudc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLOj7M+9W5XQ8RN4jiS3g1EPkmlvJACiP976VZAQNbiThmWGRH6ZtIQ4qkGbat31G4EbrapREcYzc7Zaod0CMiwxllRXFB2l7aAN2q+J87Zpkv/FV8YwN91XCCztoew31s+st1WAQYJSMjCA023eioZMZsZbbv0yc17Ctwp3SKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h7c0ijvT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B934C000A;
	Thu,  4 Apr 2024 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712223009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KpZLzk+yxmd2N+rLGkTeJed9//8KUR7HQ4lmyd8EXFo=;
	b=h7c0ijvTmw4H1AE9La2KRu3naCyGnBspabRjtnT1NwbfV+OhXMOHpXsak+p+Sy9/cCeQRc
	H26foM5ljHEvNYPkvkm+4jiLgHCGDme5mD5FbyMtQu8vSlHHKgOfkmnvRTxJm0sfeP93a+
	yKnQlgRzlneS3bBxk9Q05U0oDBDT+JOBumsDrR4FFKrFAbWzeTCHY0rgtuWpcE7hdcPFKQ
	oTQXChD6b+xG/1xOwQgJ907qHHO85AKtOxwPoaxi3erzvPYQmT9v8HK+p2SH0nBRjvl6F7
	efvNWU5nvFf+mj4MafbY/l6d8Zc9MaiPdQPN4Ar5aN+OwvuYrOB2ecxPaqqvxg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
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
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v11 00/13] Introduce PHY listing and link_topology tracking
Date: Thu,  4 Apr 2024 11:29:50 +0200
Message-ID: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V11 for the link topology addition, allowing to track all PHYs
that are linked to netdevices.

This V11 addresses the various netlink-related issues that were raised
by Jakub, and fixes some typos in the documentation.

As a remainder, here's what the PHY listings would look like :
 - eth0 has a 88x3310 acting as media converter, and an SFP module with
   an embedded 88e1111 PHY
 - eth2 has a 88e1510 PHY

# ethtool --show-phys *

PHY for eth0:
PHY index: 1
Driver name: mv88x3310
PHY device name: f212a600.mdio-mii:00
Downstream SFP bus name: sfp-eth0
PHY id: 0
Upstream type: MAC

PHY for eth0:
PHY index: 2
Driver name: Marvell 88E1111
PHY device name: i2c:sfp-eth0:16
PHY id: 21040322
Upstream type: PHY
Upstream PHY index: 1
Upstream SFP name: sfp-eth0

PHY for eth2:
PHY index: 1
Driver name: Marvell 88E1510
PHY device name: f212a200.mdio-mii:00
PHY id: 21040593
Upstream type: MAC

Ethtool patches : https://github.com/minimaxwell/ethtool/tree/link-topo-v6

Link to V10: https://lore.kernel.org/netdev/20240304151011.1610175-1-maxime.chevallier@bootlin.com/
Link to V9: https://lore.kernel.org/netdev/20240228114728.51861-1-maxime.chevallier@bootlin.com/
Link to V8: https://lore.kernel.org/netdev/20240220184217.3689988-1-maxime.chevallier@bootlin.com/
Link to V7: https://lore.kernel.org/netdev/20240213150431.1796171-1-maxime.chevallier@bootlin.com/
Link to V6: https://lore.kernel.org/netdev/20240126183851.2081418-1-maxime.chevallier@bootlin.com/
Link to V5: https://lore.kernel.org/netdev/20231221180047.1924733-1-maxime.chevallier@bootlin.com/
Link to V4: https://lore.kernel.org/netdev/20231215171237.1152563-1-maxime.chevallier@bootlin.com/
Link to V3: https://lore.kernel.org/netdev/20231201163704.1306431-1-maxime.chevallier@bootlin.com/
Link to V2: https://lore.kernel.org/netdev/20231117162323.626979-1-maxime.chevallier@bootlin.com/
Link to V1: https://lore.kernel.org/netdev/20230907092407.647139-1-maxime.chevallier@bootlin.com/

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

 Documentation/netlink/specs/ethtool.yaml      |  62 ++++
 Documentation/networking/ethtool-netlink.rst  |  52 +++
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 120 +++++++
 MAINTAINERS                                   |   2 +
 drivers/net/phy/Makefile                      |   2 +-
 drivers/net/phy/marvell-88x2222.c             |   2 +
 drivers/net/phy/marvell.c                     |   2 +
 drivers/net/phy/marvell10g.c                  |   2 +
 drivers/net/phy/phy_device.c                  |  55 ++++
 drivers/net/phy/phy_link_topology.c           | 105 ++++++
 drivers/net/phy/phylink.c                     |   3 +-
 drivers/net/phy/qcom/at803x.c                 |   2 +
 drivers/net/phy/qcom/qca807x.c                |   2 +
 drivers/net/phy/sfp-bus.c                     |  15 +-
 include/linux/netdevice.h                     |   4 +-
 include/linux/phy.h                           |   6 +
 include/linux/phy_link_topology.h             |  72 +++++
 include/linux/phy_link_topology_core.h        |  25 ++
 include/linux/sfp.h                           |   8 +-
 include/uapi/linux/ethtool.h                  |  16 +
 include/uapi/linux/ethtool_netlink.h          |  21 ++
 net/core/dev.c                                |   9 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cabletest.c                       |  16 +-
 net/ethtool/netlink.c                         |  57 +++-
 net/ethtool/netlink.h                         |  10 +
 net/ethtool/phy.c                             | 300 ++++++++++++++++++
 net/ethtool/plca.c                            |  19 +-
 net/ethtool/pse-pd.c                          |  13 +-
 net/ethtool/strset.c                          |  17 +-
 31 files changed, 979 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/networking/phy-link-topology.rst
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 include/linux/phy_link_topology.h
 create mode 100644 include/linux/phy_link_topology_core.h
 create mode 100644 net/ethtool/phy.c

-- 
2.44.0


