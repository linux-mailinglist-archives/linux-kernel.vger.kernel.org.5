Return-Path: <linux-kernel+bounces-68495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD4857B23
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D44B1C22557
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2EB633E3;
	Fri, 16 Feb 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exsq854Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3058ABF;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081544; cv=none; b=F1PdLYAlnOqHQHSP5cncY2IGKjxF8kSmH69RRcKAuwJzhhNu5eagFhIvZljTLjwHB8HWYMCr/0OMq32uW+fKSEm36B7rT4s++VqOBNyTjCjM9dO3KXoeXBozoS2WwsVIJmdX6JqwkJcknase8VMvxp5mPQsNIfUDiVjlERcl6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081544; c=relaxed/simple;
	bh=kX85+BHUILFIoP4X6xIr9jJ6kAHMS4KcDN2tshuSuHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6hvJwIO/lX3lFjQIgwSoDWgG2IdtccPoq8A5WnLz2qgriwZoeDO6Vs66EhxSB9BtRkC3pjqDnLrcHM8gzjqfJ7BByhXzTqyjbuFh5zzcCT0I5Jre/5NZ4hJ+188CFKiPKMy5ZwtRPp8lTPHwbHqlHxJFzKUO2qSgc4gOIvFZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exsq854Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44CC7C43609;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708081544;
	bh=kX85+BHUILFIoP4X6xIr9jJ6kAHMS4KcDN2tshuSuHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=exsq854Qsx4wAWqZss3l2Lql2Z9s17wuhv8eNV0lYlBmKHE6ytRQrKCBv5VKyiF90
	 w5Xo2xqB4eSH8FhI/zufAevuM0onnj3ukAKW/gP0o6ictCDorsgSQaFKX2BhuD2xXB
	 YWpzhKtZhXlr8dEBvqkKstzMMu6NMCaUeX6ySjGGEpgGf3xG2coZdMGW7HGkh/j+1I
	 b29iAvWIGYCzKUFybmktN331iCGeF+pYknfpO6h7x4GwNUYeaiHnZbiTpUk46Dxio2
	 88A1gamO+fVkfryJYzAJHSd15AdB9th7BF63TSK1gqgGAmsVYL5jFeHxLXtXdPUCDk
	 TehsiHt4xdeCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C3C48260;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 16 Feb 2024 14:05:34 +0300
Subject: [PATCH net-next v2 6/8] net: dsa: mt7530: get rid of
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
 <20240216-for-netnext-mt7530-improvements-3-v2-6-094cae3ff23b@arinc9.com>
References:
 <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
In-Reply-To:
 <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708081540; l=1494;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=8u7euwYTcc58UJEZ934iSyhrRKaOIduS6lOdsKOd2oQ=;
 b=Wx9bJeQRa7nZx6uhvjZdxKJTvpcdREkGVzpUKqIw6ba80s3n2X9cJl8s73s/KrhuxfsmqvCvh
 4REL+dvy9DCBQ14v5wMUpEpuYXWzzCv4C7cR5D8skO+Wu4eQOhxIFCh
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


