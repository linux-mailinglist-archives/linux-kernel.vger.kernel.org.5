Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540447EBF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjKOJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjKOJFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:05:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B30B11F;
        Wed, 15 Nov 2023 01:04:57 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRzwwgL0YArqRaYB+PBQmPDmbmjCfGOodH5XxvM07D8=;
        b=vre0JfoEr5u6zxvAC6yptC1xRoqvF6YaerGv+lCrROiSyAzlGsCSm0HGnUOoddSKf/vsV4
        DBIYZmp4HE4uFFjBvKA521aYOSgtloF3Z4Kme6vTkZMO0w8XleqVFP4jV2VFVmMS06mo9E
        dXHysemxklTuUGSFxTeCq6Ql/IVtzoSTq4X/Vhas80KCyHw82vTpVF/ULUIlkuyDHmt0YZ
        0+sltwtdzhq/XGgV01L5FeDCxxL/6dgvKKRfwfXdhdFxM2/IrJuOFGGqeHFGcJKmlh63Pc
        Wkp+q1z9UZYHQMusE9e4vtfOdl2QCUd9eaZi5xtPrp2zudnZVc6QGhytPVkneg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRzwwgL0YArqRaYB+PBQmPDmbmjCfGOodH5XxvM07D8=;
        b=s4AfFs/LKowDPOfjKdtn1shlbfVNlc3E0RUu2CYllC4x2ZH+M0mxHC2BfhM++iRp8DiLx+
        5bHcYvJTlaFuKKDA==
From:   "tip-bot2 for Raghavendra K T" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Fix mm numa_scan_seq based unconditional scan
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2ea7cbce80ac7c62e90cbfb9653a7972f902439f=2E16978?=
 =?utf-8?q?16692=2Egit=2Eraghavendra=2Ekt=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C2ea7cbce80ac7c62e90cbfb9653a7972f902439f=2E169781?=
 =?utf-8?q?6692=2Egit=2Eraghavendra=2Ekt=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <170003909541.391.12348642346090919555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     84db47ca7146d7bd00eb5cf2b93989a971c84650
Gitweb:        https://git.kernel.org/tip/84db47ca7146d7bd00eb5cf2b93989a971c84650
Author:        Raghavendra K T <raghavendra.kt@amd.com>
AuthorDate:    Fri, 20 Oct 2023 21:27:46 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:46 +01:00

sched/numa: Fix mm numa_scan_seq based unconditional scan

Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")

NUMA Balancing allows updating PTEs to trap NUMA hinting faults if the
task had previously accessed VMA. However unconditional scan of VMAs are
allowed during initial phase of VMA creation until process's
mm numa_scan_seq reaches 2 even though current task had not accessed VMA.

Rationale:
 - Without initial scan subsequent PTE update may never happen.
 - Give fair opportunity to all the VMAs to be scanned and subsequently
understand the access pattern of all the VMAs.

But it has a corner case where, if a VMA is created after some time,
process's mm numa_scan_seq could be already greater than 2.

For e.g., values of mm numa_scan_seq when VMAs are created by running
mmtest autonuma benchmark briefly looks like:
start_seq=0 : 459
start_seq=2 : 138
start_seq=3 : 144
start_seq=4 : 8
start_seq=8 : 1
start_seq=9 : 1
This results in no unconditional PTE updates for those VMAs created after
some time.

Fix:
 - Note down the initial value of mm numa_scan_seq in per VMA start_seq.
 - Allow unconditional scan till start_seq + 2.

Result:
SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.
base kernel: upstream 6.6-rc6 with Mels patches [1] applied.

kernbench
==========		base                  patched %gain
Amean    elsp-128      165.09 ( 0.00%)      164.78 *   0.19%*

Duration User       41404.28    41375.08
Duration System      9862.22     9768.48
Duration Elapsed      519.87      518.72

Ops NUMA PTE updates           1041416.00      831536.00
Ops NUMA hint faults            263296.00      220966.00
Ops NUMA pages migrated         258021.00      212769.00
Ops AutoNUMA cost                 1328.67        1114.69

autonumabench

NUMA01_THREADLOCAL
==================
Amean  elsp-NUMA01_THREADLOCAL   81.79 (0.00%)  67.74 *  17.18%*

Duration User       54832.73    47379.67
Duration System        75.00      185.75
Duration Elapsed      576.72      476.09

Ops NUMA PTE updates                  394429.00    11121044.00
Ops NUMA hint faults                    1001.00     8906404.00
Ops NUMA pages migrated                  288.00     2998694.00
Ops AutoNUMA cost                          7.77       44666.84

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/2ea7cbce80ac7c62e90cbfb9653a7972f902439f.1697816692.git.raghavendra.kt@amd.com
---
 include/linux/mm_types.h | 3 +++
 kernel/sched/fair.c      | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38..950df41 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -600,6 +600,9 @@ struct vma_numab_state {
 	 */
 	unsigned long pids_active[2];
 
+	/* MM scan sequence ID when scan first started after VMA creation */
+	int start_scan_seq;
+
 	/*
 	 * MM scan sequence ID when the VMA was last completely scanned.
 	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63..44b5262 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3164,7 +3164,7 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 	 * This is also done to avoid any side effect of task scanning
 	 * amplifying the unfairness of disjoint set of VMAs' access.
 	 */
-	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
+	if ((READ_ONCE(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2)
 		return true;
 
 	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
@@ -3307,6 +3307,8 @@ retry_pids:
 			if (!vma->numab_state)
 				continue;
 
+			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
+
 			vma->numab_state->next_scan = now +
 				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 
