Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D137D9EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjJ0Rib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0Ri3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:38:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E506C4;
        Fri, 27 Oct 2023 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698428307; x=1729964307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5JgsC4GZg9gDVZXuMx2csQQc1LKj5KoYBp4nu6PMc0Y=;
  b=nVb2zhiofYSM3SoUkKgkuGwk8TFcj/zWQIl+GoN1sL61IDNgEMByU3DC
   JCVQFum45txgLEYz3C58p52D2l1kbklSZhq9DlTAoKVXJ1f/TKbyNlBto
   2cIVdDAzrVdkgAV2gM7xFqRZF900qlVqpPvqBN22Uu+7R/c7N9k8hZFQS
   1C3REoO8w5rByJQwKP74m0WGMaD+bcwzRmmJPcAcIGsYXmDF/1oWiqKX3
   RWJwDcZgm/6ilzKsY4xssLhibd7hqRHDywtSdZq2NcPDqjPZOernXP4fu
   QQImOLEV7XF1SpbOYSiSj7sWAint7cfy/QCYSci8FRKaqv+RTaTO3C/40
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="378188582"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="378188582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="788862211"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="788862211"
Received: from dhanlon-mobl1.ger.corp.intel.com (HELO [10.213.221.114]) ([10.213.221.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:38:23 -0700
Message-ID: <29c2bf2b-82b1-457d-ba42-29b0b30ecf32@linux.intel.com>
Date:   Fri, 27 Oct 2023 18:38:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i915/perf: Fix NULL deref bugs with drm_dbg() calls
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
References: <20231027172822.2753059-1-harshit.m.mogalapalli@oracle.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20231027172822.2753059-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/2023 18:28, Harshit Mogalapalli wrote:
> When i915 perf interface is not available dereferencing it will lead to
> NULL dereferences.
> 
> As returning -ENOTSUPP is pretty clear return when perf interface is not
> available.
> 
> Fixes: 2fec539112e8 ("i915/perf: Replace DRM_DEBUG with driver specific drm_dbg call")
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> v1 --> v2: Remove the debug calls as they don't add much value and
> -ENOTSUPP is a good enough return value.
> ---
>   drivers/gpu/drm/i915/i915_perf.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 2f3ecd7d4804..7b1c8de2f9cb 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4227,11 +4227,8 @@ int i915_perf_open_ioctl(struct drm_device *dev, void *data,
>   	u32 known_open_flags;
>   	int ret;
>   
> -	if (!perf->i915) {
> -		drm_dbg(&perf->i915->drm,
> -			"i915 perf interface not available for this system\n");
> +	if (!perf->i915)
>   		return -ENOTSUPP;
> -	}
>   
>   	known_open_flags = I915_PERF_FLAG_FD_CLOEXEC |
>   			   I915_PERF_FLAG_FD_NONBLOCK |
> @@ -4607,11 +4604,8 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
>   	struct i915_oa_reg *regs;
>   	int err, id;
>   
> -	if (!perf->i915) {
> -		drm_dbg(&perf->i915->drm,
> -			"i915 perf interface not available for this system\n");
> +	if (!perf->i915)
>   		return -ENOTSUPP;
> -	}
>   
>   	if (!perf->metrics_kobj) {
>   		drm_dbg(&perf->i915->drm,
> @@ -4773,11 +4767,8 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
>   	struct i915_oa_config *oa_config;
>   	int ret;
>   
> -	if (!perf->i915) {
> -		drm_dbg(&perf->i915->drm,
> -			"i915 perf interface not available for this system\n");
> +	if (!perf->i915)
>   		return -ENOTSUPP;
> -	}
>   
>   	if (i915_perf_stream_paranoid && !perfmon_capable()) {
>   		drm_dbg(&perf->i915->drm,

Thanks for re-spinning it so quickly! LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko
