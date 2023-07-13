Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99AA7529C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGMRXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGMRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:23:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F11BD4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689269025; x=1720805025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bx1BdNRJnkWtDRMYyPCzCyR8Hnmyh+FKNzK7EzNZyvg=;
  b=LP2QMpXR/7RWaDRz2zIk5RDdxBNA1RMjh5TQDq/TT4eJ7L9Y5Df+LMQn
   VPeDNczhpRdBl/VP5LC9TCEw6ohc1TYIRg0wRFUi5AbSzbbXi8HT8cTO0
   REkv6hYWEe6LPggJx919VipGBzArkq1liGsXR9SaDuDqFuGue5Lq/g2OH
   qsVP6syZnTAIctv/XvgxNqsIb1iOAFZhLqxEhEoJ00lVxbaNEMHfoQ9n8
   D7YyfayiYnNcNb0nD9KZ2k3cSo6eVTeZFu+M7kVgeEIhLPeX0e8UL4dA4
   fRZXkT27kdCe34dr7f0nmy8noavI6tdrCj7zkpJ/s5kbfZMBa4UUgt1Uv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="355196960"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="355196960"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 10:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846165621"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="846165621"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2023 10:23:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qK02V-002Rml-1q;
        Thu, 13 Jul 2023 20:23:39 +0300
Date:   Thu, 13 Jul 2023 20:23:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Subject: Re: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713125706.2884502-4-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:57:03PM +0200, Alexander Potapenko wrote:
> The config implements the EA0 algorithm suggested by Evgenii Stepanov
> to compress the memory tags for ARM MTE during swapping.
> 
> The algorithm is based on RLE and specifically targets 128-byte buffers
> of tags corresponding to a single page. In the common case a buffer
> can be compressed into 63 bits, making it possible to store it without
> additional memory allocation.

...

> +/*
> + * EA0 stands for "Evgenii's Algorithm 0", as the initial proposal contained two
> + * compression algorithms.
> + *
> + * The algorithm attempts to compress a 128-byte (MTE_GRANULES_PER_PAGE / 2)
> + * array of tags into a smaller byte sequence that can be stored in a
> + * 16-, 32-, or 64-byte buffer. A special case is storing the tags inline in
> + * an 8-byte pointer.
> + *
> + * We encapsulate tag storage memory management in this module, because it is
> + * tightly coupled with the pointer representation.
> + *   ea0_compress(*tags) takes a 128-byte buffer and returns an opaque value
> + *     that can be stored in Xarray
> + *   ea_decompress(*ptr, *tags) takes the opaque value and loads the tags into
> + *     the provided 128-byte buffer.

> + *
> + *
> + *

Isn't a bit too many blank lines?

> + * The compression algorithm works as follows.
> + *
> + * 1. The input array of 128 bytes is transformed into tag ranges (two arrays:
> + *    @r_tags containing tag values and @r_sizes containing range lengths) by
> + *    ea0_tags_to_ranges(). Note that @r_sizes sums up to 256.
> + *
> + * 2. Depending on the number N of ranges, the following storage class is picked:
> + *            N <= 6:  8 bytes (inline case, no allocation required);
> + *       6 < N <= 11: 16 bytes
> + *      11 < N <= 23: 32 bytes
> + *      23 < N <= 46: 64 bytes
> + *      46 < N:       128 bytes (no compression will be performed)
> + *
> + * 3. The number of the largest element of @r_sizes is stored in @largest_idx.
> + *    The element itself is thrown away from @r_sizes, because it can be
> + *    reconstructed from the sum of the remaining elements. Note that now none
> + *    of the remaining @r_sizes elements is greater than 127.
> + *
> + * 4. For the inline case, the following values are stored in the 8-byte handle:
> + *       largest_idx : i4
> + *      r_tags[0..5] : i4 x 6
> + *     r_sizes[0..4] : i7 x 5
> + *    (if N is less than 6, @r_tags and @r_sizes are padded up with zero values)
> + *
> + *    Because @largest_idx is <= 5, bit 63 of the handle is always 0 (so it can
> + *    be stored in the Xarray), and bits 62..60 cannot all be 1, so it can be
> + *    distinguished from a kernel pointer.
> + *
> + * 5. For the out-of-line case, the storage is allocated from one of the
> + *    "mte-tags-{16,32,64,128}" kmem caches. The resulting pointer is aligned
> + *    on 8 bytes, so its bits 2..0 can be used to store the size class:
> + *     - 0 for 128 bytes
> + *     - 1 for 16
> + *     - 2 for 32
> + *     - 4 for 64.
> + *    Bit 63 of the pointer is zeroed out, so that it can be stored in Xarray.
> + *
> + * 6. The data layout in the allocated storage is as follows:
> + *         largest_idx : i6
> + *        r_tags[0..N] : i4 x N
> + *     r_sizes[0..N-1] : i7 x (N-1)
> + *
> + *
> + *

Ditto.

> + * The decompression algorithm performs the steps below.
> + *
> + * 1. Decide if data is stored inline (bits 62..60 of the handle != 0b111) or
> + *    out-of line.
> + *
> + * 2. For the inline case, treat the handle itself as the input buffer.
> + *
> + * 3. For the out-of-line case, look at bits 2..0 of the handle to understand
> + *    the input buffer length. To obtain the pointer to the input buffer, unset
> + *    bits 2..0 of the handle and set bit 63.
> + *
> + * 4. If the input buffer is 128 byte long, copy its contents to the output
> + *    buffer.
> + *
> + * 5. Otherwise, read @largest_idx, @r_tags and @r_sizes from the input buffer.
> + *    Calculate the removed largest element of @r_sizes:
> + *      largest = 256 - sum(r_sizes)
> + *    and insert it into @r_sizes at position @largest_idx.
> + *
> + * 6. While @r_sizes[i] > 0, add a 4-bit value @r_tags[i] to the output buffer
> + *    @r_sizes[i] times.
> + */

...

> +#include <linux/bitmap.h>
> +#include <linux/gfp.h>
> +#include <linux/module.h>
> +#include <asm/mtecomp.h>
> +#include <linux/slab.h>
> +#include <linux/swab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>

Please, keep linux/* and asm/* separated like

linux/*
...blank line...
asm/*

...

> +#define HANDLE_MASK ~(BIT_ULL(63))

GENMASK_ULL(62, 0)

...

> +/* Out-of-line handles have 0b111 in bits 62..60. */
> +#define NOINLINE_MASK (BIT_ULL(62) | BIT_ULL(61) | BIT_ULL(60))

GENMASK_ULL()?

...

> +/* Cache index is stored in the lowest pointer bits. */
> +#define CACHE_ID_MASK (BIT_ULL(2) | BIT_ULL(1) | BIT_ULL(0))

Ditto.

...

> +/* Translate allocation size into mtecomp_caches[] index. */
> +static int ea0_size_to_cache_id(int len)
> +{
> +	switch (len) {
> +	case 16:
> +		return 1;
> +	case 32:
> +		return 2;
> +	case 64:
> +		return 3;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/* Translate mtecomp_caches[] index into allocation size. */
> +static int ea0_cache_id_to_size(int id)
> +{
> +	switch (id) {
> +	case 1:
> +		return 16;
> +	case 2:
> +		return 32;
> +	case 3:
> +		return 64;
> +	default:
> +		return 128;
> +	}
> +}

Not sure why fls() / BIT() can't be used directly instead of these functions,
but okay, they are not too ugly.

...

> +void ea0_tags_to_ranges(u8 *tags, u8 *out_tags, short *out_sizes, int *out_len)
> +{
> +	u8 prev_tag = 0xff;

GENMASK()? U8_MAX? ((u8)-1)? What is this?

> +	int cur_idx = -1;
> +	u8 cur_tag;
> +	int i;
> +
> +	memset(out_tags, 0, *out_len * sizeof(*out_tags));
> +	memset(out_sizes, 0, *out_len * sizeof(*out_sizes));

array_size() ?

> +	for (i = 0; i < MTE_GRANULES_PER_PAGE; i++) {
> +		cur_tag = tags[i / 2];
> +		if (i % 2)
> +			cur_tag = cur_tag % 16;
> +		else
> +			cur_tag = cur_tag / 16;
> +		if (cur_tag == prev_tag) {
> +			out_sizes[cur_idx]++;
> +		} else {
> +			cur_idx++;
> +			prev_tag = cur_tag;
> +			out_tags[cur_idx] = prev_tag;
> +			out_sizes[cur_idx] = 1;
> +		}

Perhaps instead of doing those % 2, / 2 we simply can go twice less outer loops
and introduce an inner loop of 2 iterations?

> +	}
> +	*out_len = cur_idx + 1;
> +}

> +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags)
> +{
> +	int i, j, pos = 0;
> +	u8 prev;
> +
> +	for (i = 0; i < r_len; i++) {
> +		for (j = 0; j < r_sizes[i]; j++) {

> +			if (pos % 2 == 0)

Would be better to keep this aligned with above?

			if (pos % 2)
				...
			else
				...

> +				prev = r_tags[i];
> +			else
> +				tags[pos / 2] = (prev << 4) | r_tags[i];
> +			pos++;
> +		}
> +	}
> +}

...

> +EXPORT_SYMBOL(ea0_storage_size);

Btw, can we go to the namespaced export from day 1?

...

> +	for (i = 0; i < len; i++) {
> +		if (i == len)
> +			break;

Interesting dead code. What was the idea behind this?

> +		if (sizes[i] > largest) {
> +			largest = sizes[i];
> +			largest_idx = i;
> +		}

(alas max_array() can't be used here)

...

> +		bitmap_set_value_unaligned((unsigned long *)buf, largest_idx,
> +					   bit_pos, 4);

> +		bitmap_set_value_unaligned((unsigned long *)buf, largest_idx,
> +					   bit_pos, 6);

> +		bitmap_set_value_unaligned((unsigned long *)buf, tags[i],
> +					   bit_pos, 4);

> +		bitmap_set_value_unaligned((unsigned long *)buf, 0, bit_pos, 4);

> +		bitmap_set_value_unaligned((unsigned long *)buf, sizes[i],
> +					   bit_pos, 7);

> +	largest_idx = bitmap_get_value_unaligned((unsigned long *)buf, bit_pos,
> +						 l_bits);

> +		r_tags[i] = bitmap_get_value_unaligned((unsigned long *)buf,
> +						       bit_pos, 4);

> +		r_sizes[i] = bitmap_get_value_unaligned((unsigned long *)buf,
> +							bit_pos, 7);

These castings is a red flag. bitmap API shouldn't be used like this. Something
is not okay here.

...

> +void ea0_release_handle(u64 handle)
> +{
> +	void *storage = ea0_storage(handle);
> +	int size = ea0_storage_size(handle);
> +	struct kmem_cache *c;

> +	if (!handle || !storage)
> +		return;

You use handle before this check. Haven't you run static analysers?

...

> +static int mtecomp_init(void)
> +{
> +	char name[16];
> +	int size;
> +	int i;
> +
> +	for (i = 0; i < NUM_CACHES; i++) {
> +		size = ea0_cache_id_to_size(i);
> +		snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size);
> +		mtecomp_caches[i] =
> +			kmem_cache_create(name, size, size, 0, NULL);
> +	}
> +	return 0;
> +}

> +

Unneeded blank line.

> +module_init(mtecomp_init);

-- 
With Best Regards,
Andy Shevchenko


