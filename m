Return-Path: <linux-kernel+bounces-40514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2783E1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5313C1C210ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300F5100A;
	Fri, 26 Jan 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HCZX5vCc"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4825560;
	Fri, 26 Jan 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294354; cv=none; b=VVdr5v7LSpMspUIuc+d0/iaTKOKRjk02AT6Ci1/TCMXMiT12uTD2rk+akvuhVDl+U+rgddCk2g9fq4uxKgRx10fza/HpmQpKCD3a0g2RUKSV8v10kxDZ1N+dyjEWSOwQsfls4lavGYmT7/T7U53a60Z5ArljeC9jXctCnmC1pmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294354; c=relaxed/simple;
	bh=QR8KukQNJYf4X9G6LtFhLoWAABohgfvSPcQpNy0NZ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSMQuQaEGFq9uKN/+iV5BKa9MUWB3TMJ89ppAhSK1Tsj1uLiQ8xLADOX2nppauvkEbqV6/l1NtdjhVp3hnR7e2lA+63zjJpIntcpj2xrCyVGuifPEhqloMN9PujmNoRGy2AMrhs+ejT4xEypr0FZv0XRwF1nEvNUy6VqXtG09sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HCZX5vCc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D42EFF805;
	Fri, 26 Jan 2024 18:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706294350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdrRTdEirrNY3jmVRjt4I2nMCqECN/logDj8JRe5CMw=;
	b=HCZX5vCcRr7i3B1FCZB+R+7/1XG8N6PROGn20hnFZVp+4mBr56iBYtmj+fYnhIRxSnXpmi
	zPuh7Jkmskx0uwymj0zZV0e+au5L05kLaRiaIYUC/INU0zUv0kfgX0887Eo2b8Rc4hvoW0
	s9bcf8nXyupKb6C7CPgfILqoTShWmZaJieUAcRlH8Xb814W02g96FETRsPcp95vGRibvF4
	6+hiHEricGbtCRdtN0d0gEWrbqlJ2qa+iqL7/kMGrDMM0A1t3o5dL4yXg15eEtf6DFAN1o
	lRKW2Cm46x8/Kp7z1wL0AxMRcpNfbho/lPN6OzUXFfKc7PxeOsw15Z9+Y/g0YA==
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
Subject: [PATCH net-next v6 13/13] Documentation: networking: document phy_link_topology
Date: Fri, 26 Jan 2024 19:38:50 +0100
Message-ID: <20240126183851.2081418-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
References: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
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
V6: No changes
V5: Fixed a lot of typos
V4: No changes
V3: New patch

 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/networking/phy-link-topology.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 69f3d6dcd9fd..a2c45a75a4a6 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -88,6 +88,7 @@ Contents:
    operstates
    packet_mmap
    phonet
+   phy-link-topology
    pktgen
    plip
    ppp_generic
diff --git a/Documentation/networking/phy-link-topology.rst b/Documentation/networking/phy-link-topology.rst
new file mode 100644
index 000000000000..1fd8e904ef4b
--- /dev/null
+++ b/Documentation/networking/phy-link-topology.rst
@@ -0,0 +1,121 @@
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
+An Ethernet Interface from userspace's point of view is nothing but a
+:c:type:`struct net_device <net_device>`, which exposes configuration options
+through the legacy ioctls and the ethool netlink commands. The base assumption
+when designing these configuration channels were that the link looked
+something like this ::
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
2.43.0


