Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312D7D42F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjJWW7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:59:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52420D79;
        Mon, 23 Oct 2023 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1E09UBgyQcefRn0OnXUpZNo1/9RUAr8V/BmFHciwpq8=; b=VvP9HTzSRGv6LJiGRkitBz+OZ5
        z23ToaOkkIuiqKP8k/xdrFZHky3oX4HtSSfkaJK7ZTATG4vDYZqAkG4kqPw1c49qsfgQ/b+fF7Dc0
        KYoaxCKk+zdqw0x3vCZz8i4YSpdgAjaO16zs2BjnSNRBESpx1lwSHmq/JIfeJnQJUz1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qv3sp-0001KP-52; Tue, 24 Oct 2023 00:58:51 +0200
Date:   Tue, 24 Oct 2023 00:58:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 3/9] net: ethernet: oa_tc6: implement OA TC6
 configuration function
Message-ID: <423e0b42-a75e-4104-b445-7d9ff0991acf@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-4-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-4-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Read and configure the IMASK0 register for unmasking the interrupts */
> +	ret = oa_tc6_perform_ctrl(tc6, IMASK0, &regval, 1, false, false);
> +	if (ret)
> +		return ret;

Can you use oa_tc6_read_register() here? I guess the question is, what
does tc6->protect default to until it is set later in this function?
So long as it defaults to false, i guess you can use the register
read/write functions, which are a lot more readable than this generic
oa_tc6_perform_ctrl().

> +
> +	regval &= ~(TXPEM & TXBOEM & TXBUEM & RXBOEM & LOFEM & HDREM);
> +
> +	ret = oa_tc6_perform_ctrl(tc6, IMASK0, &regval, 1, true, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Read STDCAP register to get the MAC-PHY standard capabilities */
> +	ret = oa_tc6_perform_ctrl(tc6, STDCAP, &regval, 1, false, false);
> +	if (ret)
> +		return ret;
> +
> +	mincps = FIELD_GET(MINCPS, regval);
> +	ctc = (regval & CTC) ? true : false;
> +
> +	regval = 0;
> +	oa_node = of_get_child_by_name(spi->dev.of_node, "oa-tc6");
> +	if (oa_node) {
> +		/* Read OA parameters from DT */
> +		if (of_property_present(oa_node, "oa-cps")) {
> +			ret = of_property_read_u32(oa_node, "oa-cps", &tc6->cps);

If of_property_read_u32() does not find the property, it is documented
to not touch tc6->cps. So you can set tc6->cps to the default 64,
before the big if, and skip the of_property_present(). You can then
probably remove the else at the end as well.

> +			if (ret < 0)
> +				return ret;
> +			/* Return error if the configured cps is less than the
> +			 * minimum cps supported by the MAC-PHY.
> +			 */
> +			if (tc6->cps < mincps)
> +				return -ENODEV;

A dev_err() would be nice here to indicate why.

> +		} else {
> +			tc6->cps = 64;
> +		}
> +		if (of_property_present(oa_node, "oa-txcte")) {
> +			/* Return error if the tx cut through mode is configured
> +			 * but it is not supported by MAC-PHY.
> +			 */
> +			if (ctc)
> +				regval |= TXCTE;
> +			else
> +				return -ENODEV;

and a dev_err() here as well.

> +		}
> +		if (of_property_present(oa_node, "oa-rxcte")) {
> +			/* Return error if the rx cut through mode is configured
> +			 * but it is not supported by MAC-PHY.
> +			 */
> +			if (ctc)
> +				regval |= RXCTE;
> +			else
> +				return -ENODEV;
> +		}

and another dev_err(). Without these prints, you probably need to
modify the code to figure out why the probe failed.

> +		if (of_property_present(oa_node, "oa-prote")) {
> +			regval |= PROTE;
> +			tc6->prote = true;
> +		}
> +	} else {
> +		tc6->cps = 64;
> +	}
> +
> +	regval |= FIELD_PREP(CPS, ilog2(tc6->cps) / ilog2(2)) | SYNC;
> +
> +	return oa_tc6_perform_ctrl(tc6, CONFIG0, &regval, 1, true, false);
> +}
> +
>  static int oa_tc6_sw_reset(struct oa_tc6 *tc6)
>  {
>  	u32 regval;
> @@ -310,7 +387,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_read_registers);
>   * Returns pointer reference to the oa_tc6 structure if all the memory
>   * allocation success otherwise NULL.
>   */
> -struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote)
> +struct oa_tc6 *oa_tc6_init(struct spi_device *spi)

Was there a reason to have prote initially, and then remove it here?

    Andrew
