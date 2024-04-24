Return-Path: <linux-kernel+bounces-156599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEBD8B0565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8991C239D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0981591EE;
	Wed, 24 Apr 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YB/euR5J"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8606157482;
	Wed, 24 Apr 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949553; cv=none; b=j1yI9nIVsYJWfWtkJS1OQMG00GPcK3c8Kh72oOtd1Dj+LJkCIkrSF1ieB/xfnbe9FtyV7wur9ivcx+8fNqnGK65grztetJ/RIQAFKidGPfpswjVDQ7cm0SyunmHO0zXu9cZLzm1xlolKXR+vi4kFVLZKjYS6Rpa4gP05YHi3AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949553; c=relaxed/simple;
	bh=RYi0++8u2X9c6dtV/xZRa3mc1bjAR7oL65UDBW4WRgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxCH1r3MHsO9WImvFHQxieYEbD2xZH/VNzSu+7WynE+iI0IT2cKzOm1DKO22gllFARtRB4lwIMQ4eumjikcZNHOfhYLEDNOcxl50Xsgxl3Ps+t24rCAnd8YRES2uVNSv8nHUIdYFSZJwy0y87HqxrQ+iKYO2+f5nmeclUuDqdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YB/euR5J; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC8932000E;
	Wed, 24 Apr 2024 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713949547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPM2kEMf15wkRNUvXrLz3uHBj6EMXfPCHtn3BLrRChk=;
	b=YB/euR5J/Z8B/HqLgK4Od31HxrAfKd2VgUdvtO8x8fwZohgTkm/xrSelB4wLLAJ0wEpMU8
	ILPjBahUDsGDu2UVv4EcwaTLg39lcsQPoEfWjb6Ru9C/a7OEY4o7XiKPMM2bqqAxIZIt33
	snE07FB4uZRr5OWFOWZwtuF3nKIt6Jr7NhORJ5S9L+HpLQjA7fk0SRQPF6ESoC2I2oB4bK
	djn5btNL31RKRxMLw1fmF7CozNbbdN/j8XMBsW2CfYsnesXbalkQ/pcqwnvZ9tTyLOkEDj
	cUuna/7mqKhqGwgCvt6hl0PI+KMBjTCzk6/3K48gdJztVLN+vg2BpIQ6cAFjeg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 24 Apr 2024 11:06:20 +0200
Subject: [PATCH net-next v4 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rzn1-gmac1-v4-2-852a5f2ce0c0@bootlin.com>
References: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com>
In-Reply-To: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: romain.gantois@bootlin.com

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Introduce a mechanism whereby platforms can create their PCS instances
prior to the network device being published to userspace, but after
some of the core stmmac initialisation has been completed. This means
that the data structures that platforms need will be available.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
[rgantois: removed second parameters of new callbacks]
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++++
 include/linux/stmmac.h                            |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59bf83904b62d..bee9c9ab31a88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7200,6 +7200,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (ret)
 		return ret;
 
+	if (priv->plat->pcs_init) {
+		ret = priv->plat->pcs_init(priv);
+		if (ret)
+			return ret;
+	}
+
 	/* Get the HW capability (new GMAC newer than 3.50a) */
 	priv->hw_cap_support = stmmac_get_hw_features(priv);
 	if (priv->hw_cap_support) {
@@ -7282,6 +7288,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	return 0;
 }
 
+static void stmmac_hw_exit(struct stmmac_priv *priv)
+{
+	if (priv->plat->pcs_exit)
+		priv->plat->pcs_exit(priv);
+}
+
 static void stmmac_napi_add(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -7795,6 +7807,7 @@ int stmmac_dvr_probe(struct device *device,
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
 error_mdio_register:
+	stmmac_hw_exit(priv);
 	stmmac_napi_del(ndev);
 error_hw_init:
 	destroy_workqueue(priv->wq);
@@ -7835,6 +7848,7 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
+	stmmac_hw_exit(priv);
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756a..4a24a246c617d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -285,6 +285,8 @@ struct plat_stmmacenet_data {
 	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
 			   void *ctx);
 	void (*dump_debug_regs)(void *priv);
+	int (*pcs_init)(struct stmmac_priv *priv);
+	void (*pcs_exit)(struct stmmac_priv *priv);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;

-- 
2.44.0


