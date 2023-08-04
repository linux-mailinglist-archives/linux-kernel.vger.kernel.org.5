Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07BF76F858
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHDDZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDDZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:25:04 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A244210
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:25:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHB0q3ftjz4f3kp9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:24:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
        by APP2 (Coremail) with SMTP id Syh0CgAXvuuIb8xk3MnNPQ--.65152S4;
        Fri, 04 Aug 2023 11:25:00 +0800 (CST)
From:   yangyingliang@huaweicloud.com
To:     linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, jiangshanlai@gmail.com, yangyingliang@huawei.com
Subject: [PATCH -next resend] workqueue: use LIST_HEAD to initialize cull_list
Date:   Fri,  4 Aug 2023 11:22:15 +0800
Message-Id: <20230804032215.1168792-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXvuuIb8xk3MnNPQ--.65152S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WryxKw43AFy8GF1UWFy5XFb_yoW8Jw4kpF
        43G3yxGrWrXr4I9a45JFWvkrW7GF1kXa45KFs5Ca1Sgr17JFs5XF4qka43AFWrJrW8Wr1S
        vFyqgFsFyr4IvFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu4UUUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

Use LIST_HEAD() to initialize cull_list instead of open-coding it.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
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

