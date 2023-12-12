Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F380EC65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376266AbjLLMqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346747AbjLLMqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:46:20 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98F95;
        Tue, 12 Dec 2023 04:46:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2B5DFF809;
        Tue, 12 Dec 2023 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702385184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jC7Y5dK/DICzEjb8YaubuwlA1bw7PTnQpe9efjGHWo=;
        b=Iu4apoqukWOGrhU2BWLiEsyYNEfPQh71yNBQ+HHEfNPDTrAaEpCuiey8d0M+TokROaNNRQ
        0ZugxcqTUr0sTLG5FKF6hdcwRcQQk01UbvJEd5nUFX0iVh6l1coDRhhFAbX1ytzBUkhP/v
        Y1p85zIqaygZJ4kq9j65pLxzhnpgfs1KK+77un0dlMfhPBxHrT4NA3cKBgdOKtYq8HuoVY
        FJYqBWq9WHNibMek65kMX/j18zB2Mp24AOYB+a4z3Kv5OUpZouP5YF4p+n3/MGyEO0Y6l4
        9o3XvGjQyWB4ZekQsiJxwn+R6eW+u2sbsLqmO+j3sIj7UYMAxr7wWbXH25D+bg==
Date:   Tue, 12 Dec 2023 13:46:21 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: Re: [PATCH v2 2/5] net: mdio: ipq4019: enable the SoC uniphy clocks
 for ipq5332 platform
Message-ID: <20231212134621.0fe2583f@device.home>
In-Reply-To: <20231212115151.20016-3-quic_luoj@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
        <20231212115151.20016-3-quic_luoj@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 12 Dec 2023 19:51:47 +0800
Luo Jie <quic_luoj@quicinc.com> wrote:

> On the platform ipq5332, the related SoC uniphy GCC clocks need
> to be enabled for making the MDIO slave devices accessible.
> 
> These UNIPHY clocks are from the SoC platform GCC clock provider,
> which are enabled for the connected PHY devices working.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

[...]

>  static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
> @@ -209,14 +230,43 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>  static int ipq_mdio_reset(struct mii_bus *bus)
>  {
>  	struct ipq4019_mdio_data *priv = bus->priv;
> -	int ret;
> +	int ret, index;
> +	unsigned long rate;

Please remember to use reverse christmas-tree ordering, meaning longer
declaration lines go first :

	struct ipq4019_mdio_data *priv = bus->priv;
	unsigned long rate;
	int ret, index;

> +
> +	/* For the platform ipq5332, there are two SoC uniphies available
> +	 * for connecting with ethernet PHY, the SoC uniphy gcc clock
> +	 * should be enabled for resetting the connected device such
> +	 * as qca8386 switch, qca8081 PHY or other PHYs effectively.
> +	 *
> +	 * Configure MDIO/UNIPHY clock source frequency if clock instance
> +	 * is specified in the device tree.
> +	 */
> +	for (index = MDIO_CLK_MDIO_AHB; index < MDIO_CLK_CNT; index++) {
> +		switch (index) {
> +		case MDIO_CLK_MDIO_AHB:
> +			rate = IPQ_MDIO_CLK_RATE;
> +			break;
> +		case MDIO_CLK_UNIPHY0_AHB:
> +		case MDIO_CLK_UNIPHY1_AHB:
> +			rate = IPQ_UNIPHY_AHB_CLK_RATE;
> +			break;
> +		case MDIO_CLK_UNIPHY0_SYS:
> +		case MDIO_CLK_UNIPHY1_SYS:
> +			rate = IPQ_UNIPHY_SYS_CLK_RATE;
> +			break;
> +		default:
> +			break;
> +		}
>  
> -	/* Configure MDIO clock source frequency if clock is specified in the device tree */
> -	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
> -	if (ret)
> -		return ret;
> +		ret = clk_set_rate(priv->clk[index], rate);
> +		if (ret)
> +			return ret;
> +
> +		ret = clk_prepare_enable(priv->clk[index]);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	ret = clk_prepare_enable(priv->mdio_clk);
>  	if (ret == 0)
>  		mdelay(10);
>  
> @@ -240,10 +290,6 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->membase))
>  		return PTR_ERR(priv->membase);
>  
> -	priv->mdio_clk = devm_clk_get_optional(&pdev->dev, "gcc_mdio_ahb_clk");
> -	if (IS_ERR(priv->mdio_clk))
> -		return PTR_ERR(priv->mdio_clk);
> -
>  	/* These platform resources are provided on the chipset IPQ5018 or
>  	 * IPQ5332.
>  	 */
> @@ -271,6 +317,13 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	for (index = 0; index < MDIO_CLK_CNT; index++) {
> +		priv->clk[index] = devm_clk_get_optional(&pdev->dev,
> +							 mdio_clk_name[index]);
> +		if (IS_ERR(priv->clk[index]))
> +			return PTR_ERR(priv->clk[index]);
> +	}

You should be able to use devm_clk_bulk_get_optional(), to avoid that
loop.

Thanks,

Maxime
