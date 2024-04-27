Return-Path: <linux-kernel+bounces-160993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECAE8B458D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087981F21BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB3C482C2;
	Sat, 27 Apr 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzhLjUl+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E1481A8;
	Sat, 27 Apr 2024 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714213700; cv=none; b=HstXSTziujlhlLh3wQ8QnxnJNfKs5J85DyOh75r6Z++xvX+YsNHwfSWxBtmuetsoqCKT7vmssB3oJ7JLj5SV21Ynwde24FFgTaQrjHS9k32zlkrVsD0jgGKYmbXZtTUMfVzgrdTgp8/EBlNosbbne98WgRlHCVe3xVbg8gng9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714213700; c=relaxed/simple;
	bh=N/b5DpSzKkfD8U7Qhdg29sDer1L62s9oh/XW1K5lrqI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=O3VLQ+VYzzdMNQD4lIffQly3Au0Ialcd9KQte6yf+TEex3ErTK+qfs7gpnNXLTEG1wVZJsSU6xR+DHToOBPFBPL9zMdE11k19rlllRDNjRr8i73yBDWuB9FGaU3i8X3jiq2Ty7QzP23G+Bwg41EpLKfYMsXY/STZ59POMTsRXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzhLjUl+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e9320c2ef6so21460445ad.2;
        Sat, 27 Apr 2024 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714213699; x=1714818499; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Lsen2Jh93GdgDkNshamkOVa5/H5pA7PUKli5agUeu4=;
        b=dzhLjUl+hlqqTnYF5r8V/UkZvP6nFMfvEhxzeiDRZWJGo1s+NfF7LNkK0Sb7RN32DZ
         FYGp+7+gDzNSMmyRmdwZ6MOOZfro+pRGMoz+UWdv6eqycR00EUXgmZ8EuA61i2Aqwfyg
         xu1y20yIvjVwf6Iz0zEj/HSji/D1GZkH374v1y0rjItyCqHJ6LOpd9d2Fv+O1zsHGMl9
         oFBvAIruAJm6skLD2zeywCuakkfRkRS2wWj8OeYQoOUyUk29XOpypCnRQ2AyidNnyjua
         oso3F/chzNH8Qv0wapLRIetfhwFtBgdRdqi8B7Xz0WCO2rsAWfIL7E92rxQ4/G2doF24
         GCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714213699; x=1714818499;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Lsen2Jh93GdgDkNshamkOVa5/H5pA7PUKli5agUeu4=;
        b=n3+MnAzOVr80zpCHL4qC7TXaBLwdKRQy974i809gHbJ87vMdikJJcGaFCCmezRcUKq
         r8yoXcHhNmoCiOO1MSTsMahiEhSnQCBj3DdZHP6/KEoGV/fgGnLpWGF1/atOxDh4rYgn
         cNifyihBSJoN5pPnwMPhvEWSftGvFswokK20eIevShWmMZEskEVpRWYCC/Xq2pjCkDIQ
         PDywEZE3rgBCyHS+yFyhKIsaDgjW6v6iqgc9F8WxoqR7aSgJrpGJuwsa6Em6PEjWg5sb
         FFW0lVHpGGam3gMOwckCjcbat6V8DYuiBIvGrlNgs49jMU7GB6oP5dzBFxz8azaGAuWU
         5e5A==
X-Forwarded-Encrypted: i=1; AJvYcCU5UWIIzxr+6awoS4pqFqOwxck008JZ5Uv9l+dZNan6PWKuYXKamxZO7SRA6peCkuvIamkLlVe8XZSQBQLwA/nIUO28SyRfkzd48XO4k/TD/ljQMiWpHEgfcjbfiu7MemaV
X-Gm-Message-State: AOJu0Yw/QpnZoixQ833vpI9oK8ywPsHYYb+d6zp5spYB7bG/gKtGK7jQ
	H897SKy292l3v0OAAStCGd4nLOOLCAdvOBIS3jTCAFp7LIPD28th79n87w==
X-Google-Smtp-Source: AGHT+IEpg2tJ1zZJTLXkw19Actvjcq76/czJyPfB/0NpY0GxWoReDmsakjKAuEW5BcLumAI4tqPNyA==
X-Received: by 2002:a17:902:d50d:b0:1eb:e1b:737a with SMTP id b13-20020a170902d50d00b001eb0e1b737amr4560900plg.44.1714213698693;
        Sat, 27 Apr 2024 03:28:18 -0700 (PDT)
Received: from localhost.localdomain ([120.244.141.185])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902b21400b001e3e081dea1sm16878152plr.0.2024.04.27.03.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:28:18 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	tglx@linutronix.de,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix suspicious RCU usage in __do_softirq()
Date: Sat, 27 Apr 2024 18:28:08 +0800
Message-Id: <20240427102808.29356-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently, the condition "__this_cpu_read(ksoftirqd) == current" is
checked to ensure the rcu_softirq_qs() is invoked in ksoftirqd tasks
context for non-RT kernels. however, in some scenarios, this condition
will be broken.

     ksoftirqd/0
->finish_task_switch
  ->put_task_struct_rcu_user
    ->call_rcu(&task->rcu, delayed_put_task_struct)
      ->__kasan_record_aux_stack
        ->pfn_valid
          ->rcu_read_lock_sched()
            <interrupt>
             __irq_exit_rcu
             ->__do_softirq
               -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
                   __this_cpu_read(ksoftirqd) == current)
                   ->rcu_softirq_qs
                     ->RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))

The rcu quiescent states is reported occurs in the rcu-read critical
section, so the lockdep warning is triggered. this commit therefore
remove "__this_cpu_read(ksoftirqd) == current" condition check, generate
new "handle_softirqs(bool kirqd)" function to replace __do_softirq() in
run_ksoftirqdt(), and set parameter kirqd to true, make rcu_softirq_qs()
be invoked only in ksofirqd tasks context for non-RT kernels.

Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop/T/#mea8aba4abfcb97bbf499d169ce7f30c4cff1b0e3
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/softirq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

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
-- 
2.17.1


