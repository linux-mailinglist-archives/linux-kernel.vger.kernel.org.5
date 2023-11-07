Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23827E43D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjKGPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjKGPrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:47:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD421985;
        Tue,  7 Nov 2023 07:47:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA17FC433C8;
        Tue,  7 Nov 2023 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372050;
        bh=mRHkPuHvsJWkWHgdH7J0WK0slPz46XQvhiwyePTgxyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzchYNKTjuZ9mddnTY/t/+Ak3/4N+pCfq3GQ/W7jgN0miXrDQTT3L8FtCc9CQqy9v
         UP+lSvIuzBHxnuN/Kw4iKZIDScQPK/JD2bIlg6Kall2j48u5wwrjYefx/L/bWFOdL0
         vXA8gH9EPAR6FLBSVeJHZ3vrvIdn0/204Y9xKJTn7jFJfPW0p1GYxAWs+VPQXo8KN1
         RDSBDQvw6ZRucMbpo+gxZdHxZck3vnIDEJc+W9FGDKM6MPB4Cz/W1+Xon8jcQ05wTU
         IThCk9nwb/m+cO2Tdkrv30NWKrBNVbc1FDG52cNDV2efVA2IoCWgQU9apcD6FLb3VC
         33NcJmte+vsug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        juntong.deng@outlook.com, liushixin2@huawei.com,
        wonguk.lee1023@gmail.com, andrew.kanner@gmail.com,
        yogi.kernel@gmail.com, code@siddh.me,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 14/36] jfs: fix array-index-out-of-bounds in dbFindLeaf
Date:   Tue,  7 Nov 2023 10:45:56 -0500
Message-ID: <20231107154654.3765336-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manas Ghandat <ghandatmanas@gmail.com>

[ Upstream commit 22cad8bc1d36547cdae0eef316c47d917ce3147c ]

Currently while searching for dmtree_t for sufficient free blocks there
is an array out of bounds while getting element in tp->dm_stree. To add
the required check for out of bound we first need to determine the type
of dmtree. Thus added an extra parameter to dbFindLeaf so that the type
of tree can be determined and the required check can be applied.

Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 4d59373f9e6c9..11c77757ead9e 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -87,7 +87,7 @@ static int dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno,
 static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks);
 static int dbFindBits(u32 word, int l2nb);
 static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno);
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx);
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl);
 static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		      int nblocks);
 static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
@@ -1717,7 +1717,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
 		 * dbFindLeaf() returns the index of the leaf at which
 		 * free space was found.
 		 */
-		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx);
+		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx, true);
 
 		/* release the buffer.
 		 */
@@ -1964,7 +1964,7 @@ dbAllocDmapLev(struct bmap * bmp,
 	 * free space.  if sufficient free space is found, dbFindLeaf()
 	 * returns the index of the leaf at which free space was found.
 	 */
-	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
+	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
 		return -ENOSPC;
 
 	if (leafidx < 0)
@@ -2928,14 +2928,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
  *	leafidx	- return pointer to be set to the index of the leaf
  *		  describing at least l2nb free blocks if sufficient
  *		  free blocks are found.
+ *	is_ctl	- determines if the tree is of type ctl
  *
  * RETURN VALUES:
  *	0	- success
  *	-ENOSPC	- insufficient free blocks.
  */
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 {
 	int ti, n = 0, k, x = 0;
+	int max_size;
+
+	max_size = is_ctl ? CTLTREESIZE : TREESIZE;
 
 	/* first check the root of the tree to see if there is
 	 * sufficient free space.
@@ -2956,6 +2960,8 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
 			/* sufficient free space found.  move to the next
 			 * level (or quit if this is the last level).
 			 */
+			if (x + n > max_size)
+				return -ENOSPC;
 			if (l2nb <= tp->dmt_stree[x + n])
 				break;
 		}
-- 
2.42.0

