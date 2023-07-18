Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA147757EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjGROEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjGROEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:04:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBE72103
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689689003; x=1721225003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/mJ3Wv9KMmTSUv2ljgFK3PwPh1Z2nSfs4nN171S3JRk=;
  b=KUn/v+E3oSP6scinue5IF6Sv8WXWDqBiZGCMhtWwlucrYp28cHKVJ8Nf
   mzC+eZKMid1Pmgy6Gt3FmpagdXgWTUdlWAMz3VtwPi15lzhoZMGDvrJb/
   2wHApzQHjV5BQVwKvO4KbRNMvSMMUm8LVD25jHA4oW90Z1vMr0vwQSuiF
   qRBbRh6tWjLM59K4zIntpRoJpYNzN7E57FuZBIcNe7IErqtL8B+vhAZgK
   PjWTUWHQ8hfgOI8ikF98p8rb9Lawe74RfFZuYak0mUEM7c6lt2W1LXVTt
   FtIk3OYatdE5YyDjsu4DK+Z0pBHBck4v1x92A2cxECH8p4BB3AqTlq41e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="351078335"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="351078335"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867085441"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2023 07:01:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlGb-00GCGc-0B;
        Tue, 18 Jul 2023 17:01:29 +0300
Date:   Tue, 18 Jul 2023 17:01:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLabOHmNQm2EOXWR@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
 <ZLVjYzuxlJAQVpIO@yury-ThinkPad>
 <CAG_fn=UPqyFhEMLDz3nhc7fgpCvprLsYrNjUnw3z4KfWCJGTHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=UPqyFhEMLDz3nhc7fgpCvprLsYrNjUnw3z4KfWCJGTHA@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 11:30:00AM +0200, Alexander Potapenko wrote:
> On Mon, Jul 17, 2023 at 5:51 PM Yury Norov <yury.norov@gmail.com> wrote:
> > On Mon, Jul 17, 2023 at 01:37:04PM +0200, Alexander Potapenko wrote:

...

> > When nbits == 0, copy-like functions shouldn't touch any memory. See how
> > other bitmap and find_bit functions hold it.
> 
> I think this is different from what other bitmap functions do, but it
> should be enough to bail out on !nbits, i.e.:
> 
>     if (!nbits)
>         return 0;
> 
> You probably meant adding a __builtin_constant_p() (which is used all
> over the place in bitmap.h), but:
>  - the compiler won't have problem optimizing away the code for a
> constant nbits=0;
>  - we anyway need a dynamic check for the case nbits is not constant
> (for both bitmap_get_value() and bitmap_set_value(), I assume).
> 
> What do you think?

The idea behind is to eliminate the code completely for the cases nbits != 0.
In your case the dynamic check will be there. That's what we want to avoid.

-- 
With Best Regards,
Andy Shevchenko


