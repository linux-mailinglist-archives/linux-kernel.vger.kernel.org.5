Return-Path: <linux-kernel+bounces-136540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A7889D55C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83B8282061
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FC81204;
	Tue,  9 Apr 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XFtmtanh"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6207F482;
	Tue,  9 Apr 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654482; cv=none; b=W2/iILp/CiEsaab5Kr/fQ25KTM7K/7TXm1bzzE7nsupVTVYDdwKv8nC6mW6gHNtrQUCiN/kjF0eg1ja+UBBm9taBgzQwG2mQXCnxnWCGEmrFLeMugYW3s1RfnuKcQEZCbtdmdu0bsgUpryVxFsZ+yF+gYX7atAnHizWBy7EfrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654482; c=relaxed/simple;
	bh=0fIq0EiaoSUE8hihT4+KSPVneM0zHJ4IeA1fFweZO4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFEkaxwf9rdRRsP+cmYEQKeuXG4IeQDzhlXFZwjAVDdrPQQWnkwimE25qeltR2+S+0+nMVT/TQxGAmktiJ914S6sHWNYQHeFCG+YyF0D1OZewH/nnXU2YD2ZpcbDL2PVIReajWk0o31OwwcwFoODPhFy06SzN4/pWYwrO80tPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XFtmtanh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B6751BF213;
	Tue,  9 Apr 2024 09:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712654473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPfM5DXi3AOxcOxSFXD66Q2xnC+7MkQaEdZih6HEgsY=;
	b=XFtmtanhLu0vOCNKC0pqBEwASpKSq2H5FzNkHYa1WJ/dLzHQpZBR9vmbNZWJjFGpV4JrVQ
	cGdhBPLD+G9ZGYnpy8/zoD76IosZz93NqXeTfBj3P19NjuwiKUZWsO7BWCflu8ejhq7/FP
	tZXMJLKbWzcI4GKIEAUx3fN0loNTjrHF1ou0kbLWxGJJSx5iCP5pOkFQI35pYaxMwrYZfq
	R+JHjGPnzomRfAyyFd2ENXhlgOTjmIhoP2I/mYMos9+ZQX4gKcq/O+NCA5TTI+OxFh7jUA
	GqJczs5HTXA2shzL3bsp5bpMmJkdZUsDe3Bdts7xKPeEKZV5nor0+YjtgoCqIA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 09 Apr 2024 11:21:45 +0200
Subject: [PATCH net-next v2 2/5] net: stmmac: introduce pcs_init/pcs_exit
 stmmac operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-rzn1-gmac1-v2-2-79ca45f2fc79@bootlin.com>
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
In-Reply-To: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
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
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>
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
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++++
 include/linux/stmmac.h                            |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe3498e86de9..25fa33ae7017 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7208,6 +7208,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (ret)
 		return ret;
 
+	if (priv->plat->pcs_init) {
+		ret = priv->plat->pcs_init(priv, priv->hw);
+		if (ret)
+			return ret;
+	}
+
 	/* Get the HW capability (new GMAC newer than 3.50a) */
 	priv->hw_cap_support = stmmac_get_hw_features(priv);
 	if (priv->hw_cap_support) {
@@ -7290,6 +7296,12 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	return 0;
 }
 
+static void stmmac_hw_exit(struct stmmac_priv *priv)
+{
+	if (priv->plat->pcs_exit)
+		priv->plat->pcs_exit(priv, priv->hw);
+}
+
 static void stmmac_napi_add(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -7804,6 +7816,7 @@ int stmmac_dvr_probe(struct device *device,
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
 error_mdio_register:
+	stmmac_hw_exit(priv);
 	stmmac_napi_del(ndev);
 error_hw_init:
 	destroy_workqueue(priv->wq);
@@ -7844,6 +7857,7 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
+	stmmac_hw_exit(priv);
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dfa1828cd756..941fde506e51 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -285,6 +285,8 @@ struct plat_stmmacenet_data {
 	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
 			   void *ctx);
 	void (*dump_debug_regs)(void *priv);
+	int (*pcs_init)(struct stmmac_priv *priv, struct mac_device_info *hw);
+	void (*pcs_exit)(struct stmmac_priv *priv, struct mac_device_info *hw);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;

-- 
2.44.0


