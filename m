Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8D7BBAB8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjJFOsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJFOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:47:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E51A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696603677; x=1728139677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q6cQelynE4rTwAzTODBvQckDdOlp9FgcGKV65uBI6Pw=;
  b=ajoWItSFg/Gxuww7DJ6z5RiA57pPLUg01HMZHE1a8DmCxQg8+I39NGJE
   xE9fp5oQlnSwjIyCtG0wH/wzNUArleOg+MXFvg/MbJBTWwLlne2d3xeur
   O+a6IayskSFQGIpnnOM3TscBvhlQWJUJVP8LTyTydGVXD1klw3FnZS9Iq
   MldsuNOl6gh8r+wvlC36wxKfn+S9DnY2I7QU66Mudr9ycsMHI5MeAgJ7l
   zxlQEl7oHo0dthgzEsUElmIDwcRvbvGj4YU3j9oBaaEA8okmtJg51KD7F
   8iMpBWTobLMq9OSSiG8YvlWUqCVc/U5t3Rn/tr256QYVgYCGjC9don5VU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387642136"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387642136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="752212944"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="752212944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:47:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qom7K-00000003L89-0Ik7;
        Fri, 06 Oct 2023 17:47:50 +0300
Date:   Fri, 6 Oct 2023 17:47:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZSAeFfNOUZIrK3Yk@smile.fi.intel.com>
References: <20231006134529.2816540-1-glider@google.com>
 <20231006134529.2816540-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006134529.2816540-2-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 03:45:25PM +0200, Alexander Potapenko wrote:
> From: Syed Nayyar Waris <syednwaris@gmail.com>
> 
> The two new functions allow reading/writing values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
> 
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a number of changes and simplifications:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value());
>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>    and bitmap_write();
>  - some redundant computations are omitted.

...

> v6:
>  - As suggested by Yury Norov, do not require bitmap_read(..., 0) to
>    return 0.

Hmm... See below.

...

>   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
>   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst

With the grouping as below I would add a blank line here. But was the intention
to group _arrXX() to these groups?

>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> + *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
> + *                                              map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> + *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
> + *                                              map at start

...

> +static inline unsigned long bitmap_read(const unsigned long *map,
> +					unsigned long start,
> +					unsigned long nbits)
> +{
> +	size_t index = BIT_WORD(start);
> +	unsigned long offset = start % BITS_PER_LONG;
> +	unsigned long space = BITS_PER_LONG - offset;
> +	unsigned long value_low, value_high;

> +	if (unlikely(!nbits))
> +		return 0;

Hmm... I didn't get was the comment to add or to remove these checks?

> +	if (space >= nbits)
> +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);

And don't you want to replace this GENMASK() as well?

> +	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> +	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +	return (value_low >> offset) | (value_high << space);
> +}

-- 
With Best Regards,
Andy Shevchenko


