Return-Path: <linux-kernel+bounces-154033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6388AD667
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C44E1C20E16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8C1CA84;
	Mon, 22 Apr 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LI8OLR0g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LlsSVL43"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA631BC2A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820535; cv=none; b=FjK3VwTodOGfYoDQrlLPBuwcjYd0ynbZeL64o8ZAtJHw+9tgvKlvw2j3IVOEnww9VGyiOgPWBh0c8czVshbpkmfTs4jvRpYk7oGzVu9k2z78gLjPH0vn8eeR0zTdgB6DDdEefd061Q1oza9ct3RjaLXuZt7ShPwWE4cHsvDAsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820535; c=relaxed/simple;
	bh=ZfD8GDUf+BpUFvHq2DztCjPOiFTDW6U9w5FFA/E+6+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7v8yVyO/Orjkaqrzw7WC7Lb/ilLNVapx2SiWhahlK5ayeFcsNuRRl1UpCLBDBRfNoXgLTTruVqBkwWX36/m/VYdTbc5f87b6AOxwNQZvSI4sF63Hum20GiF9HjFoQB75R/KBB3/GSbGgCyyR8Jqy96ApcOiBAExpL4JlfELk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LI8OLR0g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LlsSVL43; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713820532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/WzVm6vkdqQBH8TJFQlbBy0ETJLmjovhycHFl4LuAY=;
	b=LI8OLR0gs1l2T4gDe/DYYI3pSr+N4vVctjgC0n+OCz/erSdl8HRWRhLMAKnr224yPE2/XV
	7FbfgEad9ioH6l7Hw7spra6a68iJQESQNB5u+o9OmLr3bk2DsQzhOhCSzASkaZNc5r0dZh
	HdJh1d5nUhUm49XQsAqpRYqVhFTj2/DSoGEpGFxjXbY6haBD5CPiR/0nwQcmJvX/6MM7od
	as0MyHu3KAwLDSQqNvL9fRrMkBGvLe9oDcXkK13hrqrtAu3scW74Akb+OsTACv4BzVPlTL
	wyKB0RJV5mxCpviTRCpYIJJ+yG/1J60ATHzCg21/yZGF7tFQOWelV4LIoJu0Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713820532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/WzVm6vkdqQBH8TJFQlbBy0ETJLmjovhycHFl4LuAY=;
	b=LlsSVL43dKz/SBoN993pJPhyetX2IbV/g9QQXgTf05GSu9Z9ywDtZWe66Stevl/nLreG3d
	djgBjYKXqPhVXyBQ==
To: Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org
Cc: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
In-Reply-To: <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
References: <000000000000b24903061520f3e9@google.com>
 <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop>
 <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop>
 <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
 <ac7bf2c3-c752-46db-a5c8-0c55a1af8561@paulmck-laptop>
 <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
Date: Mon, 22 Apr 2024 23:15:28 +0200
Message-ID: <87o7a1umj3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 19 2024 at 13:50, Z qiang wrote:
>> On Thu, Apr 18, 2024 at 05:49:38PM +0800, Z qiang wrote:
>  static __init int spawn_ksoftirqd(void)
>  {
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu)
> +               per_cpu(ksoftirqd_work, cpu) = false;

First of all that initialization is pointless, but why making all of
this complex as hell?

Thanks,

        tglx
---
diff --git a/kernel/softirq.c b/kernel/softirq.c
index b315b21fb28c..e991d735be0d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool kirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -563,8 +563,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -584,6 +583,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
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

