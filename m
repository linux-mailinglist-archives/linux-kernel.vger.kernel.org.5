Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AF75FADB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGXPeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGXPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:34:17 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052FB1;
        Mon, 24 Jul 2023 08:34:15 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 3E6C916DD52;
        Mon, 24 Jul 2023 17:34:10 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1690212850; bh=CFxh3d477oOhYZ3uvUhGHQpP6GUzR0mq4w1y/nNw4og=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yUexeB26xN5tLOCfdVZM7bR3qhrCqYJbvGmRWeskacpy4hE4VsOwhKDawqemC+iqc
         j+BbOBuU06Iyg7ey3yPsZZJSPm+LMtouN7R1QJQv8/0zq5WqWGJHXdoiFkLW0So5qF
         uLFMGBpl8zi8v/C6B3aogibXccHxoZKbAO8gFM/hnd7zWXMNuRR/rz8JnjsOZq2B/j
         l0bx6ahgHKJxLyHo7bkKwU00qOOhrBPwWYaIz0PSIfW+IdzVtPIK/TLls0q5EOyRH3
         EEvr0/dKKm09Xr46DwzLkQaAQZYvRJqmvnZUR4CbmnW1ydSpjck5w1F6ot+yP2O63/
         08qaj0iEcFRfg==
Date:   Mon, 24 Jul 2023 17:34:08 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
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
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
Message-ID: <20230724173408.5d951e8c@meshulam.tesarici.cz>
In-Reply-To: <jang73ontcdxo7zliixfeyll7za5e7es2rfjc53kpube7bq5nv@fhbxuk37o7kb>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
        <jang73ontcdxo7zliixfeyll7za5e7es2rfjc53kpube7bq5nv@fhbxuk37o7kb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 15:22:50 +0200
Jacopo Mondi <jacopo.mondi@ideasonboard.com> wrote:

> Hi Petr,
> 
> On Mon, Jul 24, 2023 at 02:07:42PM +0200, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> >
> > In all these cases, the last argument to dma_declare_coherent_memory() is
> > the buffer end address, but the expected value should be the size of the
> > reserved region.
> >
> > Fixes: 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera driver")
> > Fixes: c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
> > Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> > Fixes: 186c446f4b84 ("media: arch: sh: migor: Use new renesas-ceu camera driver")
> > Fixes: 1a3c230b4151 ("media: arch: sh: ms7724se: Use new renesas-ceu camera driver")  
> 
> Ups, seems like I have introduced all of these! thanks for fixing

No problem. The same code was obviously copied to all boards that have
a renesas-ceu camera. ;-)

Petr T

> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> 
> Thanks
>   j
> 
> > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > ---
> >  arch/sh/boards/mach-ap325rxa/setup.c | 2 +-
> >  arch/sh/boards/mach-ecovec24/setup.c | 6 ++----
> >  arch/sh/boards/mach-kfr2r09/setup.c  | 2 +-
> >  arch/sh/boards/mach-migor/setup.c    | 2 +-
> >  arch/sh/boards/mach-se/7724/setup.c  | 6 ++----
> >  5 files changed, 7 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
> > index 151792162152..645cccf3da88 100644
> > --- a/arch/sh/boards/mach-ap325rxa/setup.c
> > +++ b/arch/sh/boards/mach-ap325rxa/setup.c
> > @@ -531,7 +531,7 @@ static int __init ap325rxa_devices_setup(void)
> >  	device_initialize(&ap325rxa_ceu_device.dev);
> >  	dma_declare_coherent_memory(&ap325rxa_ceu_device.dev,
> >  			ceu_dma_membase, ceu_dma_membase,
> > -			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
> > +			CEU_BUFFER_MEMORY_SIZE);
> >
> >  	platform_device_add(&ap325rxa_ceu_device);
> >
> > diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> > index 674da7ebd8b7..7ec03d4a4edf 100644
> > --- a/arch/sh/boards/mach-ecovec24/setup.c
> > +++ b/arch/sh/boards/mach-ecovec24/setup.c
> > @@ -1454,15 +1454,13 @@ static int __init arch_setup(void)
> >  	device_initialize(&ecovec_ceu_devices[0]->dev);
> >  	dma_declare_coherent_memory(&ecovec_ceu_devices[0]->dev,
> >  				    ceu0_dma_membase, ceu0_dma_membase,
> > -				    ceu0_dma_membase +
> > -				    CEU_BUFFER_MEMORY_SIZE - 1);
> > +				    CEU_BUFFER_MEMORY_SIZE);
> >  	platform_device_add(ecovec_ceu_devices[0]);
> >
> >  	device_initialize(&ecovec_ceu_devices[1]->dev);
> >  	dma_declare_coherent_memory(&ecovec_ceu_devices[1]->dev,
> >  				    ceu1_dma_membase, ceu1_dma_membase,
> > -				    ceu1_dma_membase +
> > -				    CEU_BUFFER_MEMORY_SIZE - 1);
> > +				    CEU_BUFFER_MEMORY_SIZE);
> >  	platform_device_add(ecovec_ceu_devices[1]);
> >
> >  	gpiod_add_lookup_table(&cn12_power_gpiod_table);
> > diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
> > index 20f4db778ed6..c6d556dfbbbe 100644
> > --- a/arch/sh/boards/mach-kfr2r09/setup.c
> > +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> > @@ -603,7 +603,7 @@ static int __init kfr2r09_devices_setup(void)
> >  	device_initialize(&kfr2r09_ceu_device.dev);
> >  	dma_declare_coherent_memory(&kfr2r09_ceu_device.dev,
> >  			ceu_dma_membase, ceu_dma_membase,
> > -			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
> > +			CEU_BUFFER_MEMORY_SIZE);
> >
> >  	platform_device_add(&kfr2r09_ceu_device);
> >
> > diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> > index f60061283c48..773ee767d0c4 100644
> > --- a/arch/sh/boards/mach-migor/setup.c
> > +++ b/arch/sh/boards/mach-migor/setup.c
> > @@ -604,7 +604,7 @@ static int __init migor_devices_setup(void)
> >  	device_initialize(&migor_ceu_device.dev);
> >  	dma_declare_coherent_memory(&migor_ceu_device.dev,
> >  			ceu_dma_membase, ceu_dma_membase,
> > -			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
> > +			CEU_BUFFER_MEMORY_SIZE);
> >
> >  	platform_device_add(&migor_ceu_device);
> >
> > diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
> > index b60a2626e18b..6495f9354065 100644
> > --- a/arch/sh/boards/mach-se/7724/setup.c
> > +++ b/arch/sh/boards/mach-se/7724/setup.c
> > @@ -940,15 +940,13 @@ static int __init devices_setup(void)
> >  	device_initialize(&ms7724se_ceu_devices[0]->dev);
> >  	dma_declare_coherent_memory(&ms7724se_ceu_devices[0]->dev,
> >  				    ceu0_dma_membase, ceu0_dma_membase,
> > -				    ceu0_dma_membase +
> > -				    CEU_BUFFER_MEMORY_SIZE - 1);
> > +				    CEU_BUFFER_MEMORY_SIZE);
> >  	platform_device_add(ms7724se_ceu_devices[0]);
> >
> >  	device_initialize(&ms7724se_ceu_devices[1]->dev);
> >  	dma_declare_coherent_memory(&ms7724se_ceu_devices[1]->dev,
> >  				    ceu1_dma_membase, ceu1_dma_membase,
> > -				    ceu1_dma_membase +
> > -				    CEU_BUFFER_MEMORY_SIZE - 1);
> > +				    CEU_BUFFER_MEMORY_SIZE);
> >  	platform_device_add(ms7724se_ceu_devices[1]);
> >
> >  	return platform_add_devices(ms7724se_devices,
> > --
> > 2.25.1
> >  

