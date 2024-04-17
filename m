Return-Path: <linux-kernel+bounces-147897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EC38A7B15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA30FB2338A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29538820;
	Wed, 17 Apr 2024 03:27:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE0E54C;
	Wed, 17 Apr 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324471; cv=none; b=lE8bRdNXHxD/qhlKq37qbYRyw4ACwZKWnq0FgvV5WbhR+6bOxlRf/qRMXwWp9HulDUWjssyV/3tn1LxVbwRr2aK6XkAiRN/NrryOGQGZ2REnu8oLlKRE4l6pnd4NR3N5QvEpMt9c+h+B4KXAHDoUy3U61KAh8ylPGekHjOWY9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324471; c=relaxed/simple;
	bh=r4KiFE+z6Yjl+E0UrlArfx0WhhGiKdnxIypFv3feVE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1ssXyW7UeDYRxpFkoylZ2ykHlemk5sfKZb4lnO6MslPUVBM0mHZxFjIpF1ddmJxKKBy+81IBSiRzRQYp4haMHSx10EF7qnBj2mr1gX/ITeedvU5MVny0PYmOTc0fshm7p8FiTXnM+XI+DBZ3yyo3gJbUd1oVfqgHUzVaglgVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VK5tF1ztvzYdQ8;
	Wed, 17 Apr 2024 11:26:45 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EB1E18006D;
	Wed, 17 Apr 2024 11:27:46 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:27:46 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>
CC: <Markus.Elfring@web.de>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH v3] ftrace: Fix possible use-after-free issue in ftrace_location()
Date: Wed, 17 Apr 2024 11:28:30 +0800
Message-ID: <20240417032830.1764690-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401125543.1282845-1-zhengyejian1@huawei.com>
References: <20240401125543.1282845-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)

KASAN reports a bug:

  BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
  Read of size 8 at addr ffff888141d40010 by task insmod/424
  CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+
  [...]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x68/0xa0
   print_report+0xcf/0x610
   kasan_report+0xb5/0xe0
   ftrace_location+0x90/0x120
   register_kprobe+0x14b/0xa40
   kprobe_init+0x2d/0xff0 [kprobe_example]
   do_one_initcall+0x8f/0x2d0
   do_init_module+0x13a/0x3c0
   load_module+0x3082/0x33d0
   init_module_from_file+0xd2/0x130
   __x64_sys_finit_module+0x306/0x440
   do_syscall_64+0x68/0x140
   entry_SYSCALL_64_after_hwframe+0x71/0x79

The root cause is that, in lookup_rec(), ftrace record of some address
is being searched in ftrace pages of some module, but those ftrace pages
at the same time is being freed in ftrace_release_mod() as the
corresponding module is being deleted:

           CPU1                       |      CPU2
  register_kprobes() {                | delete_module() {
    check_kprobe_address_safe() {     |
      arch_check_ftrace_location() {  |
        ftrace_location() {           |
          lookup_rec() // USE!        |   ftrace_release_mod() // Free!

To fix this issue:
  1. Hold rcu lock as accessing ftrace pages in ftrace_location_range();
  2. Use ftrace_location_range() instead of lookup_rec() in
     ftrace_location();
  3. Call synchronize_rcu() before freeing any ftrace pages both in
     ftrace_process_locs()/ftrace_release_mod()/ftrace_free_mem().

Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 46 ++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 16 deletions(-)

v3:
 - Complete the commit description and add Suggested-by tag
 - Add comments around where synchronize_rcu() is called

v2:
 - Link: https://lore.kernel.org/all/20240416112459.1444612-1-zhengyejian1@huawei.com/
 - Use RCU lock instead of holding ftrace_lock as suggested by Steve.
   Link: https://lore.kernel.org/all/20240410112823.1d084c8f@gandalf.local.home/

v1:
 - Link: https://lore.kernel.org/all/20240401125543.1282845-1-zhengyejian1@huawei.com/

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..e05d3e3dc06a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1581,7 +1581,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 }
 
 /**
- * ftrace_location_range - return the first address of a traced location
+ * ftrace_location_range_rcu - return the first address of a traced location
  *	if it touches the given ip range
  * @start: start of range to search.
  * @end: end of range to search (inclusive). @end points to the last byte
@@ -1592,7 +1592,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
  * that is either a NOP or call to the function tracer. It checks the ftrace
  * internal tables to determine if the address belongs or not.
  */
-unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+static unsigned long ftrace_location_range_rcu(unsigned long start, unsigned long end)
 {
 	struct dyn_ftrace *rec;
 
@@ -1603,6 +1603,16 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 	return 0;
 }
 
+unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+{
+	unsigned long loc;
+
+	rcu_read_lock();
+	loc = ftrace_location_range_rcu(start, end);
+	rcu_read_unlock();
+	return loc;
+}
+
 /**
  * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
@@ -1614,25 +1624,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	struct dyn_ftrace *rec;
+	unsigned long loc;
 	unsigned long offset;
 	unsigned long size;
 
-	rec = lookup_rec(ip, ip);
-	if (!rec) {
+	loc = ftrace_location_range(ip, ip);
+	if (!loc) {
 		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
 			goto out;
 
 		/* map sym+0 to __fentry__ */
 		if (!offset)
-			rec = lookup_rec(ip, ip + size - 1);
+			loc = ftrace_location_range(ip, ip + size - 1);
 	}
 
-	if (rec)
-		return rec->ip;
-
 out:
-	return 0;
+	return loc;
 }
 
 /**
@@ -6596,6 +6603,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6809,6 +6818,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -7142,6 +7154,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -7183,12 +7196,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			if (pg->records) {
-				free_pages((unsigned long)pg->records, pg->order);
-				ftrace_number_of_pages -= 1 << pg->order;
-			}
-			ftrace_number_of_groups--;
-			kfree(pg);
+			pg->next = tmp_page;
+			tmp_page = pg;
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
 				ftrace_pages = pg;
@@ -7205,6 +7214,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)
-- 
2.25.1


