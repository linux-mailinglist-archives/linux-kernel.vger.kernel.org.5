Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC50E7B744A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjJCWwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJCWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:52:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA09E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:52:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A47C433C7;
        Tue,  3 Oct 2023 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696373538;
        bh=DAv2AfX6INF2/9pEZJP+mKh8rXKAu51RSvWoW5djUnA=;
        h=From:To:Cc:Subject:Date:From;
        b=HF6nIf/t1kA+ZxoD3boKZynlbN/56xiURDRVeBwjZ9dyZGcm1B9CC0JAGfJiMZgc0
         8IPSPTEjMiSyXBHMkxRgkl2OEUlGrBfPJlHmxsDsODzuY5hF8A4E0C2z9Jeg8Aes4n
         DoGuxmHQPMvTDDdQroZu8T6cjxZCb6V29OvDZX5WG9hwikidufm62yGJJqGWqMt0hA
         rys+7LO8OG4/pmXsgwrS8C2ZzT1+zUkjz/f+m17zxQk86+3I8slTWIhrES9yR+TceW
         dJgwPjTPMkJ+Z7u4CKVvHHCX5WM5sbIscSmsiTUHJTFxlclvxjLpVibOWO3WXtFXrt
         XXk/0v+avs9XQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: stop iterating f2fs_map_block if hole exists
Date:   Tue,  3 Oct 2023 15:52:08 -0700
Message-ID: <20231003225208.1936359-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's avoid unnecessary f2fs_map_block calls to load extents.

 # f2fs_io fadvise willneed 0 4096 /data/local/tmp/test

  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 386, start blkaddr = 0x34ac00, len = 0x1400, flags = 2,
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 5506, start blkaddr = 0x34c200, len = 0x1000, flags = 2,
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 9602, start blkaddr = 0x34d600, len = 0x1200, flags = 2,
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 14210, start blkaddr = 0x34ec00, len = 0x400, flags = 2,
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 15235, start blkaddr = 0x34f401, len = 0xbff, flags = 2,
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 18306, start blkaddr = 0x350200, len = 0x1200, flags = 2
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 22915, start blkaddr = 0x351601, len = 0xa7d, flags = 2
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25600, start blkaddr = 0x351601, len = 0x0, flags = 0
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25601, start blkaddr = 0x351601, len = 0x0, flags = 0
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25602, start blkaddr = 0x351601, len = 0x0, flags = 0
  ...
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1037188, start blkaddr = 0x351601, len = 0x0, flags = 0
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1038206, start blkaddr = 0x351601, len = 0x0, flags = 0
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1039224, start blkaddr = 0x351601, len = 0x0, flags = 0
  f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 2075548, start blkaddr = 0x351601, len = 0x0, flags = 0

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 161826c6e200..2403fd1de5a0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3270,7 +3270,7 @@ int f2fs_precache_extents(struct inode *inode)
 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-		if (err)
+		if (err || !map.m_len)
 			return err;
 
 		map.m_lblk = m_next_extent;
-- 
2.42.0.582.g8ccd20d70d-goog

