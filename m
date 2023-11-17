Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662847EF3AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346030AbjKQNWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:22:02 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675CD4B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:21:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwZt3bk_1700227309;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwZt3bk_1700227309)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 21:21:55 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: put the cookie to uaddr when create cookie
Date:   Fri, 17 Nov 2023 21:21:48 +0800
Message-Id: <20231117132148.17844-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the control process, it's necessary to get the cookie of the
task when create a cookie with command PR_SCHED_CORE_CREATE. In
current design, we have to use command PR_SCHED_CORE_GET after we
create a cookie, with one more syscall.

To optimize this process, we allow user to pass a userspace address,
and we put the cookie to the uaddr when we create the cookie
successfully. If the uaddr is NULL, the logic is the same as before.

Note that put_user() will return -EFAULT if error, which is different
from any error return value of sched_core_share_pid().

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core_sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f27498..96bd159844b7 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -142,7 +142,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_PROCESS_GROUP != PIDTYPE_PGID);
 
 	if (type > PIDTYPE_PGID || cmd >= PR_SCHED_CORE_MAX || pid < 0 ||
-	    (cmd != PR_SCHED_CORE_GET && uaddr))
+	    (cmd != PR_SCHED_CORE_GET && cmd != PR_SCHED_CORE_CREATE && uaddr))
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -229,6 +229,10 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	read_unlock(&tasklist_lock);
 
 out:
+	if (cmd == PR_SCHED_CORE_CREATE && !err && uaddr) {
+		ptr_to_hashval((void *)cookie, &id);
+		err = put_user(id, (u64 __user *)uaddr);
+	}
 	sched_core_put_cookie(cookie);
 	put_task_struct(task);
 	return err;
-- 
2.39.3

