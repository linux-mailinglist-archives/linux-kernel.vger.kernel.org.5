Return-Path: <linux-kernel+bounces-152855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A18AC546
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8312B1F20EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788457301;
	Mon, 22 Apr 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSsmTj7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D14F5FB;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=KDNxU1g523X1b1f+eG5xbx0wCGsdTWI01x6KD9ZRH9BBtNcSVAr66RorhM0rUHXTGA4c29B/HumAzVY6DIdnORNffPxSnsxSwmDrbjTssazH9PHoV+W1oOZLEqy3rLz6ibpPOcbt5eVv/yBrwlGUupZnb0W3HSJnIM2j5srQoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=PmeAMYPZ9FxzUW5GiKbK62DPOkBKTTIRFefQeWGqI48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3gzh8WZ1gv4Izedgel2y3jvkIv7PXGqBdX79USt5uBrWuGREi1WCXzXcoLvwM0OS3Vgep7ZXV91K9d3wR2ZEBR6ShsoJgpsq4QRzZDb0n+IH9V2aaPOlsIw45H9HHkPdpgoMItZM3HhrVGZswveCkeYjA+wABMh/ndrmv+pq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSsmTj7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B6DCC4AF5F;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770131;
	bh=PmeAMYPZ9FxzUW5GiKbK62DPOkBKTTIRFefQeWGqI48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WSsmTj7/BFmSBKk+MIr5vBMqLM1UJs9iG9nfg5KdPgaAa2IqPWSAnux4rmop2SUQx
	 mbI6gkOkb/OarXGqoMtYjvepAHj4k3N+a/thjJHgRK8FbJIlNf+9VBELFgZsrmmE0a
	 SAB4bOi/zk4h1LwjeVxKbU9SJSOznmvLT2u4CsGB025g9zQjohrp8M3oEZSvbpiu91
	 cPQ68d5B4ASkZvm7xIzxPQYBptkBX+7j3SZRP41KvJOIRSCIx6nhDDN65/mEm+iPuL
	 8Gn6y8T/03O3QXuNxxej15krNFX7lE2WmIn7wHonmQhLkjSFKSk51lYJo98p0Jwkya
	 TPbfDH1oERMCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501AFC07E8F;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:21 +0300
Subject: [PATCH net-next v2 14/15] net: dsa: mt7530: do not pass port
 variable to mt7531_rgmii_setup()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-14-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=1111;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=Q1j4jaCBiZXdXWGCY6tFpliJwSXL75dq4VnMljuW2Zw=;
 b=4edWHZvzNJRTxMTUE0wiBeIEW7Iu4gYhfzaEG4rSVBrQN4GpNEFRAkN0qFdg0HmYp8vS7lSnt
 a/JDc1cAa1ODoctBTyvB6iFiv1Ld2Sv5i5/ytpRPb3P/IaNP9ia9DRL
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The mt7531_rgmii_setup() function does not use the port variable, do not
pass the variable to it.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 55954a165a15..1f6cd24de4b7 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2785,7 +2785,7 @@ mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		mt7530_setup_port6(priv->ds, interface);
 }
 
-static void mt7531_rgmii_setup(struct mt7530_priv *priv, u32 port,
+static void mt7531_rgmii_setup(struct mt7530_priv *priv,
 			       phy_interface_t interface,
 			       struct phy_device *phydev)
 {
@@ -2836,7 +2836,7 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	if (phy_interface_mode_is_rgmii(interface)) {
 		dp = dsa_to_port(ds, port);
 		phydev = dp->user->phydev;
-		mt7531_rgmii_setup(priv, port, interface, phydev);
+		mt7531_rgmii_setup(priv, interface, phydev);
 	}
 }
 

-- 
2.40.1



