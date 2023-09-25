Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB67ACEB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjIYDXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjIYDW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:22:59 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80783A3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:22:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VsjxV8O_1695612156;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VsjxV8O_1695612156)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 11:22:50 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: [PATCH] perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7
Date:   Mon, 25 Sep 2023 11:22:32 +0800
Message-Id: <1695612152-123633-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register por_dt_pmovsr Bits[7:0] indicates overflow from counters 7
to 0. But in arm_cmn_handle_irq(), only handled the overflow status of
Bits[3:0] which results in unhandled overflow status of counters 4 to 7.

So let the overflow status of DTC counters 4 to 7 to be handled.

Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 913dc04..6b50bc5 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1972,7 +1972,7 @@ static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
 		u64 delta;
 		int i;
 
-		for (i = 0; i < CMN_DTM_NUM_COUNTERS; i++) {
+		for (i = 0; i < CMN_DT_NUM_COUNTERS; i++) {
 			if (status & (1U << i)) {
 				ret = IRQ_HANDLED;
 				if (WARN_ON(!dtc->counters[i]))
-- 
1.8.3.1

