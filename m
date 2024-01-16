Return-Path: <linux-kernel+bounces-28016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664C82F920
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B31F262BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA928E36;
	Tue, 16 Jan 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYHgL7jV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCD13F008;
	Tue, 16 Jan 2024 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434845; cv=none; b=c84qmiVaQ4aNx1ZcGBCx9Sa/IsOg80G4gwmtX10wj+zPnZsn2+jdxLLpdMQoEXbXkQMoKgAJJZxqfl9ieIY+3NWFLQa89utQt4+QxyrrrYSESi/qFJmkSvN/hja+Pc+KP3IjS3Q43lJy2XzQqjDBru9GwrHnv9eqDb25SPVxoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434845; c=relaxed/simple;
	bh=BKifvPs38kQSJmM19rkP5nq0Pl5r7C4sjUM/Citd3M4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=iCF4COXL6pAxo4v0vOOtxSWM3gO39ehCp7i7DahQUZyQP/15WlXyrDnbna2q9AW7XE/EM+tlII4FW2/479uZwaRmC2EC0QBKlkc9BwkZnQaPJCLW7ZnZU62X1GjyZOxYeHa1lGvMu96RsfvDbBv1t8e/pAAJQ+pQAsG4X249KEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYHgL7jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D775C43390;
	Tue, 16 Jan 2024 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434845;
	bh=BKifvPs38kQSJmM19rkP5nq0Pl5r7C4sjUM/Citd3M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYHgL7jVbLJY1Bxd/Hg6m2RaurhLGXGbya1vIdVoMkgg6Bt0PiiPWSnpoIRszmNSf
	 z5+DP7rfzyp1wIKdfraqglU9/Vos1FU0/q+LIK7nmreJt2F/3dV25QdJ/Q+PGGhnjo
	 fA6tPdyxNvUl5EG+Gp/Ej8P07GNUzlDkIeLdxJh9llSTFcIog2kL9tSkeFXh0NEuyO
	 tID0mB/fIRy51AKLA2nweAE84yWuZZZky2pTwswjr/aXAfXm9VEoT8v7Mh3nM+Yhux
	 7jLpU8Brh/N0DnQ1u6AilDZjH8M2ezxNSb5uCTtl6TsKZzw8UdIEuV7vJoNSKsDhL3
	 KdgUjAcU53KRw==
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
Subject: [PATCH AUTOSEL 6.6 104/104] net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure
Date: Tue, 16 Jan 2024 14:47:10 -0500
Message-ID: <20240116194908.253437-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 4ce68e655a63..368d53d3b1d6 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -949,10 +949,15 @@ qca8k_mdio_register(struct qca8k_priv *priv)
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
@@ -962,12 +967,12 @@ qca8k_mdio_register(struct qca8k_priv *priv)
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
@@ -976,7 +981,13 @@ qca8k_mdio_register(struct qca8k_priv *priv)
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


