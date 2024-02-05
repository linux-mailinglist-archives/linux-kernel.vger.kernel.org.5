Return-Path: <linux-kernel+bounces-53101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C984A0A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D71F23E05
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22644C6A;
	Mon,  5 Feb 2024 17:27:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3AD4121B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154047; cv=none; b=Ofee90gy5KIY8qBflfAwSv+OABfuBLPCsEDeJtyujaX0k39S6GOosIDzkT9eSoPI1gdODeEyqvBP+shEgSN1TR3aO4x67pKwp346BROIfikxOX2q+4VTrPwHbXBqgnU06Jk0WfD0isecn2Ph3KaBuXO9r50/OWu24RgPhK2iGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154047; c=relaxed/simple;
	bh=YgyprZMcWh4/hukYYHskhFKA/cj1E4erg92UhA9B0Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zy3Fs1y60wl1fF9XbfFP1sBTI46z9bJZrZcnGLMjhtMW+E6mKJCaWPO1et3UB3Wn5YJVnF3jFrvk3Jh3veuCrN4cKxv2nOsSmOta5BOw/iGR1/T20W2JwM7fHU1nLAbMwOIIamuSH60GOnovzOFUBvBjVFHn3OeOaC2c3Yi4Nzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC626DA7;
	Mon,  5 Feb 2024 09:28:06 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AA613F5A1;
	Mon,  5 Feb 2024 09:27:22 -0800 (PST)
Date: Mon, 5 Feb 2024 17:27:20 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: [RFC PATCH] arm64/sve,sme: Refine scalable regset sizes at boot
Message-ID: <ZcEaeLeEG8ve+Yp7@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since [1] and [2], the ptrace core has used the static values in
struct user_regset to preallocate memory when reading a regset.
This results in allocating excessive memory for SVE and related
regsets which are not a fixed size, since the theoretical max size
of those regsets was deliberately made huge in case of future
expansion.

In practice, the regsets can be smaller -- usually _much_ smaller.

Since the max possible size of these regsets depends on how big the
CPUs' registers actually are, clamp the affected regset sizes once
the kernel has probed all boot-time CPUs.

This doesn't make memory allocation failures impossible on the
affected paths, but at least avoids stupidly large allocations.

[1]: commit b4e9c9549f62 ("introduction of regset ->get() wrappers,
switching ELF coredumps to those")

[2]: commit 7717cb9bdd04 ("regset: new method and helpers for it")

Reported-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/lkml/20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid/
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

Only build-tested for now.

If a short-term fix is needed, Mark Brown's patch [3] looks like the
lower-risk option, but there seems to be outstanding discussion about
whether this change will actually fix the issue reported above or just
make it less likely to fire.  See the Link above.

This patch duplicates logic between the compiled-in regset->n values and
those computed after boot.  It might be better to compile in junk
values, since they should never get used anyway...

[3] https://lore.kernel.org/all/20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org/


 arch/arm64/include/asm/ptrace.h | 12 ++++++++++++
 arch/arm64/kernel/fpsimd.c      |  3 +++
 arch/arm64/kernel/ptrace.c      | 22 +++++++++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 47ec58031f11..609b963a05e0 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -389,5 +389,17 @@ static inline void procedure_link_pointer_set(struct pt_regs *regs,
 
 extern unsigned long profile_pc(struct pt_regs *regs);
 
+#ifdef CONFIG_ARM64_SVE
+void __init arch_ptrace_sve_init(unsigned int vq_max);
+#else
+static inline void __init arch_ptrace_sve_init(unsigned int vq_max) { }
+#endif
+
+#ifdef CONFIG_ARM64_SME
+void __init arch_ptrace_sme_init(unsigned int vq_max);
+#else
+static inline void __init arch_ptrace_sme_init(unsigned int vq_max) { }
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a5dc6f764195..5c2f91f84c31 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1189,6 +1189,7 @@ void __init sve_setup(void)
 		pr_warn("%s: unvirtualisable vector lengths present\n",
 			info->name);
 
+	arch_ptrace_sve_init(sve_vq_from_vl(info->max_vl));
 	sve_efi_setup();
 }
 
@@ -1309,6 +1310,8 @@ void __init sme_setup(void)
 		info->max_vl);
 	pr_info("SME: default vector length %u bytes per vector\n",
 		get_sme_default_vl());
+
+	arch_ptrace_sme_init(sve_vq_from_vl(info->max_vl));
 }
 
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index dc6cf0e37194..466a0eb93123 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/audit.h>
+#include <linux/cache.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -1441,7 +1442,7 @@ enum aarch64_regset {
 #endif
 };
 
-static const struct user_regset aarch64_regsets[] = {
+static struct user_regset aarch64_regsets[] __ro_after_init = {
 	[REGSET_GPR] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_pt_regs) / sizeof(u64),
@@ -1596,6 +1597,25 @@ static const struct user_regset_view user_aarch64_view = {
 	.regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
+#ifdef CONFIG_ARM64_SVE
+void __init arch_ptrace_sve_init(unsigned int vq_max)
+{
+	aarch64_regsets[REGSET_SVE].n = DIV_ROUND_UP(
+		SVE_PT_SIZE(vq_max, SVE_PT_REGS_SVE), SVE_VQ_BYTES);
+}
+#endif /* CONFIG_ARM64_SVE */
+
+#ifdef CONFIG_ARM64_SME
+void __init arch_ptrace_sme_init(unsigned int vq_max)
+{
+	aarch64_regsets[REGSET_SSVE].n = DIV_ROUND_UP(
+		SVE_PT_SIZE(vq_max, SVE_PT_REGS_SVE), SVE_VQ_BYTES);
+
+	aarch64_regsets[REGSET_ZA].n = DIV_ROUND_UP(
+		ZA_PT_SIZE(vq_max), SVE_VQ_BYTES);
+}
+#endif /* CONFIG_ARM64_SME */
+
 #ifdef CONFIG_COMPAT
 enum compat_regset {
 	REGSET_COMPAT_GPR,

base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
-- 
2.34.1


