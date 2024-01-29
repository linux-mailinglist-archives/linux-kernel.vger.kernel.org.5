Return-Path: <linux-kernel+bounces-42937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5757B8408E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096311F275C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831F1272A8;
	Mon, 29 Jan 2024 14:45:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979A2E415
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539515; cv=none; b=du8HLrXwlDKFyw3e+d7lBXXbOyI9Lg8a0Il1tM0BXJRVfH6dnC70XPBVz2bC6zjDMvH1dZKxFfxQAf7R1kpVCTycpxX5VhP/mVShtTzQ31fJ463GTRtEOfqTIMDlCYE2IbXi/ml/9hqbkEUaeGib8MUnCpwTx4xIjAjqjeVbF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539515; c=relaxed/simple;
	bh=P5A9cVY+kgbiczbcyuHDJR+vgp6zcgnAKEZ9flYpJn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VgiMOKmDUKwZRcZKQkNPlCCDA3ChkOfZrmBPk/T+WXu9MYulpYMsw+m7GjLUBQdqTPc57AMDCt4mG0VatAKvupXbO3tEi8j/ytDWSGtLDSpRIISjA2rEnqzquuRCKijBDomd38XILsif/+G2fSeDHf3inAXsDwJuK4WvZhZfYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rUSsh-0003FF-Fg; Mon, 29 Jan 2024 15:45:03 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rUSsg-003Cu0-78; Mon, 29 Jan 2024 15:45:02 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>,
	James Gowans <jgowans@amazon.com>,
	Koichiro Den <den@valinux.co.jp>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH] genirq: use relaxed access by default for irq_reg_{readl,writel}
Date: Mon, 29 Jan 2024 15:45:02 +0100
Message-Id: <20240129144502.1828154-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

irqchip access does not require any memory ordering between other
memory transactions and the IRQ controller peripheral access.
As all architectures now implement the relaxed MMIO accessors we
can switch the irq_reg_{readl,writel} helpers to use them, in
order to avoid potentially costly barriers in the IRQ handling
hotpath.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 include/linux/irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 90081afa10ce..fa1597db7887 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1218,7 +1218,7 @@ static inline void irq_reg_writel(struct irq_chip_generic *gc,
 	if (gc->reg_writel)
 		gc->reg_writel(val, gc->reg_base + reg_offset);
 	else
-		writel(val, gc->reg_base + reg_offset);
+		writel_relaxed(val, gc->reg_base + reg_offset);
 }
 
 static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
@@ -1227,7 +1227,7 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 	if (gc->reg_readl)
 		return gc->reg_readl(gc->reg_base + reg_offset);
 	else
-		return readl(gc->reg_base + reg_offset);
+		return readl_relaxed(gc->reg_base + reg_offset);
 }
 
 struct irq_matrix;
-- 
2.39.2


