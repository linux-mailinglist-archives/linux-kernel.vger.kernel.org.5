Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4BB766660
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjG1IHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjG1IGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:06:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A311BD6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690531581; x=1722067581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x2rUUtziHP5HRkIPgMEOOTCdi1SsP+tT2Q4VyJcV8z0=;
  b=IorFuCtNiq0wOEbjNbY1cu+tPROb9kV2cVPyBozPElzh/zuPszzrj4le
   RJErllgh44eQwIDBHztg/gcbTYObaHe/AwHKFLvfrfYFK/GtWwgCnqL8D
   oVpfqSnX0LTFHlYdl/FfvW1kXqTvWA7icS6C7lQvFfWE/7WqENcI3y1ok
   Mqc/WXg8fk6xerwcWOvNeBcHUMV/mn+q2zpvuyE87irAL3loY0nZ8Lh0f
   cM1VdVpNe8t7ZO7vOgYpjT+0xOJt4crOYgq6uzxCpit4t5FevmqMgHuQi
   k8/C7t0Ydf5FpRXhzyCM2mj6jezDaK8Wri1iFY0ZP8p/PPct/IiCTc1RH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348138328"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348138328"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727384080"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="727384080"
Received: from atoomey-mobl.amr.corp.intel.com (HELO [10.213.197.30]) ([10.213.197.30])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:06:17 -0700
Message-ID: <54b820a4-8e8b-26a2-1b65-eaaa43f8b92d@linux.intel.com>
Date:   Fri, 28 Jul 2023 09:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/i915/gem: Add check for bitmap_zalloc()
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@gmail.com, daniel@ffwll.ch, robdclark@chromium.org,
        lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
        chris@chris-wilson.co.uk
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230728015846.20228-1-jiasheng@iscas.ac.cn>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230728015846.20228-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 28/07/2023 02:58, Jiasheng Jiang wrote:
> Add the check for the return value of bitmap_zalloc() in order to
> guarantee the success of the allocation.
> 
> Fixes: e9b73c67390a ("drm/i915: Reduce memory pressure during shrinker by preallocating swizzle pages")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_tiling.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> index a049ca0b7980..e9cf99d95966 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
> @@ -311,6 +311,11 @@ i915_gem_object_set_tiling(struct drm_i915_gem_object *obj,
>   		if (!obj->bit_17) {
>   			obj->bit_17 = bitmap_zalloc(obj->base.size >> PAGE_SHIFT,
>   						    GFP_KERNEL);
> +			if (!obj->bit_17) {
> +				i915_gem_object_unlock(obj);
> +				i915_gem_object_release_mmap_gtt(obj);
> +				return -ENOMEM;
> +			}

Hm the comment few lines above says:

	/* Try to preallocate memory required to save swizzling on put-pages */

Lets emphasis the *try* for now. Then once the obj->bit_17 is attempted to be used we have this:

i915_gem_object_save_bit_17_swizzle(..)
{
...
	if (obj->bit_17 == NULL) {
		obj->bit_17 = bitmap_zalloc(page_count, GFP_KERNEL);
		if (obj->bit_17 == NULL) {
			drm_err(obj->base.dev,
				"Failed to allocate memory for bit 17 record\n");
			return;
		}
	}

So despite this area of the driver being a bit before my time, I'd say it quite possibly works as designed - only *tries* to preallocate but does not have to and can cope with a later failure.

Good question might be why wouldn't it be better to do what you suggest. Trade off would be between failing the ioctl and possibly crashing the application, versus visual corruption if at use time allocation fails.

The whole swizzling thing also only applies to old GPUs, stuff before Broadwell, which itself was released in 2014. So it is tempting to err on the side of caution and leave it as is. I'll mull it over in the background, or maybe someone else will have an opinion too.

Regards,

Tvrtko

>   		}
>   	} else {
>   		bitmap_free(obj->bit_17);
