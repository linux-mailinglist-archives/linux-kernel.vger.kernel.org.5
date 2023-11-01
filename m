Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6507DE5EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjKASQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjKASQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:16:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B610E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:16:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290BCC433C8;
        Wed,  1 Nov 2023 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698862568;
        bh=CWEykj5+tFr+JNRKp03dxdLwO9L3eRx4zFB2zUr31Dc=;
        h=From:To:Cc:Subject:Date:From;
        b=l0MKaZJD8ihETltvQccrJPwHUwrskliP7I3a/sF6CamE6Mccw04Tkv0XsKLegQG6T
         uY/AbhnK9M2/dBW1yXum6u0EDjKHHMvs6fkIG2dQVmh7JZ6PGUbQwORJq5h+uVi7bP
         MycvLFTegmWDIYv2fFY3NMHqqLAT4GVZtnTwo9QIZH1pp0sHIfKC8uZ/iZGhJM53IN
         +AJouJHR9j0Q9Mi0PBudk3ALs45lCr0EY/YjnC35NNk2FOgroq+Ta9berSLLF3fHV+
         DW7Ej+9W/owTw4Il+HCk0vp61XQTeExGIJT3d5R8zAAF1uCKO/eVpSgqK1JcgBaQZo
         jd1ipZg4kflCQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [PATCHv2 bpf-next] bpf: fix compilation error without CGROUPS
Date:   Wed,  1 Nov 2023 19:16:01 +0100
Message-ID: <20231101181601.1493271-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthieu Baerts <matttbe@kernel.org>

Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
possible to build the kernel without CONFIG_CGROUPS:

  kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
  kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
    919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
        |              ^~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
  kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
    919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
        |                                    ^~~~~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
    927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
        |                                                            ^~~~~~
  kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
    930 |         css_task_iter_start(css, flags, kit->css_it);
        |         ^~~~~~~~~~~~~~~~~~~
        |         task_seq_start
  kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
  kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
    940 |         return css_task_iter_next(kit->css_it);
        |                ^~~~~~~~~~~~~~~~~~
        |                class_dev_iter_next
  kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
    940 |         return css_task_iter_next(kit->css_it);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
  kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
    949 |         css_task_iter_end(kit->css_it);
        |         ^~~~~~~~~~~~~~~~~

This patch simply surrounds with a #ifdef the new code requiring CGroups
support. It seems enough for the compiler and this is similar to
bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
been added in kernel/bpf/helpers.c and in the selftests.

Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665206927
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@intel.com/
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
[ added missing ifdefs for BTF_ID cgroup definitions ]
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/helpers.c   | 8 +++++---
 kernel/bpf/task_iter.c | 4 ++++
 kernel/bpf/verifier.c  | 8 ++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a108..95449ea7cc1b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2564,15 +2564,17 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
+#ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
-BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
+#endif
+BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 59e747938bdb..e0d313114a5b 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -894,6 +894,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 
 __diag_pop();
 
+#ifdef CONFIG_CGROUPS
+
 struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
@@ -952,6 +954,8 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 
 __diag_pop();
 
+#endif /* CONFIG_CGROUPS */
+
 struct bpf_iter_task {
 	__u64 __opaque[3];
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e42ce974b106..f2afb17a1534 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5421,7 +5421,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
 BTF_SET_START(rcu_protected_types)
 BTF_ID(struct, prog_test_ref_kfunc)
+#ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
+#endif
 BTF_ID(struct, bpf_cpumask)
 BTF_ID(struct, task_struct)
 BTF_SET_END(rcu_protected_types)
@@ -10873,7 +10875,9 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+#ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
+#endif
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10899,7 +10903,11 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+#ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
+#else
+BTF_ID_UNUSED
+#endif
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
-- 
2.41.0

