Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542FC7AB8F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjIVSPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjIVSPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:15:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEEAA7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:15:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8191a1d5acso3319981276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695406531; x=1696011331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yisyY0FcmMhu1UJ/oaYmui5M8B9s34gvtt+JkaXaZJE=;
        b=xKbjJFawPq3P2Rqp0AoelvxFAsmjkVVaYt6RF52xu7mhDWUmn2RIYRafiPyWdLGAdx
         1HFv9cniAx/PuVPNcOqYzqox0JCKxh3AE9S6oSqiKJZ5UkWVgsXjk7+slaDn6pxBonJh
         bApAhc7pKa/QKigrL94SXCkbJfwGaWtznY4ieIK5JKzD4AQGQLLlih7bxC0lfH57PZvL
         /2azdufvdUW3iI1JDAisciV2wrh4uOKZd4GaoK2rkZa3qLHw3hrhJ+dv2jDBsnVb4krP
         5bpnTGbt7g6dEO93n8f0nHygmpuQTXBT1+z17xeTPRMsfJM6rC/XkxyD2pgB8iSy5MZq
         bY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406531; x=1696011331;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yisyY0FcmMhu1UJ/oaYmui5M8B9s34gvtt+JkaXaZJE=;
        b=e22N2eTrYXeT0/QVVOborCFwYPO/QxKjZnJeZUO/GKmIsZHd99RwmJgSX34cFTGU+x
         52K9/5AXUSNb1Tk2K+yyfrGhEh/NXnDsCKS5LukovF4PWHN4VBemUSWZ4EWvoWTo7c1D
         48CCDhMTmtapIafUgPpAqDxLHroyCXIS5QTqxnzWsBYzU0EzyEakdqxRJotNtW0iluYg
         UK9aBr/0fWCgg4vVvrVZLCibSupM66a+CS+nB3/LALZyev2VYAacngLgHAQGXBGhfY/c
         XiYJLMpoeDQYRji1GTo+owxvIvrGZTgJCHl+836JwAXcZUBRh8uqP/PiMb0zDQKSeHxc
         QOVA==
X-Gm-Message-State: AOJu0YyjGHTtX5dx5YZYuGRNfAjOpoEq5RerM5mwNXbwWrGyRA/X2C78
        NzZpAM4h7Y7GXaKP7dkPRxGDNmJ8QSLKxAriSAc=
X-Google-Smtp-Source: AGHT+IFQ1zANXEZ45PUN85d3Byff5vsjkSZ9yZxDFGwfcMj4yS/9JsNcjoZvrTXXNE/JR+PhfTyQ2mp5VnDjWOxSv2c=
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2a3:200:bdd4:4eee:5b8e:9273])
 (user=saranyamohan job=sendgmr) by 2002:a25:316:0:b0:d7b:8d0c:43f1 with SMTP
 id 22-20020a250316000000b00d7b8d0c43f1mr784ybd.9.1695406531401; Fri, 22 Sep
 2023 11:15:31 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:15:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922181528.366670-1-saranyamohan@google.com>
Subject: [PATCH 6.1] block: fix use-after-free of q->q_usage_counter
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit d36a9ea5e7766961e753ee38d4c331bbe6ef659b upstream.

For blk-mq, queue release handler is usually called after
blk_mq_freeze_queue_wait() returns. However, the
q_usage_counter->release() handler may not be run yet at that time, so
this can cause a use-after-free.

Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu().
Since ->release() is called with rcu read lock held, it is agreed that
the race should be covered in caller per discussion from the two links.

Backport-notes: Not a clean cherry-pick since a lot has changed,
however essentially the same fix.

Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Dennis Zhou <dennis@kernel.org>
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20221215021629.74870-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 block/blk-sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a582ea0da74f..a82bdec923b2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -737,6 +737,7 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 	struct request_queue *q = container_of(rcu_head, struct request_queue,
 					       rcu_head);
 
+	percpu_ref_exit(&q->q_usage_counter);
 	kmem_cache_free(blk_get_queue_kmem_cache(blk_queue_has_srcu(q)), q);
 }
 
@@ -762,8 +763,6 @@ static void blk_release_queue(struct kobject *kobj)
 
 	might_sleep();
 
-	percpu_ref_exit(&q->q_usage_counter);
-
 	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
-- 
2.42.0.515.g380fc7ccd1-goog

