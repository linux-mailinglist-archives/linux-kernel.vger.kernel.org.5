Return-Path: <linux-kernel+bounces-73525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7585C3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F892862A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDA133983;
	Tue, 20 Feb 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i0Cc23g/"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D012AAC1;
	Tue, 20 Feb 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454548; cv=none; b=Ri+Nrio/pUiXIEXMuAKBPJBP8CqKrd8qJj983yOHvJCRtu+fLcYcexbREdPfl867CfMaeS7P4bJMm9MnEfs6OSLIrZ3QNtHwVTy6Ssh9lcJwCZEtvsj9jHcnrfP5j38UZOX09LpvG+dY7mU0NOX8uzGRClnaK34klsjF58GwoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454548; c=relaxed/simple;
	bh=+pVfYEr7XO3DpYpotTiexUm+b8VWYPRpkEbdDmREHlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APC5+4j+lrIlUy/Pzs6qnpsDXNtfQGdOgaVhYxwjXFWO7z78Ls+Bxa3ERVkMtzbBs3mPmWbUWnlDpgLqoPsI4Hw+ZP6L94oIStKYMP1ZbHrLHZ2KhQGz+gZL3cjSE1r11OYL+Di36kE7xxSB8CdicMhpW5rqG6RJ2N4FUB3cHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i0Cc23g/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DF4160002;
	Tue, 20 Feb 2024 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708454542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xTQHv/xPrWj4xRmZLf6OLY/oIhHbsC3f4zK2ZbIN5Es=;
	b=i0Cc23g/2GRDjwry00mzOVZ89XR3vRiy0m4NW6UpbOt+5HqmYI0Idc5NwAhYSWRy81pOE9
	Wpwa6cIgwqyAEnEpdfDfjpP8MQd+vvAI0zdgEGLcwPZBem68GzpiVrBYCf6pijPzZVhBEc
	Tlz99UPRjijz/YzfzmhvDXfkduYd48UItkxlL5rTYx8Y0noDcDoZLDMg2Vaygh4q35IH1U
	kKTNgxSgD6Em3Hi/KOkypeoQIHpapGUBCcCW+J9WmYeMiF2E6VST92RyfB3z+2RVOtgzuj
	Zt5iqRMrMhG1mr7SfgPV4QYsDV6o47xScTLHlM8J67UyQnyUq4AdSs3YWCvrWg==
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
Subject: [PATCH net-next v8 00/13] Introduce PHY listing and link_topology tracking
Date: Tue, 20 Feb 2024 19:42:03 +0100
Message-ID: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V8 for the link topology addition, allowing to track all PHYs
that are linked to netdevices. V8 is merely V7 rebased on net-next with
a few basic adaptations due to the at803x driver split. I'm leaving the
V7 explanations below still.

In V7 was introduced the protection of the main internal API
entrypoints (link_topo_init/cleanup, link_topo_add/del_phy) by
IS_REACHABLE(CONFIG_PHYLIB).

That's restrictive, but it looks difficult to do otherwise while still keep the
data structure opaque and not add dependency clutter with PHYLIB.

As you can tell, I'm unsure about this, so please don't hesitate to
comment on that part :)

The other changes are very minor, the only one is a call to netdev_put
in the .done() netlink callback.

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
 Documentation/networking/ethtool-netlink.rst  |  46 +++
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 121 +++++++
 MAINTAINERS                                   |   2 +
 drivers/net/phy/Makefile                      |   2 +-
 drivers/net/phy/marvell-88x2222.c             |   2 +
 drivers/net/phy/marvell.c                     |   2 +
 drivers/net/phy/marvell10g.c                  |   2 +
 drivers/net/phy/phy_device.c                  |  55 ++++
 drivers/net/phy/phy_link_topology.c           | 105 +++++++
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
 net/ethtool/netlink.c                         |  53 +++-
 net/ethtool/netlink.h                         |  10 +
 net/ethtool/phy.c                             | 297 ++++++++++++++++++
 net/ethtool/plca.c                            |  19 +-
 net/ethtool/pse-pd.c                          |  13 +-
 net/ethtool/strset.c                          |  17 +-
 31 files changed, 967 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/networking/phy-link-topology.rst
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 include/linux/phy_link_topology.h
 create mode 100644 include/linux/phy_link_topology_core.h
 create mode 100644 net/ethtool/phy.c

-- 
2.43.2


