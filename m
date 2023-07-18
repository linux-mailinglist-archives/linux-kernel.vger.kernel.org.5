Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C493757A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGRL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGRL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:28:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28048E75;
        Tue, 18 Jul 2023 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689679729; x=1721215729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eG9i8FoJlSyTJM2sgpvziVRwaPmDaVtbaL3UEyeheKw=;
  b=e19dbwZv+EPy5/QVk7l2OM+OugGEdf17yR54Q4N7pVX+S2Fts2fXkmeh
   +qdb/WnCENniETqVe1EK3QtewJDcP/uGiRaZ1SDVClHFpX5RkdW7bIWvk
   sF0yQKV0kE32ED6mtBnpMIFho8eQLKBRd2RZIR9F0xrzoXZOI4WWnfPkN
   LozWjQCRr5/c88Ywef0eExV56w9Klay/XDTSs612B0Cgcieqh5Ek4oHr5
   f4GOg4dOPFlBrUe1grqKwVLaCOJDMRaxcsTDVDrzcm6Ob9JttKTkaGSt6
   OEuf0p1t/ehzvbvlKeYc3L7MsddZoLgiuVjUV95utvQSEtSQXfHOOrG3i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368821003"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368821003"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 04:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="813719404"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="813719404"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.19.167]) ([10.213.19.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 04:28:42 -0700
Message-ID: <3c7dfc18-539f-2b0c-0c77-48b89ef96560@intel.com>
Date:   Tue, 18 Jul 2023 13:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/i915/tv: avoid possible division by zero
Content-Language: en-US
To:     Su Hui <suhui@nfschina.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        ville.syrjala@linux.intel.com, mripard@kernel.org,
        ankit.k.nautiyal@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
References: <8e3e945b-9cae-71e9-fc68-dc1c64e5ea86@nfschina.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <8e3e945b-9cae-71e9-fc68-dc1c64e5ea86@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.07.2023 12:10, Su Hui wrote:
> On 2023/7/18 13:39, Dan Carpenter wrote:
>> On Mon, Jul 17, 2023 at 04:52:51PM +0200, Andrzej Hajda wrote:
>>>
>>> On 17.07.2023 08:22, Su Hui wrote:
>>>> Clang warning: drivers/gpu/drm/i915/display/intel_tv.c:
>>>> line 991, column 22 Division by zero.
>>>> Assuming tv_mode->oversample=1 and (!tv_mode->progressive)=1,
>>>> then division by zero will happen.
>>>>
>>>> Fixes: 1bba5543e4fe ("drm/i915: Fix TV encoder clock computation")
>>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>>> ---
>>>>    drivers/gpu/drm/i915/display/intel_tv.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c 
>>>> b/drivers/gpu/drm/i915/display/intel_tv.c
>>>> index 36b479b46b60..82b54af51f23 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_tv.c
>>>> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
>>>> @@ -988,7 +988,8 @@ intel_tv_mode_to_mode(struct drm_display_mode 
>>>> *mode,
>>>>                  const struct tv_mode *tv_mode,
>>>>                  int clock)
>>>>    {
>>>> -    mode->clock = clock / (tv_mode->oversample >> 
>>>> !tv_mode->progressive);
>>>> +    mode->clock = clock / (tv_mode->oversample != 1 ?
>>>> +            tv_mode->oversample >> !tv_mode->progressive : 1);
>>> Seems too smart to me, why not just:
>>> mode->clock = clock / tv_mode->oversample;
>>> if (!tv_mode->progressive)
>>>      mode->clock <<= 1;
>> This is nice.
>
> mode->clock = clock / tv_mode->oversample << !tv_mode->progressive;
>
> But I think this one is much better,  it has less code and run faster.
> Should I resend v3 to add some explanation or follow Dan's advice?

Speed gain here is irrelevant here, and disputable.

One thing which could be problematic is that we could loose the least 
significant bit in mode->clock,
in case non-progressive, but I am not sure if it really matters, as 
mode->clock is not precise value anyway.
Alternatively we could 1st shift, then divide, but in this case overflow 
can occur, at least in theory - I suspect there are no such big clocks 
(in kHz).

Finally I would agree with Dan, readability is better with conditional.

Regards
Andrzej

>
> Su Hui
>
>> regards,
>> dan carpenter

