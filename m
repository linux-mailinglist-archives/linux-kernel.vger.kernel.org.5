Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C57AD0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjIYG7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjIYG7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:59:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCDCA3;
        Sun, 24 Sep 2023 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695625136; x=1727161136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6s9STd0fndehTlHvjZGrzL7YOyiewvnDeh9Ym526SI=;
  b=UlLjvH2PY1qED2iKCdvXmfX0S8Jz7SN27JO05bZI9dWuKJaFdm7H2qFV
   PRsvzNCajQl96VTJTyr0pVqUQaWipf2Fu0PXEp9yWplln5QhjFUf8lxpn
   TSARBp18dKl2vvy39doF991xON9Vuy2ehZsHHjz8E7MGCvEnq6tSjc8Fv
   UuC0OJgxJ8NekRn6SRr9F1PGqAul/ewlTS0QNu56638J1eO4Jn9Cc65Vu
   2CoyfCksaSvXaBp0d3lypHUSJ7IwvKnRGqWx5ymoLltZtyXxA7QIodjUZ
   XaKCfaY7b1Jo8ZoF/4hpCJSLk6hAg6fOQbbAe6yxi0au8YilxvpiXT97S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445288213"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445288213"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="751568785"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="751568785"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:58:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qkfYP-00000000H00-2LVd;
        Mon, 25 Sep 2023 09:58:49 +0300
Date:   Mon, 25 Sep 2023 09:58:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     brgl@bgdev.pl, Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4] gpio: sim: fix an invalid __free() usage
Message-ID: <ZREvqQdQlE9OBvMC@smile.fi.intel.com>
References: <20230918145533.14642-1-brgl@bgdev.pl>
 <ZQhtWNaCiHVu5yzL@smile.fi.intel.com>
 <CAMRc=MfkzdFgwEuNGJYgxyCA_b__Ds-jA4S+jVT1ULJ9DTRhOw@mail.gmail.com>
 <ZQl8tkWnQcjtFBbQ@smile.fi.intel.com>
 <CAHk-=wgK+PimVukScvVjoqOdOWWG_e+xCurhP_9SvA_+7scYWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgK+PimVukScvVjoqOdOWWG_e+xCurhP_9SvA_+7scYWw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 11:19:08AM -0700, Linus Torvalds wrote:
> On Tue, 19 Sept 2023 at 03:49, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Nope, k*alloc*() returns ZERO or NULL on failure. That's what most developers
> > are missing :-)
> 
> Absolutely not.
> 
> k*alloc() returns NULL on failure. Absolutely nothing else.
> 
> On *success*, it can return the special ZERO_SIZE_PTR. But that is
> *not* a failure at all. It's very much a successful pointer.
> 
> Now, it's a pointer that you can't actually dereference, but that's
> very much intentional. You can't dereference it, because you asked for
> a zero-sized allocation. You got a zero-sized allocation.

"A-ha" moment to me, thank you for elaboration!

> But please never *ever* think it's a failure. It's very much not a
> failure case, and it is very much intentional.
> 
> It's different from NULL exactly *because* it's successful, and
> exactly so that you can write
> 
>      ptr = kmalloc(size);
>      if (!ptr)
>           return -ENOMEM;
> 
> without having to worry about the "size is zero" case.
> 
> The standard user-space "malloc()" library is misdesigned. Surprise
> surprise. The kernel isn't.

-- 
With Best Regards,
Andy Shevchenko


