Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA537B838A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjJDP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjJDP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:27:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3E2293;
        Wed,  4 Oct 2023 08:27:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 146EDC15;
        Wed,  4 Oct 2023 08:28:32 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 134A63F762;
        Wed,  4 Oct 2023 08:27:51 -0700 (PDT)
Message-ID: <c4438f24-fe87-bf22-183b-f53376e950db@arm.com>
Date:   Wed, 4 Oct 2023 16:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] soc: renesas: make ARCH_R9A07G043 (riscv version) depend
 on NONPORTABLE
Content-Language: en-GB
To:     Jisheng Zhang <jszhang@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Drew Fustini <dfustini@baylibre.com>
References: <20231004150856.2540-1-jszhang@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231004150856.2540-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 4:08 pm, Jisheng Zhang wrote:
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

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Reported-by: Drew Fustini <dfustini@baylibre.com>
> Closes: https://lore.kernel.org/linux-riscv/ZRuamJuShOnvP1pr@x1/
> Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/soc/renesas/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 5a75ab64d1ed..12040ce116a5 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -333,6 +333,7 @@ if RISCV
>   
>   config ARCH_R9A07G043
>   	bool "RISC-V Platform support for RZ/Five"
> +	depends on NONPORTABLE
>   	select ARCH_RZG2L
>   	select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
>   	select DMA_GLOBAL_POOL
