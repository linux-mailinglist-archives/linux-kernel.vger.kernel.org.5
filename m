Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD578039C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357161AbjHRCDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352400AbjHRCC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:02:56 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD961FE;
        Thu, 17 Aug 2023 19:02:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vq0RZwk_1692324171;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vq0RZwk_1692324171)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 10:02:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     djwong@kernel.org
Cc:     jefflexu@linux.alibaba.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH next] xfs: fix inconsistent indenting of xlog_verify_tail_lsn()
Date:   Fri, 18 Aug 2023 10:02:50 +0800
Message-Id: <20230818020250.35427-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

fs/xfs/xfs_log.c:3598 xlog_verify_tail_lsn() warn: inconsistent indenting

Also fix several style violations mentioned in [1].

[1] https://lore.kernel.org/linux-xfs/20210902233137.GB1826899@dread.disaster.area/
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/xfs/xfs_log.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 79004d193e54..d197534cd3b3 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -3593,23 +3593,23 @@ xlog_verify_tail_lsn(
 	struct xlog_in_core	*iclog)
 {
 	xfs_lsn_t	tail_lsn = be64_to_cpu(iclog->ic_header.h_tail_lsn);
-	int		blocks;
+	int		blocks, ic_blocks;
 
-    if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
-	blocks =
-	    log->l_logBBsize - (log->l_prev_block - BLOCK_LSN(tail_lsn));
-	if (blocks < BTOBB(iclog->ic_offset)+BTOBB(log->l_iclog_hsize))
-		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
-    } else {
-	ASSERT(CYCLE_LSN(tail_lsn)+1 == log->l_prev_cycle);
+	if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
+		blocks = log->l_logBBsize -
+			(log->l_prev_block - BLOCK_LSN(tail_lsn));
+		ic_blocks = BTOBB(iclog->ic_offset) + BTOBB(log->l_iclog_hsize);
+	} else {
+		ASSERT(CYCLE_LSN(tail_lsn) + 1 == log->l_prev_cycle);
 
-	if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
-		xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
+		if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
+			xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
 
-	blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;
-	if (blocks < BTOBB(iclog->ic_offset) + 1)
+		blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;
+		ic_blocks = BTOBB(iclog->ic_offset) + 1;
+	}
+	if (blocks < ic_blocks)
 		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
-    }
 }
 
 /*
-- 
2.20.1.7.g153144c

