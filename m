Return-Path: <linux-kernel+bounces-101077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6D587A1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B021C21B46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F810A11;
	Wed, 13 Mar 2024 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Bn7P49KN"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8D10953
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300872; cv=none; b=nDVpIocYP6dcKvDc4EuREU3uDXO9SOoX7iaM+XnrFl6G3TNoqj3TCeZ6uxtFuVPaAXbchExm9XpwJQkIfweGfy4OTnhz6SyYtwybbEr1lD2zaSGmH46avyVuNWK+wBiFOmGPEhiaTlijoVtqBnXoQ5NQt5oLL3irzWe4jawLKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300872; c=relaxed/simple;
	bh=0AnQsIoGRXEiWmpNu1y3bPVdadUrUGdZZ7FkjytxHLo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S9asfuUEw+EjbRpLhE8grsnt+KLnjuN+b1pD5+LITvM/4Hnunb3NUKDT3uheEM/NZpEP5F/Hixp45i6Mqzn78VuIdMY97ScUhG8Czz0lpDpebCRdoHXY7SqtNPHTAMx7GV4JWQKBcgpOa776nknfJAFtJOsnclapXjhTfDQEEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Bn7P49KN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7882d75e766so24442585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710300870; x=1710905670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sli3mfWx0lYFMlw598vEsdEvssG10grtOqJ1aTNbNWY=;
        b=Bn7P49KNinuHKkiNplCz0fE3ZMxMw1g+fSzND62rw2GNdJE5+dF1p5t3XOYek7AtZ3
         U8ZAQzvnBpRYuHrIXcZ0rrn++Fs7YcrfiWpHIAEbIjUxYPaAV+PR2L0z1+/nfwhF/2z+
         JoW3m4Ceubk/qfi8gaH+yLC/0aqcdyxi1jT7PXPF/Wpo80riFvvXUJZvE2BDenrKUpZV
         JYjPuJxw55rlVdaq3t5a3BJuBay/VBkfe9/+rSCuy7EcqvldC07Kl5nfb2x83m/NvObY
         eHGSqOBPjU0qHDvHpExa/Dg5wtQZEKMZEbPK8smZNu+bkTjyugXqbuuiV5nLRKXNAioW
         z1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710300870; x=1710905670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sli3mfWx0lYFMlw598vEsdEvssG10grtOqJ1aTNbNWY=;
        b=Bgjc3KyY7FWsdsFyw5CCnMWRTGldqfx5zpD+jtHAEMCmQUq8Zdd9F3TGXl7aj38BG4
         q2fPU1y8zk1gNKp52bMBwyzZOo7/T+kUgPT97WkWIqb/3ucvxpynSlo01AnSvza+2De2
         FbItGSfpAyazCgCw4n+ZKjZblnKPtzu8YvYFAGDZNQb8YnWON5MibYcXxVolc6xw2l2F
         xdp9AYrSjdoG2IwSFyWAVNtto8uPoo5bb+7TrUTYhv+bJbFAvDlHXSa+5ktgBR5ySAh0
         vlB+X0OkKxDjFDcMUM1Pqn1Fl7UhqK+gk5nRfJmO5EMg7pql6Fh722fyfNk32lg7kjPw
         wtfA==
X-Forwarded-Encrypted: i=1; AJvYcCVerFlcn170546we/MuErsHQyhToWjmhe+S8qhrkhbkTo35JDvRm37E0q5txWrveOXgT9OHPyis/AnDi8j3iGoZ/8LP/sRYPNxlm30p
X-Gm-Message-State: AOJu0Yzrn5JmswKkLu9xx7OpCFn1smr6KUgM9Y4AaGYtrlp5WKf5wMIF
	QdMROw1/KlJH6nk/o+VPmOR2DUfCMXM7J5nz6MYHqrP30sJMiVSHRCPR7fP2i5s=
X-Google-Smtp-Source: AGHT+IGSuWTJqFlidzOR25k5TK28N3coug262snCXpyJ/gX21nMvv8zZXtrjObRgQD1ep9GW89F9FQ==
X-Received: by 2002:a05:620a:8dc:b0:789:c83d:c5f5 with SMTP id z28-20020a05620a08dc00b00789c83dc5f5mr973105qkz.20.1710300869839;
        Tue, 12 Mar 2024 20:34:29 -0700 (PDT)
Received: from soleen.c.googlers.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id bs44-20020a05620a472c00b00787fed5c768sm4295509qkb.72.2024.03.12.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:34:29 -0700 (PDT)
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
Subject: [PATCH] vmstat: Keep count of the maximum page reached by the kernel stack
Date: Wed, 13 Mar 2024 03:34:17 +0000
Message-ID: <20240313033417.447216-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_STACK_USAGE provides a mechanism to know the minimum amount
of memory that was left in stack. Every time the new anti-record is
reached a message is printed to the console.

However, this is not useful to know how much each page within stack was
actually used. Provide a mechanism to count the number of time each
stack page was reached throughout the live of the stack:

	$ grep kstack /proc/vmstat
	kstack_page_1 19974
	kstack_page_2 94
	kstack_page_3 0
	kstack_page_4 0

In the above example only out of ~20K threads that ever exited on that
machine only 94 touched second page of the stack, and none touched
pages three and four.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/sched/task_stack.h | 39 ++++++++++++++++++++++++++++++--
 include/linux/vm_event_item.h    | 29 ++++++++++++++++++++++++
 include/linux/vmstat.h           | 16 -------------
 mm/vmstat.c                      | 11 +++++++++
 4 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index ccd72b978e1f..7ff7f9997266 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -95,9 +95,41 @@ static inline int object_is_on_stack(const void *obj)
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
+		this_cpu_inc(vm_event_states.event[KSTACK_PAGE_5]);
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
@@ -108,10 +140,13 @@ static inline unsigned long stack_not_used(struct task_struct *p)
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


