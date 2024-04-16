Return-Path: <linux-kernel+bounces-147155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238408A7032
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468201C2188C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F1131745;
	Tue, 16 Apr 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwzGbiMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACC1311B4;
	Tue, 16 Apr 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282653; cv=none; b=cIgrQQGoS3wk1a0liJ44Ny6zBYyuVDYHQ1Gg3pybyucdeJ94/8VG2ZdYMIb7G/SOpbTVnaYEoHhuDrLoGDARZVAfPpXQHKLzFhcsviXJQGfPk7xTG7NVhPGel38mbQGElxQkZsnHC5BA4eL641Jpva/KwAwuqr1Rfn+SEZBEqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282653; c=relaxed/simple;
	bh=wE/1nQW03EOW2WjxRav5KhI1biPyJvYQafxlZ0n0QgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5N6nYzwTmhib6mQcDVA9xWmt+wihdrLGUppQYvIweZ+JNmEA2HIM8VmcnOkXjg3wo2JGcYzeOdEnjZchYrX7Ia+qvtPRkr+ed79T8IweCqpRmzJJH6PMS/PL+IqFCyfmrcIzj1JHrmyzsuudIlUKuUWEgG7J+Fnczl4Y3nZsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwzGbiMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ED3C113CE;
	Tue, 16 Apr 2024 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282652;
	bh=wE/1nQW03EOW2WjxRav5KhI1biPyJvYQafxlZ0n0QgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwzGbiMo8w/Nh/4Nrlp02t8ZIxpU1s16/LVWkVMivNOFKZt6GWHPxrTcVYMmu0Vh0
	 pR0OYwF7Pedi8E5biwG6+xiq6b9MRmdEPItHRtphbobBcpO3L6Lp3e9J6XQ3IgIiBI
	 LnSurHWuqKEsPtQpbLS4g917/g4T4/EMZ5QIyp/bybMTLQFqfmR+Gfo1dbin1Ls8B2
	 w42jZEHEhO/a5IE0s3O4i5h4bPAxLjRC8B6FYwHiqXndS4PrnHxAOklM3Pnokz0GMN
	 7dVKNBJWV3nPJgFVhejsZPF/QBt6se0aCkmstJ9+cGGOCKYC96CXwCEdcF42WHMMFO
	 PgUI+iwjPTOiw==
Date: Tue, 16 Apr 2024 23:37:23 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
Message-ID: <Zh6bM2EQnAFYFhiV@xhacker>
References: <cover.1713258948.git.unicorn_wang@outlook.com>
 <e5aa1338d74504e141ba833b484d588cafb7ab38.1713258948.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5aa1338d74504e141ba833b484d588cafb7ab38.1713258948.git.unicorn_wang@outlook.com>

On Tue, Apr 16, 2024 at 05:50:57PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for the mmc controller of Sophgo SG2042.
> 
> SG2042 uses Synopsys PHY the same as TH1520 so we reuse the tuning
> logic from TH1520. Besides this, this patch implement some SG2042
> specific work, such as clocks and reset ops.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 173 ++++++++++++++++++++++++++--
>  1 file changed, 166 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1a0b7ded7f9f..432ce0398163 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -106,12 +106,13 @@
>  #define DWC_MSHC_PTR_PHY_R	0x300
>  
>  /* PHY general configuration */
> -#define PHY_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x00)
> -#define PHY_CNFG_RSTN_DEASSERT	0x1  /* Deassert PHY reset */
> -#define PHY_CNFG_PAD_SP_MASK	GENMASK(19, 16) /* bits [19:16] */
> -#define PHY_CNFG_PAD_SP		0x0c /* PMOS TX drive strength */
> -#define PHY_CNFG_PAD_SN_MASK	GENMASK(23, 20) /* bits [23:20] */
> -#define PHY_CNFG_PAD_SN		0x0c /* NMOS TX drive strength */
> +#define PHY_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x00)
> +#define PHY_CNFG_RSTN_DEASSERT		0x1  /* Deassert PHY reset */
> +#define PHY_CNFG_PHY_PWRGOOD_MASK	BIT_MASK(1) /* bit [1] */
> +#define PHY_CNFG_PAD_SP_MASK		GENMASK(19, 16) /* bits [19:16] */
> +#define PHY_CNFG_PAD_SP			0x0c /* PMOS TX drive strength */
> +#define PHY_CNFG_PAD_SN_MASK		GENMASK(23, 20) /* bits [23:20] */
> +#define PHY_CNFG_PAD_SN			0x0c /* NMOS TX drive strength */
>  
>  /* PHY command/response pad settings */
>  #define PHY_CMDPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x04)
> @@ -143,7 +144,8 @@
>  
>  /* PHY CLK delay line settings */
>  #define PHY_SDCLKDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x1d)
> -#define PHY_SDCLKDL_CNFG_UPDATE	BIT(4) /* set before writing to SDCLKDL_DC */
> +#define PHY_SDCLKDL_CNFG_EXTDLY_EN	BIT(0)
> +#define PHY_SDCLKDL_CNFG_UPDATE		BIT(4) /* set before writing to SDCLKDL_DC */
>  
>  /* PHY CLK delay line delay code */
>  #define PHY_SDCLKDL_DC_R		(DWC_MSHC_PTR_PHY_R + 0x1e)
> @@ -151,6 +153,9 @@
>  #define PHY_SDCLKDL_DC_DEFAULT		0x32 /* default delay code */
>  #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
>  
> +#define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
> +#define PHY_SMPLDL_CNFG_BYPASS_EN	BIT(1)
> +
>  /* PHY drift_cclk_rx delay line configuration setting */
>  #define PHY_ATDL_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x21)
>  #define PHY_ATDL_CNFG_INPSEL_MASK	GENMASK(3, 2) /* bits [3:2] */
> @@ -194,6 +199,11 @@ struct rk35xx_priv {
>  	u8 txclk_tapnum;
>  };
>  
> +#define SG2042_MAX_CLKS 2

I don't think "bulk" is suitable here for max 2 clks, no?

> +struct sg2042_priv {
> +	struct clk_bulk_data clks[SG2042_MAX_CLKS];

useless either

> +};
> +
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
>  	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
> @@ -690,6 +700,76 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_writel(host, val, priv->vendor_specific_area1 + CV18XX_SDHCI_PHY_TX_RX_DLY);
>  }
>  
> +static inline void sg2042_sdhci_phy_init(struct sdhci_host *host)
> +{
> +	u32 val;
> +
> +	/* Asset phy reset & set tx drive strength */
> +	val = sdhci_readl(host, PHY_CNFG_R);
> +	val &= ~PHY_CNFG_RSTN_DEASSERT;
> +	val |= FIELD_PREP(PHY_CNFG_PHY_PWRGOOD_MASK, 1);
> +	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, 9);
> +	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, 8);
> +	sdhci_writel(host, val, PHY_CNFG_R);
> +
> +	/* Configure phy pads */
> +	val = PHY_PAD_RXSEL_3V3;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, 3);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, 2);
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	val = PHY_PAD_RXSEL_3V3;
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, 3);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, 2);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	val = PHY_PAD_RXSEL_3V3;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, 3);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, 2);
> +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +
> +	/* Configure delay line */
> +	/* Enable fixed delay */
> +	sdhci_writeb(host, PHY_SDCLKDL_CNFG_EXTDLY_EN, PHY_SDCLKDL_CNFG_R);
> +	/*
> +	 * Set delay line.
> +	 * Its recommended that bit UPDATE_DC[4] is 1 when SDCLKDL_DC is being written.
> +	 * Ensure UPDATE_DC[4] is '0' when not updating code.
> +	 */
> +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> +	val |= PHY_SDCLKDL_CNFG_UPDATE;
> +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> +	/* Add 10 * 70ps = 0.7ns for output delay */
> +	sdhci_writeb(host, 10, PHY_SDCLKDL_DC_R);
> +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> +	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> +
> +	/* Set SMPLDL_CNFG, Bypass */
> +	sdhci_writeb(host, PHY_SMPLDL_CNFG_BYPASS_EN, PHY_SMPLDL_CNFG_R);
> +
> +	/* Set ATDL_CNFG, tuning clk not use for init */
> +	val = FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, 2);

magic "2" needs a meaningful macro definition.

> +	sdhci_writeb(host, val, PHY_ATDL_CNFG_R);
> +
> +	/* Deasset phy reset */
> +	val = sdhci_readl(host, PHY_CNFG_R);
> +	val |= PHY_CNFG_RSTN_DEASSERT;
> +	sdhci_writel(host, val, PHY_CNFG_R);
> +}
> +
> +static void sg2042_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	sdhci_reset(host, mask);
> +
> +	if (mask & SDHCI_RESET_ALL)
> +		sg2042_sdhci_phy_init(host);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -728,6 +808,16 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_sg2042_ops = {
> +	.set_clock              = sdhci_set_clock,
> +	.set_bus_width          = sdhci_set_bus_width,
> +	.set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> +	.get_max_clock		= dwcmshc_get_max_clock,
> +	.platform_execute_tuning = th1520_execute_tuning,
> +	.reset                  = sg2042_sdhci_reset,
> +	.adma_write_desc        = dwcmshc_adma_write_desc,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>  	.ops = &sdhci_dwcmshc_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> @@ -763,6 +853,13 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_sg2042_pdata = {
> +	.ops = &sdhci_dwcmshc_sg2042_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,

is "wp-inverted" property better?

> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
>  static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	/*
> @@ -882,6 +979,58 @@ static int dwcmshc_th1520_init(struct device *dev,
>  	return 0;
>  }
>  
> +static int dwcmshc_sg2042_clks_enable(struct dwcmshc_priv *dwc_priv)
> +{
> +	int ret = 0;
> +	struct sg2042_priv *soc = dwc_priv->priv;
> +
> +	if (soc)
> +		ret = clk_bulk_prepare_enable(SG2042_MAX_CLKS, soc->clks);
> +	return ret;
> +}
> +
> +static void dwcmshc_sg2042_clks_disable(struct dwcmshc_priv *dwc_priv)
> +{
> +	struct sg2042_priv *soc = dwc_priv->priv;
> +
> +	if (soc)
> +		clk_bulk_disable_unprepare(SG2042_MAX_CLKS,
> +					   soc->clks);
> +}
> +
> +static int dwcmshc_sg2042_init(struct device *dev,
> +			       struct sdhci_host *host,
> +			       struct dwcmshc_priv *dwc_priv)
> +{
> +	int err;
> +	struct sg2042_priv *soc = NULL;
> +
> +	soc = devm_kzalloc(dev, sizeof(struct sg2042_priv), GFP_KERNEL);
> +	if (!soc)
> +		return -ENOMEM;
> +
> +	soc->clks[0].id = "card";
> +	soc->clks[1].id = "timer";

Interesting, only "card" and "timer", so which clk is for clk input of the ip?

> +	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), SG2042_MAX_CLKS,
> +					 soc->clks);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_bulk_prepare_enable(SG2042_MAX_CLKS, soc->clks);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
> +		return err;
> +	}
> +
> +	dwc_priv->priv = soc;
> +	dwc_priv->soc_clks_enable = dwcmshc_sg2042_clks_enable;
> +	dwc_priv->soc_clks_disable = dwcmshc_sg2042_clks_disable;
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
> @@ -907,6 +1056,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  		.compatible = "thead,th1520-dwcmshc",
>  		.data = &sdhci_dwcmshc_th1520_pdata,
>  	},
> +	{
> +		.compatible = "sophgo,sg2042-dwcmshc",
> +		.data = &sdhci_dwcmshc_sg2042_pdata,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> @@ -994,6 +1147,12 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  			goto err_clk;
>  	}
>  
> +	if (pltfm_data == &sdhci_dwcmshc_sg2042_pdata) {
> +		err = dwcmshc_sg2042_init(dev, host, priv);
> +		if (err)
> +			goto err_clk;
> +	}
> +
>  #ifdef CONFIG_ACPI
>  	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
>  		sdhci_enable_v4_mode(host);
> -- 
> 2.25.1
> 

