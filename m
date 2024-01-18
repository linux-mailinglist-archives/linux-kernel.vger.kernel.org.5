Return-Path: <linux-kernel+bounces-30023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7248317FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A341C213A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030CF241ED;
	Thu, 18 Jan 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjXOaR56"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5622F0B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575745; cv=none; b=bCNPrfT6ve7l27917/2IfAqN/eB+tIu4gyM9EJUsek81IBxfe2svdRlZjRt2kDDEalLZotdHmL0cUxAWY1egITSwC6Zg107MYu+YO9zW2Usggg0qvPDNTnLPrAdcj1r6LRtnOSOLK4lHTDoyW1OM2gVAeduiYirN82og89T9cXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575745; c=relaxed/simple;
	bh=JbGdZ0r8SfIsSthHz6PNRZ4WcHYtizrP40XUEolRL5s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=DsoE3dlQNBouGT84uL9nvImy4qeMy7lxII4HjCG7I7OB1WvsuR9gw/GmStf4TREF4opNzx+xdGq+GrzIitxV0PgA0/NUlVvdZGtU0ecHHOiMTqXHLLKhcC/Ajg4vpCZ05tLeH4QF8aS+YmSMOH31Ef4ujJAnbpgjbHwh4W+kb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjXOaR56; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-558b04cb660so3653882a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705575742; x=1706180542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nt/piPitvuHRj/PfEKvId5IXLv15chj5uEnJGFs8RjM=;
        b=IjXOaR56u/Mwm31DOFhFT3YVPyvcnUynjU3mjhV9SQWxm2FBzkg5qHz7XuRPnCv90v
         mDO7i1tQHiqHx0H+fuMrikkdebxYAWc2DGKUZEBNLHDwzLVmbFo+ahCjED9kCXLZnJgx
         hcx9NNtcEBhMEwA9uF2dbOMTjQGZ+SCZlq/+W+7RgxHequk0Z4Yp/4jlyCFhUwA+UkBU
         arnuRkYMYeNtvB5h8TIzlodczNrhS25PbAR34q55devwdgpLQE9iQuRlMXbzo3FSrCiI
         ijG4Z8A/hqvFuC2IqrdYYlEm6I5YBcr4miP9TGyt5JOGKhMZMNZ+gHmVmVNljmT4UOwE
         d7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705575742; x=1706180542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt/piPitvuHRj/PfEKvId5IXLv15chj5uEnJGFs8RjM=;
        b=HynI8rZOT33ZeUG4QmkxwMQHJTdyKteXATmxcNJ839kF09LsV/psl1gVNv230SGtQR
         CdGYEG2Sng19P+aLtiXRJHsYC+2L6SLET/iRGalnuv0j8j9mz+GpwvVxTDUHATizOmFu
         KEwQg3qybLdu3Xdq6F4rZoWU85U8IPtCHrJdWdx3NeehDYcjpeJETL/h4QMu2XvjB2QU
         nYwHKJHR/8y5w/X0I5st+YQn9oahb7tBQCHRfPNU6e+6sF2vikw2pX/1CnlArZC8wDML
         bQTObKfz90ACGITMHQRHUCchnhB3VVaqHc3kaI7cxIv42zwfGCa2Y9hdWEN/L+sl/y/V
         1Exw==
X-Gm-Message-State: AOJu0YxG4MRHQjFFfBupNXiOl7WDmvXN7AWeMFJlBh7qxBZGKfpzMZh3
	tJHN42x2Eafi9ccSraeqjX0Mk8CldiS8VKXtFkik+WH856zobYDEYF+qeZCBjZczAJodx1RaXg=
	=
X-Google-Smtp-Source: AGHT+IFIPHUVEGpmNTcM9skVlrx/JI8ArShyuL+aXC255FwnIPaPGTUml+eefEgi92CmARI5g8w1oU12HA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:9d7e:25fb:9605:2bef])
 (user=elver job=sendgmr) by 2002:a05:6402:3712:b0:559:f7b9:319c with SMTP id
 ek18-20020a056402371200b00559f7b9319cmr5073edb.5.1705575741753; Thu, 18 Jan
 2024 03:02:21 -0800 (PST)
Date: Thu, 18 Jan 2024 12:01:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118110216.2539519-1-elver@google.com>
Subject: [PATCH 1/2] stackdepot: add stats counters exported via debugfs
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
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
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
2.43.0.381.gb435a96ce8-goog


