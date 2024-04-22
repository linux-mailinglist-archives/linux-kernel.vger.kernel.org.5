Return-Path: <linux-kernel+bounces-152851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC868AC542
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD342822B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645956757;
	Mon, 22 Apr 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqa4gTOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491864E1D5;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=YmGURavwyeTOs5htVwZR2JhnlgvbjBj1xDIlBIm1GPiyVTCAD4C24qazBmPfGmL0dQqDAVWOJ3U6QCIeZ7tU9qtCkdWt1Mzg6Jriya8RsEFsTR+eEQyiaOQwIbtM/4AlqW3riie8h4d+qWnYZVAixjEyk1M5+S7ZP9ItgJmS5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=A/6I8pJ7fmJZa2NSEfrteMXm9y4a13URFTnLtu4q6Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PM0IZ/u7bffeV/c3QVE5pT4bRyap4EgBdN2o+ee79UOFoukgSR2WYDCtiWOwU4K9wkS1ieYW73yjwuVOHxzq6Gv6YyU3FHcvXmd8n+gr7J8XXkE0B0ItI8tCFQo8TGQLLzMY+9p0JRBAZyS8Xt48wC6I1Aj1AzMYN5EgMfrli2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqa4gTOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0836C113CC;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770131;
	bh=A/6I8pJ7fmJZa2NSEfrteMXm9y4a13URFTnLtu4q6Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jqa4gTOQpqUEeVwgzZHNta+79O3jU/ZaS9WHl16exrJwCVJ6pzA9ak3iIxXKS1McF
	 v5QHGA8+km+tOgvo68GFmt7owkXcEdkiK+/7vU7/seedEhRtUFMHnRgXe+PIvy915l
	 QoAsNWPZA2N+iTsBY/EWytzSgbQAC2Rj6m70ANJO3lSb+Baqtog8iVVCOMZSHUdXtK
	 lBYjUPSVn+NRsQleIboFkq3QdsV7c273ztdHX8CO5pgkMMSmQeW6z/0Q/x1dBDCmbK
	 1r7kNUWbJ7VGXU+4NTWBq9rqU5+Yp/hTKOk9sO46j3sgDBAGAz/fENZtGTz08LIshM
	 dZBgNhq8MNMog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D44C04FF6;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:15 +0300
Subject: [PATCH net-next v2 08/15] net: dsa: mt7530: return
 mt7530_setup_mdio & mt7531_setup_common on error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-8-a75157ba76ad@arinc9.com>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=1000;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=dhGaiF9+p4oldvBExDhNwz/DfR5nSajm98YgCgzXa+8=;
 b=lXh6eSrIbOP+xfkdRh30HoWuS5lsawXRQ2YNuwx1j7jFHq7jc5F18YX4FFRxNzE4PvpfHwONc
 abDithSkfs4DgzmXzHuE83I+yde2+7dDX+eZODZcmdij4kDASKiNUGX
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The mt7530_setup_mdio() and mt7531_setup_common() functions should be
checked for errors. Return if the functions return a non-zero value.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 83436723cb16..4e9aa78ca3d0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2667,7 +2667,9 @@ mt7531_setup(struct dsa_switch *ds)
 					 0);
 	}
 
-	mt7531_setup_common(ds);
+	ret = mt7531_setup_common(ds);
+	if (ret)
+		return ret;
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
@@ -3020,6 +3022,8 @@ mt753x_setup(struct dsa_switch *ds)
 	ret = mt7530_setup_mdio(priv);
 	if (ret && priv->irq)
 		mt7530_free_irq_common(priv);
+	if (ret)
+		return ret;
 
 	/* Initialise the PCS devices */
 	for (i = 0; i < priv->ds->num_ports; i++) {

-- 
2.40.1



