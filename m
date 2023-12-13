Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7019812128
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjLMWEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMWEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:04:34 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9CDA3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:04:40 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58d1b767b2bso4780149eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505079; x=1703109879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4OPTogfVv1ZY+r+8gNK2KKTBuXiCXIz5vFe+cYHeuU=;
        b=PJNFy3YJbyvwerbUXPLauHcDwp+7kWXoONPWmqt+cjY2pL/FCjm7FvfXuUMVfwFMsY
         OELNgCYtdSFu9OoALQ8awCqsxs60q51qPPo8x7frN/ErtEDZoGrzOqwxlUN3XelRFlXz
         9l1najAAe2y1MAR+VmGKFvCnwTuJNmCD+fyaalQoJv3vh9sRppV39YTY6Y8DbreaDTBA
         ecCwNS41uYA1Jl9TXSiEBSNLKkx17610bBZXmZPMQM59p+5zSYUQeFJnl2fq+XXKf696
         oHT6xRpisRNeF73EtZRO7KIxeV2Vysu4I0+PaBcji8wRa1xAZ0U65+ax73/CS68V+BkM
         DK/g==
X-Gm-Message-State: AOJu0YwcQ7vzvwSo1Dv+VAbOPlfklb8+EP5InzazOX6Ufv62BGvzJn/+
        rObMw/NloucNe3Zm+fb0Og==
X-Google-Smtp-Source: AGHT+IGdF9F6O9LTxZgS8q3vuCx3hdnxKDs33XeGnWYMMp1Int23TCA0rSiE9RA/oFIRnV/IRIZX/w==
X-Received: by 2002:a4a:6701:0:b0:58e:1c47:76c6 with SMTP id f1-20020a4a6701000000b0058e1c4776c6mr5289216ooc.18.1702505079242;
        Wed, 13 Dec 2023 14:04:39 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id az2-20020a056830458200b006d87b9d84bfsm2960478otb.12.2023.12.13.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:04:38 -0800 (PST)
Received: (nullmailer pid 2150081 invoked by uid 1000);
        Wed, 13 Dec 2023 22:04:37 -0000
Date:   Wed, 13 Dec 2023 16:04:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 5/6] platform: Modify platform_get_irq_optional() to
 use resource
Message-ID: <20231213220437.GA2115075-robh@kernel.org>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.5.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110009.v1.5.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:00:23AM -0700, Mark Hasemeyer wrote:
> Unify handling of ACPI, GPIO, devictree, and platform resource
> interrupts in platform_get_irq_optional(). Each of these subsystems
> provide their own apis which provide IRQ information as a struct
> resource. This simplifies the logic of the function and allows callers
> to get more information about the irq by looking at the resource flags.
> For example, whether or not an irq is wake capable.
> 
> Rename the function to platform_get_irq_resource() to better describe
> the function's new behavior.

This is misleading as the original function is still there.

The get_optional() functions are designed to not print an error message 
where as the non-optional variant will. You've broken that pattern here 
in that there is no platform_get_irq_resource_optional() (at least named 
that because your implementation is that since there is no error 
message).

What about versions equivalent to platform_get_irq_byname() 
and platform_get_irq_byname_optional(), though I guess we need users 
first.

> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
>  drivers/base/platform.c         | 78 ++++++++++++++++++---------------
>  include/linux/platform_device.h |  9 +++-
>  2 files changed, 50 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 76bfcba250039..6b58bde776d4f 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -151,9 +151,10 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
>  #endif /* CONFIG_HAS_IOMEM */
>  
>  /**
> - * platform_get_irq_optional - get an optional IRQ for a device
> + * platform_get_irq_resource - get an IRQ for a device and populate resource struct
>   * @dev: platform device
>   * @num: IRQ number index
> + * @r: pointer to resource to populate with irq information. It is not modified on failure.
>   *
>   * Gets an IRQ for a platform device. Device drivers should check the return
>   * value for errors so as to not pass a negative integer value to the
> @@ -162,59 +163,47 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
>   *
>   * For example::
>   *
> - *		int irq = platform_get_irq_optional(pdev, 0);
> + *		int irq = platform_get_irq_resource(pdev, 0, &res);
>   *		if (irq < 0)
>   *			return irq;
>   *
>   * Return: non-zero IRQ number on success, negative error number on failure.
>   */
> -int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
> +int platform_get_irq_resource(struct platform_device *dev, unsigned int num, struct resource *r)
>  {
>  	int ret;
>  #ifdef CONFIG_SPARC
>  	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
>  	if (!dev || num >= dev->archdata.num_irqs)
> -		goto out_not_found;
> +		return -ENXIO;
>  	ret = dev->archdata.irqs[num];
> +	if (ret >= 0)
> +		*r = (struct resource)DEFINE_RES_IRQ(ret);
>  	goto out;
>  #else
> -	struct resource *r;
> +	struct resource *platform_res;
>  
>  	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> -		ret = of_irq_get(dev->dev.of_node, num);
> +		ret = of_irq_to_resource(dev->dev.of_node, num, r);
>  		if (ret > 0 || ret == -EPROBE_DEFER)
>  			goto out;
>  	}
>  
> -	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> -	if (has_acpi_companion(&dev->dev)) {
> -		if (r && r->flags & IORESOURCE_DISABLED) {
> -			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> -			if (ret)
> -				goto out;
> -		}
> -	}
> -
> -	/*
> -	 * The resources may pass trigger flags to the irqs that need
> -	 * to be set up. It so happens that the trigger flags for
> -	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
> -	 * settings.
> -	 */
> -	if (r && r->flags & IORESOURCE_BITS) {
> -		struct irq_data *irqd;
> -
> -		irqd = irq_get_irq_data(r->start);
> -		if (!irqd)
> -			goto out_not_found;
> -		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
> -	}
> -
> -	if (r) {
> +	platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);
> +	if (platform_res && !(platform_res->flags & IORESOURCE_DISABLED)) {
> +		*r = *platform_res;
>  		ret = r->start;
>  		goto out;
>  	}
>  
> +	if (has_acpi_companion(&dev->dev)) {
> +		ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> +		if (!ret || ret == -EPROBE_DEFER) {
> +			ret = ret ?: r->start;
> +			goto out;
> +		}
> +	}
> +
>  	/*
>  	 * For the index 0 interrupt, allow falling back to GpioInt
>  	 * resources. While a device could have both Interrupt and GpioInt
> @@ -223,21 +212,38 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>  	 * allows a common code path across either kind of resource.
>  	 */
>  	if (num == 0 && has_acpi_companion(&dev->dev)) {
> -		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> +		ret = acpi_dev_get_gpio_irq_resource(ACPI_COMPANION(&dev->dev), NULL,
> +						     num, r);
>  		/* Our callers expect -ENXIO for missing IRQs. */
> -		if (ret >= 0 || ret == -EPROBE_DEFER)
> +		if (!ret || ret == -EPROBE_DEFER) {
> +			ret = ret ?: r->start;
>  			goto out;
> +		}
>  	}
> -
>  #endif
> -out_not_found:
>  	ret = -ENXIO;
>  out:
>  	if (WARN(!ret, "0 is an invalid IRQ number\n"))
>  		return -EINVAL;
> +
> +	/*
> +	 * The resources may pass trigger flags to the irqs that need
> +	 * to be set up. It so happens that the trigger flags for
> +	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
> +	 * settings.
> +	 */
> +	if (ret > 0 && r->flags & IORESOURCE_BITS) {
> +		struct irq_data *irqd;
> +
> +		irqd = irq_get_irq_data(r->start);
> +		if (!irqd)
> +			ret = -ENXIO;
> +		else
> +			irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);

We were not doing any of this in the DT or Sparc cases before. It's 
probably just redundant for DT. It might break Sparc.

Rob
