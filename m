Return-Path: <linux-kernel+bounces-151302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3968AAC99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732D6283445
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924812DD8A;
	Fri, 19 Apr 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahWAMSh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC17F7F1;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=cAgtN0P3N4M5DbWBggfNn3kn1mk4Q6JL6M6Kw+vcNAE9TeD+3oRGjuzZMKcOfHVuV9s7t31N9hFDpl2TrHGb0NKZdoDDeGQh1EQzB4xr2OFSPa6tX4amhAUBoi0zlF/BX+ZMPtXroc7tEc+5jtoPeLCjr7PhJ7JZur0l+ZkIrz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=ZNmSMiuq5wJcBo+EGlGmT/XTyYTDOnZPeAOljaVsq+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s6vqrQt5PdQ4QE9CY2MdKUuznzaLGleriHb/+B/dJICoIf+u+/zGDk5/uTpUNwrvDxRUEpLOfrygS4AM7YcmZ/fk9kAvxlnR+iAX+ivxhSxiGH76ji6PQrUICCHaoYo9owAUdSlbr8woPpHa1QZMMUhPqa+sAVXMs6hhmbqWHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahWAMSh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E92EC4AF07;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521378;
	bh=ZNmSMiuq5wJcBo+EGlGmT/XTyYTDOnZPeAOljaVsq+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ahWAMSh/qjA1VIw8T6MFh+en9clMxEU4B3qAfiuR2mUjkKQfoMNKAeS4jvftgLEb5
	 qSSqgstFp5gDWye9zhwtttDwbRBbFFCZTuMKcUN0XT1BcODl1O4Ms//4qlxOoknNkC
	 YvF7aBqO6o8is/XYHxfDrrPn/rxFytIAZqoC34XtCwUFMjG4lIxdeGIEIDa15E9xY8
	 c8RF8sN9XDL6XPF6GKvqK84TD4Mz5LR7X2k+rXSFlW3nrvv2WB/VsnABFnK5MMKv/q
	 5p9fXZ2OPAziuJkCdUez0XshHVOOmb/8S+YTB+hlNC/CfQ6Pab8fXzMa3R3/Oathp9
	 LQQ+RssYPl26Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4644AC04FF6;
	Fri, 19 Apr 2024 10:09:38 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:36 +0300
Subject: [PATCH net-next 13/13] net: dsa: mt7530: use priv->ds->num_ports
 instead of MT7530_NUM_PORTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-13-6d852ca79b1d@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=1820;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=zwYuUUVIbXmvRXAn0iA1vobSjJIppJvvXAmZxGXeCM8=;
 b=fe6mJg0I8EYeeDH1SRaOoku+kWHl7bJSQMptDTwIIsKsJjM2Ye2E/BZe2PgrQWFS3Q+DLWrY6
 M/7B5bZqr4yBBq/kg9oZ6WE/NN10dRp5OB3IueAP5ByiUJ0dMCiYOS+
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

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



