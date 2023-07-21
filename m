Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E875C68C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGUMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGUMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:07:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9440319A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:07:22 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R6pBy6FxyzHnV3;
        Fri, 21 Jul 2023 20:04:42 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 20:07:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <wander@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched: Remove unsued extern declarations
Date:   Fri, 21 Jul 2023 20:07:05 +0800
Message-ID: <20230721120705.32372-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f64f61145a38 ("sched: remove sched_exit()") removed sched_exit(),
commit ad46c2c4ebce ("sched: clean up fastcall uses of sched_fork()/sched_exit()")
mistakenly change sched_exit() to sched_dead() extern declarations.

And since commit 7c9414385ebf ("sched: Remove USER_SCHED")
uids_sysfs_init() is not used anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/sched/task.h | 1 -
 include/linux/sched/user.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index a23af225c898..d4ec49d36ca4 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -63,7 +63,6 @@ extern void init_idle(struct task_struct *idle, int cpu);
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
 extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 extern void sched_post_fork(struct task_struct *p);
-extern void sched_dead(struct task_struct *p);
 
 void __noreturn do_task_dead(void);
 void __noreturn make_task_dead(int signr);
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 4cc52698e214..ffa639dd3821 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -36,8 +36,6 @@ struct user_struct {
 	struct ratelimit_state ratelimit;
 };
 
-extern int uids_sysfs_init(void);
-
 extern struct user_struct *find_user(kuid_t);
 
 extern struct user_struct root_user;
-- 
2.34.1

