Return-Path: <linux-kernel+bounces-11822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165081EC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB2F1C22252
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5830153AB;
	Wed, 27 Dec 2023 04:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="kx6c4ABZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1346B8;
	Wed, 27 Dec 2023 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07E4F1C0003;
	Wed, 27 Dec 2023 04:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703652249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icw9vOVwt7dw4ced30DqL2oi7ni+F+KZa3W/XTt3JM4=;
	b=kx6c4ABZ3oirOhfT2Cqv+0E3TLx0ftm3rRd0XB4uIp8sMUsTWk7Kn80tKCcODWV3NdaDtI
	twZ8uldX/Mt3+pJnZDK7DKCrljg2cAxA4Kq/QAg7HLPYQ0pRmZCev2hacMqFBKmR8lSsAp
	7n3MQRhHhdBVRqXQmbSw7x83SDnGIIKfZGYi/batAMrWpPI/DeaFCY1QAVxLKMoioXbmcA
	oKubanng0GHjRotp5SsO5qV6kzv8xmg9mgq8EHT9pURIYLtI0ZrkHCjUHm09Ygu8di6D8H
	VGxfoym3bYv9NNbe5tAlHAC9Fvu0JgvNMIz9HykG0N1FcXZCtOyBoXAiyUQ4hg==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 1/7] net: dsa: mt7530: always trap frames to active CPU port on MT7530
Date: Wed, 27 Dec 2023 07:43:41 +0300
Message-Id: <20231227044347.107291-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227044347.107291-1-arinc.unal@arinc9.com>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On the MT7530 switch, the CPU_PORT field indicates which CPU port to trap
frames to, regardless of the affinity of the inbound user port.

When multiple CPU ports are in use, if the DSA conduit interface is down,
trapped frames won't be passed to the conduit interface.

To make trapping frames work including this case, implement
ds->ops->master_state_change() on this subdriver and set the CPU_PORT field
to the numerically smallest CPU port which the DSA conduit interface its
affine to is up. Introduce the active_cpu_ports field to store the
information of the active CPU ports. Correct the macros, CPU_PORT is bits 4
through 6 of the register.

Add a comment to explain frame trapping for this switch.

Currently, the driver doesn't support the use of multiple CPU ports so this
is not necessarily a bug fix.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 37 +++++++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h |  6 ++++--
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..436d5c311be0 100644
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
@@ -3075,6 +3071,38 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void
+mt753x_conduit_state_change(struct dsa_switch *ds,
+			    const struct net_device *conduit,
+			    bool operational)
+{
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct mt7530_priv *priv = ds->priv;
+	u8 mask;
+	int val = 0;
+
+	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
+	 * forwarded to the numerically smallest CPU port which the DSA conduit
+	 * interface its affine to is up.
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
+		val =
+		    CPU_EN |
+		    CPU_PORT(__ffs((unsigned long)priv->active_cpu_ports));
+
+	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
+}
+
 static int mt7988_pad_setup(struct dsa_switch *ds, phy_interface_t interface)
 {
 	return 0;
@@ -3130,6 +3158,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
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


