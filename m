Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22307776FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjHJL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjHJL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2359C;
        Thu, 10 Aug 2023 04:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A533165984;
        Thu, 10 Aug 2023 11:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BBBC433C8;
        Thu, 10 Aug 2023 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691666905;
        bh=Me+e9ML6CgkKjftPxzYhGhgVehw49yScpv6EvPjDSgs=;
        h=From:Date:Subject:To:Cc:From;
        b=a5UHdsmxhL25LF7SfAKBucfNreOSVU2r5hR7/QhIYrt/S2Ac319sUwGnoQ6/3225M
         JVVmQc+5oOJKeMZGT7+NGARLiefZ80ewxBGElqR9LvjPcMrqALukfIZNGxDRLbNvqZ
         ao0DYx9WEc5CxxUEIqzRf0d8xvAUZRqeb2AeXsLjZiyCG/TZF1IgWDRZtaNOPLWD9m
         I/OrX4/8zcEVjz4M92Ek9/jp5OFlMSXm03jqM0XO5zaEbOzek5NQ7utW9ttZazalCm
         v0DReiS+JE4rr3GYHVGl2cotS2LP+wATZUU0EYo2NoJ0ahOHGaFnTIQF9vFL+w59dV
         whLpmbS3XRJRQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 10 Aug 2023 12:28:19 +0100
Subject: [PATCH] arm64/ptrace: Ensure that SME is set up for target when
 writing SSVE state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-arm64-fix-ptrace-race-v1-1-a5361fad2bd6@kernel.org>
X-B4-Tracking: v=1; b=H4sIANLJ1GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNL3cSiXDMT3bTMCt2CkqLE5FRdMJGSZGFqapSWZGlhmqQE1FtQlAp
 UAjY3Ora2FgDKZd0tZwAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4947; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Me+e9ML6CgkKjftPxzYhGhgVehw49yScpv6EvPjDSgs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk1MnWH0qCwoS0bpMXisFIifer56zHw9jZfo6+nuhk
 A/m/gCCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNTJ1gAKCRAk1otyXVSH0HBAB/
 97WesYrytvtvoryIpbQZyJuhPczQLMBmqXVKp6CccgFwKaimR1AlycJRNa5NEyn3c2zWWn1lBcksXK
 p+F0fpPTM+jWb54GxE9wmpM28jsevBrdKD2iDaMIUCPgvK7Haa1MbczPqRFxC8Dd0CXxdgei/qXsmN
 DyR1jJDlRm7s0s+kV+sawmZET3SykEd1GjGkGpSZe2bCRxyFeu9St1wKPI243n82hFmRKTx6SH4UvV
 87J3WACkkY7FZ0gmFrfRyfMGEvWLvTnv3bYiqLYrX5lHkmfRCvD6E9sU3H/yd/vDQOIdBFEh+h06cE
 YCSqYRX3x+uhYKuK6fJamFurAZs+G4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use NT_ARM_SSVE to either enable streaming mode or change the
vector length for a process we do not currently do anything to ensure that
there is storage allocated for the SME specific register state.  If the
task had not previously used SME or we changed the vector length then
the task will not have had TIF_SME set or backing storage for ZA/ZT
allocated, resulting in inconsistent register sizes when saving state
and spurious traps which flush the newly set register state.

We should set TIF_SME to disable traps and ensure that storage is
allocated for ZA and ZT if it is not already allocated.  This requires
modifying sme_alloc() to make the flush of any existing register state
optional so we don't disturb existing state for ZA and ZT.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/fpsimd.h |  4 ++--
 arch/arm64/kernel/fpsimd.c      |  6 +++---
 arch/arm64/kernel/ptrace.c      | 12 ++++++++++--
 arch/arm64/kernel/signal.c      |  2 +-
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 67f2fb781f59..8df46f186c64 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -356,7 +356,7 @@ static inline int sme_max_virtualisable_vl(void)
 	return vec_max_virtualisable_vl(ARM64_VEC_SME);
 }
 
-extern void sme_alloc(struct task_struct *task);
+extern void sme_alloc(struct task_struct *task, bool flush);
 extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
@@ -388,7 +388,7 @@ static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
 static inline void sme_smstop(void) { }
 
-static inline void sme_alloc(struct task_struct *task) { }
+static inline void sme_alloc(struct task_struct *task, bool flush) { }
 static inline void sme_setup(void) { }
 static inline unsigned int sme_get_vl(void) { return 0; }
 static inline int sme_max_vl(void) { return 0; }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 75c37b1c55aa..087c05aa960e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1285,9 +1285,9 @@ void fpsimd_release_task(struct task_struct *dead_task)
  * the interest of testability and predictability, the architecture
  * guarantees that when ZA is enabled it will be zeroed.
  */
-void sme_alloc(struct task_struct *task)
+void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.sme_state) {
+	if (task->thread.sme_state && flush) {
 		memset(task->thread.sme_state, 0, sme_state_size(task));
 		return;
 	}
@@ -1515,7 +1515,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 	}
 
 	sve_alloc(current, false);
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.sve_state || !current->thread.sme_state) {
 		force_sig(SIGKILL);
 		return;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5b9b4305248b..95568e865ae1 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -881,6 +881,14 @@ static int sve_set_common(struct task_struct *target,
 			break;
 		case ARM64_VEC_SME:
 			target->thread.svcr |= SVCR_SM_MASK;
+
+			/*
+			 * Disable tramsp and ensure there is SME
+			 * storage but preserve any currently set
+			 * values in ZA/ZT.
+			 */
+			sme_alloc(target, false);
+			set_tsk_thread_flag(target, TIF_SME);
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -1100,7 +1108,7 @@ static int za_set(struct task_struct *target,
 	}
 
 	/* Allocate/reinit ZA storage */
-	sme_alloc(target);
+	sme_alloc(target, true);
 	if (!target->thread.sme_state) {
 		ret = -ENOMEM;
 		goto out;
@@ -1171,7 +1179,7 @@ static int zt_set(struct task_struct *target,
 		return -EINVAL;
 
 	if (!thread_za_enabled(&target->thread)) {
-		sme_alloc(target);
+		sme_alloc(target, true);
 		if (!target->thread.sme_state)
 			return -ENOMEM;
 	}
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e304f7ebec2a..c7ebe744c64e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -475,7 +475,7 @@ static int restore_za_context(struct user_ctxs *user)
 	fpsimd_flush_task_state(current);
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.sme_state) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		clear_thread_flag(TIF_SME);

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230809-arm64-fix-ptrace-race-db8552fb985b

Best regards,
-- 
Mark Brown <broonie@kernel.org>

