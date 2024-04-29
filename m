Return-Path: <linux-kernel+bounces-163170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7948B66B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BA51F232A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E911870;
	Tue, 30 Apr 2024 00:03:07 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B91623;
	Tue, 30 Apr 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435386; cv=none; b=VGdAZRpTEcOdi2YV9wolqn4+iaHvJM5II0wmUZ1H5UJmLdE6qY88of7W3HpB1/c90J03owmi3wuLfgCMWpn/oi2EDbsurUXD5BYj6p4UCc14sD2PM7zbRKXNrmDlCIA6FZyl+WTbKdqicj61DEdccYMqSdxGItw3W2kFguYg3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435386; c=relaxed/simple;
	bh=OAALAvGgj2+eNeT14GTmZ9nctNzxrwyvFnOi6pdmdv0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UPhSpWWmObfMAt2dC+FF7c1mEpk37QCoVuVAOhui4+OwK0a8yXB8fH57UWTRsTsietFQZ9j1S/llGepm+Wszd6XVZE8k9Qb73thg0iNDOYNXUtyft2aexKKz02I1Rek5fWASMj7xAom+yHGPZ5WRdF4MBPiWE5XHwvAUFEs2yls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s1ah2-000000003Ss-0jtq;
	Mon, 29 Apr 2024 23:45:56 +0000
Date: Tue, 30 Apr 2024 00:45:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: dsa: mt7530: fix impossible MDIO address and issue
 warning
Message-ID: <e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MDIO address of the MT7530 and MT7531 switch ICs can be configured
using bootstrap pins. However, there are only 4 possible options for the
switch itself: 7, 15, 23 and 31 (ie. only 3 and 4 can be configured, bit
0~2 are always 111). Practically all boards known as of today use the
default setting which is to have the switch respond to address 31, while
the built-in switch PHYs respond to address 0~4 in this case.

However, even in MediaTek's SDK the address of the switch is wrongly
stated in the device trees as 0 (while in reality it is 31), so warn the
user about such broken device tree and make a good guess what was
actually intended.

This is imporant to not break compatibility with older Device Trees as
with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
switch from device tree") the address in device tree will be taken into
account. Doing so instead of assuming the switch is always at
address 31 which was previously hard-coded will obviously break things
for many existing downstream device trees as they contain the wrong
address (0) which previously didn't matter.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530-mdio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index fa3ee85a99c1..119630fd9060 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -193,6 +193,19 @@ mt7530_probe(struct mdio_device *mdiodev)
 			return PTR_ERR(priv->io_pwr);
 	}
 
+	/* Only MDIO bus address 7, 15, 23 and 31 are valid options */
+	if (~(priv->mdiodev->addr & 0x7) & 0x7) {
+		/* If the address in DT must be wrong, make a good guess about
+		 * the most likely intention, and issue a warning.
+		 */
+		int correct_addr = ((((priv->mdiodev->addr - 7) & ~0x7) % 0x20) + 7) & 0x1f;
+
+		dev_warn(&mdiodev->dev,
+			 "impossible switch MDIO address in device tree: %d, assuming %d\n",
+			 priv->mdiodev->addr, correct_addr);
+		priv->mdiodev->addr = correct_addr;
+	}
+
 	regmap_config = devm_kzalloc(&mdiodev->dev, sizeof(*regmap_config),
 				     GFP_KERNEL);
 	if (!regmap_config)
-- 
2.44.0


