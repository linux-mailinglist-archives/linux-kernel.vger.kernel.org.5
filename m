Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE27E6190
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjKIAoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjKIAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDC51992;
        Wed,  8 Nov 2023 16:43:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D534C433BA;
        Thu,  9 Nov 2023 00:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490623;
        bh=v76o2vA/VG9otrtJQHKg2j3xEjD5Gu2nvX2ekprmSw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=og2t3FQyVJK/vz8cFtmD/kFi17HXxKWytVXbx7ruZxtkXOtaU17/nq2+veBi+qCH5
         7TJ/nCsW5q1wpKGCkm649MYUnu8x8x+SemvUGkos4s1bnb05fTvZr6QCajYf1Oa8jT
         209Yn9rDlUkpi6CdhrYqWbEV/FrGywanlTEBEg1UAHNdYwJSWWQXdV/bopDt861AOQ
         FZQFPWxZULZ++CdBZdyBxqdZRo30tgAWWl8b0OmvNL9M38HlHzTarYYm6DFbkaxW9C
         8zXU+Qv/DXmqmoYRO/K26NFM3DISCHg4CgvwchqqToCMo1wH52xHMTNa4AqVMgoqQO
         wFm6TIIpuKgqw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 06/10] unwind: Introduce generic user space unwinding interfaces
Date:   Wed,  8 Nov 2023 16:41:11 -0800
Message-ID: <bd5cff471e67cf8d2b2d3bd8db35007ccc86f6a4.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce generic user space unwinder interfaces which will provide a
unified way for architectures to unwind different user space stack frame
types.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                |  3 ++
 include/linux/user_unwind.h | 32 +++++++++++++++
 kernel/Makefile             |  1 +
 kernel/unwind/Makefile      |  1 +
 kernel/unwind/user.c        | 77 +++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+)
 create mode 100644 include/linux/user_unwind.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/user.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 690c82212224..c4a08485835e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -428,6 +428,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 config HAVE_PERF_CALLCHAIN_DEFERRED
 	bool
 
+config HAVE_USER_UNWIND
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/user_unwind.h b/include/linux/user_unwind.h
new file mode 100644
index 000000000000..2812b88c95fd
--- /dev/null
+++ b/include/linux/user_unwind.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_USER_UNWIND_H
+#define _LINUX_USER_UNWIND_H
+
+#include <linux/types.h>
+#include <linux/sframe.h>
+
+enum user_unwind_type {
+	USER_UNWIND_TYPE_AUTO,
+	USER_UNWIND_TYPE_FP,
+};
+
+struct user_unwind_frame {
+	s32 cfa_off;
+	s32 ra_off;
+	s32 fp_off;
+	bool use_fp;
+};
+
+struct user_unwind_state {
+	unsigned long ip, sp, fp;
+	enum user_unwind_type type;
+	bool done;
+};
+
+extern int user_unwind_start(struct user_unwind_state *state, enum user_unwind_type);
+extern int user_unwind_next(struct user_unwind_state *state);
+
+#define for_each_user_frame(state, type) \
+	for (user_unwind_start(&state, type); !state.done; user_unwind_next(&state))
+
+#endif /* _LINUX_USER_UNWIND_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..bddf58b3b496 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
new file mode 100644
index 000000000000..eb466d6a3295
--- /dev/null
+++ b/kernel/unwind/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_HAVE_USER_UNWIND) += user.o
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
new file mode 100644
index 000000000000..8f9432306482
--- /dev/null
+++ b/kernel/unwind/user.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/user_unwind.h>
+#include <linux/sframe.h>
+#include <linux/uaccess.h>
+#include <asm/user_unwind.h>
+
+static struct user_unwind_frame fp_frame = {
+	ARCH_INIT_USER_FP_FRAME
+};
+
+int user_unwind_next(struct user_unwind_state *state)
+{
+	struct user_unwind_frame _frame;
+	struct user_unwind_frame *frame = &_frame;
+	unsigned long cfa, fp, ra;
+	int ret = -EINVAL;
+
+	if (state->done)
+		return -EINVAL;
+
+	switch (state->type) {
+	case USER_UNWIND_TYPE_FP:
+		frame = &fp_frame;
+		break;
+	default:
+		BUG();
+	}
+
+	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
+
+	if (frame->ra_off && get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+		goto the_end;
+
+	if (frame->fp_off && get_user(fp, (unsigned long *)(cfa + frame->fp_off)))
+		goto the_end;
+
+	state->sp = cfa;
+	state->ip = ra;
+	if (frame->fp_off)
+		state->fp = fp;
+
+	return 0;
+
+the_end:
+	state->done = true;
+	return ret;
+}
+
+int user_unwind_start(struct user_unwind_state *state,
+		      enum user_unwind_type type)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	might_sleep();
+
+	memset(state, 0, sizeof(*state));
+
+	if (!current->mm) {
+		state->done = true;
+		return -EINVAL;
+	}
+
+	if (type == USER_UNWIND_TYPE_AUTO)
+		state->type = USER_UNWIND_TYPE_FP;
+	else
+		state->type = type;
+
+	state->sp = user_stack_pointer(regs);
+	state->ip = instruction_pointer(regs);
+	state->fp = frame_pointer(regs);
+
+	return user_unwind_next(state);
+}
-- 
2.41.0

