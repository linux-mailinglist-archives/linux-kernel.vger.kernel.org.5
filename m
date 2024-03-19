Return-Path: <linux-kernel+bounces-108196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30163880755
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B0CB2201D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371D3EA8D;
	Tue, 19 Mar 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAezIUfv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D5125CB;
	Tue, 19 Mar 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888128; cv=none; b=hXapvOXtTnsqjCGrvJaq0HBb5igO0jKW3J4l8gaKi4U/b5VMiGv58GFl8D3GJUZzNpcOwEKHPitZUUiT3LRaindydtKciHWxU8TLWzI9HGZT/5KZkNduE7Sl9Jjqs4Jm8R2KnNFhEIQiRrnIInmH7NQSsokSpfVHOD/cLL0fT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888128; c=relaxed/simple;
	bh=3k8Qz8Bs43OFLNKtX+4DNpyATuOJaHuSGtFlxYyLjX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruM0EEdySkMovuIyknNtlsWl+NH/QfInxhPqHVZAjTMs0hW95JS1lUTR0/vp4jBCm2LD4KFQq1wfzZNRbdSJjIrvSxOpaYRRFtyRBcwbqboRBz/cGm0B5vYlKh/AtpPZBlf4onCUBXMCWotJFiaxG6V2Q0Vv5/bG1nqHxXMBQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAezIUfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB87CC433F1;
	Tue, 19 Mar 2024 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710888127;
	bh=3k8Qz8Bs43OFLNKtX+4DNpyATuOJaHuSGtFlxYyLjX0=;
	h=From:To:Cc:Subject:Date:From;
	b=tAezIUfvhlaM6VSRzdNrZjhumJKNe0MXgmknrwX4Y8j/6BGuOae2p/AxQAU+aI7V5
	 p6wqo6+zeN/eaWmQMyv5CD8WNH6WyVvmZaABErV9mZz5oaduwKJElIl+RPYhbb2sKk
	 gh/Fplugu2DbIlDP6evHR8XkoyNkpgR/vVws3etnjG8prvOGlFLwwSU5i5w0nZ9qBC
	 zD0euNHvrbog0JuIZgRzcwkPZU+nGeDGAJnbrUcoGm9dPSx2lgI0MIY9Sm9j8J9ZO/
	 a25cbe1+61Kwl3ZR9NjtQ4vPefC1Rs7Sg7F6G+/EjrR8yw2AoYJswkGfaMlCcZ6Wqa
	 woVVyNRnjyGQw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] perf, amd: support capturing LBR from software events
Date: Tue, 19 Mar 2024 15:42:06 -0700
Message-ID: <20240319224206.1612000-1-andrii@kernel.org>
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

Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
point, there is no reason to artificially limit this feature to sampling
events. So corresponding check is removed. AFAIU, there is no
correctness implications of doing this (and it was possible to bypass
this check by just setting perf_event's sample_period to 1 anyways, so
it doesn't guard all that much).

This was tested on AMD Bergamo CPU and worked well when utilized from
the aforementioned retsnoop tool.

  [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubraving@fb.com/
  [1] https://github.com/anakryiko/retsnoop

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
 arch/x86/events/amd/lbr.c    | 11 +----------
 arch/x86/events/perf_event.h | 11 +++++++++++
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 69a3b02e50bb..fef661230acc 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -619,7 +619,7 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
-static inline void amd_pmu_set_global_ctl(u64 ctl)
+static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 {
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
@@ -879,6 +879,29 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
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
@@ -1415,6 +1438,10 @@ static int __init amd_core_pmu_init(void)
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
index eb31f850841a..c34f8d0048e0 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -308,10 +308,6 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
 {
 	int ret = 0;
 
-	/* LBR is not recommended in counting mode */
-	if (!is_sampling_event(event))
-		return -EINVAL;
-
 	ret = amd_pmu_lbr_setup_filter(event);
 	if (!ret)
 		event->attach_state |= PERF_ATTACH_SCHED_CB;
@@ -410,16 +406,11 @@ void amd_pmu_lbr_enable_all(void)
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


