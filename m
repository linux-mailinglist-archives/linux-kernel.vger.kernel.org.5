Return-Path: <linux-kernel+bounces-139796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101758A07D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF01F22237
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0113CA93;
	Thu, 11 Apr 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ0uQD+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B613C9DE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814118; cv=none; b=tvJGgSPBFVbG2zH8qFPhphaJK9meMyFQrQTdXzRwOgWCG9Og5o8TgLxRLyDzA6U9PMGMArEqAb+UMo+b9ZG6QQgcugncQDQZKDdCkJN4s99WZkNaaBMCYFPantUcKXn1mlJ7Wz4pR6EKuzJ4lcqfCNSw6hnIV3+OtGse/LrcoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814118; c=relaxed/simple;
	bh=bjH/hA/VjvWBhWBiH5gqQ//vbhB5hJhCQRISe3nTC2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb4xLiB9civl0pUIzlXR1DD6uiAC433SC02rt9gEcJyCX5nkjml2Cnwkuz84JhhIuC317ARP31zgAMJtp2FzpdIg5zOQlzwQKUy1bDU2p9ZRWVWI0OUcTJC71c6H2DbIFSFNY33uqAQ1lEQGOnFyo8yPg2ifNcanIhgQdcO+EV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ0uQD+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A4C43601;
	Thu, 11 Apr 2024 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712814118;
	bh=bjH/hA/VjvWBhWBiH5gqQ//vbhB5hJhCQRISe3nTC2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZ0uQD+Ba9XDmG0qJoleQfk1yM9qJnN0mcY3uxOmjW3iy2uwm8STjOsvaFRLZ3dgJ
	 f4qa4ZexQnBFfDukiimZqrfu+OQ1wP1G8wDcsKSPQIcPyR1QJAyE5cI+Zz95HQCPa5
	 7aJN1+lj+f7NHjSXBcsmmYqNtu3iqS62igu4jSVNq9O5QUuMiMVNiOQK7q4Wby/38F
	 w55CVtSY2bPW2Fa0NZS1scZPLLW5UfAYzNR3KhQGfeq+1KmQendh6/z4BgcHRv6sHn
	 Xc6ISEk5g8S0Z3HeTiHJVNycpPI/+lPt7JkTccpyYy/YdGtg9BkhK0S5PEAmab+BV3
	 xRhffogWQjaRw==
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
Subject: [PATCH 2/7] x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
Date: Wed, 10 Apr 2024 22:40:46 -0700
Message-ID: <9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org>
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

There's no need to keep reading MSR_IA32_ARCH_CAPABILITIES over and
over.  It's even read in the BHI sysfs function which is a big no-no.
Just read it once and cache it.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 295463707e68..27d6d64eeec3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -61,6 +61,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
+static u64 __ro_after_init ia32_cap;
+
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
 void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
@@ -144,6 +146,8 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	ia32_cap = x86_read_arch_cap_msr();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
@@ -301,8 +305,6 @@ static const char * const taa_strings[] = {
 
 static void __init taa_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
@@ -341,7 +343,6 @@ static void __init taa_select_mitigation(void)
 	 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
 	 * update is required.
 	 */
-	ia32_cap = x86_read_arch_cap_msr();
 	if ( (ia32_cap & ARCH_CAP_MDS_NO) &&
 	    !(ia32_cap & ARCH_CAP_TSX_CTRL_MSR))
 		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
@@ -401,8 +402,6 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
 	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
 	     cpu_mitigations_off()) {
@@ -413,8 +412,6 @@ static void __init mmio_select_mitigation(void)
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
 	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
@@ -508,7 +505,7 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
@@ -659,8 +656,6 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
@@ -669,7 +664,6 @@ static void __init srbds_select_mitigation(void)
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
 	 * by Processor MMIO Stale Data vulnerability.
 	 */
-	ia32_cap = x86_read_arch_cap_msr();
 	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
 	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
@@ -813,7 +807,7 @@ static void __init gds_select_mitigation(void)
 	/* Will verify below that mitigation _can_ be disabled */
 
 	/* No microcode */
-	if (!(x86_read_arch_cap_msr() & ARCH_CAP_GDS_CTRL)) {
+	if (!(ia32_cap & ARCH_CAP_GDS_CTRL)) {
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
 			/*
 			 * This only needs to be done on the boot CPU so do it
@@ -1908,8 +1902,6 @@ static void update_indir_branch_cond(void)
 /* Update the static key controlling the MDS CPU buffer clear in idle */
 static void update_mds_branch_idle(void)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable the idle clearing if SMT is active on CPUs which are
 	 * affected only by MSBDS and not any other MDS variant.
@@ -2818,7 +2810,7 @@ static const char * const spectre_bhi_state(void)
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
 	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
+		 !(ia32_cap & ARCH_CAP_RRSBA))
 		return "; BHI: Retpoline";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Syscall hardening, KVM: SW loop";
-- 
2.44.0


