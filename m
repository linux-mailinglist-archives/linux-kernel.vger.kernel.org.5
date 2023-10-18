Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205F7CD45A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbjJRGVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344505AbjJRGVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:21:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9A1989
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c88b467ef8so45738055ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609892; x=1698214692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBjREUfdYjysteuQq+CF2MBmAUs5yTb/YGRZ4Q4shvo=;
        b=WW3aO8hMPq9dtwDyVMW8bvYBqA9W5ayBgjr8EyMbwXlENVQYLcT/O7MnckTrEdGeAg
         t3Ij9IMel+5V/0syQekAwBDa5pGTXJN50vM4JM/Ert0UO3OjadDmHxPrbzYIjEpp05YR
         8fckf4LZZ3YcnWgZBC+D3ppUdF1DZUnLWGicx7U3Vl7O531PMA4dtGJfd3VHaivS4sCL
         p5ePlszhPZWiR4srszNmO/1Uyo7dfe9UCHwRp/6uIloSdMXEBFBCC/FprMW3sGKB6ZdI
         noD7+sMWbwoACGT/faOYyZyYCEjEPBME58+XZ6OBAoubQZav46qxr2N5exRNtKxLUJMh
         NScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609892; x=1698214692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBjREUfdYjysteuQq+CF2MBmAUs5yTb/YGRZ4Q4shvo=;
        b=TT3bXaRpfCtpwW9v1an6NOHnFiAPgKJuYJU6h7II0YF6Kxcojlv7Hm1eOUV9Ffs/JD
         uF8UDMI7qsgE3YpuyZKhGmhT2u5GzRhnxQ6o9Z34WjU0lENMSZqLYQ+SkAGWLjGXViOa
         M+r/2rHpNiFOlv2E3jOHIcOJYsTTRyP9H/KjtNn+jq1olwD5kzr/e1PQVUPWnS9AlGeZ
         LFLwmDpR21qxzldqog3LwACL+fTPUWQccInZgsZcQspvNQBfZ+1cUAPhZShlWa2HQABW
         bysE9lbr8adnS+aW4aA17ZJ/Vj00BQnbcsKP9yhTvIMjh7Y0c7tFjHRtpaZDnFdEO1np
         tt3Q==
X-Gm-Message-State: AOJu0Yw356dmOE0iJPvNYFnhdeiOZv0m8WJT2xnueA9XA/4A/DXfioO7
        ywmBc2rl5ROlBdP6DWvq85OHKw==
X-Google-Smtp-Source: AGHT+IEcjcprgVH3l41ELy8Zj6cbhO4neAlWBPjwjSIwdE6So6A363RYv4MEKCuHWdtRisbJbwo7oQ==
X-Received: by 2002:a17:90a:31c:b0:27d:1ce5:1eb6 with SMTP id 28-20020a17090a031c00b0027d1ce51eb6mr4382459pje.17.1697609891808;
        Tue, 17 Oct 2023 23:18:11 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:11 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 6/8] bpf: Let bpf_iter_task_new accept null task ptr
Date:   Wed, 18 Oct 2023 14:17:44 +0800
Message-Id: <20231018061746.111364-7-zhouchuyi@bytedance.com>
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

When using task_iter to iterate all threads of a specific task, we enforce
that the user must pass a valid task pointer to ensure safety. However,
when iterating all threads/process in the system, BPF verifier still
require a valid ptr instead of "nullable" pointer, even though it's
pointless, which is a kind of surprising from usability standpoint. It
would be nice if we could let that kfunc accept a explicit null pointer
when we are using BPF_TASK_ITER_ALL_{PROCS, THREADS} and a valid pointer
when using BPF_TASK_ITER_THREAD.

Given a trival kfunc:
	__bpf_kfunc void FN(struct TYPE_A *obj);

BPF Prog would reject a nullptr for obj. The error info is:
"arg#x pointer type xx xx must point to scalar, or struct with scalar"
reported by get_kfunc_ptr_arg_type(). The reg->type is SCALAR_VALUE and
the btf type of ref_t is not scalar or scalar_struct which leads to the
rejection of get_kfunc_ptr_arg_type.

This patch add "__nullable" annotation:
	__bpf_kfunc void FN(struct TYPE_A *obj__nullable);
Here __nullable indicates obj can be optional, user can pass a explicit
nullptr or a normal TYPE_A pointer. In get_kfunc_ptr_arg_type(), we will
detect whether the current arg is optional and register is null, If so,
return a new kfunc_ptr_arg_type KF_ARG_PTR_TO_NULL and skip to the next
arg in check_kfunc_args().

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/task_iter.c |  7 +++++--
 kernel/bpf/verifier.c  | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index faa1712c1df5..59e747938bdb 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -976,7 +976,7 @@ __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
 __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
-		struct task_struct *task, unsigned int flags)
+		struct task_struct *task__nullable, unsigned int flags)
 {
 	struct bpf_iter_task_kern *kit = (void *)it;
 
@@ -988,14 +988,17 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
 	switch (flags) {
 	case BPF_TASK_ITER_ALL_THREADS:
 	case BPF_TASK_ITER_ALL_PROCS:
+		break;
 	case BPF_TASK_ITER_PROC_THREADS:
+		if (!task__nullable)
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	if (flags == BPF_TASK_ITER_PROC_THREADS)
-		kit->task = task;
+		kit->task = task__nullable;
 	else
 		kit->task = &init_task;
 	kit->pos = kit->task;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fcdf2382153a..e9bc5d4a25a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10332,6 +10332,11 @@ static bool is_kfunc_arg_refcounted_kptr(const struct btf *btf, const struct btf
 	return __kfunc_param_match_suffix(btf, arg, "__refcounted_kptr");
 }
 
+static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__nullable");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -10474,6 +10479,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
+	KF_ARG_PTR_TO_NULL,
 };
 
 enum special_kfunc_type {
@@ -10630,6 +10636,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_CALLBACK;
 
+	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
+		return KF_ARG_PTR_TO_NULL;
 
 	if (argno + 1 < nargs &&
 	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
@@ -11180,7 +11188,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
-		    (register_is_null(reg) || type_may_be_null(reg->type))) {
+		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
+			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -11205,6 +11214,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_NULL:
+			continue;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
-- 
2.20.1

