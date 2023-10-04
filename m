Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B997B86D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjJDRnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJDRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:43:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E779E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:42:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c6219307b2so71235ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696441377; x=1697046177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAz1DFCYnOrFN4tIroBsTa6sPFO/dCrdBUsEUFQEyNU=;
        b=DN3V9vCzLrYoivi49vMp4dDuJ/ofMrXGrlbhyXoXwCeD+Adg1TCyq4HCZxSbgTAR1r
         3NHlWwY6cQVzoOkOtv/oGFyPj4kxiXVNjD26BPlHfgdz1AXI0NLIsIwyYpmegOOIToso
         es+6ep0WGLR+VO0FkfxdgPk/Z7NMALJ6bF5WKECVdI8KnEBfnViMzI+EzCMOWOBZx4PF
         Pc7XQ9odW7OVHCA2unJ5KhqRpHSbsOv3nX/lvTIm/a/5daPaU5TdwNEkZ+6n+NP+evBr
         DTM5fiSkgobswignL7sFLTok/BAXp9x36n0lJFjYfok+yCcNnz+74HSh/1TNZjs8s61k
         Tsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696441377; x=1697046177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAz1DFCYnOrFN4tIroBsTa6sPFO/dCrdBUsEUFQEyNU=;
        b=s3TAMtvU8RIvNXp65RgN+twY2g/B1hh55QddZuZs7rVQrQVjg+CODzFA/iM6LLfPRT
         73Wv0kvbcZYRUD2jlCLWyYfckFj0Rtk0t9UhGhsPzMu5vD8Le4O3qSFeOUEyZw1HdlKd
         w0RMulw3HZye4SZprAbd962KkpDCEnBBmJ8JOgZUl3Z512qLL88V5D6m8OTnU67b1+Yz
         8YG3FkPc0x9iZnNLXCOHGBYwAKNzEZ8PPxfAsjxAGDRFeYMYPTpml0i5z5dYSIM81LzA
         GDV8bReabhuL6UyQyY8ZzoRdVBrxThNo/KkYksyx73M1oopfTS0eFidz2UKcf5zXN5mU
         cW1Q==
X-Gm-Message-State: AOJu0Yym2odfyRjzSOHyzmPtsZH6Bn4bUEuDrZcoaIwLi+34FQPvg9hP
        cOEih8MZzSi7QOF5GIVcr5ZTUA==
X-Google-Smtp-Source: AGHT+IGCU8SV8LgeVtV8MEhdZCojuC38BkViH9No+0IHftNGmQ/M48mEVbfFLmkXJV2TQfY+9EjP+w==
X-Received: by 2002:a17:903:25c3:b0:1c5:76b6:d4f7 with SMTP id jc3-20020a17090325c300b001c576b6d4f7mr2813402plb.36.1696441376967;
        Wed, 04 Oct 2023 10:42:56 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:95a1:7b5c:a766:5db1])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001b9c960ffeasm3993160plh.47.2023.10.04.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:42:56 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:42:53 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] soc: renesas: make ARCH_R9A07G043 (riscv version) depend
 on NONPORTABLE
Message-ID: <ZR2kHfUXmQ9jwQC9@x1>
References: <20231004150856.2540-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004150856.2540-1-jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:08:56PM +0800, Jisheng Zhang wrote:
> Drew found "CONFIG_DMA_GLOBAL_POOL=y causes ADMA buffer alloc to fail"
> the log looks like:
> [    3.741083] mmc0: Unable to allocate ADMA buffers - falling back to standard DMA
> 
> The logic is: generic riscv defconfig selects ARCH_RENESAS then
> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
> non-dma-coherent riscv platforms have a dma global pool, this assumption
> seems not correct. And I believe DMA_GLOBAL_POOL should not be
> selected by ARCH_SOCFAMILIY, instead, only ARCH under some specific
> conditions can select it globaly, for example NOMMU ARM and so on,
> because it's designed for special cases such as "nommu cases where
> non-cacheable memory lives in a fixed place in the physical address
> map" as pointed out by Robin.
> 
> Fix the issue by making ARCH_R9A07G043 (riscv version) depend on
> NONPORTABLE, thus generic defconfig won't select ARCH_R9A07G043 by
> default. And even for random config case, there will be less debug
> effort once we see NONPORTABLE is enabled.
> 
> Reported-by: Drew Fustini <dfustini@baylibre.com>
> Closes: https://lore.kernel.org/linux-riscv/ZRuamJuShOnvP1pr@x1/
> Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/soc/renesas/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 5a75ab64d1ed..12040ce116a5 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -333,6 +333,7 @@ if RISCV
>  
>  config ARCH_R9A07G043
>  	bool "RISC-V Platform support for RZ/Five"
> +	depends on NONPORTABLE
>  	select ARCH_RZG2L
>  	select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
>  	select DMA_GLOBAL_POOL
> -- 
> 2.40.1
> 

Tested-by: Drew Fustini <dfustini@baylibre.com>

With this patch, I can use the defconfig and sdhci-of-dwcmshc driver is
able to use ADMA mode without needing to add shared-dma-pool to dts:

# zcat /proc/config.gz |grep DMA_GLOBAL_POOL
# dtc -I fs /sys/firmware/devicetree/base/ 2>/dev/null |grep pool
# dmesg |grep ADMA
[    3.910269] mmc0: SDHCI controller on ffe7080000.mmc [ffe7080000.mmc] using ADMA 64-bit


Thanks,
Drew
