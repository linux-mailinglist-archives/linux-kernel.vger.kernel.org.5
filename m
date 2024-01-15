Return-Path: <linux-kernel+bounces-25795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2A82D5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9802823AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF40E56D;
	Mon, 15 Jan 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzwcuDlH"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE0E541
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a2daab7f775so31014966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705310852; x=1705915652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmhCfln9ac1sszz1cn9mo233ZA1ZqqWQM/ks4o+Avbk=;
        b=JzwcuDlHyfuflMWO07WxWr4rEq2cJMl5H9i+nxg1L4O8wFoutdveUsA60/LUnnS9IZ
         Ds2p902XKJIVw4TOM/GQoP7eoxJ+2ImglcWhhzNSg/CQXbrGRdLdiCv05jZW5CdJEIar
         esY5c1h8Dj+MuA+Pd1Xgvhh+2LpNo2Ye0P1u33mCEVPgbn9owXEF2kZRs4fG3cZ2HdgE
         sxx3Ln/IBmfV0f63lscVP0jFHVDdTyB7O4uZQ5Oim7rHDalrQBWb1mqyTCEgRisCcuPS
         zr7DRJRUqog1j0c6sJapYH9aZCOfMmc7mD0GyjiD9edjepMyxXemXSq1po0a+5vu1ow7
         eUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310852; x=1705915652;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmhCfln9ac1sszz1cn9mo233ZA1ZqqWQM/ks4o+Avbk=;
        b=o/JXsJbJkg9R0AX+vfoJk2MxM1RZsPwJAmfd80n5XCWmTVQyQO/4AQaDU2cYhB1Vgy
         e4eYYMi4Cq4fbxRKROYLV1LtdFqZwfqP8SLd2NM3HQUocv7qZ/gTifGN+e86tD71YzHl
         56yvMre9VMtAFpdu7v2sNJ4CxGs8+X564w86LvxIAEDKVeYSD2uELRY65zK1Ge0DkkEI
         Oj3jVGD7DoOZTBLLdVrImfCk4AVmfy2681Ch8B0rXDFn/q0ZUzluPMwsduQxVh2dnnGL
         nNqGYN79/uUMnIUy5iq4Y/AzmyhFq2IxqiZFHFnPsXcthaB6Pw53CCkjI81dJMj/zzHM
         ZsDg==
X-Gm-Message-State: AOJu0YzzSixfMmLV/hvr2PLsPJ3VWbhKEbilZuj6plawSCDYEh8ZB1am
	lAkhxa5Q9+FxaY2Pfa8JhkgW7Xr8AZ16uLrG
X-Google-Smtp-Source: AGHT+IFO5G17Z/aSbnFl1izEtytTzjyDHPAC2GSkCyKOxlkJnXKbs6uNSZNVR1ANbd4JIGqvNlRpR+vZ4Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:38c7:85d7:36f7:e198])
 (user=elver job=sendgmr) by 2002:a17:906:54a:b0:a2c:7164:ff8d with SMTP id
 k10-20020a170906054a00b00a2c7164ff8dmr38908eja.3.1705310852357; Mon, 15 Jan
 2024 01:27:32 -0800 (PST)
Date: Mon, 15 Jan 2024 10:27:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240115092727.888096-1-elver@google.com>
Subject: [PATCH RFC 1/2] stackdepot: add stats counters exported via debugfs
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Add a few basic stats counters for stack depot that can be used to derive if
stack depot is working as intended. This is a snapshot of the new stats after
booting a system with a KASAN-enabled kernel:

 $ cat /sys/kernel/debug/stackdepot/stats
 pools: 838
 allocations: 29861
 frees: 6561
 in_use: 23300
 freelist_size: 1840

Generally, "pools" should be well below the max; once the system is booted,
"in_use" should remain relatively steady.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/stackdepot.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index a0be5d05c7f0..80a8ca24ccc8 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -14,6 +14,7 @@
 
 #define pr_fmt(fmt) "stackdepot: " fmt
 
+#include <linux/debugfs.h>
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <linux/kernel.h>
@@ -115,6 +116,23 @@ static bool new_pool_required = true;
 /* Lock that protects the variables above. */
 static DEFINE_RWLOCK(pool_rwlock);
 
+/* Statistics counters for debugfs. */
+enum depot_counter_id {
+	DEPOT_COUNTER_ALLOCS,
+	DEPOT_COUNTER_FREES,
+	DEPOT_COUNTER_INUSE,
+	DEPOT_COUNTER_FREELIST_SIZE,
+	DEPOT_COUNTER_COUNT,
+};
+static long counters[DEPOT_COUNTER_COUNT];
+static const char *const counter_names[] = {
+	[DEPOT_COUNTER_ALLOCS]		= "allocations",
+	[DEPOT_COUNTER_FREES]		= "frees",
+	[DEPOT_COUNTER_INUSE]		= "in_use",
+	[DEPOT_COUNTER_FREELIST_SIZE]	= "freelist_size",
+};
+static_assert(ARRAY_SIZE(counter_names) == DEPOT_COUNTER_COUNT);
+
 static int __init disable_stack_depot(char *str)
 {
 	return kstrtobool(str, &stack_depot_disabled);
@@ -277,6 +295,7 @@ static void depot_init_pool(void *pool)
 		stack->handle.extra = 0;
 
 		list_add(&stack->list, &free_stacks);
+		counters[DEPOT_COUNTER_FREELIST_SIZE]++;
 	}
 
 	/* Save reference to the pool to be used by depot_fetch_stack(). */
@@ -376,6 +395,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	/* Get and unlink the first entry from the freelist. */
 	stack = list_first_entry(&free_stacks, struct stack_record, list);
 	list_del(&stack->list);
+	counters[DEPOT_COUNTER_FREELIST_SIZE]--;
 
 	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
 	if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
@@ -394,6 +414,8 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	 */
 	kmsan_unpoison_memory(stack, DEPOT_STACK_RECORD_SIZE);
 
+	counters[DEPOT_COUNTER_ALLOCS]++;
+	counters[DEPOT_COUNTER_INUSE]++;
 	return stack;
 }
 
@@ -426,6 +448,10 @@ static void depot_free_stack(struct stack_record *stack)
 	lockdep_assert_held_write(&pool_rwlock);
 
 	list_add(&stack->list, &free_stacks);
+
+	counters[DEPOT_COUNTER_FREELIST_SIZE]++;
+	counters[DEPOT_COUNTER_FREES]++;
+	counters[DEPOT_COUNTER_INUSE]--;
 }
 
 /* Calculates the hash for a stack. */
@@ -690,3 +716,30 @@ unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
 	return parts.extra;
 }
 EXPORT_SYMBOL(stack_depot_get_extra_bits);
+
+static int stats_show(struct seq_file *seq, void *v)
+{
+	/*
+	 * data race ok: These are just statistics counters, and approximate
+	 * statistics are ok for debugging.
+	 */
+	seq_printf(seq, "pools: %d\n", data_race(pools_num));
+	for (int i = 0; i < DEPOT_COUNTER_COUNT; i++)
+		seq_printf(seq, "%s: %ld\n", counter_names[i], data_race(counters[i]));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stats);
+
+static int depot_debugfs_init(void)
+{
+	struct dentry *dir;
+
+	if (stack_depot_disabled)
+		return 0;
+
+	dir = debugfs_create_dir("stackdepot", NULL);
+	debugfs_create_file("stats", 0444, dir, NULL, &stats_fops);
+	return 0;
+}
+late_initcall(depot_debugfs_init);
-- 
2.43.0.275.g3460e3d667-goog


