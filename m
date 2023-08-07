Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946887728D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjHGPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHGPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:12:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243F10DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691421138; x=1722957138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W68uUCvV0Z+4rklVXDyvUrYFp1GzMOTZPtJmbE5mzSs=;
  b=nWADndkmZ/OE90SF2n6iZdRvHzpv8nU8hI9racOk5vQpxtMmJX9uXzma
   9Wa+sKEmVWTdtFrKI3eqVTP9yUeICkjWSbd5prCLOCEWhG76YBCSq58J5
   2U9TwJOZsaQpdHoIO47lAMXZJntW6sBLGSUT+tEH6vAQPJtT5Rx/cx2gJ
   Tb35CSAb0fZ5GwCYWtdqRYIjz2XjXVur8N7lNaj9y6hMEzf0SwitdGxRV
   PSrS9E4OIQiONybx2G5iP3rkG1kHsEgXgNGQvHN/5voYXmPRHJURriNDD
   4w0+hf7yDTAMY5Bvz1Uw4hiVrVu8hLh7ce9wSFgoLShM6IcsPwqAmdPMd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434417649"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434417649"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="854692563"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="854692563"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2023 08:11:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1tE-00GnnI-0l;
        Mon, 07 Aug 2023 18:11:24 +0300
Date:   Mon, 7 Aug 2023 18:11:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 06:09:54PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> > On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:

...

> > I agree that kernel.h is not the right place. But are there any
> > numbers how much separate sprintf.h might safe?
> > Maybe, we should not reinvent the wheel and get inspired by
> > userspace.
> > 
> > sprintf() and friends are basic functions which most people know
> > from userspace. And it is pretty handy that the kernel variants
> > are are mostly compatible as well.
> > 
> > IMHO, it might be handful when they are also included similar way
> > as in userspace. From my POV printk.h is like stdio.h. And we already
> > have include/linux/stdarg.h where the v*print*() function might
> > fit nicely.
> > 
> > How does this sound, please?
> 
> Not every user (especially _header_) wants to have printk.h included just for
> sprintf.h that may have nothing to do with real output. So, same reasoning
> from me as keeping that in kernel.h, i.e. printk.h no better.

(haven't check these, just to show how many _headers_ uses sprintf() call)

$ git grep -lw s.*printf -- include/linux/
include/linux/acpi.h
include/linux/audit.h
include/linux/btf.h
include/linux/dev_printk.h
include/linux/device-mapper.h
include/linux/efi.h
include/linux/fortify-string.h
include/linux/fs.h
include/linux/gameport.h
include/linux/kdb.h
include/linux/kdev_t.h
include/linux/kernel.h
include/linux/mmiotrace.h
include/linux/netlink.h
include/linux/pci-p2pdma.h
include/linux/perf_event.h
include/linux/printk.h
include/linux/seq_buf.h
include/linux/seq_file.h
include/linux/shrinker.h
include/linux/string.h
include/linux/sunrpc/svc_xprt.h
include/linux/tnum.h
include/linux/trace_seq.h
include/linux/usb.h
include/linux/usb/gadget_configfs.h

-- 
With Best Regards,
Andy Shevchenko


