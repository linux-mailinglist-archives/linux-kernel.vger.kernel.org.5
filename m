Return-Path: <linux-kernel+bounces-68490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FAF857B14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A192B1F25B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87E59B60;
	Fri, 16 Feb 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnmhAoaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F35822B;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081544; cv=none; b=Gos96jP9sk9Dfkz2RLPjFT3/yjszAfC/e6k+Lz7jPxlpp8ELOuz/DsqA4bp7CvwC4PJvlNWmV8CmWO5ZDLyKB0N3KsL/i5X87SnLFuE+c1bsutdv1/zhwnTkXgo3ne07V6XbraFHB6rpyDtdzAEt/xX4HA864+GS84mhoWOQJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081544; c=relaxed/simple;
	bh=r9/r4cAgofxq2YbjbbxXvYSIDlSWSINkDrq9AA9RzRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bl5OJxEEGeYCmScPsdd3mkkJJ0ONq1kyrFQMVng8UrQ4Z3oU12cA437v9a1aRm79iDOVY+DCofqd1HHEgs7i8xHQs57pbZIug3KxDbqD2X2GLlWWXg8Z/5qbWp6Aye88ykdhbjZv1zXSX07wgZ21xelKXPSTthKkJ4TGYWAGI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnmhAoaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 077E7C43390;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708081544;
	bh=r9/r4cAgofxq2YbjbbxXvYSIDlSWSINkDrq9AA9RzRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LnmhAoaG/n0fhczqyH5t6mKC/wcilGZQaUs+r7vvHlEnfE3heHFDh6CdG1/FzSMlB
	 +Kq0ftoIm32qrChLaxPeNctcaf1NHkHpLiSA38PYVXpztdbJqcPuALceqYeLIzX0pE
	 MgU7RKgemMAaqb90DlvUPlIBQJu9zmWJ1ypCqldCDodtaw+4jWWuFi3noRNSdL2TBy
	 NNtB6tLdVFzAk/Xk87ooVV47XQZZs9ZR0q2gMlrue2J0ZiC2dDybSLNvw0Kn2OLWuw
	 NBIRdaR4dPLEdeh+LlQD9aInBqvI/oxguzpBXXlwbm/fepDOv2uKqifrECO3YPrug6
	 FTobw0db8bPmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF49C48BEB;
	Fri, 16 Feb 2024 11:05:43 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 16 Feb 2024 14:05:29 +0300
Subject: [PATCH net-next v2 1/8] net: dsa: mt7530: remove .mac_port_config
 for MT7988 and make it optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240216-for-netnext-mt7530-improvements-3-v2-1-094cae3ff23b@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708081540; l=2593;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=zsBRS25Kdr7LfGGSqrR3mLbX7RMd9/oxSXqAjEC3Jr8=;
 b=vF2L9NK6OyRK16reEhB75WUImHKGciv3O6Y0W0oNc9o4O4TlHjL/V3WziVoOr3V3Iqdudmz9O
 77xXUCAaJHuBL3WS62LLUYJecjLZPR4LucIcn8MqGHWsVRyvIAZS5pf
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

For the switch on the MT7988 SoC, the mac_port_config member for ID_MT7988
in mt753x_table is not needed as the interfaces of all MACs are already
handled on mt7988_mac_port_get_caps().

Therefore, remove the mac_port_config member from ID_MT7988 in
mt753x_table. Before calling priv->info->mac_port_config(), if there's no
mac_port_config member in mt753x_table, exit mt753x_mac_config()
successfully.

Remove calling priv->info->mac_port_config() from the sanity check as the
sanity check requires a pointer to a mac_port_config function to be
non-NULL. This will fail for MT7988 as mac_port_config won't be a member of
its info table.

Co-developed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/mt7530.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 03d966fa67b2..94d4b2c87799 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2655,17 +2655,6 @@ static bool mt753x_is_mac_port(u32 port)
 	return (port == 5 || port == 6);
 }
 
-static int
-mt7988_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
-		  phy_interface_t interface)
-{
-	if (dsa_is_cpu_port(ds, port) &&
-	    interface == PHY_INTERFACE_MODE_INTERNAL)
-		return 0;
-
-	return -EINVAL;
-}
-
 static int
 mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
@@ -2706,6 +2695,9 @@ mt753x_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 {
 	struct mt7530_priv *priv = ds->priv;
 
+	if (!priv->info->mac_port_config)
+		return 0;
+
 	return priv->info->mac_port_config(ds, port, mode, state->interface);
 }
 
@@ -3169,7 +3161,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
 		.cpu_port_config = mt7988_cpu_port_config,
 		.mac_port_get_caps = mt7988_mac_port_get_caps,
-		.mac_port_config = mt7988_mac_config,
 	},
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
@@ -3197,8 +3188,7 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	 * properly.
 	 */
 	if (!priv->info->sw_setup || !priv->info->phy_read_c22 ||
-	    !priv->info->phy_write_c22 || !priv->info->mac_port_get_caps ||
-	    !priv->info->mac_port_config)
+	    !priv->info->phy_write_c22 || !priv->info->mac_port_get_caps)
 		return -EINVAL;
 
 	priv->id = priv->info->id;

-- 
2.40.1


