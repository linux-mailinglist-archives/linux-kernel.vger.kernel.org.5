Return-Path: <linux-kernel+bounces-152853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B318AC544
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21C51F22306
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76356B7C;
	Mon, 22 Apr 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpUfuCAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F94F1E5;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=czyjhQtn5OR7oIqFlF1PNA1T5R3POzZfu/1ieM1AjS7Evj6o3LKaOVhQYZ14CRSaR+TllLjqtoQgJl4/tBLkk7bivHn38oGNeSqRYZUAnOB4fVCSbO7j8Sphm+BwZgwkp/kf/wKdzd3GGiT1P+dn93f4emI45p1/ymXEklc3vQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=zupCYmW/khoZsM2dTyo44r06AeRMOCSbdh6WzpcdHaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYtAH+HXaD6xoZPN7vOZGGwUriwWASCLrr0UlzPZEkguGTe89/r1VzejZFCObz4KbHltQNyF12Q7lOWdqS/+IMvPfuAMtdv7Q7zl0DvGbzsXAuQr1fAO+h8hkwNOmlLNOf+gbOSoubIUnMJhckLT9yWfbGocm6SpLa7k29Gjp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpUfuCAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CCC1C4AF55;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770131;
	bh=zupCYmW/khoZsM2dTyo44r06AeRMOCSbdh6WzpcdHaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qpUfuCAvCaCL6v0vtDV/Jwhw7j2rUlMJMjAKZQ2HhScRbmHL0m6/Mvg59NeAm+o4s
	 MJ+h/fSxf6c9FkCj67Z1+tGK085Cf8OIHmrpuWzmrIuHHgtBTWxrQiAsNg5QjSvHbc
	 2gi2kd6GHa8Cx9172g2N8M0uqF6NbRMIvMnlEfqj7Ezf9squOlBPdk36PrQagRNWwh
	 guPE+wAyyuX4KY1ggXuS8hnrRdW5F6n5iO+/0iyZsna2usu/793tuzg3HfhsbbgxZe
	 eKqG2vZXqEqxFD/eWm7EjLHe1YBrWchubrR7AnwgA7iPuy+svXf1FrjRlYPKGuDv5Q
	 iYFX8+PmL1LUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9C9C4345F;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:19 +0300
Subject: [PATCH net-next v2 12/15] net: dsa: mt7530: get rid of
 mac_port_validate member of mt753x_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-12-a75157ba76ad@arinc9.com>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=1895;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=eQVxi9XpKVjFwy7G/fq5LbkX2JyuVqKa+YvcokozwTs=;
 b=GgpCu/Y1Z9ir60LhRY9KQrTo4YU8dcdz5TAEg6d1AtWSTPBmF2HFUtGt8VLQ4EH5FL+8o1UVO
 YEf/r6ytza4BZ+zDswwMeepMid3wYdwg9dfqG8+ydAhoONXgB2awpwl
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The mac_port_validate member of the mt753x_info structure is not being
used, remove it. Improve the member description section in the process.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 6a6ef34b48c4..2ea4e24628c6 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -743,15 +743,14 @@ struct mt753x_pcs {
 
 /* struct mt753x_info -	This is the main data structure for holding the specific
  *			part for each supported device
+ * @id:			Holding the identifier to a switch model
+ * @pcs_ops:		Holding the pointer to the MAC PCS operations structure
  * @sw_setup:		Holding the handler to a device initialization
  * @phy_read_c22:	Holding the way reading PHY port using C22
  * @phy_write_c22:	Holding the way writing PHY port using C22
  * @phy_read_c45:	Holding the way reading PHY port using C45
  * @phy_write_c45:	Holding the way writing PHY port using C45
- * @phy_mode_supported:	Check if the PHY type is being supported on a certain
- *			port
- * @mac_port_validate:	Holding the way to set addition validate type for a
- *			certan MAC port
+ * @mac_port_get_caps:	Holding the handler that provides MAC capabilities
  * @mac_port_config:	Holding the way setting up the PHY attribute to a
  *			certain MAC port
  */
@@ -770,9 +769,6 @@ struct mt753x_info {
 			     int regnum, u16 val);
 	void (*mac_port_get_caps)(struct dsa_switch *ds, int port,
 				  struct phylink_config *config);
-	void (*mac_port_validate)(struct dsa_switch *ds, int port,
-				  phy_interface_t interface,
-				  unsigned long *supported);
 	void (*mac_port_config)(struct dsa_switch *ds, int port,
 				unsigned int mode,
 				phy_interface_t interface);

-- 
2.40.1



