Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA547BA3F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjJEQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbjJEQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:01:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339362D4B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513854; x=1728049854;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7cLwqKiXl9KfzXnflp8oVp0nz4eFfG4OmGWuM2JBzIs=;
  b=WxCDvX4m82tFxDRTHzzHNBEhUCRQujuzHmBqQxGU7edfElv+/Kz8qLhA
   WNgIcPhgF+Nh7OeQE3rsdPAwp/5NSV4y7ikeh6qdsgMyTInpL6SYBJ4Et
   eq6FLuTIygR0cGQLT4mx1GJf6Yn6sM+qhQegTHG5aX6DXaC/6FFouCXGN
   nLhFdYceAMJx564N6s6BijnYL+SbDj83re4JSgxsqj3IEvoWfbDpLH0Fj
   gLY+8koM1IdqS8w6g2FKJbCes7/0lTBPzssTHS29H8rLuf4PNP0Wr2Ils
   d+ad75VRqNJjXXWRq8F6e5yo5W7WSADyPaQePqRNBmsM6RGbx0F8XU/pd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="368534710"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="368534710"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 03:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="822066068"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="822066068"
Received: from icoveix-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.55.203])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 03:22:17 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/i915/pmu: Use local64_try_cmpxchg in
 i915_pmu_event_read
In-Reply-To: <20230703150859.6176-1-ubizjak@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230703150859.6176-1-ubizjak@gmail.com>
Date:   Thu, 05 Oct 2023 13:22:15 +0300
Message-ID: <87ttr5cqso.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023, Uros Bizjak <ubizjak@gmail.com> wrote:
> Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
> in i915_pmu_event_read.  x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg).
>
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
>
> No functional change intended.
>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index d35973b41186..108b675088ba 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -696,12 +696,11 @@ static void i915_pmu_event_read(struct perf_event *event)
>  		event->hw.state = PERF_HES_STOPPED;
>  		return;
>  	}
> -again:
> -	prev = local64_read(&hwc->prev_count);
> -	new = __i915_pmu_event_read(event);
>  
> -	if (local64_cmpxchg(&hwc->prev_count, prev, new) != prev)
> -		goto again;
> +	prev = local64_read(&hwc->prev_count);
> +	do {
> +		new = __i915_pmu_event_read(event);
> +	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));

Chased through the documentation again, and pushed to drm-intel-next.

Thanks for the patch.

BR,
Jani.

>  
>  	local64_add(new - prev, &event->count);
>  }

-- 
Jani Nikula, Intel
