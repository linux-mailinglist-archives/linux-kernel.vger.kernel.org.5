Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12E806B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377370AbjLFKA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377340AbjLFKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:00:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B96120;
        Wed,  6 Dec 2023 02:00:59 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABD9C6607325;
        Wed,  6 Dec 2023 10:00:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701856858;
        bh=MrYPk0HrDzQScYwh49Au6CEiQ3KVyyzskdfW4ZzJvR8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FfkEpWEtvCpIaTqJXxSFjhF7WbvrCriQQBpQYmYW6qutLIHr7DbTk6gp/Oa3aDKcc
         D9us//HtSRQ6UAClM+JHRFW31HCR/1FCg6L0VJuot5EDAj7wreJpuEQD0nxYPIFObc
         hCJxzHiz73SQCTxigD0vrqjHVDDBqtH4tnEFJJRKsv4pBYOKOu60cMxblrGn2DR+ze
         PPePYA/0hvYEDFhZHFsEMXeZdbsiGCE4mic3B8SOxcUcXdH/BdDwFvrOZ+AxZMpvGf
         peInj0BHkC+4MCE91P2bQy6oaNGQ1vlAJCyTvwEcI6u78fYH823FmUDwC2MCS/2NNz
         hp27F1Rzc+csQ==
Message-ID: <8d42e0f5-b2d2-471b-ada9-79f76c637abe@collabora.com>
Date:   Wed, 6 Dec 2023 11:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: Add support for device tree thermal zones
 consumers
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        wenst@chromium.org
References: <20231115144857.424005-1-angelogioacchino.delregno@collabora.com>
 <09de3b1b-b725-46b8-97a6-55776fd5ca45@linaro.org>
 <99c1fd8f-4b17-4d4a-87a5-6a65745632fe@collabora.com>
 <ce110f25-5431-4c80-b037-add7fd7461bd@linaro.org>
 <03e950a1-0334-40ab-aa77-ac8175877172@collabora.com>
 <3428b2af-5522-4090-995a-10eaee90c28e@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <3428b2af-5522-4090-995a-10eaee90c28e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/12/23 19:47, Daniel Lezcano ha scritto:
> 
> Hi Angelo,
> 
> On 05/12/2023 14:48, AngeloGioacchino Del Regno wrote:
>> Il 01/12/23 15:18, Daniel Lezcano ha scritto:
> 
> [ ... ]
> 
>>> Putting apart the fact the change you propose is not relevant as there is 
>>> already everything in. My comment is about the current state of the thermal 
>>> framework.
>>>
>>
>> I don't really understand this assertion, and I'm afraid that I'm underestimating
>> something so, in case, please help me to understand what am I missing here.
> 
> Sure. Let me clarify my understanding of you proposal and my assertion.
> 
>   - A driver needs a thermal zone device structure pointer in order to read its 
> temperature. But as it is not the creator, it does not have this pointer.
> 
>   - As a solution, several drivers are using a specific DT bindings to map a 
> thermal zone "name/type' with a string to refer from the driver a specific thermal 
> zone node name. Then the function thermal_zone_device_get_by_name() is used to 
> retrieve the pointer.
> 
>   - Your proposal is to provide that mechanism in the thermal_of code directly, so 
> the code can be factored out for all these drivers.
> 
> Is my understanding correct?
> 

I think that your understanding is 95% correct....

> My point is:
> 
>   - The driver are mapping a thermal zone with a name but a node name is supposed 
> to be unique on DT (but that is implicit)
> 
>   - A phandle is enough to get the node name, no need to add a thermal zone name to 
> get the node and then get the thermal zone. It is duplicate information as the DT 
> uses the node name as a thermal zone name.
> 
> We could have:
> 
>          thermal-zones {
>                  display {
>                          polling-delay-passive = <0>;
>                          polling-delay = <0>;
>                          thermal-sensors = <&display_temp>;
>                  };
>          };
> 
>          papirus27@0{
> 
>          [ ... ]
> 
> ---             pervasive,thermal-zone = "display";
> +++             pervasive,thermal-zone = <&display>;
>          };
> 
> The ux500 is directly calling thermal_zone_device_get_by_name() with the thermal 
> zone node name.
> 

.... but as for the remaining 5%, I'm not sure, so I'll put one full-of-fantasy
example here to make sure that you get my point:


************************************
fantasy soc/board 1:

thermal-zones {
	/*
	 * The type (or name, whatever) of this zone is "dsi-disp-thermal"
	 * and not "display" - this is on purpose. Can be changed to "display"
	 * without any concerns in this fantasy soc/board.
	 */
	display: dsi-disp-thermal {
		polling-delay ....
		thermal-sensors ...
	}

	something_else: some-other-zone {
		stuff ...
	}
}

************************************
fantasy soc/board 2 (qcom vs mtk vs rockchip vs...):

thermal-zones {
	/*
	 * The type (or name, whatever) of this zone is "edp-disp-thermal"
	 * and not "display" - this is on purpose. Can be changed to "display"
	 * without any concerns in this fantasy soc/board.
	 */
	display: edp-disp-thermal {
		polling-delay ....
		thermal-sensors ...
	}

	.....
}

************************************
fantasy soc/board 3 (qcom vs mtk vs rockchip vs...):

thermal-zones {
	/*
	 * The type (or name, whatever) of this zone is "skin-sense-left-thermal"
	 * and not "display" - this is on purpose: on this device the display temp
	 * zone is retrieved from the "bottom" skin temperature zone, because the
	 * display's driver ic is 0.01mm far from that physical zone, so they have
	 * placed a sensor there.
	 *
	 * Lots of fantasy here, but it's just to show why a thermal zone may have
	 * a different name on different boards, and why it is more descriptive to
	 * keep the board-specific TZ name instead of changing them all to have a
	 * driver specific "display" name.
	 */
	display: skin-sense-bottom-thermal {
		polling-delay ....
		thermal-sensors ...
	}

	skin_zone: skin-sense-left-right-top-thermal {
		.....
	}

	.....
}

************************************
whatever dtsi/dts for whatever device based on whatever soc:

device@0 {
	....

	interrupts = <this that blah>
	interrupt-names = "some";

	clocks = <&clkcontroller 22>;
	clock-names = "main";

	dmas = ....
	dma-names = ....

	pwms = ...
	pwm-names = ....

	.... likewise, for thermal zones ....

	thermal-zones = <&display>, <&skin_zone_a>, <&batt_therm>;
	thermal-zone-names = "disp-therm", "skin-temp", "battery-top";
}
************************************

driver code:

device-driver.c:

/* This driver wants disp, batt, skin because it tries to calculate an
  * optimal battery charging current while trying to not burn users' hands
  * or something like that.
  */
enum therm_to_watch {
	THERM_DISPLAY,
	THERM_BATT_TOP,
	THERM_SKIN_TEMP,
	THERM_MAX
}

static const char * const device_therm_to_watch[THERM_MAX] = {
	"disp-therm", "battery-top", "skin-temp", [...]
};



int some_function(params) {
	[... stuff ...]

	/*
	 * Get the zones associated to the thermal-zone-names in device tree
	 *
	 * ------> This is the main reason why I proposed this commit! :-) <------
	 */
	for (i = 0; i < THERM_MAX; i++) {
		ret = thermal_of_get_zone(dev, device_therm_to_watch[i]);
		if (ret)
			return ret;
	}

	[...]
}
************************************

...my target is currently the MediaTek Smart Voltage Scaling driver, where we have
rather huge platform data (similarly to Qualcomm CPR) for [a / an increasing number
of] SoC(s): we have different SoC thermal zones for CPU big(0/1/2/3/all) and
little(0123all), and GPU, which have got different names (currently "types" in the
thermal framework).

The reason why the zone names are different across those SoCs is that those are
actually somewhat defined in the datasheets, so the names in device tree do reflect
those of the datasheet.
The driver would need cpu-big, cpu-little, or cpu, and gpu thermal zones.

But again, there are other cases apart from MTK SVS.

>> For how I see it, in the thermal framewoek I don't see any "somewhat standardized"
>> helper like the one(s) that I'm introducing with this patch (thermal_of_get_zone(),
>> thermal_of_get_zone_by_index()), and this is the exact reason why I'm proposing
>> this patch.
>>
>> Then again - I mean no disrespect - it's just that I don't understand (yet) why you
>> are saying that "everything is already available", because I really don't see it.
> 
> Ok said differently, thermal zone name and type are messy.
> 
> Let's clarify that and then let's see with the result if adding this thermal zone 
> node/name mapping still makes sense.
> 

Yes, I think that it's sensible at this point to just clarify that in the framework
first, and then go on with the rest.

>>>   - A thermal zone does not have a name but a type
>>>
>>>   - We use the thermal zone DT node name to register as a name but it is a type 
>>> from the thermal framework point of view
>>
>> This is something that I didn't realize before. Thanks for that.
>>
>> ...and yes, we're registering a "name" from DT as a "type" in the framework, this
>> is highly confusing and needs to be cleaned up.
>>
>>>
>>>   - We can register several thermal zones with the same type (so we can have 
>>> duplicate names if we use type as name)
>>>
>>
>> ...which makes sense, after realizing that we're registering a TYPE and not a NAME,
>> and I agree about the logic for which that multiple zones can be of the same type.
>>
>>>   - We use thermal_zone_device_get_by_name() but actually it checks against the 
>>> type and as we can have multiple identical types, the function returns the first 
>>> one found
>>>
>>
>> The first thing that comes to mind is to rename thermal_zone_device_get_by_name()
>> to thermal_zone_device_get_by_type(), but then I'd be reintroducing the former and
>> this gives me concerns about OOT drivers using that and developers getting highly
>> confused (name->type, but name exists again, so they might erroneously just fix the
>> call to xxx_by_name() instead of changing it to xxx_by_type()).
> 
> 
>> Should I *not* be concerned about that?
> 
> Not really :)
> 
> TBH, OOT drivers do not exist from upstream POV.
> 

Happy to see this answer.

>  > Any suggestion?
> 
> Yes, let's introduce a thermal zone name in the tzd.
> 

Let's go! I'll start this work ASAP.

>   - There are now too many parameters to the function 
> thermal_zone_device_register*(), so we can't add a new 'name' parameter. Introduce 
> a thermal_zone_device_parameters structure. This structure will contain all 
> thermal_zone_device_register_* parameter function. There won't be any functional 
> changes, just how the parameters are passed. Perhaps, you should use an 
> intermediate function to not have the change impacting everywhere.
> 
>   - then add a const char *name field in this structure and in the 
> thermal_zone_device structure. So we can assign the name to the thermal zone. The 
> name must be checked against duplicate. If no name is specified when creating a 
> thermal zone, then name = type.
> 
>   - In thermal_of, use the node name for the type and the name, that will be 
> duplicate but we will sort it out later.
> 
>   - Add the name in sysfs
> 

I didn't expect a detailed guidance like that! Even though we seem to think alike,
as in, I was imagining to do exactly that -  thank you, this reduces the actual
brainstorming from my side as makes me sure that we want to do the same thing, and
also makes me able to "make my hands dirty with code" sooner than later.

Speeds up the whole process.

> Second step, track down users of thermal_zone_device_get_by_name() and check if 
> they can use the name instead of the type. I'm pretty sure it is the case for most 
> of the callers.
> 
> With that, there will be a nice clarification IMHO.
> 
> Then we will be able to restate the 'type' with something different without 
> breaking the existing ABI.
> 

Yes, I totally agree with that.

Okay - it looks like we have at least 95% of a plan - it's enough for me to start
writing the cleanup.

Cheers!
Angelo
