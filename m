Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23617EAE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjKNKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjKNKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:31:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6947E121;
        Tue, 14 Nov 2023 02:31:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593DBC15;
        Tue, 14 Nov 2023 02:32:24 -0800 (PST)
Received: from [10.57.3.30] (unknown [10.57.3.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63DDC3F641;
        Tue, 14 Nov 2023 02:31:37 -0800 (PST)
Message-ID: <93c5b287-a643-4e95-a38b-ed301d5cbcb2@arm.com>
Date:   Tue, 14 Nov 2023 10:32:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Various Exynos targets never return to no cooling
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20231113130451eucas1p293985c1bee8dc71b9c78a013663ce8e6@eucas1p2.samsung.com>
 <20231113130435.500353-1-m.majewski2@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231113130435.500353-1-m.majewski2@samsung.com>
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

On 11/13/23 13:04, Mateusz Majewski wrote:
> Hi,
> 
> While working on some fixes on the Exynos thermal driver, I have found that some
> of the Exynos-based boards will never return to no cooling. That is, after
> heating the board a bit and letting it cool, we see in the sysfs output similar
> to this:
> 
> root@target:~# cat /sys/class/thermal/thermal_zone*/temp
> 30000
> 29000
> 32000
> 31000
> 30000
> root@target:~# cat /sys/class/thermal/cooling_device*/cur_state
> 1
> 0
> 0
> 0

You can also use this command:
$ grep . /sys/class/thermal/cooling_device*/cur_state

That would print also the names.

> 
> This is on the Odroid XU4 board, where the lowest trip point is 50 deg. C.
> Similar behavior happens on some other boards, for example TM2E. The issue
> happens when the stepwise governor is being used and I have not tested the
> behavior of the other governors.

You won't be able easily test IPA on odroidxu4, but if you like ping me
offline.

IPA won't work with this current DT thermal, so there is no issue.
Also, IPA works in polling mode only, more about why you can find below.

> 
> I have attempted to fix this myself, but the issue seems somewhat complex and
> over my level of understanding. I did some debugging, and here is what I think
> is happening:
> 
> 1. Since there is no temperature polling enabled on the mentioned boards, the
>     governor will only be called when a trip point is being passed.
> 2. The board heats up and a couple trip points get passed through. Each time,
>     the governor is called for each trip point.
> 3. For the lowest thermal instance, it will find out that the temperature is
>     higher than the lowest trip point (i.e. throttle is true), and that the trend
>     is THERMAL_TREND_RAISING. Therefore, it will attempt to increase the target
>     state each time and the state will be set to the higher limit.
> 4. Let's now say that the temperature starts falling, which means that the trip
>     points get passed from the other side. Again, the governor will be called for
>     each trip point.
> 5. For the lowest thermal instance, the trend will be THERMAL_TREND_DROPPING. The
>     temperature will be higher than the lowest trip point all but one time (i.e.
>     throttle will be true). This will mean that in these cases, nothing will
>     happen and the state will remain at the higher limit.

Tricky corner case, but possible for your interrupt only mode. The way
how step_wise is designed with this activation/deactivation of the
passive mode linked to the cooling state returned values is confusing
IMO.

> 6. Finally, when the lowest trip point is passed and the governor is called for
>     its thermal instance, the trend will still be THERMAL_TREND_DROPPING and the
>     temperature will be lower than the trip point (i.e. throttle will be false).
>     Therefore, the governor will reduce the state, but it is unlikely that this
>     will result in deactivation of the thermal instance, since the state has been
>     at the higher limit up until this point.

That's possible. That's why I would separate that control mode, so this
corner case would not happen. That governor unfortunately has quite a
lot of legacy platforms with polling only mode.

> 7. Now the governor will never be called anymore, and the state will never
>     change from this point.
> 
> I have found two workarounds, but neither seem satisfactory:
> 
> 1. The issue doesn't appear when at least two lowest trip points have their
>     lower state limit equal to the higher state limit. For instance, for TM2E,
>     the following change is enough for the issue to not appear:
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> index 81b72393dd0d..145c4c80893a 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> @@ -55,14 +55,14 @@ cooling-maps {
>               map0 {
>                   /* Set maximum frequency as 1800MHz  */
>                   trip = <&atlas0_alert_0>;
> -                cooling-device = <&cpu4 1 2>, <&cpu5 1 2>,
> -                         <&cpu6 1 2>, <&cpu7 1 2>;
> +                cooling-device = <&cpu4 1 1>, <&cpu5 1 1>,
> +                         <&cpu6 1 1>, <&cpu7 1 1>;
>               };
>               map1 {
>                   /* Set maximum frequency as 1700MHz  */
>                   trip = <&atlas0_alert_1>;
> -                cooling-device = <&cpu4 2 3>, <&cpu5 2 3>,
> -                         <&cpu6 2 3>, <&cpu7 2 3>;
> +                cooling-device = <&cpu4 2 2>, <&cpu5 2 2>,
> +                         <&cpu6 2 2>, <&cpu7 2 2>;
>               };
>               map2 {
>                   /* Set maximum frequency as 1600MHz  */
> @@ -229,14 +229,14 @@ cooling-maps {
>               map0 {
>                   /* Set maximum frequency as 1200MHz  */
>                   trip = <&apollo_alert_2>;
> -                cooling-device = <&cpu0 1 2>, <&cpu1 1 2>,
> -                         <&cpu2 1 2>, <&cpu3 1 2>;
> +                cooling-device = <&cpu0 1 1>, <&cpu1 1 1>,
> +                         <&cpu2 1 1>, <&cpu3 1 1>;
>               };
>               map1 {
>                   /* Set maximum frequency as 1100MHz  */
>                   trip = <&apollo_alert_3>;
> -                cooling-device = <&cpu0 2 3>, <&cpu1 2 3>,
> -                         <&cpu2 2 3>, <&cpu3 2 3>;
> +                cooling-device = <&cpu0 2 2>, <&cpu1 2 2>,
> +                         <&cpu2 2 2>, <&cpu3 2 2>;
>               };
>               map2 {
>                   /* Set maximum frequency as 1000MHz  */
> 
>     Two trip points need to change and not only one, since the calculation in the
>     governor is based on the maximum of all states and not only the state of a
>     single instance. It's not clear if that would be enough in all cases, but
>     this feels hacky anyway. Though since we only give the governor information
>     when the trip point is passed, it does make some limited sense to make it
>     simply set the state to a specific value instead of making decisions.

Yes, this is problematic - playing with the limits for scope in the DT
+ step_wise governor + only interrupt mode.

Also, I never like this approach, since we are dealing with dynamic
system (nonlinear) and control with static approach is not recommended.
BTW, IPA was born to introduce dynamic control alg.

> 2. The issue also disappears when polling is enabled, since this means that the
>     governor is called periodically. However, it would be great to not have to do
>     so and keep using only interrupts, since we already have them in our SoC.

There are pros and cons with the polling approach. The thermal and
temperature is a dynamic system and observability is important. The
interrupt mode limits the observability, that's what you've shown.

I understand your requirement for the interrupts only mode, but
maybe till the moment there is no fix upstream, you can enable
it as well?

> 
> It seems that in the past, there has been an attempt to handle this case
> differently: https://lore.kernel.org/all/1352348786-24255-1-git-send-email-amit.kachhap@linaro.org/
> However it seems that the attempt has never been completed, and the remains
> have been removed: https://lore.kernel.org/all/20220629151012.3115773-2-daniel.lezcano@linaro.org/
> 
> There also might be a race condition possible here, as it might be the case
> that after the interrupt, when the thermal framework calls get_temp, the value
> will already change to a value that would not trigger the trip point. This
> could be problematic when the temperature is raising, as then the governor will
> essentially ignore that trip point (trend will be RAISING, but throttle will be
> false, so nothing will happen). It is less problematic when the temperature is
> falling, as the temperature will be much lower than the trip point due to
> hysteresis. However, for the Exynos 5433 SoC, hysteresis is unfortunately set
> to 1 deg. C and the temperature values are also rounded to 1 deg. C. This means
> that the race condition might also be possible in this direction on this SoC. I
> have once managed to get the state stuck at 2 instead of the usual 1 on TM2E. I
> have not investigated that further, but it seems that this race condition is a
> good explanation of this behavior.

Interesting. That's really tough situation in that platform. AFAICS the
code_to_temp() cannot do much, that rounding happens in the HW.

In such situation that you've described: temp value can 'oscillate'
very fast around the value point (next gets rounded in HW) in the
meantime the run of the code is progressing. I would not relay on
interrupt only mode in this case.

The value stuck at 2 worries me because even if you change those
values in the DT as above, the race condition could happen and leave
you with state stuck at 1.

Escaping the control algorithm while going down is less dangerous,
but based on the code AFAICS it might be also in theory possible
while going up with the temperature. Very unlikely for the 2nd
trip point, because the temp would be higher than 1st trip. That would
set the throttling to true for 1st trip (because we loop over all
possible trip points). I'm worried about last trip point, because
it could escape the control alg there. Furthermore, since those
cooling state values are limited-space and hard-coded for the last
trip points, the temp can reach hot/critical trip point and shut
down the device (fortunately it's not handled by the governor
interpretation code, but fwk and it would work fine).
So please make sure you have hot/critical trip point as last one,
if you already don't have that.


> 
> I feel very incompetent to attempt to resolve these issues, as I have only read
> the thermal framework code for a bit. What do you think should be done here?
> 

Therefore, IMO this deserves a fix in step_wise governor code. It has to
be re-designed how it interprets trip point that has checked vs.
the temperature comparisons. Also, this confusing passive mode
handled with the cooling state values comparisons (not ideal)...

Regards,
Lukasz

