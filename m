Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD07BC7CD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJGMqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbjJGMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:46:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F1CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:45:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-578d791dd91so2309393a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696682745; x=1697287545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGhoDnxquywg7pvND9cuNzWhEguzChXTrMgGU/wV1/E=;
        b=jjzo0vFPXsS+HiyQm3pbvwfo6h1VeiXDIaWVl08R5FkOsuKuJbLT+z+vauoRd+S4y7
         ATXS8x2KEPXvQh3t7knR64tG75CW0Mg92J+o6ovpuJouWXFUsKS5wUq10O5EHrmBRnw0
         5hUoO64fz9gb43P+sGcBtDkNy7JKJmXvd6L5PIgQIGVMCE1wDm0lCWXRcwzBXKpatL6O
         3ooZ+vgIS+cNcWJalvaHWyweQnw1ZQsH1YWvx0t/288zCjUkxAphClhh+35Q2FcTq+YL
         B5eO1HmT1e/E+hCAvj80PiXZ7h97lr62BBcJc+SfMiRGAeKBIfYxk2FS0qFZgpWbYwHv
         52JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682745; x=1697287545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGhoDnxquywg7pvND9cuNzWhEguzChXTrMgGU/wV1/E=;
        b=q3k7G9Lv5c2gNOQhwtD7IbkDVcXgCYcwJiSYTYmA8xgGnhIDvYE2taMtXgX+Nh7146
         uN9i5UJ+b11O0oOVI9lSey0raM14m+uk2hilGOKfQeCJ8Gwb4CPX3u9FgwFUqePG0lm9
         hSX7/oA84UvuDrv6IxlrONp7oZR6AZeeRgReINz6efJcMTZxAVmE6WSEqwph+MLQjAdM
         IahC0HJsGlOKFAvCe+50jPOdyQKk7HdquStUcTiQnP9gTP044LO7+C5kRcL+hhQSLGZj
         MSCcXCMaj6S/sKAck41pN3nnC+jdaGq008ALgFpCph/nAS/uoOwZz2jDZdqwlI9PDgcv
         SEqw==
X-Gm-Message-State: AOJu0YyDCzssYF0aRpGv6OSkiYggwTC2636lzerwMqajOCZs19tQ+W7N
        eKBUgaJKYrXoSjqzX8we2ya0yw==
X-Google-Smtp-Source: AGHT+IFiX+kBOgpQX1/yV0pbGC/CWpw6TUzvjp9EDEXcB4Md+FvmtjVHBlrVl7pTXT20u6dHP/BMQA==
X-Received: by 2002:a17:90a:d796:b0:279:e3a:1bd3 with SMTP id z22-20020a17090ad79600b002790e3a1bd3mr10279926pju.21.1696682745288;
        Sat, 07 Oct 2023 05:45:45 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5095388pjw.47.2023.10.07.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:45:45 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 4/8] bpf: Introduce css open-coded iterator kfuncs
Date:   Sat,  7 Oct 2023 20:45:18 +0800
Message-Id: <20231007124522.34834-5-zhouchuyi@bytedance.com>
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

This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_css in open-coded iterator
style. These kfuncs actually wrapps css_next_descendant_{pre, post}.
css_iter can be used to:

1) iterating a sepcific cgroup tree with pre/post/up order

2) iterating cgroup_subsystem in BPF Prog, like
for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.

The API design is consistent with cgroup_iter. bpf_iter_css_new accepts
parameters defining iteration order and starting css. Here we also reuse
BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
BPF_CGROUP_ITER_ANCESTORS_UP enums.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/cgroup_iter.c                      | 59 +++++++++++++++++++
 kernel/bpf/helpers.c                          |  3 +
 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
 3 files changed, 68 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 810378f04fbc..9c6ad892ae82 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -294,3 +294,62 @@ static int __init bpf_cgroup_iter_init(void)
 }
 
 late_initcall(bpf_cgroup_iter_init);
+
+struct bpf_iter_css {
+	__u64 __opaque[3];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_css_kern {
+	struct cgroup_subsys_state *start;
+	struct cgroup_subsys_state *pos;
+	unsigned int flags;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *start, unsigned int flags)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
+
+	kit->start = NULL;
+	switch (flags) {
+	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
+	case BPF_CGROUP_ITER_DESCENDANTS_POST:
+	case BPF_CGROUP_ITER_ANCESTORS_UP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	kit->start = start;
+	kit->pos = NULL;
+	kit->flags = flags;
+	return 0;
+}
+
+__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	if (!kit->start)
+		return NULL;
+
+	switch (kit->flags) {
+	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
+		kit->pos = css_next_descendant_pre(kit->pos, kit->start);
+		break;
+	case BPF_CGROUP_ITER_DESCENDANTS_POST:
+		kit->pos = css_next_descendant_post(kit->pos, kit->start);
+		break;
+	case BPF_CGROUP_ITER_ANCESTORS_UP:
+		kit->pos = kit->pos ? kit->pos->parent : kit->start;
+	}
+
+	return kit->pos;
+}
+
+__bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
+{
+}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8111437a999e..7596e83d6715 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2555,6 +2555,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 1ec82997cce7..9aab609f6edd 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -463,4 +463,10 @@ extern int bpf_iter_task_new(struct bpf_iter_task *it,
 extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) __weak __ksym;
 extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
 
+struct bpf_iter_css;
+extern int bpf_iter_css_new(struct bpf_iter_css *it,
+				struct cgroup_subsys_state *start, unsigned int flags) __weak __ksym;
+extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
+extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
+
 #endif
-- 
2.20.1

