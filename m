Return-Path: <linux-kernel+bounces-43698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E938417E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938961C22F68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD6A2E40E;
	Tue, 30 Jan 2024 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YSaXjHg4"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77501E52A;
	Tue, 30 Jan 2024 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576024; cv=none; b=hpkDVadKOnfY9cecqSCQS9aOUSG+ukCCQcgfeAjdsQlNAHLTlkuHxitSNvH1WaohVWyfAzutwspy7e/4cIOnAKSIcrxj9NGfPThJDZi4tOpr0QZTqIEuU7so8ZO0XfdUC5mWkXUMm5UZAuQnCvmB+8RcbQOr+FUvOTwl6wS1FE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576024; c=relaxed/simple;
	bh=PWxwW8DGD1qMG7u+SXX5E9whYTavzrUnlw13TG8n894=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn2U3niBr8yr2+1GYSGpJmLWsziNAXX/n8oGssiQtgg2qgxm1d+fRuM8HslXZgIn0rcpwkXfJP1WrNGhOFyO1L3sK9prEjr7Ht/r7EzlWMnV3UbMg+EgXkZx2VMSbayt6DbM49dUMlnvTA2VlPsLrK4feDUIyJBqq1xIe9Z/Z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YSaXjHg4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dO+iHtbzXa56lyxPAuz5ejwpIfXOr6Sor8PoQQ7vU+s=; b=YSaXjHg4FvURM3e6Kd13581NGR
	WLSfXO5FkxZ1aWuOLyThKM0U0ohYOLc2RLR/OBZ0N9tpo5ld5nLVBquBMUhKRBj+Xz8iq0PtMVAM1
	0lJAapLnETdiSx6PyzuUsEMjhqsG1s6owKlwoSxd0xKenj1DejqNcs8p/A07gRiLfwRc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUcNY-006Qof-Ng; Tue, 30 Jan 2024 01:53:32 +0100
Date: Tue, 30 Jan 2024 01:53:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Subject: Re: [net-next PATCH v2 2/3] net: mdio: ipq4019: add support for
 clock-frequency property
Message-ID: <27b6701b-f3f1-4277-8720-b436dc8cc75a@lunn.ch>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
 <20240130003546.1546-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130003546.1546-3-ansuelsmth@gmail.com>

On Tue, Jan 30, 2024 at 01:35:21AM +0100, Christian Marangi wrote:
> The IPQ4019 MDIO internally divide the clock feed by AHB based on the
> MDIO_MODE reg. On reset or power up, the default value for the
> divider is 0xff that reflect the divider set to /256.
> 
> This makes the MDC run at a very low rate, that is, considering AHB is
> always fixed to 100Mhz, a value of 390KHz.
> 
> This hasn't have been a problem as MDIO wasn't used for time sensitive
> operation, it is now that on IPQ807x is usually mounted with PHY that
> requires MDIO to load their firmware (example Aquantia PHY).
> 
> To handle this problem and permit to set the correct designed MDC
> frequency for the SoC add support for the standard "clock-frequency"
> property for the MDIO node.
> 
> The divider supports value from /1 to /256 and the common value are to
> set it to /16 to reflect 6.25Mhz or to /8 on newer platform to reflect
> 12.5Mhz.
> 
> To scan if the requested rate is supported by the divider, loop with
> each supported divider and stop when the requested rate match the final
> rate with the current divider. An error is returned if the rate doesn't
> match any value.
> 
> On MDIO reset, the divider is restored to the requested value to prevent
> any kind of downclocking caused by the divider reverting to a default
> value.
> 
> To follow 802.3 spec of 2.5MHz of default value, if divider is set at
> /256 and "clock-frequency" is not set in DT, assume nobody set the
> divider and try to find the closest MDC rate to 2.5MHz. (in the case of
> AHB set to 100MHz, it's 1.5625MHz)
> 
> While at is also document other bits of the MDIO_MODE reg to have a
> clear idea of what is actually applied there.
> 
> Documentation of some BITs is skipped as they are marked as reserved and
> their usage is not clear (RES 11:9 GENPHY 16:13 RES1 19:17)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/mdio/mdio-ipq4019.c | 109 ++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index abd8b508ec16..61638f25c184 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -14,6 +14,20 @@
>  #include <linux/clk.h>
>  
>  #define MDIO_MODE_REG				0x40
> +#define   MDIO_MODE_MDC_MODE			BIT(12)
> +/* 0 = Clause 22, 1 = Clause 45 */
> +#define   MDIO_MODE_C45				BIT(8)
> +#define   MDIO_MODE_DIV_MASK			GENMASK(7, 0)
> +#define     MDIO_MODE_DIV(x)			FIELD_PREP(MDIO_MODE_DIV_MASK, (x) - 1)
> +#define     MDIO_MODE_DIV_1			0x0
> +#define     MDIO_MODE_DIV_2			0x1
> +#define     MDIO_MODE_DIV_4			0x3
> +#define     MDIO_MODE_DIV_8			0x7
> +#define     MDIO_MODE_DIV_16			0xf
> +#define     MDIO_MODE_DIV_32			0x1f
> +#define     MDIO_MODE_DIV_64			0x3f
> +#define     MDIO_MODE_DIV_128			0x7f
> +#define     MDIO_MODE_DIV_256			0xff
>  #define MDIO_ADDR_REG				0x44
>  #define MDIO_DATA_WRITE_REG			0x48
>  #define MDIO_DATA_READ_REG			0x4c
> @@ -26,9 +40,6 @@
>  #define MDIO_CMD_ACCESS_CODE_C45_WRITE	1
>  #define MDIO_CMD_ACCESS_CODE_C45_READ	2
>  
> -/* 0 = Clause 22, 1 = Clause 45 */
> -#define MDIO_MODE_C45				BIT(8)
> -
>  #define IPQ4019_MDIO_TIMEOUT	10000
>  #define IPQ4019_MDIO_SLEEP		10
>  
> @@ -41,6 +52,7 @@ struct ipq4019_mdio_data {
>  	void __iomem	*membase;
>  	void __iomem *eth_ldo_rdy;
>  	struct clk *mdio_clk;
> +	unsigned int mdc_rate;
>  };
>  
>  static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
> @@ -203,6 +215,38 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>  	return 0;
>  }
>  
> +static int ipq4019_mdio_set_div(struct ipq4019_mdio_data *priv)
> +{
> +	unsigned long ahb_rate;
> +	int div;
> +	u32 val;
> +
> +	/* If we don't have a clock for AHB use the fixed value */
> +	ahb_rate = IPQ_MDIO_CLK_RATE;
> +	if (priv->mdio_clk)
> +		ahb_rate = clk_get_rate(priv->mdio_clk);
> +
> +	/* MDC rate is ahb_rate/(MDIO_MODE_DIV + 1)
> +	 * While supported, internal documentation doesn't
> +	 * assure correct functionality of the MDIO bus
> +	 * with divider of 1, 2 or 4.
> +	 */
> +	for (div = 8; div <= 256; div *= 2) {
> +		/* The requested rate is supported by the div */
> +		if (priv->mdc_rate == DIV_ROUND_UP(ahb_rate, div)) {
> +			val = readl(priv->membase + MDIO_MODE_REG);
> +			val &= ~MDIO_MODE_DIV_MASK;
> +			val |= MDIO_MODE_DIV(div);
> +			writel(val, priv->membase + MDIO_MODE_REG);
> +
> +			return 0;
> +		}
> +	}
> +
> +	/* The requested rate is not supported */
> +	return -EINVAL;
> +}
> +
>  static int ipq_mdio_reset(struct mii_bus *bus)
>  {
>  	struct ipq4019_mdio_data *priv = bus->priv;
> @@ -225,10 +269,58 @@ static int ipq_mdio_reset(struct mii_bus *bus)
>  		return ret;
>  
>  	ret = clk_prepare_enable(priv->mdio_clk);
> -	if (ret == 0)
> -		mdelay(10);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	mdelay(10);
> +
> +	/* Restore MDC rate */
> +	return ipq4019_mdio_set_div(priv);
> +}
> +
> +static void ipq4019_mdio_select_mdc_rate(struct platform_device *pdev,
> +					 struct ipq4019_mdio_data *priv)
> +{
> +	unsigned long ahb_rate;
> +	int div;
> +	u32 val;
> +
> +	/* MDC rate defined in DT, we don't have to decide a default value */
> +	if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> +				  &priv->mdc_rate))
> +		return;
> +
> +	/* If we don't have a clock for AHB use the fixed value */
> +	ahb_rate = IPQ_MDIO_CLK_RATE;
> +	if (priv->mdio_clk)
> +		ahb_rate = clk_get_rate(priv->mdio_clk);
> +
> +	/* Check what is the current div set */
> +	val = readl(priv->membase + MDIO_MODE_REG);
> +	div = FIELD_GET(MDIO_MODE_DIV_MASK, val);
> +
> +	/* div is not set to the default value of /256
> +	 * Probably someone changed that (bootloader, other drivers)
> +	 * Keep this and doesn't overwrite it.

doesn't -> don't 

Otherwise please add my Reviewed-by on the next version.

	Andrew

