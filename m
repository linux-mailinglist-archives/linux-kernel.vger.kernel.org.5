Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33EB7BF5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442752AbjJJIcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442867AbjJJIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:32:12 -0400
Received: from outbound-smtp17.blacknight.com (outbound-smtp17.blacknight.com [46.22.139.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5FA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:32:06 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 942F41C4F57
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:32:05 +0100 (IST)
Received: (qmail 7039 invoked from network); 10 Oct 2023 08:32:05 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPA; 10 Oct 2023 08:32:05 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/6] sched/numa: Document vma_numab_state fields
Date:   Tue, 10 Oct 2023 09:31:38 +0100
Message-Id: <20231010083143.19593-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231010083143.19593-1-mgorman@techsingularity.net>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the intended usage of the fields.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mm_types.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..0fe054afc4d6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -551,9 +551,33 @@ struct vma_lock {
 };
 
 struct vma_numab_state {
-	unsigned long next_scan;
-	unsigned long next_pid_reset;
-	unsigned long access_pids[2];
+	unsigned long next_scan;		/* Initialised as time in
+						 * jiffies after which VMA
+						 * should be scanned.  Delays
+						 * first scan of new VMA by at
+						 * least
+						 * sysctl_numa_balancing_scan_delay
+						 */
+	unsigned long next_pid_reset;		/* Time in jiffies when
+						 * access_pids is reset to
+						 * detect phase change
+						 * behaviour.
+						 */
+	unsigned long access_pids[2];		/* Approximate tracking of PIDS
+						 * that trapped a NUMA hinting
+						 * fault. May produce false
+						 * positives due to hash
+						 * collisions.
+						 *
+						 * [0] Previous PID tracking
+						 * [1] Current PID tracking
+						 *
+						 * Window moves after
+						 * next_pid_reset has expired
+						 * approximately every
+						 * VMA_PID_RESET_PERIOD
+						 * jiffies.
+						 */
 };
 
 /*
-- 
2.35.3

