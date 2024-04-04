Return-Path: <linux-kernel+bounces-132047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144EF898F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315581C2265F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520913440F;
	Thu,  4 Apr 2024 19:38:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F56D1AB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259531; cv=none; b=ICaKtUMVasW2c27YRjD2dsnez8NRv0C7ReOwo2VzimZ9nhEgmIdIVhK9da8Uct4bMCF1cGo/Mm7Bp4e/N+po7LKVTUcXBGSo/JHNFgko8mwh+BfmXwC24glllhvW+QX5MWoJbISe7TmBX9M3kaWkofqGO8Xetn6m2d9Bn65hKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259531; c=relaxed/simple;
	bh=OkgKMraGmojnn+a+fjRWstEELW1DW59wRiTp1ftO9RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBF7QjBrUCcQ2v938f6cn0JpJX9XFSwT7bVj4b3VIL3U+uQuOq+hptPqT4DkJOlM5NaDs9QjRcdc8/hSvmKTpf7BElg5uvDuzkr6fQQtERjVj11dkxXQiFY9QVRJX5IYj5/hRNs0XIBnkWifj57UfmiMeYHv+0IaFgQFuqlm6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rsSv3-0005Tv-Jj; Thu, 04 Apr 2024 21:38:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Tomek <mtdev79b@gmail.com>,
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/3] phy: rockchip-snps-pcie3: fix bifurcation on rk3588
Date: Thu, 04 Apr 2024 21:38:40 +0200
Message-ID: <2501840.irdbgypaU6@phil>
In-Reply-To:
 <20240404-rk3588-pcie-bifurcation-fixes-v1-1-9907136eeafd@kernel.org>
References:
 <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
 <20240404-rk3588-pcie-bifurcation-fixes-v1-1-9907136eeafd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 4. April 2024, 19:11:26 CEST schrieb Sebastian Reichel:
> From: Michal Tomek <mtdev79b@gmail.com>
> 
> So far all RK3588 boards use fully aggregated PCIe. CM3588 is one
> of the few boards using this feature and apparently it is broken.
> 
> The PHY offers the following mapping options:
> 
>   port 0 lane 0 - always mapped to controller 0 (4L)
>   port 0 lane 1 - to controller 0 or 2 (1L0)
>   port 1 lane 0 - to controller 0 or 1 (2L)
>   port 1 lane 1 - to controller 0, 1 or 3 (1L1)
> 
> The data-lanes DT property maps these as follows:
> 
>   0 = no controller (unsupported by the HW)
>   1 = 4L
>   2 = 2L
>   3 = 1L0
>   4 = 1L1
> 
> That allows the following configurations with first column being the
> mainline data-lane mapping, second column being the downstream name,
> third column being PCIE3PHY_GRF_CMN_CON0 and PHP_GRF_PCIESEL register
> values and final column being the user visible lane setup:
> 
>   <1 1 1 1> = AGGREG = [4 0] = x4 (aggregation)
>   <1 1 2 2> = NANBNB = [0 0] = x2 x2 (no bif.)
>   <1 3 2 2> = NANBBI = [1 1] = x2 x1x1 (bif. of port 0)
>   <1 1 2 4> = NABINB = [2 2] = x1x1 x2 (bif. of port 1)
>   <1 3 2 4> = NABIBI = [3 3] = x1x1 x1x1 (bif. of both ports)
> 
> The driver currently does not program PHP_GRF_PCIESEL correctly, which
> is fixed by this patch. As a side-effect the new logic is much simpler
> than the old logic.
> 
> Fixes: 2e9bffc4f713 ("phy: rockchip: Support PCIe v3")
> Signed-off-by: Michal Tomek <mtdev79b@gmail.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index 121e5961ce11..d5bcc9c42b28 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -132,7 +132,7 @@ static const struct rockchip_p3phy_ops rk3568_ops = {
>  static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
>  {
>  	u32 reg = 0;
> -	u8 mode = 0;
> +	u8 mode = RK3588_LANE_AGGREGATION; /* default */
>  	int ret;
>  
>  	/* Deassert PCIe PMA output clamp mode */
> @@ -140,28 +140,20 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
>  
>  	/* Set bifurcation if needed */
>  	for (int i = 0; i < priv->num_lanes; i++) {
> -		if (!priv->lanes[i])
> -			mode |= (BIT(i) << 3);
> -
>  		if (priv->lanes[i] > 1)
> -			mode |= (BIT(i) >> 1);
> -	}
> -
> -	if (!mode)
> -		reg = RK3588_LANE_AGGREGATION;
> -	else {
> -		if (mode & (BIT(0) | BIT(1)))
> -			reg |= RK3588_BIFURCATION_LANE_0_1;
> -
> -		if (mode & (BIT(2) | BIT(3)))
> -			reg |= RK3588_BIFURCATION_LANE_2_3;
> +			mode &= ~RK3588_LANE_AGGREGATION;
> +		if (priv->lanes[i] == 3)
> +			mode |= RK3588_BIFURCATION_LANE_0_1;
> +		if (priv->lanes[i] == 4)
> +			mode |= RK3588_BIFURCATION_LANE_2_3;
>  	}
>  
> +	reg = mode;
>  	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0, (0x7<<16) | reg);

nit: instead of doing reg=mode, why not use mode directly?
i.e. (0x7<<16) | mode in the regmap_write call

other than that
Acked-by: Heiko Stuebner <heiko@sntech.de>

>  
>  	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
>  	if (!IS_ERR(priv->pipe_grf)) {
> -		reg = (mode & (BIT(6) | BIT(7))) >> 6;
> +		reg = mode & 3;
>  		if (reg)
>  			regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
>  				     (reg << 16) | reg);
> 
> 





