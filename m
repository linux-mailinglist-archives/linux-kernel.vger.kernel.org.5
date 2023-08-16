Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67D77DC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbjHPIVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242836AbjHPIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:21:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23D41FD0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:21:30 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00A53B2A;
        Wed, 16 Aug 2023 10:20:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692174016;
        bh=YSYSNTqKVyOXHnX+At0jwHzkoKfmrs+ev+WeIQDxMHM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UNjzeLmjHe1RTt7zUbHZ5/23qNxypogbuPBtztSL0eNzUxd3OF7TRV6xTBwemuzic
         zS14iiFY0/uNREcEgvHTgJNJSGjfguUF91i0qH2/cF75nMX+WymT+ficwF7nj57GMQ
         bIBvH2rzYGraVNViSD2G8z7qrUDc4pSzBpTEjzPQ=
Message-ID: <6bb64c1c-973c-d5fd-5b66-a7b42666f615@ideasonboard.com>
Date:   Wed, 16 Aug 2023 11:21:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/11] drm/bridge: tc358768: Fix bit updates
Content-Language: en-US
To:     Maxim Schwalm <maxim.schwalm@gmail.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco@dolcini.it>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-2-1afd44b7826b@ideasonboard.com>
 <cd5d39a2-4f4c-419a-8137-d2719135e205@gmail.com>
 <241937b4-1ef8-abad-7c4a-b26bfab86a3a@ideasonboard.com>
 <92396880-edb5-d8e0-4fcf-54aeaa2b40d7@gmail.com>
 <52151daa-90af-a6c0-9b03-f69081321253@ideasonboard.com>
 <d55fc4d3-015d-8cc2-417e-e92aa4687ca2@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <d55fc4d3-015d-8cc2-417e-e92aa4687ca2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 20:21, Maxim Schwalm wrote:
> On 14.08.23 08:34, Tomi Valkeinen wrote:
>> On 13/08/2023 03:23, Maxim Schwalm wrote:
>>> Hi,
>>>
>>> On 11.08.23 19:02, Tomi Valkeinen wrote:
>>>> On 11/08/2023 19:23, Péter Ujfalusi wrote:
>>>>>
>>>>>
>>>>> On 04/08/2023 13:44, Tomi Valkeinen wrote:
>>>>>> The driver has a few places where it does:
>>>>>>
>>>>>> if (thing_is_enabled_in_config)
>>>>>> 	update_thing_bit_in_hw()
>>>>>>
>>>>>> This means that if the thing is _not_ enabled, the bit never gets
>>>>>> cleared. This affects the h/vsyncs and continuous DSI clock bits.
>>>>>
>>>>> I guess the idea was to keep the reset value unless it needs to be flipped.
>>>>>
>>>>>>
>>>>>> Fix the driver to always update the bit.
>>>>>>
>>>>>> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
>>>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/bridge/tc358768.c | 13 +++++++------
>>>>>>     1 file changed, 7 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
>>>>>> index bc97a837955b..b668f77673c3 100644
>>>>>> --- a/drivers/gpu/drm/bridge/tc358768.c
>>>>>> +++ b/drivers/gpu/drm/bridge/tc358768.c
>>>>>> @@ -794,8 +794,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>>>>>>     		val |= BIT(i + 1);
>>>>>>     	tc358768_write(priv, TC358768_HSTXVREGEN, val);
>>>>>>     
>>>>>> -	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
>>>>>> -		tc358768_write(priv, TC358768_TXOPTIONCNTRL, 0x1);
>>>>>> +	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
>>>>>> +		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
>>>>>>     
>>>>>>     	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>>>>>>     	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
>>>>>> @@ -861,11 +861,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>>>>>>     	tc358768_write(priv, TC358768_DSI_HACT, hact);
>>>>>>     
>>>>>>     	/* VSYNC polarity */
>>>>>> -	if (!(mode->flags & DRM_MODE_FLAG_NVSYNC))
>>>>>> -		tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5), BIT(5));
>>>>>> +	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5),
>>>>>> +			     (mode->flags & DRM_MODE_FLAG_PVSYNC) ? BIT(5) : 0);
>>>>>
>>>>> Was this the reverse before and should be:
>>>>> (mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : BIT(5)
>>>>
>>>> Bit 5 is 1 for active high vsync polarity. The test was previously
>>>> !nvsync, i.e. the same as pvsync.
>>>
>>> this statement doesn't seem to be true, since this change causes a
>>> regression on the Asus TF700T. Apparently, !nvsync is true and pvsync is
>>> false in the present case.
>>
>> panasonic_vvx10f004b00_mode in panel_simple.c doesn't seem to have mode
>> flags set. I would say that means the panel doesn't care about the sync
>> polarities (which obviously is not the case), but maybe there's an
>> assumption that if sync polarities are not set, the default is...
>> positive? But I can't find any mention about this.
>>
>> Does it work for you if you set the polarities in
>> panasonic_vvx10f004b00_mode?
> 
> The panel seems to work with either negative or positive H-/Vsync in
> conjunction with the attached patch from Thierry. Currently, the display
> controller is unconditionally programmed for positive H-/Vsync though.
> What should be done in this case?
> 
> BTW, the vendor kernel configures the display controller as well as the
> bridge for negative H-/Vsync.

Also regarding the tegra driver, with a quick look it indeed looks like 
it is configuring hardcoded sync polarities, which is not good. Maybe 
it's time to apply the patch from Thierry, dated 2015 =).

  Tomi

