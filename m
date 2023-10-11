Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0DB7C5328
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjJKMKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346822AbjJKMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3CCB7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690ba63891dso5161284b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697026165; x=1697630965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eGErJyAmlj72NVapjxnwiwBdTl0+C6Vctyi1OYX3+k=;
        b=Q75PKDfvOvXM4GmpyNYcTLyL865BRJGnxPG/0nEQPKGAln2BUNx0CLGfcuIrYrHh1x
         /24IrWqAKKxI4OYreihRAq0SU+j9ZBpzKrNVgfTAMViUn3tsjtwhPWpsC6MbADbWF40Z
         ic/qoMn+lHgV4KTE8YZOjO19uXeZllxslPZ07EemKRyV4UETu4/NdWr0Tg7y8v62Svml
         JCpUZSgOZwVzh+4NGFrcl3JW5ShACsUZt0d3tS95d3a97i6T3fYHkfoRrXHtcbqfC6lY
         DvipNl+CEAnea/UEviD1pbqXDBcIiFKSUSv5BD+pkiQ/8LuqMo9SSQVTRy1s3pqMICM8
         QkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026165; x=1697630965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eGErJyAmlj72NVapjxnwiwBdTl0+C6Vctyi1OYX3+k=;
        b=VpiTzavW/CszEMQ8E4J5E9gNgwz6IH/8jhI+woCUQ44pE4M+Sz0m5NakLd7DVBCSQv
         YbzcPHiwuOCrwpryAPMatd+C6h0yansdrEwwbJABl840Tj9T0bicR7PWEm6GKGd1kNYA
         rTljDszMG31yeFD46cUfZivJEjFocJ5poHJ9UzAYpcgoSRnX478VWqzkW2XFeeY1TZ+y
         sVnMmHFbiJZ4V52RtmP7hJtJXnu4iEOuD6S629osDD1ql59aptkgtbN6Ox1NLhZEWB7u
         mCyiKlDWZHngb40rrJFxCsinOvLoTqhZlfTU3czZ7OrBRrEfLSvH2DnD9Smv7Y7UYkBR
         cFsw==
X-Gm-Message-State: AOJu0YyvqZf/1YQZmO1/F2GxLINO41IugYoXWogIkdagLxUjLuDRBPPP
        SarF4qP8I3AZJhtvaIdgVB94Zw==
X-Google-Smtp-Source: AGHT+IFT716Yzu5sCKwB+GQ6SNYpCeVRxL6Hq1N4Zz/wx+ngJKjvBiKhO5g5V/TMz51qkcuebWFIeA==
X-Received: by 2002:a05:6a00:1790:b0:68f:c057:b567 with SMTP id s16-20020a056a00179000b0068fc057b567mr21438572pfg.26.1697026164800;
        Wed, 11 Oct 2023 05:09:24 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id u13-20020a62ed0d000000b006930db1e6cfsm9962769pfh.62.2023.10.11.05.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:24 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v5 3/8] bpf: Introduce task open coded iterator kfuncs
Date:   Wed, 11 Oct 2023 20:08:52 +0800
Message-Id: <20231011120857.251943-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011120857.251943-1-zhouchuyi@bytedance.com>
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index cb24c4a916df..690763751f6e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2555,6 +2555,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
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
index 2cfcb4dd8a37..caeddad3d2f1 100644
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

