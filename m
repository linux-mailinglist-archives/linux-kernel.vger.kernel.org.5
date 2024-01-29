Return-Path: <linux-kernel+bounces-43623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C58416BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4701C23297
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7315A4B9;
	Mon, 29 Jan 2024 23:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO4iiK1b"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664B524CC;
	Mon, 29 Jan 2024 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570727; cv=none; b=nn6d2vmHZifIf5H5ZDtSincpEW9JFPAT4iJbqwZDxj76g0wtFLJ+3pwuOYxInFt0dGXKFvwN43ksFUuBbXNwaFtunJzfpXDczgc48S9vj6H1zkYBWqI2or6k28J1JjLkrJLfhGPSpiz9tGlZpa3BpDJhDqNmZtm5LxnItb1wzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570727; c=relaxed/simple;
	bh=ZL88poR0QTNey5GX9keKNjRoMeBEej890116qx7Cfxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb2bK6etXjQoSDGszyJ0ZwYm1dAGSWVZdEWRF7++FfnW5ruAcbmjKUunhYtdycKHwAcP5s4kRAeaMRIXDbt1NWbnHA6ZbEJ/OGRyqYL/wVAZ/4lJeb73NI6FktV6XyqeuHz4A1RCBo7Stru+vjrU0fpKCAj696NOkpO/z1gU4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO4iiK1b; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc35fd0df02so2980759276.0;
        Mon, 29 Jan 2024 15:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570725; x=1707175525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BaGBF15LgJCswlA/Xb0dIQOw2f8vA7meO+drqGQMIwc=;
        b=cO4iiK1bf1xkTMbrdPBWxUDT0pXtjFCI3YP5bArRsZkWP1LFm+HXLciPC3O7ablYaz
         BVEqLxwYyGBRyut9kCce4mFY+WVcdDKQTeuek3Ggl1QUoOMXmh4/1CgoqwsYlIYr2iz3
         iEvAPY4zUZ53Ku4A2c8it39mr9NES/Ad6g/6HrSPHVw+GQ0THGu9mhzR1SJ1EWrjtrWa
         2SPdO1wGrg5DUymphEJdLpVigfBC6+jkZhwDtCyOjmyu4rdLwo/F4xEflE5cAYJyYJrH
         RIvpnaXRnKmEzCkFpBCDFEkaHY1WVUD6FawtaM1vqhpKiTUt1L0QGN0+htFMN8zqufBI
         9moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570725; x=1707175525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BaGBF15LgJCswlA/Xb0dIQOw2f8vA7meO+drqGQMIwc=;
        b=mwx76xLQw0UtHkqp6RyI9Y2ZRyGh+B+YGiqcEX7/3fjBrjoamrgN+Re9h5ZiDh07D3
         Mwce6eH2fQc+bttX2PHFSe+OCS6SnisdyQYeVO/6zjLX57a1Hi109eJ5w9myFE1ex2PA
         tM3ndoj9XrNS7xvrKRkCL6JZp9P4LYi9XFFnn1PtMBV7+mMg+oSLXGEjxYvoktO94A8O
         FViPdbkN9FyRB6bWk7WjKRfYWWo9RogUvifkZmJ0w2tbP87c3FidsoNELy60tRkUNWm7
         P3ultGEf90zxMHY5gHXZP2tNb6uH3jC7wBSmf5nGdDdrMycqlGttTY2lnPBbWl7ilMBO
         0swg==
X-Gm-Message-State: AOJu0YyDlsegPam/W50UKiPSAmpibavm9fr7FPzLYTpe2LjtkdUUpwra
	mrQ5hNKNaarUyumxeLnLzIc2MsZtWHQ2GU6q9rFKEhsugDC6m6uWFrymuCPt
X-Google-Smtp-Source: AGHT+IFQGqPTnGxPiQO1Djtq9eBh/c4nCzgPRxDCLixqLhATJOOGjN7GMz/5eBGtGYtngLOOS7lO6Q==
X-Received: by 2002:a25:83cb:0:b0:dc2:50ea:1044 with SMTP id v11-20020a2583cb000000b00dc250ea1044mr3635082ybm.86.1706570724591;
        Mon, 29 Jan 2024 15:25:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUopi7LpDEn6Iic0kOjuwVX7zwfYaAj5nJ88lroT98VkUCVmYXSc/pGHpzIVOlu0NSZ1HZDBsPqiEvw3VZ8EZWzyTAhb0EojwT30RSnqe++9sMlN/+/ZD+3zEvSemDj1ecaqCHVtQU65ylwavHLr+PQk+iybptk1FaSkyuN6cNAlM2Nh8X8pCd+K0V5dauzvtAqH1vNTha3Y4sGpurqBGrIDzH1nU+VqS1AwCeeU3VKAxnjU/eDMVbq2EwE4SauUKUI66fxmaFcRjkI1SXYc25exJwsketHJ6/ldjYlKGNxbfjT1e0kG//kX1JGEnsftj1nFzUhnzucltKwV27CAMk90xZHXL1ObFci+1hF3essHWEGDuuF8KGOaHB/61Q=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id os28-20020a05620a811c00b0078350718a63sm3536852qkn.67.2024.01.29.15.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id D4FFF27C005B;
	Mon, 29 Jan 2024 18:25:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 18:25:23 -0500
X-ME-Sender: <xms:4zO4ZQkttY4X9SGSAHYgXxaY-7I1N5owRK6cP_QluEThTJGNw-kqhg>
    <xme:4zO4Zf1e3CMXKQZ3SdDQUSUqANhqJwHWSiTrwo6f61rB-Q2C-Yo8vjYNQgRlyVlrC
    cedICEVCWSq5A3NJA>
X-ME-Received: <xmr:4zO4ZeoXyDAchmDSrjueNqjd6UySuOLcnbTmrBgYha1nOEoQ3_7hNBmCkFhUzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4zO4ZcnWScetnwQLeRLxiGbOGvqf1pG0DYvrNSfJLmS6cuxKrevyig>
    <xmx:4zO4Ze3N-Lxei9c340Q-OtDPml3uJymVvhh2qgnWUgBJL9Ydaxd8Qw>
    <xmx:4zO4ZTs4Vdzk40bWXKYKIlc-oTcgasbyNqvnlAs7UG7Hm0eP_GjZpQ>
    <xmx:4zO4ZbvPZXXcWrl7TabmJzKl342AqNoQaMUSgyLnSlW1P4x-OUhiEQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:23 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 7/8] rcu/exp: Handle parallel exp gp kworkers affinity
Date: Mon, 29 Jan 2024 15:23:45 -0800
Message-ID: <20240129232349.3170819-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129232349.3170819-1-boqun.feng@gmail.com>
References: <20240129232349.3170819-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

Affine the parallel expedited gp kworkers to their respective RCU node
in order to make them close to the cache their are playing with.

This reuses the boost kthreads machinery that probe into CPU hotplug
operations such that the kthreads become/stay affine to their respective
node as soon/long as they contain online CPUs. Otherwise and if the
current CPU going down was the last online on the leaf node, the related
kthread is affine to the housekeeping CPUs.

In the long run, this affinity VS CPU hotplug operation game should
probably be implemented at the generic kthread level.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[boqun: s/* rcu_boost_task/*rcu_boost_task as reported by checkpatch]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c        | 79 +++++++++++++++++++++++++++++++++++++---
 kernel/rcu/tree_plugin.h | 42 ++-------------------
 2 files changed, 78 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 398c099d45d9..312c4c5d4509 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -145,7 +145,7 @@ static int rcu_scheduler_fully_active __read_mostly;
 
 static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
+static struct task_struct *rcu_boost_task(struct rcu_node *rnp);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
@@ -4417,6 +4417,16 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 	sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
 }
 
+static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
+{
+	struct kthread_worker *kworker = READ_ONCE(rnp->exp_kworker);
+
+	if (!kworker)
+		return NULL;
+
+	return kworker->task;
+}
+
 static void __init rcu_start_exp_gp_kworker(void)
 {
 	const char *name = "rcu_exp_gp_kthread_worker";
@@ -4441,6 +4451,11 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 {
 }
 
+static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
+{
+	return NULL;
+}
+
 static void __init rcu_start_exp_gp_kworker(void)
 {
 }
@@ -4519,13 +4534,67 @@ int rcutree_prepare_cpu(unsigned int cpu)
 }
 
 /*
- * Update RCU priority boot kthread affinity for CPU-hotplug changes.
+ * Update kthreads affinity during CPU-hotplug changes.
+ *
+ * Set the per-rcu_node kthread's affinity to cover all CPUs that are
+ * served by the rcu_node in question.  The CPU hotplug lock is still
+ * held, so the value of rnp->qsmaskinit will be stable.
+ *
+ * We don't include outgoingcpu in the affinity set, use -1 if there is
+ * no outgoing CPU.  If there are no CPUs left in the affinity set,
+ * this function allows the kthread to execute on any CPU.
+ *
+ * Any future concurrent calls are serialized via ->kthread_mutex.
  */
-static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
+static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	cpumask_var_t cm;
+	unsigned long mask;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+	struct task_struct *task_boost, *task_exp;
+
+	if (!IS_ENABLED(CONFIG_RCU_EXP_KTHREAD) && !IS_ENABLED(CONFIG_RCU_BOOST))
+		return;
+
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	rnp = rdp->mynode;
+
+	task_boost = rcu_boost_task(rnp);
+	task_exp = rcu_exp_par_gp_task(rnp);
+
+	/*
+	 * If CPU is the boot one, those tasks are created later from early
+	 * initcall since kthreadd must be created first.
+	 */
+	if (!task_boost && !task_exp)
+		return;
+
+	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
+		return;
+
+	mutex_lock(&rnp->kthread_mutex);
+	mask = rcu_rnp_online_cpus(rnp);
+	for_each_leaf_node_possible_cpu(rnp, cpu)
+		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
+		    cpu != outgoingcpu)
+			cpumask_set_cpu(cpu, cm);
+	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
+	if (cpumask_empty(cm)) {
+		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
+		if (outgoingcpu >= 0)
+			cpumask_clear_cpu(outgoingcpu, cm);
+	}
+
+	if (task_exp)
+		set_cpus_allowed_ptr(task_exp, cm);
+
+	if (task_boost)
+		set_cpus_allowed_ptr(task_boost, cm);
+
+	mutex_unlock(&rnp->kthread_mutex);
 
-	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
+	free_cpumask_var(cm);
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 09bdd36ca9ff..36a8b5dbf5b5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1211,43 +1211,9 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 }
 
-/*
- * Set the per-rcu_node kthread's affinity to cover all CPUs that are
- * served by the rcu_node in question.  The CPU hotplug lock is still
- * held, so the value of rnp->qsmaskinit will be stable.
- *
- * We don't include outgoingcpu in the affinity set, use -1 if there is
- * no outgoing CPU.  If there are no CPUs left in the affinity set,
- * this function allows the kthread to execute on any CPU.
- *
- * Any future concurrent calls are serialized via ->kthread_mutex.
- */
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static struct task_struct *rcu_boost_task(struct rcu_node *rnp)
 {
-	struct task_struct *t = rnp->boost_kthread_task;
-	unsigned long mask;
-	cpumask_var_t cm;
-	int cpu;
-
-	if (!t)
-		return;
-	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
-		return;
-	mutex_lock(&rnp->kthread_mutex);
-	mask = rcu_rnp_online_cpus(rnp);
-	for_each_leaf_node_possible_cpu(rnp, cpu)
-		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
-		    cpu != outgoingcpu)
-			cpumask_set_cpu(cpu, cm);
-	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
-	if (cpumask_empty(cm)) {
-		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
-		if (outgoingcpu >= 0)
-			cpumask_clear_cpu(outgoingcpu, cm);
-	}
-	set_cpus_allowed_ptr(t, cm);
-	mutex_unlock(&rnp->kthread_mutex);
-	free_cpumask_var(cm);
+	return READ_ONCE(rnp->boost_kthread_task);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
@@ -1266,10 +1232,10 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static struct task_struct *rcu_boost_task(struct rcu_node *rnp)
 {
+	return NULL;
 }
-
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
 /*
-- 
2.43.0


