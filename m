Return-Path: <linux-kernel+bounces-115881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBC8894CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7FE1F2D684
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B253839B4;
	Mon, 25 Mar 2024 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcQC7QF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E0146019;
	Sun, 24 Mar 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322076; cv=none; b=a1VdmT6VeV9giz4fAV1EpVEWb0NG8TEAsgkJsBcWF0k3FfSHjtaJk2G9cvBcNExDsi3HIqLEtESBjtv7mHRRQBEClGyHelDbrpckvvQKAT6HNElSdGEITENyPnZWdm4gxriYFi1vBYWQZReEu7DvHvamN8Ns82Lqe6lvJFh4jYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322076; c=relaxed/simple;
	bh=fX80GMalYyvbWjTGR43Qrf2n8NK9uE12CRuupmtEfWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUki/146IjljTBSRiqHoJIcq2lsH8No9a2UELrYwA98Qemr2VbrI7IzJMHXxi9L/uMO5OazEqnaRGcmlGpQSsKx7Qs/2T1i9QUlQnHOxDm/agZXKOiwitaPbv6DJkAdRLbQ3ZLTyS4TfkufX5kK3JsSoqay+uVsZnSv7HRMWHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcQC7QF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA2CC433C7;
	Sun, 24 Mar 2024 23:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322076;
	bh=fX80GMalYyvbWjTGR43Qrf2n8NK9uE12CRuupmtEfWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcQC7QF5Tmk8os6GY0pZEyxq+GNDwnWj8UcxbvwafTmcSpz9v0Z5u0r/LrWZZGcDi
	 QTwdOF//0wicKR/U4Vhe3njFKZUsZ2VYeEKUZ6vPXCZHb78ZeBTn9+dFOi2qavpqi9
	 l2SNYGb8gu0+BgGUkdLJpBPLQuTTMiHGO1SUZc95JfhpJPdrRSELSyzxv3woU42tEP
	 S1/3+IqhHhwdGdkb9jIgwyLmGTwD2+vlkdiRcDIOcFpA9AP85zJ3B6te3+VrNxJIQl
	 OapXWnJU4DpCKiXaPIsptb9F5ZXEbI5NYw40tjCBJkkH6JFSMR3CV+0jwA3gMDPt+H
	 ACiiP7KNA6oOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 149/451] selftests/bpf: Add global subprog context passing tests
Date: Sun, 24 Mar 2024 19:07:05 -0400
Message-ID: <20240324231207.1351418-150-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit e2b5cfc978f871996d1f8667515c0e06b33e620e ]

Add tests validating that it's possible to pass context arguments into
global subprogs for various types of programs, including a particularly
tricky KPROBE programs (which cover kprobes, uprobes, USDTs, a vast and
important class of programs).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/20230216045954.3002473-4-andrii@kernel.org
Stable-dep-of: 879bbe7aa4af ("bpf: don't infer PTR_TO_CTX for programs with unnamed context type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bpf/prog_tests/test_global_funcs.c        |   2 +
 .../bpf/progs/test_global_func_ctx_args.c     | 104 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 2ff4d5c7abfce..e0879df38639b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -18,6 +18,7 @@
 #include "test_global_func15.skel.h"
 #include "test_global_func16.skel.h"
 #include "test_global_func17.skel.h"
+#include "test_global_func_ctx_args.skel.h"
 
 void test_test_global_funcs(void)
 {
@@ -38,4 +39,5 @@ void test_test_global_funcs(void)
 	RUN_TESTS(test_global_func15);
 	RUN_TESTS(test_global_func16);
 	RUN_TESTS(test_global_func17);
+	RUN_TESTS(test_global_func_ctx_args);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
new file mode 100644
index 0000000000000..7faa8eef0598b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+static long stack[256];
+
+/*
+ * KPROBE contexts
+ */
+
+__weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?kprobe")
+__success
+int kprobe_typedef_ctx(void *ctx)
+{
+	return kprobe_typedef_ctx_subprog(ctx);
+}
+
+#define pt_regs_struct_t typeof(*(__PT_REGS_CAST((struct pt_regs *)NULL)))
+
+__weak int kprobe_struct_ctx_subprog(pt_regs_struct_t *ctx)
+{
+	return bpf_get_stack((void *)ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?kprobe")
+__success
+int kprobe_resolved_ctx(void *ctx)
+{
+	return kprobe_struct_ctx_subprog(ctx);
+}
+
+/* this is current hack to make this work on old kernels */
+struct bpf_user_pt_regs_t {};
+
+__weak int kprobe_workaround_ctx_subprog(struct bpf_user_pt_regs_t *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?kprobe")
+__success
+int kprobe_workaround_ctx(void *ctx)
+{
+	return kprobe_workaround_ctx_subprog(ctx);
+}
+
+/*
+ * RAW_TRACEPOINT contexts
+ */
+
+__weak int raw_tp_ctx_subprog(struct bpf_raw_tracepoint_args *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?raw_tp")
+__success
+int raw_tp_ctx(void *ctx)
+{
+	return raw_tp_ctx_subprog(ctx);
+}
+
+/*
+ * RAW_TRACEPOINT_WRITABLE contexts
+ */
+
+__weak int raw_tp_writable_ctx_subprog(struct bpf_raw_tracepoint_args *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?raw_tp")
+__success
+int raw_tp_writable_ctx(void *ctx)
+{
+	return raw_tp_writable_ctx_subprog(ctx);
+}
+
+/*
+ * PERF_EVENT contexts
+ */
+
+__weak int perf_event_ctx_subprog(struct bpf_perf_event_data *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?perf_event")
+__success
+int perf_event_ctx(void *ctx)
+{
+	return perf_event_ctx_subprog(ctx);
+}
-- 
2.43.0


