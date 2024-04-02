Return-Path: <linux-kernel+bounces-127290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67045894947
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A0F1C23534
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF9D17548;
	Tue,  2 Apr 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHgSVI7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21336168DD;
	Tue,  2 Apr 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024493; cv=none; b=SVoQPMy/DxrGabqAzPxlwfZq8HZR6MsPuuaO5oifVvI83VtOO/J2s9NWMZInRQ1+VUAY5Xv/q+gvc/0sTJTEUPp8jSWWeADsi80Lo8dF349Tz/lapO1bpM1holho/NJs/J66SrEG5qjpHwBPIGYw9m01WwTxMjrdzniezQhz/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024493; c=relaxed/simple;
	bh=6rtaBnzG8vSA41sp68PKabBNfcq1hfqROrFmhJ0TClQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn56ZdL22e1JS3Uh/xwYFa35Mu0UYq4dgrLf2gga0kzmmzDZmGIbR/ng6SWwToTqcNntcOycXesLD10EoawsFBS7m99eRPa1uUQqnwdE3moulSDYD1A7jfD6uBDrmUWFQ63Tdwrtel5nwwanpMjJzQ8Ukoynkrs4hsC1WvrveMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHgSVI7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0939C43390;
	Tue,  2 Apr 2024 02:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712024493;
	bh=6rtaBnzG8vSA41sp68PKabBNfcq1hfqROrFmhJ0TClQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHgSVI7gFh855zKKprdhejHDxxnNdRFIUomOb88p4rYvbFK5xBGPO/I6/ZKHqoER0
	 QD07NgCrCa5tdAdUcxhT+n7M+GwVZb9BrrL8pbeIuT2J7Gs4jxJA2Mpn64Nlc2eTxQ
	 52ZAmvf5RRP5YEAQq8OWe/bTYX/nzBF94Jn0gfrzQwDkm2uWZdfNXHZShWG4TK6OsK
	 p80lIO6Rbz9RCwVnCQK3DpZUKfgRX1zzXwtVfe2osTRKVBX70ibVNUxXT+PtOEZ+A0
	 fIhIdEAGpUYbj9SETgn3q25MT4x23FDpVlsFcrNn0/wK4uox0lnitmEAjJAJpXhJpU
	 +Ye2+WB7Hp9hA==
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
Subject: [PATCH v5 3/4] perf/x86/amd: support capturing LBR from software events
Date: Mon,  1 Apr 2024 19:21:17 -0700
Message-ID: <20240402022118.1046049-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402022118.1046049-1-andrii@kernel.org>
References: <20240402022118.1046049-1-andrii@kernel.org>
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
index 9b15afda0326..1fc4ce44e743 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -907,6 +907,37 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
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
@@ -1443,6 +1474,10 @@ static int __init amd_core_pmu_init(void)
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


