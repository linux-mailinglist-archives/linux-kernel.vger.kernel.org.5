Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601E777DDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbjHPJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243587AbjHPJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:49:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0A226B7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:49:51 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQjxn2QmCz1GDWZ;
        Wed, 16 Aug 2023 17:48:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:49:49 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>
CC:     <chenhao418@huawei.com>, <shaojijie@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH drivers/perf: hisi: 2/2] drivers/perf: hisi: fix set wrong filter mode for running events issue
Date:   Wed, 16 Aug 2023 17:46:19 +0800
Message-ID: <20230816094619.3563784-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230816094619.3563784-1-shaojijie@huawei.com>
References: <20230816094619.3563784-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

hns3_pmu_select_filter_mode() includes a series of mode judgments such
as global mode ,function mode, function-queue mode, port mode, port-tc
mode.

For a special scenario, command use parameter "bdf=0x3700,config=0x3,
queue=0x0", it is expected to enter function-queue mode, but event of
config 0x3 doesn't support func-queue mode, then it enter port-tc mode.
it's not up to expectations.

It shouldn't enter any modes but return -ENOENT.

So, add judgement of bdf parameter to fix it.

Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/perf/hisilicon/hns3_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 6a4d04cbae91..7f38a9e489d4 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1000,12 +1000,13 @@ static bool
 hns3_pmu_is_enabled_port_tc_mode(struct perf_event *event,
 				 struct hns3_pmu_event_attr *pmu_event)
 {
+	u16 bdf = hns3_pmu_get_bdf(event);
 	u8 tc_id = hns3_pmu_get_tc(event);
 
 	if (!(pmu_event->filter_support & HNS3_PMU_FILTER_SUPPORT_PORT_TC))
 		return false;
 
-	return tc_id != HNS3_PMU_FILTER_ALL_TC;
+	return (tc_id != HNS3_PMU_FILTER_ALL_TC) && (!bdf);
 }
 
 static bool
-- 
2.30.0

