Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE407750C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjHICNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHICNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:13:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318151BCD;
        Tue,  8 Aug 2023 19:13:36 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLD8k2zPxzrSXp;
        Wed,  9 Aug 2023 10:12:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 10:13:33 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
        <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH net] net: hns3: fix strscpy causing content truncation issue
Date:   Wed, 9 Aug 2023 10:09:02 +0800
Message-ID: <20230809020902.1941471-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
items to a string for content, and we add '\n' and '\0' in the last
two bytes of content.

strscpy() will add '\0' in the last byte of destination buffer(one of
items), it result in finishing content print ahead of schedule and some
dump content truncation.

One Error log shows as below:
cat mac_list/uc
UC MAC_LIST:

Expected:
UC MAC_LIST:
FUNC_ID  MAC_ADDR            STATE
pf       00:2b:19:05:03:00   ACTIVE

The destination buffer is length-bounded and not required to be
NUL-terminated, so just change strscpy() to memcpy() to fix it.

Fixes: 1cf3d5567f27 ("net: hns3: fix strncpy() not using dest-buf length as length issue")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c         | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 52546f625c8b..f276b5ecb431 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -464,9 +464,9 @@ static void hns3_dbg_fill_content(char *content, u16 len,
 		if (result) {
 			if (item_len < strlen(result[i]))
 				break;
-			strscpy(pos, result[i], strlen(result[i]));
+			memcpy(pos, result[i], strlen(result[i]));
 		} else {
-			strscpy(pos, items[i].name, strlen(items[i].name));
+			memcpy(pos, items[i].name, strlen(items[i].name));
 		}
 		pos += item_len;
 		len -= item_len;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 409db2e70965..0fb2eaee3e8a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -111,9 +111,9 @@ static void hclge_dbg_fill_content(char *content, u16 len,
 		if (result) {
 			if (item_len < strlen(result[i]))
 				break;
-			strscpy(pos, result[i], strlen(result[i]));
+			memcpy(pos, result[i], strlen(result[i]));
 		} else {
-			strscpy(pos, items[i].name, strlen(items[i].name));
+			memcpy(pos, items[i].name, strlen(items[i].name));
 		}
 		pos += item_len;
 		len -= item_len;
-- 
2.30.0

