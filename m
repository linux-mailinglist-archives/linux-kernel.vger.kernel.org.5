Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88427778BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjHKKZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHKKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:25:27 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 03:25:24 PDT
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EE12CA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:25:24 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id D4569B014EC23;
        Fri, 11 Aug 2023 18:23:13 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 18:23:13 +0800
Date:   Fri, 11 Aug 2023 18:23:07 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <tj@kernel.org>
CC:     <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>,
        <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>,
        <tiozhang@didiglobal.com>
Subject: [PATCH] workqueue: let WORKER_CPU_INTENSIVE be included in watchdog
Message-ID: <20230811102250.GA7959@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a pool has a worker with WORKER_CPU_INTENSIVE set but other workers
are not that busy, the pool->worklist will mostly be empty, which leads
the intensive work always having a chance of escaping from the watchdog's
check. This may cause watchdog miss finding out a forever running work
in WQ_CPU_INTENSIVE.

Also, after commit '616db8779b1e3f93075df691432cccc5ef3c3ba0',
workers with potentially intensive works will automatically be converted
into WORKER_CPU_INTENSIVE. This might let watchdog to miss all work
potentially running forever.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/workqueue.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 02a8f402eeb5..29875b680f5b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6280,10 +6280,23 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	rcu_read_lock();
 
 	for_each_pool(pool, pi) {
+		struct worker *worker;
 		unsigned long pool_ts, touched, ts;
+		bool check_intensive = false;
 
 		pool->cpu_stall = false;
-		if (list_empty(&pool->worklist))
+
+		/* Not sure if we should let WORKER_UNBOUND to
+		 * be included? Since let a unbound work to last
+		 * more than e,g, 30 seconds seem also unacceptable.
+		 */
+		for_each_pool_worker(worker, pool) {
+			if (worker->flags & WORKER_CPU_INTENSIVE) {
+				check_intensive = true;
+				break;
+			}
+		}
+		if (list_empty(&pool->worklist) && !check_intensive)
 			continue;
 
 		/*
-- 
2.17.1

