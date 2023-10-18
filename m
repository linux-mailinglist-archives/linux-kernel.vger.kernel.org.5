Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510D7CD3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbjJRGEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344460AbjJRGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:04:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834AAC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:03:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d0acd0903so4116638a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609021; x=1698213821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pA+uWgAid8oSLs2nLYNpXTwEjADAAqZra1pWMMUUeE=;
        b=YUZoUS8mKtF9eJp0E5jNZsZoUzKff6RJGp2trsjygUpRzQoecB84eC6OpgwkKq159u
         EPg0Q4cKZiZn5vtq0RZYe422+jQYoGmRayS506CQnsfqbaIb+oVehf0+9PRproDfY0SW
         CoHMQMUF8OvYEdHfyRxM+BAKY9QVc3aIOgzBXqrr6Z+ZLSYNEr9Dnpr6Ca2lgjG2vG1C
         +IlJILhZIjqr7dlgTi0MHDu+6AoW4+iQ98Fnou/GRa7cvmxFRnzY5m3yvJxGh8QrEcri
         CjVV2vVvCX2TbaJ3ilq4MCd766F58DFFISb2mE+UG2LEHzj+lgft6JraT1jIxldcLgGy
         MitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609021; x=1698213821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pA+uWgAid8oSLs2nLYNpXTwEjADAAqZra1pWMMUUeE=;
        b=LqqQ9eP0Zfkt2dMXCfC7DzHpxaM3PhQgLOEIlBGmwwNn9xLKL0oqUE1/UEe2nXtcZW
         NbR9zlIVmSwVoLsB/xIa8/28gJmYjp8ESLTYG0WZWhjpRFqd0CpsSbSEgSMSHhEWhuwI
         svsecGqfZtfI3ND5EHg/qgUpNuhJs5X7tY8tt085T5Vk0OozcGroJtN3hfc952mFDk1z
         AvC1oYFyqNQUBRL7y0YV9sN7TlfxAtBeTXT4l8pltPU51oqDX0jR0kwTpMTWMm8ssnas
         nfci3+felat+8e7UHfwzyGwcnPrUD4o+0NrTBbGpxAw/zq2VQWz3oOF0hRvT/8TIZpAz
         wcVg==
X-Gm-Message-State: AOJu0YzfB15MAtE6F/T/bJkWdZT8La2FmdMKIyCsQCiezdsq3ykCtqqV
        z0SQ0W4b8eFbUOShJWeH0mu2rw==
X-Google-Smtp-Source: AGHT+IEO+03WhZt4F6AHpfpw7A9KXjwU+OZEB7duCyd8ayOSyzXuyioFP+BNVpHWrGFf/YIaxP8YAw==
X-Received: by 2002:a17:90a:1141:b0:27d:61ff:3d3b with SMTP id d1-20020a17090a114100b0027d61ff3d3bmr4503004pje.38.1697609020936;
        Tue, 17 Oct 2023 23:03:40 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090acc0e00b00276cb03a0e9sm505782pju.46.2023.10.17.23.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:03:40 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v6 3/8] bpf: Introduce task open coded iterator kfuncs
Date:   Wed, 18 Oct 2023 14:03:13 +0800
Message-Id: <20231018060318.105524-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018060318.105524-1-zhouchuyi@bytedance.com>
References: <20231018060318.105524-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_task in open-coded iterator
style. BPF programs can use these kfuncs or through bpf_for_each macro to
iterate all processes in the system.

The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
accepts a specific task and iterating type which allows:

1. iterating all process in the system (BPF_TASK_ITER_ALL_PROCS)

2. iterating all threads in the system (BPF_TASK_ITER_ALL_THREADS)

3. iterating all threads of a specific task (BPF_TASK_ITER_PROC_THREADS)

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 90 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
 3 files changed, 98 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c01441db9fd5..c25941531265 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2563,6 +2563,9 @@ BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e4126698cecf..faa1712c1df5 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -952,6 +952,96 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 
 __diag_pop();
 
+struct bpf_iter_task {
+	__u64 __opaque[3];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_task_kern {
+	struct task_struct *task;
+	struct task_struct *pos;
+	unsigned int flags;
+} __attribute__((aligned(8)));
+
+enum {
+	/* all process in the system */
+	BPF_TASK_ITER_ALL_PROCS,
+	/* all threads in the system */
+	BPF_TASK_ITER_ALL_THREADS,
+	/* all threads of a specific process */
+	BPF_TASK_ITER_PROC_THREADS
+};
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
+		struct task_struct *task, unsigned int flags)
+{
+	struct bpf_iter_task_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) > sizeof(struct bpf_iter_task));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
+					__alignof__(struct bpf_iter_task));
+
+	kit->task = kit->pos = NULL;
+	switch (flags) {
+	case BPF_TASK_ITER_ALL_THREADS:
+	case BPF_TASK_ITER_ALL_PROCS:
+	case BPF_TASK_ITER_PROC_THREADS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (flags == BPF_TASK_ITER_PROC_THREADS)
+		kit->task = task;
+	else
+		kit->task = &init_task;
+	kit->pos = kit->task;
+	kit->flags = flags;
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
+{
+	struct bpf_iter_task_kern *kit = (void *)it;
+	struct task_struct *pos;
+	unsigned int flags;
+
+	flags = kit->flags;
+	pos = kit->pos;
+
+	if (!pos)
+		return pos;
+
+	if (flags == BPF_TASK_ITER_ALL_PROCS)
+		goto get_next_task;
+
+	kit->pos = next_thread(kit->pos);
+	if (kit->pos == kit->task) {
+		if (flags == BPF_TASK_ITER_PROC_THREADS) {
+			kit->pos = NULL;
+			return pos;
+		}
+	} else
+		return pos;
+
+get_next_task:
+	kit->pos = next_task(kit->pos);
+	kit->task = kit->pos;
+	if (kit->pos == &init_task)
+		kit->pos = NULL;
+
+	return pos;
+}
+
+__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
+{
+}
+
+__diag_pop();
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 6792ed2b45d7..2f6c747aa874 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -465,5 +465,10 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
 extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
 extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
 
+struct bpf_iter_task;
+extern int bpf_iter_task_new(struct bpf_iter_task *it,
+		struct task_struct *task, unsigned int flags) __weak __ksym;
+extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) __weak __ksym;
+extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
 
 #endif
-- 
2.20.1

