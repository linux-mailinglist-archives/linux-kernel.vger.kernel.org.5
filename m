Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B475A8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjGTIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGTIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:05:37 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1050213C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:05:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689840333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U7SNqNg8l9jcFOH2jbUPGRpUOcJQOOmYIXLh9NsQCGE=;
        b=PzprmWEumOxHgWMjAnQUlo//3iHng93GvAUVcRI8HM47zTYzWx+C8g3YQuEyikGNdx45mQ
        ireIT+f9zZXtZZvez4TjWerWJwneQnBLYUL4KObDLiLOA6sgIDZzo95lusLeFS3gRoQQgc
        FpawkfcLM5qRnRhlMB5fB4clTxfPFAc=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/debug: Print tgid in sched_show_task()
Date:   Thu, 20 Jul 2023 16:05:16 +0800
Message-Id: <20230720080516.1515297-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple blocked tasks are printed when the system hangs. They may have
the same parent pid, but belong to different task groups.

Printing tgid lets users better know whether these tasks are from the same
task group or not.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9020d34b22fe..80feede4e7c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9187,9 +9187,9 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
-		free, task_pid_nr(p), ppid,
-		read_task_thread_flags(p));
+	pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d flags:0x%08lx\n",
+		free, task_pid_nr(p), task_tgid_nr(p),
+		ppid, read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
-- 
2.25.1

