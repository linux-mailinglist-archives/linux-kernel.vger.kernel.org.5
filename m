Return-Path: <linux-kernel+bounces-64961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F09854531
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9294D286540
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C3E171C8;
	Wed, 14 Feb 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OF2YRymp"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3012B61;
	Wed, 14 Feb 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902908; cv=none; b=bntmwhp5zppDUfocH2APDERAsD8nvHqrOlq8ou8JZHiPEYk67IUbnagjr6ipwwNptD+NQN2a02WR4Z5RXeTHc25K8AcWpbQmiCHLeiHPjztQub3LoZFzJIWlpJwzFj5cJl76kA/Db1aIABi8KYbhtxQl2qw4rsTm57fvSYTSNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902908; c=relaxed/simple;
	bh=Mb6YxOmtcJ8Ub0l9X+yNHlgp/DjEXeH/cebfjQyMkP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg/47PjiFi4Ux2hz614aYSIIboSM24547PBUzQjidMlxk4x7TuGSrG1k2Uf7HYNoCumPDUMK8VzPb/LY1FsaaENGdpFDhsnp8P6U0KDFEbXMA+06ZFnWjDlCrhbX0KuoI7sZVgeUzyJ46EjuMnDtvNWR3s92+25b6eKiI+ceyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=OF2YRymp; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [85.89.126.105])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8ABD2407672A;
	Wed, 14 Feb 2024 09:28:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8ABD2407672A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707902896;
	bh=VPs3SFZb3IOFTfYaDQIVN+l4DqNHEqyJHkJJnFGGUPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OF2YRymp0cVZzJyXtUILvhN8lfre24hOBN/XyofoROp2Xf8dZ1rsPQzpGJzC3G+/F
	 vrJOG1GVAertAUUCgLBQ7g4AP/tNzenhe8wRW2CUofP51heor82z4gxWfQtjtj/NAc
	 tjELpTMuxUbB/2jjnOxi3D05OwdcWoxeK14c3R/k=
From: Pavel Sakharov <p.sakharov@ispras.ru>
To: Simon Horman <horms@kernel.org>
Cc: Pavel Sakharov <p.sakharov@ispras.ru>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH net v2] net: stmmac: Fix incorrect dereference in interrupt handlers
Date: Wed, 14 Feb 2024 12:27:17 +0300
Message-ID: <20240214092718.331891-1-p.sakharov@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206150704.GD1104779@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'dev' or 'data' is NULL, the 'priv' variable has an incorrect address
when dereferencing calling netdev_err().

Since we get as 'dev_id' or 'data' what was passed as the 'dev' argument
to request_irq() during interrupt initialization (that is, the net_device
and rx/tx queue pointers initialized at the time of the call) and since
there are usually no checks for the 'dev_id' argument in such handlers
in other drivers, remove these checks from the handlers in stmmac driver.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")
Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>
---
v2: Drop the second argument checks in the handlers as suggested by Serge Semin <fancer.lancer@gmail.com>.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 75d029704503..e80d77bd9f1f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6059,11 +6059,6 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (unlikely(!dev)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6079,11 +6074,6 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (unlikely(!dev)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6105,11 +6095,6 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 	dma_conf = container_of(tx_q, struct stmmac_dma_conf, tx_queue[chan]);
 	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
 
-	if (unlikely(!data)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6136,11 +6121,6 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 	dma_conf = container_of(rx_q, struct stmmac_dma_conf, rx_queue[chan]);
 	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
 
-	if (unlikely(!data)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
-- 
2.43.0


