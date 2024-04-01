Return-Path: <linux-kernel+bounces-126662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FF893B26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920B61C20C36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D93E494;
	Mon,  1 Apr 2024 12:55:19 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2F2940D;
	Mon,  1 Apr 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711976119; cv=none; b=uCRXJZe4fgOin1c7V2/ApqyWEZ9NoaRhU3TGxdwFEEfT8PkFr5weuEWziH1SbfTcMyBTzZUE2ayg+7Ta37rW1Me88zbzjytPR4TLAXClrqp8olgkVezDbfjR6bFzS0HIhSvWUBCEw7cHU4JT/FvxZNFU1aYZgfAWIChEcjvI8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711976119; c=relaxed/simple;
	bh=9+vzMVeUAI2Mzq8O0Xp2MRVfQENYZAVm0EKdXfmvQxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cgdO1EBLc6o1cdK6/pkS95iXaQvHxuHJpLR08Z8XCU+GT1xJBOYUlikfYI97vM1NecFi0qgb7o73ugAha7CzO4tqeDbC+Ok2cUl6AAdN59L/rfjIQdg2hbluzU6jt9R+gG+Xbedp9vi2a8J/Q1skqRS/V/jh+dsZ8GI9F6BLzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V7WDW1N6Vzbf3g;
	Mon,  1 Apr 2024 20:54:19 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 52C541400D1;
	Mon,  1 Apr 2024 20:55:13 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 20:55:13 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<zhengyejian1@huawei.com>
Subject: [PATCH] ftrace: Fix use-after-free issue in ftrace_location()
Date: Mon, 1 Apr 2024 20:55:43 +0800
Message-ID: <20240401125543.1282845-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500012.china.huawei.com (7.185.36.15)

KASAN reports a bug:

  BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
  Read of size 8 at addr ffff888141d40010 by task insmod/424
  CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+ #213
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
an address in some module, and at the same time in ftrace_release_mod(),
the memory that saving ftrace records has been freed as that module is
being deleted.

  register_kprobes() {
    check_kprobe_address_safe() {
      arch_check_ftrace_location() {
        ftrace_location() {
          lookup_rec()  // access memory that has been freed by
                        // ftrace_release_mod() !!!

It seems that the ftrace_lock is required when lookuping records in
ftrace_location(), so is ftrace_location_range().

Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..838d175709c1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1581,7 +1581,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 }
 
 /**
- * ftrace_location_range - return the first address of a traced location
+ * ftrace_location_range_locked - return the first address of a traced location
  *	if it touches the given ip range
  * @start: start of range to search.
  * @end: end of range to search (inclusive). @end points to the last byte
@@ -1592,7 +1592,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
  * that is either a NOP or call to the function tracer. It checks the ftrace
  * internal tables to determine if the address belongs or not.
  */
-unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+static unsigned long ftrace_location_range_locked(unsigned long start, unsigned long end)
 {
 	struct dyn_ftrace *rec;
 
@@ -1603,6 +1603,17 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 	return 0;
 }
 
+unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+{
+	unsigned long loc;
+
+	mutex_lock(&ftrace_lock);
+	loc = ftrace_location_range_locked(start, end);
+	mutex_unlock(&ftrace_lock);
+
+	return loc;
+}
+
 /**
  * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
@@ -1614,25 +1625,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
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
-- 
2.25.1


