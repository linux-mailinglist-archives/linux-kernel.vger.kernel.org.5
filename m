Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBA7D826E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344891AbjJZMSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJZMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:18:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6ED1AE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698322727; x=1729858727;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WhTiCYyZcaMi9T72mL68Bxhk4qs+XbYizDsbg8rk2pk=;
  b=he8nOJhcCktLoIUiYUp+Tpw5KSua6n3+NuVRN0sD7/iJeiL1AVySDBdr
   2qV7ZfbOeu7hbUoAJxhAPk5Kc0nQhZtfgsN4tp3jKyLfOtqNo6P8dcM9X
   zFM95H/Qz9F2wpYnAQzvn5iRNSUNDknWDTFmSUuRMrqBmjZWhCAr/DaEH
   nOIlxlfyiE9eXhEAdnfiKLRqN4iBHY9Ai7SPcLT2FPBPK/Ycv0Vz5QVAv
   L2/j1VydH3zgGh6GYtCO2pjfjtWA87c2FxwpZyk34Y1rLwDqvRooTS188
   luEyQCzHdjII4TjBmY5yUun8JudCJKu1cnYi6pudsca+g3lsmpimLVH5/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9083936"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9083936"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="709055919"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="709055919"
Received: from tzirr-desk2.ger.corp.intel.com (HELO localhost) ([10.252.49.68])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:18:42 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Badal Nilawar <badal.nilawar@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/mtl: avoid stringop-overflow warning
In-Reply-To: <87edhlbj16.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231016201012.1022812-1-arnd@kernel.org>
 <87edhlbj16.fsf@intel.com>
Date:   Thu, 26 Oct 2023 15:18:39 +0300
Message-ID: <87wmv97f1c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 16 Oct 2023, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The newly added memset() causes a warning for some reason I could not figure out:
>>
>> In file included from arch/x86/include/asm/string.h:3,
>>                  from drivers/gpu/drm/i915/gt/intel_rc6.c:6:
>> In function 'rc6_res_reg_init',
>>     inlined from 'intel_rc6_init' at drivers/gpu/drm/i915/gt/intel_rc6.c:610:2:
>> arch/x86/include/asm/string_32.h:195:29: error: '__builtin_memset' writing 16 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]
>>   195 | #define memset(s, c, count) __builtin_memset(s, c, count)
>>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/gt/intel_rc6.c:584:9: note: in expansion of macro 'memset'
>>   584 |         memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
>>       |         ^~~~~~
>> In function 'intel_rc6_init':
>>
>> Change it to an normal initializer and an added memcpy() that does not have
>> this problem.
>>
>> Fixes: 4bb9ca7ee0745 ("drm/i915/mtl: C6 residency and C state type for MTL SAMedia")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/i915/gt/intel_rc6.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/intel_rc6.c b/drivers/gpu/drm/i915/gt/intel_rc6.c
>> index 8b67abd720be8..7090e4be29cb6 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_rc6.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_rc6.c
>> @@ -581,19 +581,23 @@ static void __intel_rc6_disable(struct intel_rc6 *rc6)
>>  
>>  static void rc6_res_reg_init(struct intel_rc6 *rc6)
>>  {
>> -	memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
>
> That's just bollocks. memset() is byte granularity, while
> INVALID_MMIO_REG.reg is u32. If the value was anything other than 0,
> this would break.
>
> And you're not supposed to look at the guts of i915_reg_t to begin with,
> that's why it's a typedef. Basically any code that accesses the members
> of i915_reg_t outside of its implementation are doing it wrong.
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks for the patch, pushed to drm-intel-gt-next.

BR,
Jani.

>
>
>> +	i915_reg_t res_reg[INTEL_RC6_RES_MAX] = {
>> +		[0 ... INTEL_RC6_RES_MAX - 1] = INVALID_MMIO_REG,
>> +	};
>>  
>>  	switch (rc6_to_gt(rc6)->type) {
>>  	case GT_MEDIA:
>> -		rc6->res_reg[INTEL_RC6_RES_RC6] = MTL_MEDIA_MC6;
>> +		res_reg[INTEL_RC6_RES_RC6] = MTL_MEDIA_MC6;
>>  		break;
>>  	default:
>> -		rc6->res_reg[INTEL_RC6_RES_RC6_LOCKED] = GEN6_GT_GFX_RC6_LOCKED;
>> -		rc6->res_reg[INTEL_RC6_RES_RC6] = GEN6_GT_GFX_RC6;
>> -		rc6->res_reg[INTEL_RC6_RES_RC6p] = GEN6_GT_GFX_RC6p;
>> -		rc6->res_reg[INTEL_RC6_RES_RC6pp] = GEN6_GT_GFX_RC6pp;
>> +		res_reg[INTEL_RC6_RES_RC6_LOCKED] = GEN6_GT_GFX_RC6_LOCKED;
>> +		res_reg[INTEL_RC6_RES_RC6] = GEN6_GT_GFX_RC6;
>> +		res_reg[INTEL_RC6_RES_RC6p] = GEN6_GT_GFX_RC6p;
>> +		res_reg[INTEL_RC6_RES_RC6pp] = GEN6_GT_GFX_RC6pp;
>>  		break;
>>  	}
>> +
>> +	memcpy(rc6->res_reg, res_reg, sizeof(res_reg));
>>  }
>>  
>>  void intel_rc6_init(struct intel_rc6 *rc6)

-- 
Jani Nikula, Intel
