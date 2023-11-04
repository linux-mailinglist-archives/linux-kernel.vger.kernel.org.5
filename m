Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07627E0EFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjKDLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjKDLIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:08:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5121136
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:08:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4850EC433C7;
        Sat,  4 Nov 2023 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699096095;
        bh=VZIHdmkP+aP54yfJmioRalXA7EoSHGcpY8h5hMnTprk=;
        h=From:To:Cc:Subject:Date:From;
        b=IiP5x435Lj825vE5JslBi8mVcM0YQKP5sCDqeEimwLZuPNLrVJDB2UTWPkWB71+Sn
         TUt9YuH0jgMMrjv2o0r0yruchUgYBKqAB8XF9tyjjpF+kZOfA2BzNfZ2/KUHL8MuXG
         u3o9KPd8+hqdzB4iAFPWUR7gddlrSJosjZ0GmLnJGOcUK/pSQjDSXdLYX0EnLI66S3
         0bIeH4zO7SGL84Aj5Afleemzjd8GtL/06uuTBcNYq1FHRkAvVs2PyRWRT/zLTZeQGC
         x6k2yq6Y8soC/GCYFK0gXLll+hSL6NNh3j+eqn1iUS8fdpJ8u0J0DPPSGQ8QT5hyzM
         Urf8oBmEo5tbA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: Remove inc/dec_dl_migration on !SMP
Date:   Sat,  4 Nov 2023 12:08:05 +0100
Message-ID: <f5634cc69566bd04af9f148b0ad95c2b45814ffa.1699095970.git.bristot@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit "5fe7765997b1 sched/deadline: Make dl_rq->pushable_dl_tasks
update drive dl_rq->overloaded)" removed these functions on SMP, but
thet !SMP was left. I thought that the compiler would complain about
the unused functions, but it was not complaining.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/deadline.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..6b17220b554e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -718,16 +718,6 @@ void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
 }
 
-static inline
-void inc_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-}
-
-static inline
-void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-}
-
 static inline void deadline_queue_push_tasks(struct rq *rq)
 {
 }
-- 
2.41.0

