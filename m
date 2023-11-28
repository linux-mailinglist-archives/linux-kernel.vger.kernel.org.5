Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BB7FB59F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjK1JZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjK1JZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:25:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFDDA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:25:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDD1C433C8;
        Tue, 28 Nov 2023 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701163522;
        bh=8ei0w6/cvwAZe9ao3KX6VzPIdkZ0HCfTd2duIQACX5w=;
        h=From:To:Cc:Subject:Date:From;
        b=sb2iDi1mjSU6gmZk7txGqQ+SV1xHCgEarAPTn+dDy1TfVwI4JiQMRxQlq0xfKt2Qm
         hzvXi78/1gl35t6SD+gnDpON8kZNOjBVlk3Up6l0sV9BkJkfz4gID+1b5gzC1iYW9I
         A+LNnS5Hy/odSsknkICdXFOKY2hZTmzaK8cclhwJc8G/rODKiBARZWmXela8febKiF
         uQ+p63GW0wyAAfR3DQVicv6HqR6Zoeiu6JhlM+6xpv7J6z15NO5VIEeE/ep/Esta3x
         UGIbGohjtWQi+dtfHUBM0gylYaTIIMgYWJwjdLernpAaBLLHEHQjhX2gYEPbBkJ5+G
         gsCXcVWledjDQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] f2fs: fix to avoid dirent corruption
Date:   Tue, 28 Nov 2023 17:25:16 +0800
Message-Id: <20231128092516.2882629-1-chao@kernel.org>
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

As Al reported in link[1]:

f2fs_rename()
...
	if (old_dir != new_dir && !whiteout)
		f2fs_set_link(old_inode, old_dir_entry,
					old_dir_page, new_dir);
	else
		f2fs_put_page(old_dir_page, 0);

You want correct inumber in the ".." link.  And cross-directory
rename does move the source to new parent, even if you'd been asked
to leave a whiteout in the old place.

[1] https://lore.kernel.org/all/20231017055040.GN800259@ZenIV/

With below testcase, it may cause dirent corruption, due to it missed
to call f2fs_set_link() to update ".." link to new directory.
- mkdir -p dir/foo
- renameat2 -w dir/foo bar

[ASSERT] (__chk_dots_dentries:1421)  --> Bad inode number[0x4] for '..', parent parent ino is [0x3]
[FSCK] other corrupted bugs                           [Fail]

Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
Cc: Jan Kara <jack@suse.cz>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3b1793cfb002..ede6afb81762 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1105,7 +1105,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (old_dir_entry) {
-		if (old_dir != new_dir && !whiteout)
+		if (old_dir != new_dir)
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
 		else
-- 
2.40.1

