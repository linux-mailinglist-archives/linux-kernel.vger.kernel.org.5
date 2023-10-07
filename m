Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCA7BC5B9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbjJGHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343713AbjJGHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:46:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328ECA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:46:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ABCC433C8;
        Sat,  7 Oct 2023 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696664782;
        bh=7rTaaOwJ2XLjmWgatV7u/BoCzFYYD2I7Tous8LEzDnw=;
        h=From:To:Cc:Subject:Date:From;
        b=jBA2dmFZkbBvFOg+3XCyntOekKurJ/TwSib6bXG5qcMhfJfFQ/Cn6w+piTYwnUxzd
         FaDfts0ZBNFSl2LqCRKAYIXB2CeR80MhrYThSsysifOnpn/zJEoBIuo0hqL/w/GAVM
         rbyxQIFDsXWq5LpC9XSWWCyPXR2sNN4uiTRIlK8kmdLttHUyZSwvkXlxifTvElyElR
         XA56wfJyxPbBbm4GZTwhLpef1irgERmSRZTWx3YNt8jP2byRFz7NAnchRTx9PveyiD
         0xkL/5GvH/tRBM3IMRzpQicllWWe/lrNw42G8QqVXq/BQzCcrfhz7LkeQaNFguUOV+
         k6ASXtzDyE/Cw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()
Date:   Sat,  7 Oct 2023 15:45:52 +0800
Message-Id: <20231007074552.3170496-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, it may print random physical block address in tracepoint
of f2fs_map_blocks() as below:

f2fs_map_blocks: dev = (253,16), ino = 2297, file offset = 0, start blkaddr = 0xa356c421, len = 0x0, flags = 0

Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5d726cbc4f0b..cfb199f9af0d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3261,6 +3261,7 @@ int f2fs_precache_extents(struct inode *inode)
 		return -EOPNOTSUPP;
 
 	map.m_lblk = 0;
+	map.m_pblk = 0;
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
-- 
2.40.1

