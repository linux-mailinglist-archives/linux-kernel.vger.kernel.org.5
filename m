Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C789A7BF5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442885AbjJJIcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442873AbjJJIcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:32:50 -0400
Received: from outbound-smtp12.blacknight.com (outbound-smtp12.blacknight.com [46.22.139.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5EA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:32:48 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id AB0CD1C433F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:32:47 +0100 (IST)
Received: (qmail 8972 invoked from network); 10 Oct 2023 08:32:47 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPA; 10 Oct 2023 08:32:47 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/6] sched/numa: Complete scanning of partial VMAs regardless of PID activity
Date:   Tue, 10 Oct 2023 09:31:42 +0100
Message-Id: <20231010083143.19593-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231010083143.19593-1-mgorman@techsingularity.net>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/sched/numa_balancing.h |  1 +
 include/trace/events/sched.h         |  3 ++-
 kernel/sched/fair.c                  | 18 +++++++++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index c127a1509e2f..7dcc0bdfddbb 100644
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
index b0d0dbf491ea..27b51c81b106 100644
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
index 05e89a7950d0..150f01948ec6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3130,7 +3130,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
-static bool vma_is_accessed(struct vm_area_struct *vma)
+static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	unsigned long pids;
 	/*
@@ -3143,7 +3143,19 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 		return true;
 
 	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
-	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
+	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
+		return true;
+
+	/*
+	 * Complete a scan that has already started regardless of PID access or
+	 * some VMAs may never be scanned in multi-threaded applications
+	 */
+	if (mm->numa_scan_offset > vma->vm_start) {
+		trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
+		return true;
+	}
+
+	return false;
 }
 
 #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
@@ -3287,7 +3299,7 @@ static void task_numa_work(struct callback_head *work)
 		}
 
 		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma)) {
+		if (!vma_is_accessed(mm, vma)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
 			continue;
 		}
-- 
2.35.3

