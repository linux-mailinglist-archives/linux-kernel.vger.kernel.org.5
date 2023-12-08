Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33F38098FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572969AbjLHCEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:04:54 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD5121;
        Thu,  7 Dec 2023 18:04:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vy1IIqL_1702001090;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vy1IIqL_1702001090)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 10:04:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Liam.Howlett@oracle.com
Cc:     willy@infradead.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] maple_tree: Fix warning comparing pointer to 0
Date:   Fri,  8 Dec 2023 10:04:50 +0800
Message-Id: <20231208020450.7003-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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

Avoid pointer type value compared with 0 to make code clear.

./tools/testing/radix-tree/maple.c:34142:15-16: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7696
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/radix-tree/maple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 56ae47291ee0..687886cebd9d 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -34139,7 +34139,7 @@ STORE, 140501948112896, 140501948116991,
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
 	check_erase2_testset(mt, set27, ARRAY_SIZE(set27));
 	rcu_barrier();
-	MT_BUG_ON(mt, 0 != mtree_load(mt, 140415537422336));
+	MT_BUG_ON(mt, NULL != mtree_load(mt, 140415537422336));
 	mt_set_non_kernel(0);
 	mt_validate(mt);
 	mtree_destroy(mt);
@@ -34263,7 +34263,7 @@ STORE, 140501948112896, 140501948116991,
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
 	check_erase2_testset(mt, set37, ARRAY_SIZE(set37));
 	rcu_barrier();
-	MT_BUG_ON(mt, 0 != mtree_load(mt, 94637033459712));
+	MT_BUG_ON(mt, NULL != mtree_load(mt, 94637033459712));
 	mt_validate(mt);
 	mtree_destroy(mt);
 
@@ -34271,7 +34271,7 @@ STORE, 140501948112896, 140501948116991,
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
 	check_erase2_testset(mt, set38, ARRAY_SIZE(set38));
 	rcu_barrier();
-	MT_BUG_ON(mt, 0 != mtree_load(mt, 94637033459712));
+	MT_BUG_ON(mt, NULL != mtree_load(mt, 94637033459712));
 	mt_validate(mt);
 	mtree_destroy(mt);
 
-- 
2.20.1.7.g153144c

