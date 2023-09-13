Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E358479E70E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbjIMLoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjIMLoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:44:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC15710E6;
        Wed, 13 Sep 2023 04:43:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE873660733E;
        Wed, 13 Sep 2023 12:43:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694605436;
        bh=rJbG4m613P7qZGZ7uqt8izGJD3tSdXSLnNutOtXNuWs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ORMUwgS2B3hoimYVbdUOKJqBVEH4GpvH6354MjoGlyb1nIxiwdh76Z1bHMBHCZHhE
         gJM0wLw4mvf80N0ATzZoRb063pKYtM5V+SisHSjZ6/lh8W/98BBT2QGinDJXG4iddQ
         +kP9Y5O9EFlBqKEaaw3kmPPzO8vcDqhu5vLjIx3Zc/YyApq8xIdiH1gAv59MW6DfQz
         7f37oC1Zo+nh4PH0WJ6OyJJ40ejgySOTwx75PCxf2AsF3O5xkoU0Xyvw+Fams+27Y+
         d49E3yiEG0ad1jlmikDFuPZhSYHfFcF6P7hhg8oW/eWeFjRr1PEOC6yyuT/q2furYO
         fZAQGZkalpOOg==
Message-ID: <f13a6648-cd21-a166-6e56-431ac7ee5dec@collabora.com>
Date:   Wed, 13 Sep 2023 13:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC v1 3/3] thermal/drivers/mediatek/lvts_thermal: add mt7988
 support
Content-Language: en-US
To:     frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230911183354.11487-1-linux@fw-web.de>
 <20230911183354.11487-4-linux@fw-web.de>
 <8949cbfa-acae-d6ac-e5fb-f238a29630bc@collabora.com>
 <465DDC1C-D687-47A7-966C-73FB42CFC5DD@public-files.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <465DDC1C-D687-47A7-966C-73FB42CFC5DD@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/09/23 12:52, Frank Wunderlich ha scritto:
> Am 13. September 2023 10:16:51 MESZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
> Hi angelo,
> 
> thanks for first look
> 
>> Il 11/09/23 20:33, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add Support for mediatek fologic 880/MT7988.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>>    drivers/thermal/mediatek/lvts_thermal.c | 73 +++++++++++++++++++++++++
>>>    1 file changed, 73 insertions(+)
>>>
>>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>>> index c1004b4da3b6..48b257a3c80e 100644
>>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>>> @@ -82,6 +82,8 @@
>>>    #define LVTS_GOLDEN_TEMP_DEFAULT	50
>>>    #define LVTS_COEFF_A_MT8195			-250460
>>>    #define LVTS_COEFF_B_MT8195			250460
>>> +#define LVTS_COEFF_A_MT7988			-204650
>>> +#define LVTS_COEFF_B_MT7988			204650
>>>      #define LVTS_MSR_IMMEDIATE_MODE		0
>>>    #define LVTS_MSR_FILTERED_MODE		1
>>> @@ -1272,6 +1274,67 @@ static int lvts_remove(struct platform_device *pdev)
>>>    	return 0;
>>>    }
>>>    +/*
>>> + * LVTS MT7988
>>> + */
>>> +#define LVTS_HW_SHUTDOWN_MT7988	117000
>>
>> Are you sure that this chip's Tj is >117°C ?!
>>
>> Looks a bit high... if it is exactly 117°C, I would suggest cutting earlier,
>> either at 110 (safe side) or 115: after all, this is a life-saver feature and
>> the chip is actually never meant to *constantly* work at 110°C (as it would
>> degrade fast and say goodbye earlier than "planned").
> 
> I took values from SDK
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/target/linux/mediatek/files-5.4/drivers/thermal/mediatek/soc_temp_lvts.c#1483
> 

That kernel also defines 117°C for MT8195, which leaves me a bit dubious.

For safety, I would recommend using the same 105°C hw shutdown temperature
for 7988 as well: after all if you think about it, reaching that kind of
temperature means that there's a real problem (fan stopped working and/or
heatsink detached) that needs attention.

This is because you'll have trip points in devicetree that should throttle
the CPU in case it reaches at least a dangerously high temperature (read:
a temperature outside the recommended continuous operation range), bringing
the temperatures down because of the throttling action; I would imagine
throttling the CPU a bit down at 80°C, then a bit more at 90°C - but then,
if the temps won't drop like that, there's clearly a HW-related issue that
must be addressed (like the fan/heatsink scenario that I just described).

Though, take this as an advice; I'll respect whichever decision you'll take.

>>> +//enum mt7988_lvts_domain { MT7988_AP_DOMAIN, MT7988_NUM_DOMAIN };
>>> +
>>> +enum mt7988_lvts_sensor_enum {
>>> +	MT7988_TS3_0,
>>> +	MT7988_TS3_1,
>>> +	MT7988_TS3_2,
>>> +	MT7988_TS3_3,
>>> +	MT7988_TS4_0,
>>> +	MT7988_TS4_1,
>>> +	MT7988_TS4_2,
>>> +	MT7988_TS4_3,
>>> +	MT7988_NUM_TS
>>> +};
> 
>> This enumeration should be definitions in bindings (mediatek,lvts-thermal.h).
>>
>> Besides, the LVTS is about internal temperatures, so those TS3_x and 4_x can
>> be renamed like what was done for MT8192 and MT8195: this is because you will
>> never see TS3_2 being CPU2 on a board and CPU4 on another, being those - again -
>> internal to the SoC, hence unchangeable.
> 
> Right these sensors are internally only and i took naming from sdk to avoid confusion. And i have not more information about these internal sensors (special meaning),but their values are packed together to get the resulting (average) temperature.
> 
>> Another reason is that you'll anyway have to refer to those sensors in the
>> devicetree to configure thermal trips and such, so... :-)
> 
> In device tree it will look like this:
> 
> https://github.com/frank-w/BPI-Router-Linux/blob/6.5-lvts/arch/arm64/boot/dts/mediatek/mt7988a.dtsi#L771
> 
> Daniel has also defined thermal trips there,but these are untested atm. I only verified temperature itself i get from sysfs as far as i can (start at ~40°C and reaching ~70 while running).
> 

Check how it's done in mt8192.dtsi and mt8195.dtsi: we're using the definitions
from the bindings for thermal zones.
At least for consistency (apart from other even more valid considerations), that's
how it should be done: please do it like that.

Besides, I think that you can definitely guess what `TS` is CPU related: checking
the driver and devicetree from the downstream kernel that you provided, what I
understand is:

1. Your naming TS3,4 corresponds to TS2,3 downstream (so it's wrong?)
2. Downstream TS2 is related to the CPU cores, so it should be
    - TS2_0 - CPU0
    - TS2_1 - CPU1
    - TS2_2 - CPU2
    - TS2_3 - CPU3

The other set of thermal sensors seem to be completely unused, so we cannot guess
just by looking at the code. Since you have the hardware, you may be able to take
a position about what they are by checking what sensor heats up for each "action"
(could be ethernet controller or infra or whatever else); if in doubt, just leave
them out, but add a comment saying that there are more sensors and say where, so
that if anyone finds what they're for, it'll be easy to add them.

In any case, adding thermal sensors that you don't know about is meaningless, as
the sense of all this is:
  - Monitoring temperatures of the hardware
  - Taking action to prevent temperature overrun
but if you don't know what you're reading, you can't interpret temperatures for
something unknown, hence you can't as well take action to prevent overruns, as
you won't know what's the maximum temperature for "unknown thing" :-)

Regards,
Angelo

