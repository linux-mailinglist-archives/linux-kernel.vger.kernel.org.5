Return-Path: <linux-kernel+bounces-151294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8078AAC92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA041C20F67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7504129E80;
	Fri, 19 Apr 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw1SNuhn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106797F46E;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521378; cv=none; b=h6B2/DWI2+azytU/eqXtp+iWn7ti1qwR57KSOBhGy/ZH4SDLqGvqE9Ok1LW4dibHsH9F8PoLn0B0/FKqW6XfQTR7aO5oEQaZno7JhzCC96aNbekNwbGic3FxXOsL4hGc1/7GOmPOn8NfuG54/BdmsoC+nb+lJWnZr0FDvc/3mHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521378; c=relaxed/simple;
	bh=HiS/Y7rfUE8Bpz+kjfxnTmy612XHinTi54T94xG6gRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zqumho5FJCPYtSQ8NebGBmC79lO0tnrDWmVLBSZIvgNQ6stjPGZCzRdDCdKCCwbGdedLE4uxjCsa7WbtQlHOLJc+NFweQITtjhkjxOdRyFP9er3f4mwOLJ0iz2aVXOl8BRfvXmd1dUwYCUtToIr0Bqm6RA/R16jIZWByfKXL7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw1SNuhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADDE2C4AF0B;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521377;
	bh=HiS/Y7rfUE8Bpz+kjfxnTmy612XHinTi54T94xG6gRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Xw1SNuhnthrhZB9mCF4Gu3LulsCpUl8yNGUyKJtqPWx/AGBxWcFeTVWITEqqnpYDf
	 RFL0wnVUHqag3wdyNbN0qEUYodb8oxputriFevW6LHHMoUnnhyU/lvgoGpTJUUfmtr
	 x6iH3lwkrboP491YY+rD9qDW1Xy1zkrRUN/6obuQfRI53mD/G+t08P78mOpRpvn7wv
	 7aFMpX0sJS4BA8lCoNQDkd6qWFK3riUPoT+fJUb28/jwqmLcxg67KhMs5c13WgVXbS
	 gHwYyrs3h3Wvp3uCaokjagoBDJMzjJYt+TkgTDNcameG+ETTwfZbYc9twI2lJCFUyR
	 4r1eu0AO3qUfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044FC04FFE;
	Fri, 19 Apr 2024 10:09:37 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 13:09:28 +0300
Subject: [PATCH net-next 05/13] net: dsa: mt7530: refactor MT7530_MFC and
 MT7531_CFC, add MT7531_QRY_FFP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-netnext-mt7530-improvements-4-v1-5-6d852ca79b1d@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713521374; l=7840;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=sGSHaq4RxnxW2EpnmYPnfHMUSXd9a7KtPXo7IfxtfVg=;
 b=OOQSztQcKnFh3dbVDjmQJ6A0YGaPuK+8RZzm0fVzlaP8paiq12MkDOM+liF6zhA7Q4PWcr02I
 UOGfj9GtOtOCfWrbJc/EtQ3En5sgOkDMujHOD+Akb74sKNHus8fJhiR
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The MT7530_MFC register is on MT7530, MT7531, and the switch on the MT7988
SoC. Rename it to MT753X_MFC. Bit 7 to 0 differs between MT7530 and
MT7531/MT7988. Add MT7530 prefix to these definitions, and define the
IGMP/MLD Query Frame Flooding Ports mask for MT7531.

Rename the cases of MIRROR_MASK to MIRROR_PORT_MASK.

Move mt753x_mirror_port_get() and mt753x_port_mirror_set() to mt7530.h as
macros.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 38 +++++++++-----------------
 drivers/net/dsa/mt7530.h | 69 ++++++++++++++++++++++++++++++------------------
 2 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7f864f895ba0..39c47499036b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1147,7 +1147,7 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 		     PORT_SPEC_TAG);
 
 	/* Enable flooding on the CPU port */
-	mt7530_set(priv, MT7530_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
+	mt7530_set(priv, MT753X_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
 		   UNU_FFP(BIT(port)));
 
 	/* Add the CPU port to the CPU port bitmap for MT7531 and the switch on
@@ -1311,15 +1311,15 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
 			   flags.val & BR_LEARNING ? 0 : SA_DIS);
 
 	if (flags.mask & BR_FLOOD)
-		mt7530_rmw(priv, MT7530_MFC, UNU_FFP(BIT(port)),
+		mt7530_rmw(priv, MT753X_MFC, UNU_FFP(BIT(port)),
 			   flags.val & BR_FLOOD ? UNU_FFP(BIT(port)) : 0);
 
 	if (flags.mask & BR_MCAST_FLOOD)
-		mt7530_rmw(priv, MT7530_MFC, UNM_FFP(BIT(port)),
+		mt7530_rmw(priv, MT753X_MFC, UNM_FFP(BIT(port)),
 			   flags.val & BR_MCAST_FLOOD ? UNM_FFP(BIT(port)) : 0);
 
 	if (flags.mask & BR_BCAST_FLOOD)
-		mt7530_rmw(priv, MT7530_MFC, BC_FFP(BIT(port)),
+		mt7530_rmw(priv, MT753X_MFC, BC_FFP(BIT(port)),
 			   flags.val & BR_BCAST_FLOOD ? BC_FFP(BIT(port)) : 0);
 
 	return 0;
@@ -1855,20 +1855,6 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static int mt753x_mirror_port_get(unsigned int id, u32 val)
-{
-	return (id == ID_MT7531 || id == ID_MT7988) ?
-		       MT7531_MIRROR_PORT_GET(val) :
-		       MIRROR_PORT(val);
-}
-
-static int mt753x_mirror_port_set(unsigned int id, u32 val)
-{
-	return (id == ID_MT7531 || id == ID_MT7988) ?
-		       MT7531_MIRROR_PORT_SET(val) :
-		       MIRROR_PORT(val);
-}
-
 static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 				  struct dsa_mall_mirror_tc_entry *mirror,
 				  bool ingress, struct netlink_ext_ack *extack)
@@ -1884,14 +1870,14 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
 
 	/* MT7530 only supports one monitor port */
-	monitor_port = mt753x_mirror_port_get(priv->id, val);
+	monitor_port = MT753X_MIRROR_PORT_GET(priv->id, val);
 	if (val & MT753X_MIRROR_EN(priv->id) &&
 	    monitor_port != mirror->to_local_port)
 		return -EEXIST;
 
 	val |= MT753X_MIRROR_EN(priv->id);
-	val &= ~MT753X_MIRROR_MASK(priv->id);
-	val |= mt753x_mirror_port_set(priv->id, mirror->to_local_port);
+	val &= ~MT753X_MIRROR_PORT_MASK(priv->id);
+	val |= MT753X_MIRROR_PORT_SET(priv->id, mirror->to_local_port);
 	mt7530_write(priv, MT753X_MIRROR_REG(priv->id), val);
 
 	val = mt7530_read(priv, MT7530_PCR_P(port));
@@ -2533,7 +2519,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 	mt7530_mib_reset(ds);
 
 	/* Disable flooding on all ports */
-	mt7530_clear(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK |
+	mt7530_clear(priv, MT753X_MFC, BC_FFP_MASK | UNM_FFP_MASK |
 		     UNU_FFP_MASK);
 
 	for (i = 0; i < MT7530_NUM_PORTS; i++) {
@@ -3089,10 +3075,12 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 	else
 		priv->active_cpu_ports &= ~mask;
 
-	if (priv->active_cpu_ports)
-		val = CPU_EN | CPU_PORT(__ffs(priv->active_cpu_ports));
+	if (priv->active_cpu_ports) {
+		val = MT7530_CPU_EN |
+		      MT7530_CPU_PORT(__ffs(priv->active_cpu_ports));
+	}
 
-	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
+	mt7530_rmw(priv, MT753X_MFC, MT7530_CPU_EN | MT7530_CPU_PORT_MASK, val);
 }
 
 static int mt7988_setup(struct dsa_switch *ds)
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 0d5167f5ba6b..c6ef20b7bbdd 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -36,36 +36,55 @@ enum mt753x_id {
 #define MT753X_AGC			0xc
 #define  LOCAL_EN			BIT(7)
 
-/* Registers to mac forward control for unknown frames */
-#define MT7530_MFC			0x10
-#define  BC_FFP(x)			(((x) & 0xff) << 24)
-#define  BC_FFP_MASK			BC_FFP(~0)
-#define  UNM_FFP(x)			(((x) & 0xff) << 16)
-#define  UNM_FFP_MASK			UNM_FFP(~0)
-#define  UNU_FFP(x)			(((x) & 0xff) << 8)
-#define  UNU_FFP_MASK			UNU_FFP(~0)
-#define  CPU_EN				BIT(7)
-#define  CPU_PORT_MASK			GENMASK(6, 4)
-#define  CPU_PORT(x)			FIELD_PREP(CPU_PORT_MASK, x)
-#define  MIRROR_EN			BIT(3)
-#define  MIRROR_PORT(x)			((x) & 0x7)
-#define  MIRROR_MASK			0x7
-
-/* Registers for CPU forward control */
+/* Register for MAC forward control */
+#define MT753X_MFC			0x10
+#define  BC_FFP_MASK			GENMASK(31, 24)
+#define  BC_FFP(x)			FIELD_PREP(BC_FFP_MASK, x)
+#define  UNM_FFP_MASK			GENMASK(23, 16)
+#define  UNM_FFP(x)			FIELD_PREP(UNM_FFP_MASK, x)
+#define  UNU_FFP_MASK			GENMASK(15, 8)
+#define  UNU_FFP(x)			FIELD_PREP(UNU_FFP_MASK, x)
+#define  MT7530_CPU_EN			BIT(7)
+#define  MT7530_CPU_PORT_MASK		GENMASK(6, 4)
+#define  MT7530_CPU_PORT(x)		FIELD_PREP(MT7530_CPU_PORT_MASK, x)
+#define  MT7530_MIRROR_EN		BIT(3)
+#define  MT7530_MIRROR_PORT_MASK	GENMASK(2, 0)
+#define  MT7530_MIRROR_PORT_GET(x)	FIELD_GET(MT7530_MIRROR_PORT_MASK, x)
+#define  MT7530_MIRROR_PORT_SET(x)	FIELD_PREP(MT7530_MIRROR_PORT_MASK, x)
+#define  MT7531_QRY_FFP_MASK		GENMASK(7, 0)
+#define  MT7531_QRY_FFP(x)		FIELD_PREP(MT7531_QRY_FFP_MASK, x)
+
+/* Register for CPU forward control */
 #define MT7531_CFC			0x4
 #define  MT7531_MIRROR_EN		BIT(19)
-#define  MT7531_MIRROR_MASK		(MIRROR_MASK << 16)
-#define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & MIRROR_MASK)
-#define  MT7531_MIRROR_PORT_SET(x)	(((x) & MIRROR_MASK) << 16)
+#define  MT7531_MIRROR_PORT_MASK	GENMASK(18, 16)
+#define  MT7531_MIRROR_PORT_GET(x)	FIELD_GET(MT7531_MIRROR_PORT_MASK, x)
+#define  MT7531_MIRROR_PORT_SET(x)	FIELD_PREP(MT7531_MIRROR_PORT_MASK, x)
 #define  MT7531_CPU_PMAP_MASK		GENMASK(7, 0)
 #define  MT7531_CPU_PMAP(x)		FIELD_PREP(MT7531_CPU_PMAP_MASK, x)
 
-#define MT753X_MIRROR_REG(id)		((((id) == ID_MT7531) || ((id) == ID_MT7988)) ?	\
-					 MT7531_CFC : MT7530_MFC)
-#define MT753X_MIRROR_EN(id)		((((id) == ID_MT7531) || ((id) == ID_MT7988)) ?	\
-					 MT7531_MIRROR_EN : MIRROR_EN)
-#define MT753X_MIRROR_MASK(id)		((((id) == ID_MT7531) || ((id) == ID_MT7988)) ?	\
-					 MT7531_MIRROR_MASK : MIRROR_MASK)
+#define MT753X_MIRROR_REG(id)		((id == ID_MT7531 || \
+					  id == ID_MT7988) ? \
+					 MT7531_CFC : MT753X_MFC)
+
+#define MT753X_MIRROR_EN(id)		((id == ID_MT7531 || \
+					  id == ID_MT7988) ? \
+					 MT7531_MIRROR_EN : MT7530_MIRROR_EN)
+
+#define MT753X_MIRROR_PORT_MASK(id)	((id == ID_MT7531 || \
+					  id == ID_MT7988) ? \
+					 MT7531_MIRROR_PORT_MASK : \
+					 MT7530_MIRROR_PORT_MASK)
+
+#define MT753X_MIRROR_PORT_GET(id, val)	((id == ID_MT7531 || \
+					  id == ID_MT7988) ? \
+					 MT7531_MIRROR_PORT_GET(val) : \
+					 MT7530_MIRROR_PORT_GET(val))
+
+#define MT753X_MIRROR_PORT_SET(id, val)	((id == ID_MT7531 || \
+					  id == ID_MT7988) ? \
+					 MT7531_MIRROR_PORT_SET(val) : \
+					 MT7530_MIRROR_PORT_SET(val))
 
 /* Register for BPDU and PAE frame control */
 #define MT753X_BPC			0x24

-- 
2.40.1



