Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72B75F81F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjGXNXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGXNW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:22:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BEDA;
        Mon, 24 Jul 2023 06:22:56 -0700 (PDT)
Received: from ideasonboard.com (mob-5-91-20-233.net.vodafone.it [5.91.20.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78074127D;
        Mon, 24 Jul 2023 15:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690204916;
        bh=418muW5WhsvyVZBRLNaDQZjohOlpMZa8lNZ979byWfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5kyipbPibcs6zLxBen6qMoe13IILEaqCquvavvfXOrewKTqTgyiKdszGoy5k9b0V
         QxoJQq3VBlKfKEySOtz2IfLlswtOSPfNk39SQGiV3FQFyFqGoR/Itf8ldtPLpxRx6i
         PPsUDysgCSER64VwPxwJtFB6UF5ufnjVgef31HhU=
Date:   Mon, 24 Jul 2023 15:22:50 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
Message-ID: <jang73ontcdxo7zliixfeyll7za5e7es2rfjc53kpube7bq5nv@fhbxuk37o7kb>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Mon, Jul 24, 2023 at 02:07:42PM +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>
> In all these cases, the last argument to dma_declare_coherent_memory() is
> the buffer end address, but the expected value should be the size of the
> reserved region.
>
> Fixes: 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera driver")
> Fixes: c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
> Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> Fixes: 186c446f4b84 ("media: arch: sh: migor: Use new renesas-ceu camera driver")
> Fixes: 1a3c230b4151 ("media: arch: sh: ms7724se: Use new renesas-ceu camera driver")

Ups, seems like I have introduced all of these! thanks for fixing
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> ---
>  arch/sh/boards/mach-ap325rxa/setup.c | 2 +-
>  arch/sh/boards/mach-ecovec24/setup.c | 6 ++----
>  arch/sh/boards/mach-kfr2r09/setup.c  | 2 +-
>  arch/sh/boards/mach-migor/setup.c    | 2 +-
>  arch/sh/boards/mach-se/7724/setup.c  | 6 ++----
>  5 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
> index 151792162152..645cccf3da88 100644
> --- a/arch/sh/boards/mach-ap325rxa/setup.c
> +++ b/arch/sh/boards/mach-ap325rxa/setup.c
> @@ -531,7 +531,7 @@ static int __init ap325rxa_devices_setup(void)
>  	device_initialize(&ap325rxa_ceu_device.dev);
>  	dma_declare_coherent_memory(&ap325rxa_ceu_device.dev,
>  			ceu_dma_membase, ceu_dma_membase,
> -			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
> +			CEU_BUFFER_MEMORY_SIZE);
>
>  	platform_device_add(&ap325rxa_ceu_device);
>
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 674da7ebd8b7..7ec03d4a4edf 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -1454,15 +1454,13 @@ static int __init arch_setup(void)
>  	device_initialize(&ecovec_ceu_devices[0]->dev);
>  	dma_declare_coherent_memory(&ecovec_ceu_devices[0]->dev,
>  				    ceu0_dma_membase, ceu0_dma_membase,
> -				    ceu0_dma_membase +
> -				    CEU_BUFFER_MEMORY_SIZE - 1);
> +				    CEU_BUFFER_MEMORY_SIZE);
>  	platform_device_add(ecovec_ceu_devices[0]);
>
>  	device_initialize(&ecovec_ceu_devices[1]->dev);
>  	dma_declare_coherent_memory(&ecovec_ceu_devices[1]->dev,
>  				    ceu1_dma_membase, ceu1_dma_membase,
> -				    ceu1_dma_membase +
> -				    CEU_BUFFER_MEMORY_SIZE - 1);
> +				    CEU_BUFFER_MEMORY_SIZE);
>  	platform_device_add(ecovec_ceu_devices[1]);
>
>  	gpiod_add_lookup_table(&cn12_power_gpiod_table);
> diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
> index 20f4db778ed6..c6d556dfbbbe 100644
> --- a/arch/sh/boards/mach-kfr2r09/setup.c
> +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -603,7 +603,7 @@ static int __init kfr2r09_devices_setup(void)
>  	device_initialize(&kfr2r09_ceu_device.dev);
>  	dma_declare_coherent_memory(&kfr2r09_ceu_device.dev,
>  			ceu_dma_membase, ceu_dma_membase,
> -			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
> +			CEU_BUFFER_MEMORY_SIZE);
>
>  	platform_device_add(&kfr2r09_ceu_device);
>
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> index f60061283c48..773ee767d0c4 100644
> --- a/arch/sh/boards/mach-migor/setup.c
> +++ b/arch/sh/boards/mach-migor/setup.c
> @@ -604,7 +604,7 @@ static int __init migor_devices_setup(void)
>  	device_initialize(&migor_ceu_device.dev);
>  	dma_declare_coherent_memory(&migor_ceu_device.dev,
>  			ceu_dma_membase, ceu_dma_membase,
> -			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
> +			CEU_BUFFER_MEMORY_SIZE);
>
>  	platform_device_add(&migor_ceu_device);
>
> diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
> index b60a2626e18b..6495f9354065 100644
> --- a/arch/sh/boards/mach-se/7724/setup.c
> +++ b/arch/sh/boards/mach-se/7724/setup.c
> @@ -940,15 +940,13 @@ static int __init devices_setup(void)
>  	device_initialize(&ms7724se_ceu_devices[0]->dev);
>  	dma_declare_coherent_memory(&ms7724se_ceu_devices[0]->dev,
>  				    ceu0_dma_membase, ceu0_dma_membase,
> -				    ceu0_dma_membase +
> -				    CEU_BUFFER_MEMORY_SIZE - 1);
> +				    CEU_BUFFER_MEMORY_SIZE);
>  	platform_device_add(ms7724se_ceu_devices[0]);
>
>  	device_initialize(&ms7724se_ceu_devices[1]->dev);
>  	dma_declare_coherent_memory(&ms7724se_ceu_devices[1]->dev,
>  				    ceu1_dma_membase, ceu1_dma_membase,
> -				    ceu1_dma_membase +
> -				    CEU_BUFFER_MEMORY_SIZE - 1);
> +				    CEU_BUFFER_MEMORY_SIZE);
>  	platform_device_add(ms7724se_ceu_devices[1]);
>
>  	return platform_add_devices(ms7724se_devices,
> --
> 2.25.1
>
