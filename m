Return-Path: <linux-kernel+bounces-106654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D30987F195
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD9F1C21725
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910EC58201;
	Mon, 18 Mar 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JvelUiUl"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62752F98;
	Mon, 18 Mar 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795061; cv=none; b=izcC2TUfxexC9sNb6b8P+MKZAguysix7oi53QyAhHjrPpnWirNYwEvc28c65T03P94BgdrVLktwts3/6XmjXUQv0Kow4kIKpezzCsbj5Dx7dlSLkziE6ByMtOPcY15F9roWJHpQxeje4hhFY81RT1fbQ61afymfQfvaYR2qg40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795061; c=relaxed/simple;
	bh=DQyXwkGCVcqn03gGGgc5pF7UkvAlzUUsxkvBry9vhTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adU97unXwiV/wIFkCb6d3cU16o08/iGaDXLlyWFsdMgA4JV2TE7C20+UHzyRb4V/6L3jX1CY0hARm48CvUYQbWKm2s+4b9WtINLYw6iwFEySoIRKARFDxyr7gr40e4nkrv3ops3l0fucdPo8ZG+kChuoB/TjmTnaqe4lel69hpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JvelUiUl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V7hiweKCShqTkZVjRoBbzPoSakFvSACyYI9eRdobDaY=; b=JvelUiUlEPlnNSozIDXO9xVl79
	Vs4SbJuFviGCjY4V59jwpJctAAgl/bbxuvkCTt8bNjpAbrnA/aZIbPTJEfgE0AA9FpnamA7sF7sJt
	j4SWEbsy5Vwie22bOlRsk92UlWylNrCgyTskccbnJYgCIhiTjBaXOW7fIAbhCA3TxMgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmJw1-00Adr6-5R; Mon, 18 Mar 2024 21:50:17 +0100
Date: Mon, 18 Mar 2024 21:50:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Message-ID: <ddf5c4e2-16c2-4399-ae34-57114b8d4d21@lunn.ch>
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315222754.22366-3-wafgo01@gmail.com>

On Fri, Mar 15, 2024 at 11:27:48PM +0100, Wadim Mueller wrote:
> Add support for NXP S32 SoC family's GMAC to the stmmac network driver. This driver implementation is based on the patchset originally contributed by Chester Lin [1], which itself draws heavily from NXP's downstream implementation [2]. The patchset was never merged.

Please wrap you commit message.

 
> +#include <linux/device.h>
> +#include <linux/ethtool.h>

Is this one needed?

> +static int s32_gmac_init(struct platform_device *pdev, void *priv)
> +{
> +	struct s32_priv_data *gmac = priv;
> +	u32 intf_sel;
> +	int ret;
> +
> +	if (gmac->tx_clk) {
> +		ret = clk_prepare_enable(gmac->tx_clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't set tx clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (gmac->rx_clk) {
> +		ret = clk_prepare_enable(gmac->rx_clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't set rx clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* set interface mode */
> +	if (gmac->ctrl_sts) {
> +		switch (gmac->intf_mode) {
> +		default:
> +			dev_info(
> +				&pdev->dev,
> +				"unsupported mode %u, set the default phy mode.\n",
> +				gmac->intf_mode);
> +			fallthrough;

I would actually return -EINVAL. There is no backwards compatibility
needed here, so force that the mode is always specified.

> +		case PHY_INTERFACE_MODE_SGMII:
> +			dev_info(&pdev->dev, "phy mode set to SGMII\n");

Please don't spam the kernel log. dev_dbg(). 

> +static void s32_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct s32_priv_data *gmac = priv;
> +
> +	if (!gmac->tx_clk || !gmac->rx_clk)
> +		return;
> +
> +	/* SGMII mode doesn't support the clock reconfiguration */
> +	if (gmac->intf_mode == PHY_INTERFACE_MODE_SGMII)
> +		return;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		dev_info(gmac->dev, "Set TX clock to 125M\n");

more dev_dbg(). A driver should generally be silent, unless something
goes wrong. It is also questionable if dev_dbg() should be used. Once
the driver actually works, you can throw away a lot of debug
prints. Do you expect problems here in the future?

> +static int s32_config_cache_coherency(struct platform_device *pdev,
> +				      struct plat_stmmacenet_data *plat_dat)
> +{
> +	plat_dat->axi4_ace_ctrl = devm_kzalloc(
> +		&pdev->dev, sizeof(struct stmmac_axi4_ace_ctrl), GFP_KERNEL);
> +
> +	if (!plat_dat->axi4_ace_ctrl)
> +		return -ENOMEM;
> +
> +	plat_dat->axi4_ace_ctrl->tx_ar_reg = (ACE_CONTROL_SIGNALS << 16) |
> +					     (ACE_CONTROL_SIGNALS << 8) |
> +					     ACE_CONTROL_SIGNALS;
> +
> +	plat_dat->axi4_ace_ctrl->rx_aw_reg =
> +		(ACE_CONTROL_SIGNALS << 24) | (ACE_CONTROL_SIGNALS << 16) |
> +		(ACE_CONTROL_SIGNALS << 8) | ACE_CONTROL_SIGNALS;
> +
> +	plat_dat->axi4_ace_ctrl->txrx_awar_reg =
> +		(ACE_PROTECTION << 20) | (ACE_PROTECTION << 16) |
> +		(ACE_CONTROL_SIGNALS << 8) | ACE_CONTROL_SIGNALS;

This looks like magic. Can the various shifts be replaced my #defines?
Comments added? This makes changes in some of the core code. So it
might be better to have a prerequisite patch adding cache coherency
control, with a good commit message explaining it.

> +
> +	return 0;
> +}
> +
> +static int s32_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct s32_priv_data *gmac;
> +	struct resource *res;
> +	const char *tx_clk, *rx_clk;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return ret;
> +
> +	gmac = devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
> +	if (!gmac)
> +		return PTR_ERR(gmac);
> +
> +	gmac->dev = &pdev->dev;
> +
> +	/* S32G control reg */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	gmac->ctrl_sts = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR_OR_NULL(gmac->ctrl_sts)) {
> +		dev_err(&pdev->dev, "S32G config region is missing\n");
> +		return PTR_ERR(gmac->ctrl_sts);
> +	}
> +
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return PTR_ERR(plat_dat);
> +
> +	plat_dat->bsp_priv = gmac;
> +
> +	switch (plat_dat->phy_interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		tx_clk = "tx_sgmii";
> +		rx_clk = "rx_sgmii";
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		tx_clk = "tx_rgmii";
> +		rx_clk = "rx_rgmii";
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		tx_clk = "tx_rmii";
> +		rx_clk = "rx_rmii";
> +		break;
> +	case PHY_INTERFACE_MODE_MII:
> +		tx_clk = "tx_mii";
> +		rx_clk = "rx_mii";
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Not supported phy interface mode: [%s]\n",
> +			phy_modes(plat_dat->phy_interface));
> +		return -EINVAL;
> +	};
> +
> +	gmac->intf_mode = plat_dat->phy_interface;
> +
> +	/* DMA cache coherency settings */
> +	if (of_dma_is_coherent(pdev->dev.of_node)) {
> +		ret = s32_config_cache_coherency(pdev, plat_dat);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* tx clock */
> +	gmac->tx_clk = devm_clk_get(&pdev->dev, tx_clk);
> +	if (IS_ERR(gmac->tx_clk)) {
> +		dev_info(&pdev->dev, "tx clock not found\n");
> +		gmac->tx_clk = NULL;

Is the clock really optional?

I would also print the name of the clock which is missing.

> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -324,6 +324,10 @@ static void stmmac_clk_csr_set(struct stmmac_priv *priv)
>  			priv->clk_csr = STMMAC_CSR_150_250M;
>  		else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
>  			priv->clk_csr = STMMAC_CSR_250_300M;
> +		else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
> +			priv->clk_csr = STMMAC_CSR_300_500M;
> +		else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
> +			priv->clk_csr = STMMAC_CSR_500_800M;

Also seems like something which could be a patch of its own. Ideally
you want lots of small patches which are obviously correct. Part of
being obviously correct is the commit message, which is easier to
write when the patch is small and only does one thing.

      Andrew


