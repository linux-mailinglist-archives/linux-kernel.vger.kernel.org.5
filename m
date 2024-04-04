Return-Path: <linux-kernel+bounces-131876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE7898D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59D828EF42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A78912DDA4;
	Thu,  4 Apr 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A69wDDpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAC12BEBC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250708; cv=none; b=k6dscxzT7VuH3D/sBzEpsBqK57qDsUIZXDfbtV8HRg1hMIlzzq7kGabJ9R2CZgeqjlIJpzjjaye4IrOtXTC8o10MJKcAs7JnsB08USdiD6GZcXZzW3xv8eguNpuSa7xL3izOpYxO2y3BXciZIoYAUMIm3rx+VzBTNRhWTFT7V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250708; c=relaxed/simple;
	bh=seA14bpe1BODpthUIDxlQN39xfT0KeBxv5Uo0us43vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JofKZwCGSV/VTZhlxLbQBnDQANYTC0jhzNbNt6t68JKbcgQHtMpoS2lLYMxaIf1hu753SpC5F7jq9a6E3irIE8HSIx8Y7D0S4ZKymY6j/LUdHm22XT3RHOcr8YZ0NeXfmvHXBScKIO4o39+cKJmQkSMspw/MdqAc4TyKgqpGZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A69wDDpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A95DC433F1;
	Thu,  4 Apr 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712250708;
	bh=seA14bpe1BODpthUIDxlQN39xfT0KeBxv5Uo0us43vQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A69wDDpjjxVjZ74EDGkr6RX7trWA3JxZAc+kKLOckuOVYxigq9tUchL8+iLGoTbma
	 oj0bOVho23p4z/YSYLXFVvOXi00eUqc2GZJepwa/7jLbVB3xUaXanaQ/p5SshwoL+Q
	 I2XjLmeVJ+JXWV7agV+Dp52SpI7ze8v+F0C+A1q1QMwEpM1Xs91OIZdaYy+o8ZmRHb
	 W4MbNEdcwr+rXNlkXNyyzZ1FKwKjFNL7rxHLncJ2ssQtBNjX2KtutDq/BhNq34CarR
	 Hmz8UtA9qRIA3ZqaJ7ZN6aeDb8QglOQ2sbxW/p38lGPiEQsiUaZtvbrbHxOESgAhzj
	 cC3aSsSjVn62g==
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0093D4800D0; Thu,  4 Apr 2024 19:11:45 +0200 (CEST)
From: Sebastian Reichel <sre@kernel.org>
Date: Thu, 04 Apr 2024 19:11:28 +0200
Subject: [PATCH 3/3] phy: rockchip: naneng-combphy: Fix mux on rk3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-rk3588-pcie-bifurcation-fixes-v1-3-9907136eeafd@kernel.org>
References: <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
In-Reply-To: <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Tomek <mtdev79b@gmail.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; i=sre@kernel.org;
 h=from:subject:message-id; bh=MUZluWX649SgZzXuKQn/BISKnYrBbHIpu81ShZbPzX8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGYO31HdH9N8d1uLAozp3+LD80iwgDJVmCFYt
 atmXGb1IwAWz4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJmDt9RAAoJENju1/PI
 O/qazHQP/2ErjX9stm90A5BTm9bOsa1YuinkYvCFJrb8aum7Z+yzihekKxlTB5kxFTJntQiT85/
 nNjXAZHKgKW99lPlNX+9qaDm78U8uTVy6q2ACfB+RU8gStmfuXUpwcuogoXIOBZ20LGRt69ZWmw
 aufWqVnbsJ2zE+bU6alZGHf97NdHbZpLtKfW02Vkx6MlbevO0tuXjAf0F4I3QR2yAkeFPE0N8nx
 KZ/WmREhZ7QTQGHB7dUWP2fU7hdJUHxto8XXxvv6KPA9PpvAvVjSRIrIQ65vVS5By4at1x3umjC
 eLhuTiLT6F2Zidk6qmwB11DTOI1+T8NP32ajCsW/u7oiUuJjT9TY6qujT2w84uIY/Cu0xFzySQH
 jsNgv3SIOxN2VgNEj6eyx5QvgpTkCaYr9AorVLWSUhlC5mIvOANHDiul3mfxxBL3NABNqEpXPkS
 /S+u8QyRXM8ab2cncOl9VkAGEhJt8Ux3Km9PGcSAYLnXH4I4TDh1P1q+Jf9D9oMMOoLFDjrZ84T
 Uzagx8r9GSu00X8IFrBr0X48gZNtcAnzoXPRNdRLcVDNobXKWyJ/KkWqxCIC+HZbKWExTrt0ZUq
 fYywmP2Np67LX8B4HyVVFJeBVIAq8FqWcdsh5aNF2Lx4ZmQQgcxY3hWbOKZiF+CD13+Oso16OLC
 38ceCAaBbvl1GWjt481czYg==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Sebastian Reichel <sebastian.reichel@collabora.com>

The pcie1l0_sel and pcie1l1_sel bits in PCIESEL_CON configure the
mux for PCIe1L0 and PCIe1L1 to either the PIPE Combo PHYs or the
PCIe3 PHY. Thus this configuration interfers with the data-lanes
configuration done by the PCIe3 PHY.

RK3588 has three Combo PHYs. The first one has a dedicated PCIe
controller and is not affected by this. For the other two Combo
PHYs, there is one mux for each of them.

pcie1l0_sel selects if PCIe 1L0 is muxed to Combo PHY 1 when
bit is set to 0 or to the PCIe3 PHY when bit is set to 1.

pcie1l1_sel selects if PCIe 1L1 is muxed to Combo PHY 2 when
bit is set to 0 or to the PCIe3 PHY when bit is set to 1.

Currently the code always muxes 1L0 and 1L1 to the Combi PHYs
once one of them is being used in PCIe mode. This is obviously
wrong when at least one of the ports should be muxed to the
PCIe3 PHY.

Fix this by introducing Combo PHY identification and then only
setting up the required bit.

Fixes: a03c44277253 ("phy: rockchip: Add naneng combo phy support for RK3588")
Reported-by: Michal Tomek <mtdev79b@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 36 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 76b9cf417591..bf74e429ff46 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -125,12 +125,15 @@ struct rockchip_combphy_grfcfg {
 };
 
 struct rockchip_combphy_cfg {
+	unsigned int num_phys;
+	unsigned int phy_ids[3];
 	const struct rockchip_combphy_grfcfg *grfcfg;
 	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
 };
 
 struct rockchip_combphy_priv {
 	u8 type;
+	int id;
 	void __iomem *mmio;
 	int num_clks;
 	struct clk_bulk_data *clks;
@@ -320,7 +323,7 @@ static int rockchip_combphy_probe(struct platform_device *pdev)
 	struct rockchip_combphy_priv *priv;
 	const struct rockchip_combphy_cfg *phy_cfg;
 	struct resource *res;
-	int ret;
+	int ret, id;
 
 	phy_cfg = of_device_get_match_data(dev);
 	if (!phy_cfg) {
@@ -338,6 +341,15 @@ static int rockchip_combphy_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* find the phy-id from the io address */
+	priv->id = -ENODEV;
+	for (id = 0; id < phy_cfg->num_phys; id++) {
+		if (res->start == phy_cfg->phy_ids[id]) {
+			priv->id = id;
+			break;
+		}
+	}
+
 	priv->dev = dev;
 	priv->type = PHY_NONE;
 	priv->cfg = phy_cfg;
@@ -562,6 +574,12 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
 };
 
 static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
+	.num_phys = 3,
+	.phy_ids = {
+		0xfe820000,
+		0xfe830000,
+		0xfe840000,
+	},
 	.grfcfg		= &rk3568_combphy_grfcfgs,
 	.combphy_cfg	= rk3568_combphy_cfg,
 };
@@ -578,8 +596,14 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
-		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
-		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
+		switch (priv->id) {
+		case 1:
+			rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
+			break;
+		case 2:
+			rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
+			break;
+		}
 		break;
 	case PHY_TYPE_USB3:
 		/* Set SSC downward spread spectrum */
@@ -736,6 +760,12 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
 };
 
 static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
+	.num_phys = 3,
+	.phy_ids = {
+		0xfee00000,
+		0xfee10000,
+		0xfee20000,
+	},
 	.grfcfg		= &rk3588_combphy_grfcfgs,
 	.combphy_cfg	= rk3588_combphy_cfg,
 };

-- 
2.43.0


