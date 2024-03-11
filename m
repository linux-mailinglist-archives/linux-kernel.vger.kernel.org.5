Return-Path: <linux-kernel+bounces-99267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F78785B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B67280E60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C5956B9D;
	Mon, 11 Mar 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="uM/C8rdQ"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91155E7B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175616; cv=none; b=RCLL5grTeQitKF94x0Z94rBmqgLkIdJh8aUjMhCuE5iWyDfxGDKoRYEOkPnqHVP0VnygsIB9pYzgblVD/4Ksx9pe2Xtw22DAp4wjeg4oxElYll5e5AeqvYSzpnBP8xwKrp9jB5QlbU1TAY25qkXaldcHURrM6rD1roBA2vDJpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175616; c=relaxed/simple;
	bh=UoabulEd/vJ9rmGjs45W0TPYHtt56amogSUkndFOzq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLY8ObMmbE1if1+QlH2DSKkwTGlcmV2bhei6qk7Zm28uKWZeb4R1m9niJfK9VtWu3m2HmX+fSdbdAadcipcQKwBZvVyRqDGYGcJWncq90tgaGT9fczlkCoQtDS+opZNbBm2au9Py7l2xAm+c74k+0HyrSELwQFtZkvM+tzOgkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=uM/C8rdQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7884a9a404fso246385685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175613; x=1710780413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2I5VvwnC3LRR3szeP871B8eKL/IZGdjRShD9rinhwbY=;
        b=uM/C8rdQg22GL8jKVPmnOcUNRpKwGmzX1j3q0v9A3NcQj4s+IIhBskPIlScL2dBSGg
         SPn6pdmhSJWQ8ApHnyoxuGwmuay2R5DHbSbQy5Roox7a5UyVCMtcXZ/v32VyXzuWRKdp
         /9aQG5/G+4BP0gWmpsN2MA3W1Vuoja/s7V50gs30hqlmO/dKtaiEaN0E5+/B/O05AhJA
         igUlJIm1j1IcpIrv57dCAnkeXTX2ZDDp+1iGAZiXYjrRbKINyKSvIelCN0856v/gnpnS
         h4HEXEB5Q8e2+D/Sa+YSP6/GGe7eJgijRabMLf9jTPdHabuoBuoqj9dtTq2bORdbu0SV
         exXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175613; x=1710780413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I5VvwnC3LRR3szeP871B8eKL/IZGdjRShD9rinhwbY=;
        b=iE3GMVKeQsW9vT+IpqBYRhtL1awHmgTFR9gNd1RiIAL9ACenYrJ4eDcyn2mRaIsYmB
         QQb6Etou5GJVIzRSUkqUu7NTIyN+zxvHkl0Y1hboiX+RY53JXdu/+zwXeg5QaIx9i38d
         qUwTYvxt70DJz2YgvOLYI+I7m0x5qgilE2y1rUyYYTcop4v3hCAwwNHUXiQA9vNS3HZ+
         IQja2l2Xt0L1bmAlZqPhKOlwcjJLxRGPVZxsf6vNWv44tCL6DmVUc+WuefbNDJQPVOOu
         s2VuQNqhAfByuOHQonPBEHKNDOL85/XEuEuI1mWtzOZl0Ne4F1WbKYmOzKqa6aW88nu4
         Wyiw==
X-Gm-Message-State: AOJu0Yy9OlOe5joEFEmfW0ppKmStWQsHRHeK3I8rhjhsZJws0YcqWdaf
	MxNAfCVBq1tytMX2AcLrxzVFPN88ozUCwzUUHZTfu2CrSlwzZqaYG/L/E1oVAllooWL1g1tLJud
	R5co=
X-Google-Smtp-Source: AGHT+IH9a5LZ+7yIW2SDInIoVHV8enodZiTDdoz2gyXsxlHKxaxJ5G55cFQu5tNI4LZq2rv5sPx5sw==
X-Received: by 2002:a05:620a:1a08:b0:788:4101:3d2 with SMTP id bk8-20020a05620a1a0800b00788410103d2mr10720214qkb.1.1710175613353;
        Mon, 11 Mar 2024 09:46:53 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:52 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	x86@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	dianders@chromium.org,
	dietmar.eggemann@arm.com,
	eric.devolder@oracle.com,
	hca@linux.ibm.com,
	hch@infradead.org,
	hpa@zytor.com,
	jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca,
	jpoimboe@kernel.org,
	jroedel@suse.de,
	juri.lelli@redhat.com,
	kent.overstreet@linux.dev,
	kinseyho@google.com,
	kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com,
	luto@kernel.org,
	mgorman@suse.de,
	mic@digikod.net,
	michael.christie@oracle.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	mst@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rick.p.edgecombe@intel.com,
	rostedt@goodmis.org,
	surenb@google.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	pasha.tatashin@soleen.com
Subject: [RFC 10/14] fork: Dynamic Kernel Stacks
Date: Mon, 11 Mar 2024 16:46:34 +0000
Message-ID: <20240311164638.2015063-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core implementation of dynamic kernel stacks.

Unlike traditional kernel stacks, these stack are auto-grow as they are
used. This allows to save a significant amount of memory in the fleet
environments. Also, potentially the default size of kernel thread can be
increased in order to prevent stack overflows without compromising on
the overall memory overhead.

The dynamic kernel stacks interface provides two global functions:

1. dynamic_stack_fault().
Architectures that support dynamic kernel stacks, must call this function
in order to handle the fault in the stack.

It allocates and maps new pages into the stack. The pages are
maintained in a per-cpu data structure.

2. dynamic_stack()
Must be called as a thread leaving CPU to check if the thread has
allocated dynamic stack pages (tsk->flags & PF_DYNAMIC_STACK) is set.
If this is the case, there are two things need to be performed:
  a. Charge the thread for the allocated stack pages.
  b. refill the per-cpu array so the next thread can also fault.

Dynamic kernel threads do not support "STACK_END_MAGIC", as the last
page is does not have to be faulted in. However, since they are based of
vmap stacks, the guard pages always protect the dynamic kernel stacks
from overflow.

The average depth of a kernel thread depends on the workload, profiling,
virtualization, compiler optimizations, and driver implementations.

Therefore, the numbers should be tested for a specific workload. From
my tests I found the following values on a freshly booted idling
machines:

CPU           #Cores #Stacks  Regular(kb) Dynamic(kb)
AMD Genoa        384    5786    92576       23388
Intel Skylake    112    3182    50912       12860
AMD Rome         128    3401    54416       14784
AMD Rome         256    4908    78528       20876
Intel Haswell     72    2644    42304       10624

On all machines dynamic kernel stacks take about 25% of the original
stack memory. Only 5% of active tasks performed a stack page fault in
their life cycles.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/Kconfig                     |  34 +++++
 include/linux/sched.h            |   2 +-
 include/linux/sched/task_stack.h |  41 +++++-
 kernel/fork.c                    | 239 +++++++++++++++++++++++++++++++
 kernel/sched/core.c              |   1 +
 5 files changed, 315 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..da3df347b069 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1241,6 +1241,40 @@ config VMAP_STACK
 	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
 	  must be enabled.
 
+config HAVE_ARCH_DYNAMIC_STACK
+	def_bool n
+	help
+	  An arch should select this symbol if it can support kernel stacks
+	  dynamic growth.
+
+	  - Arch must have support for HAVE_ARCH_VMAP_STACK, in order to handle
+	    stack related page faults
+
+	  - Arch must be able to faults from interrupt context.
+	  - Arch must allows the kernel to handle stack faults gracefully, even
+	    during interrupt handling.
+
+	  - Exceptions such as no pages available should be handled the same
+	    in the consitent and predictable way. I.e. the exception should be
+	    handled the same as when stack overflow occurs when guard pages are
+	    touched with extra information about the allocation error.
+
+config DYNAMIC_STACK
+	default y
+	bool "Dynamically grow kernel stacks"
+	depends on THREAD_INFO_IN_TASK
+	depends on HAVE_ARCH_DYNAMIC_STACK
+	depends on VMAP_STACK
+	depends on !KASAN
+	depends on !DEBUG_STACK_USAGE
+	depends on !STACK_GROWSUP
+	help
+	  Dynamic kernel stacks allow to save memory on machines with a lot of
+	  threads by starting with small stacks, and grow them only when needed.
+	  On workloads where most of the stack depth do not reach over one page
+	  the memory saving can be subsentantial. The feature requires virtually
+	  mapped kernel stacks in order to handle page faults.
+
 config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	def_bool n
 	help
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..d3ce3cd065ce 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1628,7 +1628,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_DYNAMIC_STACK	0x00010000	/* This thread allocated dynamic stack pages */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 860faea06883..4934bfd65ad1 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -82,9 +82,49 @@ static inline void put_task_stack(struct task_struct *tsk) {}
 
 void exit_task_stack_account(struct task_struct *tsk);
 
+#ifdef CONFIG_DYNAMIC_STACK
+
+#define task_stack_end_corrupted(task)	0
+
+#ifndef THREAD_PREALLOC_PAGES
+#define THREAD_PREALLOC_PAGES		1
+#endif
+
+#define THREAD_DYNAMIC_PAGES						\
+	((THREAD_SIZE >> PAGE_SHIFT) - THREAD_PREALLOC_PAGES)
+
+void dynamic_stack_refill_pages(void);
+bool dynamic_stack_fault(struct task_struct *tsk, unsigned long address);
+
+/*
+ * Refill and charge for the used pages.
+ */
+static inline void dynamic_stack(struct task_struct *tsk)
+{
+	if (unlikely(tsk->flags & PF_DYNAMIC_STACK)) {
+		dynamic_stack_refill_pages();
+		tsk->flags &= ~PF_DYNAMIC_STACK;
+	}
+}
+
+static inline void set_task_stack_end_magic(struct task_struct *tsk) {}
+
+#else /* !CONFIG_DYNAMIC_STACK */
+
 #define task_stack_end_corrupted(task) \
 		(*(end_of_stack(task)) != STACK_END_MAGIC)
 
+void set_task_stack_end_magic(struct task_struct *tsk);
+static inline void dynamic_stack(struct task_struct *tsk) {}
+
+static inline bool dynamic_stack_fault(struct task_struct *tsk,
+				       unsigned long address)
+{
+	return false;
+}
+
+#endif /* CONFIG_DYNAMIC_STACK */
+
 static inline int object_is_on_stack(const void *obj)
 {
 	void *stack = task_stack_page(current);
@@ -114,7 +154,6 @@ static inline unsigned long stack_not_used(struct task_struct *p)
 # endif
 }
 #endif
-extern void set_task_stack_end_magic(struct task_struct *tsk);
 
 static inline int kstack_end(void *addr)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index bbae5f705773..63e1fd661e17 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -204,6 +204,232 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
 	return false;
 }
 
+#ifdef CONFIG_DYNAMIC_STACK
+
+static DEFINE_PER_CPU(struct page *, dynamic_stack_pages[THREAD_DYNAMIC_PAGES]);
+
+static struct vm_struct *alloc_vmap_stack(int node)
+{
+	gfp_t gfp = THREADINFO_GFP & ~__GFP_ACCOUNT;
+	unsigned long addr, end;
+	struct vm_struct *vm_area;
+	int err, i;
+
+	vm_area = get_vm_area_node(THREAD_SIZE, THREAD_ALIGN, VM_MAP, node,
+				   gfp, __builtin_return_address(0));
+	if (!vm_area)
+		return NULL;
+
+	vm_area->pages = kmalloc_node(sizeof(void *) *
+				      (THREAD_SIZE >> PAGE_SHIFT), gfp, node);
+	if (!vm_area->pages)
+		goto cleanup_err;
+
+	for (i = 0; i < THREAD_PREALLOC_PAGES; i++) {
+		vm_area->pages[i] = alloc_pages(gfp, 0);
+		if (!vm_area->pages[i])
+			goto cleanup_err;
+		vm_area->nr_pages++;
+	}
+
+	addr = (unsigned long)vm_area->addr +
+					(THREAD_DYNAMIC_PAGES << PAGE_SHIFT);
+	end = (unsigned long)vm_area->addr + THREAD_SIZE;
+	err = vmap_pages_range_noflush(addr, end, PAGE_KERNEL, vm_area->pages,
+				       PAGE_SHIFT);
+	if (err)
+		goto cleanup_err;
+
+	return vm_area;
+cleanup_err:
+	for (i = 0; i < vm_area->nr_pages; i++)
+		__free_page(vm_area->pages[i]);
+	kfree(vm_area->pages);
+	kfree(vm_area);
+
+	return NULL;
+}
+
+static void free_vmap_stack(struct vm_struct *vm_area)
+{
+	int i, nr_pages;
+
+	remove_vm_area(vm_area->addr);
+
+	nr_pages = vm_area->nr_pages;
+	for (i = 0; i < nr_pages; i++)
+		__free_page(vm_area->pages[i]);
+
+	kfree(vm_area->pages);
+	kfree(vm_area);
+}
+
+/*
+ * This flag is used to pass information from fault handler to refill about
+ * which pages were allocated, and should be charged to memcg.
+ */
+#define DYNAMIC_STACK_PAGE_AQUIRED_FLAG	0x1
+
+static struct page *dynamic_stack_get_page(void)
+{
+	struct page **pages = this_cpu_ptr(dynamic_stack_pages);
+	int i;
+
+	for (i = 0; i < THREAD_DYNAMIC_PAGES; i++) {
+		struct page *page = pages[i];
+
+		if (page && !((uintptr_t)page & DYNAMIC_STACK_PAGE_AQUIRED_FLAG)) {
+			pages[i] = (void *)((uintptr_t)pages[i] | DYNAMIC_STACK_PAGE_AQUIRED_FLAG);
+			return page;
+		}
+	}
+
+	return NULL;
+}
+
+static int dynamic_stack_refill_pages_cpu(unsigned int cpu)
+{
+	struct page **pages = per_cpu_ptr(dynamic_stack_pages, cpu);
+	int i;
+
+	for (i = 0; i < THREAD_DYNAMIC_PAGES; i++) {
+		if (pages[i])
+			break;
+		pages[i] = alloc_pages(THREADINFO_GFP & ~__GFP_ACCOUNT, 0);
+		if (unlikely(!pages[i])) {
+			pr_err("failed to allocate dynamic stack page for cpu[%d]\n",
+			       cpu);
+		}
+	}
+
+	return 0;
+}
+
+static int dynamic_stack_free_pages_cpu(unsigned int cpu)
+{
+	struct page **pages = per_cpu_ptr(dynamic_stack_pages, cpu);
+	int i;
+
+	for (i = 0; i < THREAD_DYNAMIC_PAGES; i++) {
+		if (!pages[i])
+			continue;
+		__free_page(pages[i]);
+		pages[i] = NULL;
+	}
+
+	return 0;
+}
+
+void dynamic_stack_refill_pages(void)
+{
+	struct page **pages = this_cpu_ptr(dynamic_stack_pages);
+	int i, ret;
+
+	for (i = 0; i < THREAD_DYNAMIC_PAGES; i++) {
+		struct page *page = pages[i];
+
+		if (!((uintptr_t)page & DYNAMIC_STACK_PAGE_AQUIRED_FLAG))
+			break;
+
+		page = (void *)((uintptr_t)page & ~DYNAMIC_STACK_PAGE_AQUIRED_FLAG);
+		ret = memcg_kmem_charge_page(page, GFP_KERNEL, 0);
+		/*
+		 * XXX Since stack pages were already allocated, we should never
+		 * fail charging. Therefore, we should probably induce force
+		 * charge and oom killing if charge fails.
+		 */
+		if (unlikely(ret))
+			pr_warn_ratelimited("dynamic stack: charge for allocated page failed\n");
+
+		mod_lruvec_page_state(page, NR_KERNEL_STACK_KB,
+				      PAGE_SIZE / 1024);
+
+		page = alloc_pages(THREADINFO_GFP & ~__GFP_ACCOUNT, 0);
+		if (unlikely(!page))
+			pr_err_ratelimited("failed to refill per-cpu dynamic stack\n");
+		pages[i] = page;
+	}
+}
+
+bool noinstr dynamic_stack_fault(struct task_struct *tsk, unsigned long address)
+{
+	unsigned long stack, hole_end, addr;
+	struct vm_struct *vm_area;
+	struct page *page;
+	int nr_pages;
+	pte_t *pte;
+
+	/* check if address is inside the kernel stack area */
+	stack = (unsigned long)tsk->stack;
+	if (address < stack || address >= stack + THREAD_SIZE)
+		return false;
+
+	vm_area = tsk->stack_vm_area;
+	if (!vm_area)
+		return false;
+
+	/*
+	 * check if this stack can still grow, otherwise fault will be reported
+	 * as guard page access.
+	 */
+	nr_pages = vm_area->nr_pages;
+	if (nr_pages >= (THREAD_SIZE >> PAGE_SHIFT))
+		return false;
+
+	/* Check if fault address is within the stack hole */
+	hole_end = stack + THREAD_SIZE - (nr_pages << PAGE_SHIFT);
+	if (address >= hole_end)
+		return false;
+
+	/*
+	 * Most likely we faulted in the page right next to the last mapped
+	 * page in the stack, however, it is possible (but very unlikely) that
+	 * the faulted page is actually skips some pages in the stack. Make sure
+	 * we do not create  more than one holes in the stack, and map every
+	 * page between the current fault  address and the last page that is
+	 * mapped in the stack.
+	 */
+	address = PAGE_ALIGN_DOWN(address);
+	for (addr = hole_end - PAGE_SIZE; addr >= address; addr -= PAGE_SIZE) {
+		/* Take the next page from the per-cpu list */
+		page = dynamic_stack_get_page();
+		if (!page) {
+			instrumentation_begin();
+			pr_emerg("Failed to allocate a page during kernel_stack_fault\n");
+			instrumentation_end();
+			return false;
+		}
+
+		/* Store the new page in the stack's vm_area */
+		vm_area->pages[nr_pages] = page;
+		vm_area->nr_pages = nr_pages + 1;
+
+		/* Add the new page entry to the page table */
+		pte = virt_to_kpte(addr);
+		if (!pte) {
+			instrumentation_begin();
+			pr_emerg("The PTE page table for a kernel stack is not found\n");
+			instrumentation_end();
+			return false;
+		}
+
+		/* Make sure there are no existing mappings at this address */
+		if (pte_present(*pte)) {
+			instrumentation_begin();
+			pr_emerg("The PTE contains a mapping\n");
+			instrumentation_end();
+			return false;
+		}
+		set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
+	}
+
+	/* Refill the pcp stack pages during context switch */
+	tsk->flags |= PF_DYNAMIC_STACK;
+
+	return true;
+}
+
+#else /* !CONFIG_DYNAMIC_STACK */
 static inline struct vm_struct *alloc_vmap_stack(int node)
 {
 	void *stack;
@@ -226,6 +452,7 @@ static inline void free_vmap_stack(struct vm_struct *vm_area)
 {
 	vfree(vm_area->addr);
 }
+#endif /* CONFIG_DYNAMIC_STACK */
 
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
@@ -1083,6 +1310,16 @@ void __init fork_init(void)
 			  NULL, free_vm_stack_cache);
 #endif
 
+#ifdef CONFIG_DYNAMIC_STACK
+	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:dynamic_stack",
+			  dynamic_stack_refill_pages_cpu,
+			  dynamic_stack_free_pages_cpu);
+	/*
+	 * Fill the dynamic stack pages for the boot CPU, others will be filled
+	 * as CPUs are onlined.
+	 */
+	dynamic_stack_refill_pages_cpu(smp_processor_id());
+#endif
 	scs_init();
 
 	lockdep_init_task(&init_task);
@@ -1096,6 +1333,7 @@ int __weak arch_dup_task_struct(struct task_struct *dst,
 	return 0;
 }
 
+#ifndef CONFIG_DYNAMIC_STACK
 void set_task_stack_end_magic(struct task_struct *tsk)
 {
 	unsigned long *stackend;
@@ -1103,6 +1341,7 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 	stackend = end_of_stack(tsk);
 	*stackend = STACK_END_MAGIC;	/* for overflow detection */
 }
+#endif
 
 static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..20f9523c3159 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6617,6 +6617,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
+	dynamic_stack(prev);
 	schedule_debug(prev, !!sched_mode);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
-- 
2.44.0.278.ge034bb2e1d-goog


