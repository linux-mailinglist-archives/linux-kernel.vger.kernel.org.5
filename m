Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C135178F78E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbjIADyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjIADyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:54:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45518C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:54:04 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcPFC5mgTzNn04;
        Fri,  1 Sep 2023 11:50:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 11:54:01 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <yangyicong@hisilicon.com>,
        <shaojijie@huawei.com>
CC:     <chenhao418@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: fix set wrong filter mode for running events issue
Date:   Fri, 1 Sep 2023 11:50:27 +0800
Message-ID: <20230901035027.3881389-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

hns3_pmu_select_filter_mode() includes A series of mode judgments such
as global mode ,function mode, function-queue mode, port mode, port-tc
mode.

For a special scenario:
command use parameter
perf stat -a -e hns3_pmu_sicl_0/bdf=0x3700,config=0x3,queue=0x0,
and hns3_pmu_is_enabled_func_mode() has a judgement as below:
if (!(pmu_event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC))

filter_support of event 0x3 hasn't set bit for func mode, so it can't
enter func-mode branch, and continue to func-queue mode judgement, port
judgement, port-tc mode, then enter port-tc mode.

It's not up to expectations, it shouldn't enter any modes but
return -ENOENT.

port-tc mode parameter show as below:
perf stat -a -e hns3_pmu_sicl_0/config=0x00001,port=0x0,tc=0x1

port-tc mode should use bdf parameter as 0, so, add judgement of
bdf parameter to fix it.

Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
changeLog:
  v2: add more details in log message suggested by Will
  v1 link: https://lore.kernel.org/all/20230816094619.3563784-1-shaojijie@huawei.com/
---
 drivers/perf/hisilicon/hns3_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index e0457d84af6b..2aa9cb045705 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -998,12 +998,13 @@ static bool
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

