Return-Path: <linux-kernel+bounces-32331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055CC835A52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892D11F23594
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3786AD7;
	Mon, 22 Jan 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O58BuPXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DB4C89;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901758; cv=none; b=O7iKWdD9mc5PFB74DsSjkffaZ9ZwI8t/8qFkJQiQwxd6GQvslIGjxfTZhpn+s/WCasogXLDMNhmmoH7NBH6JmQhbIWhG474iFSFtk8bjGByaupXHqoCdorhE3HVD8SjQ4WhfGsLxOU/EUqc4Pfg9ruxLlZJusfH98IdbnFL1GSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901758; c=relaxed/simple;
	bh=BJnOeS65sq0ctJq5UOVZ2WxdttW9vz25dwKp4xbPBfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqiISEDFc+nb+/WUx84sDQYfPa9PGjwjNZHhgREnzol9r4R3HvvG8vY4RiMN3fl+PmMwnwHEzqES+kehAxhvUkUID3T4r9RWbwHB4FZ2UWhK05gEeIu/FOYqmoZwch1TtTtxgfYBZES6ff7iltWRDqQmKkdwNgaoMKtJCxlw80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O58BuPXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37309C433F1;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705901758;
	bh=BJnOeS65sq0ctJq5UOVZ2WxdttW9vz25dwKp4xbPBfc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O58BuPXmDB3kntKMblO13Z8kSWaTk2SeOjB/cNBiY4q4ET0d+WajAYCGaxy1C24/X
	 5eYJzqKIPfpT7ejDHYEhAoHW1Fk7tUULodwryVm7hDVg4qA2T8+uWsUXM2ZBluV+/R
	 EVB4NoOsntfxjilrt9+HZpwjCUiq1uMVuayHfN4ItQJAhPtS0okpG7qDV2GVUE4mI2
	 IPYopn/kn3If9zQ2DfwloS9Zq16tESXx/ILtYjEM/0I9MHaHANp5Oler/HurMjbIaV
	 ef8dR+4gwhSmr74N1Qt7NKi9p97y1n5HnkUYgfKldryh38V4ZjZMA1mBR//rB0jnXj
	 1TGefU2/xruXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC98C47DD3;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Jan 2024 08:35:52 +0300
Subject: [PATCH net-next v3 1/7] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240122-for-netnext-mt7530-improvements-1-v3-1-042401f2b279@arinc9.com>
References:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
In-Reply-To:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705901755; l=4314;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=OahuM/i2rvjHeE74Gk7po9F6EBBznn5IwSvSniGSaV0=;
 b=Tdp4jqS5p+QOFq8gzefgBM65crsiy194Phw6aAQVLvMNPC2qLMjNXHRYGMeSIs66WwnOrc0YK
 KoKmm10jNroBRbt3dDStrqDwLZQ3izsAPTX+dvPz1aKJnhYJNVNrne+
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

On the MT7530 switch, the CPU_PORT field indicates which CPU port to trap
frames to, regardless of the affinity of the inbound user port.

When multiple CPU ports are in use, if the DSA conduit interface is down,
trapped frames won't be passed to the conduit interface.

To make trapping frames work including this case, implement
ds->ops->conduit_state_change() on this subdriver and set the CPU_PORT
field to the numerically smallest CPU port whose conduit interface is up.
Introduce the active_cpu_ports field to store the information of the active
CPU ports. Correct the macros, CPU_PORT is bits 4 through 6 of the
register.

Add a comment to explain frame trapping for this switch.

Currently, the driver doesn't support the use of multiple CPU ports so this
is not necessarily a bug fix.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 35 +++++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h |  6 ++++--
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..761c4804449a 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1035,10 +1035,6 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	mt7530_set(priv, MT7530_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
 		   UNU_FFP(BIT(port)));
 
-	/* Set CPU port number */
-	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
-		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
-
 	/* Add the CPU port to the CPU port bitmap for MT7531 and the switch on
 	 * the MT7988 SoC. Trapped frames will be forwarded to the CPU port that
 	 * is affine to the inbound user port.
@@ -3075,6 +3071,36 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void
+mt753x_conduit_state_change(struct dsa_switch *ds,
+			    const struct net_device *conduit,
+			    bool operational)
+{
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct mt7530_priv *priv = ds->priv;
+	int val = 0;
+	u8 mask;
+
+	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
+	 * forwarded to the numerically smallest CPU port whose conduit
+	 * interface is up.
+	 */
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
+		return;
+
+	mask = BIT(cpu_dp->index);
+
+	if (operational)
+		priv->active_cpu_ports |= mask;
+	else
+		priv->active_cpu_ports &= ~mask;
+
+	if (priv->active_cpu_ports)
+		val = CPU_EN | CPU_PORT(__ffs(priv->active_cpu_ports));
+
+	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
+}
+
 static int mt7988_pad_setup(struct dsa_switch *ds, phy_interface_t interface)
 {
 	return 0;
@@ -3130,6 +3156,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.phylink_mac_link_up	= mt753x_phylink_mac_link_up,
 	.get_mac_eee		= mt753x_get_mac_eee,
 	.set_mac_eee		= mt753x_set_mac_eee,
+	.conduit_state_change	= mt753x_conduit_state_change,
 };
 EXPORT_SYMBOL_GPL(mt7530_switch_ops);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 17e42d30fff4..ebfb3a7acfcd 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -41,8 +41,8 @@ enum mt753x_id {
 #define  UNU_FFP(x)			(((x) & 0xff) << 8)
 #define  UNU_FFP_MASK			UNU_FFP(~0)
 #define  CPU_EN				BIT(7)
-#define  CPU_PORT(x)			((x) << 4)
-#define  CPU_MASK			(0xf << 4)
+#define  CPU_PORT_MASK			GENMASK(6, 4)
+#define  CPU_PORT(x)			FIELD_PREP(CPU_PORT_MASK, x)
 #define  MIRROR_EN			BIT(3)
 #define  MIRROR_PORT(x)			((x) & 0x7)
 #define  MIRROR_MASK			0x7
@@ -760,6 +760,7 @@ struct mt753x_info {
  * @irq_domain:		IRQ domain of the switch irq_chip
  * @irq_enable:		IRQ enable bits, synced to SYS_INT_EN
  * @create_sgmii:	Pointer to function creating SGMII PCS instance(s)
+ * @active_cpu_ports:	Holding the active CPU ports
  */
 struct mt7530_priv {
 	struct device		*dev;
@@ -786,6 +787,7 @@ struct mt7530_priv {
 	struct irq_domain *irq_domain;
 	u32 irq_enable;
 	int (*create_sgmii)(struct mt7530_priv *priv, bool dual_sgmii);
+	u8 active_cpu_ports;
 };
 
 struct mt7530_hw_vlan_entry {

-- 
2.40.1


