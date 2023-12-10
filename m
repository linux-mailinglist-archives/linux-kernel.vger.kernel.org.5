Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705B780BA63
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjLJLfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:35:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9430FA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:35:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C3AC433C7;
        Sun, 10 Dec 2023 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702208159;
        bh=rLcyF1ZrszFFVhog4TqrXAnFuqCYoRmQyE22OkV/4iY=;
        h=From:To:Cc:Subject:Date:From;
        b=enRuddIEf8bqGYbgra4E2dbFPYn2xIF/4SgpYcYlljGw7xqldMI0SUQIgjvBO2nuA
         BKwyGFp0hMoAm4BiD+wo9ZE9GHHSXHVSNQUP92fw3zQjDW9b2/Hp5z/L5tv3KJbqby
         8SaZ056f/hCouqDOEXQglytYMp4RBzHAtfgz2DQA2TY3uBHmNpNbmAfzMtQPmPosCN
         CnGBtmVKkIslvgul/9tI9fhJkuHrBXbszL6W0YqMp29yvWLNS4Oz4QmCVrDKzrEB+M
         41GlkTNJN4EkLSvW8GBmhHLNHAfIMG9+ohCQQjFvmms8VWHqdsuiZ728EhdNnDLkvi
         0d/fCyzrGQPLQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/6] f2fs: fix to tag gcing flag on page during block migration
Date:   Sun, 10 Dec 2023 19:35:42 +0800
Message-Id: <20231210113547.3412782-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to add missing gcing flag on page during block migration,
in order to garantee migrated data be persisted during checkpoint,
otherwise out-of-order persistency between data and node may cause
data corruption after SPOR.

Similar issue was fixed by commit 2d1fe8a86bf5 ("f2fs: fix to tag
gcing flag on page during file defragment").

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 4 +++-
 fs/f2fs/file.c     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b35be5799726..c5a4364c4482 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1036,8 +1036,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < cc->cluster_size; i++)
-		if (cc->rpages[i])
+		if (cc->rpages[i]) {
 			set_page_dirty(cc->rpages[i]);
+			set_page_private_gcing(cc->rpages[i]);
+		}
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 60290940018d..156b0ff05a3b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1312,6 +1312,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
+			set_page_private_gcing(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
 
@@ -4046,6 +4047,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		f2fs_bug_on(F2FS_I_SB(inode), !page);
 
 		set_page_dirty(page);
+		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
 	}
-- 
2.40.1

