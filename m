Return-Path: <linux-kernel+bounces-117950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959A88B1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2AA1C629A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0585D73B;
	Mon, 25 Mar 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUItxauA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA15A7B9;
	Mon, 25 Mar 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399090; cv=none; b=EKpVPHx1o3CdmiaU0wclhzUK63pBE/cRsyL7nsExnN6nnutxutcbb0/oEUX7KJo3+ZP+o3ypk3Bc+A3x1OR2DP96BlqgF/ghCGvga7XIU4QcFZ+0OabnKk/pcpKQogxFK4c9Wdzo0KpTtIpEKeiQPvy/vjj1aRBlK6RGFQNRoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399090; c=relaxed/simple;
	bh=OYwQ9gETcvblZ+DTG3uN4WV/pZ83UVeGW84DiHYtnZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnXPZAL2R/L3hcjXtgIAaSZKCj+hlUw8nw1sFUH39JCFAZD7Mr3E7s6nF2+U02LQerbg33rPOuefAt33+TyWf9fwk30LSuveUF1qzM2HG8/NUSGEsqE/GtWkdVyJxrDEXs8nCjSKx4UNXw3fUraNWaDculhU7SZndUk0ghZ2rVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUItxauA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E671EC433F1;
	Mon, 25 Mar 2024 20:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399090;
	bh=OYwQ9gETcvblZ+DTG3uN4WV/pZ83UVeGW84DiHYtnZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUItxauAtJq0ZcfLGNMccuANqR4HkC+djaA8wo+23ZY8mskjs62f0e3HviOcf2jVr
	 htVdxyNZGLeM7cEUt+nUA1pxpQzwEP1CP7aaWUFDcfIpQPjuIjgkAW08XX0JAGV16t
	 dAcJdsqdmxT62LLTvkAJg/P14gZaeGWU1eKJhe2LOVz5T71hjJ4uP0DQkA4EeTUXHh
	 OvwdFrDMSm4uiGgXbRzY5KdSaOvgcTLsas6hvwW6KwzzZcU2Nn5xJgDjU8PyGcdjzZ
	 A2NcPBEACQY427Y0sCI7P2JjbDKxOVWmW2hOr8lZJpSO9WJ67Ga/eSKXSX5+zcjkA/
	 6xuK/6NFMNRWw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Date: Mon, 25 Mar 2024 22:37:55 +0200
Message-ID: <20240325203755.1811-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325203755.1811-1-jarkko@kernel.org>
References: <20240325203755.1811-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tacing with kprobes while running a monolithic kernel is currently
impossible due the kernel module allocator dependency.

Address the issue by implementing textmem API for RISC-V.

Link: https://www.sochub.fi # for power on testing new SoC's with a minimal stack
Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian.com/ # continuation
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Architecture independent parts have been split to separate patches.
- Do not change arch/riscv/kernel/module.c as it is out of scope for
  this patch set now.
v2:
- Better late than never right? :-)
- Focus only to RISC-V for now to make the patch more digestable. This
  is the arch where I use the patch on a daily basis to help with QA.
- Introduce HAVE_KPROBES_ALLOC flag to help with more gradual migration.
---
 arch/riscv/Kconfig          |  1 +
 arch/riscv/kernel/Makefile  |  3 +++
 arch/riscv/kernel/execmem.c | 22 ++++++++++++++++++++++
 kernel/kprobes.c            |  2 +-
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/execmem.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e3142ce531a0..499512fb17ff 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,6 +132,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_ALLOC_EXECMEM if !XIP_KERNEL
 	# https://github.com/ClangBuiltLinux/linux/issues/1881
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
 	select HAVE_MOVE_PMD
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 604d6bf7e476..337797f10d3e 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -73,6 +73,9 @@ obj-$(CONFIG_SMP)		+= cpu_ops.o
 
 obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
 obj-$(CONFIG_MODULES)		+= module.o
+ifeq ($(CONFIG_ALLOC_EXECMEM),y)
+obj-y				+= execmem.o
+endif
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
 obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
diff --git a/arch/riscv/kernel/execmem.c b/arch/riscv/kernel/execmem.c
new file mode 100644
index 000000000000..4191251476d0
--- /dev/null
+++ b/arch/riscv/kernel/execmem.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/mm.h>
+#include <linux/moduleloader.h>
+#include <linux/vmalloc.h>
+#include <asm/sections.h>
+
+void *alloc_execmem(unsigned long size, gfp_t /* gfp */)
+{
+	return __vmalloc_node_range(size, 1, MODULES_VADDR,
+				    MODULES_END, GFP_KERNEL,
+				    PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void free_execmem(void *region)
+{
+	if (in_interrupt())
+		pr_warn("In interrupt context: vmalloc may not work.\n");
+
+	vfree(region);
+}
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a1a547723c3c..87fd8c14a938 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -119,7 +119,7 @@ void __weak *alloc_insn_page(void)
 	 * for most of the architectures.
 	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
 	 */
-	return alloc_execmem(PAGE_SIZE);
+	return alloc_execmem(PAGE_SIZE, GFP_KERNEL);
 }
 
 static void free_insn_page(void *page)
-- 
2.44.0


