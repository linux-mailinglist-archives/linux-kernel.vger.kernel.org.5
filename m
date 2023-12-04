Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F9802E06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjLDI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjLDI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:57:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C99B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:57:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE04CC433C8;
        Mon,  4 Dec 2023 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701680262;
        bh=+B4GQ4Ad2RTZYOYLrUhnDHag0qxxB1/ZXy/K6xKY/bA=;
        h=From:To:Cc:Subject:Date:From;
        b=D+dp7dWvcKGcJaJPPIGbZDvinEx4GUaK4YzxFzHaAferL7MmhKCZcWs8R2ZuWeslQ
         Jc5QlXFiv2xR/0gKYjqJU54JdNWTMCw7rj+5DMvK2gB1o+EABLaeVAiPN3WZO9acdX
         1dvi9NdOASfUuJZDAU3sDXN/s38zb1uXMRkXZKcRjVUGV3vK+nUcajVEAPXK/K4aCg
         JxvVvA+YdVLw1pibjP/gwfMG8vO6latwCgil8I26X5D9Z3HS58ntlReOQi3B79RDH+
         gN5Y9B+Jon6UgcCNJCx2KBvrVYnEzmgYoPIy+EnzckiYh4caSMaOwQPaxHij9FZ5pH
         LDXG0DM0/2FSg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jijie Shao <shaojijie@huawei.com>,
        Hao Chen <chenhao418@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] net: hns3: reduce stack usage in hclge_dbg_dump_tm_pri()
Date:   Mon,  4 Dec 2023 09:57:21 +0100
Message-Id: <20231204085735.4112882-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function exceeds the stack frame warning limit:

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In function 'hclge_dbg_dump_tm_pri':
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1039:1: error: the frame size of 1408 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Use dynamic allocation for the largest stack object instead. It
would be nice to rewrite this file to completely avoid the extra
buffer and just use the one that was already allocated by debugfs,
but that is a much larger change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix error handling leak
---
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index ff3f8f424ad9..8f94e13c1edf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -981,7 +981,7 @@ static const struct hclge_dbg_item tm_pri_items[] = {
 
 static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 {
-	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
+	char *data_str;
 	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
 	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
 	char content[HCLGE_DBG_TM_INFO_LEN];
@@ -992,8 +992,13 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 	if (ret)
 		return ret;
 
+	data_str = kcalloc(ARRAY_SIZE(tm_pri_items), HCLGE_DBG_DATA_STR_LEN,
+			   GFP_KERNEL);
+	if (!data_str)
+		return -ENOMEM;
+
 	for (i = 0; i < ARRAY_SIZE(tm_pri_items); i++)
-		result[i] = &data_str[i][0];
+		result[i] = &data_str[i * HCLGE_DBG_DATA_STR_LEN];
 
 	hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
 			       NULL, ARRAY_SIZE(tm_pri_items));
@@ -1002,23 +1007,23 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 	for (i = 0; i < pri_num; i++) {
 		ret = hclge_tm_get_pri_sch_mode(hdev, i, &sch_mode);
 		if (ret)
-			return ret;
+			goto out;
 
 		ret = hclge_tm_get_pri_weight(hdev, i, &weight);
 		if (ret)
-			return ret;
+			goto out;
 
 		ret = hclge_tm_get_pri_shaper(hdev, i,
 					      HCLGE_OPC_TM_PRI_C_SHAPPING,
 					      &c_shaper_para);
 		if (ret)
-			return ret;
+			goto out;
 
 		ret = hclge_tm_get_pri_shaper(hdev, i,
 					      HCLGE_OPC_TM_PRI_P_SHAPPING,
 					      &p_shaper_para);
 		if (ret)
-			return ret;
+			goto out;
 
 		sch_mode_str = sch_mode & HCLGE_TM_TX_SCHD_DWRR_MSK ? "dwrr" :
 			       "sp";
@@ -1035,7 +1040,9 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 		pos += scnprintf(buf + pos, len - pos, "%s", content);
 	}
 
-	return 0;
+out:
+	kfree(data_str);
+	return ret;
 }
 
 static const struct hclge_dbg_item tm_qset_items[] = {
-- 
2.39.2

