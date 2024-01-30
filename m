Return-Path: <linux-kernel+bounces-43665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC591841761
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6E91C233A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B07314F78;
	Tue, 30 Jan 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlhllx2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57D125CA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573670; cv=none; b=HbvaUJG0fD7TgTcIHAOWzTIbJS2eSiEvad0C5rZV4buyroZsQWfp/ZHn9OcTh0y2TeTnXc6MiKdNnlmN5JxpHqFOyHoi0dZDcbkTQLms3zjzu8LPyjNdnAlnL+A0Ur+Izz+Q1NfO9SrxjVoMn9C4DIguOnZcJ6GJ9J+EzPftAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573670; c=relaxed/simple;
	bh=ZTo5ZwG70N90xxtm+/9tRfhfP4BHWTK7W1uC77KuLOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeWRSyMjAxoXWEs6WEdcE+KCRhv9cLNSnmmoFD+8MqzoXT9lr4584IgBSpaLp5a2jW8GpXoQN+c7LuEUJeoFJKeZpmD1ZT/APLyCNDuR6cdi0pXkCUPa3Y205WNZ7LfK7UUVaNqQNUk9FapVJ97jWtvBxF1epUyR3N/1ioZnDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlhllx2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F9BC43390;
	Tue, 30 Jan 2024 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573670;
	bh=ZTo5ZwG70N90xxtm+/9tRfhfP4BHWTK7W1uC77KuLOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tlhllx2rYUBERQO/TVeu+jO1tBlv2SsdA69Fb82Zi8Ueh/FvqjtKAfTleIrzdq11p
	 kVMxq4IxOU5DaXCK2HeNRbeEJFLmPtEuUKL22QmbE7qqwI2ZPmHQnSVC9fLdoLfdpa
	 o567PTPk/6uPl3ln20ArrqRQcw0B3cMCAqy5ivJ8VzCVYAoHX18kk7g5QdzgUOcpre
	 h0/jS3wiG4AjxaF86GEAMr/R4HLB+CORxt+fqzXTQBP7SnpM3iEDZg/IjE7BeUkbEM
	 ZzPqBSoL9h2yxvAdMIHXx26vc9U0Rp9vLO1c0FgM7VkraAa/ZQyE2QPqrcSvtG1hw3
	 YWJmGl5Hjxodg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Jan 2024 00:02:48 +0000
Subject: [PATCH 1/2] arm64/sme: Restore SMCR on exit from suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-arm64-sme-resume-v1-1-0e60ebba18df@kernel.org>
References: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
In-Reply-To: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZTo5ZwG70N90xxtm+/9tRfhfP4BHWTK7W1uC77KuLOk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBluD9hwBczBmoZohtBPPFhLyZwbLluJz2W6O5QONUl
 43GzPTKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbg/YQAKCRAk1otyXVSH0MtoB/
 9id4s9xk+85E5vWs/iH8YfCgW0RW41QLhxe3supGv4xCY6wCEAyDqGmcDPWBwVxLkHskdh33bVMbRz
 KBq6U5u9rCXkckAITaFHFf8ycMwqBykW/WLoM1P5B7IdQyzzj6GYj+nzI/nqbECDBPOaQqZatc0nAi
 2qFCQ3fwVOxlY+8J5H7bboUrULAD2y5XxyzRcbw5kD3LmFkjSZFOdODvdxm+Mysvgko+ltfNiThi3L
 +k0/EbQbm/dL3Yhk8uIihyyRm+Y62RYygYlCrFcud3tYuYgAqH1H53Rez3LBngy1TT0jCHYFgF3QZ3
 b3RJStCKjjUTSnNWz5AhUNdBpAtsDu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fields in SMCR_EL1 reset to an architecturally UNKNOWN value. Since we
do not otherwise manage the traps configured in this register at runtime we
need to reconfigure them after a suspend in case nothing else was kind
enough to preserve them for us.

The vector length will be restored as part of restoring the SME state for
the next SME using task.

Fixes: a1f4ccd25cc2 (arm64/sme: Provide Kconfig for SME)
Reported-by: Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h |  2 ++
 arch/arm64/kernel/fpsimd.c      | 13 +++++++++++++
 arch/arm64/kernel/suspend.c     |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50e5f25d3024..7780d343ef08 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -386,6 +386,7 @@ extern void sme_alloc(struct task_struct *task, bool flush);
 extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
+extern void sme_suspend_exit(void);
 
 /*
  * Return how many bytes of memory are required to store the full SME
@@ -421,6 +422,7 @@ static inline int sme_max_vl(void) { return 0; }
 static inline int sme_max_virtualisable_vl(void) { return 0; }
 static inline int sme_set_current_vl(unsigned long arg) { return -EINVAL; }
 static inline int sme_get_current_vl(void) { return -EINVAL; }
+static inline void sme_suspend_exit(void) { }
 
 static inline size_t sme_state_size(struct task_struct const *task)
 {
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a5dc6f764195..69201208bb13 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1311,6 +1311,19 @@ void __init sme_setup(void)
 		get_sme_default_vl());
 }
 
+void sme_suspend_exit(void)
+{
+	u64 smcr = 0;
+
+	if (!system_supports_sme())
+		return;
+
+	if (system_supports_fa64())
+		smcr |= SMCR_ELx_FA64;
+
+	write_sysreg_s(smcr, SYS_SMCR_EL1);
+}
+
 #endif /* CONFIG_ARM64_SME */
 
 static void sve_init_regs(void)
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index eca4d0435211..eaaff94329cd 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -12,6 +12,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/exec.h>
+#include <asm/fpsimd.h>
 #include <asm/mte.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
@@ -80,6 +81,8 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	spectre_v4_enable_mitigation(NULL);
 
+	sme_suspend_exit();
+
 	/* Restore additional feature-specific configuration */
 	ptrauth_suspend_exit();
 }

-- 
2.30.2


