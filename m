Return-Path: <linux-kernel+bounces-15647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D569B822F86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5205728628C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFD1A727;
	Wed,  3 Jan 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d2pFx7rU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF51A70B;
	Wed,  3 Jan 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51F28FF816;
	Wed,  3 Jan 2024 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704292197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a05ZpwCKD22ZpankEalL5FReENSo5C7nkPaSj2vZgPk=;
	b=d2pFx7rU/3RPKqqnOSi6ocZqNZCPVlaRKeXfOzrTyxBpYU6xuf8FTilCOpmWwImvenDDCX
	s8A7u+oZLcojc5uQcil7otFw/0ERgOG2my9KgonZ8k08Z2hspT8sKgb6j75D6TpzcVUGSE
	lE6nX44WGP0TBbgncxZEJqAGB8+PF4CgXEJkBvg/wvjTzLdwHjXPPKcLVYXixWZJ+fWe3Z
	m106C5RjNVKP0ug6RVtrd2PHDiDVuqwsuav+GQgMB/uwXUC21l+VdZ9Qv+QiFVpiAWPT93
	eSbXKK/GL+XrnIsoWsU25FfktsR66h0tCFKAuuO8Rp4Q08NI+28dGJMH+2v84A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Michal Kubecek <mkubecek@suse.cz>
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
Subject: [PATCH ethtool-next 0/3] ethtool: Introduce PHY listing and targetting
Date: Wed,  3 Jan 2024 15:29:45 +0100
Message-ID: <20240103142950.235888-1-maxime.chevallier@bootlin.com>
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

This series implements the ethtool part of the multi-PHY support that was
recently merged into net-next :

https://lore.kernel.org/netdev/20231221180047.1924733-1-maxime.chevallier@bootlin.com/

The series starts with a UAPI header copy (I don't really know if it's up
to me to do this, let me know if I should drop it).

The second patch adds the possibility of passing a PHY index for the
PSE-PD, PLCA and Cable-testing commands, in such a manner :

ethtool --phy 2 --cable-test eth0

The new '--phy' parameter is optional for PHY-targetting commands, if it's
not there, we use the old behaviour of relying on the PHY directly attached
to the netdevice to perform the command.

The parameter comes before the actual command to make it generic, after all
the PHY index is passed in the request header.

The Third patch adds a new ethtool option to display the PHYs present on
an interface, along with enough information to reconstruct the link topology.
As it relies on the netlink DUMP messages, some internal helpers were added
in ethtool to send DUMP requests that includes a devname in the header, to
perform a filtered dump. Here are a few examples of what you can expect on
an interface that has 2 PHYs (the 88x3310 PHY exposes an SFP bus, on which
a module that also contains a PHY is plugged)

# ethtool --show-phys eth0

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

Here's another example using the wildcard devname, that lists all PHYs on
all interfaces :

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

Thanks,

Maxime

Maxime Chevallier (3):
  update UAPI header copies
  ethtool: Allow passing a PHY index for phy-targetting commands
  ethtool: Introduce a command to list PHYs

 Makefile.am                  |   1 +
 ethtool.c                    |  30 +-
 internal.h                   |   1 +
 netlink/cable_test.c         |   4 +-
 netlink/extapi.h             |   1 +
 netlink/msgbuff.c            |  52 +++-
 netlink/msgbuff.h            |   3 +
 netlink/nlsock.c             |  25 ++
 netlink/nlsock.h             |   2 +
 netlink/phy.c                | 139 +++++++++
 netlink/plca.c               |   4 +-
 netlink/pse-pd.c             |   4 +-
 uapi/linux/ethtool.h         |  56 +++-
 uapi/linux/ethtool_netlink.h |  31 ++
 uapi/linux/if_link.h         | 529 +++++++++++++++++++++++++++++++++++
 uapi/linux/stddef.h          |   2 +-
 16 files changed, 851 insertions(+), 33 deletions(-)
 create mode 100644 netlink/phy.c

-- 
2.43.0


