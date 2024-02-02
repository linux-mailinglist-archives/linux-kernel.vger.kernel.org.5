Return-Path: <linux-kernel+bounces-49551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41B846BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3B41C21D71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAC7CF0D;
	Fri,  2 Feb 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ8DzsSo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81277650;
	Fri,  2 Feb 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865573; cv=none; b=dEmwpbYfO0CRbHJWx2fA8l24AzPI3O2ohBYjAcBwNGYBmNYG9+aam9oAlfpVy+RaJYy9cpSmR64H01F9USEWvkzS0V67VuFcURlUvyF6m3HMR73vz9SKKIQGfivELSHdoxbSgJ6W3o6mcgpM0TKlwuCBXbwgnW1KdhLlCu/KJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865573; c=relaxed/simple;
	bh=EDH94Q0fIzWZXO02/75AuI4ovyw/xgjFBUiWt170Fhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYbvZYY6/H2OE9+z2hd4Pym6ZakzznElcgF25lIlxtTgRKx3aOjNWz6ZgTMxUVwoPx+lmjvuaP98so5St/0+Bl55zjk64oGN2qn3G9U/j0VdKvb0cLmFkXsCfEGYviynJjH1LI3uLJHgSnSHX9ta1XzEQxVeuhoqr6rLaMx7HRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ8DzsSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0733DC43142;
	Fri,  2 Feb 2024 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706865573;
	bh=EDH94Q0fIzWZXO02/75AuI4ovyw/xgjFBUiWt170Fhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JQ8DzsSoXrZ4Lu8j9qD6TNpDEOTIhF+Tn8uCdvnD84m1zm0dg9lcBjCtPyPJ7PCaT
	 0Hdt3Q4L32rouOz0Ty7pfep19IeQBjRC5oY5aCszCSkYhFTlSTPKk1V2Wr7FLRMTtM
	 qYzuDe+UJY9w4LVn797Qj+cU1COpWkvRHVxvIb8w7cI0LApsyXgdgcAoGLSFGhTphg
	 RikOWTsGtPwxAvUUO5k79nQaOIZzqkAUe+odiXuZ2QhMPZNShNaiSSz37+3tiUgs9R
	 PtYkKh99zxXNFlbcRkPEP951R6yN0eL3UzWYYC5D4wqELShisMj3dc7MXEVqc+OfA6
	 RkgvIahXeEaWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1BEC48294;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 02 Feb 2024 12:19:12 +0300
Subject: [PATCH net-next v3 6/7] net: dsa: mt7530: correct port
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
 <20240202-for-netnext-mt7530-improvements-2-v3-6-63d5adae99ca@arinc9.com>
References:
 <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
In-Reply-To:
 <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706865569; l=1134;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=C+eRNzRMDtIba7vQLCEXXq4gYtY07Q6DrrKE/vhW8K8=;
 b=lNLVoRsMxDJZyiW6dmWXjSwLM7Gjg30vtnnsuEDfzBR2RLoRy8mx3yKz0TAFr0rzRug4RBdz7
 WydiIk7K0/ODghokoz9QPeZrSgr2vxqcF/DAd88ZwytJRfuxJtcLfcO
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


