Return-Path: <linux-kernel+bounces-139426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A38A032F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F8EB23D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE1B184111;
	Wed, 10 Apr 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="dteWCXYQ"
Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F071836F7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787482; cv=none; b=tF5NUdrKkIVMCqNv3JCzth/aq34wEE/MmGEKnSFEZnIVGchGPdpm6zZWRyLx8lcGaEgE7XhYmm8BIRki93ZxAfzHWJVv2rvaKPxCEbnhb2U43g2NEtI0cPExBu9fANZg5ReIp+k/UaAxWWTn+K4OhJZCGDzVrSVHxcQfzHj2TZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787482; c=relaxed/simple;
	bh=RzQDTssJlYAh3BMwvx5gEiw6hlt77+7dESf4c/c7TE8=;
	h=MIME-version:Content-type:From:To:Cc:Subject:Date:Message-id:
	 In-reply-to:References; b=JhSu+SAREOyGg6k/9AxVI+wcKf27E1bQxa3ZbScN6thXf1JZW+CLXQyI0kf8RQZCbY+pMzIfBFPJ0NPBK9gk3/Z978G4Qxqjn6GBp7YAcdBVOvR8bfUFGq/3nvgamJTBKw493gO3y9htSziRxHG6A4KnGPSPElPcz4pNIrAMnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=dteWCXYQ; arc=none smtp.client-ip=17.32.222.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ004HUWHRGT20@ma-mailsvcp-mx-lapp01.apple.com> for
 linux-kernel@vger.kernel.org; Wed, 10 Apr 2024 14:17:53 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=mime-version : content-transfer-encoding : content-type : from : to : cc :
 subject : date : message-id : in-reply-to : references; s=20180706;
 bh=Zb4qSLbdX8jyBOZB1vfZMuFlfmvUIt03Ab95Bnrn+Vw=;
 b=dteWCXYQxAKcXXJyCpKkcxW3Nib5ozjuh8KTt7G2FKrc803XjLRVkJFvIhrkDaIGdQQS
 enZRmFrS7uvrV9qyp/WrW1qYCeRvyvNTh2hlwC0AetNBu8NLQa3sSTSRNSFl1K9kR/Wi
 eOKlGK2A+8TjKfqdEacAimx7jXCG5G6yApSbZnplvri/7xspjh6i/O+v/nW/A93eEzOF
 g8LPFySTH4Oe0Qv2eXIuTL6uEXF0zMQWhBtvRed7j5TY+D5hxQrEuznmw0wLN7kjKSk4
 PIcIuv8d3Hk0TuPI8LWtTHdNC4KN5q5bDAHWMPO8le/DedQsY4gnzxuW8EI15NC72F1q Ng==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ00920WHP3NI0@rn-mailsvcp-mta-lapp04.rno.apple.com>;
 Wed, 10 Apr 2024 14:17:50 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SBQ00E00WFDM000@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:49 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-Va-E-CD: abda6b097ca298131272d100f832e7b1
X-Va-R-CD: 2510821dd2dd4e6582baa96a6b1cf6d9
X-Va-ID: a6f2dfa7-7aaa-4ef5-b815-2be5cf783d78
X-Va-CD: 0
X-V-A:
X-V-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-V-E-CD: abda6b097ca298131272d100f832e7b1
X-V-R-CD: 2510821dd2dd4e6582baa96a6b1cf6d9
X-V-ID: 75e69c48-0d5d-49d4-8082-0485a2f69f66
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset=UTF-8
Received: from mr41p01nt-relayp01.apple.com ([17.115.0.54])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SBQ00HCRWGK4E00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:48 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: zayd_qumsieh@apple.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>,
 Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tso: aarch64: allow userspace to set tso bit using prctl
Date: Wed, 10 Apr 2024 14:16:41 -0700
Message-id: <20240410211652.16640-4-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-reply-to: <20240410211652.16640-1-zayd_qumsieh@apple.com>
References: <20240410211652.16640-1-zayd_qumsieh@apple.com>

Add a new prctl to allow userspace to change the TSO bit. This is
useful for emulators that recompile x86_64 to ARM64. Such programs used
to need to emulate TSO by hand, which has massive performance
ramifications. With this change, emulators can now use prctl to set the
TSO bit at will, and avoid emulating TSO.

Signed-off-by: Zayd Qumsieh <zayd_qumsieh@apple.com>
---
 arch/arm64/Kconfig           |  6 +++++
 arch/arm64/include/asm/tso.h |  1 +
 arch/arm64/kernel/process.c  | 52 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/tso.c      |  1 +
 include/uapi/linux/prctl.h   |  9 +++++++
 kernel/sys.c                 | 11 ++++++++
 6 files changed, 80 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 35162e5a0705..ecb7e1f080af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2088,10 +2088,16 @@ config ARM64_TSO
 	  dynamically switched between the default ARM64 memory model
 	  and x86_64's memory model (TSO).
 
+	  This option enables the support for toggling TSO mode for
+	  userspace threads.
+
 	  Selecting this option allows the feature to be detected at
 	  runtime. If the CPU doesn't implement TSO mode, then this
 	  feature will be disabled.
 
+	  Userspace threads that want to use this feature must
+	  explicitly opt in via a prctl().
+
 endmenu # "ARMv8.5 architectural features"
 
 menu "ARMv8.7 architectural features"
diff --git a/arch/arm64/include/asm/tso.h b/arch/arm64/include/asm/tso.h
index 405e9a5efdf5..cf31c685b1dd 100644
--- a/arch/arm64/include/asm/tso.h
+++ b/arch/arm64/include/asm/tso.h
@@ -13,6 +13,7 @@
 
 int modify_tso_enable(bool tso_enable);
 void tso_thread_switch(struct task_struct *next);
+int arch_set_mem_model(struct task_struct *task, int memory_model);
 
 #endif /* CONFIG_ARM64_TSO */
 #endif /* __ASM_TSO_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3831c1a97f79..2b0e9a5331e0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -763,3 +763,55 @@ int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
 	return prot;
 }
 #endif
+
+static int arch_set_mem_model_default(struct task_struct *task)
+{
+	int return_error = 0;
+
+#ifdef CONFIG_ARM64_TSO
+	int modify_tso_enable_error = modify_tso_enable(false);
+
+	if (modify_tso_enable_error == -EOPNOTSUPP)
+		// TSO is the only other memory model on arm64.
+		// If TSO is not supported, then the default memory
+		// model must already be set.
+		return_error = 0;
+	else
+		return_error = modify_tso_enable_error;
+
+	if (!return_error)
+		task->thread.tso = false;
+
+	return return_error;
+#endif
+
+	return return_error;
+}
+
+#ifdef CONFIG_ARM64_TSO
+
+static int arch_set_mem_model_tso(struct task_struct *task)
+{
+	int error = modify_tso_enable(true);
+
+	if (!error)
+		task->thread.tso = true;
+
+	return error;
+}
+
+#endif /* CONFIG_ARM64_TSO */
+
+int arch_set_mem_model(struct task_struct *task, int memory_model)
+{
+	switch (memory_model) {
+	case PR_SET_MEM_MODEL_DEFAULT:
+		return arch_set_mem_model_default(task);
+#ifdef CONFIG_ARM64_TSO
+	case PR_SET_MEM_MODEL_TSO:
+		return arch_set_mem_model_tso(task);
+#endif /* CONFIG_ARM64_TSO */
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/arch/arm64/kernel/tso.c b/arch/arm64/kernel/tso.c
index 9a15d825943f..44749f1f5e10 100644
--- a/arch/arm64/kernel/tso.c
+++ b/arch/arm64/kernel/tso.c
@@ -58,4 +58,5 @@ void tso_thread_switch(struct task_struct *next)
 	}
 }
 
+
 #endif /* CONFIG_ARM64_TSO */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..62b767e6efcf 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright © 2024 Apple Inc. All rights reserved.
+ */
+
 #ifndef _LINUX_PRCTL_H
 #define _LINUX_PRCTL_H
 
@@ -306,4 +310,9 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+/* Set the CPU memory model */
+#define PR_SET_MEM_MODEL		71
+# define PR_SET_MEM_MODEL_DEFAULT	0
+# define PR_SET_MEM_MODEL_TSO		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 8bb106a56b3a..94c18700b849 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -3,6 +3,7 @@
  *  linux/kernel/sys.c
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright © 2024 Apple Inc. All rights reserved.
  */
 
 #include <linux/export.h>
@@ -2315,6 +2316,11 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int __weak arch_set_mem_model(struct task_struct *task, int memory_model)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2760,6 +2766,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_SET_MEM_MODEL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_mem_model(current, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.39.3 (Apple Git-146)


