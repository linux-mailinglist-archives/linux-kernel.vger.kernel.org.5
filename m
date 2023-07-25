Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1472A7606FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGYEHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGYEHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:07:10 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7CA1FA3;
        Mon, 24 Jul 2023 21:07:08 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 2F9D46031EAE1;
        Tue, 25 Jul 2023 12:06:51 +0800 (CST)
Message-ID: <352f7c10-3592-4a18-abdc-ab554a992d10@nfschina.com>
Date:   Tue, 25 Jul 2023 12:06:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/tv: avoid possible division by
 zero
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, andrzej.hajda@intel.com,
        intel-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mripard@kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <ZL62X3/CnsJcWWU4@ashyti-mobl2.lan>
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

On 2023/7/25 01:35, Andi Shyti wrote:
> On Tue, Jul 18, 2023 at 09:32:17AM +0800, Su Hui wrote:
>> Clang warning: drivers/gpu/drm/i915/display/intel_tv.c:
>> line 991, column 22 Division by zero.
>> Assuming tv_mode->oversample=1 and (!tv_mode->progressive)=1,
>> then division by zero will happen.
>>
>> Fixes: 1bba5543e4fe ("drm/i915: Fix TV encoder clock computation")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/i915/display/intel_tv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
>> index 36b479b46b60..f59553f7c132 100644
>> --- a/drivers/gpu/drm/i915/display/intel_tv.c
>> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
>> @@ -988,7 +988,7 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
>>   		      const struct tv_mode *tv_mode,
>>   		      int clock)
>>   {
>> -	mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
>> +	mode->clock = clock / tv_mode->oversample << !tv_mode->progressive;
> but this does not provide the same value. Try with:
>
> 	8 / (2 >> 1)
>
> and
>
> 	8 / 2 << 1
>
> They are definitely different.
>
> The real check could be:
>
> 	if (!(tv_mode->oversample >> 1))
> 		return ...
>
> But first I would check if that's actually possible.

Oh, I have a v3 patch, like this:

-       mode->clock = clock / (tv_mode->oversample >> 
!tv_mode->progressive);
+       mode->clock = clock;
+       if (tv_mode->oversample >> !tv_mode->progressive)
+               mode->clock /= tv_mode->oversample >> 1;

But I'm not sure does it need to print some error messages or do some 
things  when
"tv_mode->oversample << !tv_mode->progressive" is zero?
If all right , I will send this v3 patch.

Su Hui

> Andi
