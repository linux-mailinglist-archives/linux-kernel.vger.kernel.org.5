Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13CF7D9C08
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbjJ0Orx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbjJ0Orv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:47:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693DBC4;
        Fri, 27 Oct 2023 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698418069; x=1729954069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y4P9Bqeterqdl3jqcGwjUkIBi2NtNxgmJccLiuc5rHI=;
  b=gDBeQykvwtLguwvkT2t+ruVqzLo5Gcnc0ABQf+q453K1G3fJifhiRPmy
   tsEdZc95wM9YXJXypJaSkrf45Wri94oPoum+0Yy8n9Yk5QN4YCbc3mwPJ
   QPq25MYni9kjOtfHudNWJL3ulrtD4Jy333fg/eHCL89RENI6PTUm1Zbm/
   yTdxz9NoqKGi3ZbWulCw1iifmGVUg1at8idHHskLmLIFDLtpJ9r0HefpH
   sR8TWAjNk/aLQCZsvmyHBtJReXP/4M4cez3DdxsfYCrY3aB4cvuKUDQ/B
   pw66lm25C7ubjCegCt7lcovYVd1rePVhhbVX4E+hnK/iyTzqLT70+lpMh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="384990201"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="384990201"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="1090946608"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="1090946608"
Received: from dhanlon-mobl1.ger.corp.intel.com (HELO [10.213.221.114]) ([10.213.221.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:47:45 -0700
Message-ID: <4d850f3c-c199-470f-b83e-00bd9fddbd7a@linux.intel.com>
Date:   Fri, 27 Oct 2023 15:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i915/perf: Fix NULL deref bugs with drm_dbg() calls
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20231027140729.2505993-1-harshit.m.mogalapalli@oracle.com>
 <1e844f00-fc16-4788-8d90-ebe115eb9313@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <1e844f00-fc16-4788-8d90-ebe115eb9313@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/2023 15:11, Andrzej Hajda wrote:
> On 27.10.2023 16:07, Harshit Mogalapalli wrote:
>> When i915 perf interface is not available dereferencing it will lead to
>> NULL dereferences.
>>
>> Fix this by using DRM_DEBUG() which the scenario before the commit in
>> the Fixes tag.
>>
>> Fixes: 2fec539112e8 ("i915/perf: Replace DRM_DEBUG with driver 
>> specific drm_dbg call")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> 
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Please hold off merging.

>> ---
>> This is found using smatch(static analysis tool), only compile tested.
>> ---
>>   drivers/gpu/drm/i915/i915_perf.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_perf.c 
>> b/drivers/gpu/drm/i915/i915_perf.c
>> index 2f3ecd7d4804..bb48c96b7950 100644
>> --- a/drivers/gpu/drm/i915/i915_perf.c
>> +++ b/drivers/gpu/drm/i915/i915_perf.c
>> @@ -4228,8 +4228,7 @@ int i915_perf_open_ioctl(struct drm_device *dev, 
>> void *data,
>>       int ret;
>>       if (!perf->i915) {
>> -        drm_dbg(&perf->i915->drm,
>> -            "i915 perf interface not available for this system\n");
>> +        DRM_DEBUG("i915 perf interface not available for this 
>> system\n");

What's that struct drm_device *dev function argument a few lines up? :)

Although TBH all these these could just be removed since I doubt they 
are adding any value and ENOTSUPP is pretty clear.

Regards,

Tvrtko

>>           return -ENOTSUPP;
>>       }
>> @@ -4608,8 +4607,7 @@ int i915_perf_add_config_ioctl(struct drm_device 
>> *dev, void *data,
>>       int err, id;
>>       if (!perf->i915) {
>> -        drm_dbg(&perf->i915->drm,
>> -            "i915 perf interface not available for this system\n");
>> +        DRM_DEBUG("i915 perf interface not available for this 
>> system\n");
>>           return -ENOTSUPP;
>>       }
>> @@ -4774,8 +4772,7 @@ int i915_perf_remove_config_ioctl(struct 
>> drm_device *dev, void *data,
>>       int ret;
>>       if (!perf->i915) {
>> -        drm_dbg(&perf->i915->drm,
>> -            "i915 perf interface not available for this system\n");
>> +        DRM_DEBUG("i915 perf interface not available for this 
>> system\n");
>>           return -ENOTSUPP;
>>       }
> 
