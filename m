Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412A3800795
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378116AbjLAJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378034AbjLAJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:52:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF0E6;
        Fri,  1 Dec 2023 01:52:58 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D393866028F5;
        Fri,  1 Dec 2023 09:52:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701424377;
        bh=uB2TrBWbPzNfO1Pa9O+R+Gcny3corfkI3WYrnflXA4Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mDYthD0yJhSmNZOfzbepaBJtOjfeye0vgHAsXkcXISgVzodR8OlfYt5o63hiywZi6
         9B7nZmXAIA7bYY6osFyV5KQaOJ0pLJ/GOoQMw2SHavsXf6/ADfyvvaA6I9plsdksbJ
         xZtgiziKpvLslq0VsVQQ8C1keqaXTWdLkcIdDGxxgRfxd1nGItKnKfrKWHIWaljVah
         lPS4KipDw0d34Q9KSxnMLjoQpv+2qFJZ63JQpDBx1nvXovZQWV+TxzpdV3WuqM3LKz
         WV7HxihwZs7TnI+0nczVXsmkL1K1Z4/BW+5E6RdNq3AqXJHGLsXhMJQHZNKDGEJeCi
         lATE8dbKEh0ww==
Message-ID: <99c1fd8f-4b17-4d4a-87a5-6a65745632fe@collabora.com>
Date:   Fri, 1 Dec 2023 10:52:54 +0100
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <09de3b1b-b725-46b8-97a6-55776fd5ca45@linaro.org>
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

Il 30/11/23 14:22, Daniel Lezcano ha scritto:
> 
> Hi Angelo,
> 
> thanks for your proposal
> 
> On 15/11/2023 15:48, AngeloGioacchino Del Regno wrote:
>> Add helpers to support retrieving thermal zones from device tree nodes:
>> this will allow a device tree consumer to specify phandles to specific
>> thermal zone(s), including support for specifying thermal-zone-names.
>> This is useful, for example, for smart voltage scaling drivers that
>> need to adjust CPU/GPU/other voltages based on temperature, and for
>> battery charging drivers that need to scale current based on various
>> aggregated temperature sensor readings which are board-dependant.
> 
> IMO these changes are trying to solve something from the DT perspective adding more 
> confusion between phandle, names, types etc ... and it does not really help AFAICT.
> 

I honestly don't see how can assigning thermal zones (like we're doing for other
consumers like clocks, etc) to a node can be confusing?
To me, it looks like a pattern that is repeating over and over in device tree, for
multiple types of consumers.

> Overall I'm a bit reluctant to add more API in the thermal.h. From my POV, we 
> should try to remove as much as possible functions from there.
> 

Cleaning up the API is always something that makes sense, but I don't see why this
should prevent useful additions...

> That said, the name of a thermal zone does not really exists and there is confusion 
> in the code between a name and a type. (type being assumed to be a name).

That depends on how you see it. What my brain ticks around is:
A thermal zone is a physical zone on the PCB, or a physical zone on a chip,
which has its own "real name", as in, it can be physically identified.

Example: The "Skin area" of a laptop is something "reachable" from the user as an
externally exposed part. This area's temperature is read by thermistor EXTERNAL_1,
not by thermistor "SKIN0".

Same goes for "big cluster area", "little cluster area", "cpu complex area", etc.

> 
> There could be several thermal zones with the same types for non-DT description. 
> However, the documentation says we should create an unique type in the DT and that 
> is what is happening when registering a thermal zone from the DT [1] as we use the 
> node name.
> 
>  From an external driver, it possible to get the np->name from the phandles and 
> call thermal_zone_get_by_name(np->name).
> 

That'd still require you to pass a thermal zone phandle to the node(driver) though?

> The hardening change which may make sense is to check a thermal zone with the same 
> name is not already registered in thermal_of.c by checking 
> thermal_zone_get_by_name() fails before registering it.
> 

Yes we can harden that, but I don't see how is this relevant to thermal zones
device tree consumers (proposed in this patch)?

Cheers,
Angelo

>    -- Daniel
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/thermal_of.c?h=thermal%2Fbleeding-edge#n514
> 
>> Example:
>> smart-scaling-driver@10000000 {
>>     [...]
>>
>>     thermal-zones = <&cluster_big_tz>, <&gpu_tz>, <&vpu_tz>;
>>     thermal-zone-names = "cpu", "gpu", "vpu";
>>
>>     [...]
>> }
>>
>> battery-charger@20000000 {
>>     [...]
>>
>>     thermal-zones = <&battery_temp>, <&device_skin_temp>;
>>     thermal-zone-names = "batt-ext-sensor", "skin";
>>
>>     [...]
>> }
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>
>> Changes in v2:
>>   - Added missing static inline for !CONFIG_OF fallback functions
>>
>> Background story: while I was cleaning up the MediaTek Smart Voltage Scaling
>> (SVS) driver, I've found out that there's a lot of commonization to be done.
>> After a rewrite of "this and that" in that driver, I came across a barrier
>> that didn't allow me to remove another ~100 lines of code, and that was also
>> anyway breaking the driver, because the thermal zone names are different
>> from what was originally intended.
>>
>> I've been looking for thermal zone handle retrieval around the kernel and
>> found that there currently are at least four other drivers that could make
>> use this as a cleanup: charger-manager, which is retrieving a thermal zone
>> to look for with a "cm-thermal-zone" string property, gpu/drm/tiny/repaper.c
>> that does the same by checking a "pervasive,thermal-zone" string property,
>> and ab8500_temp and sdhci-omap which are simply hardcoding a "cpu_thermal"
>> and "battery-thermal" thermal zone names respectively.
>>
>> There are a number of other devices (mostly embedded, mostly smartphones)
>> that don't have an upstream driver and that could make use of this as well.
>>
>> Cheers!
>>
>>
>>   drivers/thermal/thermal_of.c | 91 ++++++++++++++++++++++++++++++++++++
>>   include/linux/thermal.h      | 15 ++++++
>>   2 files changed, 106 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 1e0655b63259..d8ead456993e 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -538,6 +538,97 @@ static struct thermal_zone_device 
>> *thermal_of_zone_register(struct device_node *
>>       return ERR_PTR(ret);
>>   }
>> +/**
>> + * __thermal_of_get_zone_by_index() - Get thermal zone handle from the DT
>> + *                      thermal-zones index
>> + * @dev:   Pointer to the consumer device
>> + * @index: Index of thermal-zones
>> + *
>> + * This function will search for a thermal zone in the thermal-zones phandle
>> + * array corresponding to the specified index, then will search for its name
>> + * into the registered thermal zones through thermal_zone_get_zone_by_name()
>> + *
>> + * Please note that this function is for internal use only and expects that
>> + * all of the sanity checks are performed by its caller.
>> + *
>> + * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
>> + * when the API is disabled or the "thermal-zones" DT property is missing.
>> + */
>> +static struct thermal_zone_device
>> +*__thermal_of_get_zone_by_index(struct device *dev, int index)
>> +{
>> +    struct thermal_zone_device *tzd;
>> +    struct device_node *np;
>> +
>> +    np = of_parse_phandle(dev->of_node, "thermal-zones", index);
>> +    if (!np)
>> +        return NULL;
>> +
>> +    tzd = thermal_zone_get_zone_by_name(np->name);
>> +    of_node_put(np);
>> +
>> +    return tzd;
>> +}
>> +
>> +/**
>> + * thermal_of_get_zone_by_index() - Get thermal zone handle from a DT node
>> + *                    based on index
>> + * @dev:   Pointer to the consumer device
>> + * @index: Index of thermal-zones
>> + *
>> + * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
>> + * when the API is disabled or the "thermal-zones" DT property is missing.
>> + */
>> +struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int 
>> index)
>> +{
>> +    if (!dev || !dev->of_node)
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    if (!of_property_present(dev->of_node, "thermal-zones"))
>> +        return NULL;
>> +
>> +    return __thermal_of_get_zone_by_index(dev, index);
>> +}
>> +
>> +/**
>> + * thermal_of_get_zone() - Get thermal zone handle from a DT node based
>> + *               on name, or the first handle in list
>> + * @dev:   Pointer to the consumer device
>> + * @name:  Name as found in thermal-zone-names or NULL
>> + *
>> + * This function will search for a thermal zone in the thermal-zones phandle
>> + * array corresponding to the index of that in the thermal-zone-names array.
>> + * If the name is not specified (NULL), it will return the first thermal zone
>> + * in the thermal-zones phandle array.
>> + *
>> + * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
>> + * when the API is disabled or the "thermal-zones" DT property is missing.
>> + */
>> +struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char 
>> *name)
>> +{
>> +    int index;
>> +
>> +    if (!dev || !dev->of_node)
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    if (!of_property_present(dev->of_node, "thermal-zones")) {
>> +        pr_err("thermal zones property not present\n");
>> +        return NULL;
>> +    }
>> +
>> +    if (name) {
>> +        index = of_property_match_string(dev->of_node, "thermal-zone-names", name);
>> +        if (index < 0) {
>> +            pr_err("thermal zone names property not present\n");
>> +            return ERR_PTR(index);
>> +        }
>> +    } else {
>> +        index = 0;
>> +    }
>> +
>> +    return __thermal_of_get_zone_by_index(dev, index);
>> +}
>> +
>>   static void devm_thermal_of_zone_release(struct device *dev, void *res)
>>   {
>>       thermal_of_zone_unregister(*(struct thermal_zone_device **)res);
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index cee814d5d1ac..0fceeb7ed08a 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -261,6 +261,9 @@ struct thermal_zone_device 
>> *devm_thermal_of_zone_register(struct device *dev, in
>>   void devm_thermal_of_zone_unregister(struct device *dev, struct 
>> thermal_zone_device *tz);
>> +struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int 
>> index);
>> +struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char 
>> *name);
>> +
>>   #else
>>   static inline
>> @@ -274,6 +277,18 @@ static inline void devm_thermal_of_zone_unregister(struct 
>> device *dev,
>>                              struct thermal_zone_device *tz)
>>   {
>>   }
>> +
>> +static inline
>> +struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int 
>> index)
>> +{
>> +    return ERR_PTR(-ENOTSUPP);
>> +}
>> +
>> +static inline
>> +struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char 
>> *name)
>> +{
>> +    return ERR_PTR(-ENOTSUPP);
>> +}
>>   #endif
>>   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> 

