Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E647C7C42E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbjJJVsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjJJVr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:47:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E99D;
        Tue, 10 Oct 2023 14:47:57 -0700 (PDT)
Date:   Tue, 10 Oct 2023 21:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696974475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tRgx0NgEWbnKaIyfT7MQOZy7+jU+cp321G8t8i+uss=;
        b=ppcMjILeuqgxp4slR38RNO1u8SgT90uIAoRyS9qME+CnlfMBpeuCHDhmmk1PHgOvhiZkgc
        62EuOHoq+rAoBMrNshq+W30UoJoONk/LggTlQfUvOZ80p1rwrf/Z6o48tmLQ9/6H0sg3Qy
        FplkLv9Dkt7AmHqj/cpWJRcSVjIA/B+MraDDBBCV08uShVXRbCifvkdE9x0V2zp/npBWKA
        z3JE7yBL4hMOlepZsKkZsVLmVgwJOw1aZx9t8ubbyeiqI5vgqqYuFjL8DTuVWCU8s9s6Q5
        zKBou8YYtWX8nDdKqZbpaUOqdhY3Hzy/3hzdtXDxxxaeIaKNmWj3AmJTrdECeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696974475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tRgx0NgEWbnKaIyfT7MQOZy7+jU+cp321G8t8i+uss=;
        b=OdWC7VLiOfZjISR4Uw9bforEJ3SGXSyaIQ0tT/V+58x7Wb32vVeBFgdtS/GOWz7c1D0NSD
        2vUAycOmZLedhNBw==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Complete scanning of partial VMAs
 regardless of PID activity
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Raghavendra K T <raghavendra.kt@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010083143.19593-6-mgorman@techsingularity.net>
References: <20231010083143.19593-6-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <169697447487.3135.12299717344024056092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b7a5b537c55c088d891ae554103d1b281abef781
Gitweb:        https://git.kernel.org/tip/b7a5b537c55c088d891ae554103d1b281abef781
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 10 Oct 2023 09:31:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 23:41:47 +02:00

sched/numa: Complete scanning of partial VMAs regardless of PID activity

NUMA Balancing skips VMAs when the current task has not trapped a NUMA
fault within the VMA. If the VMA is skipped then mm->numa_scan_offset
advances and a task that is trapping faults within the VMA may never
fully update PTEs within the VMA.

Force tasks to update PTEs for partially scanned PTEs. The VMA will
be tagged for NUMA hints by some task but this removes some of the
benefit of tracking PID activity within a VMA. A follow-on patch
will mitigate this problem.

The test cases and machines evaluated did not trigger the corner case so
the performance results are neutral with only small changes within the
noise from normal test-to-test variance. However, the next patch makes
the corner case easier to trigger.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
Link: https://lore.kernel.org/r/20231010083143.19593-6-mgorman@techsingularity.net
---
 include/linux/sched/numa_balancing.h |  1 +
 include/trace/events/sched.h         |  3 ++-
 kernel/sched/fair.c                  | 18 +++++++++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index c127a15..7dcc0bd 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -21,6 +21,7 @@ enum numa_vmaskip_reason {
 	NUMAB_SKIP_INACCESSIBLE,
 	NUMAB_SKIP_SCAN_DELAY,
 	NUMAB_SKIP_PID_INACTIVE,
+	NUMAB_SKIP_IGNORE_PID,
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index d82a04d..bfc07c1 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -670,7 +670,8 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 	EM( NUMAB_SKIP_SHARED_RO,		"shared_ro" )	\
 	EM( NUMAB_SKIP_INACCESSIBLE,		"inaccessible" )	\
 	EM( NUMAB_SKIP_SCAN_DELAY,		"scan_delay" )	\
-	EMe(NUMAB_SKIP_PID_INACTIVE,		"pid_inactive" )
+	EM( NUMAB_SKIP_PID_INACTIVE,		"pid_inactive" )	\
+	EMe(NUMAB_SKIP_IGNORE_PID,		"ignore_pid_inactive" )
 
 /* Redefine for export. */
 #undef EM
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ce36969..ab79013 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3113,7 +3113,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
-static bool vma_is_accessed(struct vm_area_struct *vma)
+static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	unsigned long pids;
 	/*
@@ -3126,7 +3126,19 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 		return true;
 
 	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
-	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
+	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
+		return true;
+
+	/*
+	 * Complete a scan that has already started regardless of PID access, or
+	 * some VMAs may never be scanned in multi-threaded applications:
+	 */
+	if (mm->numa_scan_offset > vma->vm_start) {
+		trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
+		return true;
+	}
+
+	return false;
 }
 
 #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
@@ -3270,7 +3282,7 @@ static void task_numa_work(struct callback_head *work)
 		}
 
 		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma)) {
+		if (!vma_is_accessed(mm, vma)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
 			continue;
 		}
