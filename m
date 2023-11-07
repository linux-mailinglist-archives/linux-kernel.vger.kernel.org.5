Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1F7E445E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjKGPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343610AbjKGPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:51:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CCA2686;
        Tue,  7 Nov 2023 07:49:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D726C433C8;
        Tue,  7 Nov 2023 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372161;
        bh=D2kkIFfA4DjPa//ZZNeA9gZspirc1drzb3plC4xg7sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hj0xPvGJUY+BQbQN1MGIhcsaYf3vsjQxvkRNrcvzL2Zps8sRDZnF7JUBfIgLeNSd6
         xoZDT3Z79GxqreerB1eisw+MkUb6dwqbQD5EY1wt+jSidSwlUKCJg9w9ZLThco+kXV
         7RP1XPVfo0EZ8V/CzWqFRPOgK3MGinPOa76PcWdu3OQo5Mx+6ncz0hHDkgYf5XqzBS
         z64D853KAvjiDpQtTdAh0zNoF58uo8ysWzo5E+IYKNki3O/bxbQUuAcrUmsuKSCueU
         P6VBlfLCcD2m6PGUhVk1JHA+fXvckuGhx17kxI9ahcZTtgM12WVQj+tyx+cromgXhX
         UMoLy6qRb3XOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        brauner@kernel.org, jlayton@kernel.org, okanatov@gmail.com,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.5 13/34] jfs: fix array-index-out-of-bounds in diAlloc
Date:   Tue,  7 Nov 2023 10:47:53 -0500
Message-ID: <20231107154846.3766119-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154846.3766119-1-sashal@kernel.org>
References: <20231107154846.3766119-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
index 6fb28572cb2c6..34f1358264e23 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1320,7 +1320,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
-	int nwords, rem, i, agno;
+	int nwords, rem, i, agno, dn_numag;
 	u32 mask, inosmap, extsmap;
 	struct inode *ipimap;
 	struct metapage *mp;
@@ -1356,6 +1356,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
+	if (agno < 0 || agno > dn_numag)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
-- 
2.42.0

