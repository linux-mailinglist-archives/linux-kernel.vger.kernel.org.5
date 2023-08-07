Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA8D7728D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjHGPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjHGPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:14:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBC1724
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691421243; x=1722957243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1SxUmllyrZYOqY+hP7Ch9lDxmaUl+LSb6ThFxH7GYGU=;
  b=BI/oZ3LTlpjvfQmryEPTblTIMNHAITMRGa+Ml8DcReNcKTPgGP+tV1ct
   49oNPZP+IbPyIBXD/tT/d01aKVi7IQGz63xHW3QbMlBZq+uU+r9Bk/vIG
   o0gA5pjNVEaPHJxXGzAqtQwRy3C27/ERsITj0jEefZ/cac8NmA2VpB5WM
   GPDSwyjciXnM5Q0rOBEuAtLQqjnVl0Yiqs+ZOgjIG2dBXV1Uydm1JGt+7
   Rn2E3lhwZOpj4078xWC4NTViHGn+xrcKruTYuNqOtk4D6Z1OCbbWNYiUj
   5DW2g2nncluzeWi3xf1ZRIqCphIfOag1lNuCP9GiP44dPsYgA/F1DxvHA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360656650"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="360656650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760531465"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="760531465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 08:13:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1vh-00GtLP-22;
        Mon, 07 Aug 2023 18:13:57 +0300
Date:   Mon, 7 Aug 2023 18:13:57 +0300
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
Message-ID: <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 06:11:24PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 07, 2023 at 06:09:54PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 07, 2023 at 05:03:19PM +0200, Petr Mladek wrote:
> > > On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:

...

> > > How does this sound, please?
> > 
> > Not every user (especially _header_) wants to have printk.h included just for
> > sprintf.h that may have nothing to do with real output. So, same reasoning
> > from me as keeping that in kernel.h, i.e. printk.h no better.
> 
> (haven't check these, just to show how many _headers_ uses sprintf() call)
> 
> $ git grep -lw s.*printf -- include/linux/
> include/linux/acpi.h
> include/linux/audit.h
> include/linux/btf.h
> include/linux/dev_printk.h
> include/linux/device-mapper.h
> include/linux/efi.h
> include/linux/fortify-string.h
> include/linux/fs.h
> include/linux/gameport.h
> include/linux/kdb.h
> include/linux/kdev_t.h
> include/linux/kernel.h
> include/linux/mmiotrace.h
> include/linux/netlink.h
> include/linux/pci-p2pdma.h
> include/linux/perf_event.h
> include/linux/printk.h
> include/linux/seq_buf.h
> include/linux/seq_file.h
> include/linux/shrinker.h
> include/linux/string.h
> include/linux/sunrpc/svc_xprt.h
> include/linux/tnum.h
> include/linux/trace_seq.h
> include/linux/usb.h
> include/linux/usb/gadget_configfs.h

Okay, revised as my regexp was too lazy

$ git grep -lw s[^[:space:]_]*printf -- include/linux/
include/linux/btf.h
include/linux/device-mapper.h
include/linux/efi.h
include/linux/fortify-string.h
include/linux/kdev_t.h
include/linux/kernel.h
include/linux/netlink.h
include/linux/pci-p2pdma.h
include/linux/perf_event.h
include/linux/sunrpc/svc_xprt.h
include/linux/tnum.h
include/linux/usb.h
include/linux/usb/gadget_configfs.h


-- 
With Best Regards,
Andy Shevchenko


