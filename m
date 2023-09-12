Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F979D88C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjILSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbjILSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:21:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143EE115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:20:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id g80HqWghJPHcUg80HqUPtU; Tue, 12 Sep 2023 20:20:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694542851;
        bh=xDmSq0OoxamNwlukPoVQ+4tmbtEaTSofj7aVhezryxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VAw3XNchmCrB3zbMs0PNSOJLj18W26cyXopiallDZwpv82h5XFfp+hTjG8O1CgsLP
         iFv1IqNO1y/UwxmOcbiJeeFUx4yUgvW35G/4vP+GPj9BKHzjw2pfT+jZoSNETS3Tmf
         G9GDS2XTNiYs6YUZQv/Vu6WO0sNRHwKeH2QtmCRX79SuARmpwXnaRVX087olQJo2VP
         FJddabOevCnURIBIrbr9J0H1sE4R+CA4CsQmD7z7VcR99GR8KUHxC69GuVAh3LSzT+
         JHq3+oQ+djLkQljWnyrBVxJ7gb3xOrL9l4DpDOLx3cXfInT37R7PNN/hO3Xbqv5AyG
         9m8M/fmGuW/MQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Sep 2023 20:20:51 +0200
X-ME-IP: 86.243.2.178
Message-ID: <412c5225-e9c0-6a8d-1b39-2ce60cbf8074@wanadoo.fr>
Date:   Tue, 12 Sep 2023 20:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm7271: Use dev_err_probe() instead
 of dev_err()
Content-Language: fr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230912165550.402540-1-andriy.shevchenko@linux.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230912165550.402540-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/09/2023 à 18:55, Andy Shevchenko a écrit :
> Make the error messages format unified by switching to use
> dev_err_probe() where it makes sense.
> 
> This also helps simplifing the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_bcm7271.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index aa5aff046756..51c3eca8673c 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -984,10 +984,9 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	}
>   
>   	/* We should have just the uart base registers or all the registers */
> -	if (x != 1 && x != REGS_MAX) {
> -		dev_warn(dev, "%s registers not specified\n", reg_names[x]);
> -		return -EINVAL;
> -	}
> +	if (x != 1 && x != REGS_MAX)
> +		return dev_err_probe(dev, -EINVAL, "%s registers not specified\n",
> +				     reg_names[x]);
>   
>   	/* if the DMA registers were specified, try to enable DMA */
>   	if (x > REGS_DMA_RX) {
> @@ -1034,8 +1033,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	}
>   
>   	if (clk_rate == 0) {
> -		dev_err(dev, "clock-frequency or clk not defined\n");
> -		ret = -EINVAL;
> +		ret = dev_err_probe(dev, -EINVAL, "clock-frequency or clk not defined\n");
>   		goto err_clk_disable;
>   	}
>   
> @@ -1093,7 +1091,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>   
>   	ret = serial8250_register_8250_port(&up);
>   	if (ret < 0) {
> -		dev_err(dev, "unable to register 8250 port\n");
> +		dev_err_probe(dev, ret, "unable to register 8250 port\n");
>   		goto err;
>   	}
>   	priv->line = ret;
> @@ -1102,14 +1100,13 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	if (priv->dma_enabled) {
>   		dma_irq = platform_get_irq_byname(pdev,  "dma");
>   		if (dma_irq < 0) {
> -			ret = dma_irq;
> -			dev_err(dev, "no IRQ resource info\n");
> +			dev_err_probe(dev, dma_irq, "no IRQ resource info\n");

ret = dev_err_probe(dev, dma_irq, "no IRQ resource info\n");

>   			goto err1;
>   		}
>   		ret = devm_request_irq(dev, dma_irq, brcmuart_isr,
>   				IRQF_SHARED, "uart DMA irq", &new_port->port);
>   		if (ret) {
> -			dev_err(dev, "unable to register IRQ handler\n");
> +			dev_err_probe(dev, ret, "unable to register IRQ handler\n");
>   			goto err1;
>   		}
>   	}

