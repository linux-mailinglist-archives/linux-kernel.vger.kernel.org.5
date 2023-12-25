Return-Path: <linux-kernel+bounces-10892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E995A81DE21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CF928193A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9CB186D;
	Mon, 25 Dec 2023 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApSX89aV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF017FE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D88DC433C9;
	Mon, 25 Dec 2023 04:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703480094;
	bh=joYODQQgM8OQwgZYoqPwgCmKzSHGbsW2er2Qt7q5rp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApSX89aVjmgqbdkXyq2u5pLTi4jiZQPcbWieu08zEKDV+Dph9ImzxtwcsGt5gy8wr
	 /TPfe/Cqs8k7g5QxPltEkToGICEHusdBwH+BW/P4QGyTWlikiQ+KV91UxOhnGwtY3c
	 62T/Ms8cCCjpthMdr1c7uRPwAwhn6ga8kJFq/mbyljdf+t9cOOAkO4wdcsp6ehWHg1
	 eLDPnILHE/41GJwESFN4SoIiwr26rVqsjG9I4d/50ZVfoarK04qEswNR7OvVSUPl3x
	 ORk0R8hDtobKogJ4ISI9Ei8kZKGWfBcjKtMXq0H6NRCViLC1l6L9fSyImDeQ/TOicW
	 AbSrAHslZGDZA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Qingfang DENG <dqfext@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Date: Mon, 25 Dec 2023 12:42:06 +0800
Message-Id: <20231225044207.3821-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231225044207.3821-1-jszhang@kernel.org>
References: <20231225044207.3821-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
support efficient unaligned access, for performance reason we want
to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
avoid performance regressions on other non efficient unaligned access
platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.

To solve this problem, runtime code patching based on the detected
speed is a good solution. But that's not easy, it involves lots of
work to modify vairous subsystems such as net, mm, lib and so on.
This can be done step by step.

So let's take an easier solution: add support to efficient unaligned
access and hide the support under NONPORTABLE.

Now let's introduce RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
NONPORTABLE, if users know during config time that the kernel will be
only run on those efficient unaligned access hw platforms, they can
enable it. Obviously, generic unified kernel Image shouldn't enable it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig  | 13 +++++++++++++
 arch/riscv/Makefile |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 24c1799e2ec4..afcc5fdc16f7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -651,6 +651,19 @@ config RISCV_MISALIGNED
 	  load/store for both kernel and userspace. When disable, misaligned
 	  accesses will generate SIGBUS in userspace and panic in kernel.
 
+config RISCV_EFFICIENT_UNALIGNED_ACCESS
+	bool "Assume the CPU supports fast unaligned memory accesses"
+	depends on NONPORTABLE
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	help
+	  Say Y here if you want the kernel to assume that the CPU supports
+	  efficient unaligned memory accesses.  When enabled, this option
+	  improves the performance of the kernel on such CPUs.  However, the
+	  kernel will run much more slowly, or will not be able to run at all,
+	  on CPUs that do not support efficient unaligned memory accesses.
+
+	  If unsure what to do here, say N.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a74be78678eb..ebbe02628a27 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -108,7 +108,9 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
 # unaligned accesses.  While unaligned accesses are explicitly allowed in the
 # RISC-V ISA, they're emulated by machine mode traps on all extant
 # architectures.  It's faster to have GCC emit only aligned accesses.
+ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS),y)
 KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+endif
 
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
-- 
2.40.0


