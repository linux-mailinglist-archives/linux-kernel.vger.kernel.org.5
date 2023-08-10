Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55F0777971
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHJNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJNUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:20:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4E11703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691673600; x=1723209600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfr9hoyCdvcjawUTmlAUi0ntlYKYSB2P93/w2GOAF+4=;
  b=A3anYwSDQCZKfXa/2gsVc5KSA0KfuRVlTB9HvBC1HJfu8VR3fVAGl82E
   gmG8u8HDmi1HG3BrTkUs9weY2ptva9VUGHJJSVx+TbnTQrpcRskRv0W91
   nlI0YIJVkTbGEhj6d9AJ+YZDNiFzjcB9fW4yTeYCyi3nMAZSYOykDln06
   kUW3cOF6f0//OrbqvJvLRYC6xYE3j62uPie5w+ZeFmM0zYvqLTCJgBn9E
   q9l/zy7zZ/SRK/l7i6LfjE3q8YugzHcQBPQWoUXjdu/G/aQUzeI+iNb7a
   FpxWEYNNYKYK9bpGPrtd+2DOFhRBThvQ4jqRTdViwzvz6ODm1L93kpVPF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371393057"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="371393057"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="822244413"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="822244413"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2023 06:13:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU5To-002GtZ-1Y;
        Thu, 10 Aug 2023 16:13:32 +0300
Date:   Thu, 10 Aug 2023 16:13:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Petr Mladek' <pmladek@suse.com>, Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNTifGaJdQ588/B5@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley>
 <900a99a7c90241698c8a2622ca20fa96@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900a99a7c90241698c8a2622ca20fa96@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:48:54AM +0000, David Laight wrote:
> ...
> > If you split headers into so many small pieces then all
> > source files will start with 3 screens of includes. I do not see
> > how this helps with maintainability.
> 
> You also slow down compilations.

Ingo's patches showed the opposite. Do you have actual try and numbers?

> A few extra definitions in a 'leaf' header (one without any
> #includes) don't really matter.
> If a header includes other 'leaf' headers that doesn't matter
> much.
> 
> But the deep include chains caused by a low level header
> including a main header are what causes pretty much every
> header to get included in every compilation.
> 
> Breaking the deep chains is probably more useful than
> adding leaf headers for things that are in a header pretty
> much everything in going to include anyway.
> 
> The is probably scope for counting the depth of header
> includes by looking at what each header includes.

-- 
With Best Regards,
Andy Shevchenko


