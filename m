Return-Path: <linux-kernel+bounces-125912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C8892E1E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485A71F219C0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F9B38B;
	Sun, 31 Mar 2024 00:11:57 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33E376
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711843916; cv=none; b=EeK1lKhiqPe+Qob4jq5h9P1ordbzDtnFFGdl9eHTc12XyQROg9MsIVaYZ9vxQn7xJ6H7PCvCgpYMaAi/BDkZ5DACiC973JkiYAjO8hvtt7fDGsDAqBBBJExtc9cWwnybKMJnAPu1YKRMF/QyMU3cSgxcpxBumX5MY9R6l6hkw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711843916; c=relaxed/simple;
	bh=+lboaqEnt+i1iWHU9cseZxk/XEiDibYCVmlCUuzzoDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8/oJIQog9yryP9p1L2UqVKeGZbI810JqMJisQEU8lHWC57fgtVO+emFXpOKQ4uYdufirj3pIX9se4kxh8kxWDhLfRnXUFqvRG4mkI/Cm8wtCYCGNa8NxBRR/DNbgQFB8V1mnaFulCMi5aNDH/wM/rxD03MuqhGXhY1o75j9kmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.152])
	by sina.com (172.16.235.25) with ESMTP
	id 6608A9B100003ABC; Sun, 31 Mar 2024 08:09:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 37315434210117
X-SMAIL-UIID: D314BDEBA6694A70B0051E606AB997E6-20240331-080924-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in kauditd_thread (4)
Date: Sun, 31 Mar 2024 08:09:12 +0800
Message-Id: <20240331000912.3242-1-hdanton@sina.com>
In-Reply-To: <000000000000d929dd0614a8ba8c@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Mar 2024 11:39:42 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112840ee180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/mm/page_owner.c
+++ y/mm/page_owner.c
@@ -196,7 +196,8 @@ static void add_stack_record_to_list(str
 	spin_unlock_irqrestore(&stack_list_lock, flags);
 }
 
-static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
+static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask,
+				   int nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
 
@@ -217,20 +218,74 @@ static void inc_stack_record_count(depot
 			/* Add the new stack_record to our list */
 			add_stack_record_to_list(stack_record, gfp_mask);
 	}
-	refcount_inc(&stack_record->count);
+	refcount_add(nr_base_pages, &stack_record->count);
 }
 
-static void dec_stack_record_count(depot_stack_handle_t handle)
+static void dec_stack_record_count(depot_stack_handle_t handle,
+				   int nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
 
-	if (stack_record)
-		refcount_dec(&stack_record->count);
+	if (!stack_record)
+		return;
+
+	if (refcount_sub_and_test(nr_base_pages, &stack_record->count))
+		pr_warn("%s: refcount went to 0 for %u handle\n", __func__,
+			handle);
 }
 
-void __reset_page_owner(struct page *page, unsigned short order)
+static inline void __update_page_owner_handle(struct page_ext *page_ext,
+					      depot_stack_handle_t handle,
+					      unsigned short order,
+					      gfp_t gfp_mask,
+					      short last_migrate_reason, u64 ts_nsec,
+					      pid_t pid, pid_t tgid, char *comm)
 {
 	int i;
+	struct page_owner *page_owner;
+
+	for (i = 0; i < (1 << order); i++) {
+		page_owner = get_page_owner(page_ext);
+		page_owner->handle = handle;
+		page_owner->order = order;
+		page_owner->gfp_mask = gfp_mask;
+		page_owner->last_migrate_reason = last_migrate_reason;
+		page_owner->pid = pid;
+		page_owner->tgid = tgid;
+		page_owner->ts_nsec = ts_nsec;
+		strscpy(page_owner->comm, comm,
+			sizeof(page_owner->comm));
+		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
+		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+static inline void __update_page_owner_free_handle(struct page_ext *page_ext,
+						   depot_stack_handle_t handle,
+						   unsigned short order,
+						   pid_t pid, pid_t tgid,
+						   u64 free_ts_nsec)
+{
+	int i;
+	struct page_owner *page_owner;
+
+	for (i = 0; i < (1 << order); i++) {
+		page_owner = get_page_owner(page_ext);
+		/* Only __reset_page_owner() wants to clear the bit */
+		if (handle) {
+			__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
+			page_owner->free_handle = handle;
+		}
+		page_owner->free_ts_nsec = free_ts_nsec;
+		page_owner->free_pid = current->pid;
+		page_owner->free_tgid = current->tgid;
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+void __reset_page_owner(struct page *page, unsigned short order)
+{
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
 	depot_stack_handle_t alloc_handle;
@@ -245,16 +300,10 @@ void __reset_page_owner(struct page *pag
 	alloc_handle = page_owner->handle;
 
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
-	for (i = 0; i < (1 << order); i++) {
-		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
-		page_owner->free_handle = handle;
-		page_owner->free_ts_nsec = free_ts_nsec;
-		page_owner->free_pid = current->pid;
-		page_owner->free_tgid = current->tgid;
-		page_ext = page_ext_next(page_ext);
-		page_owner = get_page_owner(page_ext);
-	}
+	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
+					current->tgid, free_ts_nsec);
 	page_ext_put(page_ext);
+
 	if (alloc_handle != early_handle)
 		/*
 		 * early_handle is being set as a handle for all those
@@ -263,39 +312,14 @@ void __reset_page_owner(struct page *pag
 		 * the machinery is not ready yet, we cannot decrement
 		 * their refcount either.
 		 */
-		dec_stack_record_count(alloc_handle);
-}
-
-static inline void __set_page_owner_handle(struct page_ext *page_ext,
-					depot_stack_handle_t handle,
-					unsigned short order, gfp_t gfp_mask)
-{
-	struct page_owner *page_owner;
-	int i;
-	u64 ts_nsec = local_clock();
-
-	for (i = 0; i < (1 << order); i++) {
-		page_owner = get_page_owner(page_ext);
-		page_owner->handle = handle;
-		page_owner->order = order;
-		page_owner->gfp_mask = gfp_mask;
-		page_owner->last_migrate_reason = -1;
-		page_owner->pid = current->pid;
-		page_owner->tgid = current->tgid;
-		page_owner->ts_nsec = ts_nsec;
-		strscpy(page_owner->comm, current->comm,
-			sizeof(page_owner->comm));
-		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
-		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
-
-		page_ext = page_ext_next(page_ext);
-	}
+		dec_stack_record_count(alloc_handle, 1 << order);
 }
 
 noinline void __set_page_owner(struct page *page, unsigned short order,
 					gfp_t gfp_mask)
 {
 	struct page_ext *page_ext;
+	u64 ts_nsec = local_clock();
 	depot_stack_handle_t handle;
 
 	handle = save_stack(gfp_mask);
@@ -303,9 +327,11 @@ noinline void __set_page_owner(struct pa
 	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
 		return;
-	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
+	__update_page_owner_handle(page_ext, handle, order, gfp_mask, -1,
+				   current->pid, current->tgid, ts_nsec,
+				   current->comm);
 	page_ext_put(page_ext);
-	inc_stack_record_count(handle, gfp_mask);
+	inc_stack_record_count(handle, gfp_mask, 1 << order);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
@@ -342,7 +368,7 @@ void __folio_copy_owner(struct folio *ne
 {
 	struct page_ext *old_ext;
 	struct page_ext *new_ext;
-	struct page_owner *old_page_owner, *new_page_owner;
+	struct page_owner *old_page_owner;
 
 	old_ext = page_ext_get(&old->page);
 	if (unlikely(!old_ext))
@@ -355,31 +381,21 @@ void __folio_copy_owner(struct folio *ne
 	}
 
 	old_page_owner = get_page_owner(old_ext);
-	new_page_owner = get_page_owner(new_ext);
-	new_page_owner->order = old_page_owner->order;
-	new_page_owner->gfp_mask = old_page_owner->gfp_mask;
-	new_page_owner->last_migrate_reason =
-		old_page_owner->last_migrate_reason;
-	new_page_owner->handle = old_page_owner->handle;
-	new_page_owner->pid = old_page_owner->pid;
-	new_page_owner->tgid = old_page_owner->tgid;
-	new_page_owner->free_pid = old_page_owner->free_pid;
-	new_page_owner->free_tgid = old_page_owner->free_tgid;
-	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
-	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
-	strcpy(new_page_owner->comm, old_page_owner->comm);
-
+	__update_page_owner_handle(new_ext, old_page_owner->handle,
+				   old_page_owner->order, old_page_owner->gfp_mask,
+				   old_page_owner->last_migrate_reason,
+				   old_page_owner->ts_nsec, old_page_owner->pid,
+				   old_page_owner->tgid, old_page_owner->comm);
 	/*
-	 * We don't clear the bit on the old folio as it's going to be freed
-	 * after migration. Until then, the info can be useful in case of
-	 * a bug, and the overall stats will be off a bit only temporarily.
-	 * Also, migrate_misplaced_transhuge_page() can still fail the
-	 * migration and then we want the old folio to retain the info. But
-	 * in that case we also don't need to explicitly clear the info from
-	 * the new page, which will be freed.
+	 * Do not proactively clear PAGE_EXT_OWNER{_ALLOCATED} bits as the folio
+	 * will be freed after migration. Keep them until then as they may be
+	 * useful.
 	 */
-	__set_bit(PAGE_EXT_OWNER, &new_ext->flags);
-	__set_bit(PAGE_EXT_OWNER_ALLOCATED, &new_ext->flags);
+	__update_page_owner_free_handle(new_ext, 0, old_page_owner->order,
+					old_page_owner->free_pid,
+					old_page_owner->free_tgid,
+					old_page_owner->free_ts_nsec);
+
 	page_ext_put(new_ext);
 	page_ext_put(old_ext);
 }
@@ -787,8 +803,9 @@ static void init_pages_in_zone(pg_data_t
 				goto ext_put_continue;
 
 			/* Found early allocated page */
-			__set_page_owner_handle(page_ext, early_handle,
-						0, 0);
+			__update_page_owner_handle(page_ext, early_handle, 0, 0,
+						   -1, local_clock(), current->pid,
+						   current->tgid, current->comm);
 			count++;
 ext_put_continue:
 			page_ext_put(page_ext);
@@ -861,11 +878,11 @@ static void *stack_next(struct seq_file
 	return stack;
 }
 
-static unsigned long page_owner_stack_threshold;
+static unsigned long page_owner_pages_threshold;
 
 static int stack_print(struct seq_file *m, void *v)
 {
-	int i, stack_count;
+	int i, nr_base_pages;
 	struct stack *stack = v;
 	unsigned long *entries;
 	unsigned long nr_entries;
@@ -876,14 +893,14 @@ static int stack_print(struct seq_file *
 
 	nr_entries = stack_record->size;
 	entries = stack_record->entries;
-	stack_count = refcount_read(&stack_record->count) - 1;
+	nr_base_pages = refcount_read(&stack_record->count) - 1;
 
-	if (stack_count < 1 || stack_count < page_owner_stack_threshold)
+	if (nr_base_pages < 1 || nr_base_pages < page_owner_pages_threshold)
 		return 0;
 
 	for (i = 0; i < nr_entries; i++)
 		seq_printf(m, " %pS\n", (void *)entries[i]);
-	seq_printf(m, "stack_count: %d\n\n", stack_count);
+	seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
 
 	return 0;
 }
@@ -913,13 +930,13 @@ static const struct file_operations page
 
 static int page_owner_threshold_get(void *data, u64 *val)
 {
-	*val = READ_ONCE(page_owner_stack_threshold);
+	*val = READ_ONCE(page_owner_pages_threshold);
 	return 0;
 }
 
 static int page_owner_threshold_set(void *data, u64 val)
 {
-	WRITE_ONCE(page_owner_stack_threshold, val);
+	WRITE_ONCE(page_owner_pages_threshold, val);
 	return 0;
 }
 
--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -980,7 +980,9 @@ first_run:
 	rcu_assign_pointer(q->current_entry, next);
 	spin_unlock(&q->current_entry_lock);
 
-	hrtimer_set_expires(&q->advance_timer, end_time);
+	hrtimer_set_expires(&q->advance_timer,
+				ktime_add(timer->base->get_time(),
+					  ns_to_ktime(NSEC_PER_USEC *200)));
 
 	rcu_read_lock();
 	__netif_schedule(sch);
--

