Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D437BF5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442867AbjJJIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442886AbjJJIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:32:40 -0400
Received: from outbound-smtp36.blacknight.com (outbound-smtp36.blacknight.com [46.22.139.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB79B4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:32:38 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 3003A257E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:32:37 +0100 (IST)
Received: (qmail 8544 invoked from network); 10 Oct 2023 08:32:37 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPA; 10 Oct 2023 08:32:36 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/6] sched/numa: Move up the access pid reset logic
Date:   Tue, 10 Oct 2023 09:31:41 +0100
Message-Id: <20231010083143.19593-5-mgorman@techsingularity.net>
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

From: Raghavendra K T <raghavendra.kt@amd.com>

Recent NUMA hinting faulting activity is reset approximately every
VMA_PID_RESET_PERIOD milliseconds. However, if the current task has not
accessed a VMA then the reset check is missed and the reset is potentially
deferred forever. Check if the PID activity information should be reset
before checking if the current task recently trapped a NUMA hinting fault.

[mgorman@techsingularity.net: Rewrite changelog]
Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0535c57f6a77..05e89a7950d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3277,16 +3277,7 @@ static void task_numa_work(struct callback_head *work)
 			continue;
 		}
 
-		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma)) {
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
-			continue;
-		}
-
-		/*
-		 * RESET access PIDs regularly for old VMAs. Resetting after checking
-		 * vma for recent access to avoid clearing PID info before access..
-		 */
+		/* RESET access PIDs regularly for old VMAs. */
 		if (mm->numa_scan_seq &&
 				time_after(jiffies, vma->numab_state->pids_active_reset)) {
 			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
@@ -3295,6 +3286,12 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->pids_active[1] = 0;
 		}
 
+		/* Do not scan the VMA if task has not accessed */
+		if (!vma_is_accessed(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
+			continue;
+		}
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-- 
2.35.3

