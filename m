Return-Path: <linux-kernel+bounces-96911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5491876309
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E6282367
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7B5731C;
	Fri,  8 Mar 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUY4JTm+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD556445
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896718; cv=none; b=CdIl9ix5HBbVQnwikK8dAikyAz7/PJc1OzIAmA5YZP5lQ8JqfNQlcw73hMR8CF8sNVDuR3Q6StP6NUxJ0yOO4/CjES26qM9TmvAcSqsk2LT10LEikxII+BCweaH3T/kzxAyVhvhxbjXb61R2iy89Ii22v92xzZtogekt1XdQRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896718; c=relaxed/simple;
	bh=gz4nzHQU4MqpQnSbS1UBHclLJR2lYPGm79ku55jtwUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZ975jR7dgRH/vl/ROBY8O9YC9bfB2dAEe3CaU0jpUvafSWNH3uFA+qR86zAnsLO5V2ZVM9f7OoAYtMEtM3gVuYZ73Q2JUSkVPAljVB9IWqdbpczyRffIisqAJcMxkzkCtvL+UJ5FLDKUPkxXMsyYZLEaxIdVXtPdlcwHqJrIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUY4JTm+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so1051584f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896715; x=1710501515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGZnAIvUgvAxitPfQkgWaHDP0NrNZ4xt2txiDBCV+rk=;
        b=JUY4JTm+D41p9if9sRLYvN79IBPATGAWynda1r3PglpM1zZjP8x31d+JsX0KW9umyC
         h64qOHDApSZGoB1fw37Pv3aYhwZVFso6t3Hxulcn+1YHqwT2o3n+qzPlnr/esxs/wmWp
         4L8FfMlcVg1hZBfWFoDDtMCeAN+blt+wtTz/MZ+sRnJS0iE/Clm0/KSByzwyObrFYQ8Z
         38gB0lU+3950gqEYQSNcQnADAPGJ4mfrVpQv6pnExd6Fzf6AeFYuI9Zkg809Jq6gdfjV
         qV8KqEM3KCAwx5tWj1Nx634tOiGKl0S7GFGfZO4cTaFVK82BEgX6TNaVCnoN0mb/rrPq
         GlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896715; x=1710501515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGZnAIvUgvAxitPfQkgWaHDP0NrNZ4xt2txiDBCV+rk=;
        b=A3qBB+phbJvXmJJFB/s/4utoBdUhTuQz/0T7fch0+HnKKq0PZ707rT4WxXpUV5CPb5
         wl+jmRJXLLVi4BBH2knJOp7Mgr2LHcAis8KC1GsLRzP+9iZv6jLIXEr6VJ6Eb3jb/8ai
         3ymtaC/cEQRftEhIsw8o7KTOun1bqkZq+Pz/Qs24iqFbg3KXV+D4Igcbu9LHv/dYEKOP
         iejeaSD8mN8AUToNOAVIedPYt2klwNQwQ9DzTmklA3tMGgiskwrDUydQ8iXMB3RhK1sf
         Dd0cPiBFgveAjoR0XL1u3T2TLJyJgvhgThCl7wAIcdi7xyAJEKPaDofw8q7i89aQT4tI
         KKyg==
X-Gm-Message-State: AOJu0YwLww0JFkNgZW3QQh9YVlvZ/2HP+nJeS6cVK9PYntM9IuAe5xZp
	A+Mux2/ks/HcEqzHybNF4stAbZ0OhnsvX3CvCBw9AoIj33vFrbBHwK6R6bUZtxc=
X-Google-Smtp-Source: AGHT+IG/ZOfTRyNMuqlIXC2XXQDV3Qscmwuf+ogRDOtj7F8xG44YAobKyaKtjaxYXNd2lAGJQEPJ4Q==
X-Received: by 2002:adf:fc8e:0:b0:33d:2f2f:b135 with SMTP id g14-20020adffc8e000000b0033d2f2fb135mr16307669wrr.46.1709896714723;
        Fri, 08 Mar 2024 03:18:34 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:34 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 03/13] sched/balancing: Rename trigger_load_balance() => sched_balance_trigger()
Date: Fri,  8 Mar 2024 12:18:09 +0100
Message-Id: <20240308111819.1101550-4-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/scheduler/sched-domains.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst | 2 +-
 kernel/sched/core.c                                          | 2 +-
 kernel/sched/fair.c                                          | 2 +-
 kernel/sched/sched.h                                         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 541d6c617971..c7ea05f4107b 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -31,7 +31,7 @@ is treated as one entity. The load of a group is defined as the sum of the
 load of each of its member CPUs, and only when the load of a group becomes
 out of balance are tasks moved between groups.
 
-In kernel/sched/core.c, trigger_load_balance() is run periodically on each CPU
+In kernel/sched/core.c, sched_balance_trigger() is run periodically on each CPU
 through sched_tick(). It raises a softirq after the next regularly scheduled
 rebalancing event for the current runqueue has arrived. The actual load
 balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then run
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
index fa0c0bcc6ba5..1a8587a971f9 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -34,7 +34,7 @@ CPU共享。任意两个组的CPU掩码的交集不一定为空，如果是这
 调度域中的负载均衡发生在调度组中。也就是说，每个组被视为一个实体。组的负载被定义为它
 管辖的每个CPU的负载之和。仅当组的负载不均衡后，任务才在组之间发生迁移。
 
-在kernel/sched/core.c中，trigger_load_balance()在每个CPU上通过sched_tick()
+在kernel/sched/core.c中，sched_balance_trigger()在每个CPU上通过sched_tick()
 周期执行。在当前运行队列下一个定期调度再平衡事件到达后，它引发一个软中断。负载均衡真正
 的工作由sched_balance_softirq()->rebalance_domains()完成，在软中断上下文中执行
 （SCHED_SOFTIRQ）。
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3affa9a6b249..d56ebe8230bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5689,7 +5689,7 @@ void sched_tick(void)
 
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
-	trigger_load_balance(rq);
+	sched_balance_trigger(rq);
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 953f39deb68e..e377b675920a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12438,7 +12438,7 @@ static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 /*
  * Trigger the SCHED_SOFTIRQ if it is time to do periodic load balancing.
  */
-void trigger_load_balance(struct rq *rq)
+void sched_balance_trigger(struct rq *rq)
 {
 	/*
 	 * Don't need to rebalance while attached to NULL domain or
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..5b0ddb0e6017 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2397,7 +2397,7 @@ extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
-extern void trigger_load_balance(struct rq *rq);
+extern void sched_balance_trigger(struct rq *rq);
 
 extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
 
-- 
2.40.1


