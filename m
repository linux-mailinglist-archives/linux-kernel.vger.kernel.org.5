Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BC4757144
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGRBNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGRBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:13:17 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D906BF0;
        Mon, 17 Jul 2023 18:13:15 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id B112C6085E131;
        Tue, 18 Jul 2023 09:13:11 +0800 (CST)
Message-ID: <8a94e6dc-f664-84fa-32f7-7f45f22a410a@nfschina.com>
Date:   Tue, 18 Jul 2023 09:13:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/i915/tv: avoid possible division by zero
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     ville.syrjala@linux.intel.com, mripard@kernel.org,
        ankit.k.nautiyal@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <0cae35ea-7635-383d-cae5-2051abbc6d64@intel.com>
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

On 2023/7/17 22:52, Andrzej Hajda wrote:
>
>
> On 17.07.2023 08:22, Su Hui wrote:
>> Clang warning: drivers/gpu/drm/i915/display/intel_tv.c:
>> line 991, column 22 Division by zero.
>> Assuming tv_mode->oversample=1 and (!tv_mode->progressive)=1,
>> then division by zero will happen.
>>
>> Fixes: 1bba5543e4fe ("drm/i915: Fix TV encoder clock computation")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/i915/display/intel_tv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c 
>> b/drivers/gpu/drm/i915/display/intel_tv.c
>> index 36b479b46b60..82b54af51f23 100644
>> --- a/drivers/gpu/drm/i915/display/intel_tv.c
>> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
>> @@ -988,7 +988,8 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
>>                 const struct tv_mode *tv_mode,
>>                 int clock)
>>   {
>> -    mode->clock = clock / (tv_mode->oversample >> 
>> !tv_mode->progressive);
>> +    mode->clock = clock / (tv_mode->oversample != 1 ?
>> +            tv_mode->oversample >> !tv_mode->progressive : 1);
>
> Seems too smart to me, why not just:
> mode->clock = clock / tv_mode->oversample;
> if (!tv_mode->progressive)
>     mode->clock <<= 1;
> Or trying being smart:
> mode->clock = clock / tv_mode->oversample << !tv_mode->progressive;

Hi,

Yes, this is more readable and clear.
Thanks four your advice. I will send v2 soon.

Su Hui

>
> Btw in both cases there is assumption tv_mode->oversample != 0, I 
> guess it is true.
>
> Regards
> Andrzej
>
>>         /*
>>        * tv_mode horizontal timings:
>
