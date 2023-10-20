Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884B7D1081
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbjJTN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjJTN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:27:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358FE8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:27:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C0C433C7;
        Fri, 20 Oct 2023 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697808477;
        bh=CUPCLoZKlk4Vm8CIWIXYNCFjVcmILxXwZ8VIwc2nQpA=;
        h=From:To:Cc:Subject:Date:From;
        b=knT9wUf+n+I6fPtdBxI/pE5B8NoaxmLwCjW4MFDA4RhXjIClZ2NT83fvwzcj6TNcC
         8e7WZKf49jBZz1QBSP6ZAhqUocdJum9HcIS8c+D0rBHSrtAL3h0zhH/ugHUZ6gDUKf
         NhxsCDzl9CANVzEjoe+Ufz83C2eYrdaD6TygJs/weFS16G52SDIutqpUANWRyJidfV
         RenAWqNjsKcBcjdYKfFTbZ4xaxWAJWPrSaKq3XZyEHwqnOforRXYWJyyuI5hMyU6FW
         gr2dtfGY47EWnNdQR0ynUfNLhwFcwgy//OXdEfB3rk3FeOzbziG/SKS+U5U20arFUq
         r8E7p/nd20UXw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Chuyi Zhou <zhouchuyi@bytedance.com>, Tejun Heo <tj@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: hide cgroup functions for configs without cgroups
Date:   Fri, 20 Oct 2023 15:27:35 +0200
Message-Id: <20231020132749.1398012-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When cgroups are disabled, the newly added functions don't build:

kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
  917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
      |              ^~~~~~~~~~~~~~~~~~~
kernel/bpf/task_iter.c:925:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
  925 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
      |                                                            ^~~~~~

Hide them in an #ifdef section.

Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/task_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 654601dd6b493..15a184f4f954d 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -904,6 +904,7 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
+#ifdef CONFIG_CGROUPS
 __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
 		struct cgroup_subsys_state *css, unsigned int flags)
 {
@@ -947,6 +948,7 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 	css_task_iter_end(kit->css_it);
 	bpf_mem_free(&bpf_global_ma, kit->css_it);
 }
+#endif
 
 __diag_pop();
 
-- 
2.39.2

