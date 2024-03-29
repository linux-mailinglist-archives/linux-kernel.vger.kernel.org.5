Return-Path: <linux-kernel+bounces-125176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395808921AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8ED1C2408F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BA65E20;
	Fri, 29 Mar 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQqlzQKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152601C0DF5;
	Fri, 29 Mar 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730246; cv=none; b=D75ew9cxCvYTPQFAJnOtMKoapVheI1SdVGZarYsyl9o7uapoArgiBnyThBE/EuHV+wbMY8OhF+9t2BwZA0lhGOqrYX1fqd1ObOI0r0pcg2CP7tHHS+jP24huBq5GvhHcLoqS46ORyXi8HGC0tNcCKfnSXHdvVswrdgCCn508tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730246; c=relaxed/simple;
	bh=ZdWSNCNjQ68IX2rHd7NbPcbBVzEbZRUXZn0KGl56Wg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJPsKiOqVuwOc8BRFhAwXWO1SGUwbrKS/WTQrmAL1UfEdIX/BPRRHZdp8LX19/iSE/lTnhVdSfavJM9LDvtPaQJmCo2EpmRMpZ6aqYad92loHQo9ALYDqQT8BfkPfXROgXCFaDjha/hI21VEhi/inUPiJA8W+Y61t0X79AFlvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQqlzQKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE1C433F1;
	Fri, 29 Mar 2024 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711730245;
	bh=ZdWSNCNjQ68IX2rHd7NbPcbBVzEbZRUXZn0KGl56Wg4=;
	h=From:To:Cc:Subject:Date:From;
	b=UQqlzQKlyfMFSqlsAscjGsKS5EPm6OFhMHBbZR+3cfNw6r1UBbwGIo2oY9NksW90A
	 4vu6SL04JVP4NlArkuDzDx8bv3cZIxlNzhk5sRShD1AzYTdsHT9DbN7/mUjcwntfmG
	 +Ly997qw3NxYzSEVLQfchmQ8cCy8r/csU1dCgfzBiIuxLOlKPzB33Jy828L69Eon2a
	 5B4Hn7InKXq7ytwoyQpESdX/R9n524tYOSvPjgu6qfWkEj55lCZDl8alkQRoqD5ppK
	 PiMiMw7o/ChF+UpKVluI6PsX/hAnj6h3/Fwi4fvoY7fIUtrw03M0E1+kKciDymV569
	 xyYJYbWIpxwLw==
From: Andrii Nakryiko <andrii@kernel.org>
To: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	song@kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v3 1/2] perf/x86/amd: support capturing LBR from software events
Date: Fri, 29 Mar 2024 09:37:21 -0700
Message-ID: <20240329163722.2776730-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[0] added ability to capture LBR (Last Branch Records) on Intel CPUs
from inside BPF program at pretty much any arbitrary point. This is
extremely useful capability that allows to figure out otherwise
hard-to-debug problems, because LBR is now available based on some
application-defined conditions, not just hardware-supported events.

retsnoop ([1]) is one such tool that takes a huge advantage of this
functionality and has proved to be an extremely useful tool in
practice.

Now, AMD Zen4 CPUs got support for similar LBR functionality, but
necessary wiring inside the kernel is not yet setup. This patch seeks to
rectify this and follows a similar approach to the original patch [0]
for Intel CPUs.

Given LBR can be set up to capture any indirect jumps, it's critical to
minimize indirect jumps on the way to requesting LBR from BPF program,
so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
conditions vs always-inlined __amd_pmu_lbr_disable() called directly
from BPF subsystem (through perf_snapshot_branch_stack static call).

This was tested on AMD Bergamo CPU and worked well when utilized from
the aforementioned retsnoop tool.

  [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubraving@fb.com/
  [1] https://github.com/anakryiko/retsnoop

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
 arch/x86/events/amd/lbr.c    |  7 +------
 arch/x86/events/perf_event.h | 11 +++++++++++
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index aec16e581f5b..88f6d0701342 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -618,7 +618,7 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
-static inline void amd_pmu_set_global_ctl(u64 ctl)
+static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 {
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
@@ -878,6 +878,29 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	return amd_pmu_adjust_nmi_window(handled);
 }
 
+static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	struct cpu_hw_events *cpuc;
+	unsigned long flags;
+
+	/* must not have branches... */
+	local_irq_save(flags);
+	amd_pmu_core_disable_all();
+	__amd_pmu_lbr_disable();
+	/*            ... until here */
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	amd_pmu_lbr_read();
+	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+
+	amd_pmu_v2_enable_all(0);
+	local_irq_restore(flags);
+
+	return cnt;
+}
+
 static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1414,6 +1437,10 @@ static int __init amd_core_pmu_init(void)
 		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
 		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
 		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
+
+		/* only support branch_stack snapshot on perfmon v2 */
+		if (x86_pmu.handle_irq == amd_pmu_v2_handle_irq)
+			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branch_stack);
 	} else if (!amd_brs_init()) {
 		/*
 		 * BRS requires special event constraints and flushing on ctxsw.
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 4a1e600314d5..0e4de028590d 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -412,16 +412,11 @@ void amd_pmu_lbr_enable_all(void)
 void amd_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-
-	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	__amd_pmu_lbr_disable();
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fb56518356ec..4dddf0a7e81e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1329,6 +1329,17 @@ void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
 
+static __always_inline void __amd_pmu_lbr_disable(void)
+{
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+}
+
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
 #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
-- 
2.43.0


