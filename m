Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD3756574
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGQNtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:49:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84C94
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689601778; x=1721137778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DL4qBv+0R2QE3P5NAvRxV9T1ejT0QhIVEEVL302pr+o=;
  b=EDMORiEoX63U7s4ash/aubgK7MSHPDiHKKfWLrW9MM2h3KEFgZYiFV/K
   OalWUybCtyEtK5bFhualHmt7Uxo+R7kHEWSVLmSYsHdDE9zeuJscZdjaC
   pZrvIlIS4OMz4YV3P+7pJgLfuuOBaiZtgf1SAmx8SZ42DMUqDwy2F35CF
   ctvpL7h7eq0/+cnVB5JNMMkjjxyAqA6seHak3z0nYVR14lD9IcIFoQkZn
   lbFh1Xq01Yx7uuC08xchkIFt+CIq/uqYt8qXkAkCdndnfbhWfrisutSV/
   ujARTO31OryRf9UbiKJ4X7YBNAY6isYZAh+h2oFXJ67YrGzWp3gRxJWRf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345524965"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345524965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="1053913251"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053913251"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2023 06:49:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLObU-00GsY1-2w;
        Mon, 17 Jul 2023 16:49:32 +0300
Date:   Mon, 17 Jul 2023 16:49:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLVG7GCTTBV4odAG@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717113709.328671-4-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:37:06PM +0200, Alexander Potapenko wrote:
> The config implements the EA0 algorithm suggested by Evgenii Stepanov
> to compress the memory tags for ARM MTE during swapping.
> 
> The algorithm is based on RLE and specifically targets 128-byte buffers
> of tags corresponding to a single page. In the common case a buffer
> can be compressed into 63 bits, making it possible to store it without
> additional memory allocation.

...

> +config ARM64_MTE_COMP
> +	bool "Tag compression for ARM64 MTE"

At least here, make sure everybody understands what you are talking about. WTF
MTE is?

> +	default y
> +	depends on ARM64_MTE
> +	help
> +	  Enable tag compression support for ARM64 MTE.
> +
> +	  128-byte tag buffers corresponding to 4K pages can be compressed using
> +	  the EA0 algorithm to save heap memory.

>  config ARM64_SVE
>  	bool "ARM Scalable Vector Extension support"

You see the difference?

...

> +/*

Are you deliberately made it NON-kernel-doc? If so, why? And why does it
have too many similarities with above mentioned format?

> + * ea0_compress() - compress the given tag array.
> + * @tags: 128-byte array to read the tags from.
> + *
> + * Compresses the tags and returns a 64-bit opaque handle pointing to the
> + * tag storage. May allocate memory, which is freed by @ea0_release_handle().
> + */
> +unsigned long ea0_compress(u8 *tags);
> +
> +/*
> + * ea0_decompress() - decompress the tag array addressed by the handle.
> + * @handle: handle returned by @ea0_decompress()
> + * @tags: 128-byte array to write the tags to.
> + *
> + * Reads the compressed data and writes it into the user-supplied tag array.
> + * Returns true on success, false on error.

In case you are going to make them real kernel-doc:s, make sure kernel-doc
validator doesn't warn. Here, for example, return section is missing. The easy
fix is to add : after Returns. Same to the rest of function descriptions. Also
why you put the descriptions in to the header file? It's a bit unusual for the
exported ones.

> + */

...

> +/*
> + * ea0_tags_to_ranges() - break @tags into arrays of tag ranges.
> + * @tags: 128-byte array containing 256 MTE tags.
> + * @out_tags: u8 array to store the tag of every range.
> + * @out_sizes: u16 array to store the size of every range.

u16? I don't see it.

> + * @out_len: length of @out_tags and @out_sizes (output parameter, initially
> + *           equal to lengths of out_tags[] and out_sizes[]).
> + */

> +/*
> + * ea0_ranges_to_tags() - fill @tags using given tag ranges.
> + * @r_tags: u8[256] containing the tag of every range.
> + * @r_sizes: u16[256] containing the size of every range.

Ditto.

> + * @r_len: length of @r_tags and @r_sizes.
> + * @tags: 128-byte array to write the tags to.
> + */
> +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags);

In both cases signed integer may be promoted with a sign. Is it a problem here?

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

ea0_compress() is usual way how we refer to the functions. Let tools to make
the necessary references.

> + *     that can be stored in Xarray
> + *   ea0_decompress(*ptr, *tags) takes the opaque value and loads the tags into

Ditto. And so on.

> + *     the provided 128-byte buffer.
> + *
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

Is this chosen deliberately (for performance?)? Otherwise why not put them in
natural exponential growing?

> + *    Bit 63 of the pointer is zeroed out, so that it can be stored in Xarray.
> + *
> + * 6. The data layout in the allocated storage is as follows:
> + *         largest_idx : i6
> + *        r_tags[0..N] : i4 x N
> + *     r_sizes[0..N-1] : i7 x (N-1)
> + *
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

> +#include <linux/bits.h>
> +#include <linux/bitmap.h>

bitmap guarantees that bits.h will be included.

> +#include <linux/gfp.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/swab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>

...

> +void ea0_tags_to_ranges(u8 *tags, u8 *out_tags, short *out_sizes, int *out_len)
> +{
> +	u8 prev_tag = U8_MAX;

> +	int cur_idx = -1;

At which circumstances does this assignment make sense?

> +	u8 cur_tag;
> +	int i, j;
> +
> +	memset(out_tags, 0, array_size(*out_len, sizeof(*out_tags)));
> +	memset(out_sizes, 0, array_size(*out_len, sizeof(*out_sizes)));
> +
> +	for (i = 0; i < MTE_PAGE_TAG_STORAGE; i++) {
> +		for (j = 0; j < 2; j++) {
> +			cur_tag = j ? (tags[i] % 16) : (tags[i] / 16);
> +			if (cur_tag == prev_tag) {
> +				out_sizes[cur_idx]++;

Who guarantees this one is not [-1]?

> +			} else {

> +				cur_idx++;

Aha, above seems a bit prone to out of boundaries errors. Can you make it
unsigned and start from 0?

> +				prev_tag = cur_tag;
> +				out_tags[cur_idx] = prev_tag;
> +				out_sizes[cur_idx] = 1;
> +			}
> +		}
> +	}
> +	*out_len = cur_idx + 1;
> +}

...

> +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags)
> +{
> +	int i, j, pos = 0;

Wouldn't be more correct to have this assignment inside the first for-loop?

> +	u8 prev;
> +
> +	for (i = 0; i < r_len; i++) {
> +		for (j = 0; j < r_sizes[i]; j++) {
> +			if (pos % 2)
> +				tags[pos / 2] = (prev << 4) | r_tags[i];
> +			else
> +				prev = r_tags[i];
> +			pos++;
> +		}
> +	}
> +}

...

> +#define RANGES_INLINE ea0_size_to_ranges(8)

Don't forget to undef it when not needed.

...

> +static void bitmap_write(unsigned long *bitmap, unsigned long value,
> +			 unsigned long *pos, unsigned long bits)

Please, don't use reserved namespace. Yours is ea0, use it:
ea0_bitmap_write()! Same to other similarly named functions.

...

> +	unsigned long bit_pos = 0, l_bits;
> +	int largest_idx = -1, i;
> +	short largest = 0;

Here and elsewhere, please, double check the correctness and/or necessity of
signdness and assignments of local variables.

...

> +	for (i = 0; i < len; i++) {
> +		if (sizes[i] > largest) {

Here

		if (largest >= sizes[i])
			continue;
makes sense, but...

> +			largest = sizes[i];
> +			largest_idx = i;
> +		}
> +	}

...

> +	for (i = 0; i < len; i++) {
> +		if (i == largest_idx)
> +			continue;
> +		bitmap_write(bitmap, sizes[i], &bit_pos, BITS_PER_SIZE);

...here I would do the opposite since it's one liner.

> +	}

...

> +	u8 r_tags[256];
> +	int r_len = ARRAY_SIZE(r_tags);

sizeof() ?

...

> +	l_bits = (max_ranges == RANGES_INLINE) ? BITS_PER_LARGEST_IDX_INLINE :
> +						 BITS_PER_LARGEST_IDX;

Is it a dup? Perhaps a helper for this?

Seems BITS_PER_TAG, BITS_PER_SIZE and the rest should also be namespaced,
EA0_BITS_...

...

> +bool ea0_decompress(unsigned long handle, u8 *tags)
> +{
> +	unsigned long *storage = ea0_storage(handle);
> +	int size = ea0_storage_size(handle);
> +
> +	if (size == 128) {
> +		memcpy(tags, storage, size);
> +		return true;
> +	}
> +	if (size == 8)
> +		return ea0_decompress_from_buf(&handle, RANGES_INLINE, tags);

Maybe

	switch (ea0_storage_size(handle)) {
		...
	default:
	}

?

> +	return ea0_decompress_from_buf(storage, ea0_size_to_ranges(size), tags);
> +}

...

> +void ea0_release_handle(unsigned long handle)
> +{
> +	void *storage = ea0_storage(handle);
> +	int size = ea0_storage_size(handle);
> +	struct kmem_cache *c;

> +	if (!storage)
> +		return;

I find slightly better for maintaining in the form as

	struct kmem_cache *c;
	void *storage;
	int size;

	storage = ea0_storage(handle);
	if (!storage)
		return;

	size = ea0_storage_size(handle);

> +	c = mtecomp_caches[ea0_size_to_cache_id(size)];
> +	kmem_cache_free(c, storage);
> +}

...

> +static int mtecomp_init(void)
> +{
> +	char name[16];
> +	int size;
> +	int i;
> +
> +	BUILD_BUG_ON(MTE_PAGE_TAG_STORAGE != 128);

Why not static_assert()?

> +	for (i = 0; i < NUM_CACHES; i++) {
> +		size = ea0_cache_id_to_size(i);
> +		snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size);

sizeof() will work the same way without need of having kernel.h be included.

> +		mtecomp_caches[i] =
> +			kmem_cache_create(name, size, size, 0, NULL);
> +	}
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


