Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04D7F5C81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbjKWKh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKWKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:37:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0B01BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:38:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55ADC433C8;
        Thu, 23 Nov 2023 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700735881;
        bh=jNCvrYLWqFSMORBcd4VCK5iJmMYxeQ+pIicJZR1QdZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsF3kppGdYawW3i9ssq3ugB1MO1LBA6OQUjLWRF1guLmmJ8TOW3t9LMwbxsKBcJ+g
         zzIs1OOwIEY6MOFArp1AUt9Adt6vg4BoV4ercW4rwPUzVqgGJQCgz40Jjh4klDaQjo
         qANSsF44mdfTn2CJ7p9i8B958N8pVMxUtnaUyDsG0/sy2oQG+ab5ra8r5y0Bj399SR
         zeF1c5mqStT3VIkAAO/m3o97UyJ8KD/q4hpOcoaQRV5O7zeH0VpTkLx4Q+goDh/2RU
         C/kdUqnuNeDdxOqAvQjAivOxiBTqXwsND2WHyDoMdov7wn7UFHIDtk3bcaK9ObUAFB
         orjusgieYHYOA==
Date:   Thu, 23 Nov 2023 10:37:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     tony@atomide.com, robh@kernel.org, wens@csie.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
Message-ID: <20231123103756.GD1184245@google.com>
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023, Peter Ujfalusi wrote:

> The core twl chip is probed via i2c and the dev->driver->of_match_table is
> NULL, causing the driver to fail to probe.
> 
> This partially reverts commit 1e0c866887f4.
> 
> Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
>  drivers/mfd/twl6030-irq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index f9fce8408c2c..3c03681c124c 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -24,10 +24,10 @@
>  #include <linux/kthread.h>
>  #include <linux/mfd/twl.h>
>  #include <linux/platform_device.h>
> -#include <linux/property.h>
>  #include <linux/suspend.h>
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of_device.h>
>  
>  #include "twl-core.h"
>  
> @@ -368,10 +368,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
>  	int			nr_irqs;
>  	int			status;
>  	u8			mask[3];
> -	const int		*irq_tbl;
> +	const struct of_device_id *of_id;
>  
> -	irq_tbl = device_get_match_data(dev);
> -	if (!irq_tbl) {
> +	of_id = of_match_device(twl6030_of_match, dev);

I think you just dropped support for ACPI.

Rob, care to follow-up?

> +	if (!of_id || !of_id->data) {
>  		dev_err(dev, "Unknown TWL device model\n");
>  		return -EINVAL;
>  	}
> @@ -409,7 +409,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
>  
>  	twl6030_irq->pm_nb.notifier_call = twl6030_irq_pm_notifier;
>  	atomic_set(&twl6030_irq->wakeirqs, 0);
> -	twl6030_irq->irq_mapping_tbl = irq_tbl;
> +	twl6030_irq->irq_mapping_tbl = of_id->data;
>  
>  	twl6030_irq->irq_domain =
>  		irq_domain_add_linear(node, nr_irqs,
> -- 
> 2.42.0
> 

-- 
Lee Jones [李琼斯]
