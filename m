Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140367F3BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjKVCWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVCWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:22:07 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA171E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:22:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VwuMgws_1700619714;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwuMgws_1700619714)
          by smtp.aliyun-inc.com;
          Wed, 22 Nov 2023 10:22:01 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, kprateek.nayak@amd.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf: ignore exited thread when synthesize thread map
Date:   Wed, 22 Nov 2023 10:21:54 +0800
Message-Id: <20231122022154.12772-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synthesize thread map, some threads in thread map may have
already exited, so that __event__synthesize_thread() returns -1
and the synthesis breaks. However, It will not have any effect
if we just ignore the exited thread. So just ignore it and continue.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 tools/perf/util/synthetic-events.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a0579c7d7b9e..43ad2298a933 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -866,14 +866,16 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
 
 	err = 0;
 	for (thread = 0; thread < threads->nr; ++thread) {
+		/*
+		 * We may race with exiting thread, so don't stop just because
+		 * one thread couldn't be synthesized.
+		 */
 		if (__event__synthesize_thread(comm_event, mmap_event,
 					       fork_event, namespaces_event,
 					       perf_thread_map__pid(threads, thread), 0,
 					       process, tool, machine,
-					       needs_mmap, mmap_data)) {
-			err = -1;
-			break;
-		}
+					       needs_mmap, mmap_data))
+			continue;
 
 		/*
 		 * comm.pid is set to thread group id by
-- 
2.39.3

