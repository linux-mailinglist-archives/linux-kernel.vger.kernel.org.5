Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1715770021
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjHDMXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHDMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:23:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B58B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:23:03 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHPwJ53vXzrS60;
        Fri,  4 Aug 2023 20:21:52 +0800 (CST)
Received: from huawei.com (10.67.175.85) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 20:22:57 +0800
From:   Xia Fukun <xiafukun@huawei.com>
To:     <davem@davemloft.net>, <hariprasad@chelsio.com>,
        <rahul.lakkireddy@chelsio.com>
CC:     <linux-kernel@vger.kernel.org>, <xiafukun@huawei.com>
Subject: [PATCH] cxgb4: Optimize the call of memset in fill_default_mask()
Date:   Fri, 4 Aug 2023 20:22:05 +0800
Message-ID: <20230804122205.193331-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.85]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using memset to assign values to fs->mask.fip,
the byte length should be sizeof(fs->mask.fip),
which is more reasonable than lip.

Fixes: 578b46b9383c ("cxgb4: add common api support for configuring filters")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 786ceae34488..caadb2283328 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -1097,7 +1097,7 @@ static void fill_default_mask(struct ch_filter_specification *fs)
 		memset(fs->mask.lip, ~0, sizeof(fs->mask.lip));
 
 	if (fip && !fip_mask)
-		memset(fs->mask.fip, ~0, sizeof(fs->mask.lip));
+		memset(fs->mask.fip, ~0, sizeof(fs->mask.fip));
 
 	if (fs->val.lport && !fs->mask.lport)
 		fs->mask.lport = ~0;
-- 
2.17.1

