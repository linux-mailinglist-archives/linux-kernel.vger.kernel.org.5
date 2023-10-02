Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1E7B4D40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjJBIX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:23:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E587AC;
        Mon,  2 Oct 2023 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696235005; x=1727771005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOlIFOn2hk256CLpF+8BPrLncA78Y2Z964ZdqXYyHSc=;
  b=UM9SnUNWn7HS4b5Er/pVFaxviH450KRgQccsotd9owe/4XBvh1msYPxq
   GywIUoOCFk6At/tXeJgAmIEQuvGmVsvvdSJpLWY5YB1ZNESZmRgwtlzuM
   oANXMy3MtiO5+RBlAsEbBINcMaQVHHk8noi9i0b/fDNSqQcGT4spA+YTo
   WFfhm+v61pBZg5lCXwru4iUWCrWczHAUHqXr/QlEhjTzFWNJIWvUGrKiZ
   e+8Y2/IEQmaXdKj3YSD3Fu7ms1rrPfGjqn6g9dKv67SOG/M30i4Ce7/5X
   PX0OmuwGJin8q9wBGdZ7A0fdNjqUxNm7ljqo4mnMRXhhPmj7dtVktwhRp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="4178066"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="4178066"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 01:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="820822711"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="820822711"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 01:23:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnED0-000000026Fx-18m8;
        Mon, 02 Oct 2023 11:23:18 +0300
Date:   Mon, 2 Oct 2023 11:23:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <ZRp99X4pWQ22l5VP@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
 <ZRN2adZZaGeqWNlY@yury-ThinkPad>
 <ZRQZ2m0Rb/4AkeQ3@smile.fi.intel.com>
 <ZRpBwFznhl+pci/a@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRpBwFznhl+pci/a@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 09:06:24PM -0700, Yury Norov wrote:
> On Wed, Sep 27, 2023 at 03:02:34PM +0300, Andy Shevchenko wrote:

[...]

> > > It looks like those are designed complement to each other. Is that
> > > true? If so, can you make your example showing that
> > >         scatter -> gather -> scatter
> > > would restore the original bitmap?
> > 
> > It looks like you stopped reading documentation somewhere on the middle.
> 
> What a wonderful week of strong statements... Whatever...
> 
> > The two APIs are documented with the same example which makes it clear
> > that they are data-loss transformations.

Oh, should be read as data-lossleess.

> > Do you need something like this to be added (in both documentations):
> > 
> >   The bitmap_scatter(), when executed over the @dst bitmap, will
> >   restore the @src one if the @mask is kept the same, see the example
> >   in the function description.
> > 
> > ?
> > 
> > > If I'm wrong, can you please underline that they are not complement,
> > > and why?
> > 
> > No, you are not.
> 
> I should be confused even more. You're saying that I'm not wrong here, and few
> lines above you're saying it's a data loss...

data-lossless, sorry, I was missing that.

> I don't mind this new 3-liners, but I'd like you to have a well better
> wording and testing around them because those bitmap_scatter/gather are
> all about performance, readability and usability.
> 
> To begin with, the whole name of the series: "get rid of bitmap_remap() and
> bitmap_biremap() uses" is wrong because the functions are still here, and are
> still used.
> 
> Even worse, instead of getting rid of some useless code, you're
> bloating the kernel with something that duplicates existing
> functionality.

Wasn't Rasmus clear about the intention:
1) get rid of active users of bitmap_remap() outside of NUMA;
2) move that APIs to be private for NUMA users exclusively?

Towards that direction is my series.

> But I understand your motivation, and as I already said, I like this
> series in general. So let's please figure out a better wording before
> moving forward?
> 
> Below are some my of thought.
> 
> 1. Stop saying that you're getting rid of something when you're not.
>    I'd suggest something like: "add simple and verbose alternatives to
>    bitmap_remap(), and use them where appropriate".

I'm getting rid of the users of the bitmap_remap() outside of NUMA.
Why should I stop telling that? I think I have to elaborate what
that means.

> 2. Don't blame people considering a parameter named 'mask' as a mask.
>    I mean this sentence: 
> 
>    > You should get the mask meaning. It's not the bit provider, it's a bit
>    > positions provider.
> 
>    If it's a 'bit position provider', please give it a proper name,
>    for example 'pos'. I'd suggest something like:
>         unsigned long bitmap_scatter(unsigned long *dst, unsigned long *pos,

It's not pos in the sense of what pos means. pos means a position of a single
bit, mask is about many bits. And mask meaning is still the same despite how
we call it, it's bit positions provider, i.e. bits that are set in the mask
will be considered to be worked on. It's mask, why should I rename it?

> 3. If you're saying that new API is a simplified replacement for
>    something, I'd like to see the full contract, i.e. explicit list of all
>    simplifications and limitations implied:
>    - val == dst is not handled;
>    - when 'pos' is empty, val is not copied to dst;
>    - new API doesn't wrap around 0, like bitmap_remap() does;
>    - set bits in 'val' are not copied to 'dst' when not in 'pos' (?)'
>    - anything else else?

I see, I should have not used word "simplification" at all.
I will reword to not mention bitmap_remap() _at all_.

> 4. Similarly to previous item, I'd like to have explicit understanding
>    and examples where and how bitmap_remap may be replaced. You're
>    only saying that it is possible when either 'new' or 'old' are
>    dense. Is that the only case? Can you add a test that explicitly
>    checks that bitmap_remap and bitmap_scatter/gather produce the same
>    output. Something like this:
>         bitmap_remap(dst1, val, dense_map, pos, nbits);
>         bitmap_scatter(dst2, val, pos, nbits);
>         check_eq_bitmap(dst1, dst2, nbits);

No, I won't do that. This is out of the scope as see comment on 3. above.

> 5. Can you add a picture like this to explain the algorithm even more:
> 
>         mask:    ...v..vv..v...vv
>         bits:    0000001100000010
>         1.          ^  ^^  ^    0
>         2.          |  ||  |   10
>         3.          |  ||  +> 010
>         4.          |  |+--> 1010
>         5.          |  +--> 11010
>         6.          +----> 011010
>         gather:  ..........011010

Why? Is it so complicated?

> 5. Regarding my confusion, I had to draw the picture above to realise
>    how it's possible that scatter/gather are inverse and data-loss
>    (i.e. not inverse) at the same time. Can you explain it with a
>    wording like this: "For bits selected by 'pos' bitmap, gathering a
>    'val' bitmap with the following scattering restores the original map.
>    All other bits values are lost and replaced with zeros." Similarly
>    for gathering. And please add a test case.

Let's not make a big deal out of a small typo. I admit that it confused people,
but that was neither in the documentation, nor in the code, just in our
discussion.

> 6. Regarding performance. I think it's wrong to say that that your
>    code is better optimized then some other, and then ask your
>    reviewers to figure out how to measure the difference. If you make
>    such statement, you should already have some test or real-life
>    measurement.

Same as for 4. above. I drop the comparison and mentioning of bitmap_remap().
It was a big mistake by me to even mentioned that.

>    However, if you ask me, I can suggest you to pull this patch:
>    https://lore.kernel.org/lkml/20230828184353.5145-4-yury.norov@gmail.com/
> 
>    and modify/extend it in a way that both bitmap_remap and
>    bitmap_scatter/gather take the same 'val' and 'pos' bitmaps,
>    produce the same output, and then see which code is faster.
> 
>    Worth to mention that since all current users of your API are working
>    on 64-bit maps, performance is doubty an issue. So you can drop the
>    'optimization' part of your wording, and don't add performance test.

-- 
With Best Regards,
Andy Shevchenko


