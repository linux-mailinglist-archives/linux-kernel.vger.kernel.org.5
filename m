Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AA7E8109
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbjKJSVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbjKJSTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:19:30 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6424C3D;
        Fri, 10 Nov 2023 01:42:39 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SRYf70QpPzMmkD;
        Fri, 10 Nov 2023 17:38:07 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 17:42:37 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 4/7] net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
Date:   Fri, 10 Nov 2023 17:37:10 +0800
Message-ID: <20231110093713.1895949-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231110093713.1895949-1-shaojijie@huawei.com>
References: <20231110093713.1895949-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

The hns3 driver define an array of string to show the coalesce
info, but if the kernel adds a new mode or a new state,
out-of-bounds access may occur when coalesce info is read via
debugfs, this patch fix the problem.

Fixes: c99fead7cb07 ("net: hns3: add debugfs support for interrupt coalesce")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 0b138635bafa..c083d1d10767 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -503,11 +503,14 @@ static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 	}
 
 	sprintf(result[j++], "%d", i);
-	sprintf(result[j++], "%s", dim_state_str[dim->state]);
+	sprintf(result[j++], "%s", dim->state < ARRAY_SIZE(dim_state_str) ?
+		dim_state_str[dim->state] : "unknown");
 	sprintf(result[j++], "%u", dim->profile_ix);
-	sprintf(result[j++], "%s", dim_cqe_mode_str[dim->mode]);
+	sprintf(result[j++], "%s", dim->mode < ARRAY_SIZE(dim_cqe_mode_str) ?
+		dim_cqe_mode_str[dim->mode] : "unknown");
 	sprintf(result[j++], "%s",
-		dim_tune_stat_str[dim->tune_state]);
+		dim->tune_state < ARRAY_SIZE(dim_tune_stat_str) ?
+		dim_tune_stat_str[dim->tune_state] : "unknown");
 	sprintf(result[j++], "%u", dim->steps_left);
 	sprintf(result[j++], "%u", dim->steps_right);
 	sprintf(result[j++], "%u", dim->tired);
-- 
2.30.0

