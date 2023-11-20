Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B57F1733
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjKTPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjKTPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:23:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B35EFBE;
        Mon, 20 Nov 2023 07:23:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC73FEC;
        Mon, 20 Nov 2023 07:24:40 -0800 (PST)
Received: from [10.57.4.99] (unknown [10.57.4.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8863F6C4;
        Mon, 20 Nov 2023 07:23:51 -0800 (PST)
Message-ID: <96565d08-8d6b-4a37-8a83-90bdd53ba89a@arm.com>
Date:   Mon, 20 Nov 2023 15:24:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] thermal: exynos: use BIT wherever possible
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20231120145049.310509-1-m.majewski2@samsung.com>
 <CGME20231120145107eucas1p13ed9ea8772346c404d2d7f47d4c80f5a@eucas1p1.samsung.com>
 <20231120145049.310509-9-m.majewski2@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231120145049.310509-9-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

On 11/20/23 14:50, Mateusz Majewski wrote:
> The original driver did not use that macro and it allows us to make our
> intentions slightly clearer.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>   drivers/thermal/samsung/exynos_tmu.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 

[snip]

> @@ -590,15 +590,15 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
>   				continue;
>   
>   			interrupt_en |=
> -				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
> +				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
>   		}
>   
>   		interrupt_en |=
>   			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
>   
> -		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
>   	} else

Minor issue: the if-else segment here. When the 'if' has the
brackets, then the 'else' should have them as well,
even if there is only a single line under 'else'.
It's not strictly to this patch, but you can address that
later somewhere (just saw it here).

> -		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
>   
>   	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
>   
> @@ -622,17 +622,17 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
>   				continue;
>   
>   			interrupt_en |=
> -				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
> +				BIT(EXYNOS7_TMU_INTEN_RISE0_SHIFT + i);
>   		}
>   
>   		interrupt_en |=
>   			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
>   
> -		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> -		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
> +		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
> +		con |= BIT(EXYNOS7_PD_DET_EN_SHIFT);
>   	} else {
> -		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> -		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
> +		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
> +		con &= ~BIT(EXYNOS7_PD_DET_EN_SHIFT);
>   	}
>   
>   	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);


The patch LGTM,

Reviewed-by Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
