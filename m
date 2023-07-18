Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF7758355
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjGRRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjGRRR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:17:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B39170B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689700677; x=1721236677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DEWWKPhD3bMLHl0K23L9B74wls/fgC1L701Hhpw8vVA=;
  b=COwxpX2u2PXovbwfq7MQXi4kUGhsK47KL0xhSg0t9k8BDifn4NhsnKiP
   FIkYRlBoF5CVRmbiOGI0GNbAU+M5S/KCVpSx5u8hftP+ek3mnaGxBDVkm
   0TT24QWV/3IDuXwYn7qXPHxpRp4PVsL/J12MB5vEv3PEMhT12YsIG3UEA
   oEVdYgdH7UJWszZ73thf8+famdeM0Qd273h3QNoQ0dS0iPL6oehOQeBFw
   vzCLGupv3/Dj4yakwgTI0VNkTvzTkMfXdgyFyjXvXHaXqJPSX2lFTjIY9
   jAKSDDm9oOprrIfm9ySHbk+D7KVa+8+lgz+zw2R7BB5F6x08ZrHYxH2Co
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430028058"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="430028058"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="717676698"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="717676698"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2023 10:17:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLoKd-005QHc-2q;
        Tue, 18 Jul 2023 20:17:51 +0300
Date:   Tue, 18 Jul 2023 20:17:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLbJPwdFCdSeur6k@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-4-glider@google.com>
 <ZLVG7GCTTBV4odAG@smile.fi.intel.com>
 <CAG_fn=XvoKjYpS2VPnSYBC3t7p7U-M_bfXohbXSvkepzS=6Tvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=XvoKjYpS2VPnSYBC3t7p7U-M_bfXohbXSvkepzS=6Tvg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:33:37PM +0200, Alexander Potapenko wrote:
> On Mon, Jul 17, 2023 at 3:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jul 17, 2023 at 01:37:06PM +0200, Alexander Potapenko wrote:

...

> However it doesn't seem to be very picky.
> 
>   $ scripts/kernel-doc -v  -none arch/arm64/include/asm/mtecomp.h
> 
> warns about e.g. parameter name mismatch, but does not care about the
> missing return section.

-Wreturn is missing

...

> > Also
> > why you put the descriptions in to the header file? It's a bit unusual for the
> > exported ones.
> 
> https://docs.kernel.org/doc-guide/kernel-doc.html was not specific on
> this, and I thought anyone wanting to understand how an interface
> works would prefer reading the header rather than the implementation.
> I can move the comments to arch/arm64/mm/mtecomp.c if you think it's a
> better place for them.

With the kernel doc in the C file you may also comment the internal ones and
generate documentation only for exported ones. This is not possible with h.

...

> > > +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags);
> > In both cases signed integer may be promoted with a sign. Is it a problem here?
> Not sure if you mean r_len or r_sizes,

Mostly about the latter.

> but all those values are >= 0
> and <= 256, so there should be no problems.
> (shorts could have been ints as well, we are just saving some stack
> space in ea0_compress()/ea0_decompress()).

Then why they are signed? Please, justify that.
Signdness prone to subtle and hard to hunt errors due to integer promotions.

...

> > > +#include <linux/bits.h>
> > > +#include <linux/bitmap.h>
> >
> > bitmap guarantees that bits.h will be included.
> 
> I am following the IWYU principle here, and I believe it's a good thing to do.
> I've seen cases where these transitive dependencies rotted after some
> refactoring, but the fact was only noticed in certain configurations.
> Also, there's an ongoing work by Ingo Molnar to speed up kernel builds
> by optimizing headers
> (https://lwn.net/ml/linux-kernel/YdIfz+LMewetSaEB@gmail.com/), and it
> relies on explicit dependencies which are easier to untangle.

Yes, but we have some guarantees. E.g., we don't include compiler*.h
when types.h is included, because of the guarantees.

Otherwise your code misses _a lot_ of headers.

...

> > Can you make it unsigned and start from 0?
> 
> Changed to start with 0, but I am a bit hesitant about making it
> unsigned: it is now no more special than a loop variable.

Signdness is a beast in C, needs always an additional justification.

...

> > > +     int i, j, pos = 0;
> >
> > Wouldn't be more correct to have this assignment inside the first for-loop?
> 
> Do you mean setting it back to 0 on every iteration of the outer loop?

Yes.

> We sure don't want that, since pos is the location in the tags[] array
> where the next tag is written.

OK!

...

> > > +#define RANGES_INLINE ea0_size_to_ranges(8)
> >
> > Don't forget to undef it when not needed.
> 
> Ok, will do.

> Shall I undef the constants above as well (e.g. BITS_PER_TAG)?
> The intuitive answer is "no",

Correct.

> but then there should be some difference between those and RANGES_INLINE?

Yes, one is widely used constant and one is a _localized_ helper.

...

> > > +static void bitmap_write(unsigned long *bitmap, unsigned long value,
> > > +                      unsigned long *pos, unsigned long bits)
> >
> > Please, don't use reserved namespace. Yours is ea0, use it:
> > ea0_bitmap_write()! Same to other similarly named functions.
> 
> Done.
> However there are two parallel namespaces now: "ea0" for the
> compression algorithm, and "memcomp" for the module initialization and
> data structures.
> Dunno if it makes sense to merge them (and rename the .c file accordingly).

Your choice. Mu point, just do prefix it with something meaningful.

...

> > > +     u8 r_tags[256];
> > > +     int r_len = ARRAY_SIZE(r_tags);
> >
> No, it is the length of the arrays (both r_tags and r_sizes).
> Below you make a good point it will spare us a kernel.h dependency,
> but for the sake of keeping the code error-prone we probably shouldn't
> assume r_tags is a byte array.

It's a common practice even outside of Linux kernel to use sizeof() against
char arrays. I don't see the point to have the ARRAY_SIZE() complication here.

...

> > > +             snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size);

You see, if you grep for similar calls I'm pretty sure the order of 2 of power
of 10 will be the difference between sizeof()/ARRAY_SIZE() if the latter even
occurs at least once.


-- 
With Best Regards,
Andy Shevchenko


