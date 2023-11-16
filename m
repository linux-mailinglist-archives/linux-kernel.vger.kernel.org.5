Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6086E7EDB86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjKPG0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:26:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8499127
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:26:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B6C433C9;
        Thu, 16 Nov 2023 06:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700115964;
        bh=6rwiQ68wHhdsE6vY/Y31nFsyaYQ2rLgqDwN+2WxChEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIuPwVvk8OAAiglh4l+yrHMbH+U1E4tlFGpj6dqWYdv6FlT3GEmLUnBx6u5qaJL8e
         8iiU1S03QdgwgH67BEn0CunhA2O/7XGyO+TJLDVXrS0Ql3NY3m1Cof+SADxmK+nv5d
         emPwLN/XIwrNwUkAvFbD9iuFt+Ki6Ba2hjNFIZ9cHqYYj/NKt1EafCbhU1bK5soqrD
         Ea2mNSi+m8H8h4HhaA7ikBwdDtfafQXtAvValMHkzvU3shabOifFaNoJHC+9wZ/0HY
         be8J/dOOZP8Db6Y33jBnwR5mM/h0WUtCm6gc5qZaHorKuzRJrCbxpj4bW6Z7b7T7G/
         Gc2skX6crDrYQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: use shared inode lock during f2fs_fiemap()
Date:   Thu, 16 Nov 2023 14:25:55 +0800
Message-Id: <20231116062556.2451839-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116062556.2451839-1-chao@kernel.org>
References: <20231116062556.2451839-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_fiemap() will only traverse metadata of inode, let's use shared
inode lock for it to avoid unnecessary race on inode lock.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e42b5f24deb..42f0f6184f73 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1992,7 +1992,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret)
 		return ret;
 
-	inode_lock(inode);
+	inode_lock_shared(inode);
 
 	maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
 	if (start > maxbytes) {
@@ -2112,7 +2112,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret == 1)
 		ret = 0;
 
-	inode_unlock(inode);
+	inode_unlock_shared(inode);
 	return ret;
 }
 
-- 
2.40.1

