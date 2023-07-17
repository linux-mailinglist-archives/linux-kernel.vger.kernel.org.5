Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760A6756656
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGQO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGQO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:29:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B61BE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689604158; x=1721140158;
  h=date:from:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=U8UgNLsEAL8kyjLXPWzFgbj6b2pD9PD2ERnwE/GiYys=;
  b=OgUu7286sf3ydYQG5cq3zgZ3tYf9siVbSDzmy6yp/8i/+37pmpkaxFYC
   Hx18dv+7AKe5CkNFm2VJlvOxcryJcPUGzOnMy62Vw65XuyMIwMAFI7fQM
   jTNfr9CQfSd2hK9a+8gM52FZnqykMp0lubmRCnLN6X4sxmKFrBYdfLR97
   MGR8g+TmWTk0zONHeT9jOYCqgZfhWLO24NlK7mGRnUTeYcOzIgdrE7gnl
   35W3l2xYxWRv037lScEQKcDPRgqlI4xpMSpVZKI0IeKkTI7NtcBowRjyp
   5F1WtCaIgIhkxPBMPGt3xd2AIziLFmPR/+orogR7iyWaq001Wl5wvGzZy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="369496975"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="369496975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866758705"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2023 07:29:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLPDs-000je9-2A;
        Mon, 17 Jul 2023 17:29:12 +0300
Date:   Mon, 17 Jul 2023 17:29:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLVQOF0F4OfZQ8Qt@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
 <ZLU7mkhUiDQodaw1@smile.fi.intel.com>
 <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:14:57PM +0200, Alexander Potapenko wrote:

+Cc: Nathan (on code generation question below)

...

> > > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > You can use --cc to `git send-email` instead of polluting the commit message.
> 
> Right. But as far as I can tell, certain kernel devs prefer to be CCed
> on the whole series, whereas others do not want to see anything but
> the actual patch they were interested in.
> I am not sure about Arnd's preferences, so I just decided to keep the
> tag from the original patch by Syed Nayyar Waris (which I also
> consider to be an indication of the fact "that potentially interested
> parties have been included in the discussion" per
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by)

My personal statistics from the field that more than 90% of maintainers would
like to receive 100% of the series. Of course it depends on the series (if it's
treewide, I will agree with you). Here another point to my suggestion is that
Arnd is SoC tree maintainer, where ARM is one of the biggest player, so I think
he would like to see arm*: prefixed patches anyway.

...

> > > +             map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> >
> > I remember that this construction may bring horrible code on some architectures
> > with some version(s) of the compiler (*).
> 
> Wow, even the trunk Clang and GCC seem to generate better code for
> your version of this line: https://godbolt.org/z/36Kqxhe6j

Wow, indeed! Perhaps time to report to clang and GCC people. I believe the root
cause is that in the original version compiler can't prove that l is constant
for GENMASK().

> > To fix that I found an easy refactoring:
> >
> >                 map[index] &= ~(GENMASK(nbits, 0) << offset));
> 
> I'll take this one.
> 
> > (*) don't remember the actual versions, though, but anyway...

-- 
With Best Regards,
Andy Shevchenko


