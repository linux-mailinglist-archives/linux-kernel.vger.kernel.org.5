Return-Path: <linux-kernel+bounces-32336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19B835A60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE08A1C21A75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2817570;
	Mon, 22 Jan 2024 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd/8p3Bs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F8525D;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901759; cv=none; b=f0IjVHGMu3JjPlpLZn+yZ9B2jwG49pad9AW80wmoEm+CqTTw0XcjmSGyXtcw+qYrWpHXehnPQhI6etkWRynXlLRkBvVC21+AHhnL5WnYbPrkT224X7B+FtouZbcpfr8osoNA9u5+vR1g1oolsq+DNQNCZvqpoGdoyFo+npJ3L0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901759; c=relaxed/simple;
	bh=atNAIQUZ9YchgrXFgHv6eKt+am7CBizMAbohfqxIWvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vvkr17xGqZB86AxXHvVOCe9OKZQcMy375OWPJeg7WkTxrLp2nGtTVKUFVvU+uzGADrSPYgXOQ9cSV2D+wmFC8ixh9GPGTATTgU5JWptDix9G9KTMUqhA8PEaZ5DGuhC6Rn9Y8F1RadgWd3ujYY93gm0RT3bWEDn2jfuD+9PLwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd/8p3Bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DBEDC43601;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705901758;
	bh=atNAIQUZ9YchgrXFgHv6eKt+am7CBizMAbohfqxIWvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gd/8p3Bs5oRANr3GBaOqROJ4MBiNKAO5bD1N3KQXoR2kEsqTMCA0Xhr6YFU6HosbI
	 C4o/XMGdc0dV0yYRXWI81O/ys55rk561DWuy8gGbMW+VDocHXo5eJlriBExRbzsaOM
	 bnf0iG88lGu5OMAsdJ32YKLWlzHnGohUyLT5ZU8RxOKIWtMLe/pDsSMsgTTQ6uA1TC
	 PXD3F/6v0KAn90FILcSmXTKq5AHgzhUUmP9u0Fx5SzIyXFyfRvD67/Ki+HFmHjw7yv
	 5yhGbZm7hyOdjZmN51eCUDe/ZzbME8DkIF254NWIpioJhQcP7ixVeH+wAXNgILGJYS
	 Y/zDr7GQRlDBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE3C47DD3;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Jan 2024 08:35:57 +0300
Subject: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
References:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
In-Reply-To:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705901755; l=1273;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=pshHxjZuMebpMx/Gh2fbwscWV4LBFxm7gD/pRSkDjUU=;
 b=3QO+m8i9+Ps4LZGshnpqcBCo9aNWs7CYTLbXp9XfvHkLogRSHjRTuKQahhjiOlLAM+EezZlll
 M7WXEkoq3q3AJBtDqaVD4ZqTNnAsgH2y6/N04iZ6+sNliD5XWQrHn3Z
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Running mt7530_setup_port5() from mt7530_setup() used to handle all cases
of configuring port 5, including phylink.

Setting priv->p5_interface under mt7530_setup_port5() makes sure that
mt7530_setup_port5() from mt753x_phylink_mac_config() won't run.

The commit ("net: dsa: mt7530: improve code path for setting up port 5")
makes so that mt7530_setup_port5() from mt7530_setup() runs only on
non-phylink cases.

Get rid of unnecessarily setting priv->p5_interface under
mt7530_setup_port5() as port 5 phylink configuration will be done by
running mt7530_setup_port5() from mt753x_phylink_mac_config() now.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 33c15f10de34..5394d8c6a40e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -978,8 +978,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, intf_sel=%s, phy-mode=%s\n",
 		val, p5_intf_modes(priv->p5_intf_sel), phy_modes(interface));
 
-	priv->p5_interface = interface;
-
 unlock_exit:
 	mutex_unlock(&priv->reg_mutex);
 }

-- 
2.40.1


