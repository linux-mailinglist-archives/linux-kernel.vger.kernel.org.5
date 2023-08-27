Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3FE789BC5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjH0HVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjH0HVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:21:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D9F123
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:21:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdca7cc28dso18078095ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693120874; x=1693725674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aaba14g0pYwSo+C1GRPKvs5a7tFEGv787StoXtTJ820=;
        b=JwVbln6N5wR5/SkAR4HytFsak9tIqVeQnyIIlX5+rht8o2CZ9ArLClTIB8PiC9IsFc
         McY+zXbts1fQ4YlKjmgkVwMznw+jaHyLo1tPnqd0gqNqtca+NN5Rxu7vbMsGZhv7RLU8
         kfQ70FIBr0eeu0n3G2iYVdMxdedqx/DGMHzkZQHuTOj4vPipKdA4dbjCfFQl3DbJc9pU
         emxbxeVWpLLA04yIW6BD8boa1+H/ZnFTTm814e2gc5R0CovgFNJ8UpxJvPKf78AKgKM5
         XQ9hlAXT37NRxQPHe2TPRG6SXmskGf9LbkYfJDcc4ldEWnm64hrmF0XS32qoNtHbvKgC
         EQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120874; x=1693725674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aaba14g0pYwSo+C1GRPKvs5a7tFEGv787StoXtTJ820=;
        b=WLmM6M8tZgIpFo6GuE5awDB2+bl7rZAZR5QFNZeds1dq+AE1NgSpsIXuzIaEAckuwn
         YdGpLWH6AIhn/RLS8VxRK6PMshNSUk/kiRwzV1LZu4Rax6AL4x8k2fewzdvSswHzAPXN
         h+Kxa9DakWoXpoZaDxl0rp6BpNV/Y3dZrrsB7zIExcF08s0PqQFbgQMgV2QXQEgBOZs4
         jls2fNxAwTso8ljzW0Yn7wrBm+0vOkzJmT30BKeijx/ldLCW1inIjCNKakd6h4cvMqSx
         jkN/vW9HsRXXU7tShHW3kgbWdV9Q3tU1yi+whLyc60mjy28kYRUYIMoArJrS7126bepc
         5IAg==
X-Gm-Message-State: AOJu0YyUtNQqr9baNXddCCF0kbVEvQx2+dWDkeCZy1Jgyr0o7MSNxmoj
        WfAMl781wSRh3aAQpbLqyUI1cw==
X-Google-Smtp-Source: AGHT+IES0aZIVeC31/U5wz+SDgtdO6clWH2gS+rxwgpQr0NFr3Q721xrDf7OcxpufCUAkp3hGCZ4Og==
X-Received: by 2002:a17:902:f54b:b0:1b8:92fc:7429 with SMTP id h11-20020a170902f54b00b001b892fc7429mr27897781plf.53.1693120873965;
        Sun, 27 Aug 2023 00:21:13 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001befac3b3cbsm4769723plt.290.2023.08.27.00.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:21:13 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH bpf-next 3/4] bpf: Introduce css_descendant open-coded iterator kfuncs
Date:   Sun, 27 Aug 2023 15:20:56 +0800
Message-Id: <20230827072057.1591929-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow creation
and manipulation of struct bpf_iter_css in open-coded iterator style. These
kfuncs actually wrapps css_next_descendant_{pre, post}. BPF programs can
use these kfuncs through bpf_for_each macro for iteration of all descendant
css under a root css.

Normally, css_next_descendant_{pre, post} should be called with rcu
locking. Although we have bpf_rcu_read_lock(), here we still calls
rcu_read_lock in bpf_iter_css_new and unlock in bpf_iter_css_destroy
for convenience use.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/helpers.c           |  3 +++
 kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 tools/lib/bpf/bpf_helpers.h    |  6 ++++++
 5 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cfbd527e3733..19f1f1bf9301 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7203,4 +7203,9 @@ struct bpf_iter_process {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css {
+	__u64 __opaque[2];
+	char __opaque_c[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 81a2005edc26..47d46a51855f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2461,6 +2461,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index a6717a76c1e0..ef9aef62f1ac 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -893,6 +893,45 @@ __bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
 	rcu_read_unlock();
 }
 
+struct bpf_iter_css_kern {
+	struct cgroup_subsys_state *root;
+	struct cgroup_subsys_state *pos;
+	char flag;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *root, char flag)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
+	kit->root = root;
+	kit->pos = NULL;
+	kit->flag = flag;
+	rcu_read_lock();
+	return 0;
+}
+
+__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	if (!kit->pos)
+		kit->pos = kit->flag ? css_next_descendant_post(NULL, kit->root)
+					: css_next_descendant_pre(NULL, kit->root);
+	else
+		kit->pos = kit->flag ? css_next_descendant_post(kit->pos, kit->root)
+					: css_next_descendant_pre(kit->pos, kit->root);
+
+	return kit->pos;
+}
+
+__bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
+{
+	rcu_read_unlock();
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index cfbd527e3733..19f1f1bf9301 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7203,4 +7203,9 @@ struct bpf_iter_process {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css {
+	__u64 __opaque[2];
+	char __opaque_c[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 7d6a828d98b5..bb56295b1442 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -314,6 +314,12 @@ extern int bpf_iter_process_new(struct bpf_iter_process *it) __weak __ksym;
 extern struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it) __weak __ksym;
 extern void bpf_iter_process_destroy(struct bpf_iter_process *it) __weak __ksym;
 
+struct bpf_iter_css;
+extern int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *root, char flag) __weak __ksym;
+extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
+extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
  * using BPF open-coded iterators without having to write mundane explicit
-- 
2.20.1

