Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFA7C8336
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJMKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJMKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:36:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D4B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697193382; x=1728729382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h5eylseGlyKInganAtlR/cJWIKhdZQLtNfHjqZwm1Xc=;
  b=PqFwb6qDqfFitrXeMk6L9f+JcJyxXqh45Dketho/sKQg/WwPzrz8KbWL
   F0G4VWX13UaA9ajSdPuEZRhIyMfonEgStcQFPCYJoICgMNUOs5q9c4Sl4
   0DebuRs8ymGA3HShJuFWPbFc3PhWT7AV3ns3mH/WWjjGp75dAXSfQWiIp
   /Fo/unBCsw6t0izgdJqfElYLaA9JLLvgIefbdQzLKHgR9MxrwCHnbcjjE
   0XkC+7gUkvvVYHnodxEyA86AFRmZFsfsp2CVbe/7eXUKAF/AJJxDQJcuY
   hFtgQihC0Kbb4eTyeClghBao5SESndrm2tQPA9HCYCkik+Rms2/5sHuJa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364516397"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="364516397"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758454698"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="758454698"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmsmga007.fm.intel.com with SMTP; 13 Oct 2023 03:36:17 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 13 Oct 2023 13:36:17 +0300
Date:   Fri, 13 Oct 2023 13:36:17 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        tvrtko.ursulin@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com
Subject: Re: [PATCH] drm/i915/gvt: Optimize mmio_offset_compare() for
 efficiency
Message-ID: <ZSkdoVcMxKIbXUOW@intel.com>
References: <20231012230449.2109078-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012230449.2109078-1-visitorckw@gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 07:04:49AM +0800, Kuan-Wei Chiu wrote:
> The original code used conditional branching in the mmio_offset_compare
> function to compare two values and return -1, 1, or 0 based on the
> result. However, the list_sort comparison function only needs results
> <0, >0, or =0. This patch optimizes the code to make the comparison
> branchless, improving efficiency and reducing code size. This change
> reduces the number of comparison operations from 1-2 to a single
> subtraction operation, thereby saving the number of instructions.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/debugfs.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/drm/i915/gvt/debugfs.c
> index baccbf1761b7..998d82a259c8 100644
> --- a/drivers/gpu/drm/i915/gvt/debugfs.c
> +++ b/drivers/gpu/drm/i915/gvt/debugfs.c
> @@ -48,11 +48,7 @@ static int mmio_offset_compare(void *priv,
>  
>  	ma = container_of(a, struct diff_mmio, node);
>  	mb = container_of(b, struct diff_mmio, node);
> -	if (ma->offset < mb->offset)
> -		return -1;
> -	else if (ma->offset > mb->offset)
> -		return 1;
> -	return 0;
> +	return ma->offset - mb->offset;

Those are unsigned ints effectively, so this only works due
to the return value being the same size signed int. Might be
better to add some explicit casts.

>  }
>  
>  static inline int mmio_diff_handler(struct intel_gvt *gvt,
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
