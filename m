Return-Path: <linux-kernel+bounces-155575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063F8AF41A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F14F1C23A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05613D61C;
	Tue, 23 Apr 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEWrtxWI"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210013D530
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889742; cv=none; b=BqXxTsBb/WwqsMf4s89+hQ2KFyTK0WRqKdr8ywDEDzLBKl6M7DdeaH6f74pdYxzz00rPL1qzUaIazb11LWM9HiLeiCLNK4ycwHagsNny5kkEAHHv22e3CM6Vhb0KTMhO1PGH1gBV/BZerWLckODyyeyGZ+Pc8vTYpffrXEsKPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889742; c=relaxed/simple;
	bh=hKwnyKYxUieWcDXpBDUPZWC/LBXcDL4MoiPPoFHtwhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdgllfoV0ekXVfrAvK5/IpjF6Gok9ZGt1E05N7WWXh7MwceXfdd0RtJmXx6JVdNZGOEaJ7JOUNOL+RuURCjELROQuEIVtkbVM3YT3nzNJqjfQzMQ0P35NON5yck6joMrB+k+na5/Ow7VFJ1E/iYdDx1Hbf4c44dGRuRJsRcA8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEWrtxWI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2adce8f7814so2061859a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713889740; x=1714494540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMsNlntKePki7cMkUYlg0t86F6HRDujxz9Yy8T6g+ic=;
        b=YEWrtxWICGCV2yeG2SydqZuMasIle3A534xsylDOHjoTzfgA3XKwCJOEFEz8EURDx3
         j3kqFhYiRdGeqUhkDXA0qnZQsraz631I7QfnY/80WcdLdEG1lCbqHUZ1rGdMClSjotgK
         BrHSI5F2pVCMh9AWJUtj2dVDOPsY2U9DAPaU4RRbA/95EZzBqmNkeMOr1S0yoe3wexhX
         jKCyDcP/s8II16CYEzmpTpq+W9Xv1Rzq+H/qW2xmTRmMY/eoSHgIg0xtGTXY+jLXDJPv
         t+oKlcbYzM+j8enGehCTY1K3ttLWFkMcOazaEt0aKAdrb6cU8jTVQNvXm2sA+OERYn57
         g1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889740; x=1714494540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMsNlntKePki7cMkUYlg0t86F6HRDujxz9Yy8T6g+ic=;
        b=EwwKiXsYYi+tSp+qdzcCbSiJj5kbG3wDW8ih6OGfxyTm4semfgXmRvHULK6RsbJyaG
         KG9nGpT9oP/j9zT9UQgb/gfqlpVDO4IDAl8sC/EmGMbCJF/FuXm3Xq14RywPrRm1lyte
         P8Hq5ISkQ8ybAhG9q4vzz2KUjrOcrlNyf+lTVuiuIhiAqdboJTO8dWeOQ+xiRyfgPM/h
         RTV6QZJPphM16JSWRUb8BgXs0H0tEj3ThG5xk3OAgwyQhVADXRpHf/N7GTFTq+D+Rcw9
         M039psxi+kgYXJ2R9qA4fW/8HHDM8WCt1pYEw4VyCR6FFEqHHhAt/Eh6YruRc3IIDIYh
         6QRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJWy75YeIizZfekz82Hyqa/xsCHK9sxVO8d7hDuRqDoqvnb9MMFESTVLsDwtqDS9UVHRcynsQL+Qy2yilqFr81f2g+CiF0OtqGztGd
X-Gm-Message-State: AOJu0YzqW35X1DIHN9nn6tJFBqzDxSbRnZnsRYx5Ob2XVA2kCdXp7XWp
	aEQFfz1psdYwT/hoINuNJhUyhOqn9Qm+57HEnsOwxC63IaPGzm0WwwOluVX5
X-Google-Smtp-Source: AGHT+IE1mIBHXr7DXWIF1lee9/leT3zgkzvzMUi58zr2PGz6kvSJOKss+onfXyAvnYI5I9TNDHiVFQ==
X-Received: by 2002:a17:90a:638c:b0:2a5:badb:30ea with SMTP id f12-20020a17090a638c00b002a5badb30eamr13287807pjj.36.1713889740538;
        Tue, 23 Apr 2024 09:29:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id si4-20020a17090b528400b002ae62a84f29sm2505085pjb.38.2024.04.23.09.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:29:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Apr 2024 06:28:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: fix selection of wake_cpu in kick_pool()
Message-ID: <ZifhygHQQnPLBbtU@slm.duckdns.org>
References: <20240423061906.2431968-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423061906.2431968-1-svens@linux.ibm.com>

Hello,

Applied to wq/for-6.9-fixes with further explanation and stable cc.

Thanks.
------ 8< ------
From 57a01eafdcf78f6da34fad9ff075ed5dfdd9f420 Mon Sep 17 00:00:00 2001
From: Sven Schnelle <svens@linux.ibm.com>
Date: Tue, 23 Apr 2024 08:19:05 +0200
Subject: [PATCH] workqueue: Fix selection of wake_cpu in kick_pool()

With cpu_possible_mask=0-63 and cpu_online_mask=0-7 the following
kernel oops was observed:

smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 8 CPUs
Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000000000000000 TEID: 0000000000000803
[..]
 Call Trace:
arch_vcpu_is_preempted+0x12/0x80
select_idle_sibling+0x42/0x560
select_task_rq_fair+0x29a/0x3b0
try_to_wake_up+0x38e/0x6e0
kick_pool+0xa4/0x198
__queue_work.part.0+0x2bc/0x3a8
call_timer_fn+0x36/0x160
__run_timers+0x1e2/0x328
__run_timer_base+0x5a/0x88
run_timer_softirq+0x40/0x78
__do_softirq+0x118/0x388
irq_exit_rcu+0xc0/0xd8
do_ext_irq+0xae/0x168
ext_int_handler+0xbe/0xf0
psw_idle_exit+0x0/0xc
default_idle_call+0x3c/0x110
do_idle+0xd4/0x158
cpu_startup_entry+0x40/0x48
rest_init+0xc6/0xc8
start_kernel+0x3c4/0x5e0
startup_continue+0x3c/0x50

The crash is caused by calling arch_vcpu_is_preempted() for an offline
CPU. To avoid this, select the cpu with cpumask_any_and_distribute()
to mask __pod_cpumask with cpu_online_mask. In case no cpu is left in
the pool, skip the assignment.

tj: This doesn't fully fix the bug as CPUs can still go down between picking
the target CPU and the wake call. Fixing that likely requires adding
cpu_online() test to either the sched or s390 arch code. However, regardless
of how that is fixed, workqueue shouldn't be picking a CPU which isn't
online as that would result in unpredictable and worse behavior.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0066c8f6c154..a2af0aaf026b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1277,8 +1277,12 @@ static bool kick_pool(struct worker_pool *pool)
 	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
 		struct work_struct *work = list_first_entry(&pool->worklist,
 						struct work_struct, entry);
-		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
-		get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
+		int wake_cpu = cpumask_any_and_distribute(pool->attrs->__pod_cpumask,
+							  cpu_online_mask);
+		if (wake_cpu < nr_cpu_ids) {
+			p->wake_cpu = wake_cpu;
+			get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
+		}
 	}
 #endif
 	wake_up_process(p);
-- 
2.44.0


