Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB589756717
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGQPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGQPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:03:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9715B9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689606219; x=1721142219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zDv2lDctT5fbcckIC6WwWPCqBgFU1iff9oIJZnsJfSc=;
  b=IzmrrjzfMLUEzAf/Jl7IHpVGaWMb042XuY0CpH8w5RSzsFYDJF7ZHwkY
   BLdyi7tZj+JQGDkSU1EwppmUD24nyHvpUXW2trhuC2gKexvW3wm95Qc3m
   2SqIZ1+THA//TLitwsLWNglM0/HWcCm2qxdOCV9UbvI2zXp71ch2arDPJ
   bJNB14BEr9iIzLbH+Iv+mV7PSov3BvS/qYFjB/+rrtgTLUgRBMaczvSE4
   fVmktyPbPK74BW8IN/NTOaO8Vo9Q41xK/RM+BS2HvrnOBU9h+0NFO7lnF
   xQ5rSEbvU1bKGVTm9zfFTWRjlXMTSyALkAR4K/gabuGwb5ANZoNfWm7o7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="363415142"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363415142"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="1053927770"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053927770"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2023 08:03:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLPl6-001zWM-29;
        Mon, 17 Jul 2023 18:03:32 +0300
Date:   Mon, 17 Jul 2023 18:03:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLVYRHUwgnYdnZih@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
 <ZLU7mkhUiDQodaw1@smile.fi.intel.com>
 <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
 <CAG_fn=Ufo8sWbdtPyaXhvUddRG3k9E+btFVVLTn5Tk91cwAwLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Ufo8sWbdtPyaXhvUddRG3k9E+btFVVLTn5Tk91cwAwLw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:53:51PM +0200, Alexander Potapenko wrote:

...

> > > I remember that this construction may bring horrible code on some architectures
> > > with some version(s) of the compiler (*).
> >
> > Wow, even the trunk Clang and GCC seem to generate better code for
> > your version of this line: https://godbolt.org/z/36Kqxhe6j
> 
> Oh wait.
> First, my Godbolt reproducer is incorrect, it is using sizeof(unsigned
> long) instead of 8 * sizeof(unsigned long) for BITS_PER_LONG.

Still slightly better. And note, that the same GENMASK() is used at the
beginning of the function. Compiler actually might cache it.

> > > To fix that I found an easy refactoring:
> > >
> > >                 map[index] &= ~(GENMASK(nbits, 0) << offset));
> > >
> 
> Second, the line above should probably be:
>   map[index] &= ~(GENMASK(nbits - 1, 0) << offset));
> 
> , right?

Yes.

-- 
With Best Regards,
Andy Shevchenko


