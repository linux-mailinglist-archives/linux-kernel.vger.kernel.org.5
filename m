Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A5763C46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjGZQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjGZQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:20:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D431BE8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690388439; x=1721924439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o067iCH+8OoAcXJbQwYJ/ne9brMepb9+J6sApO0wauk=;
  b=KGOfAsiC69uifANqDn2YhvQHH4vGtR08xcvaVtre/JkC4XIIAfCeUjJE
   zRxXTUvcdTKtYpHuAhIKDILJeWXYomCOGUndNv/2JLaKgulaRI9Yhta3w
   9sunRWEqg0Nzg3xsDJT9CGEpwtR2DgtPZE6DGRV2Ax32HyQWvgm0FuW4l
   WHVftmNDNYyOwfNAuXv6rLNFe9ZIMJzj6RZBSmK43PKrVwyjopnH3r2RQ
   ftfPTwnQf6xZkHunhN/cjce1t+gzRQJLxv8EKOhCBq2uNONPs2MJKYMUd
   8DJn0oH1a4MkOT6E9RmPlmaZ5Phqr56krBxqXXux7vRXaIoBATqbbvbgJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368083877"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="368083877"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 09:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720533384"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="720533384"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2023 09:20:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOhF5-00EjU9-2l;
        Wed, 26 Jul 2023 19:20:03 +0300
Date:   Wed, 26 Jul 2023 19:20:03 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'kernel test robot' <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <ZMFHs4MV6vUhwn7r@smile.fi.intel.com>
References: <454f967d452548a9acfa7c0a0872507e@AcuMS.aculab.com>
 <202307252359.Is4T2MXC-lkp@intel.com>
 <350c7fe495424138afd15d797830c417@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <350c7fe495424138afd15d797830c417@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:30:59AM +0000, David Laight wrote:
> From: kernel test robot
> > Sent: 25 July 2023 16:58
> > 
> > kernel test robot noticed the following build errors:

...

> >    In file included from init/calibrate.c:8:
> > >> include/linux/jiffies.h:427:28: error: call to undeclared function 'static_assert'; ISO C99 and
> > later do not support implicit function declarations [-Wimplicit-function-declaration]
> >      427 |         return jiffies_to_clock_t(max(0L, delta));
> >          |                                   ^
> ...
> >    include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
> >       29 |                 static_assert(__types_ok(x, y),         \
> 
> This is fixed by the earlier patch:
> [PATCH v1 1/1] minmax: Fix header inclusions
> 
> which adds #include <linux/build_bug.h> and thus defines static_assert().
> 
> Can I just assume that will be applied?

You can test that and reply there with your Tested-by there, it will help it
to be applied.

-- 
With Best Regards,
Andy Shevchenko


