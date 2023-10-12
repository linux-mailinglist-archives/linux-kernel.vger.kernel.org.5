Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1267C731F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379466AbjJLQfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343912AbjJLQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:35:09 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E40C0;
        Thu, 12 Oct 2023 09:35:07 -0700 (PDT)
Received: from [192.168.42.20] (p5b164245.dip0.t-ipconnect.de [91.22.66.69])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 8286B2FC0048;
        Thu, 12 Oct 2023 18:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1697128505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxjtNY2PIhe33mFCTAMP/mdiKX7jay1tXWg+m/RQ7IU=;
        b=XiRoS6AAOtjavcoJqrTrF8V2iKReRcxJt8pSRcI5uQVVX1HGXsBdSdWQXezQLzP6RMvwz9
        BUEky7D1jCK50DWjqIwZcBX+hee7RRXdZey7QHk95Pdk9M4V3r/kihDHaQuTcXC8OH+Ba/
        NFFERt4RPad9atk4Tm77AuJaM8aaIqs=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
Date:   Thu, 12 Oct 2023 18:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZSf9QneKO/8IzWhd@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 12.10.23 um 16:05 schrieb Pavel Machek:
> Hi!
>
>>>> There are however some known short comings:
>>>> - The sysfs leds interface does only allow to write one key at a time. The
>>>> controller however can only update row wise or the whole keyboard at once
>>>> (whole keyboard update is currently not implemented). This means that even
>>>> when you want to updated a whole row, the whole row is actually updated
>>>> once for each key. So you actually write up to 18x as much as would be
>>>> required.
>>>> - When you want to update the brightness of the whole keyboard you have to
>>>> write 126 sysfs entries, which inherently is somewhat slow, especially when
>>>> using a slider that is live updating the brightness.
>>>> - While the controller manages up to 126 leds, not all are actually
>>>> populated. However the unused are not grouped at the end but also in
>>>> between. To not have dead sysfs entries, this would require manual testing
>>>> for each implemented device to see which leds are used and some kind of
>>>> bitmap in the driver to sort out the unconnected ones.
>>>> - It is not communicated to userspace which led entry controls which key
>>>> exactly
>>> Sooner or later, we'll need to support these keyboards.
>>>
>>> But this has way too many shortcomings (and we'd be stuck with the
>>> interface forever).
>> I had some thoughts on how the current userspace api could be expanded to
>> better reflect the capabilities of RGB keyboards. What would be required for
>> such an expansion to be considered?
> You submit a proposal.

My quick writeup:

New sysfs entires:
- mode: single_zone_static, multi_zone_static, single_zone_breathing, 
multi_zone_breathing, single_zone_color_cycle, multi_zone_color_cycle, etc.
     - single_zone_static is mandatory, all other modes are optional (maybe even 
freely definable by the driver)
     - single_zone_static is the default and does not add any new sysfs entries 
that aren't already present on multicolor leds aka brightness, max_brightness, 
multi_index, mulit_intensity
     - multi_zone_static adds a new entry zones_count. mulit_intensity has now 
colors count * zones_count entries. aka a rgb keyboard with 126 leds would take 
378 values for mulit_intensity
     - other modes are more device specific e.g.
         - multi_zone_breathing could have optional breathing_speed and 
max_breathing speed entries depending on whether or not the hardware supports it.
         - multi_zone_color_cycle could have a color_count and max_color_count 
entry. e.g. with color_count 2 you would then write 756 values to multi 
intensity, describing 2 states the driver should alternate between

Every multi_zone_* mode could also output a zones_image. That is a greyscale 
bitmap or even a svg containing the information where each zone is located and 
which outline it has. For the bitmap the information would be encoded in the 
grey value, aka 0 = zone 0 etc with 0xff = no zone (i.e. space between the 
keys). For the svg, the name of the paths would indicate the zone they are 
describing. Svg would have the advantage that it could be more easily used to 
also describe non square devices like mice or headsets that also might have 
complex RGB controllers.

This might already be doable with triggers? I'm unsure of triggers allow to 
change the length of multi_intensity however.

>   
>> I'm in contact with the KDE folks. Plasma already has a keyboard brightness
>> slider, that soon
>> https://gitlab.freedesktop.org/upower/upower/-/merge_requests/203 will work
>> with multiple kbd_backlight. However the slowness of 126 sysfs entries makes
>> it a little bit janky still.
>>
>> They are also thinking about expanding desktop accent colors to the keyboard
>> backlight when it supports RGB.
>>
>> I have not reached out to the OpenRGB project yet, but is it alive and well
>> and under constant development: https://gitlab.com/CalcProgrammer1/OpenRGB.
>> Afaik it is currently a userspace only driver interacting directly with
>> hidraw mostly and has not yet implemented the sysfs leds interface.
>>
>> Just listing this to show that there is definitely interest in this.
> Yep, there's definitely interest.
>
>>> These days, displays with weird shapes are common. Like rounded
>>> corners and holes in them. Perhaps this should be better modelled as a
>>> weird display?
>> I'm not sure if I can follow you here. Where would this be implemented? Also
>> I asume displays asume equal distance between pixels and that columns are
>> straight lines perpendicular to rows, which the key backlights have and are
>> not.
> Yes, I know displays are a bit different from RGB LEDs. Gamma is
> another issue. Yes, it is quite weird display. But 6x22 display may be
> better approximation of keyboard than ... 126 unrelated files.
>
> Or you could do 6x66 sparse display, I guess, to express the
> shifts. But I believe 6x22 would be better.
>
> It would go to drivers/auxdisplay, most probably.

Looking into it, thanks for the direction. But this would come with the downside 
that upowers kbd_brightness no longer controls the keyboard.

Another approach could be that i implement what i described under 
multi_zone_static above without the zones_count entry. Then there wouldn't be 
126 unrelated files, but a multi_intensity that is describing multiple 3 subled 
leds. This would at least solve the performance problem and allow the shared 
brightness adjust the hardware supports to be implemented.

>
> I checked
> https://www.tuxedocomputers.com/en/Linux-Hardware/Zubehoer-USB-Co./USB-Zubehoer.tuxedo
> , but you don't seem to have stand-alone keyboard with such RGB capability...?

No, it's for the integrated keyboards in some of our devices, this driver 
specifically is for the Stellaris line with optomechanical keyboards. The ite 
controller is internally connected, but is using the usb protocol.

https://www.tuxedocomputers.com/en/Linux-Hardware/Notebooks/15-16-inch/TUXEDO-Stellaris-15-Gen4.tuxedo

Kind regards,

Werner

>
> Best regards,
> 								Pavel
