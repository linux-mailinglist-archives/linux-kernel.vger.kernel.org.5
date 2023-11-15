Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D897EBB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjKODNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKODNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:13:48 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500FEA7;
        Tue, 14 Nov 2023 19:13:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VwRJmGm_1700018010;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VwRJmGm_1700018010)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 11:13:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] bcachefs: Remove the unused variable journal_flags
Date:   Wed, 15 Nov 2023 11:13:29 +0800
Message-Id: <20231115031329.31138-1-jiapeng.chong@linux.alibaba.com>
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

Variable journal_flags is not effectively used, so delete it.

fs/bcachefs/btree_update_interior.c:1057:11: warning: variable 'journal_flags' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7559
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/bcachefs/btree_update_interior.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index 9affcb22d9cb..18e5a75142e9 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -1054,7 +1054,6 @@ bch2_btree_update_start(struct btree_trans *trans, struct btree_path *path,
 	unsigned nr_nodes[2] = { 0, 0 };
 	unsigned update_level = level;
 	enum bch_watermark watermark = flags & BCH_WATERMARK_MASK;
-	unsigned journal_flags = 0;
 	int ret = 0;
 	u32 restart_count = trans->restart_count;
 
@@ -1068,10 +1067,6 @@ bch2_btree_update_start(struct btree_trans *trans, struct btree_path *path,
 	flags &= ~BCH_WATERMARK_MASK;
 	flags |= watermark;
 
-	if (flags & BCH_TRANS_COMMIT_journal_reclaim)
-		journal_flags |= JOURNAL_RES_GET_NONBLOCK;
-	journal_flags |= watermark;
-
 	while (1) {
 		nr_nodes[!!update_level] += 1 + split;
 		update_level++;
-- 
2.20.1.7.g153144c

