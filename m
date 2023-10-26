Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C977D7AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjJZCQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjJZCQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:16:39 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4C712F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:16:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VuvzTZ6_1698286588;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VuvzTZ6_1698286588)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 10:16:33 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: get rid of ROOT_NID()
Date:   Thu, 26 Oct 2023 10:16:26 +0800
Message-Id: <20231026021627.23284-1-mengferry@linux.alibaba.com>
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

Let's open code this helper for simplicity.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 --
 fs/erofs/super.c    | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ff88d0dd980..ca7d85958450 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -228,8 +228,6 @@ struct erofs_buf {
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-#define ROOT_NID(sb)		((sb)->root_nid)
-
 #define erofs_blknr(sb, addr)	((addr) >> (sb)->s_blocksize_bits)
 #define erofs_blkoff(sb, addr)	((addr) & ((sb)->s_blocksize - 1))
 #define erofs_pos(sb, blk)	((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3700af9ee173..019229eb2ef6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -724,13 +724,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	xa_init(&sbi->managed_pslots);
 #endif
 
-	inode = erofs_iget(sb, ROOT_NID(sbi));
+	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
 	if (!S_ISDIR(inode->i_mode)) {
 		erofs_err(sb, "rootino(nid %llu) is not a directory(i_mode %o)",
-			  ROOT_NID(sbi), inode->i_mode);
+			  sbi->root_nid, inode->i_mode);
 		iput(inode);
 		return -EINVAL;
 	}
@@ -760,7 +760,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	erofs_info(sb, "mounted with root inode @ nid %llu.", ROOT_NID(sbi));
+	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
 
-- 
2.19.1.6.gb485710b

