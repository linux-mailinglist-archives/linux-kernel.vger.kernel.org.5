Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EBD79C787
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjILHCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjILHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:02:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625EE75
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c336f3f449so45836235ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502133; x=1695106933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbzquHAnwok7U8VH5ASiuRWtN2QtgmEjZHX4A6sEdQ0=;
        b=EgE/SEvhM6y7H0wOdoJWkDzV29CKcPkS3iWL8GssBkcc0O9ymUk5IhMnFKhvYVz7M0
         OhAQpdsl5k1naQB1oRrSa/OXFxDDPGjdfgZG/ECrAQa2+x71LlfB7pXbFUe4Ox/t9F77
         cLIcHTy2RaBomVkoR/Kljy5ollN4wNcDVT6/jAE5Xi/aZtEhd7wzp8WKSN2XV4qi4hSs
         7+fs9Ifk/Us6R8GOVpjdC57+grmarGBjpPdJIKcUIgqzTPIyM5tMTYV4ZqmplsSyMVsH
         bQC6P6th9E06JuHAEDCV018vo8zzU5d4N6htKV8QC2a9LDXHUL8vF3u7yKRamWZKRcZT
         S5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502133; x=1695106933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbzquHAnwok7U8VH5ASiuRWtN2QtgmEjZHX4A6sEdQ0=;
        b=PU+0fSV6O57JJVoAyImX/GKH/zcZpQn3CUjyOIeKr9w47axpbg4mm623g5DG2M5ItI
         d7DHvgVB6y6iixhkwQ6WI+Wnc8vLGly8poOjqetvq2/zdIEajtQoHLDJZ2wAc7K4+ME3
         goN8WT8Cz0rVc79Xo/KjEWrFCaSW0ckm3LBYue2R4LPC1GqTLS3iOPA55dQnycmWjUjP
         882tbZK1VxwCmfJbIyQB3QzooElJL2sRQGVjO4/2p8uxwduEy8MKsxekMz5ash1tQEBq
         V9JySNdx/oxhdpFBdc+Ip5E3zX2l7yFeCPL3U+xImsqUphmRL4Q6MfdnucoQUnN1P0DJ
         Dz7A==
X-Gm-Message-State: AOJu0YwxNJ5bO26ZeQQtvqVIUJVD6gWyDnYOqWNaWiT6VfjIhSm8Eanu
        5rMDsTzdyHkSIldgOfn8oK/YdD+JrzOAqfmacv8OBg==
X-Google-Smtp-Source: AGHT+IH3nN6SdkGHHenKlH89H8T3xLnbtavEibYfCQL2fxVa7I7VNXrgt1h0+smga0DjUw8E5wv8fA==
X-Received: by 2002:a17:902:8693:b0:1b8:66f6:87a3 with SMTP id g19-20020a170902869300b001b866f687a3mr10957357plo.52.1694502132925;
        Tue, 12 Sep 2023 00:02:12 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:12 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded iterator kfuncs
Date:   Tue, 12 Sep 2023 15:01:47 +0800
Message-Id: <20230912070149.969939-5-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch adds kfuncs bpf_iter_css_{pre,post}_{new,next,destroy} which
allow creation and manipulation of struct bpf_iter_css in open-coded
iterator style. These kfuncs actually wrapps css_next_descendant_{pre,
post}. BPF programs can use these kfuncs through bpf_for_each macro for
iteration of all descendant css under a root css.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/uapi/linux/bpf.h       |  8 +++++
 kernel/bpf/helpers.c           |  6 ++++
 kernel/bpf/task_iter.c         | 53 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 +++++
 tools/lib/bpf/bpf_helpers.h    | 12 ++++++++
 5 files changed, 87 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index befa55b52e29..57760afc13d0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7326,4 +7326,12 @@ struct bpf_iter_process {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css_pre {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_css_post {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9b7d2c6f99d1..ca1f6404af9e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2510,6 +2510,12 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_pre_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_css_pre_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_pre_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_post_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_css_post_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_post_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 9d1927dc3a06..8963fc779b87 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -880,6 +880,59 @@ __bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
 {
 }
 
+struct bpf_iter_css_kern {
+	struct cgroup_subsys_state *root;
+	struct cgroup_subsys_state *pos;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
+		struct cgroup_subsys_state *root)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_pre));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css_pre));
+	kit->root = root;
+	kit->pos = NULL;
+	return 0;
+}
+
+__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	kit->pos = css_next_descendant_pre(kit->pos, kit->root);
+	return kit->pos;
+}
+
+__bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
+{
+}
+
+__bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
+		struct cgroup_subsys_state *root)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_post));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css_post));
+	kit->root = root;
+	kit->pos = NULL;
+	return 0;
+}
+
+__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	kit->pos = css_next_descendant_post(kit->pos, kit->root);
+	return kit->pos;
+}
+
+__bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
+{
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index befa55b52e29..57760afc13d0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7326,4 +7326,12 @@ struct bpf_iter_process {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css_pre {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_css_post {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 858252c2641c..6e5bd9ef14d6 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -315,6 +315,18 @@ extern int bpf_iter_process_new(struct bpf_iter_process *it) __weak __ksym;
 extern struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it) __weak __ksym;
 extern void bpf_iter_process_destroy(struct bpf_iter_process *it) __weak __ksym;
 
+struct bpf_iter_css_pre;
+extern int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
+		struct cgroup_subsys_state *root) __weak __ksym;
+extern struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it) __weak __ksym;
+extern void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it) __weak __ksym;
+
+struct bpf_iter_css_post;
+extern int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
+		struct cgroup_subsys_state *root) __weak __ksym;
+extern struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it) __weak __ksym;
+extern void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it) __weak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
  * using BPF open-coded iterators without having to write mundane explicit
-- 
2.20.1

