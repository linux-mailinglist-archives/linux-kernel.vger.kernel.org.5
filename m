Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EB79F5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjINAq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjINAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:46:28 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840B41BCD;
        Wed, 13 Sep 2023 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ubbJptGmaQtLPF4XkWG4x6+bOZSb0KamTqcEQOaigX8=; b=XZUI6b+klpdLAVLEcOxtCKC8HO
        wxY6iesSPwn88hd2U97UhI3FUFlVyA21Pjq6MXmMgpVhdyOO12szaEQD6BG5PMJvspgBQQRw59ce1
        my1WXuaZfhC30LSA8a8jGpY7crBxfrh504vHUitwL7avJvi+WXZH5xPnszSKlrrR+RpE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgaUe-006Lst-0W; Thu, 14 Sep 2023 02:46:04 +0200
Date:   Thu, 14 Sep 2023 02:46:03 +0200
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
Subject: Re: [RFC PATCH net-next 3/6] net: ethernet: implement OA TC6
 configuration function
Message-ID: <dd0a6cd5-91e5-4e13-8025-d6c88bdab5a2@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-4-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-4-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int oa_tc6_configure(struct oa_tc6 *tc6, u8 cps, bool ctrl_prot, bool tx_cut_thr,
> +		     bool rx_cut_thr)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	/* Read and configure the IMASK0 register for unmasking the interrupts */
> +	ret = oa_tc6_read_register(tc6, OA_TC6_IMASK0, &regval, 1);
> +	if (ret)
> +		return ret;
> +
> +	regval &= TXPEM & TXBOEM & TXBUEM & RXBOEM & LOFEM & HDREM;
> +	ret = oa_tc6_write_register(tc6, OA_TC6_IMASK0, &regval, 1);

It is not so obvious what this 1 means. Maybe change to regval[1], and
user ARRAY_SIZE(). What also does not help is the function name,
oa_tc6_write_register(). Singular. So it appears to write one register,
not multiple registers. It might even make sense to make
oa_tc6_write_register() truly access a single register, and add
oa_tc6_write_registers() for multiple registers.

> +/* Unmasking interrupt fields in IMASK0 */
> +#define HDREM		~BIT(5)		/* Header Error Mask */
> +#define LOFEM		~BIT(4)		/* Loss of Framing Error Mask */
> +#define RXBOEM		~BIT(3)		/* Rx Buffer Overflow Error Mask */
> +#define TXBUEM		~BIT(2)		/* Tx Buffer Underflow Error Mask */
> +#define TXBOEM		~BIT(1)		/* Tx Buffer Overflow Error Mask */
> +#define TXPEM		~BIT(0)		/* Tx Protocol Error Mask */

Using ~BIT(X) is very usual. I would not do this, Principle of Least
Surprise.

>  struct oa_tc6 {
> -	struct spi_device *spi;
> -	bool ctrl_prot;
> +	struct completion rst_complete;
>  	struct task_struct *tc6_task;
>  	wait_queue_head_t tc6_wq;
> +	struct spi_device *spi;
> +	bool tx_cut_thr;
> +	bool rx_cut_thr;
> +	bool ctrl_prot;
>  	bool int_flag;
> -	struct completion rst_complete;
> +	u8 cps;
>  };

Please try not to move stuff around. It makes the diff bigger than it
should be.

       Andrew
