Return-Path: <linux-kernel+bounces-132042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE488898F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9D41C281E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849BF13440C;
	Thu,  4 Apr 2024 19:31:02 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E86133439
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259062; cv=none; b=IfnZfoTadiDmaBpvVtt8QdYBouZQcQwbCWSp3SXnAr53kM5K+EXf/uBFbkBrap509ypkZNdsDWCKSXVHd9VDmEBaE+ZYNxhaTsmZuMN+TwbN9ZYVpqc0z82p5aVHdh7iO1mWyKNWSffxwq+OnIUvT1rB6Mnrx5BBLUSE4idWh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259062; c=relaxed/simple;
	bh=EI/MhM4AP6v35KTirZ+vRYrRSU6+Omoaw2fj9e9D3CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLmCehtKNMaAU9j5BrsokbSbDzMflpxXfLF51mcFWSnB6hkhI0KJtarY106lrnAaDIbMrvArjWpfH5ve6BEaPf/9oamWBHS/nb+cZsmLGckyfUWGuzMOZjZKGyRx+V8wC8HcRQiqvzxEMYDuFNWH+VlMsGKvDkvXoCtP7YABKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rsSnV-0005R7-NJ; Thu, 04 Apr 2024 21:30:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Tomek <mtdev79b@gmail.com>,
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 3/3] phy: rockchip: naneng-combphy: Fix mux on rk3588
Date: Thu, 04 Apr 2024 21:30:52 +0200
Message-ID: <2643155.ElGaqSPkdT@phil>
In-Reply-To:
 <20240404-rk3588-pcie-bifurcation-fixes-v1-3-9907136eeafd@kernel.org>
References:
 <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
 <20240404-rk3588-pcie-bifurcation-fixes-v1-3-9907136eeafd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 4. April 2024, 19:11:28 CEST schrieb Sebastian Reichel:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> The pcie1l0_sel and pcie1l1_sel bits in PCIESEL_CON configure the
> mux for PCIe1L0 and PCIe1L1 to either the PIPE Combo PHYs or the
> PCIe3 PHY. Thus this configuration interfers with the data-lanes
> configuration done by the PCIe3 PHY.
> 
> RK3588 has three Combo PHYs. The first one has a dedicated PCIe
> controller and is not affected by this. For the other two Combo
> PHYs, there is one mux for each of them.
> 
> pcie1l0_sel selects if PCIe 1L0 is muxed to Combo PHY 1 when
> bit is set to 0 or to the PCIe3 PHY when bit is set to 1.
> 
> pcie1l1_sel selects if PCIe 1L1 is muxed to Combo PHY 2 when
> bit is set to 0 or to the PCIe3 PHY when bit is set to 1.
> 
> Currently the code always muxes 1L0 and 1L1 to the Combi PHYs
> once one of them is being used in PCIe mode. This is obviously
> wrong when at least one of the ports should be muxed to the
> PCIe3 PHY.
> 
> Fix this by introducing Combo PHY identification and then only
> setting up the required bit.
> 
> Fixes: a03c44277253 ("phy: rockchip: Add naneng combo phy support for RK3588")
> Reported-by: Michal Tomek <mtdev79b@gmail.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 36 ++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 76b9cf417591..bf74e429ff46 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -125,12 +125,15 @@ struct rockchip_combphy_grfcfg {
>  };
>  
>  struct rockchip_combphy_cfg {
> +	unsigned int num_phys;
> +	unsigned int phy_ids[3];
>  	const struct rockchip_combphy_grfcfg *grfcfg;
>  	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
>  };
>  
>  struct rockchip_combphy_priv {
>  	u8 type;
> +	int id;
>  	void __iomem *mmio;
>  	int num_clks;
>  	struct clk_bulk_data *clks;
> @@ -320,7 +323,7 @@ static int rockchip_combphy_probe(struct platform_device *pdev)
>  	struct rockchip_combphy_priv *priv;
>  	const struct rockchip_combphy_cfg *phy_cfg;
>  	struct resource *res;
> -	int ret;
> +	int ret, id;
>  
>  	phy_cfg = of_device_get_match_data(dev);
>  	if (!phy_cfg) {
> @@ -338,6 +341,15 @@ static int rockchip_combphy_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* find the phy-id from the io address */
> +	priv->id = -ENODEV;
> +	for (id = 0; id < phy_cfg->num_phys; id++) {
> +		if (res->start == phy_cfg->phy_ids[id]) {
> +			priv->id = id;
> +			break;
> +		}
> +	}
> +
>  	priv->dev = dev;
>  	priv->type = PHY_NONE;
>  	priv->cfg = phy_cfg;
> @@ -562,6 +574,12 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
>  };
>  
>  static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
> +	.num_phys = 3,
> +	.phy_ids = {
> +		0xfe820000,
> +		0xfe830000,
> +		0xfe840000,
> +	},
>  	.grfcfg		= &rk3568_combphy_grfcfgs,
>  	.combphy_cfg	= rk3568_combphy_cfg,
>  };
> @@ -578,8 +596,14 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> -		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
> -		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
> +		switch (priv->id) {
> +		case 1:
> +			rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
> +			break;
> +		case 2:
> +			rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
> +			break;
> +		}
>  		break;
>  	case PHY_TYPE_USB3:
>  		/* Set SSC downward spread spectrum */
> @@ -736,6 +760,12 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
>  };
>  
>  static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
> +	.num_phys = 3,
> +	.phy_ids = {
> +		0xfee00000,
> +		0xfee10000,
> +		0xfee20000,
> +	},
>  	.grfcfg		= &rk3588_combphy_grfcfgs,
>  	.combphy_cfg	= rk3588_combphy_cfg,
>  };
> 
> 





