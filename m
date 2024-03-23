Return-Path: <linux-kernel+bounces-112467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E30887A36
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C3E1C20B47
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E659B57;
	Sat, 23 Mar 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I3rtbZhi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ZumxDFc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340DC54675
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711223525; cv=none; b=bytgAEExE6uaFg0mbkOC+vPX2LLSlYjlk3ZlVL/+1gt117R1wal+ip+pUCT27NdeGaPV3AReA6suyqsyzVvLfLDJ3p3dYnPEDGb+8F3mSG3yNTJiaVmFJ6gVUoKOdQAkL8JFBCtT4IBb370RrRVcvftUqjJ5piXyD5tESSoWezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711223525; c=relaxed/simple;
	bh=3hBu6JGfwnANydjRy0qGyXicX1PZYHy+wpz5cmdmvYU=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=Axptjaha2T8LASa14VoRQ/3Ajfcg0EeV76Ya0S4ldjRaKYGMqofS+cTXc6Vn4bfdT3i8X7sM9fER+uxLB11PEXDsRilV+JE5Yy84W6bajNAfiNJbCjfnrL7VK1ecR9R7cHtvuaxbjnrp4lCR0ahN9dD//kQuJcqWBGIqb12BCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I3rtbZhi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ZumxDFc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711223521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=mnvLml7Sp1CnFF1iVOX2L/3pT5OaaPjoAsx4yR5NNCI=;
	b=I3rtbZhijiPHd7fRDIXqqVBm0Bsx52Q0Q62l001d6X09Tw8Ly/h7QoxoiOrNW/bRaKTJYo
	Wo6wRlBtGVe1WL9yQps6PyWm0Dkwn2QxL41k128LmdjMSlowmP2aimT3qjf3XTgNwtAiNe
	Egl0bLXm215rVhrg+Arps0PY5kk76WwmyVfIjJkiCP/xCz2MXgTgkBIRV7o/++z9/m8Guh
	7dfs1BJp2evpH6ohFPOzlU6YmWt5v+/g2rWtyrDZgRggiZ02a7igtiAAXInmfoXk2ICtlz
	14GiBn6f+7PhvgryKtmoToi+kJNLOGtLROAeazuKISSbgiuCoSl+y5xfh9da0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711223521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=mnvLml7Sp1CnFF1iVOX2L/3pT5OaaPjoAsx4yR5NNCI=;
	b=7ZumxDFc6m3b+5S5iQyYw40XpqR/2VjUbKEB5i3dBxF9k7py2iHb/QuoI/StGEb90vfG9F
	9htznvK1smR0sXAg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.9-rc1
References: <171122346785.2772088.10596056144848184713.tglx@xen13>
Message-ID: <171122346956.2772088.12525594748449004875.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 23 Mar 2024 20:52:00 +0100 (CET)

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-=
03-23

up to:  dce0919c83c3: irqchip/renesas-rzg2l: Do not set TIEN and TINT source =
at the same time

A series of fixes for the Renesas RZG21 interrupt chip driver to prevent
spurious and misrouted interrupts.

  - Ensure that posted writes are flushed in the eoi() callback

  - Ensure that interrupts are masked at the chip level when the trigger
    type is changed

  - Clear the interrupt status register when setting up edge type trigger
    modes.

  - Ensure that the trigger type and routing information is set before the
    interrupt is enabled.

Thanks,

	tglx

------------------>
Biju Das (5):
      irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
      irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger=
 type
      irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time


 drivers/irqchip/irq-renesas-rzg2l.c | 72 +++++++++++++++++++++++++++--------=
--
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 9494fc26259c..ae67fec2ab46 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -85,10 +85,9 @@ static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq=
_data *data)
 	return data->domain->host_data;
 }
=20
-static void rzg2l_irq_eoi(struct irq_data *d)
+static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int h=
wirq)
 {
-	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
-	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hw_irq =3D hwirq - IRQC_IRQ_START;
 	u32 bit =3D BIT(hw_irq);
 	u32 iitsr, iscr;
=20
@@ -99,20 +98,30 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
 	 * falling/rising-edge.
 	 */
-	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq))) {
 		writel_relaxed(iscr & ~bit, priv->base + ISCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + ISCR);
+	}
 }
=20
-static void rzg2l_tint_eoi(struct irq_data *d)
+static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int =
hwirq)
 {
-	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_TINT_START;
-	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
-	u32 bit =3D BIT(hw_irq);
+	u32 bit =3D BIT(hwirq - IRQC_TINT_START);
 	u32 reg;
=20
 	reg =3D readl_relaxed(priv->base + TSCR);
-	if (reg & bit)
+	if (reg & bit) {
 		writel_relaxed(reg & ~bit, priv->base + TSCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + TSCR);
+	}
 }
=20
 static void rzg2l_irqc_eoi(struct irq_data *d)
@@ -122,9 +131,9 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
=20
 	raw_spin_lock(&priv->lock);
 	if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
-		rzg2l_irq_eoi(d);
+		rzg2l_clear_irq_int(priv, hw_irq);
 	else if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
-		rzg2l_tint_eoi(d);
+		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);
 	irq_chip_eoi_parent(d);
 }
@@ -142,7 +151,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
=20
 		raw_spin_lock(&priv->lock);
 		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &=3D ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+		reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
@@ -154,7 +163,6 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq =3D irqd_to_hwirq(d);
=20
 	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		unsigned long tint =3D (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
 		u32 offset =3D hw_irq - IRQC_TINT_START;
 		u32 tssr_offset =3D TSSR_OFFSET(offset);
@@ -163,7 +171,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
=20
 		raw_spin_lock(&priv->lock);
 		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |=3D (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
+		reg |=3D TIEN << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
@@ -172,8 +180,10 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
=20
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+	u32 iitseln =3D hwirq - IRQC_IRQ_START;
+	bool clear_irq_int =3D false;
 	u16 sense, tmp;
=20
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -183,14 +193,17 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsig=
ned int type)
=20
 	case IRQ_TYPE_EDGE_FALLING:
 		sense =3D IITSR_IITSEL_EDGE_FALLING;
+		clear_irq_int =3D true;
 		break;
=20
 	case IRQ_TYPE_EDGE_RISING:
 		sense =3D IITSR_IITSEL_EDGE_RISING;
+		clear_irq_int =3D true;
 		break;
=20
 	case IRQ_TYPE_EDGE_BOTH:
 		sense =3D IITSR_IITSEL_EDGE_BOTH;
+		clear_irq_int =3D true;
 		break;
=20
 	default:
@@ -199,21 +212,40 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsig=
ned int type)
=20
 	raw_spin_lock(&priv->lock);
 	tmp =3D readl_relaxed(priv->base + IITSR);
-	tmp &=3D ~IITSR_IITSEL_MASK(hw_irq);
-	tmp |=3D IITSR_IITSEL(hw_irq, sense);
+	tmp &=3D ~IITSR_IITSEL_MASK(iitseln);
+	tmp |=3D IITSR_IITSEL(iitseln, sense);
+	if (clear_irq_int)
+		rzg2l_clear_irq_int(priv, hwirq);
 	writel_relaxed(tmp, priv->base + IITSR);
 	raw_spin_unlock(&priv->lock);
=20
 	return 0;
 }
=20
+static u32 rzg2l_disable_tint_and_set_tint_source(struct irq_data *d, struct=
 rzg2l_irqc_priv *priv,
+						  u32 reg, u32 tssr_offset, u8 tssr_index)
+{
+	u32 tint =3D (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	u32 tien =3D reg & (TIEN << TSSEL_SHIFT(tssr_offset));
+
+	/* Clear the relevant byte in reg */
+	reg &=3D ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+	/* Set TINT and leave TIEN clear */
+	reg |=3D tint << TSSEL_SHIFT(tssr_offset);
+	writel_relaxed(reg, priv->base + TSSR(tssr_index));
+
+	return reg | tien;
+}
+
 static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
 	unsigned int hwirq =3D irqd_to_hwirq(d);
 	u32 titseln =3D hwirq - IRQC_TINT_START;
+	u32 tssr_offset =3D TSSR_OFFSET(titseln);
+	u8 tssr_index =3D TSSR_INDEX(titseln);
 	u8 index, sense;
-	u32 reg;
+	u32 reg, tssr;
=20
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -235,10 +267,14 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsi=
gned int type)
 	}
=20
 	raw_spin_lock(&priv->lock);
+	tssr =3D readl_relaxed(priv->base + TSSR(tssr_index));
+	tssr =3D rzg2l_disable_tint_and_set_tint_source(d, priv, tssr, tssr_offset,=
 tssr_index);
 	reg =3D readl_relaxed(priv->base + TITSR(index));
 	reg &=3D ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |=3D sense << (titseln * TITSEL_WIDTH);
 	writel_relaxed(reg, priv->base + TITSR(index));
+	rzg2l_clear_tint_int(priv, hwirq);
+	writel_relaxed(tssr, priv->base + TSSR(tssr_index));
 	raw_spin_unlock(&priv->lock);
=20
 	return 0;


