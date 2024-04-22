Return-Path: <linux-kernel+bounces-152854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB98AC547
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56B71C214A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DB57305;
	Mon, 22 Apr 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajM1UMJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1214F213;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=sKI1/X5k2QSQoWjPSPeMlo6fJ9KtOrngzj+n6QSm1ilQ9ZJfs6VtfyRTOWfh+zcfh7XvOGtdfKuKY0vwuSklbw8ICViRm8gdGxmLhYh2qk3H7oiZIrxbB/EpTRUMpoTUMFBNY2ufMts7HjUXMzGUMIEk7WPaQisvy7+C42LuThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=E4bOiJx1q+nQyx91LA+lMd4HNz7Gscld/4vQtZGnbwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNjSEU4F4j1VHKYl65YDkJ+CWwXVhz4dy3752LW1cWJ9+tyPhS3gSe0uCEweb+0qQ6TJ9phDzoYsa3AXcKBGA+OFYgrQ+g012ySFg2uNMBOyJEALDj6c1ZmaYxc5jnS86oBfrmU2VVPkEktzGUX06+s5TrCi9mKVxjp0k/yPSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajM1UMJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CFE9C4AF61;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770131;
	bh=E4bOiJx1q+nQyx91LA+lMd4HNz7Gscld/4vQtZGnbwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ajM1UMJ2pU9y8p0WzVLRgrTnFqnBgLHP56xFT+M5+xuc6vUkf2Xc8GCvl4ZOCqQSr
	 ALjNg3hM0HgykkcnBsOhk2Pq+wRHEozYfeukHOLG9XVN/GErHZeGraFB073hiA/QAy
	 174e36wrHQot9JZv4SuYSGHZYKlSPcXXXs3YTRzxC9Vji6Ut28pnKXwB/kQIFtRbf8
	 CtolqRWeJhUOQmw2jGpRGHX/lrmliu5abN7l5xIrw84ZOKFqIjYbp0Rm/bgRctbbJA
	 i7jglt+Wr1agneYewuOh1x4vEaIGTFgxWFIET9BF3LzgprQWhWKHyWHNYiODQa8aYz
	 yAxFN7iijpqsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB70C10F16;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:20 +0300
Subject: [PATCH net-next v2 13/15] net: dsa: mt7530: use
 priv->ds->num_ports instead of MT7530_NUM_PORTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-13-a75157ba76ad@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=2051;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=LO57rTtyBbOCREdPUpi6qHUsoyqRRLXYGv733cnzF7I=;
 b=qqzctkZQES8NF5LlMYDv98BTmFXbTZaEoakWJoA2/kDTUoi9+aBTltYqJHlK1JsL0us/ZvI7Q
 +CO9tadFy7qCeAsJ9tbPawfjSyWV1IroyQul4j0q174vvcq7p9mKQjL
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Use priv->ds->num_ports on all for loops which configure the switch
registers. In the future, the value of MT7530_NUM_PORTS will depend on
priv->id. Therefore, this change prepares the subdriver for a simpler
implementation.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 5e69ff0a4b24..55954a165a15 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1411,7 +1411,7 @@ mt7530_port_set_vlan_unaware(struct dsa_switch *ds, int port)
 	mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
 		   G0_PORT_VID_DEF);
 
-	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+	for (i = 0; i < priv->ds->num_ports; i++) {
 		if (dsa_is_user_port(ds, i) &&
 		    dsa_port_is_vlan_filtering(dsa_to_port(ds, i))) {
 			all_user_ports_removed = false;
@@ -2428,7 +2428,7 @@ mt7530_setup(struct dsa_switch *ds)
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
 
-	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+	for (i = 0; i < priv->ds->num_ports; i++) {
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
@@ -2539,7 +2539,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 	mt7530_clear(priv, MT753X_MFC, BC_FFP_MASK | UNM_FFP_MASK |
 		     UNU_FFP_MASK);
 
-	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+	for (i = 0; i < priv->ds->num_ports; i++) {
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
@@ -2626,7 +2626,7 @@ mt7531_setup(struct dsa_switch *ds)
 	priv->p5_sgmii = !!(val & PAD_DUAL_SGMII_EN);
 
 	/* Force link down on all ports before internal reset */
-	for (i = 0; i < MT7530_NUM_PORTS; i++)
+	for (i = 0; i < priv->ds->num_ports; i++)
 		mt7530_write(priv, MT753X_PMCR_P(i), MT7531_FORCE_MODE_LNK);
 
 	/* Reset the switch through internal reset */

-- 
2.40.1



