Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E105A761110
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjGYKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGYKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:38:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCAA12E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690281508; x=1721817508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KJgjI4sfR6bBwcSEF+aGovBbHBNR3BwruDjTz8j7xqs=;
  b=JT6WX0181f7U40MNq5Wmoxo74cG7N/H+AKZKKM/26yN4RtehZJ2oyqP7
   zcAd9dO3tCDExVLl5kasYa05N19Poz7uyMZLS9W5T5vf3KNRJ1qfA+oUH
   JWmw8990jSCHeBHLMFKDix94GCojn/VCmfHBJC5Q+kHT7fgYCuo5VfeT4
   ehF9tZrmNgmcyP6eHlcqUJB6nzZ/2qYDAssenDU1IsiEObOs5YJflKYGn
   1YjKrgMteN/P4woqFfKsXjJgLeofnSRwZ3WeRhLjse9Lp5hoZZXMAAZaG
   8IWlPDRAUbp/PVrDfNcZ8kItbrmxGOg1DN69wPbzj6D6gHl7yZcqQQPpA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365144408"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="365144408"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="676191678"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="676191678"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2023 03:38:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOFQu-005cVb-2W;
        Tue, 25 Jul 2023 13:38:24 +0300
Date:   Tue, 25 Jul 2023 13:38:24 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH next 0/5] minmax: Relax type checks in min() and max().
Message-ID: <ZL+mIJiXAJaXDSJF@smile.fi.intel.com>
References: <caa84582f9414de895ac6c4fe2b53489@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa84582f9414de895ac6c4fe2b53489@AcuMS.aculab.com>
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

On Tue, Jul 25, 2023 at 10:00:40AM +0000, David Laight wrote:
> The min() (etc) functions in minmax.h require that the arguments have
> exactly the same types. This was probably added after an 'accident'
> where a negative value got converted to a large unsigned value.
> 
> However when the type check fails, rather than look at the types and
> fix the type of a variable/constant, everyone seems to jump on min_t().
> In reality min_t() ought to be rare - when something unusual is being
> done, not normality.
> If the wrong type is picked (and it is far too easy to pick the type
> of the result instead of the larger input) then significant bits can
> get discarded.
> Pretty much the worst example is in the derfved clamp_val(), consider:
> 	unsigned char x = 200u;
> 	y = clamp_val(x, 10u, 300u);
> 
> I also suspect that many of the min_t(u16, ...) are actually wrong.
> For example copy_data() in printk_ringbuffer.c contains:
> 	data_size = min_t(u16, buf_size, len);
> Here buf_size is 'unsigned int' and len 'u16', pass a 64k buffer
> (can you prove that doesn't happen?) and no data is returned.
> 
> The only reason that most of the min_t() are 'fine' is that pretty
> much all the value in the kernel are between 0 and INT_MAX.
> 
> Patch 1 adds min_unsigned(), this uses integer promotions to convert
> both arguments to 'unsigned long long'. It can be used to compare a
> signed type that is known to contain a non-negative value with an
> unsigned type. The compiler typically optimises it all away.
> Added first so that it can be referred to in patch 2.
> 
> Patch 2 replaces the 'same type' check with a 'same signedness' one.
> This makes min(unsigned_int_var, sizeof()) be ok.
> The error message is also improved and will contain the expanded
> form of both arguments (useful for seeing how constants are defined).
> 
> Patch 3 just fixes some whitespace.
> 
> Patch 4 allows comparisons of 'unsigned char' and 'unsigned short'
> to signed types. The integer promotion rules convert them both
> to 'signed int' prior to the comparison so they can never cause
> a negative value be converted to a large positive one.
> 
> Patch 5 is slightly more contentious (Linus may not like it!)
> effectively adds an (int) cast to all constants between 0 and MAX_INT.
> This makes min(signed_int_var, sizeof()) be ok.
> 
> With all the patches applied pretty much all the min_t() could be
> replaced by min(), and most of the rest by min_unsigned().
> However they all need careful inspection due to code like:
> 	sz = min_t(unsigned char, sz - 1, LIM - 1) + 1;
> which converts 0 to LIM.

I don't know how you made this series, but it has no thread. You need to use
--thread when forming the patch series.

-- 
With Best Regards,
Andy Shevchenko


