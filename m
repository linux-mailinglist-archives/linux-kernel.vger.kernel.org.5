Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99F7D9AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346056AbjJ0OLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjJ0OLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:11:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28633194;
        Fri, 27 Oct 2023 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698415898; x=1729951898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F1oYnUoZzwVSCUOBDhckDQC+q1Fm0eZRJN/xfvsc2I8=;
  b=GDIBeb1ZovcXmAj8shZEtPK/5Q7jdvvaJYFPrhbM7rQjS29Qc+R+G9q6
   trg0z69HCooIGlwWbWm/tkFBvictVCL3SLOl9HTIp7FvtolFeGn91rVQR
   zUn25R2kkH1q2yTGBMXHtHXVQRAHqOYr97kEczWLHDGZLIheyDCN+w+8w
   kOqv6EYSbAkQJDB421KDKwes9eMEQT1Ky6cfyUPREOG8ozXH/mUWy+5/h
   2AxB68UXUcLBxuFBQL4Bj8RI5Uzm57ESH/pRrx6ObSFkdLmuNZU4JJjo3
   9tomjRRXig/y0N51oL0u2Dj/jxbB09nlJDDfcGFhekOh5TspUB5htWeLO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391652793"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391652793"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="753135193"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="753135193"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.18.37]) ([10.213.18.37])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:11:33 -0700
Message-ID: <1e844f00-fc16-4788-8d90-ebe115eb9313@intel.com>
Date:   Fri, 27 Oct 2023 16:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i915/perf: Fix NULL deref bugs with drm_dbg() calls
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
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
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20231027140729.2505993-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.10.2023 16:07, Harshit Mogalapalli wrote:
> When i915 perf interface is not available dereferencing it will lead to
> NULL dereferences.
>
> Fix this by using DRM_DEBUG() which the scenario before the commit in
> the Fixes tag.
>
> Fixes: 2fec539112e8 ("i915/perf: Replace DRM_DEBUG with driver specific drm_dbg call")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>


Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
> This is found using smatch(static analysis tool), only compile tested.
> ---
>   drivers/gpu/drm/i915/i915_perf.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 2f3ecd7d4804..bb48c96b7950 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4228,8 +4228,7 @@ int i915_perf_open_ioctl(struct drm_device *dev, void *data,
>   	int ret;
>   
>   	if (!perf->i915) {
> -		drm_dbg(&perf->i915->drm,
> -			"i915 perf interface not available for this system\n");
> +		DRM_DEBUG("i915 perf interface not available for this system\n");
>   		return -ENOTSUPP;
>   	}
>   
> @@ -4608,8 +4607,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
>   	int err, id;
>   
>   	if (!perf->i915) {
> -		drm_dbg(&perf->i915->drm,
> -			"i915 perf interface not available for this system\n");
> +		DRM_DEBUG("i915 perf interface not available for this system\n");
>   		return -ENOTSUPP;
>   	}
>   
> @@ -4774,8 +4772,7 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
>   	int ret;
>   
>   	if (!perf->i915) {
> -		drm_dbg(&perf->i915->drm,
> -			"i915 perf interface not available for this system\n");
> +		DRM_DEBUG("i915 perf interface not available for this system\n");
>   		return -ENOTSUPP;
>   	}
>   

