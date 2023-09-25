Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950BF7AD682
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjIYK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjIYK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:56:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862F2DF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:56:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27758c8f579so945217a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695639378; x=1696244178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOdJP7oL9V0pfghlkrFj0G9yXM6wChDw4505+CoOkdQ=;
        b=BmiMF2kcWkyOidvwJfG4QC0zB74vzpVlPTXjptXjUwOvBGUjyJEfURbh7VpmAvc4eG
         hBOBtzXtXgdgt9ICBWbxBE2lXh0sQmvM8VMFnpSv3wMwwq2dXQvYb/PVJxTpU2DKtm+w
         2Wo7D7VtMacgw0AIhg3JUjYNNDxe1ZVkWVSnNMOf3kWywBDA3DnOXHzXHkgdCSzffpw8
         3dDuv/AhBrfpwW5WwSRtgdIdPZYOK7xBRViLSX1Ax9fhbebxCREH1+S2wuUZKzReuo42
         9PnCRV5hGpLJFBeTtmquyy7k2QDp4PaTPk7Svm6RaFSgBPBzTBass38uMF5pqJp8c6tk
         ntQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639378; x=1696244178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOdJP7oL9V0pfghlkrFj0G9yXM6wChDw4505+CoOkdQ=;
        b=Wiht/YmCyXXNePXYbbiPbQ28ZorG9Bh1T6UpS/nvHP0VSUlYUTSJKVWVzvF2cjP0P8
         gw+RdAsEGaQB8RRyG6sUP8NeZVoeabfcKTiLoKhb4IOFIzbvCIcHiSrHsjzquT3+D/R+
         Frexk8vwZOc8nLryzQ3I+s6rFaFRrbYhyDgjc2IZy82tgxzO8e8DFVJo+1d/y8ZZkVk9
         ouV+dOiYkWGY1LdI7k6K6C16Lv+GqJf1yvShFkHoXObe/CrQryTHBQgGuElbK6B1PCHv
         p/t4jUsMHs7GrKKeJWH/8R9CSMNka0kuqnl0ZiRDH1T1R2YCFbPtXZ2gKCHv1E6iaHLB
         ZYYA==
X-Gm-Message-State: AOJu0YyWeIxh1vnGHzGlNboRvkYjDNsZ0VGedACT6tgjBi7ENvimyyIB
        SE1w3vpQ30B6GBa4dEm6/eOvFz0gIaooNCxRe6I=
X-Google-Smtp-Source: AGHT+IGF3/xIiLkqT45ecP2/7tusxq48zTsMuaXckeqHcz2gZk6O2utKTP6dF2fp03awV8/cVRLpfg==
X-Received: by 2002:a17:90b:164e:b0:26b:49de:13bd with SMTP id il14-20020a17090b164e00b0026b49de13bdmr3912935pjb.36.1695639378052;
        Mon, 25 Sep 2023 03:56:18 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm2297842pje.5.2023.09.25.03.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:56:17 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 6/7] bpf: Let bpf_iter_task_new accept null task ptr
Date:   Mon, 25 Sep 2023 18:55:51 +0800
Message-Id: <20230925105552.817513-7-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230925105552.817513-1-zhouchuyi@bytedance.com>
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
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

When using task_iter to iterate all threads of a specific task, we enforce
that the user must pass a valid task pointer to ensure safety. However,
when iterating all threads/process in the system, BPF verifier still
require a valid ptr instead of "nullable" pointer, even though it's
pointless, which is a kind of surprising from usability standpoint. It
would be nice if we could let that kfunc accept a explicit null pointer
when we are using BPF_TASK_ITER_ALL/BPF_TASK_ITER_PROC and a valid pointer
when using BPF_TASK_ITER_THREAD.

Given a trival kfunc:
	__bpf_kfunc void FN(struct TYPE_A *obj)

BPF Prog would reject a nullptr for obj. The error info is:
"arg#x pointer type xx xx must point to scalar, or struct with scalar"
reported by get_kfunc_ptr_arg_type(). The reg->type is SCALAR_VALUE and
the btf type of ref_t is not scalar or scalar_struct which leads to the
rejection of get_kfunc_ptr_arg_type.

This patch reuse the __opt annotation which was used to indicate that
the buffer associated with an __sz or __szk argument may be null:
	__bpf_kfunc void FN(struct TYPE_A *obj__opt)
Here __opt indicates obj can be optional, user can pass a explicit nullptr
or a normal TYPE_A pointer. In get_kfunc_ptr_arg_type(), we will detect
whether the current arg is optional and register is null, If so, return
a new kfunc_ptr_arg_type KF_ARG_PTR_TO_NULL and skip to the next arg in
check_kfunc_args().

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/task_iter.c |  7 +++++--
 kernel/bpf/verifier.c  | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 9bcd3f9922b1..7ac007f161cc 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -867,7 +867,7 @@ struct bpf_iter_task_kern {
 	unsigned int type;
 } __attribute__((aligned(8)));
 
-__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task, unsigned int type)
+__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task__opt, unsigned int type)
 {
 	struct bpf_iter_task_kern *kit = (void *)it;
 	BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task));
@@ -877,14 +877,17 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *
 	switch (type) {
 	case BPF_TASK_ITER_ALL:
 	case BPF_TASK_ITER_PROC:
+		break;
 	case BPF_TASK_ITER_THREAD:
+		if (!task__opt)
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	if (type == BPF_TASK_ITER_THREAD)
-		kit->task = task;
+		kit->task = task__opt;
 	else
 		kit->task = &init_task;
 	kit->pos = kit->task;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a065e18a0b3a..a79204c75a90 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10331,6 +10331,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
+	KF_ARG_PTR_TO_NULL,
 };
 
 enum special_kfunc_type {
@@ -10425,6 +10426,12 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
 }
 
+static inline bool is_kfunc_arg_optional_null(struct bpf_reg_state *reg,
+				const struct btf *btf, const struct btf_param *arg)
+{
+	return register_is_null(reg) && is_kfunc_arg_optional(btf, arg);
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -10497,6 +10504,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	 */
 	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
+			if (is_kfunc_arg_optional_null(reg, meta->btf, &args[argno]))
+				return KF_ARG_PTR_TO_NULL;
 		verbose(env, "arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
 			argno, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
 		return -EINVAL;
@@ -11028,7 +11037,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
-		    (register_is_null(reg) || type_may_be_null(reg->type))) {
+		    (register_is_null(reg) || type_may_be_null(reg->type)) && !is_kfunc_arg_optional(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -11053,6 +11062,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_NULL:
+			continue;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
-- 
2.20.1

