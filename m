Return-Path: <linux-kernel+bounces-64506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94590853FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E0C28C2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6263119;
	Tue, 13 Feb 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID2Wjs2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373B63099
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865636; cv=none; b=g0yapNqrIj6KKjPWmmF8Hj71D0G2uoOsTLm7dRqkw2ubi0T68+9hUGsCRnSFOyaVQ/tAdq29i53Gkkp/6BQxCRBOFG78f0eO5ffGcMixvYcbozO8bfGdHQJWMPcgquX1AObMkwRhqabclh5/fLGM2o3J1ljJzZAnYfrNNOjjFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865636; c=relaxed/simple;
	bh=n9u10ZS5tf3bLwSljOa4a7bDya4v/AV3Y3EVY8udHHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIXMDarrOgaM4HSXhGjX0hv2BAjCVI34gncgPwr0Df0ul9NeAkC66nQRRoEJF0dTq4efHkox4ULXwc5/uSnnMRBm4sfrO06it/UeL6OrIQIIicagEUtm+NxVfoRHEN4cDcdmAoA9axCHIICi7JdkpIJNQ3ggFpBH4+VRmuMfuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID2Wjs2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F077C43394;
	Tue, 13 Feb 2024 23:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707865636;
	bh=n9u10ZS5tf3bLwSljOa4a7bDya4v/AV3Y3EVY8udHHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ID2Wjs2tRPxkGyK0RXHRa2GKVKZNd3QngdWE6h/uBwXLUCp7Oop3zt/6AU5zeen/3
	 ZnmJ1RijSO+Q4YgB7YzDLvy3/HUZC5XW7/EPzrWHnmKtQZVlEAT3O/0NMvhBnR29CU
	 ETxfyssW2eXN0y3eBymg+7npKEgMTwvL7LhKHwOs3C0G9j+kk6weVBufhoUxQH5VWN
	 hPUSIxFswmcQF/bIPHWMDfB/Yl5UIwkK81YeWOetfmpyjKcMfIFGrGh2uMA3AWRhCz
	 Gy4JEaR/wBjZJQswRvSb7YmualUZcg6LXW0PkQYddb03zDpfdy6XRSgR0ZGpuPUJ/n
	 eqfXMUwG5UOjw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 13 Feb 2024 23:06:32 +0000
Subject: [PATCH v3 1/2] arm64/sme: Restore SME registers on exit from
 suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm64-sme-resume-v3-1-17e05e493471@kernel.org>
References: <20240213-arm64-sme-resume-v3-0-17e05e493471@kernel.org>
In-Reply-To: <20240213-arm64-sme-resume-v3-0-17e05e493471@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2876; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n9u10ZS5tf3bLwSljOa4a7bDya4v/AV3Y3EVY8udHHE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBly/YeT8Zv2qklmd6Z20IViy+bBIDojKavlqTywPM7
 QnEOhbqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcv2HgAKCRAk1otyXVSH0Eq1B/
 wKayaPsmBI/+hGRSWdTXUxHsD37OXQcSNtsqAu77CQIX0HoROXuvQckQ51Ot80fWvOSZ7fo2kUYvO1
 mVkodiqvR9a4v4gHsmad1dIzf61oB3X9tImInXXMvVqvPUtJWzr474R4HWroKD31tzP/kGI6D7OZR5
 gC6z9hNLTsnRtS/gpy8z2KWo/nVirBNp2VOgZ0zlxvJlgiijnTE9mB0fgBv1DVoWsSejlxBQyVDPLi
 7zYCVN9UVw9J1PuI0kjPk5qrs4cf1X3LwqoWU0ws4I9qjb+NRPrjikhMmQ9myItS/2kC1E+oeTj/h4
 mG5SJT+HoDgYMzOzF5BxhoYcm3kgf5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fields in SMCR_EL1 and SMPRI_EL1 reset to an architecturally UNKNOWN
value. Since we do not otherwise manage the traps configured in this
register at runtime we need to reconfigure them after a suspend in case
nothing else was kind enough to preserve them for us.

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


