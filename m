Return-Path: <linux-kernel+bounces-51097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B81E84866D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2001C234C3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065635EE66;
	Sat,  3 Feb 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAcGWw6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2405DF31
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965287; cv=none; b=G/XoWUP9lgEE7uf3kDu4E8oaArW3M5utc3heZmLj0AVVx0myk9unuomzs11+WmqY4DGP+6xucJQdCRlwcjdEg9bxz4MEYYKYnregGyZSE6gx25mUh4I2VUl+Y+q5VC3JJMw/8OQ+Ji4U0WAc6dV77jkCXzzW2NqBxXE9pDVLd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965287; c=relaxed/simple;
	bh=WYAnHqfh3wc9ALgAbEUHjU8HQPMdcTokUkC4neL2YMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsDlC2jxkxjGUXRqg2PD33f60ORzT+TiuUp7QCgaA++FNrH9kB+VDMtyUrtGxXo/tUYrvPrYUoBRj0sZjLIwRFc5wDDIrb81WXhC1/sHX1yLF54kpVo6Zg+bTNim7Oq7S6FcVw36wAYdwRU43p0upS6H4moRF1+c47vt+wRhu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAcGWw6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C37C433F1;
	Sat,  3 Feb 2024 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706965286;
	bh=WYAnHqfh3wc9ALgAbEUHjU8HQPMdcTokUkC4neL2YMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OAcGWw6b+tKUCj4Q377dOFpF7STHZVNvqfUkyXTA2ysBn2YSoUwb/AZrXbLrw5dlc
	 nizLkVJ/AB1XG5lU0OkCOfWtlw6AzoeHR+khV6mtYcJ+wuGv2ssgxN9AUCxRi2uOAK
	 ZXiLEvWZneAR2MYGywMhKDpfu5SrYL8NMer/HQGNWM5NSnhzuK9iZun9h9+A/D1SwT
	 F+FyAgLYI9HPt8JvSIky1P2loBRB7bRikq26UDtKflHQ23OxS9QBMo//TYOOTMNh4Q
	 so87FS1bPJz6LfqZXQVqBOAP/f9o9lkRJ23oTW7C06GnndYhrPdHl2lIs16PLh7SiJ
	 Td7YiWkxEr2Zw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 13:00:40 +0000
Subject: [PATCH v2 1/2] arm64/sme: Restore SMCR on exit from suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-sme-resume-v2-1-a1fbaddc4425@kernel.org>
References: <20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org>
In-Reply-To: <20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WYAnHqfh3wc9ALgAbEUHjU8HQPMdcTokUkC4neL2YMY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjkT4aXhtj2CXSu9FybDljHxn75/w4PZuyUtMHq8
 5JNnjk+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb45EwAKCRAk1otyXVSH0KvAB/
 4p6ZI3LJRELdmOTD9CJIEHYV2hSnM8GWKgCbf0qVwltqR5PUoAEAybmvK8z5CALDug3oOu96fr2ucZ
 2WyGJJHflFpa6vswKo75XB5/UqQsqk6TVtnJMIlfy2zVgcuck7xVFNbu94vkXdIjO/oNZ3/65lEDQA
 pUIVXfzo5VACviPzWlj6VMiod0YQyaB1dlQYZltzpB3oOeY9rBuYlFajhb0dFDC/Ll0s0Wr83/kHXg
 phoPtN8/K2Q8SAgLD4AOXKsU+xWTQ64sc+HcVEQWfFdz0h836fPeG438rraqLStyUi8B+TgDi5nXEb
 m/T5LTZui/D2SJwL0F30oTzI0STmMt
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
 arch/arm64/kernel/fpsimd.c      | 14 ++++++++++++++
 arch/arm64/kernel/suspend.c     |  3 +++
 3 files changed, 19 insertions(+)

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
index a5dc6f764195..8d2a5824d5d3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1311,6 +1311,20 @@ void __init sme_setup(void)
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
+	write_sysreg_s(0, SYS_SMPRI_EL1);
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


