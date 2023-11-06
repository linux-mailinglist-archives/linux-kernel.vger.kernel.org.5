Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692A57E1DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjKFJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjKFJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:58:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D4B6;
        Mon,  6 Nov 2023 01:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699264688; x=1730800688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TkCxKcGNYdznfqT6795v5EotFRAa/oQht+6T7W3URj0=;
  b=LrElxFClg/heFhBtULqBBZ6J1e4/t5IMDX1Tds1/HdVtSjlLaZSwTHo7
   jIc7pb3bnZzhwFlYQikHUtbVFQElcitN+5iIy2f284vY+6oZ/1LBbxzei
   jxQxxl66eGPa5lTslkzqVUypz+3FXooFkVUxrUeA0ME6rKVB0in5aa/7a
   ONPUKOeNhMXlwiJrI2kQ+dzihdbrtC37GEeJ6TZeemf2vEEspcRdlAO40
   o99SVg+nh9mHRtEtxSaGOaQMC2DfGFJP0StVuK8vLSTwj1horQb9JmzSA
   n83uEnZdyAQ5SXfYL7DeTNyLgI/S5coMRoQW5Wrut42wyWWlLNFSxN6dA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420357288"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="420357288"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="755803698"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="755803698"
Received: from chareli-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.51.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:58:01 -0800
Date:   Mon, 6 Nov 2023 10:57:58 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     tvrtko.ursulin@linux.intel.com, airlied@gmail.com,
        alan.previn.teres.alexis@intel.com, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, chris.p.wilson@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jonathan.cavitt@intel.com,
        joonas.lahtinen@linux.intel.com, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        rodrigo.vivi@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: Fix potential spectre vulnerability
Message-ID: <ZUi4ploYfYyZvmO7@ashyti-mobl2.lan>
References: <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
 <20231103023257.58199-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103023257.58199-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kunwu,

On Fri, Nov 03, 2023 at 10:32:57AM +0800, Kunwu Chan wrote:
> Fix smatch warning:
> drivers/gpu/drm/i915/gem/i915_gem_context.c:847 set_proto_ctx_sseu()
> warn: potential spectre issue 'pc->user_engines' [r] (local cap)
> 
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Link: https://lore.kernel.org/all/20231102101642.52988-1-chentao@kylinos.cn
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 9a9ff84c90d7..e38f06a6e56e 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -844,6 +844,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
>  		if (idx >= pc->num_user_engines)
>  			return -EINVAL;
>  
> +		idx = array_index_nospec(idx, pc->num_user_engines);

you ignored my comment, though.

Andi

>  		pe = &pc->user_engines[idx];
>  
>  		/* Only render engine supports RPCS configuration. */
> -- 
> 2.34.1
