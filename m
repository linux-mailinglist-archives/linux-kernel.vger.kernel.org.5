Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30DB7E45D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbjKGQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjKGQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:20:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6963C16;
        Tue,  7 Nov 2023 07:54:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80693C433C7;
        Tue,  7 Nov 2023 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372488;
        bh=zVVQ7dCLljkfi4J6UkS4uhE2JVt1KshtZvGFvUu5Pns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOoQhX13GPR4/SGAYtAw0kUsa1QV/Krhh7yiBIdtSBh3vWbEbG9cXxsISe+nuoyGs
         JJoAjkxQehszw4BNoMQq90GD/r8R+rueFL779p/brDyiO53BlHMrGuG+ZjcCqtthd/
         7iFfhZcQ+pfNEHtm9ONMHPzpfheZp7JSj/Ezbsfbp88XeVx9MmoIoQPuZ0wAvpg+ot
         rN2VkwzPvjGSfR9KYyDLIr3kTiadW+lPhlub1UxjDLxwx6voWa731KFgFDKF/p5ZHT
         R6CmTZrRZUk6dLCLGOi2YyBnPu0reoP9mdBE7/7TUWbwMShqlputc+xcjKjkF+EuFx
         XjLeqnRD7DTpw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        jlayton@kernel.org, brauner@kernel.org, jack@suse.cz,
        liushixin2@huawei.com, okanatov@gmail.com,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 06/11] jfs: fix array-index-out-of-bounds in diAlloc
Date:   Tue,  7 Nov 2023 10:54:14 -0500
Message-ID: <20231107155430.3768779-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155430.3768779-1-sashal@kernel.org>
References: <20231107155430.3768779-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manas Ghandat <ghandatmanas@gmail.com>

[ Upstream commit 05d9ea1ceb62a55af6727a69269a4fd310edf483 ]

Currently there is not check against the agno of the iag while
allocating new inodes to avoid fragmentation problem. Added the check
which is required.

Reported-by: syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=79d792676d8ac050949f
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_imap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 7565e00e88182..b45cc109e5063 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1335,7 +1335,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
-	int nwords, rem, i, agno;
+	int nwords, rem, i, agno, dn_numag;
 	u32 mask, inosmap, extsmap;
 	struct inode *ipimap;
 	struct metapage *mp;
@@ -1371,6 +1371,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
+	if (agno < 0 || agno > dn_numag)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
-- 
2.42.0

