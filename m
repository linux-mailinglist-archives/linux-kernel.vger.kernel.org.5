Return-Path: <linux-kernel+bounces-139797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D68A07D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DE11F2253D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44C13CAB9;
	Thu, 11 Apr 2024 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJMNErly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62713CA9C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814120; cv=none; b=EaLMYXsJj64o05C1wfMAxd+5FKqb5PBeqpw+7FqqTOVZsJX57JIyxOyPR3I3u78kqzSWbuEHqdRK9AlQ8d/0cB7ZGv4G86NMxbuZx8EOkkBA5MIWgV0mXdpTMBTjk1qh/2/yVBOB4q1zy5v5JmiK7i+bcLqFPGh+qDkINGKjgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814120; c=relaxed/simple;
	bh=OncdHB68GtNbx3dHWQR7cZg44SO1zu1bq2L0lGrG/HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZhCftIQFK6xgqV7lt9FrI/G9PrcAAIaq3wwxofN0cX3IzGB6ychjmuBO4Uszx7dcNZRIiJT8UheYL4ZNflcuRWrzLFiFopaBAcacYkTIIowjb0ALMxzKop09G+DaLBt3NFaEmlfuaFgrMqgWeKYI7I16rUaYxvIooOL92sxZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJMNErly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CFDC43390;
	Thu, 11 Apr 2024 05:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814119;
	bh=OncdHB68GtNbx3dHWQR7cZg44SO1zu1bq2L0lGrG/HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJMNErlyM8Vi/USIIrNgPRTSHavW9bC2+Mx1Fuf1DlUxKw73y9z3pCg5uJLvJ/ZdO
	 F61OJgRVUv4sp28NUVPcWuZVlrgTjJIfYI3zRHyJFBeVT9NEqLwkf73amij4D3Tx12
	 5BH1tM04W83g0xtXbPC1rKNU4EP8JSl7pCZdzUVbXWo3v16Cim4qiexK9yXNK6jUp7
	 O2wEmDl32kvIE9d+np8Yly7gkcZUzbAqXnHzCjUB+xjTIqNwGlPj+g3UR22JyPDhMx
	 /6QF1GVYXA2/rEsHi3p3WbQkHMw+gJel5fE2yNSB3KYyGvYIh/DyxhQoqhCVlT33nj
	 9DU1b1lDLyr8Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 3/7] x86/bugs: Fix BHI handling of RRSBA
Date: Wed, 10 Apr 2024 22:40:47 -0700
Message-ID: <6f56f13da34a0834b69163467449be7f58f253dc.1712813475.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712813475.git.jpoimboe@kernel.org>
References: <cover.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARCH_CAP_RRSBA check isn't correct: RRSBA may have already been
disabled by the Spectre v2 mitigation (or can otherwise be disabled by
the BHI mitigation itself if needed).  In that case retpolines are fine.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 27d6d64eeec3..0755600d5d18 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1538,20 +1538,25 @@ static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 	return SPECTRE_V2_RETPOLINE;
 }
 
+static bool __ro_after_init rrsba_disabled;
+
 /* Disable in-kernel use of non-RSB RET predictors */
 static void __init spec_ctrl_disable_kernel_rrsba(void)
 {
-	u64 ia32_cap;
+	if (rrsba_disabled)
+		return;
+
+	if (!(ia32_cap & ARCH_CAP_RRSBA)) {
+		rrsba_disabled = true;
+		return;
+	}
 
 	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
-
-	if (ia32_cap & ARCH_CAP_RRSBA) {
-		x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
-		update_spec_ctrl(x86_spec_ctrl_base);
-	}
+	x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
+	update_spec_ctrl(x86_spec_ctrl_base);
+	rrsba_disabled = true;
 }
 
 static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
@@ -1652,9 +1657,11 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
-		return;
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		spec_ctrl_disable_kernel_rrsba();
+		if (rrsba_disabled)
+			return;
+	}
 
 	if (spec_ctrl_bhi_dis())
 		return;
@@ -2809,8 +2816,7 @@ static const char * const spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !(ia32_cap & ARCH_CAP_RRSBA))
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Syscall hardening, KVM: SW loop";
-- 
2.44.0


