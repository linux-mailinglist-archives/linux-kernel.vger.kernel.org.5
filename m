Return-Path: <linux-kernel+bounces-40501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA383E1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4864DB24E60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA712209F;
	Fri, 26 Jan 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jXPcmQZr"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11822314;
	Fri, 26 Jan 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294345; cv=none; b=sfnoVcx39NR25HsAd3qoGVq4j5ao+s0LQYvHyxU41hck7iueJl0Lypzh7hbXJPb41ZeLfzBw8t2apo3tt0rSJmJW6jaSZu4n4/5GO1Lhx9fQRZFZOlB6aY0Y5uYkAlghaoxbThkqmv9IM/4vdFRuhxrjEyxuu/5QlwvBLRixdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294345; c=relaxed/simple;
	bh=2Vifm3Clfr2xszb+ywbPOhQLn9MbhjVZ/slMa2m4ZLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TM4qSMgRfVY7FuaK8x/5bz5FRmKR4I8gBJm1lGYKiagJyXdWYHv1T1z9PLeQzzfMQeUTay2ZDRKvc5csGth/QOVx636fH/cRIUimZN0eWT8cMBZtUzjwtFMr6IFVV+fu2LcqB0kPRxnB5mecxvUmrl1hQjX6WehMYTYtKkmmNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jXPcmQZr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 434FEFF807;
	Fri, 26 Jan 2024 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706294335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yeL548460/u4rHD5j2BuwVWmAizj8tIX6rIka3UJqMg=;
	b=jXPcmQZrsZk/4tDdz8Evmndg3RJPsY2zUTYu8R/jkNbcBw1OKqsXyQ46hGJglzG63/mlNT
	ZHLzfoIhpZAucuqot3+PfDbiajz89frUNU/+2ZvkQFqhMFqtS+Z3bmclT9kwBfcrf/KMwn
	CjFePlgkVbLvJfpNm08L9YSUep4R7fV8ROwB4GBY3Qlv2YG8vzzU7flPzZ3AU/VpvFThg7
	wh7DvnWmB8Y2OhlDfi2ZBuk6CtkSrrv5VuDntqJgoq3PvZFgt/aHhF5zrrd0mHzsD/rEkQ
	ZZHUfQ0WBrfta1G6tbZ+xFNqT6d1aCAOcm0vMT2R8SnkihfNpBxBX084t9d4fQ==
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 00/13] Introduce PHY listing and link_topology tracking
Date: Fri, 26 Jan 2024 19:38:37 +0100
Message-ID: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

Here's a V6 for the link topo and multi-phy support series.

Most of the changes were from Jakub's and Russell's reviews, the main
point being a rework of the netlink API, removing uneeded nests and
cleaning-up the dump code. Thanks's Jakub for all the tips, hopefulle
the API is cleaner now.

Another change is that we now try to re-use the phy index if possible,
but I couldn't reliably have this and the alloc-topology-on-first-attached-phy
feature as well, with the risk of assigning the same index to different
PHYs when setting an interface down then up again.

Here's what the new listings would look like :
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
 Documentation/networking/ethtool-netlink.rst  |  46 +++
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 121 +++++++
 MAINTAINERS                                   |   2 +
 drivers/net/phy/Makefile                      |   2 +-
 drivers/net/phy/at803x.c                      |   2 +
 drivers/net/phy/marvell-88x2222.c             |   2 +
 drivers/net/phy/marvell.c                     |   2 +
 drivers/net/phy/marvell10g.c                  |   2 +
 drivers/net/phy/phy_device.c                  |  55 ++++
 drivers/net/phy/phy_link_topology.c           | 105 ++++++
 drivers/net/phy/phylink.c                     |   3 +-
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
 net/ethtool/netlink.c                         |  53 +++-
 net/ethtool/netlink.h                         |  10 +
 net/ethtool/phy.c                             | 298 ++++++++++++++++++
 net/ethtool/plca.c                            |  19 +-
 net/ethtool/pse-pd.c                          |  13 +-
 net/ethtool/strset.c                          |  17 +-
 30 files changed, 966 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/networking/phy-link-topology.rst
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 include/linux/phy_link_topology.h
 create mode 100644 include/linux/phy_link_topology_core.h
 create mode 100644 net/ethtool/phy.c

-- 
2.43.0


