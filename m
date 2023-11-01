Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90B7DDF99
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjKAKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3BDA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698835239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXci9J0xD0tMPtjPi+KFGNzlE2tvEnYyGsbEz8laLLc=;
        b=DT3bqnwnF3/THMw5nh8A+Rd7DJ04FLdE6REB0+PgevBz/4ijV8wd3KDUNRvyXkB2jWmH97
        /TorFKq0BgSPz07AFJRoAbjj2GToCUNOemyPYLr33QKVq4f7gfsOPKqY+KvUrf0uhqN180
        NbhrfH/dttDejEUgEPclxfh7NLFpVXw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-bj8-N-xGN8WbdVaKSePGCQ-1; Wed, 01 Nov 2023 06:40:37 -0400
X-MC-Unique: bj8-N-xGN8WbdVaKSePGCQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53e26bbbc63so4845186a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698835236; x=1699440036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXci9J0xD0tMPtjPi+KFGNzlE2tvEnYyGsbEz8laLLc=;
        b=Xqnc8+aVszzYqrlP1fIoN1+Gz4NmRDCyyiicLKz9MAIiR8hafxGTwqsnJSZOfqZO/A
         pK3Mf9rKAGPkqZsLLnkAiMT6yC8XMoEnWtA8nfu5+PpvejKNZlTyyPsedkFDRK/ipclj
         LJAVim4OUJMzc0rHPzSlytWfiBTjZIFNlLle1ARTTZk46+HG83Bo+U/bebw++8vQ40mC
         GsboLwmCjnThOmIQS4HKCRS+fxyIrXcPjjQatOZp03MnhsYyUK8dovhmfKQfptHy64NK
         knyjWhWrFdnow5q1+/CW5qFO9ZB08AMWRdoNuXs/TwUp3/GyRQpAibA0XaZk20NM/gZ/
         1hgQ==
X-Gm-Message-State: AOJu0Yzoj3WTOnqwPot45M0Mm1dv8/d4PuoGQUOdUOrVCKI1KqkLJCGP
        ke6fowx2A1O+eIctTtx1nc5wcQX4lcwk9kjxdzc/CrPDOpFcCkd+EzhafCRc5m+F3UN5y2xNsb2
        W8+9dRrCSeCX2E4bg/OA6U1/k
X-Received: by 2002:a05:6402:3586:b0:538:a47:89d3 with SMTP id y6-20020a056402358600b005380a4789d3mr12770009edc.21.1698835236782;
        Wed, 01 Nov 2023 03:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwEzcZ5PbSGrv84q2mKqUSPtMNw0MIc+7X2PCfPIy0r+a45ZF7Ol+yi88FtHV2yNblOW6pWA==
X-Received: by 2002:a05:6402:3586:b0:538:a47:89d3 with SMTP id y6-20020a056402358600b005380a4789d3mr12769999edc.21.1698835236475;
        Wed, 01 Nov 2023 03:40:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v28-20020a50d09c000000b005434e3d8e7bsm930845edd.1.2023.11.01.03.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 03:40:35 -0700 (PDT)
Message-ID: <e3d6da15-8d54-fa63-5fcc-79617310244e@redhat.com>
Date:   Wed, 1 Nov 2023 11:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-gfx] [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV
 GPIOs behind the driver's back
Content-Language: en-US, nl
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
 <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
 <ZUIbPtEEbl6pjdqg@smile.fi.intel.com>
 <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
 <ZUIpmhYlqMXroHfV@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZUIpmhYlqMXroHfV@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/23 11:34, Ville Syrjälä wrote:
> On Wed, Nov 01, 2023 at 11:20:23AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/1/23 10:32, Andy Shevchenko wrote:
>>> On Tue, Oct 31, 2023 at 10:15:52PM +0100, Hans de Goede wrote:
>>>> On 10/31/23 17:07, Hans de Goede wrote:
>>>>> On 10/24/23 18:11, Andy Shevchenko wrote:
>>>>>> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
>>>
>>> ...
>>>
>>>>> As for the CHT support, I have not added that to my tree yet, I would
>>>>> prefer to directly test the correct/fixed patch.
>>>>
>>>> And I hit the "jackpot" on the first device I tried and the code needed
>>>> some fixing to actually work, so here is something to fold into v3 to
>>>> fix things:
>>>
>>> Thanks!
>>>
>>> But let me first send current v3 as it quite differs to v2 in the sense
>>> of how I do instantiate GPIO lookup tables.
>>
>> The problem is there already is a GPIO lookup table registered for
>> the "0000:00:02.0" device by intel_dsi_vbt_gpio_init() and there can
>> be only be one GPIO lookup table per device. So no matter how you
>> instantiate GPIO lookup tables it will not work.
>>
>> The solution that I chose is to not instantiate a GPIO lookup table
>> at all and instead to extend the existing table with an extra entry.
>>
>> Although thinking more about it I must admit that this is racy.
>>
>> So a better idea would be to unregister the GPIO lookup
>> table registered by intel_dsi_vbt_gpio_init() after getting
>> the GPIOs there, that would allow instantiating a new one
>> from soc_exec_opaque_gpio() as it currently does and that
>> would be race free.
> 
> The proper solution would likely be be to pre-parse the sequences
> to determine which GPIOs are actually needed. That would also get
> rid of the bxt_gpio_table[] eyesore.

Interesting suggestion. Note that intel_dsi_vbt_gpio_init() arm
only runs on byt and cht though, so that is something to keep
in mind.

Regards,

Hans

