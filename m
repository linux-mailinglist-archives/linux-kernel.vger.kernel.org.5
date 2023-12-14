Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2248135E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjLNQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjLNQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:13:40 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537AD10E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:13:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyUqVoN_1702570418;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VyUqVoN_1702570418)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 00:13:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix ztailpacking for subpage compressed blocks
Date:   Fri, 15 Dec 2023 00:13:37 +0800
Message-Id: <20231214161337.753049-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`pageofs_in` should be the compressed data offset of the page rather
than of the block.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a2c3e87d2f81..8264936b8612 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -812,7 +812,6 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 
 	if (ztailpacking) {
 		pcl->obj.index = 0;	/* which indicates ztailpacking */
-		pcl->pageofs_in = erofs_blkoff(fe->inode->i_sb, map->m_pa);
 	} else {
 		pcl->obj.index = erofs_blknr(sb, map->m_pa);
 
@@ -889,6 +888,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 		}
 		get_page(map->buf.page);
 		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}
 	/* file-backed inplace I/O pages are traversed in reverse order */
-- 
2.39.3

