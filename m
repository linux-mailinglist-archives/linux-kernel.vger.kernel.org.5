Return-Path: <linux-kernel+bounces-65130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8758854868
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8421F26839
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AABD199C2;
	Wed, 14 Feb 2024 11:31:58 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6618E29;
	Wed, 14 Feb 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910317; cv=none; b=UU8WyL98NA0QUwxug6NBO8XSQq2YjaxwNp5rYTgVyqbs5picCB6hdq+yABqIEtJHW9Y7Q6p2Acc73C6rls2wJS9wykOdafT67PEbnSbnoVxBAJBF3UvxcHE98a5Xi+XRoT73J43U3qCBjigqrwlOhJVea3IJBS3uorhfURaN834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910317; c=relaxed/simple;
	bh=IZRkWO/+sOchYJGTeX49qHMaLdDDn4RxMUwVyR1RVFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O88bz9EW6gRK9JOs3ubIeFktnndDqI1FenB4wbEtulCazr4NK6qn/bAgh/OPqWTG+dHxpl+1zWh1tMwgEyYW3d+HAEaGtEEQS0eqOT7AqAQa/Yc6hObr/MfaW0JUMrhT4g6S2B8FDGxZJqJttVE95vdiXVxh7YrN3U9C5DpVmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TZbHN35hjz9yMKw;
	Wed, 14 Feb 2024 19:16:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AE0AD1405A2;
	Wed, 14 Feb 2024 19:31:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rl8pMxlwo99Ag--.51308S3;
	Wed, 14 Feb 2024 12:31:36 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 1/5] sbm: SandBox Mode core data types and functions
Date: Wed, 14 Feb 2024 12:30:31 +0100
Message-Id: <20240214113035.2117-2-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAn0Rl8pMxlwo99Ag--.51308S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rXFyUuw15Zr48GF43Awb_yoWfArW5pF
	43A3Z8Kr48ta4ay3yfJrWF9ryftw4Sgr15JFy7A343ta4qgry8WFsYqry29Fs3CrWkKayF
	qF1FgF10ka15Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JU7pnQUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Introduce SandBox Mode (SBM) core infrastructure and make the feature
configurable at build time with CONFIG_SANDBOX_MODE.

Provide an API to execute a function in a sandbox. This target function
runs in an address space that is similar to but distinct from the caller's
address space. This is why the target function cannot be called directly.
Instead, it is called via sbm_exec(), which takes the target function as a
parameter and executes it inside the sandbox.

All target functions take one void parameter and return an integer which
can be interpreted as error status (zero is success, negative is error).

Store sandbox parameters and state in struct sbm, and define these
operations on it:

* sbm_init() - set up a sandbox
* sbm_destroy() - clean up sandbox resources
* sbm_error() - query error status
* sbm_exec() - execute code in sandbox

Allow to defer error checking until after the last operation. When a SBM
operation fails, set an error value in struct sbm and make it stick, that
is fail all subsequent operations and return this error instead. The error
value can be explicitly retrieved with sbm_error(), but simple use cases
can get by with the return value of sbm_exec() alone.

Also declare these arch hooks:

* arch_sbm_init() - arch-specific setup
* arch_sbm_destroy() - arch-specific cleanup
* arch_sbm_exec() - arch-specific code execution

These hooks are required to provide strong isolation. The availability of
arch hooks is indicated by CONFIG_HAVE_ARCH_SBM. Initially, no architecture
provides SBM arch hooks, falling back to a trivial no-op implementation.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 include/linux/sbm.h | 154 ++++++++++++++++++++++++++++++++++++++++++++
 init/Kconfig        |   2 +
 kernel/Kconfig.sbm  |  31 +++++++++
 kernel/Makefile     |   1 +
 kernel/sbm.c        |  45 +++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 include/linux/sbm.h
 create mode 100644 kernel/Kconfig.sbm
 create mode 100644 kernel/sbm.c

diff --git a/include/linux/sbm.h b/include/linux/sbm.h
new file mode 100644
index 000000000000..8e0c63fb9fb2
--- /dev/null
+++ b/include/linux/sbm.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Petr Tesarik <petr.tesarik1@huawei-partners.com>
+ *
+ * SandBox Mode (SBM) public API declarations.
+ */
+#ifndef __LINUX_SBM_H
+#define __LINUX_SBM_H
+
+/**
+ * struct sbm - SandBox Mode instance.
+ * @error:    Error code. Initialized to zero by sbm_init() and updated when
+ *            a SBM operation fails.
+ * @private:  Arch-specific private data.
+ */
+struct sbm {
+#ifdef CONFIG_SANDBOX_MODE
+	int error;
+	void *private;
+#endif
+};
+
+/**
+ * typedef sbm_func - Sandbox mode function pointer.
+ * @data:  Arbitrary data passed via sbm_exec().
+ *
+ * Return: Zero on success, negative on error.
+ */
+typedef int (*sbm_func)(void *data);
+
+#ifdef CONFIG_SANDBOX_MODE
+
+/**
+ * sbm_init() - Initialize a SandBox Mode instance.
+ * @sbm:     SBM instance.
+ *
+ * Initialize a SBM instance structure.
+ *
+ * Return: Zero on success, negative on error.
+ */
+int sbm_init(struct sbm *sbm);
+
+/**
+ * sbm_destroy() - Clean up a SandBox Mode instance.
+ * @sbm:    SBM instance to be cleaned up.
+ */
+void sbm_destroy(struct sbm *sbm);
+
+/**
+ * sbm_error() - Get SBM error status.
+ * @sbm:  SBM instance.
+ *
+ * Get the SBM error code. This can be used to distinguish between
+ * errors returned by the target function and errors from setting
+ * up the sandbox environment.
+ */
+static inline int sbm_error(const struct sbm *sbm)
+{
+	return sbm->error;
+}
+
+/**
+ * sbm_exec() - Execute function in a sandbox.
+ * @sbm:   SBM instance.
+ * @func:  Function to be called.
+ * @data:  Argument for @func.
+ *
+ * Execute @func in a fully prepared SBM instance.
+ *
+ * Return: Return value of @func on success, or a negative error code.
+ */
+int sbm_exec(struct sbm *sbm, sbm_func func, void *data);
+
+#ifdef CONFIG_HAVE_ARCH_SBM
+
+/**
+ * arch_sbm_init() - Arch hook to initialize a SBM instance.
+ * @sbm:  Instance to be initialized.
+ *
+ * Perform any arch-specific initialization. This hook is called by sbm_init()
+ * immediately after zeroing out @sbm.
+ *
+ * Return: Zero on success, negative error code on failure.
+ */
+int arch_sbm_init(struct sbm *sbm);
+
+/**
+ * arch_sbm_destroy() - Arch hook to clean up a SBM instance.
+ * @sbm:  Instance to be cleaned up.
+ *
+ * Perform any arch-specific cleanup. This hook is called by sbm_destroy() as
+ * the very last operation on @sbm.
+ */
+void arch_sbm_destroy(struct sbm *sbm);
+
+/**
+ * arch_sbm_exec() - Arch hook to execute code in a sandbox.
+ * @sbm:   SBM instance.
+ * @func:  Function to be executed in a sandbox.
+ * @data:  Argument passed to @func.
+ *
+ * Execute @func in a fully prepared SBM instance. If sandbox mode
+ * cannot be set up or is aborted, set &sbm->error to a negative error
+ * value. This error is then returned by sbm_exec(), overriding the
+ * return value of arch_sbm_exec().
+ *
+ * Return: Return value of @func.
+ */
+int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *data);
+
+#else /* !CONFIG_HAVE_ARCH_SBM */
+
+static inline int arch_sbm_init(struct sbm *sbm)
+{
+	return 0;
+}
+
+static inline void arch_sbm_destroy(struct sbm *sbm)
+{
+}
+
+static inline int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *data)
+{
+	return func(data);
+}
+
+#endif /* CONFIG_HAVE_ARCH_SBM */
+
+#else /* !CONFIG_SANDBOX_MODE */
+
+static inline int sbm_init(struct sbm *sbm)
+{
+	return 0;
+}
+
+static inline void sbm_destroy(struct sbm *sbm)
+{
+}
+
+static inline int sbm_error(const struct sbm *sbm)
+{
+	return 0;
+}
+
+static inline int sbm_exec(struct sbm *sbm, sbm_func func, void *data)
+{
+	return func(data);
+}
+
+#endif /* CONFIG_SANDBOX_MODE */
+
+#endif /* __LINUX_SBM_H */
diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b..253ac8c45527 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1932,6 +1932,8 @@ config TRACEPOINTS
 
 source "kernel/Kconfig.kexec"
 
+source "kernel/Kconfig.sbm"
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Kconfig.sbm b/kernel/Kconfig.sbm
new file mode 100644
index 000000000000..64d683cefd4d
--- /dev/null
+++ b/kernel/Kconfig.sbm
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+#
+# Author: Petr Tesarik <petr.tesarik1@huawei-partners.com>
+#
+# SandBox Mode (SBM) config options.
+#
+
+config HAVE_ARCH_SBM
+       def_bool n
+
+config SANDBOX_MODE
+	bool "SandBox Mode (SBM)"
+	default n
+	help
+	  SandBox Mode provides kernel API to run native kernel functions in a
+	  sandbox, preventing out-of-bounds memory accesses. On targets which
+	  implement SBM arch hooks, the isolation is strong, preventing all
+	  memory accesses outside the sandbox; after a protection violation,
+	  the affected kernel thread can continue running. On all other
+	  targets, the isolation is weak, preventing only buffer overflows
+	  within a guard page; after a violation, the kernel thread usually
+	  terminates.
+
+	  This is an opt-in self-defense mechanism, i.e. kernel source code
+	  must be modified to run in SandBox Mode. For such code, there is
+	  some run-time overhead (CPU time, memory) associated with entering
+	  and leaving the sandbox.
+
+	  If unsure, say N.
diff --git a/kernel/Makefile b/kernel/Makefile
index ce105a5558fc..ecc4bfd6213f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 obj-$(CONFIG_NUMA) += numa.o
+obj-$(CONFIG_SANDBOX_MODE) += sbm.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/sbm.c b/kernel/sbm.c
new file mode 100644
index 000000000000..9a5b89a71a23
--- /dev/null
+++ b/kernel/sbm.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Petr Tesarik <petr.tesarik1@huawei-partners.com>
+ *
+ * SandBox Mode (SBM) public API and generic functions.
+ */
+
+#include <linux/export.h>
+#include <linux/sbm.h>
+#include <linux/string.h>
+
+int sbm_init(struct sbm *sbm)
+{
+	memset(sbm, 0, sizeof(*sbm));
+
+	sbm->error = arch_sbm_init(sbm);
+	if (sbm->error)
+		return sbm->error;
+
+	return 0;
+}
+EXPORT_SYMBOL(sbm_init);
+
+void sbm_destroy(struct sbm *sbm)
+{
+	arch_sbm_destroy(sbm);
+}
+EXPORT_SYMBOL(sbm_destroy);
+
+int sbm_exec(struct sbm *sbm, sbm_func func, void *args)
+{
+	int ret;
+
+	if (sbm->error)
+		return sbm->error;
+
+	ret = arch_sbm_exec(sbm, func, args);
+	if (sbm->error)
+		return sbm->error;
+
+	return ret;
+}
+EXPORT_SYMBOL(sbm_exec);
-- 
2.34.1


