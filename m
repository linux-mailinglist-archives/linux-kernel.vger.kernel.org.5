Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE37D9986
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbjJ0NRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjJ0NQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:16:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CBC4;
        Fri, 27 Oct 2023 06:16:53 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698412612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/39ktFhwdPeEfTfccsuAt5wKzh2w/3VDMlvZhp7o4k=;
        b=e+2fFQOaQix0c+iUlW97KH4cyBvg1/OFvLia6NwSbKs+HODWk4gIyiNMqbFHFZc+hTZBtT
        Q49kZpGU9+CoffM8/PkYOg11WHkU+zUfvxjZzV3yy4cMz9LwbmPTXCIK0pTMQKqqyJi0kf
        65kbz0MXNvmkvl+b8et/Hlo4PyItfRAEo/lpxQJsdMCW40wydHjohcLr0MVFkJTQ4nd2JQ
        EVtlvBVkolcVeTxB61JHB6Rtq3wl673zixL69H2HgSrM9r7h+sd5YyQkNz6kISWFNEUHB7
        RV943QkW/PZds66yLp5T+kNvn8W1Syu0xeCaU88dxkRSFkVV0n4gEr5DkLI6Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698412612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/39ktFhwdPeEfTfccsuAt5wKzh2w/3VDMlvZhp7o4k=;
        b=+dlLZktxHE+zscb3ONpjYezHlYfjgwJQm5DP+/tHQAs1qhGQ4aBz0uwCtpYZkN83B5gDhm
        zsFgIYasXflSxFDg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231025201626.3000228-2-kan.liang@linux.intel.com>
References: <20231025201626.3000228-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169841261141.3135.2527427059573800876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     85846b27072defc7ab3dcee7ff36563a040079dc
Gitweb:        https://git.kernel.org/tip/85846b27072defc7ab3dcee7ff36563a040079dc
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 25 Oct 2023 13:16:20 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Oct 2023 15:05:09 +02:00

perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag

Currently, branch_sample_type !=0 is used to check whether a branch
stack setup is required. But it doesn't check the sample type,
unnecessary branch stack setup may be done for a counting event. E.g.,
perf record -e "{branch-instructions,branch-misses}:S" -j any
Also, the event only with the new PERF_SAMPLE_BRANCH_COUNTERS branch
sample type may not require a branch stack setup either.

Add a new flag NEEDS_BRANCH_STACK to indicate whether the event requires
a branch stack setup. Replace the needs_branch_stack() by checking the
new flag.

The counting event check is implemented here. The later patch will take
the new PERF_SAMPLE_BRANCH_COUNTERS into account.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231025201626.3000228-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c       | 14 +++++++++++---
 arch/x86/events/perf_event_flags.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 41a1647..a99449c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2527,9 +2527,14 @@ static void intel_pmu_assign_event(struct perf_event *event, int idx)
 		perf_report_aux_output_id(event, idx);
 }
 
+static __always_inline bool intel_pmu_needs_branch_stack(struct perf_event *event)
+{
+	return event->hw.flags & PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+}
+
 static void intel_pmu_del_event(struct perf_event *event)
 {
-	if (needs_branch_stack(event))
+	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_del(event);
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_del(event);
@@ -2820,7 +2825,7 @@ static void intel_pmu_add_event(struct perf_event *event)
 {
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_add(event);
-	if (needs_branch_stack(event))
+	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_add(event);
 }
 
@@ -3897,7 +3902,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
-	if (needs_branch_stack(event)) {
+	if (needs_branch_stack(event) && is_sampling_event(event))
+		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+
+	if (intel_pmu_needs_branch_stack(event)) {
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
 			return ret;
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 1dc19b9..a168598 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -20,3 +20,4 @@ PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
 PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
 PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
 PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
+PERF_ARCH(NEEDS_BRANCH_STACK,	0x40000) /* require branch stack setup */
