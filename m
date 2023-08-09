Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3F775280
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHIGGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHIGGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:06:49 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E1A0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:06:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpNfuZA_1691561198;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VpNfuZA_1691561198)
          by smtp.aliyun-inc.com;
          Wed, 09 Aug 2023 14:06:43 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] erofs: refine warning messages for data I/Os
Date:   Wed,  9 Aug 2023 14:06:37 +0800
Message-Id: <20230809060637.21311-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Don't warn users since -EINTR is returned due to user interruption.
Also suppress warning messages of readmore.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/zdata.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index de4f12152b62..53820271e538 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1848,15 +1848,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
 		if (page) {
-			if (PageUptodate(page)) {
+			if (PageUptodate(page))
 				unlock_page(page);
-			} else {
-				err = z_erofs_do_read_page(f, page);
-				if (err)
-					erofs_err(inode->i_sb,
-						  "readmore error at page %lu @ nid %llu",
-						  index, EROFS_I(inode)->nid);
-			}
+			else
+				(void)z_erofs_do_read_page(f, page);
 			put_page(page);
 		}
 
@@ -1885,8 +1880,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	/* if some compressed cluster ready, need submit them anyway */
 	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
 
-	if (err)
-		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
+	if (err && err != -EINTR)
+		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
+			  err, folio->index, EROFS_I(inode)->nid);
 
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
@@ -1920,10 +1916,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		head = (void *)page_private(page);
 
 		err = z_erofs_do_read_page(&f, page);
-		if (err)
-			erofs_err(inode->i_sb,
-				  "readahead error at page %lu @ nid %llu",
-				  page->index, EROFS_I(inode)->nid);
+		if (err && err != -EINTR)
+			erofs_err(inode->i_sb, "readahead error %d @ %lu of nid %llu",
+				  err, page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
-- 
2.19.1.6.gb485710b

