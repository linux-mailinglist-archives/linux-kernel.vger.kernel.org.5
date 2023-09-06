Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4269793E09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjIFNtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjIFNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:49:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C1E10D3;
        Wed,  6 Sep 2023 06:49:24 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qdsuI-0002DX-9q; Wed, 06 Sep 2023 15:49:22 +0200
Message-ID: <6406fb2e-afb2-461d-9bac-aa157cf6d16f@leemhuis.info>
Date:   Wed, 6 Sep 2023 15:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: zynq: restore
 zynq_gpio_irq_reqres/zynq_gpio_irq_relres callbacks
Content-Language: en-US, de-DE
To:     Daniel Mack <daniel@zonque.org>, linux-gpio@vger.kernel.org,
        manikanta.guntupalli@amd.com
Cc:     linux-kernel@vger.kernel.org, stable@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230901122424.247070-1-daniel@zonque.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230901122424.247070-1-daniel@zonque.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694008164;3b961e7f;
X-HE-SMSGID: 1qdsuI-0002DX-9q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing Arnd (wrote the culprit), Linus (reviewed it), Bartosz (applied
it), and the regressions mailing list

On 01.09.23 14:24, Daniel Mack wrote:
> Commit f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip
> warning") ditched the open-coded resource allocation handlers in favor
> of the generic ones. These generic handlers don't maintain the PM
> runtime anymore, which causes a regression in that level IRQs are no
> longer reported.
> 
> Restore the original handlers to fix this.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Fixes: f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip warning")
> Cc: stable@kernel.org

This seems to be a regression report that comes straight with a fix, but
there wasn't a single reply yet afaics. :-/ Maybe the extended list of
recipients will get things moving. But to ensure this doesn't fall
through the cracks, I'll add it to the list of tracked regressions.

#regzbot ^introduced f56914393537
#regzbot title gpio: zynq: in that level IRQs are no longer reported
#regzbot fix: gpio: zynq: restore
zynq_gpio_irq_reqres/zynq_gpio_irq_relres callbacks
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> ---
>  drivers/gpio/gpio-zynq.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
> index 0a7264aabe48..324e942c0650 100644
> --- a/drivers/gpio/gpio-zynq.c
> +++ b/drivers/gpio/gpio-zynq.c
> @@ -575,6 +575,26 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
>  	return 0;
>  }
>  
> +static int zynq_gpio_irq_reqres(struct irq_data *d)
> +{
> +	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(chip->parent);
> +	if (ret < 0)
> +		return ret;
> +
> +	return gpiochip_reqres_irq(chip, d->hwirq);
> +}
> +
> +static void zynq_gpio_irq_relres(struct irq_data *d)
> +{
> +	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> +
> +	gpiochip_relres_irq(chip, d->hwirq);
> +	pm_runtime_put(chip->parent);
> +}
> +
>  /* irq chip descriptor */
>  static const struct irq_chip zynq_gpio_level_irqchip = {
>  	.name		= DRIVER_NAME,
> @@ -584,9 +604,10 @@ static const struct irq_chip zynq_gpio_level_irqchip = {
>  	.irq_unmask	= zynq_gpio_irq_unmask,
>  	.irq_set_type	= zynq_gpio_set_irq_type,
>  	.irq_set_wake	= zynq_gpio_set_wake,
> +	.irq_request_resources = zynq_gpio_irq_reqres,
> +	.irq_release_resources = zynq_gpio_irq_relres,
>  	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
>  			  IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> -	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>  
>  static const struct irq_chip zynq_gpio_edge_irqchip = {
> @@ -597,8 +618,9 @@ static const struct irq_chip zynq_gpio_edge_irqchip = {
>  	.irq_unmask	= zynq_gpio_irq_unmask,
>  	.irq_set_type	= zynq_gpio_set_irq_type,
>  	.irq_set_wake	= zynq_gpio_set_wake,
> +	.irq_request_resources = zynq_gpio_irq_reqres,
> +	.irq_release_resources = zynq_gpio_irq_relres,
>  	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> -	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>  
>  static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
