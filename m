Return-Path: <linux-kernel+bounces-88274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C6286DF83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A760B1F23394
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294E26F070;
	Fri,  1 Mar 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSYTX+tw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A446BFA5;
	Fri,  1 Mar 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289779; cv=none; b=r6PGwHTFlsLSC90Z7PsXd+NyEo4VLrxApqYDN6Y+cz6pZDILl0UX7C3BELa1GXCOhhyLLkDCs0ae+ehIuxZyTAaeAZb3LGy+/jekHgmB5P05cb7hPGmroIzHgChSko2aWeC+wz0/+WDL1SL+pxfYPyQ5DmkhspO4hI2hsXZbKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289779; c=relaxed/simple;
	bh=kX85+BHUILFIoP4X6xIr9jJ6kAHMS4KcDN2tshuSuHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxZZf5wKoZYXYgI4GDOfnxc456ZZsl72JJcdR5MgHefPVKZ7VTwynJGzI0JoiCKwfXd+OxwYFu6pWHMnAY7egCqaW9KpZSS1FrgkWX1lAQbPepxes9abaxe65w10m0R7QnZ/sgIsj1Xy63SwhMsrUZCFhKfgqPgN4EXVbXq4Ifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSYTX+tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C25DC43609;
	Fri,  1 Mar 2024 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289779;
	bh=kX85+BHUILFIoP4X6xIr9jJ6kAHMS4KcDN2tshuSuHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uSYTX+twQJfmMJBIippEzWC8M8R2zkbkT8fF/X4cxDCledXVZ3G6FuwEOuj/5m8G4
	 OGagzDS6BsU+CKbEoeQV1CguLIO7Tm7SkfY04qEZOeTXGgo1eUOfERF/AvEIT2vEQf
	 cE2criWG4dS6eMgJlBdHWfG3U0SKeWAxqMJvZBjSX0xFlIzP+T2q0WCjtDSOzk1g43
	 Lhw1zhaFDK4XatcCqJz9W3JBBDR9dcuLecaSFyR8s/vTczL332QqT510V2Oi/Go/UU
	 JcL2pmp4TFfnqhQdUgj406XrAzSHviwVG2aR7uI47gfJhNacvCBIcyMBSTlSuZ1fM5
	 /nafAIahokwJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF0C5475B;
	Fri,  1 Mar 2024 10:42:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 01 Mar 2024 12:43:02 +0200
Subject: [PATCH net-next v3 6/9] net: dsa: mt7530: get rid of
 mt753x_mac_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240301-for-netnext-mt7530-improvements-3-v3-6-449f4f166454@arinc9.com>
References:
 <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
In-Reply-To:
 <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709289776; l=1494;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=8u7euwYTcc58UJEZ934iSyhrRKaOIduS6lOdsKOd2oQ=;
 b=CuKSG8ZKfZXUavxJ8+US5J8hRU3RJR/w4dge8UOfky7+xPVutxnu5IricMLLQQWyejQQOG5+g
 6kgpOcLdoJiBe6485TrqwGcf1yu5j/s0HRJPH2k+UYkVhi87eHDrPkE
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront with auth_id=137
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There is no need for a separate function to call
priv->info->mac_port_config(). Call it from mt753x_phylink_mac_config()
instead and remove mt753x_mac_config().

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 80b65f064310..e353c03dd1db 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2634,16 +2634,6 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	}
 }
 
-static void
-mt753x_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
-		  const struct phylink_link_state *state)
-{
-	struct mt7530_priv *priv = ds->priv;
-
-	if (priv->info->mac_port_config)
-		priv->info->mac_port_config(ds, port, mode, state->interface);
-}
-
 static struct phylink_pcs *
 mt753x_phylink_mac_select_pcs(struct dsa_switch *ds, int port,
 			      phy_interface_t interface)
@@ -2669,8 +2659,8 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	struct mt7530_priv *priv = ds->priv;
 	u32 mcr_cur, mcr_new;
 
-	if (port == 5 || port == 6)
-		mt753x_mac_config(ds, port, mode, state);
+	if ((port == 5 || port == 6) && priv->info->mac_port_config)
+		priv->info->mac_port_config(ds, port, mode, state->interface);
 
 	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
 	mcr_new = mcr_cur;

-- 
2.40.1


