Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4D77E1D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjKFJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:18:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52C2BDB;
        Mon,  6 Nov 2023 01:18:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB531FB;
        Mon,  6 Nov 2023 01:19:14 -0800 (PST)
Received: from [10.57.1.27] (unknown [10.57.1.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB433F6C4;
        Mon,  6 Nov 2023 01:18:27 -0800 (PST)
Message-ID: <bae19559-0aea-422f-931f-b51aa8f3f5a3@arm.com>
Date:   Mon, 6 Nov 2023 09:19:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v4 8/8] thermal: exynos: use set_trips
To:     m.majewski2@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <2c4b6c1b-b9e7-42b2-8f7b-446ebe9d15ac@arm.com>
 <20231025133027.524152-1-m.majewski2@samsung.com>
 <20231025133027.524152-9-m.majewski2@samsung.com>
 <CGME20231025133100eucas1p14e6de58e52560d165bdb8b809e406278@eucms1p4>
 <20231102103507eucms1p4aea91982ebcc4a9a6314d9c4e03050fc@eucms1p4>
Content-Language: en-US
In-Reply-To: <20231102103507eucms1p4aea91982ebcc4a9a6314d9c4e03050fc@eucms1p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/23 10:35, Mateusz Majewski wrote:
> Hi,
> 
>>> +        th &= ~(0xff << 0);
>>> +        th |= temp_to_code(data, temp) << 0;
>>   
>> This 2-line pattern repeats a few times. It looks like a nice cadidate
>> for an inline function which can abstract that. Something like:
>>   
>> val = update_temp_value(data, temp, threshold, LOW_TEMP_SHIFT)
>>   
>> Assisted with the macros {LOW|HIGH|CRIT}_TEMP_SHIFT, the code
>> would look less convoluted IMO.
>> (The old code with the multiplication for the shift value wasn't
>> cleaner nor faster).
> 
> What would you think about something like this?
> 
> static void exynos_tmu_update_temp(struct exynos_tmu_data *data, int reg_off,
>                                     int bit_off, u8 temp)
> {
>          u32 th;
> 
>          th = readl(data->base + reg_off);
>          th &= ~(0xff << bit_off);
>          th |= temp_to_code(data, temp) << bit_off;
>          writel(th, data->base + reg_off);
> }
> 
> And then, it would be used like this:
> 
> static void exynos4412_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
> {
>          exynos_tmu_update_temp(data, EXYNOS_THD_TEMP_RISE, 24, temp);
>          exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
>                                EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
> }

Yes, this looks good.

> 
> Granted it's not as clear as if we had some macro like CRIT_TEMP_SHIFT, but
> we would need more than one variant anyway, as Exynos 5433 uses different
> values of reg_off, and the new function looks short and inviting IMHO.

Fair enough.

> 
>>> -static void exynos7_tmu_set_trip_temp(struct exynos_tmu_data *data,
>>> -                                      int trip, u8 temp)
>>> +static void exynos7_tmu_update_temp(struct exynos_tmu_data *data, u8 temp,
>>> +                                    int idx, bool rise)
>>>     {
>>>             unsigned int reg_off, bit_off;
>>>             u32 th;
>>> +        void __iomem *reg;
>>>     
>>> -        reg_off = ((7 - trip) / 2) * 4;
>>> -        bit_off = ((8 - trip) % 2);
>>> +        reg_off = ((7 - idx) / 2) * 4;
>>   
>> Why can't we just have a set of defined register macros and pick one
>> in some small function?
>> A lot of operations here, also some assumption.
>>   
>>> +        bit_off = ((8 - idx) % 2);
>>   
>> So this can only be 0 or 1 and than it's used for the shift
>> multiplication. Also I don't know the history of older code and
>> if it was missed after some cleaning, but 'idx % 2' gives
>> equal values but w/o subtraction.
>>   
>> BTW, the code assumes the 'idx' values are under control somewhere else.
>> Is that because the DT make sure in the schema that the range cannot be
>> too big?
>> What are the possible values for 'idx'?
> 
> In the old code, the values of trip (which is the same thing, I will
> change the name back from idx) were limited by the value of data->ntrip,
> which was always 8 (value is per SoC). In the new code, there are only three
> variants:
> 
> static void exynos7_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
> {
>          exynos7_tmu_update_temp(data, temp, 0, false);
> }
> 
> static void exynos7_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
> {
>          exynos7_tmu_update_temp(data, temp, 1, true);
> }
> 
> static void exynos7_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
> {
>          /*
>           * Like Exynos 4210, Exynos 7 does not seem to support critical temperature
>           * handling in hardware. Again, we still set a separate interrupt for it.
>           */
>          exynos7_tmu_update_temp(data, temp, 7, true);
> }
> 
> To be fair, considering the values are constant like this, I should probably
> just do the calculations myself and then in code just call exynos_tmu_update_temp
> (from above) and exynos_tmu_update_bit, like on all other SoCs. I guess I were
> a bit too scared to touch Exynos 7 code...

Yes, anything that can be pre-calculated with nice comment, would be
more desired. I would suggest to not be afraid about touching that
Exynos 7 code.

> 
>>> -        if (on) {
>>> -                for (i = 0; i < data->ntrip; i++) {
>>> -                        if (thermal_zone_get_trip(tz, i, &trip))
>>> -                                continue;
>>> -
>>> -                        interrupt_en |=
>>> -                                (1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
>>> -                }
>>> -
>>> -                if (data->soc != SOC_ARCH_EXYNOS4210)
>>> -                        interrupt_en |=
>>> -                                interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
>>> -
>>> +        if (on)
>>>                     con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
>>> -        } else {
>>> +        else
>>>                     con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
>>   
>> Please also consider the BIT() helper here and above...
> 
> Will do, but should I do this in a separate patch in these cases? I don't touch
> the con lines otherwise, and this patch is already humongous.

That would definitely deserve an extra patch to address it. Please add
to the patch set.

Regards,
Lukasz
