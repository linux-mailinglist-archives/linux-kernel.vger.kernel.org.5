Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6334C7789AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjHKJ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjHKJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:27:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432E2D5B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691746078; x=1723282078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2lTuwzsjUsvHd6iZXZYrq5zB7tK8v7Iq3OrfyHb09I=;
  b=USYsCVY5QfZrP+WYcknsPLtXa//fpKFxQjZctMrfUVFs2KmDPqeQjHZT
   pbkkxPvqYDbr4XWVhAIBFoTaEojgCpsILoTIcHZbCbBm8IcnieKYlnlJB
   cYq16wjWiQxSIyRIrNyJ2wMi0sT5Dy8IZ8Xt7lHf/jiexiItuRWGvkaP6
   lr+sbK63jmFrvfWv3voMVFwSVtg2rENnAvjka0auAe1Nv7EGrgJ42JbTm
   e8yM5niFFX/GUSe4ITYq0rvUg0+HW8RzJ0SKQO2zWhCN6iQBpE1eD9fLg
   kEMxEdufQ1gIBMZa0CVK2z39IhGL6sxkUnrD3EqVMTGpN+dedpzab4wyb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375352965"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="375352965"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906373767"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="906373767"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 02:27:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUOQx-008Wms-1D;
        Fri, 11 Aug 2023 12:27:51 +0300
Date:   Fri, 11 Aug 2023 12:27:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 6/6] bitmap: move bitmap_*_region functions to bitmap.h
Message-ID: <ZNX/F45GKXSRDgG/@smile.fi.intel.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-7-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811005732.107718-7-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:57:32PM -0700, Yury Norov wrote:
> Now that bitmap_*_region() functions are implemented as thin wrappers
> around others, it's worth to move them to the header, as it opens room
> for compile-time optimizations.

...

> + * Return 0 on success, or %-EBUSY if specified region wasn't
> + * free (not all bits were zero).

Run

	scripts/kernel-doc -v -none -Wall

against this

...

> + * Return the bit offset in bitmap of the allocated region,
> + * or -errno on failure.

Ditto.

...

> +static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
> +{
> +	unsigned int pos, end;		/* scans bitmap by regions of size order */
> +
> +	for (pos = 0 ; (end = pos + BIT(order)) <= bits; pos = end)

Extra space.

> +		if (!bitmap_allocate_region(bitmap, pos, order))
> +			return pos;
> +
> +	return -ENOMEM;
> +}

...

> +/**
> + * bitmap_release_region - release allocated bitmap region
> + *	@bitmap: array of unsigned longs corresponding to the bitmap
> + *	@pos: beginning of bit region to release
> + *	@order: region size (log base 2 of number of bits) to release
> + *
> + * This is the complement to __bitmap_find_free_region() and releases
> + * the found region (by clearing it in the bitmap).

> + * No return value.

Useless line.

> + */

...

Seems like the original code has all these, perhaps update in a separate patch?

-- 
With Best Regards,
Andy Shevchenko


