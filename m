Return-Path: <linux-kernel+bounces-105378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4617387DD10
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CFD1F213E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7561AACB;
	Sun, 17 Mar 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+dQBm9S"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8063BF;
	Sun, 17 Mar 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710675510; cv=none; b=iJPA+4XDFY2JWQmBFWuaY1xWlo20ifWJKtIpExFhRHjTabFIOQTiSEDzsNSgJl3r4Gg2IERrinU/hwglmm1CVzm9EiktjH34m60YbjIF0Hr2/yr78hY5vsrrmLWonEnXi1MLbNPk9VNASeTrpaPMxOCBllAjHomcV+ZV0XIMXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710675510; c=relaxed/simple;
	bh=tYcMPZ7zJjxtwuj8HFC2FsRjbac76kluNtGY1VE+Pag=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lf+1Rz+xiUMEDM7WZe+pECUJudH2QCNGhH5/BFEYfi7xjseBxiSLtPe0CJE/8HBAOmxT7zINyMeidrk4LLjq/OA2YTME6QEmXaCklMr11uJ091IOp/340R8hp/badjgBZUnP7JxjEJbu+giw1yAW6iH0PEyU+Uv86EmPP9eQ49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+dQBm9S; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a496fde460so538081eaf.1;
        Sun, 17 Mar 2024 04:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710675507; x=1711280307; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4KA0EFwWdVp5/tT7XS37xOqKZ+ls9/0QsFS2P56u/I=;
        b=G+dQBm9SOOZ85hz3ogL7i7g2PcD/udhTbVVshVrMHGzJSKgnRIzR8eDFm/yRvm5yxP
         f2UivC+oNQr7QVnvqkPHfw4GXyHbY2uKwFt36kQ3fHM/Yyq9q3EZXJKuJfcMgN9dimck
         jI7Vbb3zRMw3Kuin2jQ4fA0ZCO4XCd84A6P8YWPNBhNftSanRC/hqjQOqNHwJokBmch0
         5RIxQp+WVbcIlONsjMRa5et/CBER9Nfw4nn11vjlfcjD4WBy7xspgRB7yYcqcp6khqRT
         e7A/freAfR7ciG7szvud2IdyTYYO10Coslr/quWlF58hB2jq7KFskCbQ/3An6s+stFk0
         tx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710675507; x=1711280307;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4KA0EFwWdVp5/tT7XS37xOqKZ+ls9/0QsFS2P56u/I=;
        b=tcTpa8538WrIct/TCBrMgLee+0wY0PuyCs331Be/OehPsWzkoaF42anniJ6WeC8Myx
         7lk/v9V/yf4bFM8upKzmCVQ/gyEiG+KIBPirYPz6xkL/7xpl22jQoV4uXvHuWLfojblp
         D3A01P+gzCqxkwH2dJEUTe6PSYbjwHuqdK/Ub0WYXfgLR28GtxTrPwTA31GLyjEY5NIj
         y03Ev444AhpirHHd7Cfo1usDhSWEoOdImxWt0JtezmwmjRi4I66rcusxBSMTGRAbX2cO
         U33RwemVkZYqxMVJBAbL7vay4x5iqrQQPB89YEO4/dGCqoYpE5cSdZx+h2QHfSiZ2jrg
         IZJg==
X-Forwarded-Encrypted: i=1; AJvYcCWP2empp1pQuyGLetz9gbOA+v8QPCKtmvJ2TdgT5b/v6dDWWGm+PMCGUiLN6Ncsp72sOgEU4V8K3TJShVMBKmM6ngjB5AICebVyh+EQ5HbWjD5zNpsD7wvZixVAc/jiawVQ
X-Gm-Message-State: AOJu0YxWeArI2PrBIrIMbTybg8HjAtkSMEoUXKGFYqz4y5RHmTOHvi4I
	tGi+z7sKoU4qRiDTjNOdOZxjIxKTNJ1FV6q7ieUs6CcAS78Eb4tq
X-Google-Smtp-Source: AGHT+IFBsEAr3jxlXCoZHvU2NwTknb7DTHam44wtQnPa+t+W0z8kDScycLXfABB0q70xq8qXfl7Paw==
X-Received: by 2002:a05:6358:52cd:b0:17e:8b5d:c7af with SMTP id z13-20020a05635852cd00b0017e8b5dc7afmr7549204rwz.30.1710675503483;
        Sun, 17 Mar 2024 04:38:23 -0700 (PDT)
Received: from localhost.localdomain ([120.244.140.115])
        by smtp.gmail.com with ESMTPSA id ph4-20020a17090b3bc400b0029f6eb4c14asm2285505pjb.5.2024.03.17.04.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 04:38:23 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcutorture: Make rcutorture support print rcu-tasks gp state
Date: Sun, 17 Mar 2024 19:38:11 +0800
Message-Id: <20240317113811.8085-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit make rcu-tasks related rcutorture test support rcu-tasks
gp state printing when the writer stall occurs or the at the end of
rcutorture test, and generate rcu_ops->get_gp_data() operation to
simplify the acquisition of gp state for different types of rcutorture
tests.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 
[   47.582683] rcu:  Start-test grace-period state: g4313 f0x0
[   73.780444] rcu:  End-test grace-period state: g15728 f0x0 total-gps=2854

[   99.013921] srcu:  Start-test grace-period state: g0 f0x0
[  126.596727] srcu:  End-test grace-period state: g10292 f0x0 total-gps=10292

[  175.664991] srcud:  Start-test grace-period state: g0 f0x0
[  195.012774] srcud:  End-test grace-period state: g7628 f0x0 total-gps=7628

[  216.943521] tasks:  Start-test grace-period state: g8 f0x0
[  234.245093] tasks:  End-test grace-period state: g300 f0x0 total-gps=292

[  267.139368] tasks-rude:  Start-test grace-period state: g8 f0x0
[  296.132748] tasks-rude:  End-test grace-period state: g684 f0x0 total-gps=676

[  316.044241] tasks-tracing:  Start-test grace-period state: g8 f0x0
[  342.020447] tasks-tracing:  End-test grace-period state: g348 f0x0 total-gps=340

 kernel/rcu/rcu.h        | 20 ++++++++++----------
 kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++--------
 kernel/rcu/srcutree.c   |  5 +----
 kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
 kernel/rcu/tree.c       | 13 +++----------
 5 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 86fce206560e..38238e595a61 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -522,12 +522,18 @@ static inline void show_rcu_tasks_gp_kthreads(void) {}
 
 #ifdef CONFIG_TASKS_RCU
 struct task_struct *get_rcu_tasks_gp_kthread(void);
+void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RCU
 
 #ifdef CONFIG_TASKS_RUDE_RCU
 struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
+void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RUDE_RCU
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
+#endif
+
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void tasks_cblist_init_generic(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
@@ -557,8 +563,7 @@ static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
 #endif
 
 #if defined(CONFIG_TREE_RCU)
-void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gp_seq);
+void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq);
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
 			       unsigned long secs,
@@ -566,8 +571,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
 #else
-static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
-					  int *flags, unsigned long *gp_seq)
+static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
 	*flags = 0;
 	*gp_seq = 0;
@@ -587,20 +591,16 @@ static inline void rcu_gp_set_torture_wait(int duration) { }
 
 #ifdef CONFIG_TINY_SRCU
 
-static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
-					   struct srcu_struct *sp, int *flags,
+static inline void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 					   unsigned long *gp_seq)
 {
-	if (test_type != SRCU_FLAVOR)
-		return;
 	*flags = 0;
 	*gp_seq = sp->srcu_idx;
 }
 
 #elif defined(CONFIG_TREE_SRCU)
 
-void srcutorture_get_gp_data(enum rcutorture_type test_type,
-			     struct srcu_struct *sp, int *flags,
+void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 			     unsigned long *gp_seq);
 
 #endif
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2f43d31fb7a5..2e8a037072eb 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -381,6 +381,7 @@ struct rcu_torture_ops {
 	void (*gp_kthread_dbg)(void);
 	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
+	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
 	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
+	.get_gp_data		= rcutorture_get_gp_data,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -612,6 +614,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.sync		= synchronize_rcu_busted,
 	.exp_sync	= synchronize_rcu_busted,
 	.call		= call_rcu_busted,
+	.get_gp_data	= NULL,
 	.cb_barrier	= NULL,
 	.fqs		= NULL,
 	.stats		= NULL,
@@ -628,6 +631,11 @@ static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
 
+static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	srcutorture_get_gp_data(srcu_ctlp, flags, gp_seq);
+}
+
 static int srcu_torture_read_lock(void)
 {
 	if (cur_ops == &srcud_ops)
@@ -736,6 +744,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.get_gp_data	= srcu_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
@@ -774,6 +783,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.get_gp_data	= srcu_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
@@ -796,6 +806,7 @@ static struct rcu_torture_ops busted_srcud_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.get_gp_data	= NULL,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.extendables	= RCUTORTURE_MAX_EXTEND,
@@ -838,6 +849,7 @@ static struct rcu_torture_ops trivial_ops = {
 	.get_gp_seq	= rcu_no_completed,
 	.sync		= synchronize_rcu_trivial,
 	.exp_sync	= synchronize_rcu_trivial,
+	.get_gp_data	= NULL,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -882,6 +894,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
 	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
+	.get_gp_data	= rcu_tasks_get_gp_data,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -922,6 +935,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.call		= call_rcu_tasks_rude,
 	.cb_barrier	= rcu_barrier_tasks_rude,
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
+	.get_gp_data	= rcu_tasks_rude_get_gp_data,
 	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
@@ -974,6 +988,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
+	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
@@ -2264,10 +2279,8 @@ rcu_torture_stats_print(void)
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
-		rcutorture_get_gp_data(cur_ops->ttype,
-				       &flags, &gp_seq);
-		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
-					&flags, &gp_seq);
+		if (cur_ops->get_gp_data)
+			cur_ops->get_gp_data(&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
 		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
 			 rcu_torture_writer_state_getname(),
@@ -3390,8 +3403,8 @@ rcu_torture_cleanup(void)
 		fakewriter_tasks = NULL;
 	}
 
-	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
-	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	if (cur_ops->get_gp_data)
+		cur_ops->get_gp_data(&flags, &gp_seq);
 	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
 		 cur_ops->name, (long)gp_seq, flags,
 		 rcutorture_seq_diff(gp_seq, start_gp_seq));
@@ -3762,8 +3775,8 @@ rcu_torture_init(void)
 			nrealreaders = 1;
 	}
 	rcu_torture_print_module_parms(cur_ops, "Start of test");
-	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
-	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	if (cur_ops->get_gp_data)
+		cur_ops->get_gp_data(&flags, &gp_seq);
 	start_gp_seq = gp_seq;
 	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
 		 cur_ops->name, (long)gp_seq, flags);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d19326486edd..98f79ba01b0a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1828,12 +1828,9 @@ static void process_srcu(struct work_struct *work)
 	srcu_reschedule(ssp, curdelay);
 }
 
-void srcutorture_get_gp_data(enum rcutorture_type test_type,
-			     struct srcu_struct *ssp, int *flags,
+void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
 			     unsigned long *gp_seq)
 {
-	if (test_type != SRCU_FLAVOR)
-		return;
 	*flags = 0;
 	*gp_seq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
 }
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e83adcdb49b5..e7ac9138a4fd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1182,6 +1182,13 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
 
+void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_get_gp_data);
+
 /*
  * Protect against tasklist scan blind spot while the task is exiting and
  * may be removed from the tasklist.  Do this by adding the task to yet
@@ -1361,6 +1368,13 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_rude_gp_kthread);
 
+void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
+
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
@@ -2020,6 +2034,13 @@ struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
 
+void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
+
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..e229a12afe31 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -539,17 +539,10 @@ static struct rcu_node *rcu_get_root(void)
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
-void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gp_seq)
+void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
-	switch (test_type) {
-	case RCU_FLAVOR:
-		*flags = READ_ONCE(rcu_state.gp_flags);
-		*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
-		break;
-	default:
-		break;
-	}
+	*flags = READ_ONCE(rcu_state.gp_flags);
+	*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-- 
2.17.1


