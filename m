Return-Path: <linux-kernel+bounces-117601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF788AD08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C93B1C3D196
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF4A1311A5;
	Mon, 25 Mar 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJo9biCV"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C7130AD4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387667; cv=none; b=aqR27DWZCf3P4SbUj5DK/ZzHzHoXvolzG3TsoafM4AVr3DoJQGK7U9WODqtT91ZeA0v4X68vMpg98OgfAb32vrEm7j05WzarYPWGnddMua3zGVTyVVBQo0Otph3jeTDsFinqMa2m5zg1V8E2+8B1Lz+ZrDWmdVOxKwfyW7ZnJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387667; c=relaxed/simple;
	bh=k78/xyNeRm+p5JTWQOob+AJOfSmYtbmPvcai3bGPDYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f/Vy32GoTqJb6xPuSeYIS1Sbs7rbqORlpcfgx7+jsD2oPrAs53fzb4FvKV6SnBn+r5+M1WndkF7OUTgoW8sZQQzNtFDG8UU5VOK7GMyuK19qsMVpuWGUvptcq/xBKrtPAEx9fiOtP/Ahfciu/dnkosKAaudKi7eOMqAbVOwtC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJo9biCV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29b8f702cbfso3404997a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711387665; x=1711992465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYXDvPU+5s3FumCxEyHgAv7m9MtFIzgZjtXbt/l7B3E=;
        b=eJo9biCVBxAzskJaWYFfuXUOwzU0Qe9xf0tWZTC7IYoEZMIbn+bOwxzLCm+lBG/c+y
         R3wiNurBs2SW9Dj5LNs8KRpsPyO/IH6yHeTmSREyIpCod8k1b+jn6o8tlQhc8rngIB+3
         O5pQIiLuRdH0qeBszxuGfF9/AoHnEebCspuYwCKnDAnlpqpOHKKgkVJ4qFJF6kcHodqc
         Lsh1R6Y8rP+S0fRlg9swmsu3aC6w8qC2WgqTBBvpI3qO+ZDbniDlpR1gYzJLdtEZ9d3C
         eNFhEaTF/hs+hpgnQAmLmb57Ir0PUHOCE/GCw6eew1Ceyc+Wqbru0F84bKkDYl7UDm9h
         2sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387665; x=1711992465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYXDvPU+5s3FumCxEyHgAv7m9MtFIzgZjtXbt/l7B3E=;
        b=YzKENjDGVrF/LolRnFGxNAzNTWXDj+BFV3XdXauZLZjAw19HAeDQmbCQO3GxEtRqL1
         G2KbJNrnNDm7D6VUSi0qj86g2VQsJrqPRWrnD1S184nnH+Fat4hh5sqW6sfbdCsLiGUy
         vRFGdVKGps6BPixr0Pd0FIAA9Ly5Wehkw+cFO+lQ/Evd0rI32ucj+AXMuzlHFg4eatUc
         N2OIoEvyrYoNe8ijcXDiHgrq9e//GTs2WUezNZyrgMNl0Blh70QOxY9kgH8b+s+/8S8W
         6M2E0iG1mAjnBcg4WqinqRh8L8+nTTkjjAjh+cDkF0gj8CMd9vJNnYu9Chco6BRSkFu1
         nFBg==
X-Forwarded-Encrypted: i=1; AJvYcCUMbmkF65Eha6TV+HRTXYmcVD1iQmI4ugRv4CZJaFsNBnQoBX0A89MK7+skcBS8pvvwbwnAG2LzEJGyIH56QWRhEsAgaURXv5+GGy7L
X-Gm-Message-State: AOJu0Yw/GPqDTuBsG/lxZua5SRqnVMrk2yDs18aZKB9V/x+5j5APKs2S
	0Hb6D52jAskp8KsAY8pyH8PabeqHXg7nl0m+ULXaHdKeuQf/WDzzZ8N7Y7NFddFyVG5Cy5jmWB9
	oBQIJm660Zh+hue7fNPh4cQ==
X-Google-Smtp-Source: AGHT+IHnCMj4K+ceCrkCTPaNx6/YZeAY1MukLGPRA5Ia+2uNmIgD1Fz+quh85teKWLKttkyfgEqVrvG4ZT+VnA2d4g==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a17:90b:78a:b0:2a0:4e94:3c9 with SMTP
 id l10-20020a17090b078a00b002a04e9403c9mr23042pjz.4.1711387664881; Mon, 25
 Mar 2024 10:27:44 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:27:06 -0700
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325172707.73966-6-peternewman@google.com>
Subject: [PATCH v1 5/6] x86/resctrl: Abstract PQR_ASSOC from generic code
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	James Morse <james.morse@arm.com>
Cc: Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

While CLOSID and RMID originated in RDT, the concept applies to other
architectures, as it's standard to write allocation and monitoring IDs
into per-CPU registers.

 - Rename resctrl_pqr_state and pqr_state to be more
   architecturally-neutral.

 - Introduce resctrl_arch_update_cpu() to replace the explicit write to
   MSR_IA32_PQR_ASSOC in __resctrl_sched_in(). In the case of MPAM,
   PARTID[_I,D] and PMG are a simple function of closid, rmid, and an
   internal global.

 - Update terminology containing explicit references to the PQR_ASSOC
   register.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 11 ++++++++---
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 +++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 +++++++++---------
 include/linux/resctrl.h                   | 11 +++++++++++
 5 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index ae5878d748fc..4cc584754f8b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -37,12 +37,12 @@
 static DEFINE_MUTEX(domain_list_lock);
 
 /*
- * The cached resctrl_pqr_state is strictly per CPU and can never be
+ * The cached resctrl_cpu_state is strictly per CPU and can never be
  * updated from a remote CPU. Functions which modify the state
  * are called with interrupts disabled and no preemption, which
  * is sufficient for the protection.
  */
-DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
+DEFINE_PER_CPU(struct resctrl_cpu_state, resctrl_state);
 
 /*
  * Used to store the max resource name width and max resource data width
@@ -309,6 +309,11 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
+void resctrl_arch_update_cpu(u32 ctrl_id, u32 mon_id)
+{
+	wrmsr(MSR_IA32_PQR_ASSOC, mon_id, ctrl_id);
+}
+
 static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
@@ -598,7 +603,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 static void clear_closid_rmid(int cpu)
 {
-	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
+	struct resctrl_cpu_state *state = this_cpu_ptr(&resctrl_state);
 
 	state->default_group = &rdtgroup_default;
 	state->cur_closid = RESCTRL_RESERVED_CLOSID;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0ba0d2428780..e30f42744ac7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -332,7 +332,7 @@ struct rftype {
 };
 
 /**
- * struct resctrl_pqr_state - State cache for the PQR MSR
+ * struct resctrl_cpu_state - State cache for allocation/monitoring group IDs
  * @cur_rmid:		The cached Resource Monitoring ID
  * @cur_closid:		The cached Class Of Service ID
  * @default_group:	The user assigned rdtgroup
@@ -340,13 +340,13 @@ struct rftype {
  * The cache also helps to avoid pointless updates if the value does
  * not change.
  */
-struct resctrl_pqr_state {
+struct resctrl_cpu_state {
 	u32			cur_rmid;
 	u32			cur_closid;
 	struct rdtgroup		*default_group;
 };
 
-DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
+DECLARE_PER_CPU(struct resctrl_cpu_state, resctrl_state);
 
 /**
  * struct mbm_state - status for each MBM counter in each domain
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 884b88e25141..ca1805a566cb 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -480,8 +480,8 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 */
 	saved_msr = __rdmsr(MSR_MISC_FEATURE_CONTROL);
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
-	closid_p = this_cpu_read(pqr_state.cur_closid);
-	rmid_p = this_cpu_read(pqr_state.cur_rmid);
+	closid_p = this_cpu_read(resctrl_state.cur_closid);
+	rmid_p = this_cpu_read(resctrl_state.cur_rmid);
 	mem_r = plr->kmem;
 	size = plr->size;
 	line_size = plr->line_size;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index badf181c8cbb..bd067f7ed5b6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -112,7 +112,7 @@ void rdt_staged_configs_clear(void)
  * + We can simply set current's closid to assign a task to a resource
  *   group.
  * + Context switch code can avoid extra memory references deciding which
- *   CLOSID to load into the PQR_ASSOC MSR
+ *   CLOSID to load into the CPU
  * - We give up some options in configuring resource groups across multi-socket
  *   systems.
  * - Our choices on how to configure each resource become progressively more
@@ -347,7 +347,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
  */
 void __resctrl_sched_in(struct task_struct *tsk)
 {
-	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
+	struct resctrl_cpu_state *state = this_cpu_ptr(&resctrl_state);
 	u32 closid = state->cur_closid;
 	u32 rmid = state->cur_rmid;
 	struct rdtgroup *rgrp;
@@ -401,7 +401,7 @@ void __resctrl_sched_in(struct task_struct *tsk)
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
 		state->cur_closid = closid;
 		state->cur_rmid = rmid;
-		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
+		resctrl_arch_update_cpu(closid, rmid);
 	}
 }
 
@@ -416,7 +416,7 @@ static void update_cpu_closid_rmid(void *info)
 	struct rdtgroup *r = info;
 
 	if (r)
-		this_cpu_write(pqr_state.default_group, r);
+		this_cpu_write(resctrl_state.default_group, r);
 
 	/*
 	 * We cannot unconditionally write the MSR because the current
@@ -635,8 +635,8 @@ static void rdtgroup_remove(struct rdtgroup *rdtgrp)
 static void _update_task_closid_rmid(void *task)
 {
 	/*
-	 * If the task is still current on this CPU, update PQR_ASSOC MSR.
-	 * Otherwise, the MSR is updated when the task is scheduled in.
+	 * If the task is still current on this CPU, update the current ctrl
+	 * group. Otherwise, the CPU is updated when the task is scheduled in.
 	 */
 	if (task == current)
 		resctrl_sched_in(task);
@@ -3005,7 +3005,7 @@ static void rmdir_all_sub(void)
 		else
 			rdtgroup_remove(rdtgrp);
 	}
-	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
+	/* Update online CPUs to propagate group membership changes. */
 	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
 
 	kernfs_remove(kn_info);
@@ -3688,7 +3688,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 
 	/* Update per cpu rmid of the moved CPUs first */
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		per_cpu(pqr_state.default_group, cpu) = prdtgrp;
+		per_cpu(resctrl_state.default_group, cpu) = prdtgrp;
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
 	 * task running on them.
@@ -3732,7 +3732,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 
 	/* Update per cpu closid and rmid of the moved CPUs first */
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		per_cpu(pqr_state.default_group, cpu) = &rdtgroup_default;
+		per_cpu(resctrl_state.default_group, cpu) = &rdtgroup_default;
 
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b2af1fbc7aa1..a6b1b13cc769 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -306,6 +306,17 @@ extern unsigned int resctrl_rmid_realloc_limit;
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 
+/*
+ * resctrl_arch_update_cpu() - Make control and monitoring group IDs effective
+ *			       on the current CPU
+ *
+ * @ctrl_id:	An identifier for the control group which is to be used on the
+ *		current CPU.
+ * @mon_id:	An identifier for the monitoring group which is to be used on
+ *		the current CPU.
+ */
+void resctrl_arch_update_cpu(u32 ctrl_id, u32 mon_id);
+
 void __resctrl_sched_in(struct task_struct *tsk);
 
 /*
-- 
2.44.0.396.g6e790dbe36-goog


