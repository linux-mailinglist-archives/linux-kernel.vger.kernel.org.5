Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62C79C78A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjILHCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjILHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:02:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B910C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c336f3f449so45837165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502139; x=1695106939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHvChKGnnZi2VbMoC/1ghgca6iZmmMi6EKlv8J2G2fg=;
        b=Pz94yrZEm1gAewdNBZNyHYGilUQYcv52N/6CM7ofREcH9Azf91rO5OrplltOLjm/vK
         2IjyqTcsuiHZR2OZlAWJlsf3XCAkc07jw5hrHF3czY017l5o1m+shrQ07R8ALKrHbDsM
         sqOozaHKk1//v8czq1/Et6jCeIAuhLqU8nfj+qGH4NUWsHn0unUwp4tQAmEIH0PA7Oyg
         F4tDd+v3U65B5PQXAz+S65m2l8CQVvAKbW20jgwvksYdCtctjwy30kapQemgdGTTH4Bl
         e/siybWVV/ldUfRAqjdF0+W9DLCPMZtZ++C9BLwYUypljfkYj9xhPuaPoz0TD54DAI2V
         4p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502139; x=1695106939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHvChKGnnZi2VbMoC/1ghgca6iZmmMi6EKlv8J2G2fg=;
        b=xBx6etKHWxG+Sb+SXLseIvGaY4W37g47KhQswVxq0vJFkCOfmK4vgKPJ/hMTXs3B7j
         Oks52tzHAYTLiVETbEzyZivcwHUxeLLpWmfSXzHSdZxW9+q74PCfz++El2CRPb3SetvV
         sRKl0QbEdNc508V0+YJTCBny/T5QcumD1rYFFMDh738fEF8XEBZ7b+GPCZ8T5EsXBDMi
         hY0/oevgU574Mj+Nx65Lg4Tf5it8DRV4mWd7OVMxeeyOcIRtd0Bs5cnzJKbO1hDpYsui
         LJTPdLfD38J1E1JdtyhMkVCeeENTtU2hXanPslIOOWL+2lZ+VK6rdvgRSo2e1oCVp0k1
         rsiw==
X-Gm-Message-State: AOJu0YzZ2qMq+i9S2eSYzEmmG5akluiePOst4fK/wfI0bPrAKj0lTRub
        5uPiok79EMT/2T1gWGhap43cwQ==
X-Google-Smtp-Source: AGHT+IGAzzXLvSkqyFtsQ81mmEO/NsorZtgGazng17R/SZuKMut3kM4aZbbVuYOInENRSv12IHsRgQ==
X-Received: by 2002:a17:902:b287:b0:1c3:7628:fcbb with SMTP id u7-20020a170902b28700b001c37628fcbbmr10807814plr.43.1694502139227;
        Tue, 12 Sep 2023 00:02:19 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:19 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for open-coded task and css iter
Date:   Tue, 12 Sep 2023 15:01:49 +0800
Message-Id: <20230912070149.969939-7-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds three tests to demonstrate these patterns and validating
correctness.

test1: We use bpf_for_each(process, task) to iterate all process in the
system and search for the current process with a given pid.

test2: We create a cgroup and add the current task to the cgroup. In the
BPF program, we would use bpf_for_each(css_task, task, css) to iterate all
tasks under the cgroup. As expected, we would find the current process.

test3: We create a cgroup tree. In the BPF program, we use
bpf_for_each(css_{pre,post}, pos, root) to iterate all descendant under the
root with pre and post order. As expected, we would find all descendant and
the last iterating cgroup in post-order is root cgroup, the first
iterating cgroup in pre-order is root cgroup.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../testing/selftests/bpf/prog_tests/iters.c  | 138 ++++++++++++++++++
 .../testing/selftests/bpf/progs/iters_task.c  | 104 +++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 10804ae5ae97..f4e69a506509 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -1,13 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <malloc.h>
+#include <stdlib.h>
 #include <test_progs.h>
+#include "cgroup_helpers.h"
 
 #include "iters.skel.h"
 #include "iters_state_safety.skel.h"
 #include "iters_looping.skel.h"
 #include "iters_num.skel.h"
 #include "iters_testmod_seq.skel.h"
+#include "iters_task.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -90,6 +98,130 @@ static void subtest_testmod_seq_iters(void)
 	iters_testmod_seq__destroy(skel);
 }
 
+static void subtest_process_iters(void)
+{
+	struct iters_task *skel;
+	int err;
+
+	skel = iters_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	bpf_program__set_autoload(skel->progs.iter_task_for_each_sleep, true);
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+	skel->bss->target_pid = getpid();
+	err = iters_task__attach(skel);
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+	syscall(SYS_getpgid);
+	iters_task__detach(skel);
+	ASSERT_EQ(skel->bss->process_cnt, 1, "process_cnt");
+
+cleanup:
+	iters_task__destroy(skel);
+}
+
+extern int stack_mprotect(void);
+
+static void subtest_css_task_iters(void)
+{
+	struct iters_task *skel;
+	int err, cg_fd, cg_id;
+	const char *cgrp_path = "/cg1";
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+	cg_fd = create_and_get_cgroup(cgrp_path);
+	if (!ASSERT_GE(cg_fd, 0, "cg_create"))
+		goto cleanup;
+	cg_id = get_cgroup_id(cgrp_path);
+	err = join_cgroup(cgrp_path);
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+
+	skel = iters_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	bpf_program__set_autoload(skel->progs.iter_css_task_for_each, true);
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->cg_id = cg_id;
+	err = iters_task__attach(skel);
+
+	err = stack_mprotect();
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
+	iters_task__detach(skel);
+	ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");
+
+cleanup:
+	cleanup_cgroup_environment();
+	iters_task__destroy(skel);
+}
+
+static void subtest_css_dec_iters(void)
+{
+	struct iters_task *skel;
+	struct {
+		const char *path;
+		int fd;
+	} cgs[] = {
+		{ "/cg1" },
+		{ "/cg1/cg2" },
+		{ "/cg1/cg2/cg3" },
+		{ "/cg1/cg2/cg3/cg4" },
+	};
+	int err, cg_nr = ARRAY_SIZE(cgs);
+	int i;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+	for (i = 0; i < cg_nr; i++) {
+		cgs[i].fd = create_and_get_cgroup(cgs[i].path);
+		if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
+			goto cleanup;
+	}
+
+	skel = iters_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	bpf_program__set_autoload(skel->progs.iter_css_dec_for_each, true);
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->cg_id = get_cgroup_id(cgs[0].path);
+
+	err = iters_task__attach(skel);
+
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
+	syscall(SYS_getpgid);
+	ASSERT_EQ(skel->bss->css_dec_cnt, cg_nr, "pre order search dec count");
+	ASSERT_EQ(skel->bss->first_cg_id, get_cgroup_id(cgs[0].path),
+				"pre order search first cgroup id");
+	skel->bss->css_dec_cnt = 0;
+	skel->bss->is_post_order = 1;
+	syscall(SYS_getpgid);
+	ASSERT_EQ(skel->bss->css_dec_cnt, cg_nr, "post order search dec count");
+	ASSERT_EQ(skel->bss->last_cg_id, get_cgroup_id(cgs[0].path),
+				"post order search last cgroup id");
+	iters_task__detach(skel);
+cleanup:
+	cleanup_cgroup_environment();
+	iters_task__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -103,4 +235,10 @@ void test_iters(void)
 		subtest_num_iters();
 	if (test__start_subtest("testmod_seq"))
 		subtest_testmod_seq_iters();
+	if (test__start_subtest("process"))
+		subtest_process_iters();
+	if (test__start_subtest("css_task"))
+		subtest_css_task_iters();
+	if (test__start_subtest("css_dec"))
+		subtest_css_dec_iters();
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_task.c b/tools/testing/selftests/bpf/progs/iters_task.c
new file mode 100644
index 000000000000..cf24a3b177f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+char _license[] SEC("license") = "GPL";
+
+pid_t target_pid = 0;
+int process_cnt = 0;
+int css_task_cnt = 0;
+int css_dec_cnt = 0;
+
+char is_post_order;
+u64 cg_id;
+u64 last_cg_id;
+u64 first_cg_id;
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int iter_task_for_each_sleep(void *ctx)
+{
+	struct task_struct *task;
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+
+	if (cur_task->pid != target_pid)
+		return 0;
+	bpf_rcu_read_lock();
+	bpf_for_each(process, task) {
+		if (task->pid == target_pid)
+			process_cnt += 1;
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+
+SEC("?lsm/file_mprotect")
+int BPF_PROG(iter_css_task_for_each)
+{
+	struct task_struct *task;
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (cgrp == NULL)
+		return 0;
+	struct cgroup_subsys_state *css = &cgrp->self;
+
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
+		if (!task)
+			continue;
+		if (task->pid == target_pid)
+			css_task_cnt += 1;
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int iter_css_dec_for_each(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (cgrp == NULL)
+		return 0;
+	struct cgroup_subsys_state *root = &cgrp->self;
+	struct cgroup_subsys_state *pos = NULL;
+
+	bpf_rcu_read_lock();
+	if (is_post_order) {
+		bpf_for_each(css_post, pos, root) {
+			struct cgroup *cur_cgrp = pos->cgroup;
+
+			css_dec_cnt += 1;
+			if (cur_cgrp)
+				last_cg_id = cur_cgrp->kn->id;
+		}
+	} else {
+		bpf_for_each(css_pre, pos, root) {
+			struct cgroup *cur_cgrp = pos->cgroup;
+
+			css_dec_cnt += 1;
+			if (cur_cgrp && !first_cg_id)
+				first_cg_id = cur_cgrp->kn->id;
+		}
+	}
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
-- 
2.20.1

