Return-Path: <linux-kernel+bounces-164765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF268B8290
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748E11F23C37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359231BF6CB;
	Tue, 30 Apr 2024 22:01:36 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2B74E11;
	Tue, 30 Apr 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514495; cv=none; b=kEMWbxzlmEKkk5uP3jALJBZt+gQUgdEW6bNKIQwOgCQCQsLCucL88B+rCi40Doex+az8s+hLNFub5MvBw3Qr8g0swmNi+rkr0tcIw8oGD8zAF8AAv/t9I3SfiwrGc2M19MH9lxXWBVPm1HsZPu080ILUsj4hPtIHfptPsHE0uLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514495; c=relaxed/simple;
	bh=iEt4z79Rp/ekOOktnvu3zl7uib0Zfw+JTHZVZY8sIzc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nrLp/sX76ERJqUJ0MBaAsqMQVIQNijW8czU9VrLOqjhjATDJjYL9FNezFTPLCjPtzoIjGgwofBrcUPQHtMFTWzGuOnT9bYcavF0UiRRoZFQLp79LlFGX7mO3EQwEWkZnEBWI+Bsy189yb9EoAGeqcRS9DVhMESKpW2fb3bofxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s1vXQ-0000000019H-1CUZ;
	Tue, 30 Apr 2024 22:01:24 +0000
Date: Tue, 30 Apr 2024 23:01:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net v2] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org>
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
switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
switch is wrongly stated in the device tree as 0 (while in reality it is
31), warn the user about such broken device tree and make a good guess
what was actually intended.

This is imporant also to not break compatibility with older device trees
as with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
switch from device tree") the address in device tree will be taken into
account.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Changes since v1:
 - use FW_WARN as suggested.
 - fix build on net tree which doesn't have 'mdiodev' as member of the
   priv struct. Imho including this patch as fix makes sense to warn
   users about broken firmware, even if the change introducing the
   actual breakage is only present in net-next for now.

 drivers/net/dsa/mt7530-mdio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index fa3ee85a99c1..3c21c8d074c7 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -193,6 +193,19 @@ mt7530_probe(struct mdio_device *mdiodev)
 			return PTR_ERR(priv->io_pwr);
 	}
 
+	/* Only MDIO bus address 7, 15, 23 and 31 are valid options */
+	if (~(mdiodev->addr & 0x7) & 0x7) {
+		/* If the address in DT must be wrong, make a good guess about
+		 * the most likely intention, and issue a warning.
+		 */
+		int correct_addr = ((((mdiodev->addr - 7) & ~0x7) % 0x20) + 7) & 0x1f;
+
+		dev_warn(&mdiodev->dev, FW_WARN
+			 "impossible switch MDIO address in device tree: %d, assuming %d\n",
+			 mdiodev->addr, correct_addr);
+		mdiodev->addr = correct_addr;
+	}
+
 	regmap_config = devm_kzalloc(&mdiodev->dev, sizeof(*regmap_config),
 				     GFP_KERNEL);
 	if (!regmap_config)
-- 
2.44.0


