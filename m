Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4225375220B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjGMM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjGMM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE0173B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so596908276.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689253055; x=1691845055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gj4eacZ7u0TYs1+VtoNyY+f/L6MZ9TJLIuNpJdtqlH8=;
        b=vWSzm6VmSUHA1eKL56ezPYbSxbiC4K2GMyF9+/+iS1xukhlImcrV8hhIQKjKxrkKtr
         RXwzzKVIU9lSsP4iQjQjHRJ2L8rG9Svuhpb1PHBcVU/abOFQKT6MQQClFj/F/pAPvMXJ
         dLr7katuacqVhZiYQrzyn3vRjR7P3uyYSce8Efg/KnBxau//aNmCIJVG7Zzoh6Qf8XWv
         UXEpNsagWFCUiCdpvlWZYXJLDgKj0QrvUUZRntY8Xp3jNz3YKj8Ez57uv+WWmSHzY2eu
         8BCChYRDAJ2jr9aZbn48Qynyz+/WDqFRLwOYhFX+hju1EIpoO/lqyU6/ujBzrjrslw3V
         V7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253055; x=1691845055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gj4eacZ7u0TYs1+VtoNyY+f/L6MZ9TJLIuNpJdtqlH8=;
        b=UyLiloJdbcO5ewyj8NVKvhy3vc834Ids0t3hZmL7MU5O+ARtZ7oeQY+tavXqRVJgat
         9XLYoeephZXItbBME7qiyHMpORxRex+zoYY657Hw2kPRWxftDOp/Ys/5UdR/wSyjlpqR
         ZEg41TNrFaVghmdKHTAWRJrTOvNvfqBaFCrR8E6ryK2miN+MhLLmziqTVqT0BUcCBSpS
         Hf7XMyTq2WYStTg2+EiF8jiXswBEvIysvhwM66So7Wn+jYERFb35UmO77jtYxBrPHKoh
         8rGnQKetBl/yGlsyABMqgyV4jQTpVuG7clHCYpsiFlOJGtnJWMoZ0Lwj6nl09VoVM+n9
         mv9A==
X-Gm-Message-State: ABy/qLZXeiu/Yxe6ZHiO+qxKApe2vgskV9h9KdW0h6UcquI6SYkKS6S8
        GAKGzG+YVdUam1n1BALnBtGDZ5bWKfY=
X-Google-Smtp-Source: APBJJlF0pXpAbiiBxXoxQba0L+m/+yPSdYlI36cxdumBJYS89vRavjKjsLMrP5WyNUADwhRqjoijimELJhk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7a88:66b7:31e5:7d85])
 (user=glider job=sendgmr) by 2002:a05:6902:1ce:b0:c85:d53:2aef with SMTP id
 u14-20020a05690201ce00b00c850d532aefmr6871ybh.12.1689253055149; Thu, 13 Jul
 2023 05:57:35 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:57:03 +0200
In-Reply-To: <20230713125706.2884502-1-glider@google.com>
Mime-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713125706.2884502-4-glider@google.com>
Subject: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config implements the EA0 algorithm suggested by Evgenii Stepanov
to compress the memory tags for ARM MTE during swapping.

The algorithm is based on RLE and specifically targets 128-byte buffers
of tags corresponding to a single page. In the common case a buffer
can be compressed into 63 bits, making it possible to store it without
additional memory allocation.

Suggested-by: Evgenii Stepanov <eugenis@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
 v2:
  - as suggested by Yuri Norov, switched from struct bitq (which is
    not needed anymore) to <linux/bitmap.h>
  - add missing symbol exports
---
 arch/arm64/Kconfig               |  10 +
 arch/arm64/include/asm/mtecomp.h |  60 +++++
 arch/arm64/mm/Makefile           |   1 +
 arch/arm64/mm/mtecomp.c          | 412 +++++++++++++++++++++++++++++++
 4 files changed, 483 insertions(+)
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7856c3a3e35af..0aa727888e746 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2091,6 +2091,16 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+config ARM64_MTE_COMP
+	bool "Tag compression for ARM64 MTE"
+	default y
+	depends on ARM64_MTE
+	help
+	  Enable tag compression support for ARM64 MTE.
+
+	  128-byte tag buffers corresponding to 4K pages can be compressed using
+	  the EA0 algorithm to save heap memory.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/include/asm/mtecomp.h b/arch/arm64/include/asm/mtecomp.h
new file mode 100644
index 0000000000000..65a3730cc50d9
--- /dev/null
+++ b/arch/arm64/include/asm/mtecomp.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_MTECOMP_H
+#define __ASM_MTECOMP_H
+
+#include <linux/types.h>
+
+/*
+ * ea0_compress() - compress the given tag array.
+ * @tags: 128-byte array to read the tags from.
+ *
+ * Compresses the tags and returns a 64-bit opaque handle pointing to the
+ * tag storage. May allocate memory, which is freed by @ea0_release_handle().
+ */
+u64 ea0_compress(u8 *tags);
+
+/*
+ * ea0_decompress() - decompress the tag array addressed by the handle.
+ * @handle: handle returned by @ea0_decompress()
+ * @tags: 128-byte array to write the tags to.
+ *
+ * Reads the compressed data and writes it into the user-supplied tag array.
+ * Returns true on success, false on error.
+ */
+bool ea0_decompress(u64 handle, u8 *tags);
+
+/*
+ * ea0_release_handle() - release the handle returned by ea0_compress().
+ * @handle: handle returned by ea0_compress().
+ */
+void ea0_release_handle(u64 handle);
+
+/* Functions below are exported for testing purposes. */
+
+/*
+ * ea0_storage_size() - calculate the memory occupied by compressed tags.
+ * @handle: storage handle returned by ea0_compress.
+ */
+int ea0_storage_size(u64 handle);
+
+/*
+ * ea0_tags_to_ranges() - break @tags into arrays of tag ranges.
+ * @tags: 128-byte array containing 256 MTE tags.
+ * @out_tags: u8 array to store the tag of every range.
+ * @out_sizes: u16 array to store the size of every range.
+ * @out_len: length of @out_tags and @out_sizes (output parameter, initially
+ *           equal to lengths of out_tags[] and out_sizes[]).
+ */
+void ea0_tags_to_ranges(u8 *tags, u8 *out_tags, short *out_sizes, int *out_len);
+
+/*
+ * ea0_ranges_to_tags() - fill @tags using given tag ranges.
+ * @r_tags: u8[256] containing the tag of every range.
+ * @r_sizes: u16[256] containing the size of every range.
+ * @r_len: length of @r_tags and @r_sizes.
+ * @tags: 128-byte array to write the tags to.
+ */
+void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags);
+
+#endif // __ASM_MTECOMP_H
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index dbd1bc95967d0..46778f6dd83c2 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
 obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
+obj-$(CONFIG_ARM64_MTE_COMP)	+= mtecomp.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/mtecomp.c b/arch/arm64/mm/mtecomp.c
new file mode 100644
index 0000000000000..e6c1026bd7e89
--- /dev/null
+++ b/arch/arm64/mm/mtecomp.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * MTE tag compression algorithm.
+ * Proposed by Evgenii Stepanov <eugenis@google.com>
+ */
+
+/*
+ * EA0 stands for "Evgenii's Algorithm 0", as the initial proposal contained two
+ * compression algorithms.
+ *
+ * The algorithm attempts to compress a 128-byte (MTE_GRANULES_PER_PAGE / 2)
+ * array of tags into a smaller byte sequence that can be stored in a
+ * 16-, 32-, or 64-byte buffer. A special case is storing the tags inline in
+ * an 8-byte pointer.
+ *
+ * We encapsulate tag storage memory management in this module, because it is
+ * tightly coupled with the pointer representation.
+ *   ea0_compress(*tags) takes a 128-byte buffer and returns an opaque value
+ *     that can be stored in Xarray
+ *   ea_decompress(*ptr, *tags) takes the opaque value and loads the tags into
+ *     the provided 128-byte buffer.
+ *
+ *
+ *
+ * The compression algorithm works as follows.
+ *
+ * 1. The input array of 128 bytes is transformed into tag ranges (two arrays:
+ *    @r_tags containing tag values and @r_sizes containing range lengths) by
+ *    ea0_tags_to_ranges(). Note that @r_sizes sums up to 256.
+ *
+ * 2. Depending on the number N of ranges, the following storage class is picked:
+ *            N <= 6:  8 bytes (inline case, no allocation required);
+ *       6 < N <= 11: 16 bytes
+ *      11 < N <= 23: 32 bytes
+ *      23 < N <= 46: 64 bytes
+ *      46 < N:       128 bytes (no compression will be performed)
+ *
+ * 3. The number of the largest element of @r_sizes is stored in @largest_idx.
+ *    The element itself is thrown away from @r_sizes, because it can be
+ *    reconstructed from the sum of the remaining elements. Note that now none
+ *    of the remaining @r_sizes elements is greater than 127.
+ *
+ * 4. For the inline case, the following values are stored in the 8-byte handle:
+ *       largest_idx : i4
+ *      r_tags[0..5] : i4 x 6
+ *     r_sizes[0..4] : i7 x 5
+ *    (if N is less than 6, @r_tags and @r_sizes are padded up with zero values)
+ *
+ *    Because @largest_idx is <= 5, bit 63 of the handle is always 0 (so it can
+ *    be stored in the Xarray), and bits 62..60 cannot all be 1, so it can be
+ *    distinguished from a kernel pointer.
+ *
+ * 5. For the out-of-line case, the storage is allocated from one of the
+ *    "mte-tags-{16,32,64,128}" kmem caches. The resulting pointer is aligned
+ *    on 8 bytes, so its bits 2..0 can be used to store the size class:
+ *     - 0 for 128 bytes
+ *     - 1 for 16
+ *     - 2 for 32
+ *     - 4 for 64.
+ *    Bit 63 of the pointer is zeroed out, so that it can be stored in Xarray.
+ *
+ * 6. The data layout in the allocated storage is as follows:
+ *         largest_idx : i6
+ *        r_tags[0..N] : i4 x N
+ *     r_sizes[0..N-1] : i7 x (N-1)
+ *
+ *
+ *
+ * The decompression algorithm performs the steps below.
+ *
+ * 1. Decide if data is stored inline (bits 62..60 of the handle != 0b111) or
+ *    out-of line.
+ *
+ * 2. For the inline case, treat the handle itself as the input buffer.
+ *
+ * 3. For the out-of-line case, look at bits 2..0 of the handle to understand
+ *    the input buffer length. To obtain the pointer to the input buffer, unset
+ *    bits 2..0 of the handle and set bit 63.
+ *
+ * 4. If the input buffer is 128 byte long, copy its contents to the output
+ *    buffer.
+ *
+ * 5. Otherwise, read @largest_idx, @r_tags and @r_sizes from the input buffer.
+ *    Calculate the removed largest element of @r_sizes:
+ *      largest = 256 - sum(r_sizes)
+ *    and insert it into @r_sizes at position @largest_idx.
+ *
+ * 6. While @r_sizes[i] > 0, add a 4-bit value @r_tags[i] to the output buffer
+ *    @r_sizes[i] times.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/gfp.h>
+#include <linux/module.h>
+#include <asm/mtecomp.h>
+#include <linux/slab.h>
+#include <linux/swab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+/* The handle must fit into an Xarray value. */
+#define HANDLE_MASK ~(BIT_ULL(63))
+
+/* Out-of-line handles have 0b111 in bits 62..60. */
+#define NOINLINE_MASK (BIT_ULL(62) | BIT_ULL(61) | BIT_ULL(60))
+
+/* Cache index is stored in the lowest pointer bits. */
+#define CACHE_ID_MASK (BIT_ULL(2) | BIT_ULL(1) | BIT_ULL(0))
+
+/* Four separate caches to store out-of-line data. */
+#define NUM_CACHES 4
+static struct kmem_cache *mtecomp_caches[NUM_CACHES];
+
+/* Translate allocation size into mtecomp_caches[] index. */
+static int ea0_size_to_cache_id(int len)
+{
+	switch (len) {
+	case 16:
+		return 1;
+	case 32:
+		return 2;
+	case 64:
+		return 3;
+	default:
+		return 0;
+	}
+}
+
+/* Translate mtecomp_caches[] index into allocation size. */
+static int ea0_cache_id_to_size(int id)
+{
+	switch (id) {
+	case 1:
+		return 16;
+	case 2:
+		return 32;
+	case 3:
+		return 64;
+	default:
+		return 128;
+	}
+}
+
+/* Transform tags into tag ranges. */
+void ea0_tags_to_ranges(u8 *tags, u8 *out_tags, short *out_sizes, int *out_len)
+{
+	u8 prev_tag = 0xff;
+	int cur_idx = -1;
+	u8 cur_tag;
+	int i;
+
+	memset(out_tags, 0, *out_len * sizeof(*out_tags));
+	memset(out_sizes, 0, *out_len * sizeof(*out_sizes));
+	for (i = 0; i < MTE_GRANULES_PER_PAGE; i++) {
+		cur_tag = tags[i / 2];
+		if (i % 2)
+			cur_tag = cur_tag % 16;
+		else
+			cur_tag = cur_tag / 16;
+		if (cur_tag == prev_tag) {
+			out_sizes[cur_idx]++;
+		} else {
+			cur_idx++;
+			prev_tag = cur_tag;
+			out_tags[cur_idx] = prev_tag;
+			out_sizes[cur_idx] = 1;
+		}
+	}
+	*out_len = cur_idx + 1;
+}
+EXPORT_SYMBOL(ea0_tags_to_ranges);
+
+/* Transform tag ranges back into tags. */
+void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags)
+{
+	int i, j, pos = 0;
+	u8 prev;
+
+	for (i = 0; i < r_len; i++) {
+		for (j = 0; j < r_sizes[i]; j++) {
+			if (pos % 2 == 0)
+				prev = r_tags[i];
+			else
+				tags[pos / 2] = (prev << 4) | r_tags[i];
+			pos++;
+		}
+	}
+}
+EXPORT_SYMBOL(ea0_ranges_to_tags);
+
+/* Translate @num_ranges into the allocation size needed to hold them. */
+static int ea0_alloc_size(int num_ranges)
+{
+	if (num_ranges <= 6)
+		return 8;
+	if (num_ranges <= 11)
+		return 16;
+	if (num_ranges <= 23)
+		return 32;
+	if (num_ranges <= 46)
+		return 64;
+	return 128;
+}
+
+/* Translate allocation size into maximum number of ranges that it can hold. */
+static int ea0_size_to_ranges(int size)
+{
+	switch (size) {
+	case 8:
+		return 6;
+	case 16:
+		return 11;
+	case 32:
+		return 23;
+	case 64:
+		return 46;
+	default:
+		return 0;
+	}
+}
+
+/* Is the data stored inline in the handle itself? */
+static bool ea0_is_inline(u64 handle)
+{
+	return (handle & NOINLINE_MASK) != NOINLINE_MASK;
+}
+
+/* Get the size of the buffer backing @handle. */
+int ea0_storage_size(u64 handle)
+{
+	if (ea0_is_inline(handle))
+		return 8;
+	return ea0_cache_id_to_size(handle & CACHE_ID_MASK);
+}
+EXPORT_SYMBOL(ea0_storage_size);
+
+/* Compress ranges into the buffer of the given length. */
+static void ea0_compress_to_buf(int len, u8 *tags, short *sizes, u8 *buf,
+				int buflen)
+{
+	int largest_idx = -1, i;
+	short largest = 0;
+	unsigned long bit_pos = 0;
+
+	for (i = 0; i < len; i++) {
+		if (i == len)
+			break;
+		if (sizes[i] > largest) {
+			largest = sizes[i];
+			largest_idx = i;
+		}
+	}
+	if (len <= 6) {
+		/* Inline case, @buflen <= 8. */
+		bitmap_set_value_unaligned((unsigned long *)buf, largest_idx,
+					   bit_pos, 4);
+		bit_pos += 4;
+	} else {
+		bitmap_set_value_unaligned((unsigned long *)buf, largest_idx,
+					   bit_pos, 6);
+		bit_pos += 6;
+	}
+	for (i = 0; i < len; i++) {
+		bitmap_set_value_unaligned((unsigned long *)buf, tags[i],
+					   bit_pos, 4);
+		bit_pos += 4;
+	}
+	for (i = len; i < ea0_size_to_ranges(buflen); i++) {
+		bitmap_set_value_unaligned((unsigned long *)buf, 0, bit_pos, 4);
+		bit_pos += 4;
+	}
+	for (i = 0; i < len; i++) {
+		if (i == largest_idx)
+			continue;
+		bitmap_set_value_unaligned((unsigned long *)buf, sizes[i],
+					   bit_pos, 7);
+		bit_pos += 7;
+	}
+}
+
+/* Compress the data inline. */
+static u64 ea0_compress_inline(int len, u8 *tags, short *sizes)
+{
+	u64 result;
+
+	ea0_compress_to_buf(len, tags, sizes, (u8 *)&result, sizeof(result));
+	result = be64_to_cpu(result);
+	return result;
+}
+
+/* Compress @tags and return a handle. */
+u64 ea0_compress(u8 *tags)
+{
+	int alloc_size, cache_id;
+	struct kmem_cache *cache;
+	short r_sizes[256];
+	u8 r_tags[256];
+	int r_len = ARRAY_SIZE(r_tags);
+	u8 *storage;
+
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	alloc_size = ea0_alloc_size(r_len);
+	if (alloc_size == 8)
+		return ea0_compress_inline(r_len, r_tags, r_sizes);
+	cache_id = ea0_size_to_cache_id(alloc_size);
+	cache = mtecomp_caches[cache_id];
+	storage = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (alloc_size < 128) {
+		ea0_compress_to_buf(r_len, r_tags, r_sizes, storage,
+				    alloc_size);
+		return ((u64)storage | cache_id) & HANDLE_MASK;
+	}
+	memcpy(storage, tags, alloc_size);
+	return (u64)storage & HANDLE_MASK;
+}
+EXPORT_SYMBOL(ea0_compress);
+
+/* Decompress the contents of the given buffer into @tags. */
+static bool ea0_decompress_from_buf(u8 *buf, int buflen, u8 *tags)
+{
+	int largest_idx, i, r_len = ea0_size_to_ranges(buflen);
+	short r_sizes[46], sum = 0;
+	u8 r_tags[46];
+	unsigned long bit_pos = 0, l_bits = (buflen == 8) ? 4 : 6;
+
+	largest_idx = bitmap_get_value_unaligned((unsigned long *)buf, bit_pos,
+						 l_bits);
+	bit_pos += l_bits;
+	for (i = 0; i < r_len; i++) {
+		r_tags[i] = bitmap_get_value_unaligned((unsigned long *)buf,
+						       bit_pos, 4);
+		bit_pos += 4;
+	}
+	for (i = 0; i < r_len; i++) {
+		if (i == largest_idx)
+			continue;
+		r_sizes[i] = bitmap_get_value_unaligned((unsigned long *)buf,
+							bit_pos, 7);
+		bit_pos += 7;
+		if (!r_sizes[i]) {
+			r_len = i;
+			break;
+		}
+		sum += r_sizes[i];
+	}
+	if (sum >= 256)
+		return false;
+	r_sizes[largest_idx] = 256 - sum;
+	ea0_ranges_to_tags(r_tags, r_sizes, r_len, tags);
+	return true;
+}
+
+/* Get pointer to the out-of-line storage from a handle. */
+static void *ea0_storage(u64 handle)
+{
+	if (ea0_is_inline(handle))
+		return NULL;
+	return (void *)((handle & (~CACHE_ID_MASK)) | BIT_ULL(63));
+}
+
+/* Decompress tags from the buffer referenced by @handle. */
+bool ea0_decompress(u64 handle, u8 *tags)
+{
+	u8 *storage = ea0_storage(handle);
+	int size = ea0_storage_size(handle);
+
+	if (size == 128) {
+		memcpy(tags, storage, size);
+		return true;
+	}
+	if (size == 8) {
+		handle = cpu_to_be64(handle);
+		return ea0_decompress_from_buf((u8 *)&handle, sizeof(handle),
+					       tags);
+	}
+	return ea0_decompress_from_buf(storage, size, tags);
+}
+EXPORT_SYMBOL(ea0_decompress);
+
+/* Release the memory referenced by @handle. */
+void ea0_release_handle(u64 handle)
+{
+	void *storage = ea0_storage(handle);
+	int size = ea0_storage_size(handle);
+	struct kmem_cache *c;
+
+	if (!handle || !storage)
+		return;
+
+	c = mtecomp_caches[ea0_size_to_cache_id(size)];
+	kmem_cache_free(c, storage);
+}
+EXPORT_SYMBOL(ea0_release_handle);
+
+/* Set up mtecomp_caches[]. */
+static int mtecomp_init(void)
+{
+	char name[16];
+	int size;
+	int i;
+
+	for (i = 0; i < NUM_CACHES; i++) {
+		size = ea0_cache_id_to_size(i);
+		snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size);
+		mtecomp_caches[i] =
+			kmem_cache_create(name, size, size, 0, NULL);
+	}
+	return 0;
+}
+
+module_init(mtecomp_init);
-- 
2.41.0.255.g8b1d071c50-goog

