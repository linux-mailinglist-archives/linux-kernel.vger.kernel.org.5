Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E74805662
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjLENsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjLENsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:48:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02901AA;
        Tue,  5 Dec 2023 05:48:46 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96E9E6607295;
        Tue,  5 Dec 2023 13:48:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701784125;
        bh=QHpD8YOtXaDi52IC6086xEhq6SgOi9Ayt/A/doymTOM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k9JSa9mQfWzzxuQqnphrYKt7/I5ycZAtjjkLEWWs2CnpBriiSCbPMf0+f6URj5HWQ
         oMTY9YoPLqMr7/VO/C2TOOHlrIlVKvOTdZXY4YnpSCHhD32toLapIZe94rRAC+CCe/
         1bRWwaltloNcAt/Jl6B4JY+iWqpAcPv8DZQH44MnpcDHOQaa1OmXgxdl3yPONgty/e
         EQiZE3vdP9iyv00JZRELUbVLKOkJC64oLzKL8i/gUt67vNiq+kAAsZd9R9eJ5lAnXj
         fxh0FX8v5QpX7sRsUTqiBIHQ1VL2dPGwD1wC7qjZjTyWmX/dOzqk03nJ3DtYNhcJtO
         RZua2aA85eXhg==
Message-ID: <03e950a1-0334-40ab-aa77-ac8175877172@collabora.com>
Date:   Tue, 5 Dec 2023 14:48:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: Add support for device tree thermal zones
 consumers
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        wenst@chromium.org
References: <20231115144857.424005-1-angelogioacchino.delregno@collabora.com>
 <09de3b1b-b725-46b8-97a6-55776fd5ca45@linaro.org>
 <99c1fd8f-4b17-4d4a-87a5-6a65745632fe@collabora.com>
 <ce110f25-5431-4c80-b037-add7fd7461bd@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ce110f25-5431-4c80-b037-add7fd7461bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/23 15:18, Daniel Lezcano ha scritto:
> 
> Hi Angelo,
> 
> On 01/12/2023 10:52, AngeloGioacchino Del Regno wrote:
>> Il 30/11/23 14:22, Daniel Lezcano ha scritto:
>>>
>>> Hi Angelo,
>>>
>>> thanks for your proposal
>>>
>>> On 15/11/2023 15:48, AngeloGioacchino Del Regno wrote:
>>>> Add helpers to support retrieving thermal zones from device tree nodes:
>>>> this will allow a device tree consumer to specify phandles to specific
>>>> thermal zone(s), including support for specifying thermal-zone-names.
>>>> This is useful, for example, for smart voltage scaling drivers that
>>>> need to adjust CPU/GPU/other voltages based on temperature, and for
>>>> battery charging drivers that need to scale current based on various
>>>> aggregated temperature sensor readings which are board-dependant.
>>>
>>> IMO these changes are trying to solve something from the DT perspective adding 
>>> more confusion between phandle, names, types etc ... and it does not really help 
>>> AFAICT.
>>>
>>
>> I honestly don't see how can assigning thermal zones (like we're doing for other
>> consumers like clocks, etc) to a node can be confusing?
>> To me, it looks like a pattern that is repeating over and over in device tree, for
>> multiple types of consumers.
> 
> Because there is no need to add anything. Everything is already available.
> 
> Add a phandle in the device node wanting to access the thermal zone, get the 
> thermal zone device node pointer name and use thermal_zone_device_get_by_name(), 
> but see below ...
> 
> 
>>> Overall I'm a bit reluctant to add more API in the thermal.h. From my POV, we 
>>> should try to remove as much as possible functions from there.
>>>
>>
>> Cleaning up the API is always something that makes sense, but I don't see why this
>> should prevent useful additions...
>>
>>> That said, the name of a thermal zone does not really exists and there is 
>>> confusion in the code between a name and a type. (type being assumed to be a name).
>>
>> That depends on how you see it. What my brain ticks around is:
>> A thermal zone is a physical zone on the PCB, or a physical zone on a chip,
>> which has its own "real name", as in, it can be physically identified.
> 
> What I meant the thermal framework does not really have a thermal zone name, just a 
> type. So it is possible to find several thermal zone with the same type like "acpitz"
> 
>> Example: The "Skin area" of a laptop is something "reachable" from the user as an
>> externally exposed part. This area's temperature is read by thermistor EXTERNAL_1,
>> not by thermistor "SKIN0".
>>
>> Same goes for "big cluster area", "little cluster area", "cpu complex area", etc.
> 
> Today that is solved with a configuration file mapping a specific thermal zone to a 
> name but still fragile as we can have duplicate thermal zone types.
> 
>>> There could be several thermal zones with the same types for non-DT description. 
>>> However, the documentation says we should create an unique type in the DT and 
>>> that is what is happening when registering a thermal zone from the DT [1] as we 
>>> use the node name.
>>>
>>>  From an external driver, it possible to get the np->name from the phandles and 
>>> call thermal_zone_get_by_name(np->name).
>>>
>>
>> That'd still require you to pass a thermal zone phandle to the node(driver) though?
> 
> Yes
> 
>>> The hardening change which may make sense is to check a thermal zone with the 
>>> same name is not already registered in thermal_of.c by checking 
>>> thermal_zone_get_by_name() fails before registering it.
>>>
>>
>> Yes we can harden that, but I don't see how is this relevant to thermal zones
>> device tree consumers (proposed in this patch)?
> 
> Putting apart the fact the change you propose is not relevant as there is already 
> everything in. My comment is about the current state of the thermal framework.
> 

I don't really understand this assertion, and I'm afraid that I'm underestimating
something so, in case, please help me to understand what am I missing here.

For how I see it, in the thermal framewoek I don't see any "somewhat standardized"
helper like the one(s) that I'm introducing with this patch (thermal_of_get_zone(),
thermal_of_get_zone_by_index()), and this is the exact reason why I'm proposing
this patch.

Then again - I mean no disrespect - it's just that I don't understand (yet) why you
are saying that "everything is already available", because I really don't see it.

>   - A thermal zone does not have a name but a type
> 
>   - We use the thermal zone DT node name to register as a name but it is a type 
> from the thermal framework point of view

This is something that I didn't realize before. Thanks for that.

...and yes, we're registering a "name" from DT as a "type" in the framework, this
is highly confusing and needs to be cleaned up.

> 
>   - We can register several thermal zones with the same type (so we can have 
> duplicate names if we use type as name)
> 

...which makes sense, after realizing that we're registering a TYPE and not a NAME,
and I agree about the logic for which that multiple zones can be of the same type.

>   - We use thermal_zone_device_get_by_name() but actually it checks against the 
> type and as we can have multiple identical types, the function returns the first 
> one found
> 

The first thing that comes to mind is to rename thermal_zone_device_get_by_name()
to thermal_zone_device_get_by_type(), but then I'd be reintroducing the former and
this gives me concerns about OOT drivers using that and developers getting highly
confused (name->type, but name exists again, so they might erroneously just fix the
call to xxx_by_name() instead of changing it to xxx_by_type()).

Should I *not* be concerned about that? Any suggestion?


I'd be glad to go on and "make it clear" that we're doing type comparison and not
name comparison (with that rename, or similar), because (again) I see how confusing
that is. I was confused by that as well, so... :-)

> All this is a bit fuzzy and confusing. So if you add these mapping between thermal 
> zone nodes and names, that will be even more confusing.
> 

IMO, not really. The thermal-zone-names are "local to a driver", not to the thermal
framework itself... it's like for clocks, interrupts, etc.: you want to get a TZ
that is declared with name "xyz", but it doesn't matter what the real name of the
actual TZ actually is.

Since I'm not sure I expressed myself in the best possible way, I'm referring to
the following example:

	clock-names = "main";

...but the "real name" for the clock in the clk framework is "mfg_bg3d".

That's the same with what I'm introducing here (forget for just one moment that
there is this name<->type issue):

	thermal-zone-names = "xyz";

...but the "real name" for the TZ in the thermal framework is "gpu0-thermal".

> Ideally, it would make more sense to cleanup this in order to have something like 
> an enum type describing the thermal zone (battery, cpu, npu, gpu, dsp, ...) which 
> would be used as a type of thermal zone and then an unique name (cpu0, cpu1, 
> modem0, modem1, gpu-bottom, gpu-top, gpu-center, skin, ...).
> 

This might get more complicated than how it looks, but would actually make sense
as well: the concern would be about how do we cleanly declare (example, in DT, but
ACPI is the worst case, as ACPI tables are a "set and forget" type of thing,
shipped  with BIOSes/EFI and almost never modified).

Cheers,
Angelo

