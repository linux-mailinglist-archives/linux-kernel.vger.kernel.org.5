Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA99812E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444091AbjLNLHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443962AbjLNLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:07:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238A3D56
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:07:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5deda822167so69235527b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702552025; x=1703156825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKxTzibU43FbKAAwU1cbn+VKrccGDamZlyB7KN8LFoo=;
        b=nBhImV6Y49TPWVACxCkWZQ+psa3/ar62hzVxDuLZXA7BvoyGuY9s60eqOXJ3amBiuq
         SwBKJMdg15C6EPwqaE/WR/7aD7FMnyV65WI90xNd3bLqJq8uernNphWl9CnUxOI/TUtJ
         Zsb83DSZFxvEwAIO9tqiHZxH4E1cMfH/sUNx1tRmI1fbjR/LB4QIS5WmJPDXe7hjAoZu
         Lbv/gUY6gKgzayQ1gSeJHqo6iLKR9ccd/kJV1SuYDbkBCB7ozL4dM7Q2qu8KSv06Otti
         ueob3K5sZ+O6EepzM4uGNyvqswBlHmLK+i1DNojUVW065Dw6k7fw6EFUjRP6ThrHl+P2
         ukpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552025; x=1703156825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKxTzibU43FbKAAwU1cbn+VKrccGDamZlyB7KN8LFoo=;
        b=tulWvG9dlkdmys2QMsqtaYlGGNrSLdUqPAAF3aw/cSL8dSd3vDuhVlpBxp4Gi0kEFq
         pzbCC6hqhztZvm8wOUw26+vib4pxZ1yI+Zxny8qiJlOKC0++zSs8OQoDvuWyYMUdO/pY
         xczBJx7+Ev6bvoOvcQFvekghvkMaqOzlaD1TuMhHxosOgReBDI2THkTcpC7z7g2BhFB/
         CqrJWOj19YtLCR1wp58Jmw2d3mEn/8XDTFSb2z1k/uPft3MbiyvoG3d5BU1qeZ9FcZbG
         Ua9ubTptTweTWRpEvp9Tnhqdtctey9YUosmOx+inRb8adf0tAnGzVvHTipVhqR0MfaeA
         Iiqg==
X-Gm-Message-State: AOJu0YyRjyySWFVwKF5XRDKiamjXfjN4bQvOgVSqaTW16V8KuAt75cqO
        RerHqdbODOvP69Zb0/nZGuOgAGTMa0A=
X-Google-Smtp-Source: AGHT+IFBw8Rja0Ncdp/+8Jl8ZkbXeAqW7FhNZ926MndywhHb2Vn/iUMG2mrbxSRArQwUykHTFC+G8aHdUrw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8447:3e89:1f77:ff8a])
 (user=glider job=sendgmr) by 2002:a05:690c:3389:b0:5e3:e985:18bb with SMTP id
 fl9-20020a05690c338900b005e3e98518bbmr1990ywb.7.1702552025370; Thu, 14 Dec
 2023 03:07:05 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:06:39 +0100
In-Reply-To: <20231214110639.2294687-1-glider@google.com>
Mime-Version: 1.0
References: <20231214110639.2294687-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214110639.2294687-8-glider@google.com>
Subject: [PATCH v10-mte 7/7] arm64: mte: implement CONFIG_ARM64_MTE_SWAP_STATS
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a config to collect the usage statistics for ARM MTE tag
compression. This patch introduces allocation/deallocation counters
for buffers that were stored uncompressed (and thus occupy 128 bytes of
heap plus the Xarray overhead to store a pointer) and those that were
compressed into 8-byte pointers (effectively using 0 bytes of heap in
addition to the Xarray overhead).

The counters are exposed to the userspace via
/sys/kernel/debug/mteswap/stats:

  # cat /sys/kernel/debug/mteswap/stats
  8 bytes:      102496 allocations,     67302 deallocations
  128 bytes:    212234 allocations,     178278 deallocations
  uncompressed tag storage size:        8851200
  compressed tag storage size:  4346368

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>

---

This patch was split off from the "arm64: mte: add compression support
to mteswap.c" patch
(https://lore.kernel.org/linux-arm-kernel/ZUVulBKVYK7cq2rJ@yury-ThinkPad/T/#m819ec30beb9de53d5c442f7e3247456f8966d88a)

v10-mte:
 - added Catalin's Acked-by:

v9:
 - add this patch, put the stats behind a separate config,
   mention /sys/kernel/debug/mteswap/stats in the documentation
---
 .../arch/arm64/mte-tag-compression.rst        | 12 +++
 arch/arm64/Kconfig                            | 15 +++
 arch/arm64/mm/mteswap.c                       | 93 ++++++++++++++++++-
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/mte-tag-compression.rst b/Documentation/arch/arm64/mte-tag-compression.rst
index 8fe6b51a9db6d..4c25b96f7d4b5 100644
--- a/Documentation/arch/arm64/mte-tag-compression.rst
+++ b/Documentation/arch/arm64/mte-tag-compression.rst
@@ -145,6 +145,18 @@ Tag compression and decompression implicitly rely on the fixed MTE tag size
 (4 bits) and number of tags per page. Should these values change, the algorithm
 may need to be revised.
 
+Stats
+=====
+
+When `CONFIG_ARM64_MTE_SWAP_STATS` is enabled, `arch/arm64/mm/mteswap.c` exports
+usage statistics for tag compression used when swapping tagged pages. The data
+can be accessed via debugfs::
+
+  # cat /sys/kernel/debug/mteswap/stats
+  8 bytes:        10438 allocations,      10417 deallocations
+  128 bytes:      26180 allocations,      26179 deallocations
+  uncompressed tag storage size:  2816
+  compressed tag storage size:    128
 
 Programming Interface
 =====================
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6a1397a96f2f0..49a786c7edadd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2100,6 +2100,21 @@ config ARM64_MTE_COMP_KUNIT_TEST
 	  be compressed into pointer-size values and correctly decompressed
 	  afterwards.
 
+config ARM64_MTE_SWAP_STATS
+	bool "Collect usage statistics of tag compression for swapped MTE tags"
+	default y
+	depends on ARM64_MTE && ARM64_MTE_COMP
+	help
+	  Collect usage statistics for ARM64 MTE tag compression during swapping.
+
+	  Adds allocation/deallocation counters for buffers that were stored
+	  uncompressed (and thus occupy 128 bytes of heap plus the Xarray
+	  overhead to store a pointer) and those that were compressed into
+	  8-byte pointers (effectively using 0 bytes of heap in addition to
+	  the Xarray overhead).
+	  The counters are exposed to the userspace via
+	  /sys/kernel/debug/mteswap/stats.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index 70f5c8ecd640d..1c6c78b9a9037 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/debugfs.h>
 #include <linux/pagemap.h>
 #include <linux/xarray.h>
 #include <linux/slab.h>
@@ -11,16 +12,54 @@
 
 static DEFINE_XARRAY(mte_pages);
 
+enum mteswap_counters {
+	MTESWAP_CTR_INLINE = 0,
+	MTESWAP_CTR_OUTLINE,
+	MTESWAP_CTR_SIZE
+};
+
+#if defined(CONFIG_ARM64_MTE_SWAP_STATS)
+static atomic_long_t alloc_counters[MTESWAP_CTR_SIZE];
+static atomic_long_t dealloc_counters[MTESWAP_CTR_SIZE];
+
+static void inc_alloc_counter(int kind)
+{
+	atomic_long_inc(&alloc_counters[kind]);
+}
+
+static void inc_dealloc_counter(int kind)
+{
+	atomic_long_inc(&dealloc_counters[kind]);
+}
+#else
+static void inc_alloc_counter(int kind)
+{
+}
+
+static void inc_dealloc_counter(int kind)
+{
+}
+#endif
+
 void *mte_allocate_tag_storage(void)
 {
+	void *ret;
+
 	/* tags granule is 16 bytes, 2 tags stored per byte */
-	return kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	ret = kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	if (ret)
+		inc_alloc_counter(MTESWAP_CTR_OUTLINE);
+	return ret;
 }
 
 void mte_free_tag_storage(char *storage)
 {
-	if (!mte_is_compressed(storage))
+	if (!mte_is_compressed(storage)) {
 		kfree(storage);
+		inc_dealloc_counter(MTESWAP_CTR_OUTLINE);
+	} else {
+		inc_dealloc_counter(MTESWAP_CTR_INLINE);
+	}
 }
 
 int mte_save_tags(struct page *page)
@@ -39,6 +78,7 @@ int mte_save_tags(struct page *page)
 	if (compressed_storage) {
 		mte_free_tag_storage(tag_storage);
 		tag_storage = compressed_storage;
+		inc_alloc_counter(MTESWAP_CTR_INLINE);
 	}
 
 	/* lookup the swap entry.val from the page */
@@ -98,3 +138,52 @@ void mte_invalidate_tags_area(int type)
 	}
 	xa_unlock(&mte_pages);
 }
+
+#if defined(CONFIG_ARM64_MTE_SWAP_STATS)
+/* DebugFS interface. */
+static int stats_show(struct seq_file *seq, void *v)
+{
+	unsigned long total_mem_alloc = 0, total_mem_dealloc = 0;
+	unsigned long total_num_alloc = 0, total_num_dealloc = 0;
+	unsigned long sizes[2] = { 8, MTE_PAGE_TAG_STORAGE };
+	long alloc, dealloc;
+	unsigned long size;
+	int i;
+
+	for (i = 0; i < MTESWAP_CTR_SIZE; i++) {
+		alloc = atomic_long_read(&alloc_counters[i]);
+		dealloc = atomic_long_read(&dealloc_counters[i]);
+		total_num_alloc += alloc;
+		total_num_dealloc += dealloc;
+		size = sizes[i];
+		/*
+		 * Do not count 8-byte buffers towards compressed tag storage
+		 * size.
+		 */
+		if (i) {
+			total_mem_alloc += (size * alloc);
+			total_mem_dealloc += (size * dealloc);
+		}
+		seq_printf(seq,
+			   "%lu bytes:\t%lu allocations,\t%lu deallocations\n",
+			   size, alloc, dealloc);
+	}
+	seq_printf(seq, "uncompressed tag storage size:\t%lu\n",
+		   (total_num_alloc - total_num_dealloc) *
+			   MTE_PAGE_TAG_STORAGE);
+	seq_printf(seq, "compressed tag storage size:\t%lu\n",
+		   total_mem_alloc - total_mem_dealloc);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stats);
+
+static int mteswap_init(void)
+{
+	struct dentry *mteswap_dir;
+
+	mteswap_dir = debugfs_create_dir("mteswap", NULL);
+	debugfs_create_file("stats", 0444, mteswap_dir, NULL, &stats_fops);
+	return 0;
+}
+module_init(mteswap_init);
+#endif
-- 
2.43.0.472.g3155946c3a-goog

