Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E987B070A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjI0OhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjI0OhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:37:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4AF9;
        Wed, 27 Sep 2023 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695825423; x=1727361423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vq86wg25E1S0QDmaQFQmXhGozSKSAKKVSmU2/hjQZnw=;
  b=EDRa8Fyi39v2aVcpVcJkvLecle32wJcdIBVTDPmHrBcJYI0tonOqtmiQ
   BFvRBBPhSH1j5ES17/kKibQEArllIcxxteCGHi2ruOetsTXzPPRqsv7Fk
   10dstYOaz2B7+DAKIiyEtN6ORmtHwPOaStK4tgTrHfSrXqOTloZfK7eYa
   7tmGortpqIXp5HQzZGLhCq3QwlU0ZpTEVBAcNY0woZjeJxS0aPIAlBu4I
   +QwUs2Yl1ozB0rXkpmcf8p6Jh+WrFKkMaziBrfcpLjzMtqpPVeXOXaGvT
   15c1TeLHxyc4rNGnHVsbpX54NALz8r1Jaep9Mfyy36jiZn2eQurSZ8SQA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="372181180"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="372181180"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 07:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="1080191656"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="1080191656"
Received: from mscanex-mobl.ger.corp.intel.com (HELO [10.213.204.17]) ([10.213.204.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 07:36:57 -0700
Message-ID: <eeff4966-8a93-c2c9-5ec3-5b1f71cd1ad9@linux.intel.com>
Date:   Wed, 27 Sep 2023 15:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/6] drm/drm_file: Add DRM obj's RSS reporting function
 for fdinfo
Content-Language: en-US
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com, freedreno@lists.freedesktop.org
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
 <20230919233556.1458793-5-adrian.larumbe@collabora.com>
 <495203cd-d85e-2c00-4fa9-81879a882441@linux.intel.com>
 <fs3u3b62vhixqpuoa5c4dwckew3l4etvps4zhlgeuwle6o2as2@tsgwsil4s35k>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <fs3u3b62vhixqpuoa5c4dwckew3l4etvps4zhlgeuwle6o2as2@tsgwsil4s35k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/09/2023 11:58, Adrián Larumbe wrote:
> On 20.09.2023 16:53, Tvrtko Ursulin wrote:
>>
>> On 20/09/2023 00:34, Adrián Larumbe wrote:
>>> Some BO's might be mapped onto physical memory chunkwise and on demand,
>>> like Panfrost's tiler heap. In this case, even though the
>>> drm_gem_shmem_object page array might already be allocated, only a very
>>> small fraction of the BO is currently backed by system memory, but
>>> drm_show_memory_stats will then proceed to add its entire virtual size to
>>> the file's total resident size regardless.
>>>
>>> This led to very unrealistic RSS sizes being reckoned for Panfrost, where
>>> said tiler heap buffer is initially allocated with a virtual size of 128
>>> MiB, but only a small part of it will eventually be backed by system memory
>>> after successive GPU page faults.
>>>
>>> Provide a new DRM object generic function that would allow drivers to
>>> return a more accurate RSS size for their BOs.
>>>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Reviewed-by: Steven Price <steven.price@arm.com>
>>> ---
>>>    drivers/gpu/drm/drm_file.c | 5 ++++-
>>>    include/drm/drm_gem.h      | 9 +++++++++
>>>    2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>>> index 883d83bc0e3d..762965e3d503 100644
>>> --- a/drivers/gpu/drm/drm_file.c
>>> +++ b/drivers/gpu/drm/drm_file.c
>>> @@ -944,7 +944,10 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>>>    		}
>>>    		if (s & DRM_GEM_OBJECT_RESIDENT) {
>>> -			status.resident += obj->size;
>>> +			if (obj->funcs && obj->funcs->rss)
>>> +				status.resident += obj->funcs->rss(obj);
>>> +			else
>>> +				status.resident += obj->size;
>>
>> Presumably you'd want the same smaller size in both active and purgeable? Or
>> you can end up with more in those two than in rss which would look odd.
> 
> I didn't think of this. I guess when an object is both resident and purgeable,
> then its RSS and purgeable sizes should be the same.
> 
>> Also, alternative to adding a new callback could be adding multiple output
>> parameters to the existing obj->func->status() which maybe ends up simpler due
>> fewer callbacks?
>>
>> Like:
>>
>> s = obj->funcs->status(obj, &supported_status, &rss)
>>
>> And adjust the code flow to pick up the rss if driver signaled it supports
>> reporting it.
> 
> I personally find having a separate object callback more readable in this case.
> There's also the question of what output parameter value would be used as a token
> that the relevant BO doesn't have an RSS different from its virtual
> size. I guess '0' would be alright, but this is on the assumption that this
> could never be a legitimate BO virtual size across all DRM drivers. I guess
> most of them round the size up to the nearest page multiple at BO creation
> time.

Okay. See how it will look once you need to apply it to resident and 
purgeable. I wonder if "driver knows better" will end up a dominant case 
and we do end up considering reversing the scheme (like ask the driver 
to fill in the meminfo record). TBH I do not remember all the flavours 
both Rob and I proposed at this point.

Regards,

Tvrtko

> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>    		} else {
>>>    			/* If already purged or not yet backed by pages, don't
>>>    			 * count it as purgeable:
>>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>> index bc9f6aa2f3fe..16364487fde9 100644
>>> --- a/include/drm/drm_gem.h
>>> +++ b/include/drm/drm_gem.h
>>> @@ -208,6 +208,15 @@ struct drm_gem_object_funcs {
>>>    	 */
>>>    	enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
>>> +	/**
>>> +	 * @rss:
>>> +	 *
>>> +	 * Return resident size of the object in physical memory.
>>> +	 *
>>> +	 * Called by drm_show_memory_stats().
>>> +	 */
>>> +	size_t (*rss)(struct drm_gem_object *obj);
>>> +
>>>    	/**
>>>    	 * @vm_ops:
>>>    	 *
