Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16EC7732E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHGWVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHGWVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA48F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77D1622B1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 22:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1A9C433C7;
        Mon,  7 Aug 2023 22:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691446894;
        bh=xOUwFjdJ4X0S873rAYEoVXdGL+g6dxq/FSauta25+d4=;
        h=From:Date:Subject:To:Cc:From;
        b=ZlkWPHtzRcQthsqych0C/vWlxqvWgKs7n6eTnaGpkHit/gUk6mINEh2ZQeXytOlUi
         UttlSU9E1qvpgCw9DndNRGnfShHWozx1OI7n+ea4VC4ooQ1d3Gf5NJFZk0cKZFUP85
         Bkwq5PedVJ8BnfAYrY8cIjRaPTW0EO6N5/hK76e9WhyFw+R2YGV9DyFuaepkhdV61T
         nFIRCbB1FN5JsSCVAqAvM5noAN3vvczqYNyYSaIIhfN71JwXIH3Kci5ScL/eIWOZll
         Ikv+H98gVjkcDW15Hzh+GI/M2UppsW1i7BRlmTUJ3V7rJ4MYFSGRgyd31NnItNCjOs
         D97l8HFnNm1YQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:20:38 +0100
Subject: [PATCH] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-sve-trap-mitigation-v1-1-d92eed1d2855@kernel.org>
X-B4-Tracking: v=1; b=H4sIADVu0WQC/x3MQQqAIBBA0avErBswFbOuEi2kppqFFaNEEN09a
 fkX7z+QSJgS9NUDQhcnPvYSTV3BtIV9JeS5NGiljfKqxSDRWUwXYZZwYuTMa8hFoaaWtHNm8ra
 D4k+hhe//PYzv+wGnfVnVawAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7237; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xOUwFjdJ4X0S873rAYEoVXdGL+g6dxq/FSauta25+d4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0W5sjiIRyf9R6UXLfAPxONbfUZ7yeeIBBGi3xGWn
 1TO/Ag+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFubAAKCRAk1otyXVSH0PbgB/
 4pr8gOCYB2Ej4oexZ7LLxPoKBaXWlYlaihkElwyF28quowaQbVv1Suh73TjG7QTcrfoc0T7i++rQK9
 wiASeBF9XwiQRADevR+KWthNB9OQUSqz7P7XoiNGHG+qZGv1PK2BeuVFSzZc57SxYSWTL+JKyou12c
 Mxg6O9yvvfY7iL53p+tBKCT7/0gDeI4XzGkHhfhkVYISDZhg/0SptSgpqe7eSPQ6pjdku8gka1Rr4s
 j6UNbFt9b3PJ66okm5FPV16yOJmlEB9WydQVHoMapcXO6DmPjurfqIiOMf403YY/Y7+ChvvISLxZZD
 lF7pJQUzJwvowNN71mpuQ5xKPNW+y5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/kernel/fpsimd.c         | 43 ++++++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 3918f2a67970..ed4d9fa730d6 100644
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
index 75c37b1c55aa..d5b0222baed6 100644
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
 
@@ -1471,6 +1494,13 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 
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
 
@@ -1654,6 +1684,7 @@ void fpsimd_flush_thread(void)
 		/* Defer kfree() while in atomic context */
 		sve_state = current->thread.sve_state;
 		current->thread.sve_state = NULL;
+		current->thread.sve_timeout = 0;
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230807-arm64-sve-trap-mitigation-2e7e2663c849

Best regards,
-- 
Mark Brown <broonie@kernel.org>

