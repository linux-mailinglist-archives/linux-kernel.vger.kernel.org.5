Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4E7DC641
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjJaGFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJaGFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:05:45 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972E8F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:05:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VvGHDFU_1698732325;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvGHDFU_1698732325)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 14:05:30 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
Date:   Tue, 31 Oct 2023 14:05:24 +0800
Message-Id: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Linus pointed out [1], lockref_put_return() is fundamentally
designed to be something that can fail.  It behaves as a fastpath-only
thing, and the failure case needs to be handled anyway.

Actually, since the new pcluster was just allocated without being
populated, it won't be accessed by others until it is inserted into
XArray, so lockref helpers are actually unneeded here.

Let's just set the proper reference count on initializing.

[1] https://lore.kernel.org/r/CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com
Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/utils.c | 8 +-------
 fs/erofs/zdata.c | 1 +
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..4256a85719a1 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -77,12 +77,7 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	struct erofs_workgroup *pre;
 
-	/*
-	 * Bump up before making this visible to others for the XArray in order
-	 * to avoid potential UAF without serialized by xa_lock.
-	 */
-	lockref_get(&grp->lockref);
-
+	DBG_BUGON(grp->lockref.count < 1);
 repeat:
 	xa_lock(&sbi->managed_pslots);
 	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
@@ -96,7 +91,6 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 			cond_resched();
 			goto repeat;
 		}
-		lockref_put_return(&grp->lockref);
 		grp = pre;
 	}
 	xa_unlock(&sbi->managed_pslots);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 036f610e044b..a7e6847f6f8f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -796,6 +796,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 		return PTR_ERR(pcl);
 
 	spin_lock_init(&pcl->obj.lockref.lock);
+	pcl->obj.lockref.count = 1;	/* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.39.3

