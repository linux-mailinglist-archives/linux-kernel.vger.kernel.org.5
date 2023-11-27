Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27B7F9D49
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjK0KQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjK0KQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:16:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2668C0;
        Mon, 27 Nov 2023 02:16:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD4422F4;
        Mon, 27 Nov 2023 02:17:39 -0800 (PST)
Received: from [10.57.4.90] (unknown [10.57.4.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B068D3F73F;
        Mon, 27 Nov 2023 02:16:50 -0800 (PST)
Message-ID: <573ec775-c1f0-4a09-afe4-83793fb11f3c@arm.com>
Date:   Mon, 27 Nov 2023 10:17:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to
 rk3399 GPU
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, conor+dt@kernel.org, daniel.lezcano@linaro.org
References: <20231127081511.1911706-1-lukasz.luba@arm.com>
 <CAGXv+5EgDk2B_FYo9hNiLVogq+mww1j140W4hsDhywExzgpf2g@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAGXv+5EgDk2B_FYo9hNiLVogq+mww1j140W4hsDhywExzgpf2g@mail.gmail.com>
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



On 11/27/23 10:02, Chen-Yu Tsai wrote:
> On Mon, Nov 27, 2023 at 4:14 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Add dynamic-power-coefficient to the GPU node. That will create Energy
>> Model for the GPU based on the coefficient and OPP table information.
>> It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
>> In similar way the Energy Model for CPUs in rk3399 is created, so both
>> are aligned in power scale. The maximum power used from this coefficient
>> is 1.5W at 600MHz.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 9da0b6d77c8d..87cfdf570b19 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -2113,6 +2113,7 @@ gpu: gpu@ff9a0000 {
>>                  interrupt-names = "job", "mmu", "gpu";
>>                  clocks = <&cru ACLK_GPU>;
>>                  #cooling-cells = <2>;
>> +               dynamic-power-coefficient = <2640>;
> 
> For reference, in the ChromeOS downstrean v5.10 kernel we have:
> 
> gpu_power_model: power_model {
>          compatible = "arm,mali-simple-power-model";
>          static-coefficient = <411522>;
>          dynamic-coefficient = <977>;
>          ts = <32000 4700 (-80) 2>;
>          thermal-zone = "gpu";
> };
> 
> This is for the Mali kbase.

That's downstream driver for downstream IPA thermal governor, which is
different. As you can see there, there is a split of the total power
to 'static power' and 'dynamic power' and thus those 2 coefficients:
'static-coefficient' and 'dynamic-coefficient'. There is also
polynomial for the exponential curve approximating temperature impact
to the increasing leakage (static power).

This is totally not upstream code and quite complex to derive thus
fly upstream. Therefore, in upstream we have very simple power
model right now, but it will be possible to update it at runtime
when the leakage is increased. I hope the new v5 version that
I'm going to send, will get into mainline soon [1].

Regards,
Lukasz

[1] 
https://lore.kernel.org/lkml/20230925081139.1305766-1-lukasz.luba@arm.com/
