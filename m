Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A479DE52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbjIMCkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjIMCkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:40:15 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0371713;
        Tue, 12 Sep 2023 19:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BXJm/TiqH4AAPAwfc/Qy2jYjA5r7iu+40UTmJpL7FD8=; b=YOctBJGu7AFO85kb3gkWsFXT5l
        6Hb1ei68Q/4Sosm4kuzQ3VBJi9uFgKjj7ugOoHCxlS/dfY7Ay67gXOYwx/jEsuH66ct79qdvE5lz5
        CLhHt5WyVcoeM9J3IOVQzgT9cb6p7+xoYbF92JlsBZSZb/YsnxuaIcuZbHDw1IO8Usss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgFn3-006H2p-GA; Wed, 13 Sep 2023 04:39:41 +0200
Date:   Wed, 13 Sep 2023 04:39:41 +0200
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
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Message-ID: <027d8f7b-6932-4d9d-b2f9-5369806a79a3@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int oa_tc6_sw_reset(struct oa_tc6 *tc6)
> +{
> +	long timeleft;
> +	u32 regval;
> +	int ret;
> +
> +	/* Perform software reset with both protected and unprotected control
> +	 * commands because the driver doesn't know the current status of the
> +	 * MAC-PHY.
> +	 */
> +	regval = SW_RESET;
> +	reinit_completion(&tc6->rst_complete);
> +	ret = oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1, true, false);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "RESET register write failed\n");
> +		return ret;
> +	}
> +
> +	ret = oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1, true, true);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "RESET register write failed\n");
> +		return ret;
> +	}
> +	timeleft = wait_for_completion_interruptible_timeout(&tc6->rst_complete,
> +							     msecs_to_jiffies(1));
> +	if (timeleft <= 0) {
> +		dev_err(&tc6->spi->dev, "MAC-PHY reset failed\n");
> +		return -ENODEV;
> +	}

This seems a bit messy and complex. I assume reset is performed once
during probe, and never again? So i wonder if it would be cleaner to
actually just poll for the reset to complete? You can then remove all
this completion code, and the interrupt handler gets simpler?

> +	/* Register MAC-PHY interrupt service routine */
> +	ret = devm_request_irq(&spi->dev, spi->irq, macphy_irq, 0, "macphy int",
> +			       tc6);
> +	if ((ret != -ENOTCONN) && ret < 0) {
> +		dev_err(&spi->dev, "Error attaching macphy irq %d\n", ret);
> +		goto err_macphy_irq;
> +	}

Why is -ENOTCONN special? A comment would be good here.

> -void oa_tc6_deinit(struct oa_tc6 *tc6)
> +int oa_tc6_deinit(struct oa_tc6 *tc6)
>  {
> -	kfree(tc6);
> +	int ret;
> +
> +	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
> +	ret = kthread_stop(tc6->tc6_task);
> +	if (!ret)
> +		kfree(tc6);
> +	return ret;
>  }

What is the MAC driver supposed to do if this fails?

But this problem probably goes away once you use a threaded interrupt
handler.

w> +/* Open Alliance TC6 Standard Control and Status Registers */
> +#define OA_TC6_RESET	0x0003		/* Reset Control and Status Register */
> +#define OA_TC6_STS0	0x0008		/* Status Register #0 */

Please use the same name as the standard. It use STATUS0, so
OA_TC6_STATUS0. Please make sure all your defines follow the standard.

> +
> +/* RESET register field */
> +#define SW_RESET	BIT(0)		/* Software Reset */

It is pretty normal to put #defines for a register members after the
#define for the register itself:

#define OA_TC6_RESET	0x0003		/* Reset Control and Status Register */
#define OA_TC6_RESET_SWRESET	BIT(0)

#define OA_TC6_STATUS0	0x0008		/* Status Register #0 */
#define OA_TC6_STATUS0_RESETC		BIT(6)		/* Reset Complete */

The naming like this also helps avoid mixups.

    Andrew
