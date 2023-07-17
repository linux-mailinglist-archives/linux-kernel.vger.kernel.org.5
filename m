Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5927561B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjGQLhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGQLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:37:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0FE4C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704aa6c69so39297577b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689593843; x=1692185843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvRbZSqEbEgNjBWP4zI9nPh29npYLZUXp+boFRM8PZk=;
        b=jF7VApe1WMvap5r7aHtsDGd9DLDWTVOxGXp1d7AH4N9GnRhRynH1GkgpQsmTw55xOw
         V3Tt/ED+0RfjpkBwjfu55EfMPv77klLgOMrExaQL6f+WARHhUcWP/0yMqNthXUkGTyWS
         GobkMIzZluNDGhLBJ97d8TIVZkzs4+bmrP2dd6zwuSjIclrP61ntl+JvVK8nbNkvRDLd
         KCi/BuKmT9+MTBAUyPpMm3iPAgq5ij4CE1Thypub5LiyI+v9DlMlUD2cFrpR0HHdqiTV
         YZdqM8R0dfb7mptP+jXX/0+vQAzwq5cjhzU6Go+Yy/S5VmqcVmrtU/LQClV7vlDpRcdY
         donA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689593843; x=1692185843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvRbZSqEbEgNjBWP4zI9nPh29npYLZUXp+boFRM8PZk=;
        b=FiQHxCnCvT6SprVPFhYlG4Xp9r9GYBCDx6rut0qmUaF//gjA50KAVoY5seQ/7bdSRU
         v7cpJRCWYkREO1g5xX6lJhbFWxZx6dZsuuTyP0adnIw2YL634n8VVoeDw6oBGoKvy1yP
         3XUPa/p/SLdIsQ0s3iXcfgjEXEgQa70IKsdPQbHoO888xU6T3CAoY1w57lRgjanU4bvV
         udAe/8jiELKqQ0K+epd1N0dUyRGdqkN45tOi4EYxCayCBdzIgUKSIEdKnFAI6nBtJA8S
         8mo3KAcAui6m2pUkil4sj6Jkg8tZZ8v3fV4gvysjvwmVkoCzWfb69c61tWIarQQXL09h
         4oVQ==
X-Gm-Message-State: ABy/qLZ+VCvhOQEprV2q2WC73MpncIQCY3qmLIzWwFqbWwoNT8bQMh94
        JbBCu+0I+GOPa5SZ5dCtoy4WCREphVg=
X-Google-Smtp-Source: APBJJlHA17jW4pujtScyZ9uruui/hISnSQLOAIGLlsDlsxPZFMf6w5pVt/0oxlUEEvPS1q4zOD5/V/rdBfk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3b6e:8102:6db8:d83f])
 (user=glider job=sendgmr) by 2002:a25:100a:0:b0:c2c:1b68:99b6 with SMTP id
 10-20020a25100a000000b00c2c1b6899b6mr106384ybq.6.1689593842870; Mon, 17 Jul
 2023 04:37:22 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:37:06 +0200
In-Reply-To: <20230717113709.328671-1-glider@google.com>
Mime-Version: 1.0
References: <20230717113709.328671-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717113709.328671-4-glider@google.com>
Subject: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
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
 v3:
  - Addressed comments by Andy Shevchenko:
   - use bitmap_{set,get}_value() writte by Syed Nayyar Waris
   - switched to unsigned long everywhere (fewer casts)
   - simplified the code, removed redundant checks
   - dropped ea0_compress_inline()
 - added bit size constants and helpers to access the bitmap
 - explicitly initialize all compressed sizes in ea0_compress_to_buf()
 - initialize all handle bits

 v2:
  - as suggested by Yuri Norov, switched from struct bitq (which is
    not needed anymore) to <linux/bitmap.h>
  - add missing symbol exports
---
 arch/arm64/Kconfig               |  10 +
 arch/arm64/include/asm/mtecomp.h |  60 +++++
 arch/arm64/mm/Makefile           |   1 +
 arch/arm64/mm/mtecomp.c          | 406 +++++++++++++++++++++++++++++++
 4 files changed, 477 insertions(+)
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f67..52cdc7603cf7c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2093,6 +2093,16 @@ config ARM64_EPAN
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
index 0000000000000..0c444c0d4ac04
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
+unsigned long ea0_compress(u8 *tags);
+
+/*
+ * ea0_decompress() - decompress the tag array addressed by the handle.
+ * @handle: handle returned by @ea0_decompress()
+ * @tags: 128-byte array to write the tags to.
+ *
+ * Reads the compressed data and writes it into the user-supplied tag array.
+ * Returns true on success, false on error.
+ */
+bool ea0_decompress(unsigned long handle, u8 *tags);
+
+/*
+ * ea0_release_handle() - release the handle returned by ea0_compress().
+ * @handle: handle returned by ea0_compress().
+ */
+void ea0_release_handle(unsigned long handle);
+
+/* Functions below are exported for testing purposes. */
+
+/*
+ * ea0_storage_size() - calculate the memory occupied by compressed tags.
+ * @handle: storage handle returned by ea0_compress.
+ */
+int ea0_storage_size(unsigned long handle);
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
index 0000000000000..50a379c035aee
--- /dev/null
+++ b/arch/arm64/mm/mtecomp.c
@@ -0,0 +1,406 @@
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
+ *   ea0_decompress(*ptr, *tags) takes the opaque value and loads the tags into
+ *     the provided 128-byte buffer.
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
+#include <linux/bits.h>
+#include <linux/bitmap.h>
+#include <linux/gfp.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/swab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/mtecomp.h>
+
+/* The handle must fit into an Xarray value. */
+#define HANDLE_MASK GENMASK_ULL(62, 0)
+
+/* Out-of-line handles have 0b111 in bits 62..60. */
+#define NOINLINE_MASK GENMASK_ULL(62, 60)
+
+/* Cache index is stored in the lowest pointer bits. */
+#define CACHE_ID_MASK GENMASK_ULL(2, 0)
+
+/*
+ * Four separate caches to store out-of-line data:
+ *  0: mte-tags-128
+ *  1: mte-tags-16
+ *  2: mte-tags-32
+ *  3: mte-tags-64
+ */
+#define NUM_CACHES 4
+static struct kmem_cache *mtecomp_caches[NUM_CACHES];
+
+/*
+ * Sizes of compressed values.
+ */
+#define BITS_PER_TAG 4
+#define BITS_PER_SIZE 7
+#define BITS_PER_LARGEST_IDX_INLINE 4
+#define BITS_PER_LARGEST_IDX 6
+
+/* Translate allocation size into mtecomp_caches[] index. */
+static int ea0_size_to_cache_id(int len)
+{
+	if (len < 128)
+		return fls(len >> 4);
+	return 0;
+}
+
+/* Translate mtecomp_caches[] index into allocation size. */
+static int ea0_cache_id_to_size(int id)
+{
+	if (id == 0)
+		return 128;
+	return 8 << id;
+}
+
+/* Transform tags into tag ranges. */
+void ea0_tags_to_ranges(u8 *tags, u8 *out_tags, short *out_sizes, int *out_len)
+{
+	u8 prev_tag = U8_MAX;
+	int cur_idx = -1;
+	u8 cur_tag;
+	int i, j;
+
+	memset(out_tags, 0, array_size(*out_len, sizeof(*out_tags)));
+	memset(out_sizes, 0, array_size(*out_len, sizeof(*out_sizes)));
+
+	for (i = 0; i < MTE_PAGE_TAG_STORAGE; i++) {
+		for (j = 0; j < 2; j++) {
+			cur_tag = j ? (tags[i] % 16) : (tags[i] / 16);
+			if (cur_tag == prev_tag) {
+				out_sizes[cur_idx]++;
+			} else {
+				cur_idx++;
+				prev_tag = cur_tag;
+				out_tags[cur_idx] = prev_tag;
+				out_sizes[cur_idx] = 1;
+			}
+		}
+	}
+	*out_len = cur_idx + 1;
+}
+EXPORT_SYMBOL_NS(ea0_tags_to_ranges, MTECOMP);
+
+/* Transform tag ranges back into tags. */
+void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 *tags)
+{
+	int i, j, pos = 0;
+	u8 prev;
+
+	for (i = 0; i < r_len; i++) {
+		for (j = 0; j < r_sizes[i]; j++) {
+			if (pos % 2)
+				tags[pos / 2] = (prev << 4) | r_tags[i];
+			else
+				prev = r_tags[i];
+			pos++;
+		}
+	}
+}
+EXPORT_SYMBOL_NS(ea0_ranges_to_tags, MTECOMP);
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
+#define RANGES_INLINE ea0_size_to_ranges(8)
+
+/* Is the data stored inline in the handle itself? */
+static bool ea0_is_inline(unsigned long handle)
+{
+	return (handle & NOINLINE_MASK) != NOINLINE_MASK;
+}
+
+/* Get the size of the buffer backing @handle. */
+int ea0_storage_size(unsigned long handle)
+{
+	if (ea0_is_inline(handle))
+		return 8;
+	return ea0_cache_id_to_size(handle & CACHE_ID_MASK);
+}
+EXPORT_SYMBOL_NS(ea0_storage_size, MTECOMP);
+
+static void bitmap_write(unsigned long *bitmap, unsigned long value,
+			 unsigned long *pos, unsigned long bits)
+{
+	bitmap_set_value(bitmap, value, *pos, bits);
+	*pos += bits;
+}
+
+/* Compress ranges into the buffer that can accommodate up to max_ranges. */
+static void ea0_compress_to_buf(int len, u8 *tags, short *sizes,
+				unsigned long *bitmap, int max_ranges)
+{
+	unsigned long bit_pos = 0, l_bits;
+	int largest_idx = -1, i;
+	short largest = 0;
+
+	for (i = 0; i < len; i++) {
+		if (sizes[i] > largest) {
+			largest = sizes[i];
+			largest_idx = i;
+		}
+	}
+	l_bits = (max_ranges == RANGES_INLINE) ? BITS_PER_LARGEST_IDX_INLINE :
+						 BITS_PER_LARGEST_IDX;
+	bitmap_write(bitmap, largest_idx, &bit_pos, l_bits);
+	for (i = 0; i < len; i++)
+		bitmap_write(bitmap, tags[i], &bit_pos, BITS_PER_TAG);
+	for (i = len; i < max_ranges; i++)
+		bitmap_write(bitmap, 0, &bit_pos, BITS_PER_TAG);
+	for (i = 0; i < len; i++) {
+		if (i == largest_idx)
+			continue;
+		bitmap_write(bitmap, sizes[i], &bit_pos, BITS_PER_SIZE);
+	}
+	for (i = len; i < max_ranges; i++)
+		bitmap_write(bitmap, 0, &bit_pos, BITS_PER_SIZE);
+}
+
+/* Compress @tags and return a handle. */
+unsigned long ea0_compress(u8 *tags)
+{
+	int alloc_size, cache_id;
+	struct kmem_cache *cache;
+	short r_sizes[256];
+	u8 r_tags[256];
+	int r_len = ARRAY_SIZE(r_tags);
+	unsigned long *storage;
+	/*
+	 * ea0_compress_to_buf() only initializes the bits that ea0_decompress()
+	 * will read. But when the tags are stored in the handle itself, it must
+	 * have all its bits initialized.
+	 */
+	unsigned long result = 0;
+
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	alloc_size = ea0_alloc_size(r_len);
+	if (alloc_size == 8) {
+		ea0_compress_to_buf(r_len, r_tags, r_sizes, &result,
+				    RANGES_INLINE);
+		return result;
+	}
+	cache_id = ea0_size_to_cache_id(alloc_size);
+	cache = mtecomp_caches[cache_id];
+	storage = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (alloc_size < 128) {
+		/* alloc_size is always a multiple of sizeof(unsigned long). */
+		ea0_compress_to_buf(r_len, r_tags, r_sizes, storage,
+				    ea0_size_to_ranges(alloc_size));
+		return ((unsigned long)storage | cache_id) & HANDLE_MASK;
+	}
+	memcpy(storage, tags, alloc_size);
+	return (unsigned long)storage & HANDLE_MASK;
+}
+EXPORT_SYMBOL_NS(ea0_compress, MTECOMP);
+
+static unsigned long bitmap_read(const unsigned long *bitmap,
+				 unsigned long *pos, unsigned long bits)
+{
+	unsigned long result;
+
+	result = bitmap_get_value(bitmap, *pos, bits);
+	*pos += bits;
+	return result;
+}
+
+/* Decompress the contents of the given buffer into @tags. */
+static bool ea0_decompress_from_buf(const unsigned long *bitmap, int max_ranges,
+				    u8 *tags)
+{
+	int largest_idx, i;
+	short r_sizes[46], sum = 0;
+	u8 r_tags[46];
+	unsigned long bit_pos = 0, l_bits;
+
+	l_bits = (max_ranges == RANGES_INLINE) ? BITS_PER_LARGEST_IDX_INLINE :
+						 BITS_PER_LARGEST_IDX;
+	largest_idx = bitmap_read(bitmap, &bit_pos, l_bits);
+	for (i = 0; i < max_ranges; i++)
+		r_tags[i] = bitmap_read(bitmap, &bit_pos, BITS_PER_TAG);
+	for (i = 0; i < max_ranges; i++) {
+		if (i == largest_idx)
+			continue;
+		r_sizes[i] = bitmap_read(bitmap, &bit_pos, BITS_PER_SIZE);
+		if (!r_sizes[i]) {
+			max_ranges = i;
+			break;
+		}
+		sum += r_sizes[i];
+	}
+	if (sum >= 256)
+		return false;
+	r_sizes[largest_idx] = 256 - sum;
+	ea0_ranges_to_tags(r_tags, r_sizes, max_ranges, tags);
+	return true;
+}
+
+/* Get pointer to the out-of-line storage from a handle. */
+static void *ea0_storage(unsigned long handle)
+{
+	if (ea0_is_inline(handle))
+		return NULL;
+	return (void *)((handle & (~CACHE_ID_MASK)) | BIT_ULL(63));
+}
+
+/* Decompress tags from the buffer referenced by @handle. */
+bool ea0_decompress(unsigned long handle, u8 *tags)
+{
+	unsigned long *storage = ea0_storage(handle);
+	int size = ea0_storage_size(handle);
+
+	if (size == 128) {
+		memcpy(tags, storage, size);
+		return true;
+	}
+	if (size == 8)
+		return ea0_decompress_from_buf(&handle, RANGES_INLINE, tags);
+	return ea0_decompress_from_buf(storage, ea0_size_to_ranges(size), tags);
+}
+EXPORT_SYMBOL_NS(ea0_decompress, MTECOMP);
+
+/* Release the memory referenced by @handle. */
+void ea0_release_handle(unsigned long handle)
+{
+	void *storage = ea0_storage(handle);
+	int size = ea0_storage_size(handle);
+	struct kmem_cache *c;
+
+	if (!storage)
+		return;
+
+	c = mtecomp_caches[ea0_size_to_cache_id(size)];
+	kmem_cache_free(c, storage);
+}
+EXPORT_SYMBOL_NS(ea0_release_handle, MTECOMP);
+
+/* Set up mtecomp_caches[]. */
+static int mtecomp_init(void)
+{
+	char name[16];
+	int size;
+	int i;
+
+	BUILD_BUG_ON(MTE_PAGE_TAG_STORAGE != 128);
+	for (i = 0; i < NUM_CACHES; i++) {
+		size = ea0_cache_id_to_size(i);
+		snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size);
+		mtecomp_caches[i] =
+			kmem_cache_create(name, size, size, 0, NULL);
+	}
+	return 0;
+}
+module_init(mtecomp_init);
-- 
2.41.0.255.g8b1d071c50-goog

