Return-Path: <linux-kernel+bounces-65133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9775585486E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC5CB29E85
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3751BDEB;
	Wed, 14 Feb 2024 11:32:29 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAB1BDCF;
	Wed, 14 Feb 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910348; cv=none; b=ZOXk8tiyIedg6AENRLRh+fLOXc6EGios4Q8VWRo+N5hzwWtTA9TqKdCPHk7g0dGt33QSQqCCfvLoGic4ef+fDmAFrRpXU9SNG0huaPXgCkZPH9/z1joZ+jYOZs7Kf13aJ10bG97P3C37me60adjy5aD112rcGwsP0nvxeKhZXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910348; c=relaxed/simple;
	bh=LbmnjlS4bxOqrvvrRtXPtPXLVGbYKpGLDnbDIyvZ+2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dch07I/rl/RrcBgGXQR2eQm8aaTXrGfO/xKVIxOEW6rPJGpJQt2SzGW5kDmgQeVwxqhM3yP/d9N86/fkz9LehUw1irIPWLApwjgSVKIUEhtT2PtBEjy+rIag7gDwp2J8O2j5oeHEgbIUc9bYwmjNOoOwDj1PfWlejk2ft3I1Vkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TZbJ42hbcz9xsDX;
	Wed, 14 Feb 2024 19:17:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 472F414059E;
	Wed, 14 Feb 2024 19:32:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rl8pMxlwo99Ag--.51308S6;
	Wed, 14 Feb 2024 12:32:14 +0100 (CET)
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
Subject: [PATCH v1 4/5] sbm: SandBox Mode KUnit test suite
Date: Wed, 14 Feb 2024 12:30:34 +0100
Message-Id: <20240214113035.2117-5-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAn0Rl8pMxlwo99Ag--.51308S6
X-Coremail-Antispam: 1UD129KBjvAXoW3KF1UKF4kKF4kZrykCrWfXwb_yoW8ZrW7Ao
	WfXwnrtw48tw1xAaykJw1DKFW7Zr4DKFnxJwsxAr4qq3srtwn8JF17W345JF18JF15C3s7
	X3WUJw47XrWktr1rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO-7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
	8vn2kIc2xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JbIYCTnIWIevJa73UjIFyTuYvjfU1WlkDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Test that a function called in sandbox mode can use input and output
buffers but blocks attempts to read or write outside the pre-defined
memory areas.

Some tests intentionally access a non-present page, which generates a page
fault in kernel space if SBM implementation cannot recover from failures.
Theoretically, the page fault handler could recover from such page faults,
but the exact details differ across architectures, and there is no
universal method. The most portable approach is to let the page fault
handler treat the fault as unrecoverable and kill the current task. This is
why a child task is used to run these tests. The parent KUnit thread can
check if the child was killed with a signal.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/Kconfig.sbm |  12 +
 kernel/Makefile    |   1 +
 kernel/sbm_test.c  | 735 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 748 insertions(+)
 create mode 100644 kernel/sbm_test.c

diff --git a/kernel/Kconfig.sbm b/kernel/Kconfig.sbm
index 64d683cefd4d..d28a754bc704 100644
--- a/kernel/Kconfig.sbm
+++ b/kernel/Kconfig.sbm
@@ -29,3 +29,15 @@ config SANDBOX_MODE
 	  and leaving the sandbox.
 
 	  If unsure, say N.
+
+config SBM_KUNIT_TEST
+	tristate "Unit tests for SandBox Mode" if !KUNIT_ALL_TESTS
+	depends on KUNIT && SANDBOX_MODE
+	default KUNIT_ALL_TESTS
+	help
+	  Build unit tests for SandBox Mode.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/kernel/Makefile b/kernel/Makefile
index ecc4bfd6213f..012df6fd817a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_SANDBOX_MODE) += sbm.o
+obj-$(CONFIG_SBM_KUNIT_TEST) += sbm_test.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/sbm_test.c b/kernel/sbm_test.c
new file mode 100644
index 000000000000..f3ad24ccf332
--- /dev/null
+++ b/kernel/sbm_test.c
@@ -0,0 +1,735 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ */
+
+#include <kunit/test.h>
+
+#include <linux/sbm.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <linux/sched/task_stack.h>
+#include <linux/signal.h>
+
+#define PASS	0x600d600d
+#define FAIL	0xbad00bad
+
+struct data {
+	int value;
+};
+
+struct page_over {
+	union {
+		unsigned char page[PAGE_SIZE];
+		struct data data;
+	};
+	int nextpage;
+};
+
+struct thread_data {
+	const struct data *in;
+	struct data *out;
+};
+
+typedef int (*sbm_threadfn)(struct kunit *test, struct thread_data *data);
+
+struct thread_param {
+	struct kunit *test;
+	sbm_threadfn threadfn;
+	struct thread_data *data;
+	int err;
+};
+
+static void check_safe_sbm(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_SBM))
+		kunit_skip(test, "requires arch hooks");
+}
+
+/**************************************************************
+ * Helpers to handle Oops in a sandbox mode kernel thread
+ *
+ * The kernel does not offer a general method for recovering
+ * from page faults in kernel mode. To intercept a planned
+ * page fault, let a helper thread oops and die.
+ */
+
+static int call_sbm_threadfn(void *arg)
+{
+	struct thread_param *params = arg;
+
+	params->err = params->threadfn(params->test, params->data);
+	do_exit(0);
+}
+
+static int run_sbm_kthread(struct kunit *test, sbm_threadfn threadfn,
+			   struct thread_data *data)
+{
+	struct thread_param params = {
+		.test = test,
+		.threadfn = threadfn,
+		.data = data,
+	};
+	int pid, status;
+
+	/* Do not let the child autoreap. */
+	kernel_sigaction(SIGCHLD, SIG_DFL);
+
+	pid = kernel_thread(call_sbm_threadfn, &params, test->name,
+			    CLONE_FS | CLONE_FILES | SIGCHLD);
+	KUNIT_ASSERT_GT(test, pid, 0);
+	KUNIT_ASSERT_EQ(test, kernel_wait(pid, &status), pid);
+
+	/* Ignore SIGCHLD again. */
+	kernel_sigaction(SIGCHLD, SIG_IGN);
+
+	/* Killed by a signal? */
+	if (status & 0x7f)
+		return -EFAULT;
+
+	KUNIT_ASSERT_EQ(test, status, 0);
+	return params.err;
+}
+
+/**************************************************************
+ * Simple write to output buffer.
+ *
+ * Verify that the output buffer is copied back to the caller.
+ */
+
+static SBM_DEFINE_FUNC(write, struct data *, out)
+{
+	out->value = PASS;
+	return 0;
+}
+
+static void sbm_write(struct kunit *test)
+{
+	struct sbm sbm;
+	struct data out;
+	int err;
+
+	out.value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write,
+		       SBM_COPY_OUT(&sbm, &out, sizeof(out)));
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), 0);
+	KUNIT_EXPECT_EQ(test, out.value, PASS);
+}
+
+/**************************************************************
+ * Memory write past output buffer within the same page.
+ *
+ * Writes beyond buffer end are ignored.
+ */
+
+static SBM_DEFINE_FUNC(write_past, struct data *, out)
+{
+	out[0].value = PASS;
+	out[1].value = FAIL;
+
+	return 0;
+}
+
+static void sbm_write_past(struct kunit *test)
+{
+	struct sbm sbm;
+	struct data out[2];
+	int err;
+
+	out[0].value = FAIL;
+	out[1].value = PASS;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write_past,
+		       SBM_COPY_OUT(&sbm, &out[0], sizeof(out[0])));
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), 0);
+	KUNIT_EXPECT_EQ(test, out[0].value, PASS);
+	KUNIT_EXPECT_EQ(test, out[1].value, PASS);
+}
+
+/**************************************************************
+ * Memory write to next page past output buffer.
+ *
+ * There is a guard page after the output buffer. Writes to
+ * this guard page should generate a page fault.
+ */
+
+static SBM_DEFINE_FUNC(write_past_page, struct data *, out)
+{
+	struct page_over *over = (struct page_over *)out;
+
+	over->nextpage = FAIL;
+	barrier();
+	out[0].value = FAIL;
+	return 0;
+}
+
+static int sbm_write_past_page_threadfn(struct kunit *text,
+					struct thread_data *data)
+{
+	struct sbm sbm;
+	int err;
+
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write_past_page,
+		       SBM_COPY_OUT(&sbm, data->out, sizeof(*data->out)));
+	sbm_destroy(&sbm);
+	return err;
+}
+
+static void sbm_write_past_page(struct kunit *test)
+{
+	struct page_over *over;
+	int err;
+
+	over = kunit_kzalloc(test, sizeof(*over), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, over);
+	over->data.value = PASS;
+	over->nextpage = PASS;
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_SBM)) {
+		struct sbm sbm;
+
+		sbm_init(&sbm);
+		err = sbm_call(&sbm, write_past_page,
+			       SBM_COPY_OUT(&sbm, &over->data,
+					    sizeof(over->data)));
+		KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+		sbm_destroy(&sbm);
+	} else {
+		struct thread_data data;
+
+		data.out = &over->data;
+		err = run_sbm_kthread(test, sbm_write_past_page_threadfn,
+				      &data);
+	}
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, over->data.value, PASS);
+	KUNIT_EXPECT_EQ(test, over->nextpage, PASS);
+}
+
+/**************************************************************
+ * Memory write before output buffer.
+ *
+ * There is a guard page before the output buffer. Writes to
+ * this guard page should generate a page fault.
+ */
+
+static SBM_DEFINE_FUNC(write_before, struct data *, out)
+{
+	out[-1].value = FAIL;
+	barrier();
+	out[0].value = FAIL;
+	return 0;
+}
+
+static int sbm_write_before_threadfn(struct kunit *test,
+				     struct thread_data *data)
+{
+	struct sbm sbm;
+	int err;
+
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write_before,
+		       SBM_COPY_OUT(&sbm, data->out, sizeof(*data->out)));
+	sbm_destroy(&sbm);
+	return err;
+}
+
+static void sbm_write_before(struct kunit *test)
+{
+	struct data out;
+	int err;
+
+	out.value = PASS;
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_SBM)) {
+		struct sbm sbm;
+
+		sbm_init(&sbm);
+		err = sbm_call(&sbm, write_before,
+			       SBM_COPY_OUT(&sbm, &out, sizeof(out)));
+		KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+		sbm_destroy(&sbm);
+	} else {
+		struct thread_data data;
+
+		data.out = &out;
+		err = run_sbm_kthread(test, sbm_write_before_threadfn, &data);
+	}
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, out.value, PASS);
+}
+
+/**************************************************************
+ * Memory write to kernel static data.
+ *
+ * Sandbox mode cannot write to a kernel static data.
+ */
+
+struct data static_data = { .value = FAIL };
+
+static void sbm_write_static(struct kunit *test)
+{
+	struct sbm sbm;
+	int err;
+
+	check_safe_sbm(test);
+
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write, &static_data);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+	KUNIT_EXPECT_EQ(test, static_data.value, FAIL);
+}
+
+/**************************************************************
+ * Memory write to kernel BSS.
+ *
+ * Sandbox mode cannot write to kernel BSS.
+ */
+
+struct data static_bss;
+
+static void sbm_write_bss(struct kunit *test)
+{
+	struct sbm sbm;
+	int err;
+
+	check_safe_sbm(test);
+
+	static_bss.value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write, &static_bss);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+	KUNIT_EXPECT_EQ(test, static_bss.value, FAIL);
+}
+
+/**************************************************************
+ * Memory write to unrelated buffer.
+ *
+ * Sandbox mode cannot write to the wrong buffer.
+ */
+
+static void sbm_write_wrong(struct kunit *test)
+{
+	struct data *out;
+	struct sbm sbm;
+	int err;
+
+	check_safe_sbm(test);
+
+	out = kunit_kzalloc(test, sizeof(*out), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, out);
+	out->value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write, out);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+	KUNIT_EXPECT_EQ(test, out->value, FAIL);
+}
+
+/**************************************************************
+ * Memory write to kernel stack.
+ *
+ * Sandbox mode runs on its own stack. The kernel stack cannot
+ * be modified.
+ */
+
+static void sbm_write_stack(struct kunit *test)
+{
+	struct data out;
+	struct sbm sbm;
+	int err;
+
+	check_safe_sbm(test);
+
+	out.value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write, &out);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+	KUNIT_EXPECT_EQ(test, out.value, FAIL);
+}
+
+/**************************************************************
+ * Simple update of an input/output buffer.
+ *
+ * Verify that the input buffer is copied in and also back to the caller.
+ */
+
+static SBM_DEFINE_FUNC(update, struct data *, data)
+{
+	data->value ^= FAIL ^ PASS;
+	return 0;
+}
+
+static void sbm_update(struct kunit *test)
+{
+	struct sbm sbm;
+	struct data data;
+	int err;
+
+	data.value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, update,
+		       SBM_COPY_INOUT(&sbm, &data, sizeof(data)));
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), 0);
+	KUNIT_EXPECT_EQ(test, data.value, PASS);
+}
+
+/**************************************************************
+ * Copy from input buffer to output buffer.
+ *
+ * Verify that sandbox mode can read from the input buffer and
+ * write to the output buffer.
+ */
+
+static int copy_value(const struct data *in, struct data *out)
+{
+	out->value = in->value;
+	return 0;
+}
+
+/*
+ * Define call helper and thunk explicitly to verify that this syntax also
+ * works.
+ */
+static SBM_DEFINE_CALL(copy_value, const struct data *, in,
+		       struct data *, out);
+static SBM_DEFINE_THUNK(copy_value, const struct data *, in,
+			struct data *, out);
+
+static void sbm_copy_value(struct kunit *test)
+{
+	struct sbm sbm;
+	struct data in[1];
+	struct data out[1];
+	int err;
+
+	in[0].value = PASS;
+	out[0].value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, copy_value,
+		       SBM_COPY_IN(&sbm, in, sizeof(in)),
+		       SBM_COPY_OUT(&sbm, out, sizeof(out)));
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), 0);
+	KUNIT_EXPECT_EQ(test, out[0].value, PASS);
+}
+
+/**************************************************************
+ * Memory read past input buffer within the same page.
+ *
+ * The page beyond the input buffer is initialized to zero.
+ */
+
+static SBM_DEFINE_FUNC(read_past, const struct data *, in)
+{
+	return in[1].value;
+}
+
+static void sbm_read_past(struct kunit *test)
+{
+	struct sbm sbm;
+	struct data in[2];
+	int err;
+
+	in[0].value = PASS;
+	in[1].value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, read_past,
+		       SBM_COPY_IN(&sbm, &in[0], sizeof(in[0])));
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), 0);
+}
+
+/**************************************************************
+ * Memory read from next page past input buffer.
+ *
+ * There is a guard page after the input buffer. Reading from
+ * that page should generate a page fault.
+ */
+
+static SBM_DEFINE_FUNC(read_past_page, const struct data *, in)
+{
+	const struct page_over *over = (const struct page_over *)in;
+
+	return over->nextpage;
+}
+
+static int sbm_read_past_page_threadfn(struct kunit *test,
+				       struct thread_data *data)
+{
+	struct sbm sbm;
+	int err;
+
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, read_past_page,
+		       SBM_COPY_IN(&sbm, data->in, sizeof(*data->in)));
+	sbm_destroy(&sbm);
+	return err;
+}
+
+static void sbm_read_past_page(struct kunit *test)
+{
+	struct page_over *over;
+	int err;
+
+	over = kunit_kzalloc(test, sizeof(*over), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, over);
+	over->data.value = PASS;
+	over->nextpage = FAIL;
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_SBM)) {
+		struct sbm sbm;
+
+		sbm_init(&sbm);
+		err = sbm_call(&sbm, read_past_page,
+			       SBM_COPY_IN(&sbm, &over->data,
+					   sizeof(over->data)));
+		KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+		sbm_destroy(&sbm);
+	} else {
+		struct thread_data data;
+
+		data.in = &over->data;
+		err = run_sbm_kthread(test, sbm_read_past_page_threadfn, &data);
+	}
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+}
+
+/**************************************************************
+ * Memory read before input buffer.
+ *
+ * There is a guard page before the input buffer. Reading from
+ * that page should generate a page fault.
+ */
+
+static SBM_DEFINE_FUNC(read_before, const struct data *, in)
+{
+	return in[-1].value;
+}
+
+static int sbm_read_before_threadfn(struct kunit *test,
+				    struct thread_data *data)
+{
+	struct sbm sbm;
+	int err;
+
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, read_before,
+		       SBM_COPY_IN(&sbm, data->in, sizeof(*data->in)));
+	sbm_destroy(&sbm);
+	return err;
+}
+
+static void sbm_read_before(struct kunit *test)
+{
+	struct data in;
+	int err;
+
+	in.value = PASS;
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_SBM)) {
+		struct sbm sbm;
+
+		sbm_init(&sbm);
+		err = sbm_call(&sbm, read_before,
+			       SBM_COPY_IN(&sbm, &in, sizeof(in)));
+		KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+		sbm_destroy(&sbm);
+	} else {
+		struct thread_data data;
+
+		data.in = &in;
+		err = run_sbm_kthread(test, sbm_read_before_threadfn, &data);
+	}
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+}
+
+/**************************************************************
+ * Memory read from unrelated buffer.
+ *
+ * Sandbox mode cannot read from the wrong buffer.
+ */
+
+static SBM_DEFINE_FUNC(read_wrong, const struct data *, in)
+{
+	return in->value;
+}
+
+static void sbm_read_wrong(struct kunit *test)
+{
+	struct data *in;
+	struct sbm sbm;
+	int err;
+
+	check_safe_sbm(test);
+
+	in = kunit_kzalloc(test, sizeof(*in), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, in);
+	in->value = FAIL;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, read_wrong, in);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+}
+
+/**************************************************************
+ * Stack bottom.
+ *
+ * Sandbox mode can read from the bottom of the kernel stack.
+ * Verify that all of the kernel stack is mapped.
+ */
+
+static SBM_DEFINE_FUNC(stack_bottom)
+{
+	return *end_of_stack(current);
+}
+
+static void sbm_stack_bottom(struct kunit *test)
+{
+	struct sbm sbm;
+	unsigned long *bottom;
+	int err;
+
+	bottom = end_of_stack(current);
+	*bottom = PASS;
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, stack_bottom);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, PASS);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), 0);
+	KUNIT_EXPECT_EQ(test, *bottom, PASS);
+}
+
+/**************************************************************
+ * Stack overflow.
+ *
+ * Sandbox mode cannot overflow the stack.
+ *
+ * This test is not safe without SBM arch hooks, because the kernel may panic
+ * when kernel stack overflow is detected.
+ */
+
+static noinline int kaboom(void)
+{
+	return 0;
+}
+
+static SBM_DEFINE_FUNC(stack_overflow)
+{
+	unsigned long old_sp = current_stack_pointer;
+	int err;
+
+	current_stack_pointer = (unsigned long)end_of_stack(current);
+	barrier();
+	err = kaboom();
+	current_stack_pointer = old_sp;
+	return err;
+}
+
+static void sbm_stack_overflow(struct kunit *test)
+{
+	struct sbm sbm;
+	int err;
+
+	check_safe_sbm(test);
+
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, stack_overflow);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+}
+
+#ifdef CONFIG_X86_64
+
+/**************************************************************
+ * [X86-64] Non-canonical address.
+ *
+ * Sandbox mode recovers from a #GP exception. Test it by
+ * memory write to a non-canonical address.
+ */
+
+static void sbm_x86_64_gp(struct kunit *test)
+{
+	void *non_canonical;
+	struct sbm sbm;
+	int err;
+
+	check_safe_sbm(test);
+
+	non_canonical = (void *)(1ULL << 63);
+	sbm_init(&sbm);
+	err = sbm_call(&sbm, write, non_canonical);
+	sbm_destroy(&sbm);
+
+	KUNIT_EXPECT_EQ(test, err, -EFAULT);
+	KUNIT_EXPECT_EQ(test, sbm_error(&sbm), -EFAULT);
+}
+
+#endif
+
+/**************************************************************
+ * Test suite metadata.
+ */
+
+static struct kunit_case sbm_test_cases[] = {
+	KUNIT_CASE(sbm_write),
+	KUNIT_CASE(sbm_write_past),
+	KUNIT_CASE(sbm_write_past_page),
+	KUNIT_CASE(sbm_write_before),
+	KUNIT_CASE(sbm_write_static),
+	KUNIT_CASE(sbm_write_bss),
+	KUNIT_CASE(sbm_write_wrong),
+	KUNIT_CASE(sbm_write_stack),
+	KUNIT_CASE(sbm_copy_value),
+	KUNIT_CASE(sbm_read_past),
+	KUNIT_CASE(sbm_read_past_page),
+	KUNIT_CASE(sbm_read_before),
+	KUNIT_CASE(sbm_read_wrong),
+	KUNIT_CASE(sbm_update),
+	KUNIT_CASE(sbm_stack_bottom),
+	KUNIT_CASE(sbm_stack_overflow),
+#ifdef CONFIG_X86_64
+	KUNIT_CASE(sbm_x86_64_gp),
+#endif
+	{}
+};
+
+static struct kunit_suite sbm_test_suite = {
+	.name = "sandbox_mode",
+	.test_cases = sbm_test_cases,
+};
+
+kunit_test_suites(&sbm_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1


