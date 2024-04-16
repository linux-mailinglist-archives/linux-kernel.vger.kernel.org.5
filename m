Return-Path: <linux-kernel+bounces-146702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC98A698D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334701F21EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44271292CE;
	Tue, 16 Apr 2024 11:24:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43B128828;
	Tue, 16 Apr 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266659; cv=none; b=uKyOWugpAB9N92XNgsKPjUk0HPx/zSoc/E9MUHPdifDY+iI/m9Xdz9+RSWt3CwaUemi3EA74JRGm1UVdP/TpJbjwA1ePt3CrE3x08q/qTl3+kgJDImqZMAqwis+h76gTz8Q1LwuUw4PtFXrNaSEHm7ZsDbmWdlh142Mz/iTYZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266659; c=relaxed/simple;
	bh=sBjv/qwRLtegjlxLd5y3j7HuvcFzTXceeLcLshqbaac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LluLC+E+pWC2fXlJb0OJXUeviNngjliw6p5BPhHclziRT3Xrlf92x+E5up6wfC1j5LUxdjcTRfL8WzEBp3kYp19sY65zijbZA3mBRGCRB9lDeoyA+kfTbc+S1a8txLvEn6rWnnlUjAC1RPruUSCJvldTuys6c98WU1Q6JT83jNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VJhS73dSxzwS0s;
	Tue, 16 Apr 2024 19:21:11 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BEE9180032;
	Tue, 16 Apr 2024 19:24:13 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 19:24:13 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<zhengyejian1@huawei.com>
Subject: [PATCH v2] ftrace: Fix possible use-after-free issue in ftrace_location()
Date: Tue, 16 Apr 2024 19:24:59 +0800
Message-ID: <20240416112459.1444612-1-zhengyejian1@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The root cause is that when lookup_rec() is lookuping ftrace record of
an address in ftrace pages of some module, and those ftrace pages may
at the same time being freed in ftrace_release_mod() as the corresponding
module is being deleted:

  register_kprobes() {
    check_kprobe_address_safe() {
      arch_check_ftrace_location() {
        ftrace_location() {
          lookup_rec()  // access memory that has been freed by
                        // ftrace_release_mod() !!!

To fix it, we hold rcu lock as lookuping ftrace record, and call
synchronize_rcu() before freeing any ftrace pages.

Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

v2:
 - Use RCU lock instead of holding ftrace_lock as suggested by Steve.
   Link: https://lore.kernel.org/all/20240410112823.1d084c8f@gandalf.local.home/

v1:
 - Link: https://lore.kernel.org/all/20240401125543.1282845-1-zhengyejian1@huawei.com/

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..2b41837a2fac 100644
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
@@ -6596,6 +6603,7 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6809,6 +6817,8 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -7142,6 +7152,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -7183,12 +7194,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
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
@@ -7205,6 +7212,10 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)
-- 
2.25.1


