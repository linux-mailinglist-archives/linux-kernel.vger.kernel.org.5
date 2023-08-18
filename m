Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE9780788
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358783AbjHRIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358786AbjHRIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:55:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8623A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692348950; x=1723884950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IFDD8/UFqH9U8ciwDyGTLb4pw1Q5ACiy9N1XKWf4THM=;
  b=VA7zA4E93z7lCQ1JwwtwhGRjQQVfzBcTCt9nq58c42OcpBB9IuokB5wX
   l26Xad/RC1mJHi9ySiceSD/iiUXGdkIRzXLuO15uKRE7nWuN/v9Hg1CcK
   xqfTFRNGSH0cnB85ZONgBQ8p9/cOf68P9YX+9faSvlw2SmroF67JC+TME
   af5SI585Ktvd7pwscglZEe/GfWLVe/nNdNQCjVS0bL/py6g+YMPCJmlRd
   upQ04DVGkfGc7Oc0VXBYe/ymqNiY6Uf4tHlm4d9LTcWVwRdwMZAwCXpgo
   8LsvRYZbhVMv2+0wayh8TTxboc6gJWwu9txepEo+oVpkfJiybTIEKwefZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370513114"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="370513114"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 01:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849219874"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="849219874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 01:55:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWvGl-000WtH-1W;
        Fri, 18 Aug 2023 11:55:47 +0300
Date:   Fri, 18 Aug 2023 11:55:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] bitmap: Optimize memset() calls
Message-ID: <ZN8yE7jsI3z63EEw@smile.fi.intel.com>
References: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
 <20230817165453.713353-3-andriy.shevchenko@linux.intel.com>
 <e66919a4-afdc-efdb-f6ae-07cfc5bde105@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66919a4-afdc-efdb-f6ae-07cfc5bde105@rasmusvillemoes.dk>
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

On Fri, Aug 18, 2023 at 08:53:38AM +0200, Rasmus Villemoes wrote:
> On 17/08/2023 18.54, Andy Shevchenko wrote:

...

> > +#if BITS_PER_LONG == 64
> > +		memset64((uint64_t *)dst, 0, len);
> > +#else
> > +		memset32((uint32_t *)dst, 0, len);
> > +#endif
> >  }
> 
> So _if_ this is worth it at all,

Yury, I believe you have a set of performance tests for bitmaps, perhaps you
can give a try and see if we got a benefit here.

Yet, not all architectures have custom implementation of the optimized
memset()/memcpy(). But at least ARM, x86 do.

> all those new '#if BITS_PER_LONG == 64'
> suggests that we should instead have a new helper memset_long(), no?
> 
> In fact, string.h already has that:
> 
> static inline void *memset_l(unsigned long *p, unsigned long v,
>                 __kernel_size_t n)

My grep skills suddenly degraded, my thoughts were exactly like yours,
but I missed the _l instead of _long for which I grepped.

...

> Please just spell an all-ones long "~0UL", that also matches the
> small_const case.

OK!

...

> > -		memset(&dst[lim - off], 0, off*sizeof(unsigned long));
> > +		bitmap_zero(&dst[lim - off], off);
> 
> This... can't be right.

Indeed, I have in mind memset_long() and on the half-way replaced it with
bitmap_zero().

> bitmap_zero() still takes an argument which is
> the size in bits, while off is the whole number of words to shift. So if
> called with say shift=128, we'd have off==2, and that bitmap_zero()
> would, because bitmap_zero() rounds up to a whole number of words, end
> up clearing just one word.
> 
> Perhaps a chance to add some more test cases? Maybe we're not exercising
> any of the "shift more than BITS_PER_LONG" logic.
> 
> But rather than using bitmap_zero() here, forcing you to convert off to
> a number of bits and then bitmap_zero to divide again, if you do this at
> all, just change that memset() to memset_l().

Agree.

-- 
With Best Regards,
Andy Shevchenko


