Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17576E774
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjHCLz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:55:27 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AE7273B;
        Thu,  3 Aug 2023 04:55:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AECCC0002;
        Thu,  3 Aug 2023 11:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691063725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnhyjKVpf0n1sR5WP4gOBdz3FzR1RW0pL4jjoZR/q1Q=;
        b=YCHWxzu7ACHg1RjcckaCDSLn43AVY60Lykq+uIupNI/4syYi4nWe58LmJukawrEhuTOsiv
        T1dP0/4bIPZK1vyb4P0DqWEo0daWrt19rPgD63AaIEXqhR6gYM4C81uWQupSn57jL3dPiV
        SuWwWgCiBlwICWuugOQ8xUWHHsQ7X6T502s4EZHZMGGC94M6VMQC7Tnaz9KEUEurzj5pEm
        8ZXNilMb8ORZSBD82HliJqIUOiH0+G2s4HrlGXKvUvGBPWJCDo2LYnLmfskTk4/06DKtFB
        Mfw0z87YqMqWo2ASSyG0ejG5VF73c0HolBvTg4UlolvaDGjrDradCY0KluSA1A==
Date:   Thu, 3 Aug 2023 13:55:23 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <robh@kernel.org>, <aaro.koskinen@iki.fi>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] usb: gadget: udc: gr_udc: Do not check 0 for
 platform_get_irq()
Message-ID: <20230803135523.3959059c@bootlin.com>
In-Reply-To: <20230803114246.79820-1-wangzhu9@huawei.com>
References: <20230803114246.79820-1-wangzhu9@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhu,

On Thu, 3 Aug 2023 19:42:46 +0800
Zhu Wang <wangzhu9@huawei.com> wrote:

> When platform_get_irq_byname() is called to get a interrupt number, it
> may return -EINVAL or -ENXIO when failed, while current code returned
> -ENODEV, so we replace it with the return value of
> platform_get_irq_byname(). And we found that platform_get_irq_byname()
> never returned zero by reading its code.

The function involve in the code is not platform_get_irq_byname() but
platform_get_irq(). Can you update ?

With this updated,
Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

> 
> Commit ce753ad1549c ("platform: finally disallow IRQ0 in
> platform_get_irq() and its ilk") makes sure IRQ0 is not returned.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> 
> ---
> Changes in v2:
> - Update the commit message, present the reason of replacing the return
> value of the probe.
> ---
>  drivers/usb/gadget/udc/gr_udc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
> index 0c3969301a53..c6dfa7cccc11 100644
> --- a/drivers/usb/gadget/udc/gr_udc.c
> +++ b/drivers/usb/gadget/udc/gr_udc.c
> @@ -2136,15 +2136,15 @@ static int gr_probe(struct platform_device *pdev)
>  		return PTR_ERR(regs);
>  
>  	dev->irq = platform_get_irq(pdev, 0);
> -	if (dev->irq <= 0)
> -		return -ENODEV;
> +	if (dev->irq < 0)
> +		return dev->irq;
>  
>  	/* Some core configurations has separate irqs for IN and OUT events */
>  	dev->irqi = platform_get_irq(pdev, 1);
>  	if (dev->irqi > 0) {
>  		dev->irqo = platform_get_irq(pdev, 2);
> -		if (dev->irqo <= 0)
> -			return -ENODEV;
> +		if (dev->irqo < 0)
> +			return dev->irqo;
>  	} else {
>  		dev->irqi = 0;
>  	}



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
