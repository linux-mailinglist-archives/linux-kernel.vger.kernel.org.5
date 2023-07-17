Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA45F7563B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGQNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGQNBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:01:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB2910D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689598901; x=1721134901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tzfUG3T9R5xA1Az/0hFpDgAGrXYHZyUOT9AfXcFaeG8=;
  b=BSE8225G4aaA5I/YrzbEGSkwjBN/By4nPRe7HNe6gDMZcDrYOJqj7Ko3
   MNkFjLEoLqFUYU4Wm2NP1RLP8f0DaA9pTjU5Rd0ZexUaH+M+s5flF/7aB
   /rajoa+pR4EPDa3P/1l5yaLd1faKF9ocjHnIY3jINpwc3npL1axiUDFvM
   xaIboxEnmZ7pfLJ1HPS6sMRUZMx9/hdSLp8/YMAGIOyXtC/zOEzbxzYxG
   FCU1i7nN+Wc6q/6cna0RFWPUc7igh9HTc0zT6QvPqpNpirOy6rt/7Yrp8
   y7MtreVtlDVPPzUtihZI18Z9kGI6A3KBSO8qFYyWC+lSGbv3xThNviTjI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="363386074"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363386074"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="752888414"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752888414"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 06:01:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLNqk-00F7Nq-1r;
        Mon, 17 Jul 2023 16:01:14 +0300
Date:   Mon, 17 Jul 2023 16:01:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZLU7mkhUiDQodaw1@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717113709.328671-2-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:37:04PM +0200, Alexander Potapenko wrote:
> The two new functions allow setting/getting values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
> 
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a couple of minor changes:

Since changes are minor, please make sure that the authorship is kept
untouched.

>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value())

> Cc: Arnd Bergmann <arnd@arndb.de>

You can use --cc to `git send-email` instead of polluting the commit message.

> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

With above, I think you can also add Co-developed-by (as the changes were
made).

...

> +static inline void bitmap_set_value(unsigned long *map,
> +				    unsigned long value,
> +				    unsigned long start, unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +	const unsigned long space = BITS_PER_LONG - offset;
> +
> +	value &= GENMASK(nbits - 1, 0);
> +
> +	if (space >= nbits) {

> +		map[index] &= ~(GENMASK(nbits + offset - 1, offset));

I remember that this construction may bring horrible code on some architectures
with some version(s) of the compiler (*).

To fix that I found an easy refactoring:

		map[index] &= ~(GENMASK(nbits, 0) << offset));


(*) don't remember the actual versions, though, but anyway...

> +		map[index] |= value << offset;
> +		return;
> +	}
> +	map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +	map[index] |= value << offset;
> +	map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +	map[index + 1] |= (value >> space);
> +}

-- 
With Best Regards,
Andy Shevchenko


