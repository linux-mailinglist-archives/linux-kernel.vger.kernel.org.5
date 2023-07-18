Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C563775835D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjGRRUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjGRRUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:20:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61836BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689700838; x=1721236838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gU6GXU89DoVEPPGhanKObMgejkXt3Pfm1XjHlWHVMrg=;
  b=MX196G+M1h1A7W9TC5o4vVleEyOA9iCw/Jkk6/Zr6C6fz1Nl3kGPKGiO
   ghMEmI/U9Zz37DFDk0d85F6+5NVMI2zzrLWTjmcuZtNyB2D7aO5CYT4ck
   BBhIIGVgixJeRV8+H+AMHH/px2S6oML6w1pjdw9p9sfuKk1/FiMLpHjeh
   VUK0G96Q/8j7GzZ7ndSA1SugqOGLddoQ1XhPHfAu9A/ku6pEbYJszDp0Z
   FGOB4Irp46+qAsD8L65waR8BP1ZMRZfg3xQKzBuFdM5jJXJT+mVLohQtY
   8UwxmUnl72Eg7+JCm7x0/g404tgTyKGpPEn3H/jtYsrB4BfCutOMatsC3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="452644692"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="452644692"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753407725"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="753407725"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 10:20:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLoND-005W4T-39;
        Tue, 18 Jul 2023 20:20:31 +0300
Date:   Tue, 18 Jul 2023 20:20:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLbJ3yz1yGtR9pCG@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
 <ZLVjYzuxlJAQVpIO@yury-ThinkPad>
 <CAG_fn=UPqyFhEMLDz3nhc7fgpCvprLsYrNjUnw3z4KfWCJGTHA@mail.gmail.com>
 <ZLabOHmNQm2EOXWR@smile.fi.intel.com>
 <ZLbF3ZO7TvJGJOeo@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLbF3ZO7TvJGJOeo@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:03:25AM -0700, Yury Norov wrote:
> On Tue, Jul 18, 2023 at 05:01:28PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 18, 2023 at 11:30:00AM +0200, Alexander Potapenko wrote:

...

> > The idea behind is to eliminate the code completely for the cases nbits != 0.
> > In your case the dynamic check will be there. That's what we want to avoid.
> 
> Alexander is right - we can't avoid testing against 0 if we need to
> test for 0... In case of other functions we have inline and outline
> implementations, controlled by small_const_nbits().
> 
> As you can see, the small_const_nbits() tests against 0 explicitly,
> although it's free at compile time. But if nbits == 0, we pick
> outline version of a function regardless.
> 
> On their turn, outline versions again do their test against nbits == 0,
> but most of the time implicitly.
> 
> In case of bitmap_set_val, we are touching at max 2 words, and there's
> no reason for outline version, so we have to test nbits against 0
> inside inline code. 
> 
> Having all that in mind, and because nbits == 0 is most likely an
> error we'd follow the following rules:
>  - no memory must be touched as we're potentially in error condition,
>    and pointer may be corrupted;
>  - the cost of the check must be as minimal as possible.
> 
> So I suggest:
> 
>         if (unlikely(nbits == 0))
>                 return;
> 
> For readers that would literally mean: we don't expect that, and we find
> it suspicious, but we'll handle that as correct as we can.

Okay, thank you for elaborated answer.

-- 
With Best Regards,
Andy Shevchenko


