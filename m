Return-Path: <linux-kernel+bounces-34067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E558372CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94BF1F268CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742153FE48;
	Mon, 22 Jan 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as2xwiJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C63B790
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952541; cv=none; b=n1gYeeNS+X+02U5v44XAPwb/pwSqEi8DHypkRtTN89MXrPtLcezo9sPJJt8K9Fbv9Rjl9knUpuVGlPZF3YMq+1IdfRyTyG6NCE+3cWu82VaQYBWHOtkjKZtrF9U/G6UHIwF0/pjbUW2REO19KkZr/N41Klm1BE8sthx69gKxqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952541; c=relaxed/simple;
	bh=Yp3pAaYRRf0J2cG3b+0xvAh7A7FfgWxJ9OADhwEKQVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=liw1XRT9HnikeSyoWJ8jddk16xFcILXGYM6VOUKTcU2TeV2irfZyZfRhwsJzlnwRZIRQULlPqKtqQeifG8axJcAcenJyAPX1tglVfvgERMDFclZCNaOfZOnw0P2dWQFdycalFLg4HZoL1qRj9K/fCpR0MKgQCh1cKDsNdgGsHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as2xwiJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90950C43390;
	Mon, 22 Jan 2024 19:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705952541;
	bh=Yp3pAaYRRf0J2cG3b+0xvAh7A7FfgWxJ9OADhwEKQVE=;
	h=From:Date:Subject:To:Cc:From;
	b=as2xwiJslDxZZwdOzqMS0GCZVNrYjMf0xJxTJtftlYDVocwh0CFDxTCY9j1VWSZU5
	 K4IyV8U+jZgkcUnsFueDw1+919N8eakg6TXFkH1tNDIRszIzPsdzYd+2qMF2+cL+IW
	 X3LOaK2gHODhp/kJ+MOS4ikmYDXgIOPBN0Owj4cTrHInVTXLn0O7CkAL7WAObyVDX+
	 MYFPb+ZtwojRhZff1DvIa0gP8Ma7rerx81AOLT4wrguDjk58mYTFBUGwY5+0yLzv8a
	 OQLAedusj3o2c40k1rfjL0R8O9egBIIy40zTb8S2hsXWvrC7lFLjT67HAtWMdk/aBh
	 nqN5Tjq2UDrnw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 19:42:14 +0000
Subject: [PATCH v4] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-sve-trap-mitigation-v4-1-54e0d78a3ae9@kernel.org>
X-B4-Tracking: v=1; b=H4sIABXFrmUC/43NQQ6CMBCF4auYrq1hpoW2rryHcYF0wEYF0pJGQ
 7i7hYXGmBCX/yTvm5EF8o4C229G5im64Lo2hdxuWHUp24a4s6kZZigynSle+nsheYjEB1/2/O4
 G15RDWnEkRVgUotLSsLTvPdXusdjHU+qLC0Pnn8urCPP1HzUCB24NElmwqPP8cCXf0m3X+YbNb
 MQPZUCsUZgoOFuqa6ERFPxQ4k0BrFMiUVIpU5lESS2+qGmaXtqBO+VZAQAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=7671; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Yp3pAaYRRf0J2cG3b+0xvAh7A7FfgWxJ9OADhwEKQVE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrsUamhFZCq2Og+wdNXdoF2mC9eXdkz1NdBqyeLNI
 Jrf6Bh6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa7FGgAKCRAk1otyXVSH0Mk/CA
 CAx72X0s3Gfu7Dgs9YkO83RBb4sCGTBc3zpuAPx6pRvH5UDJwpjaqAdGhNIxcivs0bnkdcwUml6/tO
 5dupVfQBj/AfuydJ8NhueKf5HkSMPAbTIWwS3DVBemZLUAtID4vIQePRDcJMGB4bcCRPxNfqmCjcyc
 Zen+ePtLP6nTam6yEqehOXgGaQn9z+E4iAReslvkCCMMxIIKjNWT5rdsJQ0Dt2XINdmi2K7OK1yzfm
 fWCMX4aP9KdcIyjoCpVTB/LmblLxADVcP77RyFwNPebKrWbOag9cQGfLwFOxL6zf+lYxsWlhXBP5Ah
 OBFB7R7b7/uxaAg/33Ael0gCLhBrlN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we are in a syscall we take the opportunity to discard the SVE state,
saving only the FPSIMD subset of the register state. When we reload the
state from memory we reenable SVE access traps, stopping tracking SVE until
the task takes another SVE access trap. This means that for a task which is
actively using SVE many blocking system calls will have the additional
overhead of a SVE access trap.

As SVE deployment is progressing we are seeing much wider use of the SVE
instruction set, including performance optimised implementations of
operations like memset() and memcpy(), which mean that even tasks which are
not obviously floating point based can end up with substantial SVE usage.

It does not, however, make sense to just unconditionally use the full SVE
register state all the time since it is larger than the FPSIMD register
state so there is overhead saving and restoring it on context switch and
our requirement to flush the register state not shared with FPSIMD on
syscall also creates a noticeable overhead on system call.

I did some instrumentation which counted the number of SVE access traps
and the number of times we loaded FPSIMD only register state for each task.
Testing with Debian Bookworm this showed that during boot the overwhelming
majority of tasks triggered another SVE access trap more than 50% of the
time after loading FPSIMD only state with a substantial number near 100%,
though some programs had a very small number of SVE accesses most likely
from startup. There were few tasks in the range 5-45%, most tasks either
used SVE frequently or used it only a tiny proportion of times. As expected
older distributions which do not have the SVE performance work available
showed no SVE usage in general applications.

This indicates that there should be some useful benefit from reducing the
number of SVE access traps for blocking system calls like we did for non
blocking system calls in commit 8c845e273104 ("arm64/sve: Leave SVE enabled
on syscall if we don't context switch"). Let's do this by counting the
number of times we have loaded FPSIMD only register state for SVE tasks
and only disabling traps after some number of times, otherwise leaving
traps disabled and flushing the non-shared register state like we would on
trap.

I pulled 64 out of thin air for the number of flushes to do, there is
doubtless room for tuning here. Ideally we would be able to tell if the
task is actually using SVE but without using performance counters (which
would be substantial work) we can't currently tell. I picked the number
because so many of the tasks using SVE used it so frequently.

This means that for a task which is actively using SVE the number of SVE
access traps will be substantially reduced but applications which use SVE
only very infrequently will avoid the overheads associated with tracking
SVE state once the counter expires.

There should be no functional change resulting from this, it is purely a
performance optimisation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v4:
- Rebase onto v6.8-rc1.
- Link to v3: https://lore.kernel.org/r/20231113-arm64-sve-trap-mitigation-v3-1-4779c9382483@kernel.org

Changes in v3:
- Rebase onto v6.7-rc1.
- Link to v2: https://lore.kernel.org/r/20230913-arm64-sve-trap-mitigation-v2-1-1bdeff382171@kernel.org

Changes in v2:
- Rebase onto v6.6-rc1.
- Link to v1: https://lore.kernel.org/r/20230807-arm64-sve-trap-mitigation-v1-1-d92eed1d2855@kernel.org
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/kernel/fpsimd.c         | 43 ++++++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5b0a04810b23..a99ea422f744 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -162,6 +162,7 @@ struct thread_struct {
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
 	void			*sme_state;	/* ZA and ZT state, if any */
+	unsigned int		sve_timeout;    /* For SVE trap suppression */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a5dc6f764195..50770ea13db7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -354,6 +354,7 @@ static void task_fpsimd_load(void)
 {
 	bool restore_sve_regs = false;
 	bool restore_ffr;
+	unsigned long sve_vq_minus_one;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(preemptible());
@@ -362,18 +363,12 @@ static void task_fpsimd_load(void)
 	if (system_supports_sve() || system_supports_sme()) {
 		switch (current->thread.fp_type) {
 		case FP_STATE_FPSIMD:
-			/* Stop tracking SVE for this task until next use. */
-			if (test_and_clear_thread_flag(TIF_SVE))
-				sve_user_disable();
 			break;
 		case FP_STATE_SVE:
 			if (!thread_sm_enabled(&current->thread) &&
 			    !WARN_ON_ONCE(!test_and_set_thread_flag(TIF_SVE)))
 				sve_user_enable();
 
-			if (test_thread_flag(TIF_SVE))
-				sve_set_vq(sve_vq_from_vl(task_get_sve_vl(current)) - 1);
-
 			restore_sve_regs = true;
 			restore_ffr = true;
 			break;
@@ -392,6 +387,15 @@ static void task_fpsimd_load(void)
 		}
 	}
 
+	/*
+	 * If SVE has been enabled we may keep it enabled even if
+	 * loading only FPSIMD state, so always set the VL.
+	 */
+	if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
+		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
+		sve_set_vq(sve_vq_minus_one);
+	}
+
 	/* Restore SME, override SVE register configuration if needed */
 	if (system_supports_sme()) {
 		unsigned long sme_vl = task_get_sme_vl(current);
@@ -418,6 +422,25 @@ static void task_fpsimd_load(void)
 	} else {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+
+		/*
+		 * If the task had been using SVE we keep it enabled
+		 * when loading FPSIMD only state for a number of
+		 * times to minimise overhead for tasks actively using
+		 * SVE, disabling it periodicaly to enusre that tasks
+		 * that use SVE intermittently do eventually avoid the
+		 * overhead of carrying SVE state.  The timeout is
+		 * initialised when we take a SVE trap in in do_sve_acc().
+		 */
+		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
+			if (!current->thread.sve_timeout) {
+				clear_thread_flag(TIF_SVE);
+				sve_user_disable();
+			} else {
+				current->thread.sve_timeout--;
+				sve_flush_live(true, sve_vq_minus_one);
+			}
+		}
 	}
 }
 
@@ -1364,6 +1387,13 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 
 	get_cpu_fpsimd_context();
 
+	/*
+	 * We will keep SVE enabled when loading FPSIMD only state
+	 * this many times to minimise traps when userspace is
+	 * actively using SVE.
+	 */
+	current->thread.sve_timeout = 64;
+
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
@@ -1591,6 +1621,7 @@ void fpsimd_flush_thread(void)
 		/* Defer kfree() while in atomic context */
 		sve_state = current->thread.sve_state;
 		current->thread.sve_state = NULL;
+		current->thread.sve_timeout = 0;
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20230807-arm64-sve-trap-mitigation-2e7e2663c849

Best regards,
-- 
Mark Brown <broonie@kernel.org>


