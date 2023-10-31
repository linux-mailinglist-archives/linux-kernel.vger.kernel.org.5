Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4A7DC971
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjJaJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343853AbjJaJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:25:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E81EB7;
        Tue, 31 Oct 2023 02:25:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBDF3C15;
        Tue, 31 Oct 2023 02:26:11 -0700 (PDT)
Received: from [10.57.4.28] (unknown [10.57.4.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C053E3F67D;
        Tue, 31 Oct 2023 02:25:27 -0700 (PDT)
Message-ID: <2c4b6c1b-b9e7-42b2-8f7b-446ebe9d15ac@arm.com>
Date:   Tue, 31 Oct 2023 09:26:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] thermal: exynos: use set_trips
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org
References: <20231025133027.524152-1-m.majewski2@samsung.com>
 <CGME20231025133100eucas1p14e6de58e52560d165bdb8b809e406278@eucas1p1.samsung.com>
 <20231025133027.524152-9-m.majewski2@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231025133027.524152-9-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 14:30, Mateusz Majewski wrote:
> Currently, each trip point defined in the device tree corresponds to a
> single hardware interrupt. This commit instead switches to using two
> hardware interrupts, whose values are set dynamically using the
> set_trips callback. Additionally, the critical temperature threshold is
> handled specifically.
> 

[snip]

>   
> -static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
> -					 int trip_id, u8 temp)
> +static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
> +				  int bit_off, bool enable)
>   {
> -	temp = temp_to_code(data, temp);
> -	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
> +	u32 interrupt_en;
> +
> +	interrupt_en = readl(data->base + reg_off);
> +	if (enable)
> +		interrupt_en |= 1 << bit_off;
> +	else
> +		interrupt_en &= ~(1 << bit_off);

Why not to use dedicated stuff for this?
val |= BIT(x)
val &= ~BIT(x)
You can find plenty of example in the kernel

> +	writel(interrupt_en, data->base + reg_off);
>   }
>   

[snip]

> -static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
> -					 int trip, u8 temp)
> -{
> -	u32 th, con;
> -
> -	th = readl(data->base + EXYNOS_THD_TEMP_RISE);
> -	th &= ~(0xff << 8 * trip);
> -	th |= temp_to_code(data, temp) << 8 * trip;
> -	writel(th, data->base + EXYNOS_THD_TEMP_RISE);
> -
> -	if (trip == 3) {
> -		con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
> -		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
> -		writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> -	}
> -}
> -
> -static void exynos4412_tmu_set_trip_hyst(struct exynos_tmu_data *data,
> -					 int trip, u8 temp, u8 hyst)
> +static void exynos4412_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
>   {
>   	u32 th;
>   
>   	th = readl(data->base + EXYNOS_THD_TEMP_FALL);
> -	th &= ~(0xff << 8 * trip);
> -	if (hyst)
> -		th |= temp_to_code(data, temp - hyst) << 8 * trip;
> +	th &= ~(0xff << 0);
> +	th |= temp_to_code(data, temp) << 0;

This 2-line pattern repeats a few times. It looks like a nice cadidate
for an inline function which can abstract that. Something like:

val = update_temp_value(data, temp, threshold, LOW_TEMP_SHIFT)

Assisted with the macros {LOW|HIGH|CRIT}_TEMP_SHIFT, the code
would look less convoluted IMO.
(The old code with the multiplication for the shift value wasn't
cleaner nor faster).

>   	writel(th, data->base + EXYNOS_THD_TEMP_FALL);
> +
> +	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
> +			      EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
> +}

[snip]

> -static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
> -				      int trip, u8 temp)
> +static void exynos7_tmu_update_temp(struct exynos_tmu_data *data, u8 temp,
> +				    int idx, bool rise)
>   {
>   	unsigned int reg_off, bit_off;
>   	u32 th;
> +	void __iomem *reg;
>   
> -	reg_off = ((7 - trip) / 2) * 4;
> -	bit_off = ((8 - trip) % 2);
> +	reg_off = ((7 - idx) / 2) * 4;

Why can't we just have a set of defined register macros and pick one
in some small function?
A lot of operations here, also some assumption.

> +	bit_off = ((8 - idx) % 2);

So this can only be 0 or 1 and than it's used for the shift
multiplication. Also I don't know the history of older code and
if it was missed after some cleaning, but 'idx % 2' gives
equal values but w/o subtraction.

BTW, the code assumes the 'idx' values are under control somewhere else.
Is that because the DT make sure in the schema that the range cannot be
too big?
What are the possible values for 'idx'?

>   
> -	th = readl(data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
> +	reg = data->base +
> +	      (rise ? EXYNOS7_THD_TEMP_RISE7_6 : EXYNOS7_THD_TEMP_FALL7_6) +
> +	      reg_off;
> +	th = readl(reg);
>   	th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
>   	th |= temp_to_code(data, temp) << (16 * bit_off);

Can you simplify and abstract those bit_off usage and use some
macros and less math operations?

> -	writel(th, data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
> +	writel(th, reg);
> +
> +	exynos_tmu_update_bit(data, EXYNOS5433_TMU_REG_INTEN,
> +			      (rise ? EXYNOS7_TMU_INTEN_RISE0_SHIFT :
> +				      EXYNOS_TMU_INTEN_FALL0_SHIFT) +
> +				      idx,
> +			      true);
>   }

[snip]

>   
> -	if (on) {
> -		for (i = 0; i < data->ntrip; i++) {
> -			if (thermal_zone_get_trip(tz, i, &trip))
> -				continue;
> -
> -			interrupt_en |=
> -				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
> -		}
> -
> -		if (data->soc != SOC_ARCH_EXYNOS4210)
> -			interrupt_en |=
> -				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
> -
> +	if (on)
>   		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> -	} else {
> +	else
>   		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);

Please also consider the BIT() helper here and above...

> -	}
>   
> -	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
>   	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
>   }
>   
>   static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
>   {
>   	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> -	struct thermal_zone_device *tz = data->tzd;
> -	struct thermal_trip trip;
> -	unsigned int con, interrupt_en = 0, pd_det_en, i;
> +	unsigned int con, pd_det_en;
>   
>   	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
>   
> -	if (on) {
> -		for (i = 0; i < data->ntrip; i++) {
> -			if (thermal_zone_get_trip(tz, i, &trip))
> -				continue;
> -
> -			interrupt_en |=
> -				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
> -		}
> -
> -		interrupt_en |=
> -			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
> -
> +	if (on)
>   		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> -	} else
> +	else
>   		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);

... and here. Basically in all places where it's possible.

Regards,
Lukasz
