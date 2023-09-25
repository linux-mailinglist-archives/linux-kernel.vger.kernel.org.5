Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977F67AD678
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjIYK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:56:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71958AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:56:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-578d791dd91so4501403a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695639372; x=1696244172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrdiacOpaESaqEXHiOrMTWSWkSGBNArwX1oK/BX79n4=;
        b=KRTF0ghbHQmLgnAF6+iQYPHAJa2puc+eAnjl1P4XiCfqDpVjoE0ci+7On5ehlDFPIw
         R6xnvs9V6NwgXhxUGV7G4OH5JOm+tlIn/cLGibVJw51zLJgOsNpP26XzY4TP6I1e6DgK
         uk28NftmHFNXunvxqUsTKRJvPh2YRdKcRm22RkbwpJ7neifTE6ldJyki/89hwlxk7Wi9
         ibVyURD5xoGxUTCvKts2rUxG5L9gT42YtRl+zj9WtqR8XkpBjdKrH47s72i18eBJgdO8
         iy5gcZq3HAXoWz3S2E79SEK7Pcc/v+w7xZCsqZd31AbI0S5oGu92eH9Xr0yfdNPUTqSj
         foug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639372; x=1696244172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrdiacOpaESaqEXHiOrMTWSWkSGBNArwX1oK/BX79n4=;
        b=BJW9gn2kYTjT9ZO8g7IeJp1ueaLByJfFkbqESf16WeH4H341zfgZJFRFQY3rE2FO70
         Wcq4NH9Y+vDTGpy/KOOElf2K1qcbO5529jtkMDefi9S+nzUIMAUvg5ix4RA3dEp1hvH5
         L30m1SfJsdHISqqFJxL/2MtetAOtQTLHal9qQM9dNEn9GYsOlU46koNaAvRKoNvt8pCQ
         F83+0prleJ2cjpqi0Uf8DIGvUa/kRbye0mYuZxKmVxOknySZhI5ImI25lDrXjuGvSZOi
         FtkHiNTdYEI4VpWlrk39Fe65+RMvCEIyCPeY5lb8SprsOJqTNp107bNzWnPVtU7S/VfJ
         BWxw==
X-Gm-Message-State: AOJu0Yw0Qy4B2iyJugebmmM+ncDybxLe8OxqlsY3tY64AvUJRFJi9JUM
        IGwf0cJ/REKQwMq3hvlDuiof4A==
X-Google-Smtp-Source: AGHT+IH8Hsd65TRqjkZsDY7MW0VbsIM7FfKFrnxYWvPwtJ03hxT/bkpnb9jd5tLVrjAtCo6fCsdcgg==
X-Received: by 2002:a17:90b:e07:b0:268:798:a28b with SMTP id ge7-20020a17090b0e0700b002680798a28bmr14579618pjb.23.1695639371959;
        Mon, 25 Sep 2023 03:56:11 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm2297842pje.5.2023.09.25.03.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:56:11 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 4/7] bpf: Introduce css open-coded iterator kfuncs
Date:   Mon, 25 Sep 2023 18:55:49 +0800
Message-Id: <20230925105552.817513-5-zhouchuyi@bytedance.com>
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
---
 kernel/bpf/cgroup_iter.c                      | 57 +++++++++++++++++++
 kernel/bpf/helpers.c                          |  3 +
 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
 3 files changed, 66 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 810378f04fbc..ebc3d9471f52 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -294,3 +294,60 @@ static int __init bpf_cgroup_iter_init(void)
 }
 
 late_initcall(bpf_cgroup_iter_init);
+
+struct bpf_iter_css {
+	__u64 __opaque[2];
+	__u32 __opaque_int[1];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_css_kern {
+	struct cgroup_subsys_state *start;
+	struct cgroup_subsys_state *pos;
+	int order;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *start, enum bpf_cgroup_iter_order order)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+	kit->start = NULL;
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
+	switch (order) {
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
+	kit->order = order;
+	return 0;
+}
+
+__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+	if (!kit->start)
+		return NULL;
+
+	switch (kit->order) {
+	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
+		kit->pos = css_next_descendant_pre(kit->pos, kit->start);
+		break;
+	case BPF_CGROUP_ITER_DESCENDANTS_POST:
+		kit->pos = css_next_descendant_post(kit->pos, kit->start);
+		break;
+	default:
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
index 556262c27a75..9c3af36249a2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2510,6 +2510,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
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
index d989775dbdb5..aa247d1d81d1 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -174,4 +174,10 @@ extern int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task,
 extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) __weak __ksym;
 extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
 
+struct bpf_iter_css;
+extern int bpf_iter_css_new(struct bpf_iter_css *it,
+				struct cgroup_subsys_state *start, enum bpf_cgroup_iter_order order) __weak __ksym;
+extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
+extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
+
 #endif
-- 
2.20.1

