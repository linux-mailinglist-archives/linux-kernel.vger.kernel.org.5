Return-Path: <linux-kernel+bounces-44827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72208427E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2BB1F25BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC3D86AE1;
	Tue, 30 Jan 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1T1xXnu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D7823A7;
	Tue, 30 Jan 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628057; cv=none; b=qhaC8A5reUIOYa6xVhrfFeXdeCz4xq8YS1ze8piH68xutmvLS6av/Jjg161h/68ARcQLy9+C5rZdufBWI8Qlm9vC21iAnGZSTulQ3r1E3x9Mx4+YdoC2W/iBjd57S5I3ioDVC+wQxoHcrh25GCjS0FO4Wp3aFdylMG2JW4TYK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628057; c=relaxed/simple;
	bh=msQVr9s6HrHM8DrJhHCwrIGkygPIMMpIFB46gjE9M7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlNSD2OeVGhwaaVrMNqGiaDe5jbrjovPxiQvkwjZRImHhWNA+K6qlVP+3Qh1CM4ON+HFMIpOW+EkCv/VZ8fhWPrmce5Wn4stz8R4yy2Dr7enNUSuupE8CYdZm9tpDJ9UsZtONGhqrQUcOJlPiMvxTKpanyPV/z6dFpn742sYvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1T1xXnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6E4CC32784;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628056;
	bh=msQVr9s6HrHM8DrJhHCwrIGkygPIMMpIFB46gjE9M7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f1T1xXnuyntf6lbjXWmD3EfOcH8jNnOj8RKAZpmq7UgywGXy55t5iCvdoQ6ey6vY/
	 WGslurVgvvN72SIiXDj1x/UWEEHCkmGoEQACKU18OEX+2wL8e8HTe+QmYlmukURXMb
	 ScEbKc44Rkp3m1u5Tc2JtSO0SOF5j28Kwk3iZA8rlgO8+QnZ0WEtRUMu1MvTJOUFhB
	 HxTnJi4lrw3NlWWEsciwiPeYItBorKXzsFJzt8uv1J1TpZQdTj8slkDc+W4vG6F+ng
	 Nur2HDvdCljIBIbPr+Vo2xJvn9Tv0MS8qZ/7SzyFKElU/cY4zbtR7rS0xQanEVyvaJ
	 LTJ/3AzVWMVCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C589AC4828C;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 30 Jan 2024 18:20:52 +0300
Subject: [PATCH net-next v2 6/7] net: dsa: mt7530: correct port
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
 <20240130-for-netnext-mt7530-improvements-2-v2-6-ba06f5dd9eb0@arinc9.com>
References:
 <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
In-Reply-To:
 <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706628055; l=1084;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=qgwVD3oCKv9eQ/3EPjjXtTaWHDhG5bpqRvc5PpGf3Uo=;
 b=K7aHXOw0xi1WQgkCS+NjcDvUcJ0R9W8AM7wckWoXDNIHYTBW7O+nQEi4iDULhCZxa663+isa4
 nNmjq64fz3KDUdT2HgEIrYFNX6K72quW8PjaEya2/J/cIeXB1puHtBG
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
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 36dc2bbcf3b6..638cd3f2a495 100644
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


