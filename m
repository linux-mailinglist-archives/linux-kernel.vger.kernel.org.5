Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A278077A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358769AbjHRIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358761AbjHRIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:50:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB87030E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692348649; x=1723884649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qhaO+gj765hRUFidmS/1grHiEzL0bDFlKqhb/fQCvJQ=;
  b=NmJbiZpDOlBgyf9ItVn4dIP7xpgz5lsK/esumVEkZIVqI6AFMlE6J3v/
   m1vcUwQi6obMTtfH9mS0U/hYG+NFL4NHU9RdyN0nGOwp7oa9Y4LKPXog6
   nOSIuOppDrYOceFIG/Jn3uuULFuivB56D1bAAhJmNGxy4mgIeVj+Z4WRF
   DZWVymaZsLgoL4ermuf1v8JBUyEdU6r2kD9Fjkvp2nl8TJV5JDQRjNC5Q
   2Qp360xOaWsRR3p34CI5iRJLGkDOp2Plxy/h5DPEzsmagPUdXlSmekR6s
   Qqn3zobpA2EAQ8+I7sUea6h85cjQg92Cskq5Lpgz596rDVlmKYt+o7fsd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="358015265"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="358015265"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 01:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="805078148"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="805078148"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2023 01:50:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWvBs-000MJ5-2C;
        Fri, 18 Aug 2023 11:50:44 +0300
Date:   Fri, 18 Aug 2023 11:50:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] bitmap: Use constants and macros from bits.h
Message-ID: <ZN8w5CbGn2CkYCDy@smile.fi.intel.com>
References: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
 <20230817165453.713353-2-andriy.shevchenko@linux.intel.com>
 <26fc3fb7-eb68-e5ff-ec86-67982734491e@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26fc3fb7-eb68-e5ff-ec86-67982734491e@rasmusvillemoes.dk>
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

On Fri, Aug 18, 2023 at 08:28:21AM +0200, Rasmus Villemoes wrote:
> On 17/08/2023 18.54, Andy Shevchenko wrote:

> >  #ifdef __LITTLE_ENDIAN
> > -#define BITMAP_MEM_ALIGNMENT 8
> > +#define BITMAP_MEM_ALIGNMENT	BITS_PER_BYTE
> >  #else
> > -#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
> > +#define BITMAP_MEM_ALIGNMENT	BITS_PER_LONG
> >  #endif
> >  #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)

What about this chunk? Does it worth to be updated?

...

> > -		return !memcmp(src1, src2, nbits / 8);
> > +		return !memcmp(src1, src2, BITS_TO_BYTES(nbits));
> 
> Please no. Currently, I can verify the arithmetic directly. Using such a
> "helper" I'd have to know whether it just does /8 or if it's more like
> the bitmap_words() thing which rounds up to a whole number of words. And
> BITS_PER_BYTE (and similarly CHAR_BITS) really is, IMO, much less
> readable than 8.

Okay, thank you for the comment!

-- 
With Best Regards,
Andy Shevchenko


