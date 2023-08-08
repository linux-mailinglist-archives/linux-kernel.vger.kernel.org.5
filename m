Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99556774214
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjHHRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjHHRc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:32:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7856B91B23
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691511245; x=1723047245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hTDS2ME+q1HzK5Sb8yCC07Kug3lXc6Oon/QxrCY5jRM=;
  b=extszsOWaI92j89kqFs8FlXVe7Q7Jo8TMwuf5AGsbGrjIte64HIja66v
   ss+vOGXka1GqsKPrSRVm7FIlSql7tybO8DoBEwm9vFXNPcs3xvcfIkxhn
   z4oJpEmJ7EL4ygJxZVCPAf9r0j6GqrWq21ClR/HpxQ8UdrmPWDxtJ3Mod
   SLeb687vTxtxfeaxm1J8jggNsfPul7g1B4aAI4G3aQl/UPJJ3PCEZYMEK
   b0txDWQphKBVzSrfTqdzX+DDekMOr+B2T8+YXh7krfL3P4wG7zoKnv18x
   F1Id3iyV6OO+UKxXQytnhm9gDrcqF0yGLm5XuLGJ+OaPg6tvpJHcBs+zp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370802279"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="370802279"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 05:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874710309"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2023 05:48:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTM80-008Nsn-09;
        Tue, 08 Aug 2023 15:48:00 +0300
Date:   Tue, 8 Aug 2023 15:47:59 +0300
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
Message-ID: <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNHjrW8y_FXfA7N_@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 08:41:49AM +0200, Petr Mladek wrote:
> On Mon 2023-08-07 18:13:57, Andy Shevchenko wrote:
> > On Mon, Aug 07, 2023 at 06:11:24PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 07, 2023 at 06:09:54PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> > > > > On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:

...

> > > > > How does this sound, please?
> > > > 
> > > > Not every user (especially _header_) wants to have printk.h included just for
> > > > sprintf.h that may have nothing to do with real output. So, same reasoning
> > > > from me as keeping that in kernel.h, i.e. printk.h no better.
> > > 
> > > (haven't check these, just to show how many _headers_ uses sprintf() call)
> > > 
> > > $ git grep -lw s.*printf -- include/linux/
> > > include/linux/acpi.h
> > > include/linux/audit.h
> > > include/linux/btf.h
> > > include/linux/dev_printk.h
> > > include/linux/device-mapper.h
> > > include/linux/efi.h
> > > include/linux/fortify-string.h
> > > include/linux/fs.h
> > > include/linux/gameport.h
> > > include/linux/kdb.h
> > > include/linux/kdev_t.h
> > > include/linux/kernel.h
> > > include/linux/mmiotrace.h
> > > include/linux/netlink.h
> > > include/linux/pci-p2pdma.h
> > > include/linux/perf_event.h
> > > include/linux/printk.h
> > > include/linux/seq_buf.h
> > > include/linux/seq_file.h
> > > include/linux/shrinker.h
> > > include/linux/string.h
> > > include/linux/sunrpc/svc_xprt.h
> > > include/linux/tnum.h
> > > include/linux/trace_seq.h
> > > include/linux/usb.h
> > > include/linux/usb/gadget_configfs.h
> > 
> > Okay, revised as my regexp was too lazy
> > 
> > $ git grep -lw s[^[:space:]_]*printf -- include/linux/
> > include/linux/btf.h
> > include/linux/device-mapper.h
> > include/linux/efi.h
> > include/linux/fortify-string.h
> > include/linux/kdev_t.h
> > include/linux/kernel.h
> > include/linux/netlink.h
> > include/linux/pci-p2pdma.h
> > include/linux/perf_event.h
> > include/linux/sunrpc/svc_xprt.h
> > include/linux/tnum.h
> > include/linux/usb.h
> > include/linux/usb/gadget_configfs.h
> 
> This is only a tiny part of the picture.
> 
> $> git grep sc*n*printf | cut -d : -f1 | uniq | grep "\.c$" | wc -l
> 5254
> $> find . -name  "*.c" | wc -l
> 32319
> 
> It means that the vsprintf() family is used in 1/6 of all kernel
> source files. They would need to include one extra header.

No, not only one. more, but the outcome of this is not using what is not used
and unwinding the header dependency hell.

But hey, I am not talking about C files right now, it's secondary, however
in IIO we want to get rid of kernel.h in the C files as well.

Also, please, go through all of them and tell, how many of them are using
stuff from kernel.h besides sprintf.h and ARRAY_SIZE() (which I plan
for a long time to split from kernel.h)?

> If you split headers into so many small pieces then all
> source files will start with 3 screens of includes. I do not see
> how this helps with maintainability.

It should be a compromise. But including kernel.h mess into a file
(**especially** into header) for let's say a single sprintf() call
or use ARRAY_SIZE() macro is a bad idea. _This_ is not maintainable
code and developers definitely haven't put their brains to what they
are doing with the header inclusion block in their code.

-- 
With Best Regards,
Andy Shevchenko


