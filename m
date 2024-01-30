Return-Path: <linux-kernel+bounces-44825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C18427E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA2F28893E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10486ACB;
	Tue, 30 Jan 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUMdtXLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0C811E0;
	Tue, 30 Jan 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628057; cv=none; b=UwtSKguknxAqMot+rBfD2vTn+385Oo/vgYI8V/lqPrOpLHhOdPKpmoV1s/DnMNF552xW8fcL76x2wXwT4a4ecvGzQlDoxDEYtcihQeZHnIy1YZkH0zp4/15CWxJYdk9jBk5hrhBj8ZTYw4zLxYChQpIHNgZkQcC5q5mwc2ua8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628057; c=relaxed/simple;
	bh=Mbj/3lKU288Yv0v6r0IvbWbLwZTL+8ODP93iUqv62yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUlfC7QU19k/7U/kne3hMCA0qCr7k7Y2xtcT6Q4jQe87V6VmhTVV9fGOZ+kmTAuTfP0Z6xUYt1pw038SaYwjHc+7Zr4x3p8odug2sgfGAdVyfaQ/5KYdqjrWIJHqMFHTiKb36dde5olqUPWpA7QT6Ea2qQkSc0gpDPEwLVPtZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUMdtXLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBB34C4160E;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628056;
	bh=Mbj/3lKU288Yv0v6r0IvbWbLwZTL+8ODP93iUqv62yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dUMdtXLXwcgJDUAL8o700Zv2Bps/BPuM6b6c8Pw4hjO442Ry4qx0fRJ9CtQRnWSab
	 LundywQYM/CbtWGrVdtp5v3n+NJXbx7CuiYcb+Y7eC+3Y8wzTlgkW6/zKyPBE6oxpz
	 rakjATlBC5wYWJq9gM68rvVloJbt4Q5/SQyR82aaOs1bKIpNDW7a3wa3BF0X5sqy4f
	 iuNf9oq4eV+Qdw1kuaLUqwZvcAXVkVwgLULti0zd+ce4vwKDQ5Mv2pxBLZD/Bzu+Do
	 qhQSKvtMBnenKzUdJT+wRsO8hWaLeg4DY4s97G5upZEnaglbCMUeC/0UunB+ywij6Q
	 q7FR1819xP6pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63BCC47DDB;
	Tue, 30 Jan 2024 15:20:56 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 30 Jan 2024 18:20:50 +0300
Subject: [PATCH net-next v2 4/7] net: dsa: mt7530: move XTAL check to
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
 <20240130-for-netnext-mt7530-improvements-2-v2-4-ba06f5dd9eb0@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706628055; l=1500;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=tzbZi99DdeWCfP5IhTMb0r535zllNsHp9+oBk2Ev3sU=;
 b=81QB74To1EFcaLgCDUbcIeaODB1dUD926yB8SpRil+0D/Hk4Ol1AtOwVpzoojnmOpaIqVBemQ
 mWxTU3DRefkBe1gQyhp8zmj4GpO0vZXLByEsNmEJ2APJ83pOZbLyNfZ
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
index fdaf65b58b72..c4d492e29fdf 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -422,13 +422,6 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 
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
@@ -2253,6 +2246,12 @@ mt7530_setup(struct dsa_switch *ds)
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


