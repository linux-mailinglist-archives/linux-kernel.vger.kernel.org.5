Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FEA76FA44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjHDGkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjHDGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:39:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D28525A;
        Thu,  3 Aug 2023 23:39:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 731F666071B4;
        Fri,  4 Aug 2023 07:39:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691131163;
        bh=IpOr9pdyxS7HsU+ktjaQ4KJw4Ht++OfuZ4la3Xj62Co=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GpkoezfJwAo9ULIN3eIyaMLcNz+NZU763pz33LeEcEZ0jpK8bt+Uer8CrjEZI7UfJ
         6+HlbHyaXqjGoNhJNtf98lIHNuH/CjAaoiG4k7x2yiXXPWFqKIO58JRXWPvK90r8Zi
         1ccoITx1ZOhlrN0bReJT15Hjc1JtTIamfoIWtbYsVv5gJx8j49WwIgsKsyA29iyEmD
         w7xSCnsKl5Ju3v7MomI3vey/d+Keo6q9aq4UpxM5dP/JuWbuS13NFab4SJXbS6xyGh
         +fi3z6UZjkl61Trr8NSTqWB46G8thAqw1T53McfocUbGZqVYrbTCWabmEkFuXe5vY3
         SzsBFdDgY22Mw==
Message-ID: <4762b4cc-f7bf-d4cb-a53b-ba2cfb5700fc@collabora.com>
Date:   Fri, 4 Aug 2023 08:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/9] mfd: mt6397: Split MediaTek MT6366 PMIC out of MT6358
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230803074249.3065586-1-wenst@chromium.org>
 <20230803074249.3065586-4-wenst@chromium.org>
 <aa8f232f-701a-5b4c-eda8-89fc0e6fe5a8@collabora.com>
 <CAGXv+5EAR9Q5gGzkw=5UEEMOHbp56oKD5m_FyiHfZ3em8QwVAQ@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EAR9Q5gGzkw=5UEEMOHbp56oKD5m_FyiHfZ3em8QwVAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/08/23 05:47, Chen-Yu Tsai ha scritto:
> On Thu, Aug 3, 2023 at 5:01 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 03/08/23 09:42, Chen-Yu Tsai ha scritto:
>>> The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
>>> a different set of regulators. Specifically, it lacks the camera related
>>> VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.
>>>
>>> Add a separate compatible for the MT6366 PMIC. The regulator cell for
>>> this new entry uses a new compatible string matching MT6366.
>>>
>>> Fixes: c47383f84909 ("mfd: Add support for the MediaTek MT6366 PMIC")
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> I agree in that the LDOs are a bit different, but that's handled by the
>> mt6358-regulator driver regardless of the actual devicetree compatible,
>> as that's selected through a chip_id check.
>>
>> Finally, looking at the driver implementation itself, the addition of a
>> specific mt6366 compatible here seems redundant, because the actual HW is
>>    - Handled by drivers, but
>>    - Described by bindings
>>
>> Any other opinions on this?
> 
> Well, on the bindings side, we can't have MT6366 fall back to MT6358,
> neither for the whole PMIC nor just for the regulators. For the latter
> it's because neither is a subset of the other, which a) makes them not
> fallback compatible as required by the spirit of fallback compatibles,
> and b) cannot be described with a fallback compatible, as the fallback
> one will have properties/nodes that are not valid for the other, and
> vice versa.
> 
> Without a fallback compatible to lean in for the regulator driver, we
> will need to split out the compatible at the mfd level as well. AFAIU
> the mfd core matches mfd-cells based on the compatible strings it is
> given in the driver.
> 

Hmm... you might actually be right on this.
But! I just want to be sure that we're doing things the right way.. and
I'd like to get an opinion from a bindings person, as I think that's the
most appropriate thing that can be done.

Krzysztof, please, can you check this one?

Thanks!
Angelo

> ChenYu
> 
>> Regards,
>> Angelo
>>
>>> ---
>>>    drivers/mfd/mt6397-core.c | 31 +++++++++++++++++++++++++++++++
>>>    1 file changed, 31 insertions(+)
>>>
>>> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
>>> index f6c1f80f94a4..3f8dfe60a59b 100644
>>> --- a/drivers/mfd/mt6397-core.c
>>> +++ b/drivers/mfd/mt6397-core.c
>>> @@ -206,6 +206,26 @@ static const struct mfd_cell mt6359_devs[] = {
>>>        },
>>>    };
>>>
>>> +static const struct mfd_cell mt6366_devs[] = {
>>> +     {
>>> +             .name = "mt6358-regulator",
>>> +             .of_compatible = "mediatek,mt6366-regulator"
>>> +     }, {
>>> +             .name = "mt6358-rtc",
>>> +             .num_resources = ARRAY_SIZE(mt6358_rtc_resources),
>>> +             .resources = mt6358_rtc_resources,
>>> +             .of_compatible = "mediatek,mt6358-rtc",
>>> +     }, {
>>> +             .name = "mt6358-sound",
>>> +             .of_compatible = "mediatek,mt6358-sound"
>>> +     }, {
>>> +             .name = "mt6358-keys",
>>> +             .num_resources = ARRAY_SIZE(mt6358_keys_resources),
>>> +             .resources = mt6358_keys_resources,
>>> +             .of_compatible = "mediatek,mt6358-keys"
>>> +     },
>>> +};
>>> +
>>>    static const struct mfd_cell mt6397_devs[] = {
>>>        {
>>>                .name = "mt6397-rtc",
>>> @@ -280,6 +300,14 @@ static const struct chip_data mt6359_core = {
>>>        .irq_init = mt6358_irq_init,
>>>    };
>>>
>>> +static const struct chip_data mt6366_core = {
>>> +     .cid_addr = MT6358_SWCID,
>>> +     .cid_shift = 8,
>>> +     .cells = mt6366_devs,
>>> +     .cell_size = ARRAY_SIZE(mt6366_devs),
>>> +     .irq_init = mt6358_irq_init,
>>> +};
>>> +
>>>    static const struct chip_data mt6397_core = {
>>>        .cid_addr = MT6397_CID,
>>>        .cid_shift = 0,
>>> @@ -358,6 +386,9 @@ static const struct of_device_id mt6397_of_match[] = {
>>>        }, {
>>>                .compatible = "mediatek,mt6359",
>>>                .data = &mt6359_core,
>>> +     }, {
>>> +             .compatible = "mediatek,mt6366",
>>> +             .data = &mt6366_core,
>>>        }, {
>>>                .compatible = "mediatek,mt6397",
>>>                .data = &mt6397_core,
>>
>>

