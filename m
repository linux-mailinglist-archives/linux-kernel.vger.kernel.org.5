Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8177DF13B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjKBLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKBLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:32:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6A8111
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698924769; x=1730460769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bPWnpkOl5c9kDmguqwCqZvb1rbVMV26DYRpjZF2/004=;
  b=bUdcMZBlwYrFgif2O3mARwr53kmewQ8R9HoVIMG2ssNv3GIulkV1mMVU
   O3Xz4JiSksL4YrMS9O288dOcf9b3EqcyGbbL6DKJu4GQpM84OpSWCdu4L
   SdX86LUIzn6TYNJ7cOA3071sa8/oasGuUid36it+6u8zJYGgS3RqOmAE5
   AzuZ9QNvYHn3sUGUWkM7jfkO5F+iWYGMqJKO5QWEO9L5PvHkWWFpQ6jTU
   7HThdsyE6XRKH+ICkiiwEvqr8w02SJJ7Rvzv3KOqlUL8dojXDD3TuAoIj
   rwwBaPzd/Z7wKJv5IWspa7s1E99Zu78f1P1Q87k3d7niD9llxDxzD3OsR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="368896839"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="368896839"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 04:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1008439715"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1008439715"
Received: from stevenwo-mobl1.ger.corp.intel.com (HELO [10.213.233.30]) ([10.213.233.30])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 04:32:45 -0700
Message-ID: <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
Date:   Thu, 2 Nov 2023 11:32:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Fix potential spectre vulnerability
Content-Language: en-US
To:     chentao <chentao@kylinos.cn>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@gmail.com, daniel@ffwll.ch, andi.shyti@linux.intel.com,
        robdclark@chromium.org, jonathan.cavitt@intel.com,
        andrzej.hajda@intel.com, chris.p.wilson@intel.com,
        alan.previn.teres.alexis@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com
References: <20231102101642.52988-1-chentao@kylinos.cn>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20231102101642.52988-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/11/2023 10:16, chentao wrote:
> Fix smatch warning:
> drivers/gpu/drm/i915/gem/i915_gem_context.c:847 set_proto_ctx_sseu()
> warn: potential spectre issue 'pc->user_engines' [r] (local cap)
> 
> Signed-off-by: chentao <chentao@kylinos.cn>

I don't know if this is actually exploitable given the time deltas between the index is read from userspace and acted upon here, which is at least two ioctls apart. But I suppose no harm in fixing and for safety so we need to add:

Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
Cc: <stable@vger.kernel.org> # v5.15+

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 9a9ff84c90d7..b2fdfc7ca4de 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -843,7 +843,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
>   
>   		if (idx >= pc->num_user_engines)
>   			return -EINVAL;
> -

Just please refrain from random whitespace modifications like this blank line removal. If you resend without that you can add my r-b.

Regards,

Tvrtko

> +		idx = array_index_nospec(idx, pc->num_user_engines);
>   		pe = &pc->user_engines[idx];
>   
>   		/* Only render engine supports RPCS configuration. */
