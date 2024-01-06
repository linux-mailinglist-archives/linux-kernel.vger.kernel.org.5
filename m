Return-Path: <linux-kernel+bounces-18567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88F825F75
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506011F233A2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82917464;
	Sat,  6 Jan 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="PhqQ3SZj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCA6FAE;
	Sat,  6 Jan 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70DF51C0003;
	Sat,  6 Jan 2024 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704543717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wclBdaQwx0VWFvKu4VoqvC+iQra+xtdmJ+ZOn9PX+n4=;
	b=PhqQ3SZjIgsHbd0hOa/hPVqCr/K0dFR21qHuXLzoizW1VeDyNsIRYiFI60GCY3WrfglPpz
	g12WWUepT+uTlWkgU+rrnWdwvvCUM9tigs7S9DIfqKNgvlQT/lBAQ6lRf79Yrj2xqz7Uy0
	ze2rJNIb3/AHKHNpp7KI6DPbsMR0HirvSUzBY6xR6lLXRcM6Nv1qHY80MAJp4KRyNJVmAU
	YyyX3LUhb28vybCNI/gD0+odZcEXcQl3V0+0/LwQTo7NfHCxkrsuHtpf043NNj13p0PART
	/ry4pON+HwXnBPyTIftBmQ91quBW71onIMsv/x4DyWfecGZXUWZJOC7pKZ5Q5w==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: David Bauer <mail@david-bauer.net>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: dsa: mt7530: support OF-based registration of switch MDIO bus
Date: Sat,  6 Jan 2024 15:21:42 +0300
Message-Id: <20240106122142.235389-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

From: David Bauer <mail@david-bauer.net>

Currently the MDIO bus of the switches the MT7530 DSA subdriver controls
can only be registered as non-OF-based. Bring support for registering the
bus OF-based.

The subdrivers that control switches [with MDIO bus] probed on OF must
follow this logic to support all cases properly:

No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if "interrupt-controller" is defined at
the switch node. This case should only be covered for the switches which
their dt-bindings documentation didn't document the MDIO bus from the
start. This is to keep supporting the device trees that do not describe the
MDIO bus on the device tree but the MDIO bus is being used nonetheless.

Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
the switch node and "interrupts" is defined at the PHY nodes under the
switch MDIO bus node].

Switch MDIO bus defined but explicitly disabled: If the device tree says
status = "disabled" for the MDIO bus, we shouldn't need an MDIO bus at all.
Instead, just exit as early as possible and do not call any MDIO API.

The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
switch is described on the device tree [1], which is why we don't populate
ds->user_mii_bus in that case.

Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
Suggested-by: David Bauer <mail@david-bauer.net>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..39d7e7ad7154 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2153,17 +2153,25 @@ mt7530_free_irq(struct mt7530_priv *priv)
 static int
 mt7530_setup_mdio(struct mt7530_priv *priv)
 {
+	struct device_node *mnp, *np = priv->dev->of_node;
 	struct dsa_switch *ds = priv->ds;
 	struct device *dev = priv->dev;
 	struct mii_bus *bus;
 	static int idx;
-	int ret;
+	int ret = 0;
+
+	mnp = of_get_child_by_name(np, "mdio");
+
+	if (mnp && !of_device_is_available(mnp))
+		goto out;
 
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus)
 		return -ENOMEM;
 
-	ds->user_mii_bus = bus;
+	if (!mnp)
+		ds->user_mii_bus = bus;
+
 	bus->priv = priv;
 	bus->name = KBUILD_MODNAME "-mii";
 	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
@@ -2174,16 +2182,18 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	bus->parent = dev;
 	bus->phy_mask = ~ds->phys_mii_mask;
 
-	if (priv->irq)
+	if (priv->irq && !mnp)
 		mt7530_setup_mdio_irq(priv);
 
-	ret = devm_mdiobus_register(dev, bus);
+	ret = devm_of_mdiobus_register(dev, bus, mnp);
+	of_node_put(mnp);
 	if (ret) {
 		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
 		if (priv->irq)
 			mt7530_free_mdio_irq(priv);
 	}
 
+out:
 	return ret;
 }
 
-- 
2.40.1


