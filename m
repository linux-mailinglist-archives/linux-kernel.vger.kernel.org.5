Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D397AABD5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjIVIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjIVIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:09:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139ABCF3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:09:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d858d1bdf0aso2400193276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695370140; x=1695974940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nl/fxf+qx8ISJuSoVh6mGCYH3LWVJFzsWE1L3WeUseU=;
        b=VFXxQj7TYSpLCGaJCd/rBcLfz+CO9xXJ99X04ZYJStW0BKENd+7E+RwYLu24EA2fSt
         XYm5Tki75xQjPfKdhnSnmNEBe5xAf7pE6Rt5Fg/OUrXNWewByvStEYc2sOI9evJxC6yq
         Ix77NhvzlhDPAPn/RUloRQwkkbvibTBLwfJDy335JBHRSRtzqW3C+bl6xrqzfTWjkpVv
         ORM2CLboisRhCF9CkBYHcqmjzxEsI588xzmt1JVebb7tYhRjWCuOqMN7mmMnO5R7AGel
         bgf2uV6Wo/L14H85959rgjPweyfDl4c2z+K/lB4suR0D8Z8zX9hc0EmmhEifbhQAProD
         DxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695370140; x=1695974940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl/fxf+qx8ISJuSoVh6mGCYH3LWVJFzsWE1L3WeUseU=;
        b=FfrHezuwI8RHrHVysJ8m/IT44rcQgu3x4k5GGHNqSQ2KxoipKi4RZrhXhmBI2kJcW4
         FioUWHnFvrLryvEVuDbnw1V4zitf5nFNBXiQ9Jqm63VPTHRw/Yagm8E5KMQ2idpILqDN
         lrZZ68QHrOlG/ME42NLCe3HadP4yz8LOV+cz0fRM2tlhtwMflXO4c4nAsQYR7TWAqjVH
         n5PCSWjXjZ6MWMo/ePZ0dZrmSsUaVfMMxu0zf9iUbffjTjcNt8H5R/tU/poc/4WiLtPx
         w8jE1IQfsuQZHE6Rx2i6KTTM5KHc20tYfkiPHUuPC3TBasFR/y6KUDshQ46ZRlKW97SQ
         oNow==
X-Gm-Message-State: AOJu0Yz7fGmtV0r60mk5PAqZ6fLAgMEMJT68QotzHYf3hiwAwlzXSnUr
        +bJQJbRBlAQm8TeFm+DdIb3OoEMBWnA=
X-Google-Smtp-Source: AGHT+IHABaEmmWBjew1HSJkFXBGnXvcgbZ95su8TyVn+pvlcjrVF9tYnL8LidmbIkPwNMIj0NjF7MFUsf/E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4da0:80d4:9480:7d5c])
 (user=glider job=sendgmr) by 2002:a25:e6d2:0:b0:d7f:2cb6:7d8c with SMTP id
 d201-20020a25e6d2000000b00d7f2cb67d8cmr103333ybh.13.1695370140239; Fri, 22
 Sep 2023 01:09:00 -0700 (PDT)
Date:   Fri, 22 Sep 2023 10:08:45 +0200
In-Reply-To: <20230922080848.1261487-1-glider@google.com>
Mime-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922080848.1261487-4-glider@google.com>
Subject: [PATCH v5 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config implements the algorithm compressing memory tags for ARM MTE
during swapping.

The algorithm is based on RLE and specifically targets buffers of tags
corresponding to a single page. In the common case a buffer can be
compressed into 63 bits, making it possible to store it without
additional memory allocation.

Suggested-by: Evgenii Stepanov <eugenis@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
 .../arch/arm64/mte-tag-compression.rst        | 245 +++++++++
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/include/asm/mtecomp.h              |  13 +
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/mtecomp.c                       | 467 ++++++++++++++++++
 arch/arm64/mm/mtecomp.h                       |  12 +
 7 files changed, 750 insertions(+)
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
index 0000000000000..c5170155473aa
--- /dev/null
+++ b/Documentation/arch/arm64/mte-tag-compression.rst
@@ -0,0 +1,245 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================================
+Tag Compression for Memory Tagging Extension (MTE)
+==================================================
+
+This document describes the algorithm used to compress memory tags used by the
+ARM Memory Tagging Extension (MTE)
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
+portion of the physical memory. To reduce memory waste,
+``CONFIG_ARM64_MTE_COMP`` allows the kernel to store the tags in compressed
+form.
+
+Implementation details
+======================
+
+The algorithm attempts to compress an array of ``MTE_PAGE_TAG_STORAGE``
+tag bytes into a byte sequence that can be stored in one of the smaller size
+class allocations (for 4K pages those are 16-, 32-, or 64-byte allocations).
+A special case is storing the tags inline in an 8-byte pointer.
+
+Tag manipulation and storage
+----------------------------
+
+Tags for swapped pages are stored in an XArray that maps swap entries to 63-bit
+values (see ``arch/arm64/mm/mteswap.c``). In the case when
+``CONFIG_ARM64_MTE_COMP=n``, these values contain pointers to uncompressed
+buffers allocated with kmalloc(). Otherwise, they are 63-bit handles used by the
+functions declared in ``arch/arm64/include/asm/mtecomp.h``:
+
+- mte_compress() compresses the given ``MTE_PAGE_TAG_STORAGE``-byte ``tags``
+  buffer, allocates storage for it, and returns an opaque handle addressing
+  that storage;
+- mte_decompress() decompresses the tags addressed by ``handle``
+  and fills the ``MTE_PAGE_TAG_STORAGE``-byte ``tags`` buffer;
+- mte_release_handle() releases the storage handle returned by
+  mte_compress() (so that this handle cannot be used anymore);
+- mte_storage_size() calculates the size occupied by the tags addressed
+  by ``handle``.
+
+Depending on the size of compressed data, ``mte_compress()`` stores it in one of
+the size classes backed by kmem caches: ``mte-tags-{16,32,64,128}`` for the
+4K-page case (``mte-tags-128`` being used for the data that cannot be compressed
+into 64 bytes and is stored uncompressed).
+A practical common case allows the tags to be compressed into 8 bytes - then
+they are stored in the handle itself.
+
+Handle format
+-------------
+
+The handle returned by ``mte_compress()`` is an ``unsigned long`` that has its
+bit 63 set to 0 (XArray entries must not exceed ``LONG_MAX``)::
+
+   63  62    60  ...   2         0
+  +---+--------+-----+------------+
+  | 0 | INLINE | ... |  SIZE_LOG  |
+  +---+--------+-----+------------+
+
+Bits ``62..60`` is the inline/out-of-line marker: if they all are set to 1, the
+data is stored out-of-line in the buffer pointed to by
+``(handle | BIT(63)) & ~7UL``. Otherwise, the data is stored inline in the
+handle itself.
+
+Bits ``2..0`` denote the size for out-of-line allocations::
+
+  size = 16 << (handle & 0b111)
+
+
+Tag compression
+---------------
+
+The compression algorithm is a variation of RLE (run-length encoding) and works
+as follows (we'll be considering 4K pages and 128-byte tag buffers, but the same
+approach scales to 16- and 64K pages):
+
+1. The input array of 128 (``MTE_PAGE_TAG_STORAGE``) bytes is transformed into
+   tag ranges (two arrays: ``r_tags[]`` containing tag values and ``r_sizes[]``
+   containing range lengths) by ``mte_tags_to_ranges()``. Note that
+   ``r_sizes[]`` sums up to 256 (``MTE_GRANULES_PER_PAGE``).
+
+2. The number of the largest element of ``r_sizes[]`` is stored in
+   ``largest_idx``. The element itself is thrown away from ``r_sizes[]``,
+   because it can be reconstructed from the sum of the remaining elements. Note
+   that now none of the remaining ``r_sizes[]`` elements exceeds
+   ``MTE_PAGE_TAG_STORAGE - 1``.
+
+3. Depending on the number ``N`` of ranges, a storage class is picked::
+
+           N <= 6:  8 bytes (inline case, no allocation required);
+      6 < N <= 11: 16 bytes
+     11 < N <= 23: 32 bytes
+     23 < N <= 46: 64 bytes
+     46 < N:       128 bytes (no compression will be performed)
+
+(See `Why these numbers?`_ below).
+
+4. For the inline case, the following values are stored packed in the 8-byte
+   handle (``i<size>`` means a ``<size>``-bit unsigned integer)::
+
+      largest_idx : i4
+     r_tags[0..5] : i4 x 6
+    r_sizes[0..4] : i7 x 5
+
+   (if N is less than 6, ``r_tags`` and ``r_sizes`` are padded up with zero
+   values)
+
+   Because ``largest_idx`` is <= 5, bit 63 of the handle is always 0 (so the
+   handle can be stored in an Xarray), and bits 62..60 cannot all be 1 (so the
+   handle can be distinguished from a kernel pointer).
+
+5. For the out-of-line case, the storage is allocated from one of the
+   ``mte-tags-{16,32,64,128}`` kmem caches. The resulting pointer is aligned
+   on 8 bytes, so its bits 2..0 can be used to store the size class (see above).
+
+   Bit 63 of the pointer is zeroed out, so that it can be stored in XArray.
+
+6. The data layout in the allocated storage is as follows::
+
+        largest_idx : i6
+       r_tags[0..N] : i4 x N
+    r_sizes[0..N-1] : i7 x (N-1)
+
+Tag decompression
+-----------------
+
+The decompression algorithm performs the steps below.
+
+1. Decide if data is stored inline (bits ``62..60`` of the handle ``!= 0b111``)
+   or out-of line.
+
+2. For the inline case, treat the handle itself as the input buffer.
+
+3. For the out-of-line case, look at bits ``2..0`` of the handle to understand
+   the input buffer length. To obtain the pointer to the input buffer, unset
+   bits ``2..0`` of the handle and set bit ``63``.
+
+4. If the input buffer is 128 byte long, copy its contents to the output
+   buffer.
+
+5. Otherwise, read ``largest_idx``, ``r_tags[]`` and ``r_sizes[]`` from the
+   input buffer. Calculate the removed largest element of ``r_sizes[]`` as
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
+To be able to reconstruct N tag ranges from the compressed data, we need to
+store ``largest_idx``, ``r_tags[N]``, and ``r_sizes[N-1]``. Knowing that the
+sizes do not exceed ``MTE_PAGE_TAG_STORAGE``, those can be packed into
+``S = ilog2(MTE_PAGE_TAG_STORAGE)`` bits, whereas a single tag occupies
+4 bits, and ``largest_idx`` cannot take more than
+``Lmax = ilog2(MTE_GRANULES_PER_PAGE)`` bits.
+
+Now, for each ``B``-byte size class it is possible to find the maximal number
+``M`` such as ``Lmax + 4 * M + S * (M - 1) <= 8 * B``,
+i.e. ``M = (8 * B - 1) / 11``::
+
+ 4K pages: S = 7
+ +-------------+----+--------------+
+ | Buffer size |  M | Storage bits |
+ +-------------+----+--------------+
+ |          8  |  5 |          56  |
+ |         16  | 11 |         122  |
+ |         32  | 23 |         254  |
+ |         64  | 46 |         507  |
+ +-------------+----+--------------+
+
+We can notice that ``M`` (and therefore ``largest_idx``) actually always fits
+into 6 bits. For the inline case it is even guaranteed to fit into 3 bits, which
+lets us squeeze an extra range into a 8-byte buffer. Because the inline case
+requires bit 63 of the handle to be zero, we add that bit to ``largest_idx``,
+knowing it will not be used.
+
+For the revised ``largest_idx`` sizes, we now pick the maximal number ``N``
+such as ``(L + 4 * N + 7 * (N - 1) <= 8 * S``, where ``L = 4`` in the inline
+case and ``L = 6`` otherwise.
+In other words, ``N = (8 * S + 7 - L) / 11``, therefore::
+
+  4K pages: S = 7, L_i = 4, L_o = 6
+  +-------------+----+--------------+
+  | Buffer size |  N | Storage bits |
+  +-------------+----+--------------+
+  |          8  |  6 |          63  |
+  |         16  | 11 |         120  |
+  |         32  | 23 |         252  |
+  |         64  | 46 |         505  |
+  +-------------+----+--------------+
+
+Similarly, for other page sizes::
+
+  16K pages: S = 9, L_i = 4, L_o = 8
+  +-------------+-----+--------------+
+  | Buffer size |  N  | Storage bits |
+  +-------------+-----+--------------+
+  |          8  |   5 |          60  |
+  |         16  |   9 |         116  |
+  |         32  |  19 |         246  |
+  |         64  |  39 |         506  |
+  |        128  |  78 |        1013  |
+  |        256  | 157 |        2040  |
+  +-------------+-----+--------------+
+
+  64K pages: S = 11, L_i = 4, L_o = 10
+  +-------------+-----+--------------+
+  | Buffer size |  N  | Storage bits |
+  +-------------+-----+--------------+
+  |          8  |   4 |          53  |
+  |         16  |   8 |         119  |
+  |         32  |  17 |         254  |
+  |         64  |  34 |         509  |
+  |        128  |  68 |        1019  |
+  |        256  | 136 |        2039  |
+  |        512  | 273 |        4094  |
+  |       1024  | 546 |        8189  |
+  +-------------+-----+--------------+
+
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
+ .. kernel-doc:: arch/arm64/mm/mtecomp.c
+   :export:
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f67..d4fb3b8d11d77 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2093,6 +2093,17 @@ config ARM64_EPAN
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
index 0000000000000..71552bc429882
--- /dev/null
+++ b/arch/arm64/include/asm/mtecomp.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_MTECOMP_H
+#define __ASM_MTECOMP_H
+
+#include <linux/types.h>
+
+unsigned long mte_compress(u8 *tags);
+bool mte_decompress(unsigned long handle, u8 *tags);
+void mte_release_handle(unsigned long handle);
+size_t mte_storage_size(unsigned long handle);
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
index 0000000000000..e2c8f9ef30ca0
--- /dev/null
+++ b/arch/arm64/mm/mtecomp.c
@@ -0,0 +1,467 @@
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
+#include <linux/debugfs.h>
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
+/* The handle must fit into an Xarray value. */
+#define MTE_HANDLE_MASK GENMASK_ULL(62, 0)
+
+/* Out-of-line handles have 0b111 in bits 62..60. */
+#define MTE_NOINLINE_MASK GENMASK_ULL(62, 60)
+
+/* Cache index is stored in the lowest pointer bits. */
+#define MTE_CACHE_ID_MASK GENMASK_ULL(2, 0)
+
+/* Caches start at mte-tags-16 and go up to mte-tags-MTE_PAGE_TAG_STORAGE. */
+#define MTECOMP_NUM_CACHES ilog2(MTE_PAGE_TAG_STORAGE / 8)
+static struct kmem_cache *mtecomp_caches[MTECOMP_NUM_CACHES];
+/*
+ * [0] - store the numbers of created/released inline handles;
+ * [1..MTECOMP_NUM_CACHES] - store the number of allocations/deallocations from
+ *                           mtecomp_caches.
+ */
+static atomic_long_t alloc_counters[MTECOMP_NUM_CACHES + 1];
+static atomic_long_t dealloc_counters[MTECOMP_NUM_CACHES + 1];
+
+/*
+ * Largest number of ranges, for which compressed data fits into 63 bits, can
+ * be encoded with 4 bits.
+ */
+#define MTE_BITS_PER_LARGEST_IDX_INLINE 4
+/*
+ * In the worst case every tag is different, then largest index can be up to
+ * MTE_GRANULES_PER_PAGE.
+ */
+#define MTE_BITS_PER_LARGEST_IDX ilog2(MTE_GRANULES_PER_PAGE)
+/* Range size cannot exceed MTE_GRANULES_PER_PAGE / 2. */
+#define MTE_BITS_PER_SIZE (MTE_BITS_PER_LARGEST_IDX - 1)
+
+/* Translate allocation size into mtecomp_caches[] index. */
+static unsigned int mte_size_to_cache_id(size_t len)
+{
+	return fls(len) - 5;
+}
+
+/* Translate mtecomp_caches[] index into allocation size. */
+static size_t mte_cache_id_to_size(unsigned int id)
+{
+	return 16 << id;
+}
+
+/**
+ * mte_tags_to_ranges() - break @tags into arrays of tag ranges.
+ * @tags: MTE_GRANULES_PER_PAGE-byte array containing MTE tags.
+ * @out_tags: u8 array to store the tag of every range.
+ * @out_sizes: unsigned short array to store the size of every range.
+ * @out_len: length of @out_tags and @out_sizes (output parameter, initially
+ *           equal to lengths of out_tags[] and out_sizes[]).
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
+/*
+ * Translate allocation size into maximum number of ranges that it can hold.
+ *
+ * It is the biggest number N such as:
+ *   MTE_BITS_PER_LARGEST_IDX_INLINE + MTE_TAG_SIZE * N
+ *                                   + MTE_BITS_PER_SIZE * (N-1) <= 63 bits,
+ * for the inline case, or
+ *   MTE_BITS_PER_LARGEST_IDX
+ *     + MTE_TAG_SIZE * N + MTE_BITS_PER_SIZE * (N-1) <= tag array size in bits,
+ * for the out-of line case.
+ */
+static size_t mte_size_to_ranges(size_t size)
+{
+	size_t largest_bits;
+
+	largest_bits = (size == 8) ? MTE_BITS_PER_LARGEST_IDX_INLINE :
+				     MTE_BITS_PER_LARGEST_IDX;
+	return (size * 8 + MTE_BITS_PER_SIZE - largest_bits) /
+	       (MTE_TAG_SIZE + MTE_BITS_PER_SIZE);
+}
+
+/* Translate @num_ranges into the allocation size needed to hold them. */
+static size_t mte_alloc_size(unsigned int num_ranges)
+{
+	size_t size = 8;
+
+	while (size < (1 << MTE_BITS_PER_SIZE)) {
+		if (num_ranges <= mte_size_to_ranges(size))
+			return size;
+		size <<= 1;
+	}
+	return size;
+}
+
+/* Is the data stored inline in the handle itself? */
+static bool mte_is_inline(unsigned long handle)
+{
+	return (handle & MTE_NOINLINE_MASK) != MTE_NOINLINE_MASK;
+}
+
+/**
+ * mte_storage_size() - calculate the memory occupied by compressed tags.
+ * @handle: storage handle returned by mte_compress.
+ *
+ * Returns: size of the storage used for @handle.
+ */
+size_t mte_storage_size(unsigned long handle)
+{
+	if (mte_is_inline(handle))
+		return 8;
+	return mte_cache_id_to_size(handle & MTE_CACHE_ID_MASK);
+}
+EXPORT_SYMBOL_NS(mte_storage_size, MTECOMP);
+
+static void mte_bitmap_write(unsigned long *bitmap, unsigned long value,
+			     unsigned long *pos, unsigned long bits)
+{
+	bitmap_write(bitmap, value, *pos, bits);
+	*pos += bits;
+}
+
+static inline unsigned long mte_largest_idx_bits(size_t size)
+{
+	if (size == 8)
+		return MTE_BITS_PER_LARGEST_IDX_INLINE;
+	return MTE_BITS_PER_LARGEST_IDX;
+}
+
+/* Compress ranges into the buffer that can accommodate up to max_ranges. */
+static void mte_compress_to_buf(size_t len, u8 *tags, unsigned short *sizes,
+				unsigned long *bitmap, size_t size)
+{
+	unsigned long bit_pos = 0, l_bits;
+	unsigned int largest_idx, i;
+	unsigned short largest = 0;
+	size_t max_ranges;
+
+	for (i = 0; i < len; i++) {
+		if (sizes[i] > largest) {
+			largest = sizes[i];
+			largest_idx = i;
+		}
+	}
+	l_bits = mte_largest_idx_bits(size);
+	max_ranges = mte_size_to_ranges(size);
+	mte_bitmap_write(bitmap, largest_idx, &bit_pos, l_bits);
+	for (i = 0; i < len; i++)
+		mte_bitmap_write(bitmap, tags[i], &bit_pos, MTE_TAG_SIZE);
+	for (i = len; i < max_ranges; i++)
+		mte_bitmap_write(bitmap, 0, &bit_pos, MTE_TAG_SIZE);
+	for (i = 0; i < len; i++) {
+		if (i != largest_idx)
+			mte_bitmap_write(bitmap, sizes[i], &bit_pos,
+					 MTE_BITS_PER_SIZE);
+	}
+	for (i = len; i < max_ranges; i++)
+		mte_bitmap_write(bitmap, 0, &bit_pos, MTE_BITS_PER_SIZE);
+}
+
+/**
+ * mte_compress() - compress the given tag array.
+ * @tags: MTE_GRANULES_PER_PAGE-byte array to read the tags from.
+ *
+ * Compresses the tags and returns a 64-bit opaque handle pointing to the
+ * tag storage. May allocate memory, which is freed by @mte_release_handle().
+ *
+ * Returns: 64-bit tag storage handle.
+ */
+unsigned long mte_compress(u8 *tags)
+{
+	struct kmem_cache *cache;
+	unsigned short *r_sizes;
+	unsigned long *storage;
+	unsigned int cache_id;
+	size_t alloc_size;
+	u8 *r_tags;
+	size_t r_len;
+	/*
+	 * mte_compress_to_buf() only initializes the bits that mte_decompress()
+	 * will read. But when the tags are stored in the handle itself, it must
+	 * have all its bits initialized.
+	 */
+	unsigned long result = 0;
+
+	r_sizes = kmalloc_array(MTE_GRANULES_PER_PAGE, sizeof(unsigned short),
+				GFP_KERNEL);
+	r_tags = kmalloc(MTE_GRANULES_PER_PAGE, GFP_KERNEL);
+	if (!r_sizes || !r_tags)
+		goto ret;
+	r_len = MTE_GRANULES_PER_PAGE;
+	mte_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	alloc_size = mte_alloc_size(r_len);
+	if (alloc_size == 8) {
+		mte_compress_to_buf(r_len, r_tags, r_sizes, &result,
+				    alloc_size);
+		atomic_long_inc(&alloc_counters[0]);
+		goto ret;
+	}
+	cache_id = mte_size_to_cache_id(alloc_size);
+	cache = mtecomp_caches[cache_id];
+	storage = kmem_cache_alloc(cache, GFP_KERNEL);
+	atomic_long_inc(&alloc_counters[cache_id + 1]);
+	if (!storage) {
+		result = 0;
+		goto ret;
+	}
+	if (alloc_size < MTE_PAGE_TAG_STORAGE) {
+		/* alloc_size is always a multiple of sizeof(unsigned long). */
+		mte_compress_to_buf(r_len, r_tags, r_sizes, storage,
+				    alloc_size);
+		result = ((unsigned long)storage | cache_id) & MTE_HANDLE_MASK;
+		goto ret;
+	}
+	memcpy(storage, tags, alloc_size);
+	result = ((unsigned long)storage | cache_id) & MTE_HANDLE_MASK;
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
+/* Decompress the contents of the given buffer into @tags. */
+static bool mte_decompress_from_buf(const unsigned long *bitmap, size_t size,
+				    u8 *tags)
+{
+	unsigned long bit_pos = 0, l_bits;
+	unsigned short *r_sizes, sum;
+	unsigned int largest_idx, i;
+	bool result = true;
+	size_t max_ranges;
+	u8 *r_tags;
+
+	max_ranges = mte_size_to_ranges(size);
+	l_bits = mte_largest_idx_bits(size);
+	largest_idx = mte_bitmap_read(bitmap, &bit_pos, l_bits);
+	r_sizes = kmalloc_array(max_ranges, sizeof(unsigned short), GFP_KERNEL);
+	r_tags = kmalloc(max_ranges, GFP_KERNEL);
+	if (!r_sizes || !r_tags) {
+		result = false;
+		goto ret;
+	}
+
+	for (i = 0; i < max_ranges; i++)
+		r_tags[i] = mte_bitmap_read(bitmap, &bit_pos, MTE_TAG_SIZE);
+	for (i = 0, sum = 0; i < max_ranges; i++) {
+		if (i == largest_idx)
+			continue;
+		r_sizes[i] =
+			mte_bitmap_read(bitmap, &bit_pos, MTE_BITS_PER_SIZE);
+		if (!r_sizes[i]) {
+			max_ranges = i;
+			break;
+		}
+		sum += r_sizes[i];
+	}
+	if (sum >= MTE_GRANULES_PER_PAGE) {
+		result = false;
+		goto ret;
+	}
+	r_sizes[largest_idx] = MTE_GRANULES_PER_PAGE - sum;
+	mte_ranges_to_tags(r_tags, r_sizes, max_ranges, tags);
+	result = true;
+ret:
+	kfree(r_sizes);
+	kfree(r_tags);
+	return result;
+}
+
+/* Get pointer to the out-of-line storage from a handle. */
+static void *mte_storage(unsigned long handle)
+{
+	if (mte_is_inline(handle))
+		return NULL;
+	return (void *)((handle & (~MTE_CACHE_ID_MASK)) | BIT_ULL(63));
+}
+
+/**
+ * mte_decompress() - decompress the tag array addressed by the handle.
+ * @handle: handle returned by @mte_decompress()
+ * @tags: MTE_GRANULES_PER_PAGE-byte array to write the tags to.
+ *
+ * Reads the compressed data and writes it into the user-supplied tag array.
+ *
+ * Returns: true on success, false on error.
+ */
+bool mte_decompress(unsigned long handle, u8 *tags)
+{
+	unsigned long *storage = mte_storage(handle);
+	size_t size = mte_storage_size(handle);
+
+	switch (size) {
+	case 8:
+		return mte_decompress_from_buf(&handle, size, tags);
+	case MTE_PAGE_TAG_STORAGE:
+		memcpy(tags, storage, size);
+		return true;
+	default:
+		return mte_decompress_from_buf(storage, size, tags);
+	}
+}
+EXPORT_SYMBOL_NS(mte_decompress, MTECOMP);
+
+/**
+ * mte_release_handle() - release the handle returned by mte_compress().
+ * @handle: handle returned by mte_compress().
+ */
+void mte_release_handle(unsigned long handle)
+{
+	unsigned int cache_id;
+	struct kmem_cache *c;
+	void *storage;
+	size_t size;
+
+	storage = mte_storage(handle);
+	if (!storage) {
+		atomic_long_inc(&dealloc_counters[0]);
+		return;
+	}
+
+	size = mte_storage_size(handle);
+	cache_id = mte_size_to_cache_id(size);
+	c = mtecomp_caches[cache_id];
+	kmem_cache_free(c, storage);
+	atomic_long_inc(&dealloc_counters[cache_id + 1]);
+}
+EXPORT_SYMBOL_NS(mte_release_handle, MTECOMP);
+
+/* DebugFS interface. */
+static int stats_show(struct seq_file *seq, void *v)
+{
+	unsigned long total_mem_alloc = 0, total_mem_dealloc = 0;
+	unsigned long total_num_alloc = 0, total_num_dealloc = 0;
+	unsigned long size = 8;
+	long alloc, dealloc;
+	int i;
+
+	for (i = 0; i <= MTECOMP_NUM_CACHES; i++) {
+		alloc = atomic_long_read(&alloc_counters[i]);
+		dealloc = atomic_long_read(&dealloc_counters[i]);
+		total_num_alloc += alloc;
+		total_num_dealloc += dealloc;
+		/*
+		 * Do not count 8-byte buffers towards compressed tag storage
+		 * size.
+		 */
+		if (i) {
+			total_mem_alloc += (size * alloc);
+			total_mem_dealloc += (size * dealloc);
+		}
+		seq_printf(seq,
+			   "%lu bytes: %lu allocations, %lu deallocations\n",
+			   size, alloc, dealloc);
+		size <<= 1;
+	}
+	seq_printf(seq, "uncompressed tag storage size: %lu\n",
+		   (total_num_alloc - total_num_dealloc) *
+			   MTE_PAGE_TAG_STORAGE);
+	seq_printf(seq, "compressed tag storage size: %lu\n",
+		   total_mem_alloc - total_mem_dealloc);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stats);
+
+static int mtecomp_debugfs_init(void)
+{
+	struct dentry *mtecomp_dir;
+
+	mtecomp_dir = debugfs_create_dir("mtecomp", NULL);
+	debugfs_create_file("stats", 0444, mtecomp_dir, NULL, &stats_fops);
+	return 0;
+}
+
+/* Set up mtecomp_caches[]. */
+static int mtecomp_init(void)
+{
+	unsigned int i;
+	char name[16];
+	size_t size;
+
+	static_assert(MTECOMP_NUM_CACHES <= (MTE_CACHE_ID_MASK + 1));
+	for (i = 0; i < MTECOMP_NUM_CACHES; i++) {
+		size = mte_cache_id_to_size(i);
+		snprintf(name, sizeof(name), "mte-tags-%ld", size);
+		mtecomp_caches[i] =
+			kmem_cache_create(name, size, size, 0, NULL);
+	}
+	mtecomp_debugfs_init();
+	return 0;
+}
+module_init(mtecomp_init);
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
2.42.0.515.g380fc7ccd1-goog

