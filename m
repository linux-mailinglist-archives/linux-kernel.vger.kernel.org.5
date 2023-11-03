Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF67E05A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbjKCPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjKCPfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:35:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D9E3123;
        Fri,  3 Nov 2023 08:35:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 878812F4;
        Fri,  3 Nov 2023 08:35:44 -0700 (PDT)
Received: from [10.57.81.32] (unknown [10.57.81.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F56B3F64C;
        Fri,  3 Nov 2023 08:34:56 -0700 (PDT)
Message-ID: <ffb08cc2-705a-468e-b6d2-9ce591c08ab4@arm.com>
Date:   Fri, 3 Nov 2023 15:34:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Content-Language: en-GB
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
 <20231102152033.5511-3-duje.mihanovic@skole.hr>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231102152033.5511-3-duje.mihanovic@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-02 3:20 pm, Duje Mihanović wrote:
> Add ARCH_MMP configuration option for Marvell PXA1908 SoC.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>   arch/arm64/Kconfig.platforms | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 6069120199bb..b417cae42c84 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -89,6 +89,17 @@ config ARCH_BERLIN
>   	help
>   	  This enables support for Marvell Berlin SoC Family
>   
> +config ARCH_MMP
> +	bool "Marvell MMP SoC Family"
> +	select ARM_GIC
> +	select ARM_ARCH_TIMER
> +	select ARM_SMMU

NAK, not only is selecting user-visible symbols generally frowned upon, 
and ignoring their dependencies even worse, but for a multiplatform 
kernel the user may well want this to be a module.

If having the SMMU driver built-in is somehow fundamentally required for 
this platform to boot, that would represent much bigger problems.

Thanks,
Robin.

> +	select MMP_PDMA
> +	select PINCTRL_SINGLE
> +	help
> +	  This enables support for Marvell MMP SoC family, currently
> +	  supporting PXA1908 aka IAP140.
> +
>   config ARCH_BITMAIN
>   	bool "Bitmain SoC Platforms"
>   	help
