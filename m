Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3063D7D8368
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJZNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:20:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1BAB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:20:49 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="366888831"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="366888831"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 06:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709066380"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="709066380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 06:12:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andy@kernel.org>)
        id 1qw0AP-00000008rQH-0tLs;
        Thu, 26 Oct 2023 16:12:53 +0300
Date:   Thu, 26 Oct 2023 16:12:52 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        keescook@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/39] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <ZTpl1ELUMEmne21U@smile.fi.intel.com>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-2-surenb@google.com>
 <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
 <20231024194653.c24qbnk6bx3hep6y@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024194653.c24qbnk6bx3hep6y@moria.home.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:46:53PM -0400, Kent Overstreet wrote:
> On Tue, Oct 24, 2023 at 05:26:18PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 24, 2023 at 06:45:58AM -0700, Suren Baghdasaryan wrote:

...

> > >  	string_get_size(nblocks, queue_logical_block_size(q),
> > > -			STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
> > > +			0, cap_str_10, sizeof(cap_str_10));
> > 
> > This doesn't seem right (even if it works). We shouldn't rely on the
> > implementation details.
> 
> It's now a flags parameter: passing an empty set of flags is not
> "relying on an implementation detail".

0 is the "default" flag which is definitely relies on the "implementation
detail". And I think that it's better that caller will explicitly tell what
they want.

...

> > > -/* Descriptions of the types of units to
> > > - * print in */
> > > -enum string_size_units {
> > > -	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> > > -	STRING_UNITS_2,		/* use binary powers of 2^10 */
> > > +enum string_size_flags {
> > 
> > So, please add UNITS_10 as it is now. It will help if anybody in the future
> > wants to add, e.g., 8-base numbers.
> 
> Octal human readable numbers? No, no one's wanted that so far and I
> very much doubt anyone will want that in the future.

I also in doubt, but still, the explicit is better than implicit in this case
in my opinion.

> > > +	STRING_SIZE_BASE2	= (1 << 0),
> > > +	STRING_SIZE_NOSPACE	= (1 << 1),
> > > +	STRING_SIZE_NOBYTES	= (1 << 2),
> > >  };

...

> > > +enum string_size_units {
> > > +	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> > > +	STRING_UNITS_2,		/* use binary powers of 2^10 */
> > > +};
> > 
> > And what a point now in having these?
> 
> Minimizing the size of the diff and making it more reviewable. It's fine
> as an internal implementation thing.

It's not an issue to rename these all over the places as you already did that
for most of the users. And minimizing diff could be done better with
--histogram algorithm or so. Otherwise it is not an objective here, right?

...

> > I assume you need to split this to a few patches:
> > 
> > 1) rename parameter to be a flags without renaming the definitions (this will
> >    touch only string_helpers part);
> > 2) do the end job by renaming it all over the drivers;
> > 3) add the other flags one-by-one (each in a separate change);
> > 4) use new flags where it's needed;
> 
> No, those would not be atomic changes. In particular changing the
> parameter to a flags without changing the callers - that's not how we do
> things.

> We're currently working towards _better_ type safety for enums, fyi.
> 
> The new flags _could_ be a separate patch, but since it would be
> touching much the same code as the previous patch I don't see the point
> in splitting it.

Individual flags can be discussed, objected or approved and won't affect the
rest of the changes. That's why I highly recommend to reconsider splitting of
this change.

It would be possible to squash back if maintainer wants this, but from review
perspective you are adding more burden to the reviewer's shoulders is not good.

...

> > >  	static const char *const units_10[] = {
> > > -		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
> > > +		"", "k", "M", "G", "T", "P", "E", "Z", "Y"
> > >  	};
> > >  	static const char *const units_2[] = {
> > > -		"B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"
> > > +		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi"
> > >  	};
> > 
> > Ouch, instead of leaving this and actually "cutting the letter" with NO* flags,
> > you did something different.
> 
> Not sure I understand your complaint? Were you attached to the redundant
> Bs?

Flag means "cutting" while in the code you "adding" (doing the opposite). Why
not do exactly "cutting" without touching there. Or since you mentioned changes
across the all callers, make them explicitly tell that they want Bytes suffix.

-- 
With Best Regards,
Andy Shevchenko


