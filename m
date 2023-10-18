Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C277CD44F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbjJRGUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbjJRGSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:18:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB50BD73
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9b1e3a809so43299595ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609881; x=1698214681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbIp3xjsMf+vYU1+9/Ac/+6x9YCK8BhSfh7PegmcPCk=;
        b=P60L+SOxGIk94nEPVnzuCQHC3zDs9PjIbeKM3/GOID90zzbfc72OkNnJ2cBicTZbNz
         2L6fF0ffUYiwZH41Il7pmXX6v8l7AMHcmhDOvB3M8Jhq0vgiyleUlcyRrPVpjKWNLOrx
         Cq4lPZohGdS+7EdMceaaM60pcLLMQ72HFz2k7ka2646lk+6Xw3ubIrel4XLOY2BkRMlx
         sx2WfF+44CjmP2YLJpg4/7ZgNLAsbP1n3H1ehiF4Hm0l2hOD+bf1OQ8vLIOhDDSqDAu0
         2OSqrqduISXFK4Fu47FPWhENfyYvkCFYIaDPWaMOXeNZLz3Kr/pSvJX4F0hfT4IUNa2S
         +isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609881; x=1698214681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbIp3xjsMf+vYU1+9/Ac/+6x9YCK8BhSfh7PegmcPCk=;
        b=bJ9R1CCW3IY5RWOjoPB3itFlmEQy4tF48IGfL7f4Y9GqUVwULZo1ss1OchMWyEDgWN
         Z3tNLWszzSV+g96p0NqYJd4WfjRYSEUAlnEibRi5wMpk+fLJk2FNiU3qkA8SRVvC1sl/
         WuIeX/7dAn1iAPy1jRxJno8ivr78h9mRFuQ7iYp/95XWLd2fIAsCDdu6Tu4jDLo7kh6S
         TH6Nd0/+L17SMrT5tMvhLABUm8vbqD+3961W1EDxTS8EqjiwKHgnuNMDsfl23a/wPE1i
         Y1go5e3giBNT2rGHwa7LBtxpGEAflaoeW0N9xn3EVA3lJnIDG9Rwdm9u4ivIIfx6QFup
         i8sg==
X-Gm-Message-State: AOJu0Yy/IWNTbGfjRbL23sIxWGCxdvUp5kcWwXbL3283os5XJGXYQBD/
        WTfJ3sGfE8jsT4L4oE1VF0HAdawT4lYm1LY/8nhgpA==
X-Google-Smtp-Source: AGHT+IFC8fOKgyIJb1DDkYHEoktnGwfhLo8Bs4wVZzl4BwI3qMDETlIkWvigD/g4DBAGQ2Z2RNiA9g==
X-Received: by 2002:a17:903:246:b0:1c7:5a63:43bb with SMTP id j6-20020a170903024600b001c75a6343bbmr5289084plh.8.1697609881516;
        Tue, 17 Oct 2023 23:18:01 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:01 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 2/8] bpf: Introduce css_task open-coded iterator kfuncs
Date:   Wed, 18 Oct 2023 14:17:40 +0800
Message-Id: <20231018061746.111364-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
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

This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_css_task in open-coded
iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
end}. BPF programs can use these kfuncs through bpf_for_each macro for
iteration of all tasks under a css.

css_task_iter_*() would try to get the global spin-lock *css_set_lock*, so
the bpf side has to be careful in where it allows to use this iter.
Currently we only allow it in bpf_lsm and bpf iter-s.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 58 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 23 ++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  8 +++
 4 files changed, 92 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 61f51dee8448..c01441db9fd5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2560,6 +2560,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index fef17628341f..e4126698cecf 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -894,6 +894,64 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 
 __diag_pop();
 
+struct bpf_iter_css_task {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_css_task_kern {
+	struct css_task_iter *css_it;
+} __attribute__((aligned(8)));
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != sizeof(struct bpf_iter_css_task));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
+					__alignof__(struct bpf_iter_css_task));
+	kit->css_it = NULL;
+	switch (flags) {
+	case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
+	case CSS_TASK_ITER_PROCS:
+	case 0:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
+	if (!kit->css_it)
+		return -ENOMEM;
+	css_task_iter_start(css, flags, kit->css_it);
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	if (!kit->css_it)
+		return NULL;
+	return css_task_iter_next(kit->css_it);
+}
+
+__bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	if (!kit->css_it)
+		return;
+	css_task_iter_end(kit->css_it);
+	bpf_mem_free(&bpf_global_ma, kit->css_it);
+}
+
+__diag_pop();
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb58987e4844..974713185269 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10472,6 +10472,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
+	KF_bpf_iter_css_task_new,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10495,6 +10496,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_iter_css_task_new)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10520,6 +10522,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_iter_css_task_new)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11050,6 +11053,20 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 						  &meta->arg_rbtree_root.field);
 }
 
+static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_LSM:
+		return true;
+	case BPF_TRACE_ITER:
+		return env->prog->aux->sleepable;
+	default:
+		return false;
+	}
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
 			    int insn_idx)
 {
@@ -11300,6 +11317,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
+			if (meta->func_id == special_kfunc_list[KF_bpf_iter_css_task_new]) {
+				if (!check_css_task_iter_allowlist(env)) {
+					verbose(env, "css_task_iter is only allowed in bpf_lsm and bpf iter-s\n");
+					return -EINVAL;
+				}
+			}
 			ret = process_iter_arg(env, regno, insn_idx, meta);
 			if (ret < 0)
 				return ret;
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2c8cb3f61529..6792ed2b45d7 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -458,4 +458,12 @@ extern void bpf_throw(u64 cookie) __ksym;
 		__bpf_assert_op(LHS, <=, END, value, false);		\
 	})
 
+struct bpf_iter_css_task;
+struct cgroup_subsys_state;
+extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags) __weak __ksym;
+extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
+extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
+
+
 #endif
-- 
2.20.1

