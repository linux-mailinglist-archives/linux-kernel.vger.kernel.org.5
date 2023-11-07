Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE807E450C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbjKGQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344581AbjKGP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98076B2;
        Tue,  7 Nov 2023 07:52:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95FDC433CA;
        Tue,  7 Nov 2023 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372330;
        bh=mAty3pRnzCwbGu5KLNo5Qcc7sRqrtUDeeQFjDnBcDhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T22/sQ3GZE1bUJeVaAzPoiBHArr0KGfXSgRJl23Qyv6zDCKj5l0jkTfWhF1SmY4Rt
         yjPLqQyU5mUh4CjeSKap1FLAkMjDLqJMQ15o26E7tJQflq0CJ3kyjqdqu70JSZY0+V
         8KvV+FZ1DNltoK0bWAnrBG4dooL/aTS+RNjZMbk814wOajGPoczg1jzyL0CoXW9rCi
         Lfz2gGseAI3w4xTNTIPugdN6Svp0XBuypMHJUZFKJqP3I22dtiDkyNmX0pX/QvItTT
         5Y9DGRDjT1X24U2O4Tsv2VzhZiCTxvRyT038yhZsD7RWYXj818nhO779q8kffYDUyv
         hWVH6rjbSZw6Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        jlayton@kernel.org, brauner@kernel.org, liushixin2@huawei.com,
        jfs-discussion@lists.sourceforge.net, okanatov@gmail.com
Subject: [PATCH AUTOSEL 5.15 09/22] jfs: fix array-index-out-of-bounds in diAlloc
Date:   Tue,  7 Nov 2023 10:51:18 -0500
Message-ID: <20231107155146.3767610-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index 4899663996d81..6ed2e1d4c894f 100644
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

