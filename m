Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126D67BDBAB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376357AbjJIMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbjJIMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:23:24 -0400
Received: from out-206.mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB02E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:23:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696854199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTkuKu1fmFP1M034eiGkI3GZ+Be2ZuV6kkNwoobSAUo=;
        b=ljkycbSmLqUGFWruU2fcp9eRmUqqUsv6xbsMmGj/kikBW3o8UHJ0nwJvd+X5KfoA7JXFUi
        Rw/aqMblSuY+wXWtnCDmJ1dfy1A0prXXDaqMfgUtD8pvSrx6JRmiz4OOktns3TICPmxN+1
        T1L2gPv2+mRV0MLQucM79pD2L5N7dmI=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v7 2/3] sched/rt: Init 'back' in init_tg_rt_entry
Date:   Mon,  9 Oct 2023 20:22:43 +0800
Message-Id: <20231009122244.2394336-3-yajun.deng@linux.dev>
In-Reply-To: <20231009122244.2394336-1-yajun.deng@linux.dev>
References: <20231009122244.2394336-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member 'back' in struct sched_rt_entity only related to
CONFIG_RT_GROUP_SCHED, so there is no need to init it in dequeue_rt_stack.

Init the member 'back' in init_tg_rt_entry.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v7: Init 'back' in init_tg_rt_entry.
v6: Independent patch.
v5: Resend it.
v4: Missed rt_se = root in dequeue_rt_stack().
v3: Keep parent is NULL in init_tg_rt_entry().
v2: Add WARN_ON_ONCE in init_tg_rt_entry().
v1: https://lore.kernel.org/all/20230801062714.3424299-1-yajun.deng@linux.dev/
---
 kernel/sched/rt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 642edbd24ffb..0d9e83c6fb71 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -233,8 +233,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 
 	if (!parent)
 		rt_se->rt_rq = &rq->rt;
-	else
+	else {
 		rt_se->rt_rq = parent->my_q;
+		parent->back = rt_se;
+	}
 
 	rt_se->my_q = rt_rq;
 	rt_se->parent = parent;
@@ -1444,10 +1446,8 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 	struct sched_rt_entity *back = NULL;
 	unsigned int rt_nr_running;
 
-	for_each_sched_rt_entity(rt_se) {
-		rt_se->back = back;
+	for_each_sched_rt_entity(rt_se)
 		back = rt_se;
-	}
 
 	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
 
-- 
2.25.1

