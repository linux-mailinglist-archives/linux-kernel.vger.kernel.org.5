Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD07CD451
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbjJRGUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbjJRGTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:19:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5210E3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0ecb9a075so44247805ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609887; x=1698214687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL8epgVpk2Z5NetWJuhkyFSgrHs5uVsKQ57V0KAcMww=;
        b=Yv2ZdPMdTZqcA++WVr52++fTcyXkS+b38DTPX4BzDYC42khJIP7Jy+/onhnjxsPH7K
         o2tBwTDJEQPE9RXZaoQI/KEyGnN45sY13GDrNIT3rdAmMDuV9yvWv6dawMm6BMGuu2Q0
         ZWb2RKk+DbRjr10UCtZyAHAY4ch+V6JNfyZeH9eFKPZyRi0ln+XnImQJH1MYp5+SFIg0
         6E8C7xremEzEZirBGQoh1J9lZX28MjpevIW3jnCLGe9gNwdqjndtfPtY3QZNveWn1jaP
         3iFwdvT9xAdioQVo0u7/X3AW0MVj3ubPW3cRaXENJajE5HIugR1AyJgy4pO5wnk0Nr/F
         Xzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609887; x=1698214687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL8epgVpk2Z5NetWJuhkyFSgrHs5uVsKQ57V0KAcMww=;
        b=IYHNuubJwcXXIkV342bOTa/sOQmifbCXMywLamdhEvKwCTURX0kLdxer4WCHJtGsZ2
         T6z5ivCMW+jSdEDCCXvT4iEddvjJO7K4OM8KxEy+5vDImqsvNIIsUW3rUG5dKW0Ijkgv
         RxGoPFOpeEXC8hkMziQYbLS2as8TNv5SnAlNkqZGzcc9pJa4ZW4zfXQlNMYAnAD0rUbl
         stw7qF8a/p10hnT0ZGclx1gNNKVWQgDkJzXTkRmp0/HBgACmWwgff3BxA9qgCxm99C9e
         HtZMRGP2ZZhVYCDSrzCtbM2oVVDYYoBMrYsiQIjutC7oMIZ2cfJ8dhn188A+AsZI0Jh5
         989g==
X-Gm-Message-State: AOJu0Yya+lDtTXzTMSJ3i+t84tFXa2UyFFgZAhz7ZK/fmWqD0UGgLOFF
        7KfCvnyuLyZDAKeAMbXr4gdCOQ==
X-Google-Smtp-Source: AGHT+IGJIpehzPdpQ6hVtAly07tSb5QiKQsHZ0Rb9SmsxRvIE8XkicC86AUJ1lctNjI3AiWhIkO68Q==
X-Received: by 2002:a17:902:fa8e:b0:1c9:d90b:c3e4 with SMTP id lc14-20020a170902fa8e00b001c9d90bc3e4mr4246104plb.10.1697609886810;
        Tue, 17 Oct 2023 23:18:06 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:06 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 4/8] bpf: Introduce css open-coded iterator kfuncs
Date:   Wed, 18 Oct 2023 14:17:42 +0800
Message-Id: <20231018061746.111364-5-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 kernel/bpf/cgroup_iter.c                      | 65 +++++++++++++++++++
 kernel/bpf/helpers.c                          |  3 +
 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
 3 files changed, 74 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 810378f04fbc..209e5135f9fb 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -294,3 +294,68 @@ static int __init bpf_cgroup_iter_init(void)
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
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		"Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *start, unsigned int flags)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) > sizeof(struct bpf_iter_css));
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
+
+__diag_pop();
\ No newline at end of file
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c25941531265..b1d285ed4796 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2566,6 +2566,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
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
index 2f6c747aa874..1386baf9ae4a 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -471,4 +471,10 @@ extern int bpf_iter_task_new(struct bpf_iter_task *it,
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

