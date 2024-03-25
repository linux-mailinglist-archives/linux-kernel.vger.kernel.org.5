Return-Path: <linux-kernel+bounces-118066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C088B33E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C23304E02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108037175E;
	Mon, 25 Mar 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pldJko+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1F70CB5;
	Mon, 25 Mar 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403713; cv=none; b=Ti8xqVdH6oJc7juNCHGj1P0GT4cOJ0W7lShnIW1XRpaiUy7Ih1IsQwUWN0w8KUIqV3i4yOCAreWvYdcspuPFAQzTIyJsVxcLL31BrhkSZUMR7JQjNozef2fWaTmMokKuA7eQi9sPSrD7JHlSYs7AOJUXEoHoLnPW2Bs5gaE5G30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403713; c=relaxed/simple;
	bh=bwhKzO7Db7ftntYaf5MwOOW5CKKybR0mc5KmEmU3sgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2RsgalCbQKH2J5FiPsqjtFBbO8p77PB6g+XiGU1TL/Pb/EnYd2ppq9DXNTn64VhXG5jqsGX8/ApV/Dge9pkdpuNXsUDpXe+s7o8y7neaMzrbrnYgXuMtHHhHdU4jbj8uMFoYcYP2a0LnRdpkFk1XNrKK/wrBwada+zn3Nwokbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pldJko+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493FBC433F1;
	Mon, 25 Mar 2024 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711403712;
	bh=bwhKzO7Db7ftntYaf5MwOOW5CKKybR0mc5KmEmU3sgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pldJko+7M1thiYUGHzuWMw9E9STkvm/rTGVgrZt2fOPkOIm3iovANvvPlTaflJFRj
	 V/0mbHf+ZmzI2Lq28bwBS/dk+v0dsWmrTUb45+UnW6gFimQlJdBb5qJTpv1He2w9mP
	 73tf3ed4oT8qMi4eHMZFIdpB2PnuH50HtgEqBNR24aUlkHSfRTqZcAdEzOyu3DFnWg
	 3R3wlcNUPztV7k2aPhik8u1IWkbjXkvsp2lknEiVPg0SwZUUtGhPq9sn9u4UlrFWfM
	 qv+leIOKzLnovqJ9GbKR8cF7Ivty3ySnxOtnCiqmyXkl2qQUgnYuiK56pd+XjBYYTo
	 tGhlmAkb0YD/A==
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
Subject: [PATCH v5 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Date: Mon, 25 Mar 2024 23:55:02 +0200
Message-ID: <20240325215502.660-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325215502.660-1-jarkko@kernel.org>
References: <20240325215502.660-1-jarkko@kernel.org>
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
v5:
- No changes, expect removing alloc_execmem() call which should have
  been part of the previous patch.
v4:
- Include linux/execmem.h.
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
 3 files changed, 26 insertions(+)
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
index 000000000000..3e52522ead32
--- /dev/null
+++ b/arch/riscv/kernel/execmem.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/mm.h>
+#include <linux/execmem.h>
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
-- 
2.44.0


