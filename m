Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF59758B35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGSCNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGSCM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:12:59 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 926E2FC;
        Tue, 18 Jul 2023 19:12:57 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id CD47B60484988;
        Wed, 19 Jul 2023 10:12:47 +0800 (CST)
Message-ID: <40db9ac5-84b7-dc98-786c-2e651404534b@nfschina.com>
Date:   Wed, 19 Jul 2023 10:12:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/i915/tv: avoid possible division by zero
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        ville.syrjala@linux.intel.com, mripard@kernel.org,
        ankit.k.nautiyal@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <3c7dfc18-539f-2b0c-0c77-48b89ef96560@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/18 19:28, Andrzej Hajda wrote:
> On 18.07.2023 12:10, Su Hui wrote:
>> On 2023/7/18 13:39, Dan Carpenter wrote:
>>> On Mon, Jul 17, 2023 at 04:52:51PM +0200, Andrzej Hajda wrote:
>>>> On 17.07.2023 08:22, Su Hui wrote:
>>>>> Clang warning: drivers/gpu/drm/i915/display/intel_tv.c:
>>>>> line 991, column 22 Division by zero.
>>>>> Assuming tv_mode->oversample=1 and (!tv_mode->progressive)=1,
>>>>> then division by zero will happen.
>>>>>
>>>>> Fixes: 1bba5543e4fe ("drm/i915: Fix TV encoder clock computation")
>>>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>>>> ---
>>>>>    drivers/gpu/drm/i915/display/intel_tv.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c 
>>>>> b/drivers/gpu/drm/i915/display/intel_tv.c
>>>>> index 36b479b46b60..82b54af51f23 100644
>>>>> --- a/drivers/gpu/drm/i915/display/intel_tv.c
>>>>> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
>>>>> @@ -988,7 +988,8 @@ intel_tv_mode_to_mode(struct drm_display_mode 
>>>>> *mode,
>>>>>                  const struct tv_mode *tv_mode,
>>>>>                  int clock)
>>>>>    {
>>>>> -    mode->clock = clock / (tv_mode->oversample >> 
>>>>> !tv_mode->progressive);
>>>>> +    mode->clock = clock / (tv_mode->oversample != 1 ?
>>>>> +            tv_mode->oversample >> !tv_mode->progressive : 1);
>>>> Seems too smart to me, why not just:
>>>> mode->clock = clock / tv_mode->oversample;
>>>> if (!tv_mode->progressive)
>>>>      mode->clock <<= 1;
>>> This is nice.
>>
>> mode->clock = clock / tv_mode->oversample << !tv_mode->progressive;
>>
>> But I think this one is much better,  it has less code and run faster.
>> Should I resend v3 to add some explanation or follow Dan's advice?
>
> Speed gain here is irrelevant here, and disputable.
>
> One thing which could be problematic is that we could loose the least 
> significant bit in mode->clock,
> in case non-progressive, but I am not sure if it really matters, as 
> mode->clock is not precise value anyway.
> Alternatively we could 1st shift, then divide, but in this case 
> overflow can occur, at least in theory - I suspect there are no such 
> big clocks (in kHz).
>
> Finally I would agree with Dan, readability is better with conditional.
>
How about this one?

-       mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
+       mode->clock = clock;
+       if (tv_mode->oversample >> !tv_mode->progressive)
+               mode->clock /= tv_mode->oversample >> 1;

Prevent loss of accuracy and also make it more readable.
If it's OK, I will send v3 patch.

By the way, do we need to print some error messages or do some things  when
"tv_mode->oversample << !tv_mode->progressive" is zero? I'm not sure about
this.

Su Hui

> Regards
> Andrzej
