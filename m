Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931B4756672
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGQOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjGQOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:32:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D6819B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689604341; x=1721140341;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=giOY3bjV/jdQYlLmF47ANOQu6VLHjsT9DCS4TgFK3MA=;
  b=hbrAM/1egqS5EnqReMLZknzpjsMwWymQuugyKiyzjmgoPGxoElS0nNi9
   oRHg4UxajSHav2uYswo86/NXA0CfErPMGY31hcDdGvWNOu9L7U1RxILs5
   Kffg6zZqDf4qUvZyCaiurhZxNGuXa2d9qc95pKeL34mft7nLWs9AxVbiS
   uYXzgAxpoWydCfkMMNZNtvlS+wBhS9ovWH0aOOQGEGU/UmCdr6K+FXGu5
   KtZhkh1i+C0Bp8kStbq2UOB1uvcjQv/JWCwBzagnJGugbYK09v8dvAiZ+
   9I2DI6/by+KVrcDN7cQ9rkIBZBYkooo3HLz3sbud5oqODmZqyf+DYnjUb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368586131"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368586131"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="969896512"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969896512"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 07:31:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLPGL-000pOm-0i;
        Mon, 17 Jul 2023 17:31:45 +0300
Date:   Mon, 17 Jul 2023 17:31:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLVQ0NCC8SI5F8xR@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
 <ZLU7mkhUiDQodaw1@smile.fi.intel.com>
 <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
 <ZLVQOF0F4OfZQ8Qt@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVQOF0F4OfZQ8Qt@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:29:12PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 04:14:57PM +0200, Alexander Potapenko wrote:

...

> > > > +             map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> > >
> > > I remember that this construction may bring horrible code on some architectures
> > > with some version(s) of the compiler (*).
> > 
> > Wow, even the trunk Clang and GCC seem to generate better code for
> > your version of this line: https://godbolt.org/z/36Kqxhe6j
> 
> Wow, indeed! Perhaps time to report to clang and GCC people. I believe the root
> cause is that in the original version compiler can't prove that l is constant
> for GENMASK().
> 
> > > To fix that I found an easy refactoring:
> > >
> > >                 map[index] &= ~(GENMASK(nbits, 0) << offset));

nbits - 1 it should be, btw. In any case it seems the code is still better.

> > I'll take this one.
> > 
> > > (*) don't remember the actual versions, though, but anyway...

-- 
With Best Regards,
Andy Shevchenko


