Return-Path: <linux-kernel+bounces-117602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543788AD0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D7F1C3E4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452BD131BA3;
	Mon, 25 Mar 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieauYavy"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24F130E5D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387669; cv=none; b=B/cHU+hL/42F96ySS2IDIxeVCGaWU9bIkxxMJoVHfcbyl5vQKIavAnsG0HoRp/W7nTOZVnwkWqd1fEf01Q0hMPhDOmzqQNObTFMrXyFffjPh3x0FjpCW8weWikMuvI+xDBZU/5UB3Djuww7hB23FGXgb0YJi/wCYqc0d8Ujc0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387669; c=relaxed/simple;
	bh=yTMbYEK5awdComl/ezDEyjlZWsoayimTaKfd0CBe8zE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VCJK4/5851Ahy4/lY3V70NGY4jS66WpwElB62MiOo41MMYp6a1kKd0ik8UDAlktn5SfNlu3TEPh4OQSwJMnzWk//xGCxoRf7nuprs8YloFxdVQcdgGZTeS56EELZYJ7gfqlfXSlaQpAjwkwIPaNtfyq0XikU6ejJj4kP6fw+a2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ieauYavy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so8683403276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711387666; x=1711992466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa3z2217X6fUx6p/cBiZWKstN9/uVhy7ssYwZcnFGPU=;
        b=ieauYavyZvxryp7MsmLBEGUgJQ4Eiyzz24lxTemWYG27K7NPLTGBU4vfuxh6/vOoqw
         duFzqs47tuEPn0E/ENrX1XDsbkA6uWGeONWdIu5ROtNF85+Box37JCvXIobNOATtIXWr
         LHm3P1DMqaRPah+AxisbFCtPNprRj6LZ0IrlrfaEOp6YdnAiZ4ExxlgIE3So8XJZWQJy
         2CiK0TIDeD+CwbTQTPZECRTfCT6r7R0Ah2u6vjob8BkElunsT2yhiBYSCfa0qhNOYMx7
         +Q7hqdk3T8xEdp2C29s6s52AR2Y28KLaPTzmt3QV94aZeALo/nr1KTlWJ6efqjtp1uPq
         pI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387666; x=1711992466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa3z2217X6fUx6p/cBiZWKstN9/uVhy7ssYwZcnFGPU=;
        b=p+lhhojV/ZNt3RBq/cQ4jVENy1wiKA6l9os7SJ15q0Q1Em7MAEeLWVmThuwwp3zcY4
         kzo9BrOjboGa/GB8qyWDnK57oxy7yy6qo8HJ7SDdgSyBKk1GV506PsgDQ6/21GH4ev4a
         a4niUu7V5kGQ+4Ne1eR3WkbYD3flpcs5a+xMfn7WbGLt4tTlaCDyorRlaDECXHUzsh+x
         mShrQzZ6juOyxn8DfphlEKc1r9qJSDZN8ElbZczm/Lkk2AnB0UmPauN9fRQ27Et02hcc
         d5vEzlmEG8HD13zKTPzdUspiQisYZxk1PUYNOdVBBaPPf8ULe0X4rl/g4uMCLmLvHMoP
         oBVw==
X-Forwarded-Encrypted: i=1; AJvYcCVGJvo9EjcpPHNRzrX6KpUksz5TDuqyeSmMtryTcuRqSE0T0BGsAW6PF3j82PlNRdG09LbeWpkqL832B1CHVA4FJS7kewX0p42hLg27
X-Gm-Message-State: AOJu0YwaDrD9RAu0S3US8T30A8ILTssXlt18+muHIcLjy09kO1Xloh1B
	xralWucySkCD16Wv5XoPq1Ph4eFUZfEYx6Podhc09JIFg4h1W9b5NHTV3svH2ngNx73Muxa1wEm
	YVi2BYJ+ViFMKuJa4ay/s6g==
X-Google-Smtp-Source: AGHT+IFgPlsoAE7hzmPfMTQGoYJe+yF0pzDalzKIKtFe75F+KyuVHePFsmRXYPtOcPxVj2mEZeHNwJ9LsbctE9XPDw==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a05:6902:2388:b0:dcc:5a91:aee9 with
 SMTP id dp8-20020a056902238800b00dcc5a91aee9mr2359571ybb.7.1711387666713;
 Mon, 25 Mar 2024 10:27:46 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:27:07 -0700
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325172707.73966-7-peternewman@google.com>
Subject: [PATCH v1 6/6] x86/resctrl: Don't search tasklist in mongroup rename
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

Iterating over all task_structs while read-locking the tasklist_lock
results in significant task creation/destruction latency. Back-to-back
move operations can thus be disastrous to the responsiveness of
threadpool-based services.

Now that the CLOSID is determined indirectly through a reference to the
task's current rdtgroup, it is not longer necessary to update the CLOSID
in all tasks belonging to the moved mongroup. The context switch handler
just needs to be prepared for concurrent writes to the parent pointer.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 +++++++-------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bd067f7ed5b6..a007c0ec478f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -388,8 +388,11 @@ void __resctrl_sched_in(struct task_struct *tsk)
 				 * by a full barrier and synchronous IPI
 				 * broadcast before proceeding to free the
 				 * group.
+				 *
+				 * parent can be concurrently updated to a new
+				 * group as a result of mongrp_reparent().
 				 */
-				closid = rgrp->mon.parent->closid;
+				closid = READ_ONCE(rgrp->mon.parent)->closid;
 		} else {
 			closid = rgrp->closid;
 		}
@@ -3809,8 +3812,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
  * Monitoring data for the group is unaffected by this operation.
  */
 static void mongrp_reparent(struct rdtgroup *rdtgrp,
-			    struct rdtgroup *new_prdtgrp,
-			    cpumask_var_t cpus)
+			    struct rdtgroup *new_prdtgrp)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
 
@@ -3825,13 +3827,10 @@ static void mongrp_reparent(struct rdtgroup *rdtgrp,
 	list_move_tail(&rdtgrp->mon.crdtgrp_list,
 		       &new_prdtgrp->mon.crdtgrp_list);
 
-	rdtgrp->mon.parent = new_prdtgrp;
+	WRITE_ONCE(rdtgrp->mon.parent, new_prdtgrp);
 	rdtgrp->closid = new_prdtgrp->closid;
 
-	/* Propagate updated closid to all tasks in this group. */
-	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
-
-	update_closid_rmid(cpus, NULL);
+	update_closid_rmid(cpu_online_mask, NULL);
 }
 
 static int rdtgroup_rename(struct kernfs_node *kn,
@@ -3839,7 +3838,6 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 {
 	struct rdtgroup *new_prdtgrp;
 	struct rdtgroup *rdtgrp;
-	cpumask_var_t tmpmask;
 	int ret;
 
 	rdtgrp = kernfs_to_rdtgroup(kn);
@@ -3909,16 +3907,6 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 		goto out;
 	}
 
-	/*
-	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
-	 * possibility of failing to allocate it after kernfs_rename() has
-	 * succeeded.
-	 */
-	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	/*
 	 * Perform all input validation and allocations needed to ensure
 	 * mongrp_reparent() will succeed before calling kernfs_rename(),
@@ -3927,9 +3915,7 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 	 */
 	ret = kernfs_rename(kn, new_parent, new_name);
 	if (!ret)
-		mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
-
-	free_cpumask_var(tmpmask);
+		mongrp_reparent(rdtgrp, new_prdtgrp);
 
 out:
 	mutex_unlock(&rdtgroup_mutex);
-- 
2.44.0.396.g6e790dbe36-goog


