Return-Path: <linux-kernel+bounces-54007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC284A911
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F93F1F2AF2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77853E34;
	Mon,  5 Feb 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEsEQtXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230D4F614;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170895; cv=none; b=nxE2tovGaqO6zWJvkAXujDhRDW7C15PLidQm900VTnqFXRDPbOvjhKIYg1TYQj/W8CMYNBonpTDiRXQgq+tBqxB740txBSdEszC1GZ2YWaiUXgYrb14z2WvEMWbjEsOPoUyRqMIkB6UD5ChGpC686+BGkJfl4B4idPYRCXqqdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170895; c=relaxed/simple;
	bh=EDH94Q0fIzWZXO02/75AuI4ovyw/xgjFBUiWt170Fhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rj/UxaSpn07Ej55Zh0JpE04U3/RXGaHXGlOeN+iUdIvWN94pfj1m/4eO3whIpIT8qtM5uiK1CSNxrO2t2mnPM+WO0pucwZ/u31hXumLinxD22BqN63Y5DAFJDh2bSU4gQPXWV6cJ+JZwDsqr5WDom67JHw2hPF0OQb9mTiuWuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEsEQtXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6B5CC43609;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707170894;
	bh=EDH94Q0fIzWZXO02/75AuI4ovyw/xgjFBUiWt170Fhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LEsEQtXmXB1A6U4bZMzmvadrKq8w8I2bDfxVryV2nJEUdT+rxNejTNE8ehVzFBa4y
	 qky5kFBH0SCeZh6bByi6bZcWwg4whZ3v5QKJKS7I0ry8WWhcFM6pNrQkwm9wz7ZUWp
	 6OZgL01ebQNdmB+lwuQTdVjyHf+I1Y6RsGzFFG9vD0xUZDytBsJ2nLn/nK3D/UoHkf
	 2VAycZpSpiuBwmkIyZNAI/iSRvRPwe3fUKWJ6I/R/SzGQjPgnS3Knic9XxGl8/MCEy
	 VInP06fpD/3rNFnxuUbegQ0L2N71AHTHhgyx+H0PWf/KRIrsgX+31yzNuWFOQFxHEQ
	 YFKeHtOLkqkHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314FC4829B;
	Mon,  5 Feb 2024 22:08:14 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 06 Feb 2024 01:08:07 +0300
Subject: [PATCH net-next v5 6/7] net: dsa: mt7530: correct port
 capabilities of MT7988
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240206-for-netnext-mt7530-improvements-2-v5-6-d7d92a185cb1@arinc9.com>
References:
 <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
In-Reply-To:
 <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707170890; l=1134;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=C+eRNzRMDtIba7vQLCEXXq4gYtY07Q6DrrKE/vhW8K8=;
 b=CBzUdwGnzV81mMHvp0tw0tpnea8Sj3PKTF483XOFnrkC5R7NTJvLSwD4byug+hZNA3N0d6xk4
 0ucvCcO7jqEAfWZzPVkb8M5P/Z6rAMqaXyexPhwviw16UJPRsem5009
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

On the switch on the MT7988 SoC, as shown in Block Diagram 8.1.1.3 on page
125 of "MT7988A Wi-Fi 7 Generation Router Platform: Datasheet (Open
Version) v0.1", there are only 4 PHYs. That's port 0 to 3. Set the case for
ports which connect to switch PHYs to '0 ... 3'.

Port 4 and 5 are not used at all in this design.

Link: https://wiki.banana-pi.org/Banana_Pi_BPI-R4#Documents [1]
Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index e1fdef5766fb..4ca7ba94788e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2577,7 +2577,7 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 
 	switch (port) {
 	/* Ports which are connected to switch PHYs. There is no MII pinout. */
-	case 0 ... 4:
+	case 0 ... 3:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;

-- 
2.40.1


