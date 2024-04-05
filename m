Return-Path: <linux-kernel+bounces-133420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422589A376
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2850E2817F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A6171672;
	Fri,  5 Apr 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdPxAeFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45391171669
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337828; cv=none; b=qOl9ftG3TmL0r6JxQVYiIRwqndpp1M8VyCLWXeBAvSD7jgmarJk8u5cOjFGTCMZ4GPTiQJ42WrEcZM/j6WFqBmfeua3bYvCc5N9Mka4/7TgSeV4wh5ncmAXjceV/bUxx4j/coIzwLN2roszaTImB7eKwadVq3bPe2KFda1nNDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337828; c=relaxed/simple;
	bh=Po4z8MFmbOgXf7U3RqPoragcYfCz5oLw3RhCoJjPO2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t1y4dX3LCcMVJhAJ8ui0EhFCY4VGr4eip+38y3pPA0Jl6YAOG34+h92vieJvDgpoXPn7A4V8LyBxuqzbBWGNoovcWokceD7fhfcRMmFnWSyeBh12BFbo+HZEd4eJinHkJaQwX64ZCqVsxRgU0UTrcBXXAcIpSes2uIPI0P7i/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdPxAeFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77276C433F1;
	Fri,  5 Apr 2024 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712337827;
	bh=Po4z8MFmbOgXf7U3RqPoragcYfCz5oLw3RhCoJjPO2c=;
	h=From:Date:Subject:To:Cc:From;
	b=EdPxAeFnLp1B+M57JzPFUrHkg6kXQJwji5NJfRjrpkowTz3QNR5n/ON7fNKomJJDs
	 Hgx3HxvRukRUakdINvU7KmeXA12Ddaa7e+v4bWAt+SNepBaW+wc9c8QZzEgaY3pkkx
	 NNp9uTor/VkOSEC4QE3iDp4/eR5Mrg29JoaSkw+OFLrfBwrgErlPmndDjgATea+DlP
	 k5VNklWltlF+HU39WDToPOHXzYWlpSCDNjN4RGzgWAvrumuD6VND9CaNa9THavtI4a
	 GHxe1C0N/fSjVEtjZ0xVqqGAVU3ab4JdkHkMIezQxYW5i4PJswzy9Tos1fbXMC3yZO
	 yuM1ZG0jokqOw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 05 Apr 2024 18:23:35 +0100
Subject: [PATCH v5] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-arm64-sve-trap-mitigation-v5-1-126fe2515ef1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJYzEGYC/43NQWrDMBCF4asErauiGcmWlFXuEbJQrLEj2thBM
 iIl+O6dBNJSAqbLf+B9cxOFcqIitpubyFRTSdPI0bxtRHcK40AyRW6BCrVyysqQz62RpZKcc7j
 Ic5rTEGZeSSRL2La6c8YL3l8y9en6sPcH7lMq85S/Hq8q3K//UStIkNEjUYSIrml2H5RH+nyf8
 iDubMVfyoNeo5ApOEbqe+0QLLxQ+ocCWKc0U8Za33mmjNMvlHlSRgHiGmWYagypaF3Qgfwfalm
 Wbwsy+4+kAQAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7621; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Po4z8MFmbOgXf7U3RqPoragcYfCz5oLw3RhCoJjPO2c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmEDOhVRWeTz+1gIJpbReGixszPhw2mkQjv91+mhPE
 t3az8AKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZhAzoQAKCRAk1otyXVSH0H+zB/
 0Tg9/8u1Txl2w4L9qbCY22UpAOmLp5w98i5gdE7rV6XWEpQynD00aK0aPehzlRcyFrsBzwRsyzga2P
 YlBaanJjG8JbhTBTA5MZvqSpsDtUOZ2cln5Pd6r1v+ddRvHGz5UddONZF916ey6G9vojeSybJ+AWqS
 qRABPbRjlm7wveqvR5csKBPjgNQWS5oRo/6Eb+YnhPMfyZP66OyI5jrU9t4l3kqr7lWaczJVqwl4Jy
 iWulAmNKksyqsI8LIOqgyBc02cwon8im7juEFQxJWY1pIew02KXzWEPC3YmnAe/OoDtvhOiAJSU407
 JqpIGuPlg9l5bRXZO9kjW3GTN3dKFq
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
on syscall if we don't context switch"). Let's do this with a timeout, when
we take a SVE access trap record a jiffies after which we'll reeanble SVE
traps then check this whenver we load a FPSIMD only floating point state
from memory. If the time has passed then we reenable traps, otherwise we
leave traps disabled and flush the non-shared register state like we would
on trap.

The timeout is currently set to a second, I pulled this number out of thin
air so there is doubtless some room for tuning. This means that for a
task which is actively using SVE the number of SVE access traps will be
substantially reduced but applications which use SVE only very
infrequently will avoid the overheads associated with tracking SVE state
after a second. The extra cost from additional tracking of SVE state
only occurs when a task is preempted so short running tasks should be
minimally affected.

There should be no functional change resulting from this, it is purely a
performance optimisation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v5:
- Rebase onto v6.9-rc1.
- Use a timeout rather than number of state loads to decide when to
  reenable traps.
- Link to v4: https://lore.kernel.org/r/20240122-arm64-sve-trap-mitigation-v4-1-54e0d78a3ae9@kernel.org

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
 arch/arm64/kernel/fpsimd.c         | 42 ++++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f77371232d8c..7a6ed0551291 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -164,6 +164,7 @@ struct thread_struct {
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
 	void			*sme_state;	/* ZA and ZT state, if any */
+	unsigned long		sve_timeout;    /* jiffies to drop TIF_SVE */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ebb0158997ca..22d7dc420e53 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -354,6 +354,7 @@ static void task_fpsimd_load(void)
 {
 	bool restore_sve_regs = false;
 	bool restore_ffr;
+	unsigned long sve_vq_minus_one;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(preemptible());
@@ -365,18 +366,12 @@ static void task_fpsimd_load(void)
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
@@ -395,6 +390,15 @@ static void task_fpsimd_load(void)
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
@@ -421,6 +425,25 @@ static void task_fpsimd_load(void)
 	} else {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+
+		/*
+		 * If the task had been using SVE we keep it enabled
+		 * when loading FPSIMD only state for a period to
+		 * minimise overhead for tasks actively using SVE,
+		 * disabling it periodicaly to ensure that tasks that
+		 * use SVE intermittently do eventually avoid the
+		 * overhead of carrying SVE state.  The timeout is
+		 * initialised when we take a SVE trap in in
+		 * do_sve_acc().
+		 */
+		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
+			if (time_after(jiffies, current->thread.sve_timeout)) {
+				clear_thread_flag(TIF_SVE);
+				sve_user_disable();
+			} else {
+				sve_flush_live(true, sve_vq_minus_one);
+			}
+		}
 	}
 }
 
@@ -1397,6 +1420,13 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 
 	get_cpu_fpsimd_context();
 
+	/*
+	 * We will keep SVE enabled when loading FPSIMD only state for
+	 * the next second to minimise traps when userspace is
+	 * actively using SVE.
+	 */
+	current->thread.sve_timeout = jiffies + HZ;
+
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20230807-arm64-sve-trap-mitigation-2e7e2663c849

Best regards,
-- 
Mark Brown <broonie@kernel.org>


