Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE87BC7C3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343977AbjJGMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbjJGMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:45:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9098B6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:45:42 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-351367c8fcdso12003715ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696682742; x=1697287542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fHKbB55ASWON/deExPD4dUQ5zDEYtrEPvSSX1RWcvI=;
        b=eQIb15HRAUl/E+/1CDSW96CjqWTit2i8IEuMZZ6lnRinibB26rPdHCbkN9t5i/rBbL
         +MzZZ3uBBwBpaCLZxWJ2Ee99O24DO1MGTwXBrjPKJhlMIzymN7NUihQ+asoKBCgPD8if
         6ezggLKJvTYWdNRTBPsGpOgqbtVHwJYxAsvcjpKhgx+YoaIC6qV+ZI6FEjdy7MvOmkns
         V9cJl5Lzsm3walRoHEa609CujJD1xPpYaYqAH1klUCBAOjHuFESrIegIX/RyNK4JtDbL
         /RrIuZjM41J8wd8QpRXQzTWuSnrYnnyZEPNzCXD5TQW6Rfk4ytzVp9UbtbKy22L3FE7x
         CB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682742; x=1697287542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fHKbB55ASWON/deExPD4dUQ5zDEYtrEPvSSX1RWcvI=;
        b=qReorzR6sH2f+Oo9mt3r4lkKQ/UQPN0WQB5L/g4CW1YVA3/s2rW0m9EQHqVIOK4sTB
         9b+K0S+8u0llCBbiJCWX5nVQgusej1B3rY7YES+FkF0G+DkDSzD2zUguZRJGffzM8HvH
         r3iulJ+z+T/+jmxzKJ38IOM8yT9S+oE1iFKOJweLexJWLQoNHB1W9HxCxh1Cb6bhJTmV
         DsQkrsQbz8Rb8Pe7DTG4CoOQwL2vYajle+WuSE+Mu04TugR393DfOUiFl9zY5apkZp6G
         smwJzmpKGj93Z0Gdwf2MUQbeOt0rhxtugM9byf1yfs40R5mFPTfIVtLy/TrxWqwe702L
         xcUw==
X-Gm-Message-State: AOJu0Yx4xHVw2gxCfMnhy+FF0gMjwcE/2t/c0mN2a/EGv9Op3Nh36g+u
        gwU0ICpoGW5ZTLbRnd+ul1BcPg==
X-Google-Smtp-Source: AGHT+IEesn1Ojrp3/Ky7Vcr39Ol3hiQGhi8DUzoEoqPxCGvShIC2KFZjb2b5NyK3iS/7swfHi+0FRw==
X-Received: by 2002:a05:6e02:11a7:b0:34f:70ec:d4cf with SMTP id 7-20020a056e0211a700b0034f70ecd4cfmr9114932ilj.8.1696682742110;
        Sat, 07 Oct 2023 05:45:42 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5095388pjw.47.2023.10.07.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:45:41 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 3/8] bpf: Introduce task open coded iterator kfuncs
Date:   Sat,  7 Oct 2023 20:45:17 +0800
Message-Id: <20231007124522.34834-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231007124522.34834-1-zhouchuyi@bytedance.com>
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

1. iterating all process in the system(BPF_TASK_ITER_ALL_PROCS)

2. iterating all threads in the system(BPF_TASK_ITER_ALL_THREADS)

3. iterating all threads of a specific task(BPF_TASK_ITER_PROC_THREADS)

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 82 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
 3 files changed, 90 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8699cabb52b2..8111437a999e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2552,6 +2552,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
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
index 2cfcb4dd8a37..c2e1c3cbffea 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -856,6 +856,88 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 	bpf_mem_free(&bpf_global_ma, kit->css_it);
 }
 
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
+	BPF_TASK_ITER_ALL_PROCS,
+	BPF_TASK_ITER_ALL_THREADS,
+	BPF_TASK_ITER_PROC_THREADS
+};
+
+__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
+		struct task_struct *task, unsigned int flags)
+{
+	struct bpf_iter_task_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task));
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
+		goto out;
+
+	if (flags == BPF_TASK_ITER_ALL_PROCS)
+		goto get_next_task;
+
+	kit->pos = next_thread(kit->pos);
+	if (kit->pos == kit->task) {
+		if (flags == BPF_TASK_ITER_PROC_THREADS) {
+			kit->pos = NULL;
+			goto out;
+		}
+	} else
+		goto out;
+
+get_next_task:
+	kit->pos = next_task(kit->pos);
+	kit->task = kit->pos;
+	if (kit->pos == &init_task)
+		kit->pos = NULL;
+
+out:
+	return pos;
+}
+
+__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
+{
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 8b53537e0f27..1ec82997cce7 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -457,5 +457,10 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
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

