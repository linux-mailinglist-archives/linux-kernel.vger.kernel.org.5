Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E119E7B0384
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjI0MKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjI0MK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:10:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD45CBE;
        Wed, 27 Sep 2023 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695816627; x=1727352627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qpBb1Dvmlu54LR+5l2f0lLgg+l2XFidwR6LH6371XtU=;
  b=IJJsyIY+Ej30BCLnOzlb0CS/zL68eYAYkA/SJKkokQlWaEzfBkHZYvju
   dox7SYwg6jg9mJbUg7Gl9KjqRkm3jRct0d31vdI+11X8M5bSMmxrviDMs
   qm0tVFjVWop9FN+QYbJUEgwpMbDv4XxqhGk7fyeT98EzF9LjffKgaW+jJ
   KomjhBx1tLSpupGwNMm34b0e65lK+iaWDNJfeCbqzZApc9an/LgtEzKbr
   2S+TkbtiJRWJeR3EgFIrunWTGLW+A1YXHWgzbZ9K5gbrN2Nr78CT8sTFM
   MZPI4yuetKFFFAxfAzdj0B2MmPv3AEX55IsaHyjSZe6Dk9YEXkq6AgxWm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372150467"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="372150467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892580517"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="892580517"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:09:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlTFT-00000000sRB-0Bl3;
        Wed, 27 Sep 2023 15:02:35 +0300
Date:   Wed, 27 Sep 2023 15:02:34 +0300
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
Message-ID: <ZRQZ2m0Rb/4AkeQ3@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
 <ZRN2adZZaGeqWNlY@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRN2adZZaGeqWNlY@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:25:13PM -0700, Yury Norov wrote:
> On Tue, Sep 26, 2023 at 08:20:04AM +0300, Andy Shevchenko wrote:
> > These helpers are the optimized versions of the bitmap_remap()
> > where one of the bitmaps (source or destination) is of sequential bits.
> 
> If so, can you add a test that makes sure that new API is consistent
> with the old bitmap_remap? And also provide numbers how well are they
> optimized, comparing to bitmap_remap.

It's impossible. bitmap_remap() is universal, these APIs only for the specific
domain.

> > See more in the kernel documentation of the helpers.
> 
> I grepped the whole kernel, not only Documentation directory, and found
> nothing...

It's added in this patch in the format of kernel doc.

...

> > + * Returns: the weight of the @mask.
> 
> Returning a weight of the mask is somewhat non-trivial... To me it
> would be logical to return a weight of destination, for example...

> But I see that in the following patch you're using the returned value.
> Maybe add a few words to advocate that?


I'll look into it again, maybe dst would work as well, I don't remember why
I have chosen mask. Maybe because it's invariant here, dunno.

...

> > +	int n = 0;
> 
> Is n signed for purpose? I think it should be consistent with
> return value.

OK. No purpose there. Perhaps it's a leftover from the first experiments
on the implementation of these APIs.

...

> > + * Example:
> > + * If @src bitmap = 0x0302, with @mask = 0x1313, @dst will be 0x001a.
> 
> Not sure about others, but to me hex representation is quite useless,
> moreover it's followed by binary one.

Somebody is better at hex, somebody at binary one, I would leave both.

> > + * Or in binary form
> > + * @src			@mask			@dst
> > + * 0000001100000010	0001001100010011	0000000000011010
> > + *
> > + * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
> > + *
> > + * Returns: the weight of the @mask.
> > + */
> 
> It looks like those are designed complement to each other. Is that
> true? If so, can you make your example showing that
>         scatter -> gather -> scatter
> would restore the original bitmap?

It looks like you stopped reading documentation somewhere on the middle.
The two APIs are documented with the same example which makes it clear
that they are data-loss transformations.

Do you need something like this to be added (in both documentations):

  The bitmap_scatter(), when executed over the @dst bitmap, will
  restore the @src one if the @mask is kept the same, see the example
  in the function description.

?

> If I'm wrong, can you please underline that they are not complement,
> and why?

No, you are not.

...

> I feel like they should reside in header, because they are quite a small
> functions indeed, and they would benefit from compile-time optimizations
> without bloating the kernel.
> 
> Moreover, you are using them in patch #3 on 64-bit bitmaps, which
> would benefit from small_const_nbits() optimization.

I can move them into header.

...

> > +	DECLARE_BITMAP(bmap, 1024);

> Can you make it 1000? That way we'll test non-aligned case.

Sure. But it's not related to the patch. It will test bitmap_weight() and not
the new APIs, so, whatever is bigger 64 will suffice the purpose and won't
anyhow affect the newly added APIs.

...

> Would be interesting to compare bitmap scatter/gather performance
> against bitmap_remap.

Do you have a code in mind? I can incorporate it.

Again, you should understand that it's only applicable to the certain cases,
otherwise it makes no sense (it's like comparing performance of ffs() on
a single word against find_first_bit() on the arbitrary amount of words).

-- 
With Best Regards,
Andy Shevchenko


