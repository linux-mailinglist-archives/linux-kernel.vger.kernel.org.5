Return-Path: <linux-kernel+bounces-103439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCA87BF57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABA91F22720
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478971726;
	Thu, 14 Mar 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="vgTQzZaO"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBC6FE11
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428113; cv=none; b=pgalm/zq8x5cHI8U8E70m6DI2gBV4jLT7GkiyUoOcuE3bZRJeb9s+R4wCOO7nWt39NOBswAvWVz1thDLLhfaeGnjQgBl0+pVJJRvKCP1DTDM3sKg08Q6TDSKkQ3LE3kd2lAMwcl9orWsAN74B1Ce1sig2EtlsJ6/x3jMc4wlBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428113; c=relaxed/simple;
	bh=No3CcZI0R4w6avOsnxeH0/5MK3Se1i3ukG4F2P0PWMY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LWBAGV4UWiH3UnoHmlVMcvqbOEbbzVtDQ/89t30Prl3po0MdbsNWua1w0VQsccQxN8PZgEkbOr/MM2rRUXUr10m3KsQXdqe9lmz0lYE1Tt38dJwKW8ATcwR9Ucn1EB8xQjhEZIxZUPwfX5Y0Dz/+PW6Ve+wAj6s7CoJg4Mwfm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=vgTQzZaO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-788303f317eso48169885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710428110; x=1711032910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW+2zHFZQjqfYIpLd4QibSf5RSIcFb17pxrKGVZfg7k=;
        b=vgTQzZaO7QxySNh5iuvzWZw7klEAYZButavIHT3qd1Z71MEZaynC7F4ddmAESF+j7f
         1rs4A57TtEFemy7CDRs3NLg5kv/IhNRspbEfVfrmzdfzUzv8vn7uorhAX3rNp/We3+aE
         A8B78+cRJPn9rVov88eWqHmQR2VGYm76OmcR4QHolr5gUflwUJI1v6mTGL1Ey056De0f
         VXAZSEC2yEol/ytOz0KEB0SgGnqqG18TTTOZJW0+Cr3u4LWDvcF0d3PVYfkOlKNSzmj2
         zjPmlViQrvTXld2jgHJWGCjLUJlRorWTbkA4OZMBmNNS57ZYmbPoxn2d3wLmb2ncRvA1
         8S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428110; x=1711032910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wW+2zHFZQjqfYIpLd4QibSf5RSIcFb17pxrKGVZfg7k=;
        b=RiIJj2RS2fmuqjmfX9S3zYWHx4D/7lODspaCbyF1uehAT8xbL7c1huBYK0XJmzUKEr
         VS3QOW5dpBvgv/In4hEEebyAjtignV4SVtmR/S/4qIwmT1UHdox7n6ABSNJcrzcyXE6d
         8epkw8DP+fUB/6/VgMvnG4CUlTS/bppNA72p7T195KZVhcb1fmCJvVNP8r5/id00/AtN
         oGL8AB0xnOXdYyVo4b/6vPXYanhJPJOskk4wTO31VW2ql36rifGjwLrfBzcVRfZXj4a6
         +Pd1hZYmUmUBPQLvuROCMMUNEWJsohAWAm0Cd5zOASLUfzK5KG/6zZh0I3hXHGcXBKNx
         Rkyg==
X-Forwarded-Encrypted: i=1; AJvYcCUWvcXHPQcscMREKXRxpWaxXweFtrbbd2VHnnDgIZ0rVGQfI0ErJyVeCnOLMDye5TK5wm43MZdEOqqvZ3p+iFXTfwNS7Q4YwZKsidyI
X-Gm-Message-State: AOJu0YyE/rlpevyMjhFJvKJoxb803Bi0fOY72dfeeJU6sdllhjo+bB9W
	ZTdvu0Zg9jVvICIDcS+UMnpz27h2912Ptktak7L/BZO7ltLoqUK51LjQeeIl8mE=
X-Google-Smtp-Source: AGHT+IFRyx8KYheppMcuTmknKZnIAQURRHVD3bqUb92bxpaPUbwp7dA3a4520rhwKxXGDEt+IFhD8g==
X-Received: by 2002:a05:620a:2943:b0:789:e044:eb08 with SMTP id n3-20020a05620a294300b00789e044eb08mr739775qkp.24.1710428110047;
        Thu, 14 Mar 2024 07:55:10 -0700 (PDT)
Received: from soleen.c.googlers.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id pi20-20020a05620a379400b00788406f9c7dsm904821qkn.101.2024.03.14.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:55:09 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	peterz@infradead.org,
	nphamcs@gmail.com,
	cerasuolodomenico@gmail.com,
	surenb@google.com,
	lizhijian@fujitsu.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] vmstat: Keep count of the maximum page reached by the kernel stack
Date: Thu, 14 Mar 2024 14:54:57 +0000
Message-ID: <20240314145457.1106299-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_STACK_USAGE provides a mechanism to determine the minimum
amount of memory left in a stack. Every time a new low-memory record is
reached, a message is printed to the console.

However, this doesn't reveal how many pages within each stack were
actually used. Introduce a mechanism that keeps count the number of
times each of the stack's pages were reached:

	$ grep kstack /proc/vmstat
	kstack_page_1 19974
	kstack_page_2 94
	kstack_page_3 0
	kstack_page_4 0

In the above example, out of 20,068 threads that exited on this
machine, only 94 reached the second page of their stack, and none
touched pages three or four.

In fleet environments with millions of machines, this data can help
optimize kernel stack sizes.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
Changelog:
v2:
- Fixed enum name KSTACK_PAGE_5 ->KSTACK_PAGE_REST.
- Improved commit message based on Christophe Leroy
  comment.

 include/linux/sched/task_stack.h | 40 ++++++++++++++++++++++++++++++--
 include/linux/vm_event_item.h    | 29 +++++++++++++++++++++++
 include/linux/vmstat.h           | 16 -------------
 mm/vmstat.c                      | 11 +++++++++
 4 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index ccd72b978e1f..09e6874c2ced 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -95,9 +95,42 @@ static inline int object_is_on_stack(const void *obj)
 extern void thread_stack_cache_init(void);
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
+#ifdef CONFIG_VM_EVENT_COUNTERS
+#include <linux/vm_event_item.h>
+
+/* Count the maximum pages reached in kernel stacks */
+static inline void count_kstack_page(int stack_max_page)
+{
+	switch (stack_max_page) {
+	case 1:
+		this_cpu_inc(vm_event_states.event[KSTACK_PAGE_1]);
+		break;
+	case 2:
+		this_cpu_inc(vm_event_states.event[KSTACK_PAGE_2]);
+		break;
+#if THREAD_SIZE >= (4 * PAGE_SIZE)
+	case 3:
+		this_cpu_inc(vm_event_states.event[KSTACK_PAGE_3]);
+		break;
+	case 4:
+		this_cpu_inc(vm_event_states.event[KSTACK_PAGE_4]);
+		break;
+#endif
+#if THREAD_SIZE > (4 * PAGE_SIZE)
+	default:
+		this_cpu_inc(vm_event_states.event[KSTACK_PAGE_REST]);
+		break;
+#endif
+	}
+}
+#else /* !CONFIG_VM_EVENT_COUNTERS */
+static inline void count_kstack_page(int stack_max_page) {}
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+
 static inline unsigned long stack_not_used(struct task_struct *p)
 {
 	unsigned long *n = end_of_stack(p);
+	unsigned long unused_stack;
 
 	do { 	/* Skip over canary */
 # ifdef CONFIG_STACK_GROWSUP
@@ -108,10 +141,13 @@ static inline unsigned long stack_not_used(struct task_struct *p)
 	} while (!*n);
 
 # ifdef CONFIG_STACK_GROWSUP
-	return (unsigned long)end_of_stack(p) - (unsigned long)n;
+	unused_stack = (unsigned long)end_of_stack(p) - (unsigned long)n;
 # else
-	return (unsigned long)n - (unsigned long)end_of_stack(p);
+	unused_stack = (unsigned long)n - (unsigned long)end_of_stack(p);
 # endif
+	count_kstack_page(((THREAD_SIZE - unused_stack) >> PAGE_SHIFT) + 1);
+
+	return unused_stack;
 }
 #endif
 extern void set_task_stack_end_magic(struct task_struct *tsk);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..1dbfe47ff048 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -153,10 +153,39 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		VMA_LOCK_ABORT,
 		VMA_LOCK_RETRY,
 		VMA_LOCK_MISS,
+#endif
+#ifdef CONFIG_DEBUG_STACK_USAGE
+		KSTACK_PAGE_1,
+		KSTACK_PAGE_2,
+#if THREAD_SIZE >= (4 * PAGE_SIZE)
+		KSTACK_PAGE_3,
+		KSTACK_PAGE_4,
+#endif
+#if THREAD_SIZE > (4 * PAGE_SIZE)
+		KSTACK_PAGE_REST,
+#endif
 #endif
 		NR_VM_EVENT_ITEMS
 };
 
+#ifdef CONFIG_VM_EVENT_COUNTERS
+/*
+ * Light weight per cpu counter implementation.
+ *
+ * Counters should only be incremented and no critical kernel component
+ * should rely on the counter values.
+ *
+ * Counters are handled completely inline. On many platforms the code
+ * generated will simply be the increment of a global address.
+ */
+
+struct vm_event_state {
+	unsigned long event[NR_VM_EVENT_ITEMS];
+};
+
+DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
+#endif
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
 #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 343906a98d6e..18d4a97d3afd 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -41,22 +41,6 @@ enum writeback_stat_item {
 };
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
-/*
- * Light weight per cpu counter implementation.
- *
- * Counters should only be incremented and no critical kernel component
- * should rely on the counter values.
- *
- * Counters are handled completely inline. On many platforms the code
- * generated will simply be the increment of a global address.
- */
-
-struct vm_event_state {
-	unsigned long event[NR_VM_EVENT_ITEMS];
-};
-
-DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
-
 /*
  * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
  * local_irq_disable overhead.
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..737c85689251 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1413,6 +1413,17 @@ const char * const vmstat_text[] = {
 	"vma_lock_retry",
 	"vma_lock_miss",
 #endif
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	"kstack_page_1",
+	"kstack_page_2",
+#if THREAD_SIZE >= (4 * PAGE_SIZE)
+	"kstack_page_3",
+	"kstack_page_4",
+#endif
+#if THREAD_SIZE > (4 * PAGE_SIZE)
+	"kstack_page_rest",
+#endif
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.44.0.278.ge034bb2e1d-goog


