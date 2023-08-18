Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB878082D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359033AbjHRJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359080AbjHRJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:20:37 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C23AA6;
        Fri, 18 Aug 2023 02:20:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vq26Rhg_1692350423;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0Vq26Rhg_1692350423)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 17:20:30 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] nilfs2: fix dereferencing freed memory
Date:   Fri, 18 Aug 2023 17:20:22 +0800
Message-Id: <20230818092022.111054-1-mengferry@linux.alibaba.com>
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

Fix smatch warning:

fs/nilfs2/gcinode.c:103 nilfs_gccache_submit_read_data() error:
dereferencing freed memory 'bh'

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 48fe71d309cb..6319e825f317 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (err)
+		brelse(bh);
 	return err;
 }
 
-- 
2.19.1.6.gb485710b

