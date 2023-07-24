Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3975FDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGXRfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGXRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:35:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E202598;
        Mon, 24 Jul 2023 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690220135; x=1721756135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwYTilEARt1N1V34eJr55Ya9rMistbgI1FoRnG+ZV2g=;
  b=AXlVKEqODM+4JZm+HoB7TJLQStQGmiFgXI/BsVtOAwAIFsupFTCoBrrR
   KfM5j6fiXwSoMdp79H5bW4MyB0MS8aqPMgxRYzDuK6QUrUPZH+Y+13Wc7
   2fqOOVOYIVuUiSs3n4F0YEUB5fO/4PyQFSXIVmmteVPZ6rbGwuGavr+2G
   D2rGCfhu6ebkFuLi65fzW0yaYloXXJBGjvIOIK0fvJJv+0/wgiKzqQByo
   YUgEBpnOAAbHdLMMjbS6qHM+kvhH3A25cowk5vg6hcCt7Oy8sfPJKDiwJ
   xGe/dGjwZyeQd2JRW4hVOkCHmNNBDEQeOctQQqjSehvIPGUOJRyXblGrJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371107580"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="371107580"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 10:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="791042033"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="791042033"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO intel.com) ([10.252.34.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 10:35:31 -0700
Date:   Mon, 24 Jul 2023 19:35:27 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, andrzej.hajda@intel.com,
        intel-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mripard@kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/tv: avoid possible division by
 zero
Message-ID: <ZL62X3/CnsJcWWU4@ashyti-mobl2.lan>
References: <20230718013216.495830-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718013216.495830-1-suhui@nfschina.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:32:17AM +0800, Su Hui wrote:
> Clang warning: drivers/gpu/drm/i915/display/intel_tv.c:
> line 991, column 22 Division by zero.
> Assuming tv_mode->oversample=1 and (!tv_mode->progressive)=1,
> then division by zero will happen.
> 
> Fixes: 1bba5543e4fe ("drm/i915: Fix TV encoder clock computation")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/drm/i915/display/intel_tv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
> index 36b479b46b60..f59553f7c132 100644
> --- a/drivers/gpu/drm/i915/display/intel_tv.c
> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
> @@ -988,7 +988,7 @@ intel_tv_mode_to_mode(struct drm_display_mode *mode,
>  		      const struct tv_mode *tv_mode,
>  		      int clock)
>  {
> -	mode->clock = clock / (tv_mode->oversample >> !tv_mode->progressive);
> +	mode->clock = clock / tv_mode->oversample << !tv_mode->progressive;

but this does not provide the same value. Try with:

	8 / (2 >> 1)

and

	8 / 2 << 1

They are definitely different.

The real check could be:

	if (!(tv_mode->oversample >> 1))
		return ...

But first I would check if that's actually possible.

Andi
