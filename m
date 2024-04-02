Return-Path: <linux-kernel+bounces-127289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C6894946
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753431F21C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5EB14AAD;
	Tue,  2 Apr 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBa9pnIH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF514AA7;
	Tue,  2 Apr 2024 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024490; cv=none; b=MVC7/0V9xWAzsXFTkjS7swoQbls9iHUjmphKYDtyvxrUXGYN3W+MImn4aqFHy1QCKKbUAAYUjNhi8GgNdRUoG07H1CvLRYuLl4g1x9Ukxsy8aX7v9YtLgcrWhhJ9hXZtUuBehI2Ik6HPU98u97l9GDHAI5aX/BYwLgRl3GpWU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024490; c=relaxed/simple;
	bh=x+EBMifWShV+xw46OrW58BPsP2ML8vpkbmBPBYU3nCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoXq1vqfENGyAbOKyHbN3rQaWGZJfR+z27gr8CKbPjU2ZB+lG3OjsmTTWxptfQyDFHvYK+8dcr8VH9/TlAqbjyvg3sT5xcPTLJxNsvc3rXhf3U4d1G4iR5zml9Wd/elOYCzWMCMigiAdLQgDNfayG74Ag3JxSPdnI6L9HhSQ5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBa9pnIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9ABC43390;
	Tue,  2 Apr 2024 02:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712024489;
	bh=x+EBMifWShV+xw46OrW58BPsP2ML8vpkbmBPBYU3nCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBa9pnIHd7ML3Xor/8I+/wtyWRzP7rK6hndhTgSCjVmCuAAQQnDSbAnmPhu9gv9DJ
	 7uyrszuGDGjNJxpfv3Jp/CxaB1vxZ/yh7flC0qibYwfX72ClQplijZlQRL4GXoOqFL
	 G25hOx2mPZ6eJGkdGoZRrac5CEoc+IKctXVJfGarUm3OUouWSbdDnUd1opIqANiRS0
	 OpyZp0np2bl+cDcczR41aHUFEnWExNa7Ggoix561YzG/bu0UqPkGbd0bREa9cUgPGv
	 /rB/C6/PzwmJloMZbs8vKNPtiOhiOgpNxilS2CZlL6b4pLLhAniQ+68v44Gq2C62WQ
	 QPD5AHSBgpz9g==
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
Subject: [PATCH v5 2/4] perf/x86/amd: avoid taking branches before disabling LBR
Date: Mon,  1 Apr 2024 19:21:16 -0700
Message-ID: <20240402022118.1046049-3-andrii@kernel.org>
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

In the following patches we will enable LBR capture on AMD CPUs at
arbitrary point in time, which means that LBR recording won't be frozen
by hardware automatically as part of hardware overflow event. So we need
to take care to minimize amount of branches and function calls/returns
on the path to freezing LBR, minimizing LBR snapshot altering as much as
possible.

As such, split out LBR disabling logic from the sanity checking logic
inside amd_pmu_lbr_disable_all(). This will ensure that no branches are
taken before LBR is frozen in the functionality added in the next patch.
Use __always_inline to also eliminate any possible function calls.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/amd/lbr.c    |  9 +--------
 arch/x86/events/perf_event.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 5149830c7c4f..33d0a45c0cd3 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -414,18 +414,11 @@ void amd_pmu_lbr_enable_all(void)
 void amd_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-
-	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
-		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
-	}
+	__amd_pmu_lbr_disable();
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fb56518356ec..72b022a1e16c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1329,6 +1329,19 @@ void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
 
+static __always_inline void __amd_pmu_lbr_disable(void)
+{
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
+}
+
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
 #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
-- 
2.43.0


