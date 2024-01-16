Return-Path: <linux-kernel+bounces-28086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB882FA02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7754B1F2627F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F79612C8;
	Tue, 16 Jan 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDeTOeKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39D14E2FE;
	Tue, 16 Jan 2024 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435069; cv=none; b=OWzFThqnt1ibeOsgx7sRLq9BcI10PnYymTA3JXQ7WwiViuGDSCWOA5fKe+Vh/pAZQ9/lY/Q2rrbDp+CyYd328Tq5Mkj1v/TzohmadgdrLBRez2amnUPAHQb9Sh803BQisV2PcsF5F4aEI8nz72EUR6emSyimX5FhEvHXfNC4sME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435069; c=relaxed/simple;
	bh=eqv6DOZmOTFnba1wkWc+t0Qh3zfi1qzVEj8jL7lDmxc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=h1PVAX2BMvSIyjzct9bg48JHQkS9cDt+NaD1VnD/9z1oL3x+oJlkqFalDhajdzBLcWe9w1Gd3daetNSOXO3Z0Kglgn1lGiCQMKXzCXF9mJ+yumbYEQY19/ftY0F4Hx9uEGgG0xr4cf1RA+nwglSasRAbN+foTqtpFZa5m2CE/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDeTOeKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59A4C433C7;
	Tue, 16 Jan 2024 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435068;
	bh=eqv6DOZmOTFnba1wkWc+t0Qh3zfi1qzVEj8jL7lDmxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDeTOeKPhlH4qM/nYlvTJ0ATr6n5Cl6l2xPMAUymA+Fe/rEUQmogf8nuC1oK3jjQI
	 d4RwmvE2Wa6ZCJ1nQnOhSFsPwwXBdiNohQel+By/GxdIm5PRUULqQfWrcbKg4yKr/R
	 harIOu4NUpxD2XixJHMzqHKhp6O4yEG5WOPjXj4CuUl1BovMxK3LCexWt0qFBY33op
	 udL6WnZqb2rHwjzSuG+bwFi4hvPCD+N+46fER/MjMftCNUbeux3wgSEQ1GbKWmxUe+
	 iRJZOl+8ubDJmsAcWR3bGWQiMzKIYJdJv1othG4kBpgtwI7wsgNWpcSlxVLok7xdzG
	 qKNINJPiubXyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	rmk+kernel@armlinux.org.uk,
	kabel@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 68/68] net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure
Date: Tue, 16 Jan 2024 14:54:07 -0500
Message-ID: <20240116195511.255854-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 68e1010cda7967cfca9c8650ee1f4efcae54ab90 ]

of_get_child_by_name() gives us an OF node with an elevated refcount,
which should be dropped when we're done with it. This is so that,
if (of_node_check_flag(node, OF_DYNAMIC)) is true, the node's memory can
eventually be freed.

There are 2 distinct paths to be considered in qca8k_mdio_register():

- devm_of_mdiobus_register() succeeds: since commit 3b73a7b8ec38 ("net:
  mdio_bus: add refcounting for fwnodes to mdiobus"), the MDIO core
  treats this well.

- devm_of_mdiobus_register() or anything up to that point fails: it is
  the duty of the qca8k driver to release the OF node.

This change addresses the second case by making sure that the OF node
reference is not leaked.

The "mdio" node may be NULL, but of_node_put(NULL) is safe.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 1e94ba1031ec..7c3c90c9edbe 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -842,10 +842,15 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	struct dsa_switch *ds = priv->ds;
 	struct device_node *mdio;
 	struct mii_bus *bus;
+	int err;
+
+	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
 
 	bus = devm_mdiobus_alloc(ds->dev);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		err = -ENOMEM;
+		goto out_put_node;
+	}
 
 	bus->priv = (void *)priv;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "qca8k-%d.%d",
@@ -855,12 +860,12 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	ds->slave_mii_bus = bus;
 
 	/* Check if the devicetree declare the port:phy mapping */
-	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (of_device_is_available(mdio)) {
 		bus->name = "qca8k slave mii";
 		bus->read = qca8k_internal_mdio_read;
 		bus->write = qca8k_internal_mdio_write;
-		return devm_of_mdiobus_register(priv->dev, bus, mdio);
+		err = devm_of_mdiobus_register(priv->dev, bus, mdio);
+		goto out_put_node;
 	}
 
 	/* If a mapping can't be found the legacy mapping is used,
@@ -869,7 +874,13 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	bus->name = "qca8k-legacy slave mii";
 	bus->read = qca8k_legacy_mdio_read;
 	bus->write = qca8k_legacy_mdio_write;
-	return devm_mdiobus_register(priv->dev, bus);
+
+	err = devm_mdiobus_register(priv->dev, bus);
+
+out_put_node:
+	of_node_put(mdio);
+
+	return err;
 }
 
 static int
-- 
2.43.0


