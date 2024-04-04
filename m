Return-Path: <linux-kernel+bounces-131184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF8E89841D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E8128B58B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD10128815;
	Thu,  4 Apr 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZLNqa3jp"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8D126F3A;
	Thu,  4 Apr 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223031; cv=none; b=SmXL0HPkibmjChUAUcVjDlf6QA84Q2uF5/IR1z2KtHhoUBKtK02eCHm71Lu0GMEXABZ0H9+UEYi5/7Go+WPopCWuVnRAs6R6nwfV/vPkAXHrSmDWoVVaskN1rING1CIgdyuKDct5felatfPGtiFaXs5QB6vlBY1364JuCTKHkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223031; c=relaxed/simple;
	bh=DQ8hSk/QJxJe8njna3CjdjUvXRpC9lpfP5lOddhR+M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if9snoqQWNkjaAwkpF50/JXKuIxXWfhI1nJuKtMH/1L2f48FD5MhC32RgtALV82nUFNEgu0WCDEsKZ49B+P/JHmAIKhn/yzCVvpwSwJD35OEDtIfpgDcvLl9oTW8J+YVKju6KyikDOjZI8cguznDBWwZBGxFerpr16GzwQnBu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZLNqa3jp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0314EC000E;
	Thu,  4 Apr 2024 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712223026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ezeQPX3yemno8CVusc6+tE9tnpV7ze5r18FDCeQGVc=;
	b=ZLNqa3jpiQbp2Wc9Ii0TyGRXE3Jq5xAKzwkzCbkapovowiLgpE39ntM+XYbRKAzuaWjRsj
	5DzI6hlCChq+GZU1XbIwNFyiaF88+wuSByUc8b4WNeCUoMNWMibW9AkHhvvUuKCZw2sEvM
	iHFHavghW0rPMH9vcDNnHIO/05dCH3Cnj4LexOlrpu/Lm1nWJ0HmFSEoKyGutUlTuDc0rF
	NVmtDGCpyzBEMsfNWU2jYxXxwd3hSPZ7ndSy6XNxPRp+SOLQyWTHo+7TAakNUz/K/9D7Bo
	gQNJdkW8Epm7w4NPVm1p241Eum9Lj7/naJbJUasCA+C8HTrRDlMxPiKk2ZLxUA==
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
Subject: [PATCH net-next v11 13/13] Documentation: networking: document phy_link_topology
Date: Thu,  4 Apr 2024 11:30:03 +0200
Message-ID: <20240404093004.2552221-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The newly introduced phy_link_topology tracks all ethernet PHYs that are
attached to a netdevice. Document the base principle, internal and
external APIs. As the phy_link_topology is expected to be extended, this
documentation will hold any further improvements and additions made
relative to topology handling.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V11: - Fixed some typos and phrasing
     - Link to that page from the ethtool-netlink documentation
V10: No changes
V9: No changes
V8: No changes
V7: No changes
V6: No changes
V5: Fixed a lot of typos
V4: No changes
V3: New patch

 Documentation/networking/ethtool-netlink.rst  |   3 +
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 120 ++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 Documentation/networking/phy-link-topology.rst

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2871a6a772db..ef225d3acfc6 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2018,10 +2018,13 @@ Retrieve information about a given Ethernet PHY sitting on the link. The DO
 operation returns all available information about dev->phydev. User can also
 specify a PHY_INDEX, in which case the DO request returns information about that
 specific PHY.
+
 As there can be more than one PHY, the DUMP operation can be used to list the PHYs
 present on a given interface, by passing an interface index or name in
 the dump request.
 
+For more information, refer to :ref:`Documentation/networking/phy-link-topology.rst`
+
 Request contents:
 
   ====================================  ======  ==========================
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 473d72c36d61..c29bc5179d8a 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -89,6 +89,7 @@ Contents:
    operstates
    packet_mmap
    phonet
+   phy-link-topology
    pktgen
    plip
    ppp_generic
diff --git a/Documentation/networking/phy-link-topology.rst b/Documentation/networking/phy-link-topology.rst
new file mode 100644
index 000000000000..1f021419ae8c
--- /dev/null
+++ b/Documentation/networking/phy-link-topology.rst
@@ -0,0 +1,120 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PHY link topology
+=================
+
+Overview
+========
+
+The PHY link topology representation in the networking stack aims at representing
+the hardware layout for any given Ethernet link.
+
+An Ethernet interface from userspace's point of view is nothing but a
+:c:type:`struct net_device <net_device>`, which exposes configuration options
+through the legacy ioctls and the ethtool netlink commands. The base assumption
+when designing these configuration APIs were that the link looks something like ::
+
+  +-----------------------+        +----------+      +--------------+
+  | Ethernet Controller / |        | Ethernet |      | Connector /  |
+  |       MAC             | ------ |   PHY    | ---- |    Port      | ---... to LP
+  +-----------------------+        +----------+      +--------------+
+  struct net_device               struct phy_device
+
+Commands that needs to configure the PHY will go through the net_device.phydev
+field to reach the PHY and perform the relevant configuration.
+
+This assumption falls apart in more complex topologies that can arise when,
+for example, using SFP transceivers (although that's not the only specific case).
+
+Here, we have 2 basic scenarios. Either the MAC is able to output a serialized
+interface, that can directly be fed to an SFP cage, such as SGMII, 1000BaseX,
+10GBaseR, etc.
+
+The link topology then looks like this (when an SFP module is inserted) ::
+
+  +-----+  SGMII  +------------+
+  | MAC | ------- | SFP Module |
+  +-----+         +------------+
+
+Knowing that some modules embed a PHY, the actual link is more like ::
+
+  +-----+  SGMII   +--------------+
+  | MAC | -------- | PHY (on SFP) |
+  +-----+          +--------------+
+
+In this case, the SFP PHY is handled by phylib, and registered by phylink through
+its SFP upstream ops.
+
+Now some Ethernet controllers aren't able to output a serialized interface, so
+we can't directly connect them to an SFP cage. However, some PHYs can be used
+as media-converters, to translate the non-serialized MAC MII interface to a
+serialized MII interface fed to the SFP ::
+
+  +-----+  RGMII  +-----------------------+  SGMII  +--------------+
+  | MAC | ------- | PHY (media converter) | ------- | PHY (on SFP) |
+  +-----+         +-----------------------+         +--------------+
+
+This is where the model of having a single net_device.phydev pointer shows its
+limitations, as we now have 2 PHYs on the link.
+
+The phy_link topology framework aims at providing a way to keep track of every
+PHY on the link, for use by both kernel drivers and subsystems, but also to
+report the topology to userspace, allowing to target individual PHYs in configuration
+commands.
+
+API
+===
+
+The :c:type:`struct phy_link_topology <phy_link_topology>` is a per-netdevice
+resource, that gets initialized at netdevice creation. Once it's initialized,
+it is then possible to register PHYs to the topology through :
+
+:c:func:`phy_link_topo_add_phy`
+
+Besides registering the PHY to the topology, this call will also assign a unique
+index to the PHY, which can then be reported to userspace to refer to this PHY
+(akin to the ifindex). This index is a u32, ranging from 1 to U32_MAX. The value
+0 is reserved to indicate the PHY doesn't belong to any topology yet.
+
+The PHY can then be removed from the topology through
+
+:c:func:`phy_link_topo_del_phy`
+
+These function are already hooked into the phylib subsystem, so all PHYs that
+are linked to a net_device through :c:func:`phy_attach_direct` will automatically
+join the netdev's topology.
+
+PHYs that are on a SFP module will also be automatically registered IF the SFP
+upstream is phylink (so, no media-converter).
+
+PHY drivers that can be used as SFP upstream need to call :c:func:`phy_sfp_attach_phy`
+and :c:func:`phy_sfp_detach_phy`, which can be used as a
+.attach_phy / .detach_phy implementation for the
+:c:type:`struct sfp_upstream_ops <sfp_upstream_ops>`.
+
+UAPI
+====
+
+There exist a set of netlink commands to query the link topology from userspace,
+see ``Documentation/networking/ethtool-netlink.rst``.
+
+The whole point of having a topology representation is to assign the phyindex
+field in :c:type:`struct phy_device <phy_device>`. This index is reported to
+userspace using the ``ETHTOOL_MSG_PHY_GET`` ethtnl command. Performing a DUMP operation
+will result in all PHYs from all net_device being listed. The DUMP command
+accepts either a ``ETHTOOL_A_HEADER_DEV_INDEX`` or ``ETHTOOL_A_HEADER_DEV_NAME``
+to be passed in the request to filter the DUMP to a single net_device.
+
+The retrieved index can then be passed as a request parameter using the
+``ETHTOOL_A_HEADER_PHY_INDEX`` field in the following ethnl commands :
+
+* ``ETHTOOL_MSG_STRSET_GET`` to get the stats string set from a given PHY
+* ``ETHTOOL_MSG_CABLE_TEST_ACT`` and ``ETHTOOL_MSG_CABLE_TEST_ACT``, to perform
+  cable testing on a given PHY on the link (most likely the outermost PHY)
+* ``ETHTOOL_MSG_PSE_SET`` and ``ETHTOOL_MSG_PSE_GET`` for PHY-controlled PoE and PSE settings
+* ``ETHTOOL_MSG_PLCA_GET_CFG``, ``ETHTOOL_MSG_PLCA_SET_CFG`` and ``ETHTOOL_MSG_PLCA_GET_STATUS``
+  to set the PLCA (Physical Layer Collision Avoidance) parameters
+
+Note that the PHY index can be passed to other requests, which will silently
+ignore it if present and irrelevant.
-- 
2.44.0


