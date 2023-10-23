Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD37D3752
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjJWM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjJWM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:58:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DAE9C4;
        Mon, 23 Oct 2023 05:58:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02FED2F4;
        Mon, 23 Oct 2023 05:59:00 -0700 (PDT)
Received: from [10.57.82.113] (unknown [10.57.82.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5A03F762;
        Mon, 23 Oct 2023 05:58:16 -0700 (PDT)
Message-ID: <91b3ff5a-cfdf-4bba-806e-093a90746d86@arm.com>
Date:   Mon, 23 Oct 2023 13:59:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] thermal: exynos: split initialization of TMU and
 the thermal zone
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231003111638.241542-1-m.majewski2@samsung.com>
 <CGME20231003111713eucas1p27fcc64df0091b6097461f28b05bf772a@eucas1p2.samsung.com>
 <20231003111638.241542-8-m.majewski2@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231003111638.241542-8-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

On 10/3/23 12:16, Mateusz Majewski wrote:
> This will be needed in the future, as the thermal zone subsystem might
> call our callbacks right after devm_thermal_of_zone_register. Currently
> we just make get_temp return EAGAIN in such case, but this will not be
> possible with state-modifying callbacks, for instance set_trips.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
> v1 -> v2: We take clocks into account; exynos_tmu_initialize needs both
>    clocks, as tmu_initialize might use the base_second registers. However,
>    exynos_thermal_zone_configure only needs clk.
> 
>   drivers/thermal/samsung/exynos_tmu.c | 104 +++++++++++++++------------
>   1 file changed, 60 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 7138e001fa5a..343e27c61528 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -251,25 +251,8 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
>   static int exynos_tmu_initialize(struct platform_device *pdev)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> -	struct thermal_zone_device *tzd = data->tzd;
> -	int num_trips = thermal_zone_get_num_trips(tzd);
>   	unsigned int status;
> -	int ret = 0, temp;
> -
> -	ret = thermal_zone_get_crit_temp(tzd, &temp);
> -	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
> -		dev_err(&pdev->dev,
> -			"No CRITICAL trip point defined in device tree!\n");
> -		goto out;
> -	}
> -
> -	if (num_trips > data->ntrip) {
> -		dev_info(&pdev->dev,
> -			 "More trip points than supported by this TMU.\n");
> -		dev_info(&pdev->dev,
> -			 "%d trip points should be configured in polling mode.\n",
> -			 num_trips - data->ntrip);
> -	}
> +	int ret = 0;
>   
>   	mutex_lock(&data->lock);
>   	clk_enable(data->clk);
> @@ -280,32 +263,63 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>   	if (!status) {
>   		ret = -EBUSY;
>   	} else {
> -		int i, ntrips =
> -			min_t(int, num_trips, data->ntrip);
> -
>   		data->tmu_initialize(pdev);
> -
> -		/* Write temperature code for rising and falling threshold */
> -		for (i = 0; i < ntrips; i++) {
> -
> -			struct thermal_trip trip;
> -
> -			ret = thermal_zone_get_trip(tzd, i, &trip);
> -			if (ret)
> -				goto err;
> -
> -			data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
> -			data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
> -						trip.hysteresis / MCELSIUS);
> -		}
> -
>   		data->tmu_clear_irqs(data);
>   	}
> +
> +	mutex_unlock(&data->lock);
> +	clk_disable(data->clk);
> +	if (!IS_ERR(data->clk_sec))
> +		clk_disable(data->clk_sec);

In all other places the clock is strictly protected inside the critical
section, but not here. In this code in theory on SMP (especially with
big.LITTLE system with different speeds of CPUs) this could lead to
disabling the clocks just after other CPU acquired the mutex and enabled
them (in order to use the HW regs).

Please put those two clocks before the mutex_unlock() and in the
reverse order.

Regards,
Lukasz
