Return-Path: <linux-kernel+bounces-151296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165B8AAC91
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633391C211C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B6129E7D;
	Fri, 19 Apr 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgqqzKvW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BE7F47C;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=RHY9MCgn4Xvurol946JYoBoOJLSLWOZtGwtxWSUUhAnedmIeu9R2iGc2eXnzqk7jIIrtVZa5MEjXCHFyT/FkT6kXncEYqZwLMyECSyEXW5x9d1zG/5DdYmMBAkatYIpTvqUY2g55w/0qFtG7yJEBeGzfeg5yi2s3M/45ovsodzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=QXo7TXAVxaylcHHjpRcvyG/89tEmiO1hQSF4FfXC2qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uq/bQe+DOFLEbGhkgIfWjrnMsVOgX9S1HYkddYjohkAft+woICaG5S6evo+PrqiokFfH6JZSBfSPCFDda+bM8y68BbizcudLHLi2UuOimj3a/ff9Ah2hgyBUSKf8+33x6xnTW8MZNrGeYrzUx+2dU9IAiH/eedAXqsErHcWmSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgqqzKvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0022AC3277B;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521378;
	bh=QXo7TXAVxaylcHHjpRcvyG/89tEmiO1hQSF4FfXC2qs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qgqqzKvWynmpgIFrMSIHpW8fVopOfTgvQwiqSYLktTckhPVtRVBIF58c4Vtpz8a/A
	 Rzi0bSMa30O9P2SHK1tUJOd/VG3o7PxkHGTXC8yqv4aMEBmZW7ru+NhW9vEPEINgZo
	 D9sppvQ+PKqrUFv9ebg1ffb218Hxs5RbG5AcHbDPkMcH8YaciTyb1VTwwa+ivDDuAP
	 IW3OIVIg08x7spOiuQO86rRFZ0Ckd4FNDrepOxt+u0SVPIZ4nZad+Ya3JZMqz7xmia
	 ql6HkAKCH45j8CHnOFsp4lanZ1RI3Y/PkZUHx7HM9iO2tVkygMyKNCoNKnyQ7pTadL
	 uId6WvYZBto2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FCC04FF6;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:32 +0300
Subject: [PATCH net-next 09/13] net: dsa: mt7530: define MAC speed
 capabilities per switch model
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-9-6d852ca79b1d@arinc9.com>
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=2468;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=U7m+wRsPDOynbhqa9RKx+0GeC9h4YeQt1AWk+qLy0W4=;
 b=0crF93zDGKVTpjGQEtq8n4SQMOTbZYWpe6bvUZvJS7QU9rdMeKGTO+QmpVP7+g6kxdvfi9UMQ
 IdQM4xMj7CMDeXciei7AC2vbAv1xB6047R1MFchs+fdLBBzPBx8y/R5
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

With the support of the MT7988 SoC switch, the MAC speed capabilities
defined on mt753x_phylink_get_caps() won't apply to all switch models
anymore. Move them to more appropriate locations instead of overwriting
config->mac_capabilities.

Remove the comment on mt753x_phylink_get_caps() as it's become invalid with
the support of MT7531 and MT7988 SoC switch.

Add break to case 6 of mt7988_mac_port_get_caps() to be explicit.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 4e9aa78ca3d0..8a141f849673 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2685,6 +2685,8 @@ mt7531_setup(struct dsa_switch *ds)
 static void mt7530_mac_port_get_caps(struct dsa_switch *ds, int port,
 				     struct phylink_config *config)
 {
+	config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
+
 	switch (port) {
 	/* Ports which are connected to switch PHYs. There is no MII pinout. */
 	case 0 ... 4:
@@ -2716,6 +2718,8 @@ static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
+	config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
+
 	switch (port) {
 	/* Ports which are connected to switch PHYs. There is no MII pinout. */
 	case 0 ... 4:
@@ -2755,14 +2759,17 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 	case 0 ... 3:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
 		break;
 
 	/* Port 6 is connected to SoC's XGMII MAC. There is no MII pinout. */
 	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
-		config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-					   MAC_10000FD;
+
+		config->mac_capabilities |= MAC_10000FD;
+		break;
 	}
 }
 
@@ -2932,9 +2939,7 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	/* This switch only supports full-duplex at 1Gbps */
-	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-				   MAC_10 | MAC_100 | MAC_1000FD;
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
 	priv->info->mac_port_get_caps(ds, port, config);
 }

-- 
2.40.1



