Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865657866D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbjHXEj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbjHXEiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:38:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA810E4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:38:47 -0700 (PDT)
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RWVfy1kvRzrSK3;
        Thu, 24 Aug 2023 12:37:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 24 Aug
 2023 12:38:44 +0800
From:   Liu Chao <liuchao173@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <louhongxiang@huawei.com>, <chenjiashang1@huawei.com>,
        <wangyanan55@huawei.com>
Subject: [PATCH] sched: Increase MAX_SHARES
Date:   Thu, 24 Aug 2023 05:37:53 +0100
Message-ID: <20230824043753.2049500-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of CPUs is large, such as 320 CPUs, create two cgroups in
/sys/fs/cgroup/cpu/: system.slice and machine.slice. system.slice uses 0.5
CPU, and machine.slice uses the reset 319.5 CPUs. The cpu.shares of
system.slice is set to 1024 by default, so in order to achieve this
effect, machine.slice needs to be set to 319.5 * 1024 / 0.5 = 654336,
which is greater than 1<<18, so it is increased to 1<<20.

Signed-off-by: Liu Chao <liuchao173@huawei.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0f871e9b169c..2cc1cc7dd71a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -482,7 +482,7 @@ struct task_group {
  *  limitation from this.)
  */
 #define MIN_SHARES		(1UL <<  1)
-#define MAX_SHARES		(1UL << 18)
+#define MAX_SHARES		(1UL << 20)
 #endif
 
 typedef int (*tg_visitor)(struct task_group *, void *);
-- 
2.23.0

