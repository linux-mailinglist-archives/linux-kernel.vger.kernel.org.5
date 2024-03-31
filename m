Return-Path: <linux-kernel+bounces-125955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C6892E9B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FD1C20D1F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4FB664;
	Sun, 31 Mar 2024 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P16rkTZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80CB660;
	Sun, 31 Mar 2024 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711858727; cv=none; b=dvkhbQAvyv77adWYIuNAR5Sc/SQ0UsO+w2xMCI8ufqaF1QWN4qbP2tB8XJ1WUJXZfhnUTu99O6SDKYwquqqY5RBKTz5sF4ypzbiSoJ6ApXiXyMmhi8esR3Ae9NQQhgdI8tbROh5BgolBheDvG/c+4T74Bs4+ni1FfiDymJwkNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711858727; c=relaxed/simple;
	bh=CIe5yz2IxljzMvNVJnEoy0imMXCwroO7kFYa/Os7/jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auBlE4xvH+0H8zsEj+g2F8Xl9ofRHnyrtoQNiqtIq22IjqoXG0JIBagsm4qGewhiDHe5U5dVcXFjiUE6ELLvTMXf94DGgIAMKSMEJ1kzfZqOORa+EkpD92ZHEQF/1f7LpiAc2gWdTphVtfG/CFWQnoyToYb6N6cdG4+FSRit7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P16rkTZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5145C433C7;
	Sun, 31 Mar 2024 04:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711858727;
	bh=CIe5yz2IxljzMvNVJnEoy0imMXCwroO7kFYa/Os7/jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P16rkTZ2Mne5K7Dx32E/+4stuEGOpdhIvaMl7dCwJU/EfL7W3cgksvqE4Yo2P4+L5
	 ZTv1MakGto0TIcMHJUfSMtEZ7jsVTTJkcrv/FnBDp0XqHLaRispjK0+WHTOHqPVy0s
	 NLb943KQT1Gp1sOuZv+P0d/xrBWg/kc3pZFOQUqqHQVBcrxHB+kwehLxB0PPyEke/s
	 TCeNO1nbHF13xtQTrkr5Yy1zVRZ6OVP8APp2qm+X4YmiXq9JG1aW8fFOAnEZl8MrBc
	 EfgdDXJwetAjPnVs5xakpOD4HEdGkYs/q0YiE5WTNW4lN0EoS7DC/D81XPo6WpvEbr
	 Qj+75HLH6KAkg==
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
Subject: [PATCH v4 3/4] perf/x86/amd: support capturing LBR from software events
Date: Sat, 30 Mar 2024 21:18:29 -0700
Message-ID: <20240331041830.2806741-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331041830.2806741-1-andrii@kernel.org>
References: <20240331041830.2806741-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream commit c22ac2a3d4bd ("perf: Enable branch record for software
events") added ability to capture LBR (Last Branch Records) on Intel CPUs
from inside BPF program at pretty much any arbitrary point. This is
extremely useful capability that allows to figure out otherwise
hard to debug problems, because LBR is now available based on some
application-defined conditions, not just hardware-supported events.

retsnoop ([0]) is one such tool that takes a huge advantage of this
functionality and has proved to be an extremely useful tool in
practice.

Now, AMD Zen4 CPUs got support for similar LBR functionality, but
necessary wiring inside the kernel is not yet setup. This patch seeks to
rectify this and follows a similar approach to the original patch
for Intel CPUs. We implement an AMD-specific callback set to be called
through perf_snapshot_branch_stack static call.

Previous preparatory patches ensured that amd_pmu_core_disable_all() and
__amd_pmu_lbr_disable() will be completely inlined and will have no
branches, so LBR snapshot contamination will be minimized.

This was tested on AMD Bergamo CPU and worked well when utilized from
the aforementioned retsnoop tool.

  [0] https://github.com/anakryiko/retsnoop

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/amd/core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c5bcbc87d057..ed53ce091664 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -878,6 +878,37 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	return amd_pmu_adjust_nmi_window(handled);
 }
 
+/*
+ * AMD-specific callback invoked through perf_snapshot_branch_stack static
+ * call, defined in include/linux/perf_event.h. See its definition for API
+ * details. It's up to caller to provide enough space in *entries* to fit all
+ * LBR records, otherwise returned result will be truncated to *cnt* entries.
+ */
+static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	struct cpu_hw_events *cpuc;
+	unsigned long flags;
+
+	/*
+	 * The sequence of steps to freeze LBR should be completely inlined
+	 * and contain no branches to minimize contamination of LBR snapshot
+	 */
+	local_irq_save(flags);
+	amd_pmu_core_disable_all();
+	__amd_pmu_lbr_disable();
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	amd_pmu_lbr_read();
+	cnt = min(cnt, x86_pmu.lbr_nr);
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
@@ -1414,6 +1445,10 @@ static int __init amd_core_pmu_init(void)
 		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
 		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
 		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
+
+		/* Only support branch_stack snapshot on perfmon v2 */
+		if (x86_pmu.handle_irq == amd_pmu_v2_handle_irq)
+			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branch_stack);
 	} else if (!amd_brs_init()) {
 		/*
 		 * BRS requires special event constraints and flushing on ctxsw.
-- 
2.43.0


