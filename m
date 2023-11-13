Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033287EA240
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjKMRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjKMRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:43:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07025171C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:43:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ADEC433C8;
        Mon, 13 Nov 2023 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699897396;
        bh=VTOqRu2j+Jfg1TJx8sdDIZvNn+HfD0mSJg866/OgXJo=;
        h=From:Date:Subject:To:Cc:From;
        b=W2zJiKs21A3Ngac8X48jTKClpU8ZgZ9rYGHZnD73cG+lqnoohxcner3q1j52W0gOG
         GiPE057eFrS0trt6YU3J6lA0vWW0dhn49JckgU3fzY4gbruUYCpdn9+n6aXR8y79iD
         jC0OQY7sPDSRrIoelkFD/saDrM+fpKIoAXbQCGmdwAjcn57niVqpu6u8vnv1NEsEDr
         LEwfqNo5ohIliQ9Ruh1p5lvmgJyLYZRCrjuiWDUj7lq8ayaTFN+/ClDTfZxrhh41l/
         EzYw7h/n+XefCR2gsFt1EVKO7m4Ofy3mVWzkL7nPI6lmXR59SSR0TKMWdsv8s0+2OS
         EMXsNmC8HgL9g==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 13 Nov 2023 17:37:00 +0000
Subject: [PATCH v3] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-arm64-sve-trap-mitigation-v3-1-4779c9382483@kernel.org>
X-B4-Tracking: v=1; b=H4sIALteUmUC/43NywrCMBCF4VcpWRvpTHp15XuIi9hM26C9MAlBK
 X13027Ejbj8B843i3DElpw4JYtgCtbZaYyhDoloej12JK2JLTBFlVZpKTUPRSZdIOlZz3Kw3nb
 ax5VEKgmLQjVVVou4n5la+9ztyzV2b52f+LW/CrBd/1EDSJCmRiIDBqs8P9+JR3ocJ+7Exgb8U
 DWoXxRGCm6G2lZVCCV8Ueu6vgF4O1KNDgEAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7536; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VTOqRu2j+Jfg1TJx8sdDIZvNn+HfD0mSJg866/OgXJo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlUmAy2mDdbfWAS/TSho4NwVkX9ethI03sKj9cpvHf
 CJyTVkWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVJgMgAKCRAk1otyXVSH0JUsB/
 9hnYveiDqNLMEdXQyMfk7RVdoRwdgMeF8biYAiTi8yDZgoUKBqHELhyNAveI20hFW+xjjiPZ/XbH+c
 QEy9mfwughCr/gtPo8r9f2w8QP9XPqOfAhefmbqfwsVxFGEsX9knjrN69H/fk7/PxHNTeHfAKrUcot
 EAb9/xtDOcJQt9cRsVyY36QuzYmZP+1kvYuyoAT9MVyNprkEJP9UkpxMDencfYAAq+UnTsJ5OnZup6
 JGtuPZQyndYdeNz3YLnzoB/v0DT3RETXpP0f6GhHwknlTrRhfy9CTFzoK1+yPl2D0BWhWVZdfYAOuY
 2DExP6pkP2ElFJcQJYwMal2guMHJc0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e5bc54522e71..44136181cba1 100644
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
index 1559c706d32d..29dc89404324 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -381,6 +381,7 @@ static void task_fpsimd_load(void)
 {
 	bool restore_sve_regs = false;
 	bool restore_ffr;
+	unsigned long sve_vq_minus_one;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
@@ -388,18 +389,12 @@ static void task_fpsimd_load(void)
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
@@ -418,6 +413,15 @@ static void task_fpsimd_load(void)
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
@@ -444,6 +448,25 @@ static void task_fpsimd_load(void)
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
 
@@ -1390,6 +1413,13 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 
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
 
@@ -1582,6 +1612,7 @@ void fpsimd_flush_thread(void)
 		/* Defer kfree() while in atomic context */
 		sve_state = current->thread.sve_state;
 		current->thread.sve_state = NULL;
+		current->thread.sve_timeout = 0;
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20230807-arm64-sve-trap-mitigation-2e7e2663c849

Best regards,
-- 
Mark Brown <broonie@kernel.org>

