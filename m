Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31D7538AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjGNKra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjGNKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:47:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE430FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689331646; x=1720867646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOsxOI6FQngHJON6MN20wMAy7jjyncONocREl6UC/8c=;
  b=B1AX2F0P/lJKdAyXD9Ok3WDlWGQ6KdNjJ0Jv9OE56OK7nlBmTYMDKPFe
   17VJ1rkRR9KtHxp2JjPLHQoUX2CNdZcVzFYpQmXX1FcVq7ww2qnM46Foy
   xYFxyJWAu7PCsImxAsupN36FT1Andz5By4RvJxg9auOxZ6Fo/tdFp5SLV
   2cMxzc8BmWV79rbFJR+eLIbteZNuftWNdwbMNDAiQ6dmWww5bMP99/Svs
   KtUmIcRji4Nn1mUHHEA2O9BPBtDYUEPWh1+GeAuTzl1BesvTf6FaSJcdZ
   iRk1ssDNk+0W3kN4anrnNmytq6TVWL396kBAivTGjTnI82GRfLQMXXimn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429210058"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429210058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="835990500"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="835990500"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jul 2023 03:47:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKGKX-002dBW-0w;
        Fri, 14 Jul 2023 13:47:21 +0300
Date:   Fri, 14 Jul 2023 13:47:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Subject: Re: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLEnublo8C5yX3si@smile.fi.intel.com>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-4-glider@google.com>
 <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com>
 <CAG_fn=W4Uv2YaO=Udwo80_f74y8o0+WWVVqTNK3iW5VDs5B8+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=W4Uv2YaO=Udwo80_f74y8o0+WWVVqTNK3iW5VDs5B8+w@mail.gmail.com>
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

On Fri, Jul 14, 2023 at 11:25:41AM +0200, Alexander Potapenko wrote:

...

> > Not sure why fls() / BIT() can't be used directly instead of these functions,
> > but okay, they are not too ugly.
> 
> They can't be used directly because 128 maps to 0, but I can sure
> simplify them a bit.

Right, that's why I'm okay with the current implementation. But
if you want to rewrite, up to you.

...

> > > +                     if (pos % 2 == 0)
> >
> > Would be better to keep this aligned with above?
> >
> >                         if (pos % 2)
> >                                 ...
> >                         else
> >                                 ...
> 
> It would, but i % 2 above didn't survive the rewrite, so I assume it
> is fine to keep pos % 2 == 0 as is.

Not big deal, but less characters improve the brain process, so

	if (pos % 2)

kinda quicker to read and understand in my opinion.

...

> > > +EXPORT_SYMBOL(ea0_storage_size);
> >
> > Btw, can we go to the namespaced export from day 1?
> 
> Am I getting it right that I just need to change EXPORT_SYMBOL to
> EXPORT_SYMBOL_NS and import the namespace in
> arch/arm64/mm/test_mtecomp.c?
> I.e. MODULE_IMPORT_NS is not needed in mteswap_comp.c, because it is
> linked into the kernel?

I think you always need to include MODULE_IMPORT_NS for the sake of
robustness of the code.

...

> > > +             if (sizes[i] > largest) {
> > > +                     largest = sizes[i];
> > > +                     largest_idx = i;
> > > +             }
> >
> > (alas max_array() can't be used here)
> There's no max_array() in the kernel, am I missing something?

There will be (via ASoC tree and maybe IIO tree later on) in v6.6-rc1, but
as I think it can't be used anyway because you need the index of the value
as well.

...

> > > +void ea0_release_handle(u64 handle)
> > > +{
> > > +     void *storage = ea0_storage(handle);
> > > +     int size = ea0_storage_size(handle);
> > > +     struct kmem_cache *c;
> >
> > > +     if (!handle || !storage)
> > > +             return;
> >
> > You use handle before this check. Haven't you run static analysers?
> 
> Sparse doesn't report anything in these files, are there any
> alternatives adopted in the kernel?
> 
> Note that handle is not dereferenced above, so there's no error per se.

Even if it's a simple pointer arithmetics, the storage might (theoretically?)
have a dangling pointer, no?

> Yet (as pointed out below) these checks are redundant, so I'll remove
> some of them.

...

> > > +
> >
> > Unneeded blank line.
> 
> I think there's no agreement on this in the kernel code, but my
> version is more popular:
> 
> $ git grep -B2 '^module_init(' | grep '\-}' -A2 | grep module_init | wc
>    2688    2707  164023
> $ git grep -B2 '^module_init(' | grep '\-}' -A1 | grep module_init | wc
>     505     523   30989

Even though, there is no need for this blank line. And note, for better
argument, compare this for the new code added let's say for the past 2
years. I believe numbers will tend to my variant.

I.o.w. you need to count on trends and not only on frequencies.

-- 
With Best Regards,
Andy Shevchenko


