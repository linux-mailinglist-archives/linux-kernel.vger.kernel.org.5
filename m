Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8531C75B5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjGTRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGTRkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:40:21 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90E31999
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:10 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-993eeb3a950so77441466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874809; x=1690479609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyLcAjsRGHg3YdTbeFrMs0jC9ZNfsu8l2EPbq5hpOTw=;
        b=TKJeI6mT5cm/0eupLOKH/nUeOwO6BuvhLBiKaeZcjMCJ5Hc6RrSY+6Lq2g5Gtukby2
         xMKphmMtRJV/BaWT0UgCI266KA/QNAof74zcrj/zO+/cAhMyBnGUr1JG9YkP0vD6jyHC
         YWJ/4hZmlBijJlXKnBK73sqSYrrvtzhT3MhJ94qZlvv23PVy2UtHWyJ84czbxXy6r709
         UCb/LGzJbGWu3lceFDvomHS4pEw4IkCerhJtzAl777yM//4bHmpJ2xaQOe8ntPkxFUA2
         VYLxxHh8yEAHbvM7PGVzKM70m8JaYeMeA3Rv4UUGmGedhPBBq+sX1ZPmezJbIxY0sCmz
         TA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874809; x=1690479609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyLcAjsRGHg3YdTbeFrMs0jC9ZNfsu8l2EPbq5hpOTw=;
        b=j5imSJqfgGzxVOAzGKffoGKL4Nga3woa5/XJ9VUL5NbGVOxFUewJaRDRuP/iZVDIC0
         vxLiCDCffIVX9jap4WULK6EAbAwBijZqry/ydSJ4ELXx2W6fjJKLIQqj8MMhFukFg/AG
         fjMs1hrDD0hlh3/xqVESwiCtQ+NTsHWXV5TO9i1dKGDa3X/X9og7hmhaWh3sCUJZtCUp
         XUyBcYYVNKiFzMwV24Fin54sCwtuMUCzv7Zf2Mtzp8a5KAJeY4E4W/RrVQy49lUtoPbs
         Tmy5NUM/cTV0zzYVw2Mk8biKwLe82cdKyF1DLvjySWuzGuFxOWPQeroUpIzwt/Z8zMuZ
         2FFQ==
X-Gm-Message-State: ABy/qLYle+MtZXkeaUxBXHlndrM+oGysPLIqV/B905cJFvUQ8Hu7JVxa
        at1eajSa1QzjmDXRwM++WAUd8o4vDRM=
X-Google-Smtp-Source: APBJJlGUF69Rd8W+RlvRqh81Ord/BJMAhnMg5+JZweGqNEj5ZeJB7E3He8v3dUhLM5zJs3ti/NjvWGX5chw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c495:c29a:e275:1dfb])
 (user=glider job=sendgmr) by 2002:a17:907:1de7:b0:99b:4866:e952 with SMTP id
 og39-20020a1709071de700b0099b4866e952mr10099ejc.7.1689874809321; Thu, 20 Jul
 2023 10:40:09 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:39:54 +0200
In-Reply-To: <20230720173956.3674987-1-glider@google.com>
Mime-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720173956.3674987-4-glider@google.com>
Subject: [PATCH v4 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
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

The config implements the algorithm compressing memory tags for ARM MTE
during swapping.

The algorithm is based on RLE and specifically targets 128-byte buffers
of tags corresponding to a single page. In the common case a buffer
can be compressed into 63 bits, making it possible to store it without
additional memory allocation.

Suggested-by: Evgenii Stepanov <eugenis@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
 .../arch/arm64/mte-tag-compression.rst        | 212 ++++++++++
 arch/arm64/Kconfig                            |   9 +
 arch/arm64/include/asm/mtecomp.h              |  13 +
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/mtecomp.c                       | 382 ++++++++++++++++++
 6 files changed, 618 insertions(+)
 create mode 100644 Documentation/arch/arm64/mte-tag-compression.rst
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c

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
index 0000000000000..af6716d53c1a8
--- /dev/null
+++ b/Documentation/arch/arm64/mte-tag-compression.rst
@@ -0,0 +1,212 @@
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
+(256 4-bit tags each corresponding to a 16-byte MTE granule). By default, MTE
+carves out 3.125% (1/16) of the available physical memory to store the tags.
+
+When MTE pages are saved to swap, their tags need to be stored in the kernel
+memory. If the system swap is used heavily, these tags may take a substantial
+portion of the physical memory, which in the case of a zram-backed swap may
+even exceed the memory used to store the swapped pages themselves. To reduce
+memory waste, ``CONFIG_ARM64_MTE_COMP`` allows the kernel to store the tags in
+compressed form.
+
+Implementation details
+======================
+
+The algorithm attempts to compress a 128-byte (``MTE_GRANULES_PER_PAGE / 2``)
+array of tags into a smaller byte sequence that can be stored in a
+16-, 32-, or 64-byte buffer. A special case is storing the tags inline in
+an 8-byte pointer.
+
+Tag manipulation and storage
+----------------------------
+
+Tags for swapped pages are stored in an XArray that maps swap entries to 63-bit
+values (see ``arch/arm64/mm/mteswap.c``). In the case when
+``CONFIG_ARM64_MTE_COMP=n``, these values contain pointers to 128-byte buffers
+allocated with kmalloc(). Otherwise, they are 63-bit handles used by the
+functions declared in ``arch/arm64/include/asm/mtecomp.h``:
+
+- mte_compress() compresses the given 128-byte ``tags`` buffer, allocates
+  storage for it, and returns an opaque handle addressing that storage;
+- mte_decompress() decompresses the tags addressed by ``handle``
+  and fills the 128-byte ``tags`` buffer;
+- mte_release_handle() releases the storage handle returned by
+  mte_compress() (so that this handle cannot be used anymore);
+- mte_storage_size() calculates the size occupied by the tags addressed
+  by ``handle``.
+
+Depending on the size of compressed data, ``mte_compress()`` stores it in one of
+the size classes backed by kmem caches: ``mte-tags-16``, ``mte-tags-32``,
+``mte-tags-64``, or ``mte-tags-128`` (for the data that cannot be compressed
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
+  | 0 | INLINE | ... | SIZE_CLASS |
+  +---+--------+-----+------------+
+
+Bits ``62..60`` is the inline/out-of-line marker: if they all are set to 1, the
+data is stored out-of-line in the buffer pointed to by
+``(handle | BIT(63)) & ~7UL``. Otherwise, the data is stored inline in the
+handle itself.
+
+Bits ``2..0`` denote the size class for out-of-line allocations:
+
+- ``0b001`` for ``mte-tags-16``;
+- ``0b010`` for ``mte-tags-32``;
+- ``0b100`` for ``mte-tags-64``;
+- ``0b000`` for ``mte-tags-128``.
+
+
+Tag compression
+---------------
+
+The compression algorithm is a variation of RLE (run-length encoding) and works
+as follows.
+
+1. The input array of 128 bytes is transformed into tag ranges (two arrays:
+   ``r_tags[]`` containing tag values and ``r_sizes[]`` containing range
+   lengths) by ``mte_tags_to_ranges()``. Note that ``r_sizes[]`` sums up to 256.
+
+2. The number of the largest element of ``r_sizes[]`` is stored in
+   ``largest_idx``. The element itself is thrown away from ``r_sizes[]``,
+   because it can be reconstructed from the sum of the remaining elements. Note
+   that now none of the remaining ``r_sizes[]`` elements exceeds 127.
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
+   Because ``largest_idx`` is <= 5, bit 63 of the handle is always 0 (so it
+   can be stored in the XArray), and bits 62..60 cannot all be 1, so it can be
+   distinguished from a kernel pointer.
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
+sizes do not exceed 127, those can be packed into 7 bits, whereas a single tag
+occupies 4 bits, and ``largest_idx`` cannot take more than 8 bits.
+
+Now, for each ``S``-byte size class it is possible to find the maximal number
+``M`` such as ``8 + 4 * M + 7 * (M - 1) <= 8 * S``,
+i.e. ``M = (8 * S - 1) / 11``::
+
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
+  +-------------+----+--------------+
+  | Buffer size |  N | Storage bits |
+  +-------------+----+--------------+
+  |          8  |  6 |          63  |
+  |         16  | 11 |         120  |
+  |         32  | 23 |         252  |
+  |         64  | 46 |         505  |
+  +-------------+----+--------------+
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
+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f67..3ac6e302b1509 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2093,6 +2093,15 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+config ARM64_MTE_COMP
+	bool "Tag compression for ARM64 Memory Tagging Extension"
+	default y
+	depends on ARM64_MTE
+	help
+	  Enable tag compression support for ARM64 Memory Tagging Extension.
+
+	  128-byte tag buffers corresponding to 4K pages can be compressed to save heap memory.
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
index 0000000000000..6d27f69f9521f
--- /dev/null
+++ b/arch/arm64/mm/mtecomp.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * MTE tag compression algorithm.
+ * Proposed by Evgenii Stepanov <eugenis@google.com>
+ * See Documentation/arch/arm64/mte-tag-compression.rst for more details.
+ */
+
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
+/* The handle must fit into an Xarray value. */
+#define MTE_HANDLE_MASK GENMASK_ULL(62, 0)
+
+/* Out-of-line handles have 0b111 in bits 62..60. */
+#define MTE_NOINLINE_MASK GENMASK_ULL(62, 60)
+
+/* Cache index is stored in the lowest pointer bits. */
+#define MTE_CACHE_ID_MASK GENMASK_ULL(2, 0)
+
+/*
+ * Four separate caches to store out-of-line data:
+ *  0: mte-tags-128
+ *  1: mte-tags-16
+ *  2: mte-tags-32
+ *  3: mte-tags-64
+ */
+#define MTECOMP_NUM_CACHES 4
+static struct kmem_cache *mtecomp_caches[MTECOMP_NUM_CACHES];
+
+/*
+ * Sizes of compressed values. These depend on MTE_TAG_SIZE and
+ * MTE_GRANULES_PER_PAGE.
+ */
+#define MTE_BITS_PER_TAG 4
+#define MTE_BITS_PER_SIZE 7
+#define MTE_BITS_PER_LARGEST_IDX_INLINE 4
+#define MTE_BITS_PER_LARGEST_IDX 6
+
+/* Translate allocation size into mtecomp_caches[] index. */
+static unsigned int mte_size_to_cache_id(size_t len)
+{
+	if (len < 128)
+		return fls(len >> 4);
+	return 0;
+}
+
+/* Translate mtecomp_caches[] index into allocation size. */
+static size_t mte_cache_id_to_size(unsigned int id)
+{
+	if (id == 0)
+		return 128;
+	return 8 << id;
+}
+
+/**
+ * mte_tags_to_ranges() - break @tags into arrays of tag ranges.
+ * @tags: 128-byte array containing 256 MTE tags.
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
+	out_tags[0] = prev_tag;
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
+EXPORT_SYMBOL_NS(mte_tags_to_ranges, MTECOMP);
+
+/**
+ * mte_ranges_to_tags() - fill @tags using given tag ranges.
+ * @r_tags: u8[] containing the tag of every range.
+ * @r_sizes: unsigned short[] containing the size of every range.
+ * @r_len: length of @r_tags and @r_sizes.
+ * @tags: 128-byte array to write the tags to.
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
+ *   4 + 4*N + 7*(N-1) <= 63 bits, for the inline case,
+ * or
+ *   6 + 4*N + 7*(N-1) <= array size in bits (128, 256, or 512),
+ * for the out-of line case.
+ */
+static size_t mte_size_to_ranges(size_t size)
+{
+	size_t largest_bits;
+	size_t ret = 0;
+
+	largest_bits = (size == 8) ? MTE_BITS_PER_LARGEST_IDX_INLINE :
+				     MTE_BITS_PER_LARGEST_IDX;
+	ret = (size * 8 + MTE_BITS_PER_SIZE - largest_bits) /
+	      (MTE_BITS_PER_TAG + MTE_BITS_PER_SIZE);
+	return ret;
+}
+
+/* Translate @num_ranges into the allocation size needed to hold them. */
+static size_t mte_alloc_size(unsigned int num_ranges)
+{
+	size_t sizes[4] = { 8, 16, 32, 64 };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		if (num_ranges <= mte_size_to_ranges(sizes[i]))
+			return sizes[i];
+	}
+	return 128;
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
+		mte_bitmap_write(bitmap, tags[i], &bit_pos, MTE_BITS_PER_TAG);
+	for (i = len; i < max_ranges; i++)
+		mte_bitmap_write(bitmap, 0, &bit_pos, MTE_BITS_PER_TAG);
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
+ * @tags: 128-byte array to read the tags from.
+ *
+ * Compresses the tags and returns a 64-bit opaque handle pointing to the
+ * tag storage. May allocate memory, which is freed by @mte_release_handle().
+ * Returns: 64-bit tag storage handle.
+ */
+unsigned long mte_compress(u8 *tags)
+{
+	unsigned short r_sizes[256];
+	struct kmem_cache *cache;
+	unsigned long *storage;
+	unsigned int cache_id;
+	size_t alloc_size;
+	u8 r_tags[256];
+	size_t r_len;
+	/*
+	 * mte_compress_to_buf() only initializes the bits that mte_decompress()
+	 * will read. But when the tags are stored in the handle itself, it must
+	 * have all its bits initialized.
+	 */
+	unsigned long result = 0;
+
+	r_len = sizeof(r_tags);
+	mte_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	alloc_size = mte_alloc_size(r_len);
+	if (alloc_size == 8) {
+		mte_compress_to_buf(r_len, r_tags, r_sizes, &result,
+				    alloc_size);
+		return result;
+	}
+	cache_id = mte_size_to_cache_id(alloc_size);
+	cache = mtecomp_caches[cache_id];
+	storage = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (alloc_size < 128) {
+		/* alloc_size is always a multiple of sizeof(unsigned long). */
+		mte_compress_to_buf(r_len, r_tags, r_sizes, storage,
+				    alloc_size);
+		return ((unsigned long)storage | cache_id) & MTE_HANDLE_MASK;
+	}
+	memcpy(storage, tags, alloc_size);
+	return (unsigned long)storage & MTE_HANDLE_MASK;
+}
+EXPORT_SYMBOL_NS(mte_compress, MTECOMP);
+
+static unsigned long mte_bitmap_read(const unsigned long *bitmap,
+				     unsigned long *pos, unsigned long bits)
+{
+	unsigned long result;
+
+	result = bitmap_read(bitmap, *pos, bits);
+	*pos += bits;
+	return result;
+}
+
+/* Decompress the contents of the given buffer into @tags. */
+static bool mte_decompress_from_buf(const unsigned long *bitmap, size_t size,
+				    u8 *tags)
+{
+	unsigned short r_sizes[46], sum = 0;
+	unsigned long bit_pos = 0, l_bits;
+	unsigned int largest_idx, i;
+	size_t max_ranges;
+	u8 r_tags[46];
+
+	max_ranges = mte_size_to_ranges(size);
+	l_bits = mte_largest_idx_bits(size);
+	largest_idx = mte_bitmap_read(bitmap, &bit_pos, l_bits);
+	for (i = 0; i < max_ranges; i++)
+		r_tags[i] = mte_bitmap_read(bitmap, &bit_pos, MTE_BITS_PER_TAG);
+	for (i = 0; i < max_ranges; i++) {
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
+	if (sum >= 256)
+		return false;
+	r_sizes[largest_idx] = 256 - sum;
+	mte_ranges_to_tags(r_tags, r_sizes, max_ranges, tags);
+	return true;
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
+ * @tags: 128-byte array to write the tags to.
+ *
+ * Reads the compressed data and writes it into the user-supplied tag array.
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
+	case 128:
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
+	struct kmem_cache *c;
+	void *storage;
+	size_t size;
+
+	storage = mte_storage(handle);
+	if (!storage)
+		return;
+
+	size = mte_storage_size(handle);
+	c = mtecomp_caches[mte_size_to_cache_id(size)];
+	kmem_cache_free(c, storage);
+}
+EXPORT_SYMBOL_NS(mte_release_handle, MTECOMP);
+
+/* Set up mtecomp_caches[]. */
+static int mtecomp_init(void)
+{
+	unsigned int i;
+	char name[16];
+	size_t size;
+
+	static_assert(MTE_PAGE_TAG_STORAGE == 128);
+	static_assert(MTE_TAG_SIZE == MTE_BITS_PER_TAG);
+	for (i = 0; i < MTECOMP_NUM_CACHES; i++) {
+		size = mte_cache_id_to_size(i);
+		snprintf(name, sizeof(name), "mte-tags-%ld", size);
+		mtecomp_caches[i] =
+			kmem_cache_create(name, size, size, 0, NULL);
+	}
+	return 0;
+}
+module_init(mtecomp_init);
-- 
2.41.0.487.g6d72f3e995-goog

