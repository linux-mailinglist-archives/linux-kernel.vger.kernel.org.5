Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6192B7D929D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbjJ0IuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0IuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:50:04 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B05BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:50:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vv-KCG0_1698396586;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vv-KCG0_1698396586)
          by smtp.aliyun-inc.com;
          Fri, 27 Oct 2023 16:49:55 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Liam.Howlett@oracle.com
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] maple_tree: Remove unused function
Date:   Fri, 27 Oct 2023 16:49:44 +0800
Message-Id: <20231027084944.24888-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function are defined in the maple_tree.c file, but not called
elsewhere, so delete the unused function.

lib/maple_tree.c:689:29: warning: unused function 'mas_pivot'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7064
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/maple_tree.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922..cf889aaa0011 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -679,35 +679,6 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
 	return NULL;
 }
 
-/*
- * mas_pivot() - Get the pivot at @piv of the maple encoded node.
- * @mas: The maple state.
- * @piv: The pivot.
- *
- * Return: the pivot at @piv of @mn.
- */
-static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
-{
-	struct maple_node *node = mas_mn(mas);
-	enum maple_type type = mte_node_type(mas->node);
-
-	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
-		mas_set_err(mas, -EIO);
-		return 0;
-	}
-
-	switch (type) {
-	case maple_arange_64:
-		return node->ma64.pivot[piv];
-	case maple_range_64:
-	case maple_leaf_64:
-		return node->mr64.pivot[piv];
-	case maple_dense:
-		return 0;
-	}
-	return 0;
-}
-
 /*
  * mas_safe_pivot() - get the pivot at @piv or mas->max.
  * @mas: The maple state
-- 
2.20.1.7.g153144c

