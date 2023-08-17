Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9F77F21F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348907AbjHQI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348899AbjHQI2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:28:40 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4845A30D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:28:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9Qw2_1692260894;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9Qw2_1692260894)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:19 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/8] erofs: simplify z_erofs_read_fragment()
Date:   Thu, 17 Aug 2023 16:28:06 +0800
Message-Id: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

A trivial cleanup to make the fragment handling logic more clear.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 53820271e538..dc104add0a99 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -932,34 +932,27 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	return true;
 }
 
-static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
-				 struct page *page, unsigned int pageofs,
-				 unsigned int len)
+static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
+			unsigned int cur, unsigned int end, erofs_off_t pos)
 {
-	struct super_block *sb = inode->i_sb;
-	struct inode *packed_inode = EROFS_I_SB(inode)->packed_inode;
+	struct inode *packed_inode = EROFS_SB(sb)->packed_inode;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	u8 *src, *dst;
-	unsigned int i, cnt;
+	unsigned int cnt;
+	u8 *src;
 
 	if (!packed_inode)
 		return -EFSCORRUPTED;
 
 	buf.inode = packed_inode;
-	pos += EROFS_I(inode)->z_fragmentoff;
-	for (i = 0; i < len; i += cnt) {
-		cnt = min_t(unsigned int, len - i,
+	for (; cur < end; cur += cnt, pos += cnt) {
+		cnt = min_t(unsigned int, end - cur,
 			    sb->s_blocksize - erofs_blkoff(sb, pos));
 		src = erofs_bread(&buf, erofs_blknr(sb, pos), EROFS_KMAP);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
 		}
-
-		dst = kmap_local_page(page);
-		memcpy(dst + pageofs + i, src + erofs_blkoff(sb, pos), cnt);
-		kunmap_local(dst);
-		pos += cnt;
+		memcpy_to_page(page, cur, src + erofs_blkoff(sb, pos), cnt);
 	}
 	erofs_put_metabuf(&buf);
 	return 0;
@@ -972,7 +965,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-	unsigned int cur, end, spiltted;
+	unsigned int cur, end, len, spiltted;
 	int err = 0;
 
 	/* register locked file pages as online pages in pack */
@@ -1041,17 +1034,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto next_part;
 	}
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
-		unsigned int pageofs, skip, len;
+		erofs_off_t fpos = offset + cur - map->m_la;
 
-		if (offset > map->m_la) {
-			pageofs = 0;
-			skip = offset - map->m_la;
-		} else {
-			pageofs = map->m_la & ~PAGE_MASK;
-			skip = 0;
-		}
-		len = min_t(unsigned int, map->m_llen - skip, end - cur);
-		err = z_erofs_read_fragment(inode, skip, page, pageofs, len);
+		len = min_t(unsigned int, map->m_llen - fpos, end - cur);
+		err = z_erofs_read_fragment(inode->i_sb, page, cur, cur + len,
+				EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
 		++spiltted;
-- 
2.24.4

