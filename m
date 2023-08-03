Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CEA76E25E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHCID0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjHCIC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:02:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8D24C12
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:54:21 -0700 (PDT)
Received: from dggpemm100012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGgy442tBzNmf5;
        Thu,  3 Aug 2023 15:50:52 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 15:54:18 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 15:54:18 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <jiangshanlai@gmail.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] workqueue: use LIST_HEAD to initialize cull_list
Date:   Thu, 3 Aug 2023 15:51:35 +0800
Message-ID: <20230803075135.499536-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use LIST_HEAD() to initialize cull_list instead of open-coding it.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/workqueue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3ddd0d599dab..ae975a7c9f69 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2307,9 +2307,8 @@ static void idle_worker_timeout(struct timer_list *t)
 static void idle_cull_fn(struct work_struct *work)
 {
 	struct worker_pool *pool = container_of(work, struct worker_pool, idle_cull_work);
-	struct list_head cull_list;
+	LIST_HEAD(cull_list);
 
-	INIT_LIST_HEAD(&cull_list);
 	/*
 	 * Grabbing wq_pool_attach_mutex here ensures an already-running worker
 	 * cannot proceed beyong worker_detach_from_pool() in its self-destruct
@@ -3875,10 +3874,8 @@ static void rcu_free_pool(struct rcu_head *rcu)
 static void put_unbound_pool(struct worker_pool *pool)
 {
 	DECLARE_COMPLETION_ONSTACK(detach_completion);
-	struct list_head cull_list;
 	struct worker *worker;
-
-	INIT_LIST_HEAD(&cull_list);
+	LIST_HEAD(cull_list);
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-- 
2.25.1

