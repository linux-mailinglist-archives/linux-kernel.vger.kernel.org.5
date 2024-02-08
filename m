Return-Path: <linux-kernel+bounces-57481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E784D9B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92961F23801
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11D6A35D;
	Thu,  8 Feb 2024 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlAu9uzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26667C71;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371494; cv=none; b=RIwR8KPf63Slf7WjqnnQd0sLb7bOEgpZZZJ2IxnDEsAx8FjaB405zu+9LeIq2H5NiRRrdaG9JbeNf9BNy1GjZZuAodfq+7PFKRcBKG185iv0Z9cIgsrQx2cOIpIAVNggNR8LeyIrfCu8fi/roQesJbKY+2mF6ZhVSND5459Rlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371494; c=relaxed/simple;
	bh=kX85+BHUILFIoP4X6xIr9jJ6kAHMS4KcDN2tshuSuHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWZO57fNjy080PYC3W08YoH0dQccwIUqLVgkjbQ1WqqwUFz1NQiAlAE1fKC0wTR6ok0Leblb0Lc09GZTlh8NuJzT7fSGT4WRg5DKMga0vCR1DUZhPswHMbjfu5GpqnTufrcnl2lGkQe7vgZuJGEJ9GD/ed5FLdMmUX0K7NR0HlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlAu9uzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7581AC43141;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707371493;
	bh=kX85+BHUILFIoP4X6xIr9jJ6kAHMS4KcDN2tshuSuHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MlAu9uzJin7f1o87GBKgOjfj6XVr+CikDH4dyTs1M/Q6R6CaAygiBsiY5D7XvSx1l
	 BaNtM4NZiiv88M2FhOEUsTLtbvh5DrN9n59qQdCyqZaFDooj9U7OEvjsSn2Sc/uG/q
	 beCGtW5hitKuNE2qPyuqIUkDFoOUXDfOMJf2D+IAn+WM6BaTjrhiKc31wi0kg4cE4H
	 jhktwSGCEgH0nv7oKIYUk7TEBdVcmVLzAohK2jilYTZaQK8cumr1Y2Tr+jQy1eLYZl
	 V4ty3HLrxkQ5ho/4vBWiR2rpvXRz8ND8EUKuSrflWzrUmU+GZluQL0hRz0kyz6p2gt
	 pSoHj2role8/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B51C4829E;
	Thu,  8 Feb 2024 05:51:33 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Thu, 08 Feb 2024 08:51:34 +0300
Subject: [PATCH netnext 6/8] net: dsa: mt7530: get rid of
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
 <20240208-for-netnext-mt7530-improvements-3-v1-6-d7c1cfd502ca@arinc9.com>
References:
 <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
In-Reply-To:
 <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707371489; l=1494;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=8u7euwYTcc58UJEZ934iSyhrRKaOIduS6lOdsKOd2oQ=;
 b=4kXZwrGfjQOP/O9zg/NSniCnR4s8JpB6Wq32o9H3OeS/SQbaUVeLD1kCRlsgJBEeBsabQ6bAE
 4nvyQ4j5XXyBTtoQDmIykCTp5YlEDVAD1MYjb83pgx6d2n6a0RFzb1G
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
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


