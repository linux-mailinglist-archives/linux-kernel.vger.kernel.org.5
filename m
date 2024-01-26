Return-Path: <linux-kernel+bounces-40644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA983E393
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23621F27059
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734DD2421A;
	Fri, 26 Jan 2024 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="U3CR9W38"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583D2374C;
	Fri, 26 Jan 2024 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302929; cv=none; b=XpKs77LKRxwlK+9RGtnfxjHp+m+/iBSfKl86ywM4Qw6qEaGDDP3JERmO1TKBAOHbsxh9J0aYHptcSwH7BFRKNoh7f4el1ti9IytmMUcNNdPohk9pRAB4ZO77F1LjzSTOhaV/AARsFZb+QsOAkLjFPewU3HSCKslvGHCHsGMJ5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302929; c=relaxed/simple;
	bh=mn39oHpKfrn31dhBf6OIk09Xa6Qf/ZTs2k7yrfk5adA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A60iBnePNS86HPL3VdGrKJ7MubGXYqvSgcV0z/H/Y0/W6HfgzCAi9hHkUDoPE+jW7FL/JfEmrHMMOHNTUB0KkcN+A9O5ec9sApAKdU+xcOg5G3x9dJzVvzvf2u6HZK5tIEwtfOqrqv+QPkV60/ytK1b6iV+gPwZsvJTRAyoRFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=U3CR9W38; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706302923;
	bh=mn39oHpKfrn31dhBf6OIk09Xa6Qf/ZTs2k7yrfk5adA=;
	h=From:To:Cc:Subject:Date:From;
	b=U3CR9W38GcKEHTnb5MkhwcafV1zLklKgHN8srBonMiiLOgJBLd43aKdrY8oYvZ4nj
	 5RSct1lbhRLPK69gRBaey0Zl9kJNiPMXfP2vJxkiEJfp7CDxyHVfE4WYGDwXtqY6CB
	 70FVtUnT7uAopEpSWiOQm07xsbjC6ekCHIGhlNOo=
Received: from stargazer.. (unknown [IPv6:240e:358:1181:9d00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BFBFD66A22;
	Fri, 26 Jan 2024 16:01:58 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	YunQiang Su <wzssyqa@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	stable@vger.linux.org
Subject: [PATCH] mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan
Date: Sat, 27 Jan 2024 04:59:22 +0800
Message-ID: <20240126205920.11487-3-xry111@xry111.site>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we still own the FPU after initializing fcr31, when we are preempted
the dirty value in the FPU will be read out and stored into fcr31,
clobbering our setting.  This can cause an improper floating-point
environment after execve().  For example:

    zsh% cat measure.c
    #include <fenv.h>
    int main() { return fetestexcept(FE_INEXACT); }
    zsh% cc measure.c -o measure -lm
    zsh% echo $((1.0/3)) # raising FE_INEXACT
    0.33333333333333331
    zsh% while ./measure; do ; done
    (stopped in seconds)

Call lose_fpu(0) before setting fcr31 to prevent this.

Closes: https://lore.kernel.org/linux-mips/7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site/
Fixes: 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
Cc: stable@vger.linux.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/mips/kernel/elf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 5582a4ca1e9e..7aa2c2360ff6 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -11,6 +11,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/cpu-info.h>
+#include <asm/fpu.h>
 
 #ifdef CONFIG_MIPS_FP_SUPPORT
 
@@ -309,6 +310,11 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 	struct cpuinfo_mips *c = &boot_cpu_data;
 	struct task_struct *t = current;
 
+	/* Do this early so t->thread.fpu.fcr31 won't be clobbered in case
+	 * we are preempted before the lose_fpu(0) in start_thread.
+	 */
+	lose_fpu(0);
+
 	t->thread.fpu.fcr31 = c->fpu_csr31;
 	switch (state->nan_2008) {
 	case 0:
-- 
2.43.0


