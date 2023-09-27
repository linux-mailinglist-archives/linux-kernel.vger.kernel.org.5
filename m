Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18BC7B03C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjI0MRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjI0MRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:17:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615AE19A;
        Wed, 27 Sep 2023 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695817034; x=1727353034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QmuETALrgMPjUAn12YFgIQeDTtWH91/gn8tjyGX6uwM=;
  b=diFgkx02bfYFxlgNRQjJY0PysoNjOPtbpssq4JmVVE0mFlwyGn/psfVX
   qpArlH28IBZ7sxgZCJ+bP/Ap11phykhvRn4RG3C3HMI3HF+kA7kiLlvOK
   r0clrjJLh5UP4WcHONSZ3XgWpy1YtroJ3JcKxa7b1GaWQioQp8RLufyKB
   ZSKzHEdpxdu/R5nYZDrGgwH7nS28Nw15HoD3bUa41L61yebOCGg+xTbQD
   8VmiCNK4Ft06dLEZTKV176Xn5qIrpGS/PVp3EUnUWY8NlaQfbxgYy/8Mr
   ROCPCUuHTZBfOquzv94Ifch3U932C4+lNjDx/Oc7MNshT6wQr1DzTFJr9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381710844"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="381710844"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778518582"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="778518582"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:17:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlTTW-00000000scN-2fgC;
        Wed, 27 Sep 2023 15:17:06 +0300
Date:   Wed, 27 Sep 2023 15:17:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Message-ID: <ZRQdQnL5VbX659cl@smile.fi.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
 <ZROGG44v5kfktdVs@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZROGG44v5kfktdVs@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:32:11AM +0800, Kent Gibson wrote:
> On Tue, Sep 26, 2023 at 08:20:07AM +0300, Andy Shevchenko wrote:
> > Currently we have a few bitmap calls that are open coded in the library
> > module. Let's convert them to use generic bitmap APIs instead.
> 
> Firstly, I didn't consider using the bitmap module here as, in my mind at
> least, that is intended for bitmaps wider than 64 bits, or with variable
> width. In this case the bitmap is fixed at 64 bits, so bitops seemed more
> appropriate.
> 
> And I would argue that they aren't "open coded" - they are parallelized
> to reduce the number of passes over the bitmap.
> This change serialises them, e.g. the get used to require 2 passes over
> the bitmap, it now requires 3 or 4.  The set used to require 1 and now
> requires 2.
> And there are additional copies that the original doesn't require.
> So your change looks less efficient to me - unless there is direct
> hardware support for bitmap ops??
> 
> Wrt the argument that the serialized form is clearer and more
> maintainable, optimised code is frequently more cryptic - as noted in
> bitmap.c itself, and this code has remained unchanged since it was merged
> 3 years ago, so the only maintenance it has required is to be more
> maintainable??  Ok then.
> 
> Your patch is functionally equivalent and pass my uAPI tests, so 
> 
> Tested-by: Kent Gibson <warthog618@gmail.com>

Thanks for testing!

> but my preference is to leave it as is.

As Yury mentioned we need to look at bitmap APIs and make them possible to have
a compile-time optimizations. With that in mind, I would prefer bitmap APIs
over open-coded stuff which is hardly to be understood (yes, I still point
out that it takes a few hours to me, maybe because I'm stupid enough, to
get what's the heck is going one there, esp. for the == 1 case).

Yet, it opens a way to scale this in case we might have v3 ABI that let's say
allows to work with 512 GPIOs at a time. With your code it will be much harder
to achieve and see what you wrote about maintenance (in that case).

-- 
With Best Regards,
Andy Shevchenko


