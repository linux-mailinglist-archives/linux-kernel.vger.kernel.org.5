Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6607E9A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjKMKws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:52:45 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E0CB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:52:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a828bdcfbaso59113527b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699872760; x=1700477560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmgYzX9Gh/HqVCtLQcjUqo5x4uBX58pquJxOOKimeCw=;
        b=2QoMYcIeBLrGU61miMo3OCQNSU8ZCwdBU2AEd6KxVk6edUaaPBYwPtFXl4WAjdPKXA
         A6AMLD7waDlJzz6DEBgRLXnP0ELxk+Mb3sszIAqt3drpufc6yiI+BpOpx0M2x2LKW5ua
         bbwvFqvK6k2TwY+OmkgIJIDbawp0v6+0U5hJrogSIMblVAOr17UMr+t1IPtarVr/ZaLB
         4UaMvnGOAvJoDbHhVBQCdScx5X7kyBxgDJeKuq6AG13CgAL1cGGWPT9LYnvOT/kDas9V
         3X6sIlyWo1fvxulMAyC8RTuz/t4p2Z0fMqD+UlVCyz0vsyxizvFxK0c6YaM4RAn4WRsE
         nj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699872760; x=1700477560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmgYzX9Gh/HqVCtLQcjUqo5x4uBX58pquJxOOKimeCw=;
        b=OcyGAekz0c6e2jMyh1soiye+1CW0WInjbuvdZYE4GI4d1UgwJL0lQf8PXSIZaNRpTz
         4ieg7K9gdewJ4gnniSGpvXUvksEEfKRe0MWdz50LykNKu3q4LtVjeaqMMf4AhsDVvylE
         xFm2/vry6IwPtvDO999+ziqVmuqNmJubaQ+eaSBi5KMU5hXEr8r63H6pYcxyNKA76J/0
         qERVIF2rVoy8R4vBkB6xR7T4mHWjdbcAU+GXiyHzzmff9QKlPM0iMbaNC55L/2lyknPQ
         brOUgzkmI3offVQs6EmraC31rVzxh4W0fdC/9+7JA3T4WT0614yLpbviH0c3lU9cjX94
         rLaA==
X-Gm-Message-State: AOJu0YxZZ90sc2zVcvEk8S1zpPp7weVwqmchkGWFbPabX6WZZq30s4VO
        8LUavdOnZmgAoqoMM5c69OcZWuiYh3I=
X-Google-Smtp-Source: AGHT+IHO4X/KL15y2bM31WfDS/+UhYLrvyCNCs07MSL0bqunM2xbAaXdJ9retGSdtV2md11Ea3wwqPFyl8w=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:be07:845d:4221:b15e])
 (user=glider job=sendgmr) by 2002:a05:6902:182:b0:d9a:ec95:9687 with SMTP id
 t2-20020a056902018200b00d9aec959687mr154648ybh.11.1699872759801; Mon, 13 Nov
 2023 02:52:39 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:52:30 +0100
In-Reply-To: <20231113105234.32058-1-glider@google.com>
Mime-Version: 1.0
References: <20231113105234.32058-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113105234.32058-2-glider@google.com>
Subject: [PATCH v9 1/4] arm64: mte: implement CONFIG_ARM64_MTE_COMP
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config implements the algorithm compressing memory tags for ARM MTE
during swapping.

The algorithm is based on RLE and specifically targets buffers of tags
corresponding to a single page. In many cases a buffer can be compressed
into 63 bits, making it possible to store it without additional memory
allocation.

Suggested-by: Evgenii Stepanov <eugenis@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
 v8:
  - As suggested by Catalin Marinas, only compress tags if they can be
    stored inline. This simplifies the code drastically.
  - Update the documentation.
  - Split off patches introducing bitmap_read()/bitmap_write().

 v6:
  - shuffle bits in inline handles so that they can't be confused with
    canonical pointers;
  - use kmem_cache_zalloc() to allocate compressed storage
  - correctly handle range size overflow
  - minor documentation fixes, clarify the special cases

 v5:
  - make code PAGE_SIZE-agnostic, remove hardcoded constants, updated
    the docs
  - implement debugfs interface
  - Address comments by Andy Shevchenko:
    - update description of mtecomp.c
    - remove redundant assignments, simplify mte_tags_to_ranges()
    - various code simplifications
    - introduce mtecomp.h
    - add :export: to Documentation/arch/arm64/mte-tag-compression.rst

 v4:
  - Addressed comments by Andy Shevchenko:
    - expanded "MTE" to "Memory Tagging Extension" in Kconfig
    - fixed kernel-doc comments, moved them to C source
    - changed variables to unsigned where applicable
    - some code simplifications, fewer unnecessary assignments
    - added the mte_largest_idx_bits() helper
    - added namespace prefixes to all functions
    - added missing headers (but removed bits.h)
  - Addressed comments by Yury Norov:
    - removed test-only functions from mtecomp.h
    - dropped the algoritm name (all functions are now prefixed with
      "mte")
    - added more comments
    - got rid of MTE_RANGES_INLINE
    - renamed bitmap_{get,set}_value() to bitmap_{read,write}()
    - moved the big comment explaining the algorithm to
      Documentation/arch/arm64/mte-tag-compression.rst, expanded it,
      add a link to it from Documentation/arch/arm64/index.rst
    - removed hardcoded ranges from mte_alloc_size()/mte_size_to_ranges()

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
  - as suggested by Yury Norov, switched from struct bitq (which is
    not needed anymore) to <linux/bitmap.h>
  - add missing symbol exports
---
 Documentation/arch/arm64/index.rst            |   1 +
 .../arch/arm64/mte-tag-compression.rst        | 154 +++++++++++
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/include/asm/mtecomp.h              |  39 +++
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/mtecomp.c                       | 257 ++++++++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 7 files changed, 475 insertions(+)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mtecomp.h

diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm64/index.rst
index d08e924204bf1..bf6c1583233a9 100644
--- a/Documentation/arch/arm64/index.rst
+++ b/Documentation/arch/arm64/index.rst
@@ -19,6 +19,7 @@ ARM64 Architecture
     legacy_instructions
     memory
     memory-tagging-extension
+    mte-tag-compression
     perf
     pointer-authentication
     ptdump
diff --git a/Documentation/arch/arm64/mte-tag-compression.rst b/Documentation/arch/arm64/mte-tag-compression.rst
new file mode 100644
index 0000000000000..8fe6b51a9db6d
--- /dev/null
+++ b/Documentation/arch/arm64/mte-tag-compression.rst
@@ -0,0 +1,154 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================================
+Tag Compression for Memory Tagging Extension (MTE)
+==================================================
+
+This document describes the algorithm used to compress memory tags used by the
+ARM Memory Tagging Extension (MTE).
+
+Introduction
+============
+
+MTE assigns tags to memory pages: for 4K pages those tags occupy 128 bytes
+(256 4-bit tags each corresponding to a 16-byte MTE granule), for 16K pages -
+512 bytes, for 64K pages - 2048 bytes. By default, MTE carves out 3.125% (1/16)
+of the available physical memory to store the tags.
+
+When MTE pages are saved to swap, their tags need to be stored in the kernel
+memory. If the system swap is used heavily, these tags may take a substantial
+portion of the physical memory. To reduce memory waste, ``CONFIG_ARM64_MTE_COMP``
+allows the kernel to store the tags in compressed form.
+
+Implementation details
+======================
+
+The algorithm attempts to compress an array of ``MTE_PAGE_TAG_STORAGE``
+tag bytes into a byte sequence that can be stored in an 8-byte pointer. If that
+is not possible, the data is stored uncompressed.
+
+Tag manipulation and storage
+----------------------------
+
+Tags for swapped pages are stored in an XArray that maps swap entries to 63-bit
+values (see ``arch/arm64/mm/mteswap.c``). Bit 0 of these values indicates how
+their contents should be treated:
+
+ - 0: value is a pointer to an uncompressed buffer allocated with kmalloc()
+   (always the case if ``CONFIG_ARM64_MTE_COMP=n``) with the highest bit set
+   to 0;
+ - 1: value contains compressed data.
+
+``arch/arm64/include/asm/mtecomp.h`` declares the following functions that
+manipulate with tags:
+
+- mte_compress() - compresses the given ``MTE_PAGE_TAG_STORAGE``-byte ``tags``
+  buffer into a pointer;
+- mte_decompress() - decompresses the tags from a pointer;
+- mte_is_compressed() - returns ``true`` iff the pointer passed to it should be
+  treated as compressed data.
+
+Tag compression
+---------------
+
+The compression algorithm is a variation of RLE (run-length encoding) and works
+as follows (we will be considering 4K pages and 128-byte tag buffers, but the
+same approach scales to 16K and 64K pages):
+
+1. The input array of 128 (``MTE_PAGE_TAG_STORAGE``) bytes is transformed into
+   tag ranges (two arrays: ``r_tags[]`` containing tag values and ``r_sizes[]``
+   containing range lengths) by mte_tags_to_ranges(). Note that
+   ``r_sizes[]`` sums up to 256 (``MTE_GRANULES_PER_PAGE``).
+
+   If ``r_sizes[]`` consists of a single element
+   (``{ MTE_GRANULES_PER_PAGE }``), the corresponding range is split into two
+   halves, i.e.::
+
+     r_sizes_new[2] = { MTE_GRANULES_PER_PAGE/2, MTE_GRANULES_PER_PAGE/2 };
+     r_tags_new[2] = { r_tags[0], r_tags[0] };
+
+2. The number of the largest element of ``r_sizes[]`` is stored in
+   ``largest_idx``. The element itself is thrown away from ``r_sizes[]``,
+   because it can be reconstructed from the sum of the remaining elements. Note
+   that now none of the remaining ``r_sizes[]`` elements exceeds
+   ``MTE_GRANULES_PER_PAGE/2``.
+
+3. If the number ``N`` of ranges does not exceed ``6``, the ranges can be
+   compressed into 64 bits. This is done by storing the following values packed
+   into the pointer (``i<size>`` means a ``<size>``-bit unsigned integer)
+   treated as a bitmap (see ``include/linux/bitmap.h``)::
+
+    bit 0      :      (always 1) : i1
+    bits 1-3   :     largest_idx : i3
+    bits 4-27  :    r_tags[0..5] : i4 x 6
+    bits 28-62 :   r_sizes[0..4] : i7 x 5
+    bit 63     :      (always 0) : i1
+
+   If N is less than 6, ``r_tags`` and ``r_sizes`` are padded up with zero
+   values. The unused bits in the pointer, including bit 63, are also set to 0,
+   so the compressed data can be stored in XArray.
+
+   Range size of ``MTE_GRANULES_PER_PAGE/2`` (at most one) does not fit into
+   i7 and will be written as 0. This case is handled separately by the
+   decompressing procedure.
+
+Tag decompression
+-----------------
+
+The decompression algorithm performs the steps below.
+
+1. Read the lowest bit of the data from the input buffer and check that it is 1,
+   otherwise bail out.
+
+2. Read ``largest_idx``, ``r_tags[]`` and ``r_sizes[]`` from the
+   input buffer.
+
+   If ``largest_idx`` is zero, and all ``r_sizes[]`` are zero, set
+   ``r_sizes[0] = MTE_GRANULES_PER_PAGE/2``.
+
+   Calculate the removed largest element of ``r_sizes[]`` as
+   ``largest = 256 - sum(r_sizes)`` and insert it into ``r_sizes`` at
+   position ``largest_idx``.
+
+6. For each ``r_sizes[i] > 0``, add a 4-bit value ``r_tags[i]`` to the output
+   buffer ``r_sizes[i]`` times.
+
+
+Why these numbers?
+------------------
+
+To be able to reconstruct ``N`` tag ranges from the compressed data, we need to
+store the indicator bit together with ``largest_idx``, ``r_tags[N]``, and
+``r_sizes[N-1]`` in 63 bits.
+Knowing that the sizes do not exceed ``MTE_PAGE_TAG_STORAGE``, each of them can be
+packed into ``S = ilog2(MTE_PAGE_TAG_STORAGE)`` bits, whereas a single tag occupies
+4 bits.
+
+It is evident that the number of ranges that can be stored in 63 bits is
+strictly less than 8, therefore we only need 3 bits to store ``largest_idx``.
+
+The maximum values of ``N`` so that the number ``1 + 3 + N * 4 + (N-1) * S`` of
+storage bits does not exceed 63, are shown in the table below::
+
+ +-----------+-----------------+----+---+-------------------+
+ | Page size | Tag buffer size |  S | N |    Storage bits   |
+ +-----------+-----------------+----+---+-------------------+
+ |      4 KB |           128 B |  7 | 6 | 63 = 1+3+6*4+5*7  |
+ |     16 KB |           512 B |  9 | 5 | 60 = 1+3+5*4+4*9  |
+ |     64 KB |          2048 B | 11 | 4 | 53 = 1+3+4*4+3*11 |
+ +-----------+-----------------+----+---+-------------------+
+
+Note
+----
+
+Tag compression and decompression implicitly rely on the fixed MTE tag size
+(4 bits) and number of tags per page. Should these values change, the algorithm
+may need to be revised.
+
+
+Programming Interface
+=====================
+
+ .. kernel-doc:: arch/arm64/include/asm/mtecomp.h
+ .. kernel-doc:: arch/arm64/mm/mtecomp.c
+   :export:
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 78f20e6327120..c2fbe8e492e00 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2073,6 +2073,17 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+config ARM64_MTE_COMP
+	bool "Tag compression for ARM64 Memory Tagging Extension"
+	default y
+	depends on ARM64_MTE
+	help
+	  Enable tag compression support for ARM64 Memory Tagging Extension.
+
+	  Tag buffers corresponding to swapped RAM pages are compressed using
+	  RLE to conserve heap memory. In the common case compressed tags
+	  occupy 2.5x less memory.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/include/asm/mtecomp.h b/arch/arm64/include/asm/mtecomp.h
new file mode 100644
index 0000000000000..b9a3a921a38d4
--- /dev/null
+++ b/arch/arm64/include/asm/mtecomp.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_MTECOMP_H
+#define __ASM_MTECOMP_H
+
+#include <linux/types.h>
+
+/**
+ * mte_is_compressed() - check if the supplied pointer contains compressed tags.
+ * @ptr: pointer returned by kmalloc() or mte_compress().
+ *
+ * Returns: true iff bit 0 of @ptr is 1, which is only possible if @ptr was
+ * returned by mte_is_compressed().
+ */
+static inline bool mte_is_compressed(void *ptr)
+{
+	return ((unsigned long)ptr & 1);
+}
+
+#if defined(CONFIG_ARM64_MTE_COMP)
+
+void *mte_compress(u8 *tags);
+bool mte_decompress(void *handle, u8 *tags);
+
+#else
+
+static inline void *mte_compress(u8 *tags)
+{
+	return NULL;
+}
+
+static inline bool mte_decompress(void *data, u8 *tags)
+{
+	return false;
+}
+
+#endif // CONFIG_ARM64_MTE_COMP
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
index 0000000000000..c948921525030
--- /dev/null
+++ b/arch/arm64/mm/mtecomp.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * MTE tag compression algorithm.
+ * See Documentation/arch/arm64/mte-tag-compression.rst for more details.
+ */
+
+#include <linux/bits.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/mtecomp.h>
+
+#include "mtecomp.h"
+
+#define MTE_BITS_PER_LARGEST_IDX 3
+/* Range size cannot exceed MTE_GRANULES_PER_PAGE / 2. */
+#define MTE_BITS_PER_SIZE (ilog2(MTE_GRANULES_PER_PAGE) - 1)
+
+/*
+ * See Documentation/arch/arm64/mte-tag-compression.rst for details on how the
+ * maximum number of ranges is calculated.
+ */
+#if defined(CONFIG_ARM64_4K_PAGES)
+#define MTE_MAX_RANGES 6
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define MTE_MAX_RANGES 5
+#else
+#define MTE_MAX_RANGES 4
+#endif
+
+/**
+ * mte_tags_to_ranges() - break @tags into arrays of tag ranges.
+ * @tags: MTE_GRANULES_PER_PAGE-byte array containing MTE tags.
+ * @out_tags: u8 array to store the tag of every range.
+ * @out_sizes: unsigned short array to store the size of every range.
+ * @out_len: length of @out_tags and @out_sizes (output parameter, initially
+ *           equal to lengths of out_tags[] and out_sizes[]).
+ *
+ * This function is exported for testing purposes.
+ */
+void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_sizes,
+			size_t *out_len)
+{
+	u8 prev_tag = tags[0] / 16; /* First tag in the array. */
+	unsigned int cur_idx = 0, i, j;
+	u8 cur_tag;
+
+	memset(out_tags, 0, array_size(*out_len, sizeof(*out_tags)));
+	memset(out_sizes, 0, array_size(*out_len, sizeof(*out_sizes)));
+
+	out_tags[cur_idx] = prev_tag;
+	for (i = 0; i < MTE_GRANULES_PER_PAGE; i++) {
+		j = i % 2;
+		cur_tag = j ? (tags[i / 2] % 16) : (tags[i / 2] / 16);
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
+EXPORT_SYMBOL_NS(mte_tags_to_ranges, MTECOMP);
+
+/**
+ * mte_ranges_to_tags() - fill @tags using given tag ranges.
+ * @r_tags: u8[] containing the tag of every range.
+ * @r_sizes: unsigned short[] containing the size of every range.
+ * @r_len: length of @r_tags and @r_sizes.
+ * @tags: MTE_GRANULES_PER_PAGE-byte array to write the tags to.
+ *
+ * This function is exported for testing purposes.
+ */
+void mte_ranges_to_tags(u8 *r_tags, unsigned short *r_sizes, size_t r_len,
+			u8 *tags)
+{
+	unsigned int i, j, pos = 0;
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
+EXPORT_SYMBOL_NS(mte_ranges_to_tags, MTECOMP);
+
+static void mte_bitmap_write(unsigned long *bitmap, unsigned long value,
+			     unsigned long *pos, unsigned long bits)
+{
+	bitmap_write(bitmap, value, *pos, bits);
+	*pos += bits;
+}
+
+/* Compress ranges into an unsigned long. */
+static void mte_compress_to_ulong(size_t len, u8 *tags, unsigned short *sizes,
+				  unsigned long *result)
+{
+	unsigned long bit_pos = 0;
+	unsigned int largest_idx, i;
+	unsigned short largest = 0;
+
+	for (i = 0; i < len; i++) {
+		if (sizes[i] > largest) {
+			largest = sizes[i];
+			largest_idx = i;
+		}
+	}
+	/* Bit 1 in position 0 indicates compressed data. */
+	mte_bitmap_write(result, 1, &bit_pos, 1);
+	mte_bitmap_write(result, largest_idx, &bit_pos,
+			 MTE_BITS_PER_LARGEST_IDX);
+	for (i = 0; i < len; i++)
+		mte_bitmap_write(result, tags[i], &bit_pos, MTE_TAG_SIZE);
+	if (len == 1) {
+		/*
+		 * We are compressing MTE_GRANULES_PER_PAGE of identical tags.
+		 * Split it into two ranges containing
+		 * MTE_GRANULES_PER_PAGE / 2 tags, so that it falls into the
+		 * special case described below.
+		 */
+		mte_bitmap_write(result, tags[0], &bit_pos, MTE_TAG_SIZE);
+		i = 2;
+	} else {
+		i = len;
+	}
+	for (; i < MTE_MAX_RANGES; i++)
+		mte_bitmap_write(result, 0, &bit_pos, MTE_TAG_SIZE);
+	/*
+	 * Most of the time sizes[i] fits into MTE_BITS_PER_SIZE, apart from a
+	 * special case when:
+	 *   len = 2;
+	 *   sizes = { MTE_GRANULES_PER_PAGE / 2, MTE_GRANULES_PER_PAGE / 2};
+	 * In this case largest_idx will be set to 0, and the size written to
+	 * the bitmap will be also 0.
+	 */
+	for (i = 0; i < len; i++) {
+		if (i != largest_idx)
+			mte_bitmap_write(result, sizes[i], &bit_pos,
+					 MTE_BITS_PER_SIZE);
+	}
+	for (i = len; i < MTE_MAX_RANGES; i++)
+		mte_bitmap_write(result, 0, &bit_pos, MTE_BITS_PER_SIZE);
+}
+
+/**
+ * mte_compress() - compress the given tag array.
+ * @tags: MTE_GRANULES_PER_PAGE-byte array to read the tags from.
+ *
+ * Attempts to compress the user-supplied tag array.
+ *
+ * Returns: compressed data or NULL.
+ */
+void *mte_compress(u8 *tags)
+{
+	unsigned short *r_sizes;
+	void *result = NULL;
+	u8 *r_tags;
+	size_t r_len;
+
+	r_sizes = kmalloc_array(MTE_GRANULES_PER_PAGE, sizeof(unsigned short),
+				GFP_KERNEL);
+	r_tags = kmalloc(MTE_GRANULES_PER_PAGE, GFP_KERNEL);
+	if (!r_sizes || !r_tags)
+		goto ret;
+	r_len = MTE_GRANULES_PER_PAGE;
+	mte_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	if (r_len <= MTE_MAX_RANGES)
+		mte_compress_to_ulong(r_len, r_tags, r_sizes,
+				      (unsigned long *)&result);
+ret:
+	kfree(r_tags);
+	kfree(r_sizes);
+	return result;
+}
+EXPORT_SYMBOL_NS(mte_compress, MTECOMP);
+
+static unsigned long mte_bitmap_read(const unsigned long *bitmap,
+				     unsigned long *pos, unsigned long bits)
+{
+	unsigned long start = *pos;
+
+	*pos += bits;
+	return bitmap_read(bitmap, start, bits);
+}
+
+/**
+ * mte_decompress() - decompress the tag array from the given pointer.
+ * @data: pointer returned by @mte_compress()
+ * @tags: MTE_GRANULES_PER_PAGE-byte array to write the tags to.
+ *
+ * Reads the compressed data and writes it into the user-supplied tag array.
+ *
+ * Returns: true on success, false if the passed data is uncompressed.
+ */
+bool mte_decompress(void *data, u8 *tags)
+{
+	unsigned short r_sizes[MTE_MAX_RANGES];
+	u8 r_tags[MTE_MAX_RANGES];
+	unsigned int largest_idx, i;
+	unsigned long bit_pos = 0;
+	unsigned long *bitmap;
+	unsigned short sum;
+	size_t max_ranges;
+
+	if (!mte_is_compressed(data))
+		return false;
+
+	bitmap = (unsigned long *)&data;
+	max_ranges = MTE_MAX_RANGES;
+	/* Skip the leading bit indicating the inline case. */
+	mte_bitmap_read(bitmap, &bit_pos, 1);
+	largest_idx =
+		mte_bitmap_read(bitmap, &bit_pos, MTE_BITS_PER_LARGEST_IDX);
+	if (largest_idx >= MTE_MAX_RANGES)
+		return false;
+
+	for (i = 0; i < max_ranges; i++)
+		r_tags[i] = mte_bitmap_read(bitmap, &bit_pos, MTE_TAG_SIZE);
+	for (i = 0, sum = 0; i < max_ranges; i++) {
+		if (i == largest_idx)
+			continue;
+		r_sizes[i] =
+			mte_bitmap_read(bitmap, &bit_pos, MTE_BITS_PER_SIZE);
+		/*
+		 * Special case: tag array consists of two ranges of
+		 * `MTE_GRANULES_PER_PAGE / 2` tags.
+		 */
+		if ((largest_idx == 0) && (i == 1) && (r_sizes[i] == 0))
+			r_sizes[i] = MTE_GRANULES_PER_PAGE / 2;
+		if (!r_sizes[i]) {
+			max_ranges = i;
+			break;
+		}
+		sum += r_sizes[i];
+	}
+	if (sum >= MTE_GRANULES_PER_PAGE)
+		return false;
+	r_sizes[largest_idx] = MTE_GRANULES_PER_PAGE - sum;
+	mte_ranges_to_tags(r_tags, r_sizes, max_ranges, tags);
+	return true;
+}
+EXPORT_SYMBOL_NS(mte_decompress, MTECOMP);
diff --git a/arch/arm64/mm/mtecomp.h b/arch/arm64/mm/mtecomp.h
new file mode 100644
index 0000000000000..b94cf0384f2af
--- /dev/null
+++ b/arch/arm64/mm/mtecomp.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_ARM64_MM_MTECOMP_H_
+#define ARCH_ARM64_MM_MTECOMP_H_
+
+/* Functions exported from mtecomp.c for test_mtecomp.c. */
+void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_sizes,
+			size_t *out_len);
+void mte_ranges_to_tags(u8 *r_tags, unsigned short *r_sizes, size_t r_len,
+			u8 *tags);
+
+#endif  // ARCH_ARM64_MM_TEST_MTECOMP_H_
-- 
2.42.0.869.gea05f2083d-goog

