Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A37C42EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjJJVsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjJJVr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:47:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F29B;
        Tue, 10 Oct 2023 14:47:56 -0700 (PDT)
Date:   Tue, 10 Oct 2023 21:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696974474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpEs9ENhLvphctlZsI7I0ZS+KWQgj6Q8csDIa2bdjiM=;
        b=OUhP9VY1ma3qpXl/LG+YAPccVGSjr9r0T21M2+FNT9tcEHYqBFS3BH7yrkTAgs9PJP2NLh
        6gP0rADjpNEce0XW8icZZPef/uxkSr/qmaU9mEOWibPrFP5Twp3a+ThMDUrDefK3nRn+UZ
        ADi3SnVZcGwt20lZ4iCbZLZQdWYaYThpBdZdqU/ColGYugyDvvvfOw7Yl1Jd1toctSc2hb
        aEa+GfB8E6Cq1pJ9i6t5Vv0S0a1GIneFOfITa0ukDYmTzGGa6EiVFzPrz04KjrnMQUiYYs
        BdPndIclFHdMV8e0JH8kUY0wIr40dCS2MLWpxPLcQkUHj0s6Rrs6z67RperpqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696974474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpEs9ENhLvphctlZsI7I0ZS+KWQgj6Q8csDIa2bdjiM=;
        b=QJPF17hU//0idcm78BwhwfmcuZKnkqco42qDw7/ujiyLiqvqPGL4JB9WaMBL0wc1HY+U2F
        5YvJXy/+tWdej6AQ==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Complete scanning of inactive VMAs when
 there is no alternative
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Raghavendra K T <raghavendra.kt@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010083143.19593-7-mgorman@techsingularity.net>
References: <20231010083143.19593-7-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <169697447426.3135.14791578955946343446.tip-bot2@tip-bot2>
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

Commit-ID:     f169c62ff7cd1acf8bac8ae17bfeafa307d9e6fa
Gitweb:        https://git.kernel.org/tip/f169c62ff7cd1acf8bac8ae17bfeafa307d9e6fa
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 10 Oct 2023 09:31:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 23:42:15 +02:00

sched/numa: Complete scanning of inactive VMAs when there is no alternative

VMAs are skipped if there is no recent fault activity but this represents
a chicken-and-egg problem as there may be no fault activity if the PTEs
are never updated to trap NUMA hints. There is an indirect reliance on
scanning to be forced early in the lifetime of a task but this may fail
to detect changes in phase behaviour. Force inactive VMAs to be scanned
when all other eligible VMAs have been updated within the same scan
sequence.

Test results in general look good with some changes in performance, both
negative and positive, depending on whether the additional scanning and
faulting was beneficial or not to the workload. The autonuma benchmark
workload NUMA01_THREADLOCAL was picked for closer examination. The workload
creates two processes with numerous threads and thread-local storage that
is zero-filled in a loop. It exercises the corner case where unrelated
threads may skip VMAs that are thread-local to another thread and still
has some VMAs that inactive while the workload executes.

The VMA skipping activity frequency with and without the patch:

	6.6.0-rc2-sched-numabtrace-v1
	=============================
	    649 reason=scan_delay
	  9,094 reason=unsuitable
	 48,915 reason=shared_ro
	143,919 reason=inaccessible
	193,050 reason=pid_inactive

	6.6.0-rc2-sched-numabselective-v1
	=============================
	    146 reason=seq_completed
	    622 reason=ignore_pid_inactive

	    624 reason=scan_delay
	  6,570 reason=unsuitable
	 16,101 reason=shared_ro
	 27,608 reason=inaccessible
	 41,939 reason=pid_inactive

Note that with the patch applied, the PID activity is ignored
(ignore_pid_inactive) to ensure a VMA with some activity is completely
scanned. In addition, a small number of VMAs are scanned when no other
eligible VMA is available during a single scan window (seq_completed).
The number of times a VMA is skipped due to no PID activity from the
scanning task (pid_inactive) drops dramatically. It is expected that
this will increase the number of PTEs updated for NUMA hinting faults
as well as hinting faults but these represent PTEs that would otherwise
have been missed. The tradeoff is scan+fault overhead versus improving
locality due to migration.

On a 2-socket Cascade Lake test machine, the time to complete the
workload is as follows;

                                                 6.6.0-rc2              6.6.0-rc2
                                       sched-numabtrace-v1 sched-numabselective-v1
  Min       elsp-NUMA01_THREADLOCAL      174.22 (   0.00%)      117.64 (  32.48%)
  Amean     elsp-NUMA01_THREADLOCAL      175.68 (   0.00%)      123.34 *  29.79%*
  Stddev    elsp-NUMA01_THREADLOCAL        1.20 (   0.00%)        4.06 (-238.20%)
  CoeffVar  elsp-NUMA01_THREADLOCAL        0.68 (   0.00%)        3.29 (-381.70%)
  Max       elsp-NUMA01_THREADLOCAL      177.18 (   0.00%)      128.03 (  27.74%)

The time to complete the workload is reduced by almost 30%:

                     6.6.0-rc2   6.6.0-rc2
                  sched-numabtrace-v1 sched-numabselective-v1 /
  Duration User       91201.80    63506.64
  Duration System      2015.53     1819.78
  Duration Elapsed     1234.77      868.37

In this specific case, system CPU time was not increased but it's not
universally true.

>From vmstat, the NUMA scanning and fault activity is as follows;

                                        6.6.0-rc2      6.6.0-rc2
                              sched-numabtrace-v1 sched-numabselective-v1
  Ops NUMA base-page range updates       64272.00    26374386.00
  Ops NUMA PTE updates                   36624.00       55538.00
  Ops NUMA PMD updates                      54.00       51404.00
  Ops NUMA hint faults                   15504.00       75786.00
  Ops NUMA hint local faults %           14860.00       56763.00
  Ops NUMA hint local percent               95.85          74.90
  Ops NUMA pages migrated                 1629.00     6469222.00

Both the number of PTE updates and hint faults is dramatically
increased. While this is superficially unfortunate, it represents
ranges that were simply skipped without the patch. As a result
of the scanning and hinting faults, many more pages were also
migrated but as the time to completion is reduced, the overhead
is offset by the gain.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
Link: https://lore.kernel.org/r/20231010083143.19593-7-mgorman@techsingularity.net
---
 include/linux/mm_types.h             |  6 +++-
 include/linux/sched/numa_balancing.h |  1 +-
 include/trace/events/sched.h         |  3 +-
 kernel/sched/fair.c                  | 55 +++++++++++++++++++++++++--
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e7571ec..589f31e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -575,6 +575,12 @@ struct vma_numab_state {
 	 * every VMA_PID_RESET_PERIOD jiffies:
 	 */
 	unsigned long pids_active[2];
+
+	/*
+	 * MM scan sequence ID when the VMA was last completely scanned.
+	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
+	 */
+	int prev_scan_seq;
 };
 
 /*
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 7dcc0bd..b69afb8 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -22,6 +22,7 @@ enum numa_vmaskip_reason {
 	NUMAB_SKIP_SCAN_DELAY,
 	NUMAB_SKIP_PID_INACTIVE,
 	NUMAB_SKIP_IGNORE_PID,
+	NUMAB_SKIP_SEQ_COMPLETED,
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index bfc07c1..6188ad0 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -671,7 +671,8 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 	EM( NUMAB_SKIP_INACCESSIBLE,		"inaccessible" )	\
 	EM( NUMAB_SKIP_SCAN_DELAY,		"scan_delay" )	\
 	EM( NUMAB_SKIP_PID_INACTIVE,		"pid_inactive" )	\
-	EMe(NUMAB_SKIP_IGNORE_PID,		"ignore_pid_inactive" )
+	EM( NUMAB_SKIP_IGNORE_PID,		"ignore_pid_inactive" )		\
+	EMe(NUMAB_SKIP_SEQ_COMPLETED,		"seq_completed" )
 
 /* Redefine for export. */
 #undef EM
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab79013..9229051 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3158,6 +3158,8 @@ static void task_numa_work(struct callback_head *work)
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
 	struct vma_iterator vmi;
+	bool vma_pids_skipped;
+	bool vma_pids_forced = false;
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -3200,7 +3202,6 @@ static void task_numa_work(struct callback_head *work)
 	 */
 	p->node_stamp += 2 * TICK_NSEC;
 
-	start = mm->numa_scan_offset;
 	pages = sysctl_numa_balancing_scan_size;
 	pages <<= 20 - PAGE_SHIFT; /* MB in pages */
 	virtpages = pages * 8;	   /* Scan up to this much virtual space */
@@ -3210,6 +3211,16 @@ static void task_numa_work(struct callback_head *work)
 
 	if (!mmap_read_trylock(mm))
 		return;
+
+	/*
+	 * VMAs are skipped if the current PID has not trapped a fault within
+	 * the VMA recently. Allow scanning to be forced if there is no
+	 * suitable VMA remaining.
+	 */
+	vma_pids_skipped = false;
+
+retry_pids:
+	start = mm->numa_scan_offset;
 	vma_iter_init(&vmi, mm, start);
 	vma = vma_next(&vmi);
 	if (!vma) {
@@ -3260,6 +3271,13 @@ static void task_numa_work(struct callback_head *work)
 			/* Reset happens after 4 times scan delay of scan start */
 			vma->numab_state->pids_active_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+
+			/*
+			 * Ensure prev_scan_seq does not match numa_scan_seq,
+			 * to prevent VMAs being skipped prematurely on the
+			 * first scan:
+			 */
+			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
 		}
 
 		/*
@@ -3281,8 +3299,19 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->pids_active[1] = 0;
 		}
 
-		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(mm, vma)) {
+		/* Do not rescan VMAs twice within the same sequence. */
+		if (vma->numab_state->prev_scan_seq == mm->numa_scan_seq) {
+			mm->numa_scan_offset = vma->vm_end;
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SEQ_COMPLETED);
+			continue;
+		}
+
+		/*
+		 * Do not scan the VMA if task has not accessed it, unless no other
+		 * VMA candidate exists.
+		 */
+		if (!vma_pids_forced && !vma_is_accessed(mm, vma)) {
+			vma_pids_skipped = true;
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
 			continue;
 		}
@@ -3311,8 +3340,28 @@ static void task_numa_work(struct callback_head *work)
 
 			cond_resched();
 		} while (end != vma->vm_end);
+
+		/* VMA scan is complete, do not scan until next sequence. */
+		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
+
+		/*
+		 * Only force scan within one VMA at a time, to limit the
+		 * cost of scanning a potentially uninteresting VMA.
+		 */
+		if (vma_pids_forced)
+			break;
 	} for_each_vma(vmi, vma);
 
+	/*
+	 * If no VMAs are remaining and VMAs were skipped due to the PID
+	 * not accessing the VMA previously, then force a scan to ensure
+	 * forward progress:
+	 */
+	if (!vma && !vma_pids_forced && vma_pids_skipped) {
+		vma_pids_forced = true;
+		goto retry_pids;
+	}
+
 out:
 	/*
 	 * It is possible to reach the end of the VMA list but the last few
