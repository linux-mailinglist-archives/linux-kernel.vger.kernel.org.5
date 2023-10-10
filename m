Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B47BF63D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjJJIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJJIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:41:42 -0400
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 01:41:40 PDT
Received: from outbound-smtp02.blacknight.com (outbound-smtp02.blacknight.com [81.17.249.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA374AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:41:40 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id E67D7BADA5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:32:15 +0100 (IST)
Received: (qmail 7586 invoked from network); 10 Oct 2023 08:32:15 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPA; 10 Oct 2023 08:32:15 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/6] sched/numa: Rename vma_numab_state.access_pids
Date:   Tue, 10 Oct 2023 09:31:39 +0100
Message-Id: <20231010083143.19593-3-mgorman@techsingularity.net>
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

The access_pids field name is somewhat ambiguous as no PIDs are accessed.
Similarly, it's not clear that next_pid_reset is related to access_pids.
Rename the fields to more accurately reflect their purpose.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mm.h       |  4 ++--
 include/linux/mm_types.h |  4 ++--
 kernel/sched/fair.c      | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..19fc73b02c9f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1726,8 +1726,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	unsigned int pid_bit;
 
 	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
-	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids[1])) {
-		__set_bit(pid_bit, &vma->numab_state->access_pids[1]);
+	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->pids_active[1])) {
+		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0fe054afc4d6..8cb1dec3e358 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -558,12 +558,12 @@ struct vma_numab_state {
 						 * least
 						 * sysctl_numa_balancing_scan_delay
 						 */
-	unsigned long next_pid_reset;		/* Time in jiffies when
+	unsigned long pids_active_reset;	/* Time in jiffies when
 						 * access_pids is reset to
 						 * detect phase change
 						 * behaviour.
 						 */
-	unsigned long access_pids[2];		/* Approximate tracking of PIDS
+	unsigned long pids_active[2];		/* Approximate tracking of PIDS
 						 * that trapped a NUMA hinting
 						 * fault. May produce false
 						 * positives due to hash
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb225921bbca..81405627b9ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3142,7 +3142,7 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
 		return true;
 
-	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
+	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
 	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
 }
 
@@ -3258,7 +3258,7 @@ static void task_numa_work(struct callback_head *work)
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 
 			/* Reset happens after 4 times scan delay of scan start */
-			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
+			vma->numab_state->pids_active_reset =  vma->numab_state->next_scan +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
 		}
 
@@ -3279,11 +3279,11 @@ static void task_numa_work(struct callback_head *work)
 		 * vma for recent access to avoid clearing PID info before access..
 		 */
 		if (mm->numa_scan_seq &&
-				time_after(jiffies, vma->numab_state->next_pid_reset)) {
-			vma->numab_state->next_pid_reset = vma->numab_state->next_pid_reset +
+				time_after(jiffies, vma->numab_state->pids_active_reset)) {
+			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
-			vma->numab_state->access_pids[0] = READ_ONCE(vma->numab_state->access_pids[1]);
-			vma->numab_state->access_pids[1] = 0;
+			vma->numab_state->pids_active[0] = READ_ONCE(vma->numab_state->pids_active[1]);
+			vma->numab_state->pids_active[1] = 0;
 		}
 
 		do {
-- 
2.35.3

