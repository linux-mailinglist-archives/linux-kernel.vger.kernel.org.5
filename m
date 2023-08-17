Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE15577F220
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbjHQI3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348925AbjHQI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:28:45 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D32D71
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:28:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R2H_1692260907;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R2H_1692260907)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:28 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6/8] erofs: get rid of fe->backmost for cache decompression
Date:   Thu, 17 Aug 2023 16:28:11 +0800
Message-Id: <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
incomplete pcluster for later read or not.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4009283944ca..c28945532a02 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
 	z_erofs_next_pcluster_t owned_head;
 	enum z_erofs_pclustermode mode;
 
-	/* used for applying cache strategy on the fly */
-	bool backmost;
 	erofs_off_t headoffset;
 
 	/* a pointer used to pick up inplace I/O pages */
@@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
+	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
 
 static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 {
@@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
 	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
 		return false;
 
-	if (fe->backmost)
+	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))
 		return true;
 
 	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
@@ -939,7 +937,6 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 		erofs_workgroup_put(&pcl->obj);
 
 	fe->pcl = NULL;
-	fe->backmost = false;
 }
 
 static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
-- 
2.24.4

