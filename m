Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799E7984E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbjIHJgf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjIHJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:36:34 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE5111B;
        Fri,  8 Sep 2023 02:36:30 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qeXuE-000ROj-Ku; Fri, 08 Sep 2023 11:36:02 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qeXuE-001TFN-E4; Fri, 08 Sep 2023 11:36:02 +0200
Message-ID: <bfb42a25b5827917cf37892263449250a823e8ce.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Date:   Fri, 08 Sep 2023 11:36:01 +0200
In-Reply-To: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-24 at 14:07 +0200, Petr Tesarik wrote:
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

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
