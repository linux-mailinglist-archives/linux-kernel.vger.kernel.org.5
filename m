Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176127AD67E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjIYK4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIYK42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:56:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4011DA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:56:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27731387c4eso2362714a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695639381; x=1696244181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeexHTe4tyT9b8KjfC5Hux5b6TXgeqGsjdg9N5cei7A=;
        b=DJTvbnPxKNlckBIp/yZdGsnol8EzuG12HZFlDBz/lS7lr2KpT1R4w/kN0ORq/SWja7
         eCQTN5mpyXu1GkCJs2kyhcA1lRwo1wpVuh8yRwwCwlOhX/LVujRojaXTdJ2+SNqlrflW
         Ld/2d2lLf2eKi+EHamhju8c94FilImS84dabNfzM5BCTN9J8lQGEhXFQWmaRiFZyP+yW
         ZBDHb5h1Vc8fgwh9/xyttqlkuOX61OB4ulJsGOJPhGArZx9J3XrCtRjC1samcmKcNi3I
         ie/XMgMD9Rx8B6f/JhzOBT6HdHuCy3SQg3GtWqnMqkVDS6b97owQEmiPsFBOsXLvO04K
         lHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639381; x=1696244181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeexHTe4tyT9b8KjfC5Hux5b6TXgeqGsjdg9N5cei7A=;
        b=L4GtPUcOD+mzSiesv3W9jvKuwKHoYqE/MdaMYpMUSlnNPn6iVdxcXVDWi6h2kOESln
         kKxqdNckCu+BElS3Wp0gH/armMuxKwnRJjZmW//4yRu7F0xq/k8InL4naItYmnlRkCqf
         BWkt1htPnaSwWKmneNeeqrgdKQlrJdKETX6iM1Hv26znQQG0a5lxDTlGH7JpEM6v3O7F
         YpEoNMbD1YYn7ZWe2CI0xFolnyN/GQBEYxkbfr80noDOVa/3aeCs0aElyCif3mn2HZMT
         pKV/wpCvmlNCAkU2IX+ZL3tvoFs/gA1NgqbNuoKwQ4hlobmepkk6eIjVbWQq4L4hUx5w
         cooQ==
X-Gm-Message-State: AOJu0YxusEiJdwZHQJwBMHoW3lQimbIpZTZPvP4/zjJ7e9paJlra+a6b
        f2WriFFFtHT9zDk/psmQ+2My1g==
X-Google-Smtp-Source: AGHT+IEB8A5ZUZ0a75W6XiB1wfY+254xwMH1GOYhGoEOLCfTTOay41XcVGacSy78i7007jMtRssKOg==
X-Received: by 2002:a17:90a:af87:b0:270:1586:b014 with SMTP id w7-20020a17090aaf8700b002701586b014mr6211776pjq.28.1695639381161;
        Mon, 25 Sep 2023 03:56:21 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm2297842pje.5.2023.09.25.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:56:20 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: Add tests for open-coded task and css iter
Date:   Mon, 25 Sep 2023 18:55:52 +0800
Message-Id: <20230925105552.817513-8-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230925105552.817513-1-zhouchuyi@bytedance.com>
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds three subtests to demonstrate these patterns and validating
correctness.

subtest1:
1) We use task_iter to iterate all process in the system and search for the
current process with a given pid.
2) We create some threads in current process context, and use
BPF_TASK_ITER_PROC to iterate all threads of current process. As expected,
we would find all the threads of current process.
3) We create some threads and use BPF_TASK_ITER_ALL to iterate all threads
in the system. As expected, we would find all the threads which was
created.

subtest2: We create a cgroup and add the current task to the cgroup. In the
BPF program, we would use bpf_for_each(css_task, task, css) to iterate all
tasks under the cgroup. As expected, we would find the current process.

subtest3:
1) We create a cgroup tree. In the BPF program, we use
bpf_for_each(css, pos, root, XXX) to iterate all descendant under the root
with pre and post order. As expected, we would find all descendant and the
last iterating cgroup in post-order is root cgroup, the first iterating
cgroup in pre-order is root cgroup.
2) We wse BPF_CGROUP_ITER_ANCESTORS_UP to traverse the cgroup tree starting
from leaf and root separately, and record the height. The diff of the
hights would be the total tree_high - 1.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../testing/selftests/bpf/prog_tests/iters.c  | 161 ++++++++++++++++++
 .../testing/selftests/bpf/progs/iters_task.c  | 132 ++++++++++++++
 .../selftests/bpf/progs/iters_task_failure.c  | 103 +++++++++++
 3 files changed, 396 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 10804ae5ae97..f5bb3c5887db 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -1,13 +1,22 @@
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
+#include "iters_task_failure.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -90,6 +99,151 @@ static void subtest_testmod_seq_iters(void)
 	iters_testmod_seq__destroy(skel);
 }
 
+static pthread_mutex_t do_nothing_mutex;
+
+static void *do_nothing_wait(void *arg)
+{
+	pthread_mutex_lock(&do_nothing_mutex);
+	pthread_mutex_unlock(&do_nothing_mutex);
+
+	pthread_exit(arg);
+}
+
+#define thread_num 5
+
+static void subtest_task_iters(void)
+{
+	struct iters_task *skel;
+	pthread_t thread_ids[thread_num];
+	void *ret;
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
+	pthread_mutex_lock(&do_nothing_mutex);
+	for (int i = 0; i < thread_num; i++)
+		ASSERT_OK(pthread_create(&thread_ids[i], NULL, &do_nothing_wait, NULL), "pthread_create");
+
+	syscall(SYS_getpgid);
+	iters_task__detach(skel);
+	ASSERT_EQ(skel->bss->process_cnt, 1, "process_cnt");
+	ASSERT_EQ(skel->bss->thread_cnt, thread_num + 1, "thread_cnt");
+	ASSERT_EQ(skel->bss->all_thread_cnt, thread_num + 1, "all_thread_cnt");
+	pthread_mutex_unlock(&do_nothing_mutex);
+	for (int i = 0; i < thread_num; i++)
+		pthread_join(thread_ids[i], &ret);
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
+	skel->bss->root_cg_id = cg_id;
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
+static void subtest_css_iters(void)
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
+	bpf_program__set_autoload(skel->progs.iter_css_for_each, true);
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->root_cg_id = get_cgroup_id(cgs[0].path);
+	skel->bss->leaf_cg_id = get_cgroup_id(cgs[cg_nr - 1].path);
+	err = iters_task__attach(skel);
+
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
+	syscall(SYS_getpgid);
+	ASSERT_EQ(skel->bss->pre_css_dec_cnt, cg_nr, "pre order search dec count");
+	ASSERT_EQ(skel->bss->first_cg_id, get_cgroup_id(cgs[0].path),
+				"pre order search first cgroup id");
+
+	ASSERT_EQ(skel->bss->post_css_dec_cnt, cg_nr, "post order search dec count");
+	ASSERT_EQ(skel->bss->last_cg_id, get_cgroup_id(cgs[0].path),
+				"post order search last cgroup id");
+	ASSERT_EQ(skel->bss->tree_high, cg_nr - 1, "tree high");
+	iters_task__detach(skel);
+cleanup:
+	cleanup_cgroup_environment();
+	iters_task__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -103,4 +257,11 @@ void test_iters(void)
 		subtest_num_iters();
 	if (test__start_subtest("testmod_seq"))
 		subtest_testmod_seq_iters();
+	if (test__start_subtest("task"))
+		subtest_task_iters();
+	if (test__start_subtest("css_task"))
+		subtest_css_task_iters();
+	if (test__start_subtest("css"))
+		subtest_css_iters();
+	RUN_TESTS(iters_task_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_task.c b/tools/testing/selftests/bpf/progs/iters_task.c
new file mode 100644
index 000000000000..0bf922fc750f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t target_pid = 0;
+int process_cnt = 0;
+int thread_cnt = 0;
+int all_thread_cnt = 0;
+int css_task_cnt = 0;
+int post_css_dec_cnt = 0;
+int pre_css_dec_cnt = 0;
+int tree_high = 0;
+
+u64 last_cg_id;
+u64 first_cg_id;
+
+u64 root_cg_id;
+u64 leaf_cg_id;
+
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
+	struct task_struct *pos;
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+
+	if (cur_task->pid != target_pid)
+		return 0;
+	bpf_rcu_read_lock();
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_PROC) {
+		if (pos->pid == target_pid)
+			process_cnt += 1;
+	}
+	bpf_for_each(task, pos, cur_task, BPF_TASK_ITER_THREAD) {
+		thread_cnt += 1;
+	}
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL) {
+		if (pos->tgid == target_pid)
+			all_thread_cnt += 1;
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
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
+	struct cgroup *cgrp = bpf_cgroup_from_id(root_cg_id);
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
+int iter_css_for_each(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	struct cgroup *root_cgrp = bpf_cgroup_from_id(root_cg_id);
+
+	if (!root_cgrp)
+		return 0;
+
+	struct cgroup *leaf_cgrp = bpf_cgroup_from_id(leaf_cg_id);
+
+	if (!leaf_cgrp) {
+		bpf_cgroup_release(root_cgrp);
+		return 0;
+	}
+	struct cgroup_subsys_state *root_css = &root_cgrp->self;
+	struct cgroup_subsys_state *leaf_css = &leaf_cgrp->self;
+	struct cgroup_subsys_state *pos = NULL;
+
+	bpf_rcu_read_lock();
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		struct cgroup *cur_cgrp = pos->cgroup;
+
+		post_css_dec_cnt += 1;
+			if (cur_cgrp)
+				last_cg_id = cur_cgrp->kn->id;
+	}
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_PRE) {
+		struct cgroup *cur_cgrp = pos->cgroup;
+
+		pre_css_dec_cnt += 1;
+		if (cur_cgrp && !first_cg_id)
+			first_cg_id = cur_cgrp->kn->id;
+	}
+
+	bpf_for_each(css, pos, leaf_css, BPF_CGROUP_ITER_ANCESTORS_UP)
+		tree_high += 1;
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_ANCESTORS_UP)
+		tree_high -= 1;
+
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(root_cgrp);
+	bpf_cgroup_release(leaf_cgrp);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
new file mode 100644
index 000000000000..40eb2704d94f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_task_next")
+int BPF_PROG(iter_tasks_without_lock)
+{
+	struct task_struct *pos;
+
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_PROC) {
+
+	}
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_css_next")
+int BPF_PROG(iter_css_without_lock)
+{
+	u64 cg_id = 0;
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (!cgrp)
+		return 0;
+	struct cgroup_subsys_state *root_css = &cgrp->self;
+	struct cgroup_subsys_state *pos;
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_task_next")
+int BPF_PROG(iter_tasks_lock_and_unlock)
+{
+	struct task_struct *pos;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_PROC) {
+		bpf_rcu_read_unlock();
+
+		bpf_rcu_read_lock();
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_css_next")
+int BPF_PROG(iter_css_lock_and_unlock)
+{
+	u64 cg_id = 0;
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (!cgrp)
+		return 0;
+	struct cgroup_subsys_state *root_css = &cgrp->self;
+	struct cgroup_subsys_state *pos;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		bpf_rcu_read_unlock();
+
+		bpf_rcu_read_lock();
+	}
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s")
+int BPF_PROG(iter_css_task_for_each)
+{
+	struct task_struct *task;
+	int cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (cgrp == NULL)
+		return 0;
+	struct cgroup_subsys_state *css = &cgrp->self;
+
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
+
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
-- 
2.20.1

