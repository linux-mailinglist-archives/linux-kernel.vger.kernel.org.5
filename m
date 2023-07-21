Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2243C75C5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGULWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGULWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:22:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA601996
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689938530; x=1721474530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=57KU9BS+4WtXtGFaL6wZCWV3ud+hpdZFulKGMvMZrP8=;
  b=gL88cQoecLwSmwrCuQ7mE4asKvCWtfWcyqDSoq4umvrJc9M6f2JUygMO
   WjReyVtZybeBhThVFEowQ08TCOX5vcn6RtpILjvyTnt3CMeRw1ZjzCA9c
   4zW+M7K2O5gYVpjjdZAJKCtoacgJGA7hK2SLuKerq2kTLxI8T5B8xXA9P
   UtsMTZ/L7qin0NsKHpcvqQLzDGcojTfbu/dciEmmKxC8SkHUou5Mzmgq/
   ueS1Ug+8VIjwlsLgH2t8+KN+JSw4Lk3ZimoxLfo4VZI5ONggHmARLQbpi
   NmzUx5Gwj9EFJ6h0Vaqe7Rj7JUB1JH0OAu8duN1hScnonUEdJVLtGURi5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433229016"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433229016"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971411749"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="971411749"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2023 04:22:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMoCz-001tP1-1g;
        Fri, 21 Jul 2023 14:22:05 +0300
Date:   Fri, 21 Jul 2023 14:22:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v4 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLpqXXLLj4vL/xaT@smile.fi.intel.com>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720173956.3674987-4-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:39:54PM +0200, Alexander Potapenko wrote:
> The config implements the algorithm compressing memory tags for ARM MTE
> during swapping.
> 
> The algorithm is based on RLE and specifically targets 128-byte buffers
> of tags corresponding to a single page. In the common case a buffer
> can be compressed into 63 bits, making it possible to store it without
> additional memory allocation.

...

> +Programming Interface
> +=====================
> +
> + .. kernel-doc:: arch/arm64/mm/mtecomp.c

:export:

> +

Is it dangling trailing blank line? Drop it.

...

> +#include <linux/bitmap.h>

> +#include <linux/bitops.h>

This is guaranteed to be included by bitmap.h.

> +#include <linux/export.h>
> +#include <linux/gfp.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>

...

> +/*
> + * Sizes of compressed values. These depend on MTE_TAG_SIZE and

of the

> + * MTE_GRANULES_PER_PAGE.
> + */

...

> +	u8 prev_tag = tags[0] / 16; /* First tag in the array. */
> +	unsigned int cur_idx = 0, i, j;
> +	u8 cur_tag;


> +	out_tags[0] = prev_tag;

out_tags[cur_idx] ?

> +	for (i = 0; i < MTE_PAGE_TAG_STORAGE; i++) {
> +		for (j = 0; j < 2; j++) {
> +			cur_tag = j ? (tags[i] % 16) : (tags[i] / 16);
> +			if (cur_tag == prev_tag) {
> +				out_sizes[cur_idx]++;

> +			} else {
> +				cur_idx++;
> +				prev_tag = cur_tag;
> +				out_tags[cur_idx] = prev_tag;
> +				out_sizes[cur_idx] = 1;

Looking more at this I think there is still a room for improvement. I can't
come up right now with a proposal (lunch time :-), but I would look into

	do {
		...
	} while (i < MTE_...);

approach.

> +			}
> +		}
> +	}

...

> +static size_t mte_size_to_ranges(size_t size)
> +{
> +	size_t largest_bits;

> +	size_t ret = 0;

Redundant assignment. Please, check again all of them.

> +
> +	largest_bits = (size == 8) ? MTE_BITS_PER_LARGEST_IDX_INLINE :
> +				     MTE_BITS_PER_LARGEST_IDX;
> +	ret = (size * 8 + MTE_BITS_PER_SIZE - largest_bits) /

Hmm... I thought that we moved BYTES_TO_BITS() to the generic header...
Okay, never mind.

> +	      (MTE_BITS_PER_TAG + MTE_BITS_PER_SIZE);
> +	return ret;

	return (...) / ...;

> +}

...

> +static size_t mte_alloc_size(unsigned int num_ranges)
> +{
> +	size_t sizes[4] = { 8, 16, 32, 64 };

Hooray! And now it's not needed anymore...

> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sizes); i++) {

...as sizes[i] is equivalent of (8 << i).

> +		if (num_ranges <= mte_size_to_ranges(sizes[i]))
> +			return sizes[i];
> +	}
> +	return 128;
> +}

> +}

...

> +/**
> + * mte_compress() - compress the given tag array.
> + * @tags: 128-byte array to read the tags from.
> + *
> + * Compresses the tags and returns a 64-bit opaque handle pointing to the
> + * tag storage. May allocate memory, which is freed by @mte_release_handle().

+ blank line here.

> + * Returns: 64-bit tag storage handle.
> + */

...

> +	/*
> +	 * mte_compress_to_buf() only initializes the bits that mte_decompress()
> +	 * will read. But when the tags are stored in the handle itself, it must
> +	 * have all its bits initialized.
> +	 */
> +	unsigned long result = 0;

	// Actually it's interesting how it's supposed to work on 32-bit
	// builds...
	DECLARE_BITMAP(result, BITS_PER_LONG);

and then

	bitmap_zero();

?

...

> +static unsigned long mte_bitmap_read(const unsigned long *bitmap,
> +				     unsigned long *pos, unsigned long bits)
> +{
> +	unsigned long result;
> +
> +	result = bitmap_read(bitmap, *pos, bits);
> +	*pos += bits;
> +	return result;

	unsigned long start = *pos;

	*pos += bits;
	return bitmap_read(bitmap, start, bits);

> +}

...

> +	unsigned short r_sizes[46], sum = 0;

See below.

...

It's cleaner and more robust to have

	sum = 0;

here.

> +	for (i = 0; i < max_ranges; i++) {
> +		if (i == largest_idx)
> +			continue;
> +		r_sizes[i] =
> +			mte_bitmap_read(bitmap, &bit_pos, MTE_BITS_PER_SIZE);
> +		if (!r_sizes[i]) {
> +			max_ranges = i;
> +			break;
> +		}
> +		sum += r_sizes[i];
> +	}
> +	if (sum >= 256)
> +		return false;

-- 
With Best Regards,
Andy Shevchenko


