Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A942177DDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbjHPJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbjHPJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:49:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1326B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:49:51 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQjvv4NLwzFqbx;
        Wed, 16 Aug 2023 17:46:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:49:48 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>
CC:     <chenhao418@huawei.com>, <shaojijie@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH drivers/perf: hisi: 1/2] drivers/perf: hisi: hns3: default use hardware event 0 as group leader event.
Date:   Wed, 16 Aug 2023 17:46:18 +0800
Message-ID: <20230816094619.3563784-2-shaojijie@huawei.com>
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

For hns3 pmu events, we use command as below before:
perf stat -g -e hns3_pmu_sicl_0/config=0x00105,global=1/
-e hns3_pmu_sicl_0/config=0x10105,global=1/ -I 1000

We want to use -g parameter to make 0x00105 event and 0x10105 event
share a hardware event, but for kernel 6.2, 'commit 5f8f95673f68
("perf evlist: Remove group option.")' remove -g parameter.

So add this patch to set default related event idx as 0 to share
the first hardware event.

The new command shows as below:
perf stat -e hns3_pmu_sicl_0/config=0x00105,global=1/
-e hns3_pmu_sicl_0/config=0x10105,global=1/ -I 1000

Fixes: 5f8f95673f68 ("perf evlist: Remove group option.")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/perf/hisilicon/hns3_pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index e0457d84af6b..6a4d04cbae91 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -796,9 +796,11 @@ static int hns3_pmu_find_related_event_idx(struct hns3_pmu *hns3_pmu,
 		if (!hns3_pmu_cmp_event(sibling, event))
 			continue;
 
-		/* Related events is used in group */
+		/* Related events is used in group, else we use index 0 event as related event */
 		if (sibling->group_leader == event->group_leader)
 			return idx;
+		else
+			return 0;
 	}
 
 	/* No related event and all hardware events are used up */
-- 
2.30.0

