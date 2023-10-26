Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB857D825C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344871AbjJZMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:15:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F96B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698322548; x=1729858548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PVAv9bGwxt5kvEjJKPI54bMwvQAwbEv1pym1jtK6Uxg=;
  b=WK09NWvutb9wmQwR9t18v7+xDi2CbO94k7FR92U8HPhAcRkK/cpwhR52
   fqZinbG65vnn8BOjDXaxcg8lZxaxsjGqys1Ytxg+HJwEt/wfBdfLEVqJF
   1SmMr9TkFnxUTPSc1z9rDBsWaaoGycjWVjdjiwi3EIAxbkk5vzhjHYXYT
   3EEU+qsHtRTArfBxb2qR7Ht/NFJsYGhUrzyrA3kU8V5nRyWDI01bwQrHP
   ao8zrddBElZyY83pUE/E0jXan/OpageXFXD3AcQgmEo2pxvbmkRbxEHNu
   Op/mLwXMUx69fHzgIE6aov4yXWChgcBukbpxqXJ86E9ugjJf2V+UGzr14
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391395439"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391395439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="759164502"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="759164502"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:15:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvzH2-00000008qkb-2TBo;
        Thu, 26 Oct 2023 15:15:40 +0300
Date:   Thu, 26 Oct 2023 15:15:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/2] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZTpYbCa0Qmry0HGH@smile.fi.intel.com>
References: <20231025083812.456916-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025083812.456916-1-glider@google.com>
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

On Wed, Oct 25, 2023 at 10:38:11AM +0200, Alexander Potapenko wrote:
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

>   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> + *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
> + *                                              map at start
> + *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
> + *                                              map at start

I still didn't get the grouping you implied with this...

>   * Note, bitmap_zero() and bitmap_fill() operate over the region of
>   * unsigned longs, that is, bits behind bitmap till the unsigned long

...

> +/**
> + * bitmap_read - read a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
> + *
> + * Returns: value of nbits located at the @start bit offset within the @map
> + * memory region.
> + *
> + * Note: callers on 32-bit systems must be careful to not attempt reading more
> + * than sizeof(unsigned long).

sizeof() here is misleading, We talk about bits, BITS_PER_LONG (which is 32),
here it's better to be explicit that reading more than 32 bits at a time on
32-bit platform will return 0. Actually what you need is to describe...

> + */
> +static inline unsigned long bitmap_read(const unsigned long *map,
> +					unsigned long start,
> +					unsigned long nbits)
> +{
> +	size_t index = BIT_WORD(start);
> +	unsigned long offset = start % BITS_PER_LONG;
> +	unsigned long space = BITS_PER_LONG - offset;
> +	unsigned long value_low, value_high;
> +
> +	if (unlikely(!nbits || nbits > BITS_PER_LONG))
> +		return 0;

...this return in the Return section.

> +
> +	if (space >= nbits)
> +		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
> +
> +	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> +	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +	return (value_low >> offset) | (value_high << space);
> +}

...

> +/**
> + * bitmap_write - write n-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: value to write, clamped to nbits
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
> + *
> + * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
> + * i.e. bits beyond @nbits are ignored:
> + *
> + *   for (bit = 0; bit < nbits; bit++)
> + *           __assign_bit(start + bit, bitmap, val & BIT(bit));

> + * Note: callers on 32-bit systems must be careful to not attempt writing more
> + * than sizeof(unsigned long).

Ditto.

> + */

-- 
With Best Regards,
Andy Shevchenko


