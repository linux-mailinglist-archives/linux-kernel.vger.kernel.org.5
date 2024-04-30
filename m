Return-Path: <linux-kernel+bounces-164778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC69C8B82C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACBA1F22CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3EF12BEBB;
	Tue, 30 Apr 2024 22:50:11 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFA17C6A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517411; cv=none; b=CdaVWKSksWq/pbTVhpeQSLkwE16/GMiXR9ICNtPztutRVAl/od77YU90ujsKyd8OA1A1sW9OfDsJ/Pte0LxnV7lt5kFcwkHDDM/LqjMiPRQAJKHgM6ObUM/gIZ292jhJ27yVNdjidCKD1Lrp+cNCvIvYXFibRAFGuVEnZxYTrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517411; c=relaxed/simple;
	bh=XEE2PEy3b5fcX0gLmxayUkBOW/4SKFDooMAEXPZlcsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewoC+eKChfW++l4KWk5bfbWW9dBN/K3rRf+0sF9WiQDvJ/lsIC4SeZKk1cVGUB6d5VzNzjrBnfsYlE2G2JAn4gE1bc8BwtQ1F9SASlLe0ornMuC/8GkT1IvjOsODZHxAUAQET4sFtDaMi3JqIKW9wCh+Zi+dO7kwVrjKQ3YOdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.115])
	by sina.com (172.16.235.24) with ESMTP
	id 6631759800002F6E; Tue, 1 May 2024 06:50:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 23084445089376
X-SMAIL-UIID: 793AE464C04D4BCDA5E14DF8F1C4EC61-20240501-065002-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
Date: Wed,  1 May 2024 06:50:05 +0800
Message-Id: <20240430225005.4368-1-hdanton@sina.com>
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 01:25:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    bb7a2467e6be Add linux-next specific files for 20240426
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c30028980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  bb7a2467e6be

--- x/kernel/vhost_task.c
+++ y/kernel/vhost_task.c
@@ -100,6 +100,8 @@ void vhost_task_stop(struct vhost_task *
 	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
+	mutex_lock(&vtsk->exit_mutex);
+	mutex_unlock(&vtsk->exit_mutex);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -563,8 +563,7 @@ restart:
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -584,6 +583,11 @@ restart:
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;

--

