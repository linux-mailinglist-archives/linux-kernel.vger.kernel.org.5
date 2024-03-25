Return-Path: <linux-kernel+bounces-117600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009EC88AD07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241141C3D44E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72E130E5C;
	Mon, 25 Mar 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LJf2Qon"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27B12FF80
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387666; cv=none; b=bSTDJwRcqLwBXYzKmrUbN4o/mn9JBei29HfoK9UI9xTV7QsKK98lISxIaVaesbhM6wi4GQHXC67ne/dUEfSYkGfrbRZlwGTvCd4mOqNrPPr1LUwvzVYSyN+Cv0aBNUWu8EMP+3YRXzT6wb7Mj15ySgYpOACdMAehuY6/u866828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387666; c=relaxed/simple;
	bh=l1cLPXEzd5BiKD1kOwyPdTIzc6MWvbUhAo2KrNl0sAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DLYJQzgtw79t3tgFNxv+llWb+viOlNqZFGwF7exx66ovO+m4+gSeLEG1Qc56L1a5w1s/A+TSNi8iiGw07UcEofJV+wE7tR0LPjz3Krl/t0ZhoIKANvyC++KPnUo9cPae2GUQg6iI/Xfnn1gmUcjrswZICOJwH/WayirAilFJjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LJf2Qon; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso6575554276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711387663; x=1711992463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OsE8zjKMOb7QWxDzxIqnVKWQWwrvLnNjjLQEcIFHUQ=;
        b=2LJf2QoneFnznj6mw05ClVtkmzYODZifbmrY3cLA5qf5hvUONh+Bf65dOPmy8aBJCS
         6uEJlfmONuzX9yjLHrgSGunyp2B+zJVDIXorn2otJOsvNvJIll0rFCWuiymhpYm1D+Ny
         JPxdo7zs4tg9vgbhJPZPcCGIp7+raVQNSreym1Ps5FxcyQ4A5bGHUWbJql94REx6YSZ4
         IxB9v3j5+X2/PDq9/kCWN2CTblcw+8Q97Bkn5M2h/GXNEL3ydEbKVsM91T3Gp6AMEnci
         qkoP9ZUXf+q4XrWP1HrDLLs4y5XnlU2tfaQP99lbVLvKg0CZDmt89rEBCmg72IVUtRRf
         C2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387663; x=1711992463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OsE8zjKMOb7QWxDzxIqnVKWQWwrvLnNjjLQEcIFHUQ=;
        b=PRJHEn+vea3cr3LDxu7215mcrgNShVgnVn2n2Z7haFd/W/q2RayF1HJemiLQHdnT9G
         uUo+2dHqFPJJNhLAlTiOhBoK6LDhPuKqNSxzq14nAkOExiBiaeyKrMvHS9wJ1wcsD1Sq
         7Z62y3yoekzTMwXphNJ581a07iNySqZgzNmbEGWIvcqfaV5IOe/WrgcalkkOm5Ykxpww
         ZejUqE1EWAfcni14QrcYBObE4prO7HhO9X+MISMDZKQpCdI7w5m9a5N3utZHO8PruKy5
         2US0UpS+QDDaqApAYfrn7jEPikMmuxCnNITK3UxIeEDiTFM40OKLbTpvff1zQevdjKXe
         8Xfg==
X-Forwarded-Encrypted: i=1; AJvYcCV4H/bQVspqcBuh8aWMR54vqk4GQDGdeBvqP4AQbVQmpJGKqAWn9Q0PTlvVvH/SpxPDXbg0bPwAT72ECUPQdJIR/ODFWtjcWdVbyH52
X-Gm-Message-State: AOJu0YxdXy/r5Jjdd5xDupgUIddPEVTZf19TXBYrgAmQZi+OzvJ8uoH7
	hyw7FySTlPWCs9eS6pHEWJ632fGY+EbPe1GXoD75bikLet8rqlLGWvxCZiHGjFCauhhbVrX5hFW
	i28BcPm8fdNnN4NZ5GDIxew==
X-Google-Smtp-Source: AGHT+IHcOU3kC4lTU+U9SgE+eejDP+mmufYh/KPQ87GtHJN4eZ2VWej068MZ7ayn5BbE6AKTXNJbvcjxVAWBsnUQXw==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a05:6902:2508:b0:dc6:c2e4:5126 with
 SMTP id dt8-20020a056902250800b00dc6c2e45126mr2433941ybb.12.1711387663293;
 Mon, 25 Mar 2024 10:27:43 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:27:05 -0700
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325172707.73966-5-peternewman@google.com>
Subject: [PATCH v1 4/6] x86/resctrl: Use rdtgroup pointer to indicate task membership
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

Caching the CLOSID and RMID values in all member tasks makes changing
either ID for a group expensive, as all task_structs must be inspected
while read-locking the tasklist_lock.

A single rdtgroup reference from the task_struct can indicate the
mongroup and ctrl group membership of a task. In the case of mongroups,
the parent pointer can be used to determine the CLOSID indirectly,
avoiding the need for invalidating a cached CLOSID in all task_structs.

This also solves the problem of tearing PARTID/PMG values in MPAM, as
the parent pointer of a mongroup does not change. Therefore an atomic
read of the rdt_group pointer provides a consistent view of current
mongroup and control group membership, making __resctrl_sched_in()
portable.

Care must be taken to ensure that __resctrl_sched_in() does not
dereference a pointer to a freed rdtgroup struct. Tasks may no longer be
reachable via for_each_process_thread() but can still be switched in, so
update the rdt_group pointer before the thread is removed from the
tasklist.

Co-developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/include/asm/resctrl.h         |  18 ---
 arch/x86/kernel/cpu/resctrl/core.c     |   3 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  13 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 205 +++++++++++++------------
 include/linux/sched.h                  |   3 +-
 5 files changed, 110 insertions(+), 132 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 99ba8c0dc155..be4afbc6180f 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -64,24 +64,6 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 	return val * scale;
 }
 
-static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
-						u32 closid, u32 rmid)
-{
-	WRITE_ONCE(tsk->closid, closid);
-	WRITE_ONCE(tsk->rmid, rmid);
-}
-
-static inline bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
-{
-	return READ_ONCE(tsk->closid) == closid;
-}
-
-static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
-					   u32 rmid)
-{
-	return READ_ONCE(tsk->rmid) == rmid;
-}
-
 static inline u32 resctrl_arch_system_num_rmid_idx(void)
 {
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e40341583e..ae5878d748fc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -600,8 +600,7 @@ static void clear_closid_rmid(int cpu)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 
-	state->default_closid = RESCTRL_RESERVED_CLOSID;
-	state->default_rmid = RESCTRL_RESERVED_RMID;
+	state->default_group = &rdtgroup_default;
 	state->cur_closid = RESCTRL_RESERVED_CLOSID;
 	state->cur_rmid = RESCTRL_RESERVED_RMID;
 	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 56a68e542572..0ba0d2428780 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -334,14 +334,8 @@ struct rftype {
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
- * @cur_closid:	The cached Class Of Service ID
- * @default_rmid:	The user assigned Resource Monitoring ID
- * @default_closid:	The user assigned cached Class Of Service ID
- *
- * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
- * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
- * contains both parts, so we need to cache them. This also
- * stores the user configured per cpu CLOSID and RMID.
+ * @cur_closid:		The cached Class Of Service ID
+ * @default_group:	The user assigned rdtgroup
  *
  * The cache also helps to avoid pointless updates if the value does
  * not change.
@@ -349,8 +343,7 @@ struct rftype {
 struct resctrl_pqr_state {
 	u32			cur_rmid;
 	u32			cur_closid;
-	u32			default_rmid;
-	u32			default_closid;
+	struct rdtgroup		*default_group;
 };
 
 DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8d6979dbfd02..badf181c8cbb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -348,25 +348,55 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 void __resctrl_sched_in(struct task_struct *tsk)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
-	u32 closid = state->default_closid;
-	u32 rmid = state->default_rmid;
-	u32 tmp;
+	u32 closid = state->cur_closid;
+	u32 rmid = state->cur_rmid;
+	struct rdtgroup *rgrp;
 
 	/*
-	 * If this task has a closid/rmid assigned, use it.
-	 * Else use the closid/rmid assigned to this cpu.
+	 * A task's group assignment can change concurrently, but the CLOSID or
+	 * RMID assigned to a group cannot change.
 	 */
+	rgrp = READ_ONCE(tsk->rdt_group);
+	if (!rgrp || rgrp == &rdtgroup_default)
+		/*
+		 * If this task is a member of a control or monitoring group,
+		 * use the IDs assigned to these groups. Else use the
+		 * closid/rmid assigned to this cpu.
+		 */
+		rgrp = state->default_group;
+
+	/*
+	 * Context switches are possible before the cpuonline handler
+	 * initializes default_group.
+	 */
+	if (!rgrp)
+		rgrp = &rdtgroup_default;
+
 	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		tmp = READ_ONCE(tsk->closid);
-		if (tmp)
-			closid = tmp;
+		/*
+		 * If the task is assigned to a monitoring group, the CLOSID is
+		 * determined by the parent control group.
+		 */
+		if (rgrp->type == RDTMON_GROUP) {
+			if (!WARN_ON(!rgrp->mon.parent))
+				/*
+				 * The parent rdtgroup cannot be freed until
+				 * after the mon group is freed. In the event
+				 * that the parent rdtgroup is removed (by
+				 * rdtgroup_rmdir_ctrl()), rdt_mon_group would
+				 * be redirected to rdtgroup_default, followed
+				 * by a full barrier and synchronous IPI
+				 * broadcast before proceeding to free the
+				 * group.
+				 */
+				closid = rgrp->mon.parent->closid;
+		} else {
+			closid = rgrp->closid;
+		}
 	}
 
-	if (static_branch_likely(&rdt_mon_enable_key)) {
-		tmp = READ_ONCE(tsk->rmid);
-		if (tmp)
-			rmid = tmp;
-	}
+	if (static_branch_likely(&rdt_mon_enable_key))
+		rmid = rgrp->mon.rmid;
 
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
 		state->cur_closid = closid;
@@ -385,10 +415,8 @@ static void update_cpu_closid_rmid(void *info)
 {
 	struct rdtgroup *r = info;
 
-	if (r) {
-		this_cpu_write(pqr_state.default_closid, r->closid);
-		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
-	}
+	if (r)
+		this_cpu_write(pqr_state.default_group, r);
 
 	/*
 	 * We cannot unconditionally write the MSR because the current
@@ -624,49 +652,61 @@ static void update_task_closid_rmid(struct task_struct *t)
 
 static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
 {
-	u32 closid, rmid = rdtgrp->mon.rmid;
+	struct rdtgroup *task_group = READ_ONCE(tsk->rdt_group);
 
-	if (rdtgrp->type == RDTCTRL_GROUP)
-		closid = rdtgrp->closid;
-	else if (rdtgrp->type == RDTMON_GROUP)
-		closid = rdtgrp->mon.parent->closid;
-	else
-		return false;
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* Uninitalized rdt_group pointer implies rdtgroup_default. */
+	if (!task_group)
+		task_group = &rdtgroup_default;
+
+	if (rdtgrp == task_group)
+		return true;
+
+	/* Tasks in child mongroups are members of the parent ctrlmon group. */
+	if (task_group->type == RDTMON_GROUP &&
+	    task_group->mon.parent == rdtgrp)
+		return true;
 
-	return resctrl_arch_match_closid(tsk, closid) &&
-	       resctrl_arch_match_rmid(tsk, closid, rmid);
+	return false;
 }
 
 static int __rdtgroup_move_task(struct task_struct *tsk,
 				struct rdtgroup *rdtgrp)
 {
+	struct rdtgroup *task_group = READ_ONCE(tsk->rdt_group);
+
 	/* If the task is already in rdtgrp, no need to move the task. */
 	if (task_in_rdtgroup(tsk, rdtgrp))
 		return 0;
 
 	/*
-	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
-	 * updated by them.
+	 * NULL is used in the task_struct so it can be overridden by a CPU's
+	 * default_group
+	 */
+	if (!task_group)
+		task_group = &rdtgroup_default;
+
+	/*
+	 * Set the task's group before the CPU can be updated by them.
 	 *
 	 * For ctrl_mon groups, move both closid and rmid.
 	 * For monitor groups, can move the tasks only from
-	 * their parent CTRL group.
+	 * their parent CTRL group or another mon group under the same parent.
 	 */
-	if (rdtgrp->type == RDTMON_GROUP &&
-	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
+	if (rdtgrp->type == RDTCTRL_GROUP) {
+		WRITE_ONCE(tsk->rdt_group, rdtgrp);
+	} else if (rdtgrp->type == RDTMON_GROUP &&
+		   (task_group == rdtgrp->mon.parent ||
+		    task_group->mon.parent == rdtgrp->mon.parent)) {
+		WRITE_ONCE(tsk->rdt_group, rdtgrp);
+	} else {
 		rdt_last_cmd_puts("Can't move task to different control group\n");
 		return -EINVAL;
 	}
 
-	if (rdtgrp->type == RDTMON_GROUP)
-		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
-					     rdtgrp->mon.rmid);
-	else
-		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
-					     rdtgrp->mon.rmid);
-
 	/*
-	 * Ensure the task's closid and rmid are written before determining if
+	 * Ensure the task's group is written before determining if
 	 * the task is current that will decide if it will be interrupted.
 	 * This pairs with the full barrier between the rq->curr update and
 	 * resctrl_sched_in() during context switch.
@@ -684,19 +724,6 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return 0;
 }
 
-static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
-		resctrl_arch_match_closid(t, r->closid));
-}
-
-static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
-		resctrl_arch_match_rmid(t, r->mon.parent->closid,
-					r->mon.rmid));
-}
-
 /**
  * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
  * @r: Resource group
@@ -712,7 +739,7 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
+		if (task_in_rdtgroup(t, r)) {
 			ret = 1;
 			break;
 		}
@@ -830,7 +857,7 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
+		if (task_in_rdtgroup(t, r)) {
 			pid = task_pid_vnr(t);
 			if (pid)
 				seq_printf(s, "%d\n", pid);
@@ -924,53 +951,34 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		      struct pid *pid, struct task_struct *tsk)
 {
 	struct rdtgroup *rdtg;
-	int ret = 0;
-
-	mutex_lock(&rdtgroup_mutex);
+	struct rdtgroup *crg;
+	struct rdtgroup *mrg;
 
 	/* Return empty if resctrl has not been mounted. */
 	if (!resctrl_mounted) {
 		seq_puts(s, "res:\nmon:\n");
-		goto unlock;
+		return 0;
 	}
 
-	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
-		struct rdtgroup *crg;
+	mutex_lock(&rdtgroup_mutex);
 
-		/*
-		 * Task information is only relevant for shareable
-		 * and exclusive groups.
-		 */
-		if (rdtg->mode != RDT_MODE_SHAREABLE &&
-		    rdtg->mode != RDT_MODE_EXCLUSIVE)
-			continue;
+	rdtg = READ_ONCE(tsk->rdt_group);
+	if (!rdtg)
+		rdtg = &rdtgroup_default;
 
-		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
-			continue;
+	mrg = rdtg;
+	crg = rdtg;
+	if (rdtg->type == RDTMON_GROUP)
+		crg = rdtg->mon.parent;
+
+	seq_printf(s, "res:%s%s\n", (crg == &rdtgroup_default) ? "/" : "",
+		   crg->kn->name);
+	seq_printf(s, "mon:%s%s\n", (mrg == &rdtgroup_default) ? "/" : "",
+		   mrg->kn->name);
 
-		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
-			   rdtg->kn->name);
-		seq_puts(s, "mon:");
-		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
-				    mon.crdtgrp_list) {
-			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
-						     crg->mon.rmid))
-				continue;
-			seq_printf(s, "%s", crg->kn->name);
-			break;
-		}
-		seq_putc(s, '\n');
-		goto unlock;
-	}
-	/*
-	 * The above search should succeed. Otherwise return
-	 * with an error.
-	 */
-	ret = -ENOENT;
-unlock:
 	mutex_unlock(&rdtgroup_mutex);
 
-	return ret;
+	return 0;
 }
 #endif
 
@@ -2904,13 +2912,11 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(p, t) {
-		if (!from || is_closid_match(t, from) ||
-		    is_rmid_match(t, from)) {
-			resctrl_arch_set_closid_rmid(t, to->closid,
-						     to->mon.rmid);
+		if (!from || task_in_rdtgroup(t, from)) {
+			WRITE_ONCE(t->rdt_group, to);
 
 			/*
-			 * Order the closid/rmid stores above before the loads
+			 * Order the group store above before the loads
 			 * in task_curr(). This pairs with the full barrier
 			 * between the rq->curr update and resctrl_sched_in()
 			 * during context switch.
@@ -2939,6 +2945,7 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
  */
 void exit_resctrl(struct task_struct *tsk)
 {
+	WRITE_ONCE(tsk->rdt_group, &rdtgroup_default);
 }
 
 static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
@@ -3681,7 +3688,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 
 	/* Update per cpu rmid of the moved CPUs first */
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
+		per_cpu(pqr_state.default_group, cpu) = prdtgrp;
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
 	 * task running on them.
@@ -3724,10 +3731,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
 	/* Update per cpu closid and rmid of the moved CPUs first */
-	for_each_cpu(cpu, &rdtgrp->cpu_mask) {
-		per_cpu(pqr_state.default_closid, cpu) = rdtgroup_default.closid;
-		per_cpu(pqr_state.default_rmid, cpu) = rdtgroup_default.mon.rmid;
-	}
+	for_each_cpu(cpu, &rdtgrp->cpu_mask)
+		per_cpu(pqr_state.default_group, cpu) = &rdtgroup_default;
 
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..d07d7a80006b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1236,8 +1236,7 @@ struct task_struct {
 	struct list_head		cg_list;
 #endif
 #ifdef CONFIG_X86_CPU_RESCTRL
-	u32				closid;
-	u32				rmid;
+	struct rdtgroup			*rdt_group;
 #endif
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
-- 
2.44.0.396.g6e790dbe36-goog


