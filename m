Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6989794192
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbjIFQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIFQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:38:34 -0400
Received: from out0-219.mail.aliyun.com (out0-219.mail.aliyun.com [140.205.0.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A341738;
        Wed,  6 Sep 2023 09:38:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.UZ2fPb0_1694018302;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.UZ2fPb0_1694018302)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 00:38:23 +0800
From:   "=?UTF-8?B?5p2O5qOSKOS8r+WFrik=?=" <libang.li@antgroup.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Cc:     <gregkh@linuxfoundation.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?5p2O5qOSKOS8r+WFrik=?=" <libang.li@antgroup.com>
Subject: [PATCH 6.1.y] perf/core: Fix possible deadlock in sys_perf_event_open()
Date:   Thu, 07 Sep 2023 00:38:21 +0800
Message-Id: <20230906163821.85031-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain scenarios, gctx and ctx may be equal in the
__perf_event_ctx_lock_double() function, resulting in a deadlock.

Thread 1, thread 2 and thread 3 belong to the same process, and the
process number is assumed to be M. The deadlock scenario is as follows:

1) Thread 1 creates a pure software group through the system call
   sys_perf_event_open() and returns an fd, assuming the value of fd is N.
   The parameters of sys_perf_event_open() are as follows.

   For example:
    perf_event_attr.type = PERF_TYPE_SOFTWARE;
    pid = M;
    cpu = 0;
    group_fd = -1;
    flags = 0;
    N = sys_perf_event_open(&perf_event_attr, pid, cpu, group_fd, flags);

2) Thread 2 and thread 3 call the perf_event_open() function concurrently
   with the same parameters on a different cpu. And use the fd generated
   by thread 1 as group_fd. The parameters of sys_perf_event_open() are
   as follows.

   For example:
    perf_event_attr.type = PERF_TYPE_HARDWARE;
    pid = M;
    cpu = 0;
    group_fd = N;
    flags = 0;
    sys_perf_event_open(&perf_event_attr, pid, cpu, group_fd, flags);

3) In the __perf_event_ctx_lock_double function, assuming that thread 2
   successfully acquires gctx->mutex and ctx->mutex first, thread 3 will
   wait here. At the same time, thread 2 will move the pure software gruop
   to the hardware context and change group_leader->ctx to the hardware
   context.

4) When thread 2 releases gctx->mutex and ctx->mutex, thread 3 acquires
   gctx->mutex and ctx->mutex. And find that group_leader->ctx != gctx,
   then reacquires gctx. At this time, gctx is equal to the ctx of thread
   3, triggering a deadlock.

Fixes: 321027c1fe77 ("perf/core: Fix concurrent sys_perf_event_open() vs. 'move_group' race")
Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db1065daabb6..8af980cdd3a5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12161,6 +12161,11 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
 	}
 	rcu_read_unlock();
 
+	if (gctx == ctx) {
+		put_ctx(gctx);
+		return NULL;
+	}
+
 	mutex_lock_double(&gctx->mutex, &ctx->mutex);
 
 	if (group_leader->ctx != gctx) {
@@ -12465,6 +12470,11 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	if (move_group) {
 		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
+		if (unlikely(!gctx)) {
+			mutex_lock(&ctx->mutex);
+			move_group = 0;
+			goto not_move_group;
+		}
 
 		if (gctx->task == TASK_TOMBSTONE) {
 			err = -ESRCH;
-- 
2.19.1.6.gb485710b

