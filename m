Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED37E4557
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343736AbjKGQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344593AbjKGQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:04:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8FD44AF;
        Tue,  7 Nov 2023 07:55:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED16BC433C7;
        Tue,  7 Nov 2023 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372528;
        bh=NvSYteGg18nVtXwTrTcHoeFzXQQi5ykd/JFzZYK87ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaIzY3szUjXGuYnCRg1oSuYk2/rr83F0hu0Q/0yKDTtAg8p3Mw0r9sz4kqlfdZrdz
         rgPePFSEBlc0oAivrigc6STrpxZI+IYwns6kMEwfVs9OldgGO0och+NPAFVYrn3dDy
         ciAQ0ZFfdgwPKYQjlN500RjTk/rnbzTaj0YCqKAxmvf/h8O3hBlTETCw8TKhKOcQI4
         Te9T+1rRTFC5157WbMIROFY0ziyyb4D6L86M+okvb+47b/dQiqwHz0hD/g/xr+wMlu
         I8mUNzII8jdzOVlIiw/IlVPd1EP3rrEz7q7jwxownmk5egcHt5wZbE0AUEff5TEyfC
         4bAKddWaZaElA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        jlayton@kernel.org, brauner@kernel.org, jack@suse.cz,
        jfs-discussion@lists.sourceforge.net, okanatov@gmail.com
Subject: [PATCH AUTOSEL 4.14 6/9] jfs: fix array-index-out-of-bounds in diAlloc
Date:   Tue,  7 Nov 2023 10:54:56 -0500
Message-ID: <20231107155509.3769038-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155509.3769038-1-sashal@kernel.org>
References: <20231107155509.3769038-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
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
index 12fc016244581..131dce5316ac9 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1341,7 +1341,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
-	int nwords, rem, i, agno;
+	int nwords, rem, i, agno, dn_numag;
 	u32 mask, inosmap, extsmap;
 	struct inode *ipimap;
 	struct metapage *mp;
@@ -1377,6 +1377,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
+	if (agno < 0 || agno > dn_numag)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
-- 
2.42.0

