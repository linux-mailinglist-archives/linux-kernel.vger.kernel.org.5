Return-Path: <linux-kernel+bounces-73304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F285C0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35E01F247D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2676C8E;
	Tue, 20 Feb 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YKAKuv+o"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85EF763FE;
	Tue, 20 Feb 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445055; cv=none; b=Xy6/WPZjlZ0kjcyfAfUKFXhgpa4uxADQeH4iPUlluKSdIYlD7Ckz1irZjqbh43omrZGN5yWSATexnqWfm/DcR4ytKm1t553A2KHu2ngp7735nBijJXowyah6HwNeYLmfonc02l/Ne9Kf0OjZCibbl4BPsH4KjTx9KVivhk9TVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445055; c=relaxed/simple;
	bh=Wwuqz9ZJr5TQFfwVUHEQzVdrwp0bIBroh6UK8Drtlvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOA0jBnrwyjJyfxwuebvGDoH35/UjPk0gzSPZWIr9gZFl8QyJM4cr8OGYaZa/hiDVya0bcsqMoOOlrg4+YiDBrHPuJLv47brLC8S9C0xwsFGw+fGlg3yyRc0Fx+A7Q/Znabg3Gu/hu+cF3Q3VRKY5CqTkgaM0UxE1AExyhFD/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YKAKuv+o; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 809F3FF811;
	Tue, 20 Feb 2024 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708445051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCS/sZcLThB2p5pcBcwaJElg/lIAc4UxkvYvhKEBitk=;
	b=YKAKuv+oFy32r4yzngvTxz9ZzEgGhWjaUcK7o+FIJMrj1YXCyIlyS3m0P+F75guQjxERxx
	5GN8UifikXPh6osJXnzA3KPoBnnxAc2c4MvF60T4hJekHW2LnOtArroVxgAzjFICjCMx+t
	2tlkYeY7ytuSl/nYtQDRS7cK1w8tFu02pelhyC0L+GEX3iRTtzxuYqJM48QZl9bvOmM477
	4zsJIkhwm26GwBCimrxKnHt7bgalvcrRv23xIvZ5R88FRQ/zLXpBnbGH7/i+Fde8K8l1yA
	Nlav6FoPXJLcDK88R2hSzJ05ByuZFXBy9D8XZdkvCjBoiUgbZZ4VDAuxRVVBjA==
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
Subject: [PATCH net-next 2/2] doc: sfp-phylink: mention the mac_capabilities and supported_interfaces
Date: Tue, 20 Feb 2024 17:04:04 +0100
Message-ID: <20240220160406.3363002-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
References: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

When porting a driver from bare phylib to phylink, one of the mandatory
steps is to fill-in the phylink_config.mac_capabilities and the
supported_interfaces. Add a dedicated step in the porting guide, with
some examples.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/sfp-phylink.rst | 45 +++++++++++++++++++-----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/sfp-phylink.rst b/Documentation/networking/sfp-phylink.rst
index bc3365bbf096..30b1f2cf997f 100644
--- a/Documentation/networking/sfp-phylink.rst
+++ b/Documentation/networking/sfp-phylink.rst
@@ -231,16 +231,43 @@ this documentation.
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
+   Fill-in all the :c:type:`phy_interface_t <phy_interface_t>` (i.e. all MAC to
+   PHY link modes) that your MAC can output. The following example shows a
+   configuration for a MAC that can handle all RGMII modes, SGMII and 1000BaseX.
+   You must adjust these according to what your MAC is capable of, and not just
+   the interface you wish to use:
+
+   .. code-block:: c
+
+       phy_interface_set_rgmii(priv->phylink_config.supported_interfaces);
+        __set_bit(PHY_INTERFACE_MODE_SGMII,
+                  priv->phylink_config.supported_interfaces);
+        __set_bit(PHY_INTERFACE_MODE_1000BASEX,
+                  priv->phylink_config.supported_interfaces);
+
+10. Remove calls to of_parse_phandle() for the PHY,
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
@@ -249,14 +276,14 @@ this documentation.
 
 	priv->phylink = phylink;
 
-   and arrange to destroy the phylink in the probe failure path as
-   appropriate and the removal path too by calling:
+    and arrange to destroy the phylink in the probe failure path as
+    appropriate and the removal path too by calling:
 
-   .. code-block:: c
+    .. code-block:: c
 
 	phylink_destroy(priv->phylink);
 
-10. Arrange for MAC link state interrupts to be forwarded into
+11. Arrange for MAC link state interrupts to be forwarded into
     phylink, via:
 
     .. code-block:: c
@@ -266,7 +293,7 @@ this documentation.
     where ``link_is_up`` is true if the link is currently up or false
     otherwise.
 
-11. Verify that the driver does not call::
+12. Verify that the driver does not call::
 
 	netif_carrier_on()
 	netif_carrier_off()
-- 
2.43.2


