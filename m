Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E47DB129
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjJ2XbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjJ2Xav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:30:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67F59C0;
        Sun, 29 Oct 2023 16:00:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADA7C43391;
        Sun, 29 Oct 2023 22:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620362;
        bh=iHIi9yANOPOdDTkCE9logiPI8h4/g9n7zlZm00+kVvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmICwIJWAlFO7moIfvniSxuaFt5XgkjFx+kpYwXjQmlP6RC5dpcoiS7Eaj09aMBUV
         qOaE/lMIfUYM8NSeZtm56LQZIgxd7cue1cHNSS0i3eroD09zNMIA/WS/so5jsCXUUQ
         5i/wc/v6xeKVfPVzqW+6lgmllbgR4aTwm897W38NO0tkTKXua+tQeQwRDWwkUGJTlA
         VTF3SZit5ZJAAZQRUmmx72UkHt0BFOJGqsCmk9+23UvbRIbytlt1AkPv/7JTU60K99
         2g2+6Msf0kkZh2uCfOBi8RydpV7kYZMzM/7lIDtO9nT00Xv/q/s/1ZjX2xCWjd3bOh
         p7F3Iz51r75tA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 03/28] fs/ntfs3: Write immediately updated ntfs state
Date:   Sun, 29 Oct 2023 18:58:38 -0400
Message-ID: <20231029225916.791798-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 06ccfb00645990a9fcc14249e6d1c25921ecb836 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0ae70010b01d3..e32a678861ffe 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -958,18 +958,11 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 	if (err)
 		return err;
 
-	mark_inode_dirty(&ni->vfs_inode);
+	mark_inode_dirty_sync(&ni->vfs_inode);
 	/* verify(!ntfs_update_mftmirr()); */
 
-	/*
-	 * If we used wait=1, sync_inode_metadata waits for the io for the
-	 * inode to finish. It hangs when media is removed.
-	 * So wait=0 is sent down to sync_inode_metadata
-	 * and filemap_fdatawrite is used for the data blocks.
-	 */
-	err = sync_inode_metadata(&ni->vfs_inode, 0);
-	if (!err)
-		err = filemap_fdatawrite(ni->vfs_inode.i_mapping);
+	/* write mft record on disk. */
+	err = _ni_write_inode(&ni->vfs_inode, 1);
 
 	return err;
 }
-- 
2.42.0

