Return-Path: <linux-kernel+bounces-44886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E884288E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE8C1F2785F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C8386151;
	Tue, 30 Jan 2024 16:00:12 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0385C67;
	Tue, 30 Jan 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630412; cv=none; b=nkaiiqjFILxYI+IlpNNYgqRhILVfuynhzv6gHbvJS7w7htao/1zfI7nVBdY67TB/lYv76PAs0t2PT8RLdIcIxwx6XIgY5dl4Nd0ss64dH1YSlce0pNZfueuKl7Aar9c3RCL7OFJuffZlGJdJ9O62ct1duIfqUBU9sbH5LEBRKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630412; c=relaxed/simple;
	bh=f0XoKKeF4VVk0TM0xyBbuFY+at07XPMAZt17aHCkvGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNWxqYLaRX0ZIcAS74affFizp9x2rRdfAtba1NvDCgWC5jqyOkH78Qk3NgYLg7CE/kPwabIif4AOfn/bvHTfhdI2iOtcC7UnL6HwqNqiD0M1qpIVSH6DMVrIubS7cq37UqNdT5wCXtj00bncxijlx4PaOcMhWItghWOmlq0zgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rUqWS-0007GW-1O;
	Tue, 30 Jan 2024 15:59:40 +0000
Date: Tue, 30 Jan 2024 15:59:28 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 5/7] net: dsa: mt7530: simplify
 mt7530_setup_port6() and change to void
Message-ID: <Zbkc4BRORWYu79GZ@makrotopia.org>
References: <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
 <20240130-for-netnext-mt7530-improvements-2-v2-5-ba06f5dd9eb0@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130-for-netnext-mt7530-improvements-2-v2-5-ba06f5dd9eb0@arinc9.com>

On Tue, Jan 30, 2024 at 06:20:51PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> This code is from before this driver was converted to phylink API. Phylink
> deals with the unsupported interface cases before mt7530_setup_port6() is
> run. Therefore, the default case would never run. However, it must be
> defined nonetheless to handle all the remaining enumeration values, the
> phy-modes.
> 
> Switch to if statement for RGMII and return which simplifies the code and
> saves an indent.
> 
> Set P6_INTF_MODE, which is the the three least significant bits of the
> MT7530_P6ECR register, to 0 for RGMII even though it will already be 0
> after reset. This is to keep supporting dynamic reconfiguration of the port
> in the case the interface changes from TRGMII to RGMII. The core operations
> for TRGMII does not interfere with RGMII so no need to undo them.

That last sentence doesn't parse English gramar.
"operations": plural
"does": singular

Should probably be either "The core operation for TRGMII does not..."
or "The core operations for TRGMII do not..."

As you are mentioning it, I'm now curious if you consider to
dynamically reconfiguring TRGIII<->RGMII on port 6 depending on
whether there is more then 1 GBit/s possible bandwidth needed between
port 6 and the remaining ports? That could make sense for power
management, but then we should at least again switch off the TRGMII
clocks in the RGMII case before returning, see my suggestion inline
below.

> 
> Read XTAL after checking for RGMII as it's only needed for the TRGMII
> interface mode.
> 
> Change mt7530_setup_port6() to void now that there're no error cases left.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/dsa/mt7530.c | 103 ++++++++++++++++++++---------------------------
>  1 file changed, 43 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index c4d492e29fdf..36dc2bbcf3b6 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -414,70 +414,57 @@ mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
>  }
>  
>  /* Setup port 6 interface mode and TRGMII TX circuit */
> -static int
> +static void
>  mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
>  {
>  	struct mt7530_priv *priv = ds->priv;
> -	u32 ncpo1, ssc_delta, trgint, xtal;
> -
> -	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
> +	u32 ncpo1, ssc_delta, xtal;
>  
> -	switch (interface) {
> -	case PHY_INTERFACE_MODE_RGMII:
> -		trgint = 0;
> -		break;
> -	case PHY_INTERFACE_MODE_TRGMII:
> -		trgint = 1;
> -		if (xtal == HWTRAP_XTAL_25MHZ)
> -			ssc_delta = 0x57;
> -		else
> -			ssc_delta = 0x87;
> -		if (priv->id == ID_MT7621) {
> -			/* PLL frequency: 125MHz: 1.0GBit */
> -			if (xtal == HWTRAP_XTAL_40MHZ)
> -				ncpo1 = 0x0640;
> -			if (xtal == HWTRAP_XTAL_25MHZ)
> -				ncpo1 = 0x0a00;
> -		} else { /* PLL frequency: 250MHz: 2.0Gbit */
> -			if (xtal == HWTRAP_XTAL_40MHZ)
> -				ncpo1 = 0x0c80;
> -			if (xtal == HWTRAP_XTAL_25MHZ)
> -				ncpo1 = 0x1400;
> -		}
> -		break;
> -	default:
> -		dev_err(priv->dev, "xMII interface %d not supported\n",
> -			interface);
> -		return -EINVAL;
> +	if (interface == PHY_INTERFACE_MODE_RGMII) {
> +		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
> +			   P6_INTF_MODE(0));

Maybe at least switch off TRGMIICK here because we are sure we don't need it
in the RGMII case, ie:
core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);

And that then is another line of code already present just below which
means you could keep variable trgint as it was and return after
switching off TRGMIICK below anyway...

> +		return;
>  	}
>  
> -	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
> -		   P6_INTF_MODE(trgint));
> +	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK, P6_INTF_MODE(1));
>  
> -	if (trgint) {
> -		/* Disable the MT7530 TRGMII clocks */
> -		core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
> +	xtal = mt7530_read(priv, MT7530_MHWTRAP) & HWTRAP_XTAL_MASK;
>  
> -		/* Setup the MT7530 TRGMII Tx Clock */
> -		core_write(priv, CORE_PLL_GROUP5, RG_LCDDS_PCW_NCPO1(ncpo1));
> -		core_write(priv, CORE_PLL_GROUP6, RG_LCDDS_PCW_NCPO0(0));
> -		core_write(priv, CORE_PLL_GROUP10, RG_LCDDS_SSC_DELTA(ssc_delta));
> -		core_write(priv, CORE_PLL_GROUP11, RG_LCDDS_SSC_DELTA1(ssc_delta));
> -		core_write(priv, CORE_PLL_GROUP4,
> -			   RG_SYSPLL_DDSFBK_EN | RG_SYSPLL_BIAS_EN |
> -			   RG_SYSPLL_BIAS_LPF_EN);
> -		core_write(priv, CORE_PLL_GROUP2,
> -			   RG_SYSPLL_EN_NORMAL | RG_SYSPLL_VODEN |
> -			   RG_SYSPLL_POSDIV(1));
> -		core_write(priv, CORE_PLL_GROUP7,
> -			   RG_LCDDS_PCW_NCPO_CHG | RG_LCCDS_C(3) |
> -			   RG_LCDDS_PWDB | RG_LCDDS_ISO_EN);
> +	if (xtal == HWTRAP_XTAL_25MHZ)
> +		ssc_delta = 0x57;
> +	else
> +		ssc_delta = 0x87;
>  
> -		/* Enable the MT7530 TRGMII clocks */
> -		core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
> +	if (priv->id == ID_MT7621) {
> +		/* PLL frequency: 125MHz: 1.0GBit */
> +		if (xtal == HWTRAP_XTAL_40MHZ)
> +			ncpo1 = 0x0640;
> +		if (xtal == HWTRAP_XTAL_25MHZ)
> +			ncpo1 = 0x0a00;
> +	} else { /* PLL frequency: 250MHz: 2.0Gbit */
> +		if (xtal == HWTRAP_XTAL_40MHZ)
> +			ncpo1 = 0x0c80;
> +		if (xtal == HWTRAP_XTAL_25MHZ)
> +			ncpo1 = 0x1400;
>  	}
>  
> -	return 0;
> +	/* Disable the MT7530 TRGMII clocks */
> +	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);

.. by moving this line up and letting it happen unconditionally for
both RGMII and TRGMII (in case that works and doesn't break the RGMII
case, but I assume it doesn't)

> +
> +	/* Setup the MT7530 TRGMII Tx Clock */
> +	core_write(priv, CORE_PLL_GROUP5, RG_LCDDS_PCW_NCPO1(ncpo1));
> +	core_write(priv, CORE_PLL_GROUP6, RG_LCDDS_PCW_NCPO0(0));
> +	core_write(priv, CORE_PLL_GROUP10, RG_LCDDS_SSC_DELTA(ssc_delta));
> +	core_write(priv, CORE_PLL_GROUP11, RG_LCDDS_SSC_DELTA1(ssc_delta));
> +	core_write(priv, CORE_PLL_GROUP4, RG_SYSPLL_DDSFBK_EN |
> +		   RG_SYSPLL_BIAS_EN | RG_SYSPLL_BIAS_LPF_EN);
> +	core_write(priv, CORE_PLL_GROUP2, RG_SYSPLL_EN_NORMAL |
> +		   RG_SYSPLL_VODEN | RG_SYSPLL_POSDIV(1));
> +	core_write(priv, CORE_PLL_GROUP7, RG_LCDDS_PCW_NCPO_CHG |
> +		   RG_LCCDS_C(3) | RG_LCDDS_PWDB | RG_LCDDS_ISO_EN);
> +
> +	/* Enable the MT7530 TRGMII clocks */
> +	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
>  }
>  
>  static void
> @@ -2609,15 +2596,11 @@ mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
>  		  phy_interface_t interface)
>  {
>  	struct mt7530_priv *priv = ds->priv;
> -	int ret;
>  
> -	if (port == 5) {
> +	if (port == 5)
>  		mt7530_setup_port5(priv->ds, interface);
> -	} else if (port == 6) {
> -		ret = mt7530_setup_port6(priv->ds, interface);
> -		if (ret)
> -			return ret;
> -	}
> +	else if (port == 6)
> +		mt7530_setup_port6(priv->ds, interface);
>  
>  	return 0;
>  }
> 
> -- 
> 2.40.1
> 
> 

