Return-Path: <linux-kernel+bounces-125954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBFE892E99
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097C31C20D3D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C4D8830;
	Sun, 31 Mar 2024 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMaaJwDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4099455;
	Sun, 31 Mar 2024 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711858724; cv=none; b=HaegUB0VW1Pi8pfOgLnn3EhIlvsG1JX3QDdd4kw+nWkl+wlt7CbYsaoEYELjzjYjweKex40kQnE62B1zwQYytAzUzA4gF++RWT6F6bOK84Fiwm6JINPVDiDOnr5rWUySnuCgIUv8wbEJsr8iPRMHpg4yy+yYiNG83l7Pu26NATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711858724; c=relaxed/simple;
	bh=0YP19HLDTdmiKDmEUwI54qLXFqcjsIyepLsJ8fYA4cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9V11GjiO1OQ9TzDVBArjMlEu1f8TKqY5HPmC0DsiXACcnhjb5h4pc08z0jDSrMB7z6cJPiBaNqfFr5yEm0pIDv6dqaZXtHSFYJvFekiJZlnMnoYQxR2BH2NecF55dsQ4JEq7q89g2XMlwSusSjfadlTM7WoCbe61C/MlFGVpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMaaJwDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5B1C433C7;
	Sun, 31 Mar 2024 04:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711858723;
	bh=0YP19HLDTdmiKDmEUwI54qLXFqcjsIyepLsJ8fYA4cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMaaJwDmz5S4IjSIGyKKRR9pMsPNHyJGnrenZcIVedGD4T05QLLGSxcfcAohdXvGL
	 tJuSUqm8dKiwg1JU8OfU8plHtSvgSTeZbganSvU9UVFCQ+3WKCEtv5ECIr22oL44qw
	 CJwFLgDU/ymUhUvZV+JgwEkfbCStsi607Rs0k7sfKLG65uX0NjKh9cGMOSvmG5zPi0
	 QLrNWvpQQkSVAUaKG0rGdU+3DUXHnJpiduluHKwnunkWeFwMz01iU7vmBzgyqfPeyh
	 ljr+yEZJ9QqTNwMn9IAB9ne7s4mbDB0JsGo0q59HFWhu2LrCwXzknX3z8Qouo3hFlQ
	 VbwarRZ5kbgyw==
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
Subject: [PATCH v4 2/4] perf/x86/amd: avoid taking branches before disabling LBR
Date: Sat, 30 Mar 2024 21:18:28 -0700
Message-ID: <20240331041830.2806741-3-andrii@kernel.org>
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
 arch/x86/events/amd/lbr.c    |  7 +------
 arch/x86/events/perf_event.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

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


