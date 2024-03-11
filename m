Return-Path: <linux-kernel+bounces-98781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B452F877F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87901C218DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294933CF7D;
	Mon, 11 Mar 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4kxIedt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370523BB4D;
	Mon, 11 Mar 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157617; cv=none; b=rqCT7d9lksVJK4XaRyPUdD9Q5tgPaVzEarLN8vcsUWoMh8/OyDCV6gtuZdnMGX63Gjh0t3sIp1ViBE8NADUfl4i93ifvLV2uhwjWslb47bjNf/TpM2N3ZIeIOnvEPHZmZrCgG7dCSt4r+LNngvWPa/yXIgo3JAAzaXF0ZQKoDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157617; c=relaxed/simple;
	bh=HhrrcwXb11FZgdkCOTj4FdnCz10q4yBDnVBjrPjYVL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpgWChw5pMfSXLG0Qwcu6YilTEbcPGrkqoA95R7he1RUuys2UsK37NjCOpEu/M/EwxZiIplLzg+AuxWBi1P+UDjX7LCic5CDAnkyvWZGnQFMAoT7fq4J8lgXkiMxxTpW/88ni4rSKmlzSxJMbnDZGf14GJDUykeUXMLhb29eEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4kxIedt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C96C4C433B1;
	Mon, 11 Mar 2024 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710157616;
	bh=HhrrcwXb11FZgdkCOTj4FdnCz10q4yBDnVBjrPjYVL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a4kxIedt1CV52aoVyZni0I3kOqka4uNcmrhbfhDlqOOO4NA7CeUXKNFpo2FsCs1Wp
	 u9CveC85PClR8MLNMpsdvoGzLlsn86p70M2jHrFouV9QVVco+zCQCTsltnpAi7RW9N
	 pfNaU6naYY+s136bnaao5EMp123DL7Rfuby+MS72ibDJDI8O9seHsBI+kRjNt1uup+
	 bxLeYqvGgGNKtiugKfOs3Igf8nusYv5dVxPB0fR50PEOZDGXDKfzB4h1paf3Ir0eUU
	 qHvNotAVqVFhV8mcncuutGNqS8hPEWBrvFbQgUDabbIbjISlZItBNu3VeEGWqkEOBq
	 hFKSnf+4BiPlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5779C5475B;
	Mon, 11 Mar 2024 11:46:56 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 11 Mar 2024 14:46:39 +0300
Subject: [PATCH net 2/2] net: dsa: mt7530: fix handling of all link-local
 frames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-2-d67e6cc31af2@arinc9.com>
References:
 <20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-0-d67e6cc31af2@arinc9.com>
In-Reply-To:
 <20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-0-d67e6cc31af2@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com, 
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710157606; l=5904;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=06wtkRcKC0XkT4RTzWINCxtbmCk4a1kVzz8en6OpGhQ=;
 b=YpdBCEKc6t6qo/kW5T35bWuzlCeO67KX6/tMQfWJ6gZO844d4aeoWBAMe+Tc8Kx+G8nDMr0RJ
 yrMGRbQoOh6BByvvtsKwl0kBmQDNtQK9ycAQ6B6rp3vFrKLsCayTz75
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Currently, the MT753X switches treat frames with :01-0D and :0F MAC DAs as
regular multicast frames, therefore flooding them to user ports.

On page 205, section "8.6.3 Frame filtering" of the active standard, IEEE
Std 802.1Q™-2022, it is stated that frames with 01:80:C2:00:00:00-0F as MAC
DA must only be propagated to C-VLAN and MAC Bridge components. That means
VLAN-aware and VLAN-unaware bridges. On the switch designs with CPU ports,
these frames are supposed to be processed by the CPU (software). So we make
the switch only forward them to the CPU port. And if received from a CPU
port, forward to a single port. The software is responsible of making the
switch conform to the latter by setting a single port as destination port
on the special tag.

This switch intellectual property cannot conform to this part of the
standard fully. Whilst the REV_UN frame tag covers the remaining :04-0D and
:0F MAC DAs, it also includes :22-FF which the scope of propagation is not
supposed to be restricted for these MAC DAs.

Set frames with :01-03 MAC DAs to be trapped to the CPU port(s). Add a
comment for the remaining MAC DAs.

Note that the ingress port must have a PVID assigned to it for the switch
to forward untagged frames. A PVID is set by default on VLAN-aware and
VLAN-unaware ports. However, when the network interface that pertains to
the ingress port is attached to a vlan_filtering enabled bridge, the user
can remove the PVID assignment from it which would prevent the link-local
frames from being trapped to the CPU port. I am yet to see a way to forward
link-local frames while preventing other untagged frames from being
forwarded too.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 37 +++++++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h | 13 +++++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index beef5bc38b88..eddb4cb5ce65 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -998,6 +998,21 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
+/* On page 205, section "8.6.3 Frame filtering" of the active standard, IEEE Std
+ * 802.1Q™-2022, it is stated that frames with 01:80:C2:00:00:00-0F as MAC DA
+ * must only be propagated to C-VLAN and MAC Bridge components. That means
+ * VLAN-aware and VLAN-unaware bridges. On the switch designs with CPU ports,
+ * these frames are supposed to be processed by the CPU (software). So we make
+ * the switch only forward them to the CPU port. And if received from a CPU
+ * port, forward to a single port. The software is responsible of making the
+ * switch conform to the latter by setting a single port as destination port on
+ * the special tag.
+ *
+ * This switch intellectual property cannot conform to this part of the standard
+ * fully. Whilst the REV_UN frame tag covers the remaining :04-0D and :0F MAC
+ * DAs, it also includes :22-FF which the scope of propagation is not supposed
+ * to be restricted for these MAC DAs.
+ */
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
 {
@@ -1012,13 +1027,27 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 		   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
 		   MT753X_BPDU_CPU_ONLY);
 
-	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) and egress them
-	 * VLAN-untagged.
+	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
+	 */
+	mt7530_rmw(priv, MT753X_RGAC1, MT753X_R02_EG_TAG_MASK |
+		   MT753X_R02_PORT_FW_MASK | MT753X_R01_EG_TAG_MASK |
+		   MT753X_R01_PORT_FW_MASK,
+		   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
+	 * them VLAN-untagged.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_EG_TAG_MASK |
-		   MT753X_R0E_PORT_FW_MASK,
+		   MT753X_R0E_PORT_FW_MASK | MT753X_R03_EG_TAG_MASK |
+		   MT753X_R03_PORT_FW_MASK,
 		   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
+		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+		   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   MT753X_BPDU_CPU_ONLY);
 }
 
 static int
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index cef2af3f24d5..75bc9043c8c0 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -73,12 +73,25 @@ enum mt753x_id {
 #define  MT753X_BPDU_EG_TAG(x)		FIELD_PREP(MT753X_BPDU_EG_TAG_MASK, x)
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
 
+/* Register for :01 and :02 MAC DA frame control */
+#define MT753X_RGAC1			0x28
+#define  MT753X_R02_EG_TAG_MASK		GENMASK(24, 22)
+#define  MT753X_R02_EG_TAG(x)		FIELD_PREP(MT753X_R02_EG_TAG_MASK, x)
+#define  MT753X_R02_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_R02_PORT_FW(x)		FIELD_PREP(MT753X_R02_PORT_FW_MASK, x)
+#define  MT753X_R01_EG_TAG_MASK		GENMASK(8, 6)
+#define  MT753X_R01_EG_TAG(x)		FIELD_PREP(MT753X_R01_EG_TAG_MASK, x)
+#define  MT753X_R01_PORT_FW_MASK	GENMASK(2, 0)
+
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
 #define  MT753X_R0E_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_R0E_EG_TAG(x)		FIELD_PREP(MT753X_R0E_EG_TAG_MASK, x)
 #define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
+#define  MT753X_R03_EG_TAG_MASK		GENMASK(8, 6)
+#define  MT753X_R03_EG_TAG(x)		FIELD_PREP(MT753X_R03_EG_TAG_MASK, x)
+#define  MT753X_R03_PORT_FW_MASK	GENMASK(2, 0)
 
 enum mt753x_bpdu_port_fw {
 	MT753X_BPDU_FOLLOW_MFC,

-- 
2.40.1


