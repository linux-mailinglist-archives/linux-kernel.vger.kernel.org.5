Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D8806A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346880AbjLFJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346777AbjLFJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:11:13 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D194F10C0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:11:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxxSRQh_1701853876;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxxSRQh_1701853876)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:11:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, dhavale@google.com,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/5] erofs: enable sub-page compressed block support
Date:   Wed,  6 Dec 2023 17:10:57 +0800
Message-Id: <20231206091057.87027-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
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

Let's just disable cached decompression and inplace I/Os for partial
pages as a first step in order to enable sub-page block initial
support.  In other words, currently it works primarily based on
temporary short-lived pages.  Don't expect too much in terms of
performance.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 6 ++++--
 fs/erofs/zdata.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 14a79d3226ab..3d616dea55dc 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -259,8 +259,10 @@ static int erofs_fill_inode(struct inode *inode)
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-		if (!erofs_is_fscache_mode(inode->i_sb) &&
-		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT) {
+		if (!erofs_is_fscache_mode(inode->i_sb)) {
+			DO_ONCE_LITE_IF(inode->i_sb->s_blocksize != PAGE_SIZE,
+				  erofs_info, inode->i_sb,
+				  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
 			inode->i_mapping->a_ops = &z_erofs_aops;
 			err = 0;
 			goto out_unlock;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d02989466711..a2c3e87d2f81 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -563,6 +563,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 	unsigned int i;
 
+	if (i_blocksize(fe->inode) != PAGE_SIZE)
+		return;
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
 		return;
 
@@ -967,12 +969,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct inode *const inode = fe->inode;
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
+	const unsigned int bs = i_blocksize(inode);
 	bool tight = true, exclusive;
 	unsigned int cur, end, len, split;
 	int err = 0;
 
 	z_erofs_onlinepage_init(page);
-
 	split = 0;
 	end = PAGE_SIZE;
 repeat:
@@ -1021,7 +1023,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	 * for inplace I/O or bvpage (should be processed in a strict order.)
 	 */
 	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
-	exclusive = (!cur && ((split <= 1) || tight));
+	exclusive = (!cur && ((split <= 1) || (tight && bs == PAGE_SIZE)));
 	if (cur)
 		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
-- 
2.39.3

