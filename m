Return-Path: <linux-kernel+bounces-88751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D886E61A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424041F21B89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B33B282;
	Fri,  1 Mar 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f/OkB35A"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D93A292;
	Fri,  1 Mar 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311396; cv=none; b=V0mSuPO7h5Xf/yNoy3t64UQhieXN+wxBgxM2kweUb33QZ3SNGSTtCOc6PQtn1bag+ldN7BwOei8McMs6iGu+tPa9RCTLFitkCXw16gZxR2Q6H+lTWX3nsRXQnM4PYqvDwqHQLV8V4LRbJldr3oAnVPYl3ntkEHciPU4KrdzIftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311396; c=relaxed/simple;
	bh=75AEy1zWlndPq1U/Un/5Ks4p3OAHhznbncWj8YPNmHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKLFjhtrL5zQKP54EnxaMgV3mVoaMTdq0hFcQWaNa7JdxrlHbgiqO/IjteMijPNpEjivY/S0V1WDDfU21+HkDjP6nQQVSHvTDLD7QaR9mVNBZKJDrbqUYtk5TMCVlbjtWSFdfN4q8aPQ0oVEyfG9c1AVrzig3vtjGp728Ki6RDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f/OkB35A; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF0BE240007;
	Fri,  1 Mar 2024 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709311392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdKbotaExDpWBCOtfR3VZjJCq8E0opyDA13hf7YPanw=;
	b=f/OkB35A2676PpVlRJk6dGvqH9ekmaS77ZvkVd4TvB/z2SPkBT2Wsu6wBNmzo/oZ+lERAS
	VaLYhZa4rrahGnXuZpvREphUjZ4KftugfvhfCvdhbogtaXBD98ZX1u7518ehFmWnPKS/o3
	Kj5kXyltmb52sAzska7c5yhGLsvQQjpNKKkeDQabu1VqdJVCmTszPYLhqcFP+8YwSF+uej
	o8B2IuaVpu+AEkAF6DDTujfaiGlUFdVyINhuVpySPhyKVbh7cp5ICRBq2jLURqNpQRI9Ri
	shydik66g4ahOLvRXMZrLF//IW0lS0TGk+ohAaBjZePgn113x2ZtH5f5nFAzGQ==
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v3 1/2] doc: sfp-phylink: update the porting guide with PCS handling
Date: Fri,  1 Mar 2024 17:43:07 +0100
Message-ID: <20240301164309.3643849-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
References: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Now that phylink has a comprehensive PCS support, update the porting
guide to explain the process of supporting the PCS configuration. This
also removed outdated references to phylink_config fields that no longer
exists.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: Remove stray whitespace and wrap a long line
V2: Squash both V1 patches together to create this one.

 Documentation/networking/sfp-phylink.rst | 147 ++++++++++++++++++++---
 1 file changed, 133 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/sfp-phylink.rst b/Documentation/networking/sfp-phylink.rst
index 8054d33f449f..5bf285d73e8a 100644
--- a/Documentation/networking/sfp-phylink.rst
+++ b/Documentation/networking/sfp-phylink.rst
@@ -231,16 +231,136 @@ this documentation.
    For further information on these methods, please see the inline
    documentation in :c:type:`struct phylink_mac_ops <phylink_mac_ops>`.
 
-9. Remove calls to of_parse_phandle() for the PHY,
-   of_phy_register_fixed_link() for fixed links etc. from the probe
-   function, and replace with:
+9. Fill-in the :c:type:`struct phylink_config <phylink_config>` fields with
+   a reference to the :c:type:`struct device <device>` associated to your
+   :c:type:`struct net_device <net_device>`:
 
    .. code-block:: c
 
-	struct phylink *phylink;
 	priv->phylink_config.dev = &dev.dev;
 	priv->phylink_config.type = PHYLINK_NETDEV;
 
+   Fill-in the various speeds, pause and duplex modes your MAC can handle:
+
+   .. code-block:: c
+
+        priv->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD;
+
+10. Some Ethernet controllers work in pair with a PCS (Physical Coding Sublayer)
+    block, that can handle among other things the encoding/decoding, link
+    establishment detection and autonegotiation. While some MACs have internal
+    PCS whose operation is transparent, some other require dedicated PCS
+    configuration for the link to become functional. In that case, phylink
+    provides a PCS abstraction through :c:type:`struct phylink_pcs <phylink_pcs>`.
+
+    Identify if your driver has one or more internal PCS blocks, and/or if
+    your controller can use an external PCS block that might be internally
+    connected to your controller.
+
+    If your controller doesn't have any internal PCS, you can go to step 11.
+
+    If your Ethernet controller contains one or several PCS blocks, create
+    one :c:type:`struct phylink_pcs <phylink_pcs>` instance per PCS block within
+    your driver's private data structure:
+
+    .. code-block:: c
+
+        struct phylink_pcs pcs;
+
+    Populate the relevant :c:type:`struct phylink_pcs_ops <phylink_pcs_ops>` to
+    configure your PCS. Create a :c:func:`pcs_get_state` function that reports
+    the inband link state, a :c:func:`pcs_config` function to configure your
+    PCS according to phylink-provided parameters, and a :c:func:`pcs_validate`
+    function that report to phylink all accepted configuration parameters for
+    your PCS:
+
+    .. code-block:: c
+
+        struct phylink_pcs_ops foo_pcs_ops = {
+                .pcs_validate = foo_pcs_validate,
+                .pcs_get_state = foo_pcs_get_state,
+                .pcs_config = foo_pcs_config,
+        };
+
+    Arrange for PCS link state interrupts to be forwarded into
+    phylink, via:
+
+    .. code-block:: c
+
+        phylink_pcs_change(pcs, link_is_up);
+
+    where ``link_is_up`` is true if the link is currently up or false
+    otherwise. If a PCS is unable to provide these interrupts, then
+    it should set ``pcs->pcs_poll = true;`` when creating the PCS.
+
+11. If your controller relies on, or accepts the presence of an external PCS
+    controlled through its own driver, add a pointer to a phylink_pcs instance
+    in your driver private data structure:
+
+    .. code-block:: c
+
+        struct phylink_pcs *pcs;
+
+    The way of getting an instance of the actual PCS depends on the platform,
+    some PCS sit on an MDIO bus and are grabbed by passing a pointer to the
+    corresponding :c:type:`struct mii_bus <mii_bus>` and the PCS's address on
+    that bus. In this example, we assume the controller attaches to a Lynx PCS
+    instance:
+
+    .. code-block:: c
+
+        priv->pcs = lynx_pcs_create_mdiodev(bus, 0);
+
+    Some PCS can be recovered based on firmware information:
+
+    .. code-block:: c
+
+        priv->pcs = lynx_pcs_create_fwnode(of_fwnode_handle(node));
+
+12. Populate the :c:func:`mac_select_pcs` callback and add it to your
+    :c:type:`struct phylink_mac_ops <phylink_mac_ops>` set of ops. This function
+    must return a pointer to the relevant :c:type:`struct phylink_pcs <phylink_pcs>`
+    that will be used for the requested link configuration:
+
+    .. code-block:: c
+
+        static struct phylink_pcs *foo_select_pcs(struct phylink_config *config,
+                                                  phy_interface_t interface)
+        {
+                struct foo_priv *priv = container_of(config, struct foo_priv,
+                                                     phylink_config);
+
+                if ( /* 'interface' needs a PCS to function */ )
+                        return priv->pcs;
+
+                return NULL;
+        }
+
+    See :c:func:`mvpp2_select_pcs` for an example of a driver that has multiple
+    internal PCS.
+
+13. Fill-in all the :c:type:`phy_interface_t <phy_interface_t>` (i.e. all MAC to
+    PHY link modes) that your MAC can output. The following example shows a
+    configuration for a MAC that can handle all RGMII modes, SGMII and 1000BaseX.
+    You must adjust these according to what your MAC and all PCS associated
+    with this MAC are capable of, and not just the interface you wish to use:
+
+    .. code-block:: c
+
+       phy_interface_set_rgmii(priv->phylink_config.supported_interfaces);
+        __set_bit(PHY_INTERFACE_MODE_SGMII,
+                  priv->phylink_config.supported_interfaces);
+        __set_bit(PHY_INTERFACE_MODE_1000BASEX,
+                  priv->phylink_config.supported_interfaces);
+
+14. Remove calls to of_parse_phandle() for the PHY,
+    of_phy_register_fixed_link() for fixed links etc. from the probe
+    function, and replace with:
+
+    .. code-block:: c
+
+	struct phylink *phylink;
+
 	phylink = phylink_create(&priv->phylink_config, node, phy_mode, &phylink_ops);
 	if (IS_ERR(phylink)) {
 		err = PTR_ERR(phylink);
@@ -249,14 +369,14 @@ this documentation.
 
 	priv->phylink = phylink;
 
-   and arrange to destroy the phylink in the probe failure path as
-   appropriate and the removal path too by calling:
+    and arrange to destroy the phylink in the probe failure path as
+    appropriate and the removal path too by calling:
 
-   .. code-block:: c
+    .. code-block:: c
 
 	phylink_destroy(priv->phylink);
 
-10. Arrange for MAC link state interrupts to be forwarded into
+15. Arrange for MAC link state interrupts to be forwarded into
     phylink, via:
 
     .. code-block:: c
@@ -264,17 +384,16 @@ this documentation.
 	phylink_mac_change(priv->phylink, link_is_up);
 
     where ``link_is_up`` is true if the link is currently up or false
-    otherwise. If a MAC is unable to provide these interrupts, then
-    it should set ``priv->phylink_config.pcs_poll = true;`` in step 9.
+    otherwise.
 
-11. Verify that the driver does not call::
+16. Verify that the driver does not call::
 
 	netif_carrier_on()
 	netif_carrier_off()
 
-   as these will interfere with phylink's tracking of the link state,
-   and cause phylink to omit calls via the :c:func:`mac_link_up` and
-   :c:func:`mac_link_down` methods.
+    as these will interfere with phylink's tracking of the link state,
+    and cause phylink to omit calls via the :c:func:`mac_link_up` and
+    :c:func:`mac_link_down` methods.
 
 Network drivers should call phylink_stop() and phylink_start() via their
 suspend/resume paths, which ensures that the appropriate
-- 
2.43.2


