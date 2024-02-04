Return-Path: <linux-kernel+bounces-51789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F9848F52
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C3C1C20F67
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067AE24A13;
	Sun,  4 Feb 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4XWEv9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061822EED;
	Sun,  4 Feb 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064492; cv=none; b=DAWBJ26sPPWAycc2pSTtbwXfh1r7cw4sk4C/39EX6O+0LgvFxe2a/JVp/tWYVJHat/f6F8LMoql5MJUhnfXBYVU6who/UwPVWh7h2gANHjqm/qQjCsBNCsrWu1fqTlN4FLbjiaDZiqsdqvtZn+A8eLe7IFdd54WzsoVY7cPVagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064492; c=relaxed/simple;
	bh=gCTjOmGx5pGl0G5a7sL2z7Qg9JsndGNEKXKQGIQ0/sY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGWq725AH8+roe1jAK7pGjIF5iMZgsbu3JsLQG5xvhwA6DGP4EBJIZZuaj4QvcjWIUSL8eGBfLPmr4wIdOSbaLsfThOShHnQB5U3gQJbfcHAFenaGb+qI+uhkWUDK6CJcUAUho/eEFQ1709lK21RzdT2Hifdu8orWka91Smjo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4XWEv9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D18CCC43399;
	Sun,  4 Feb 2024 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707064491;
	bh=gCTjOmGx5pGl0G5a7sL2z7Qg9JsndGNEKXKQGIQ0/sY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O4XWEv9rPgKRAKWn9akrJ6719oXcv0NOsFk6VI3Llcjb0Dm6lexRvBnkR23jsbh0W
	 ZwVbE75RnobUNW/B6fN5beQCcQTLqpoOSich3BsbxyFCvljLFjMeAruJUaSmXkBwsz
	 2sHsipcsvIVOWibY1u+mXTEQoyHWxGv8j/IcK/JPzX0aexUjbYQiX242GNS70gFBNq
	 8lvx7Ne84GyEAYo0OgOKTlpYABcbcuVZtYuejRQsbU0C2Q6Nc5rTx1KJSYZK33VIJ3
	 tKCAlO1gtkEBA0xpn5cES1wkJaFwa40n3sLdAJTO4TM4qAOCO7yvtzhvCL7wcR6R2w
	 Zq9RACEs+xb4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E82C48286;
	Sun,  4 Feb 2024 16:34:51 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 04 Feb 2024 19:34:20 +0300
Subject: [PATCH net-next v4 2/7] net: dsa: mt7530: move XTAL check to
 mt7530_setup()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240204-for-netnext-mt7530-improvements-2-v4-2-02bf0abaadb8@arinc9.com>
References:
 <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
In-Reply-To:
 <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707064489; l=1502;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=ePoF9S9AkB1Nueho21W+SYCjoATeOUbmBAR9kyDI6f0=;
 b=QR1Av9Y32TpeWpNcfORn1FkMb6gOD5gFwLEb1uT1Dq1CnJD3HCun+9vWQy/co/f+GS3Hu3eFv
 pGExVz+F+xjAp2Zh700g9wh/iPcq3E3xob3++3usWknQ1iSbWf7EI46
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The crystal frequency concerns the switch core. The frequency should be
checked when the switch is being set up so the driver can reject the
unsupported hardware earlier and without requiring port 6 to be used.

Move it to mt7530_setup(). Drop the unnecessary function printing.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/mt7530.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 330e22abc076..8b8469eba863 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -422,13 +422,6 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 
 	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
 
-	if (xtal == HWTRAP_XTAL_20MHZ) {
-		dev_err(priv->dev,
-			"%s: MT7530 with a 20MHz XTAL is not supported!\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	switch (interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		trgint = 0;
@@ -2259,6 +2252,12 @@ mt7530_setup(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
+	if ((val & HWTRAP_XTAL_MASK) == HWTRAP_XTAL_20MHZ) {
+		dev_err(priv->dev,
+			"MT7530 with a 20MHz XTAL is not supported!\n");
+		return -EINVAL;
+	}
+
 	/* Reset the switch through internal reset */
 	mt7530_write(priv, MT7530_SYS_CTRL,
 		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |

-- 
2.40.1


