Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBD806116
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjLEVxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:53:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E8C3;
        Tue,  5 Dec 2023 13:53:50 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="460453461"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="460453461"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:53:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841615284"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="841615284"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:53:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rAdMJ-00000002Bv4-03UG;
        Tue, 05 Dec 2023 23:53:39 +0200
Date:   Tue, 5 Dec 2023 23:53:38 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZW-b4l1llqPXW-el@smile.fi.intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:39:47PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 5, 2023 at 1:24 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Tue, 5 Dec 2023 13:14:16 -0800 Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > The preferred way to import bit-fiddling stuff is to include
> > > > <linux/bits.h>.  Under the hood this may include asm/bitsperlong.h.  Or
> > > > it may not, depending on Kconfig settings (particularly architecture).
> > >
> > > Just triple checking my understanding; it looks like
> > > include/linux/bits.h unconditionally includes asm/bitsperlong.h (which
> > > is implemented per arch) most of which seem to include
> > > asm-generic/bitsperlong.h.
> > >
> > > include/linux/bits.h also defines a few macros (BIT_MASK, BIT_WORD,
> > > BITS_PER_BYTE, GENMASK, etc).  If lib/string.c is not using any of
> > > those, why can't we go straight to #including asm/bitsperlong.h?  That
> > > should resolve to the arch specific impl which may include
> > > asm-generic/bitsperlong.h?
> >
> > It's just a general rule.  If the higher-level include is present, use
> > that.  Because of the above, plus I guess things might change in the
> > future.
> 
> Hmm...how does one know that linux/bits.h is the higher-level include
> of asm/bitsperlong.h?
> 
> Do we mention these conventions anywhere under Documentation?

Unfortunately it comes with an experience. The problem here is the absence of
Documentation for the headers that guarantee inclusion of other headers. In
general linux/* are preferred over asm/* but sometimes things are complicated
(when some asm ones include linux ones via architectural code and circling
around).

> > We've been getting better about irregular asm/include files.
> >
> > But bits.h is a poor example.  A better case to study is spinlock.h.
> > If this tool recommended including asm/spinlock.h then that won't work
> > on any architecture which doesn't implement SMP (there is no
> > arch/nios2/include/asm/spinlock.h).
> 
> The tooling Tanzir is working on does wrap IWYU, and does support such
> mapping (of 'low level' to 'high level' headers; more so, if it
> recommends X you can override to suggest Y instead).
> 
> arch/nios/ also doesn't provide a bug.h, which this patch is
> suggesting we include directly.  I guess the same goes for
> asm/rwonce.h.

Have you checked Ingo Molnar's gigantic series (2k+ patches) for the header
hell clean up? Perhaps we need to apply that first.

-- 
With Best Regards,
Andy Shevchenko


