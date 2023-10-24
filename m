Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCA7D53F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjJXO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343742AbjJXO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:26:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD490E8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389918644"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="389918644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 07:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="787800546"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="787800546"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 07:26:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andy@kernel.org>)
        id 1qvIMM-00000008Ixi-3mgW;
        Tue, 24 Oct 2023 17:26:18 +0300
Date:   Tue, 24 Oct 2023 17:26:18 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        keescook@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/39] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024134637.3120277-2-surenb@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Minimized the list of people for my review / comments)

On Tue, Oct 24, 2023 at 06:45:58AM -0700, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> The new flags parameter allows controlling
>  - Whether or not the units suffix is separated by a space, for
>    compatibility with sort -h
>  - Whether or not to append a B suffix - we're not always printing
>    bytes.

...

>  	string_get_size(nblocks, queue_logical_block_size(q),
> -			STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
> +			0, cap_str_10, sizeof(cap_str_10));

This doesn't seem right (even if it works). We shouldn't rely on the
implementation details.

...

> -	string_get_size(sdkp->capacity, sector_size,
> -			STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));

> +	string_get_size(sdkp->capacity, sector_size, 0,
> +			cap_str_10, sizeof(cap_str_10));

Neither this.

...

> -/* Descriptions of the types of units to
> - * print in */
> -enum string_size_units {
> -	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> -	STRING_UNITS_2,		/* use binary powers of 2^10 */
> +enum string_size_flags {

So, please add UNITS_10 as it is now. It will help if anybody in the future
wants to add, e.g., 8-base numbers.

> +	STRING_SIZE_BASE2	= (1 << 0),
> +	STRING_SIZE_NOSPACE	= (1 << 1),
> +	STRING_SIZE_NOBYTES	= (1 << 2),
>  };

Please, add necessary comments.

...

> +enum string_size_units {
> +	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> +	STRING_UNITS_2,		/* use binary powers of 2^10 */
> +};

And what a point now in having these?

I assume you need to split this to a few patches:

1) rename parameter to be a flags without renaming the definitions (this will
   touch only string_helpers part);
2) do the end job by renaming it all over the drivers;
3) add the other flags one-by-one (each in a separate change);
4) use new flags where it's needed;

Also see below.

...

>  	static const char *const units_10[] = {
> -		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
> +		"", "k", "M", "G", "T", "P", "E", "Z", "Y"
>  	};
>  	static const char *const units_2[] = {
> -		"B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"
> +		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi"
>  	};

Ouch, instead of leaving this and actually "cutting the letter" with NO* flags,
you did something different.

...

Now the main part. Since in 50+% cases (I briefly estimated, it may be more)
this is used in printf() why not introducing a new pointer extension for that?

Yes, it may be done separately, but it will look like a double effort to me.
Instead it might give us a possibility to scale w/o touching users each time
we want to do something and at the same time hide this complete API under
printf() implementation.

-- 
With Best Regards,
Andy Shevchenko


