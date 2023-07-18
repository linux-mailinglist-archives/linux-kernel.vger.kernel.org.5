Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DED757905
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGRKLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjGRKKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:10:53 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 226561703;
        Tue, 18 Jul 2023 03:10:48 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 6C27B60D1198C;
        Tue, 18 Jul 2023 18:10:45 +0800 (CST)
Message-ID: <8e3e945b-9cae-71e9-fc68-dc1c64e5ea86@nfschina.com>
Date:   Tue, 18 Jul 2023 18:10:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/i915/tv: avoid possible division by zero
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        ville.syrjala@linux.intel.com, mripard@kernel.org,
        ankit.k.nautiyal@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <d763816b-07c9-4346-8f7c-f95e86cba488@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/18 13:39, Dan Carpenter wrote:
> On Mon, Jul 17, 2023 at 04:52:51PM +0200, Andrzej Hajda wrote:
>>
>> On 17.07.2023 08:22, Su Hui wrote:
>>> Clang warning: drivers/gpu/drm/i915/display/intel_tv.c:
>>> line 991, column 22 Division by zero.
>>> Assuming tv_mode->oversample=1 and (!tv_mode->progressive)=1,
>>> then division by zero will happen.
>>>
>>> Fixes: 1bba5543e4fe ("drm/i915: Fix TV encoder clock computation")
>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>> ---
>>>    drivers/gpu/drm/i915/display/intel_tv.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
>>> index 36b479b46b60..82b54af51f23 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_tv.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
>>> @@ -988,7 +988,8 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
>>>    		      const struct tv_mode *tv_mode,
>>>    		      int clock)
>>>    {
>>> -	mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
>>> +	mode->clock = clock / (tv_mode->oversample != 1 ?
>>> +			tv_mode->oversample >> !tv_mode->progressive : 1);
>> Seems too smart to me, why not just:
>> mode->clock = clock / tv_mode->oversample;
>> if (!tv_mode->progressive)
>>      mode->clock <<= 1;
> This is nice.

mode->clock = clock / tv_mode->oversample << !tv_mode->progressive;

But I think this one is much better,  it has less code and run faster.
Should I resend v3 to add some explanation or follow Dan's advice?

Su Hui

> regards,
> dan carpenter
