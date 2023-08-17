Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8561B77F225
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349013AbjHQI3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348926AbjHQI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:28:45 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B130C3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:28:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R3t_1692260909;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R3t_1692260909)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:30 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 8/8] erofs: adapt folios for z_erofs_read_folio()
Date:   Thu, 17 Aug 2023 16:28:13 +0800
Message-Id: <20230817082813.81180-8-hsiangkao@linux.alibaba.com>
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

It's a straight-forward conversion and no logic changes (except that
it renames the corresponding tracepoint.)

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
erofs stress test passes.

 fs/erofs/zdata.c             |  9 ++++-----
 include/trace/events/erofs.h | 16 ++++++++--------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 79cadb88e8bf..ace727bfe5b2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1821,17 +1821,16 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *const inode = page->mapping->host;
+	struct inode *const inode = folio->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	int err;
 
-	trace_erofs_readpage(page, false);
-	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
+	trace_erofs_read_folio(folio, false);
+	f.headoffset = (erofs_off_t)folio->index << folio_shift(folio);
 
 	z_erofs_pcluster_readmore(&f, NULL, true);
-	err = z_erofs_do_read_page(&f, page);
+	err = z_erofs_do_read_page(&f, &folio->page);
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 71dbe8bfa7db..e18684b02c3d 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -80,11 +80,11 @@ TRACE_EVENT(erofs_fill_inode,
 		  __entry->blkaddr, __entry->ofs)
 );
 
-TRACE_EVENT(erofs_readpage,
+TRACE_EVENT(erofs_read_folio,
 
-	TP_PROTO(struct page *page, bool raw),
+	TP_PROTO(struct folio *folio, bool raw),
 
-	TP_ARGS(page, raw),
+	TP_ARGS(folio, raw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
@@ -96,11 +96,11 @@ TRACE_EVENT(erofs_readpage,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
-		__entry->nid	= EROFS_I(page->mapping->host)->nid;
-		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
-		__entry->index	= page->index;
-		__entry->uptodate = PageUptodate(page);
+		__entry->dev	= folio->mapping->host->i_sb->s_dev;
+		__entry->nid	= EROFS_I(folio->mapping->host)->nid;
+		__entry->dir	= S_ISDIR(folio->mapping->host->i_mode);
+		__entry->index	= folio->index;
+		__entry->uptodate = folio_test_uptodate(folio);
 		__entry->raw = raw;
 	),
 
-- 
2.24.4

