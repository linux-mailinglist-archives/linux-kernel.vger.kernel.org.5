Return-Path: <linux-kernel+bounces-117362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FC288B420
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F028B3E165
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FC36D1B4;
	Mon, 25 Mar 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW9eTHNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514686CDAC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380459; cv=none; b=eWbTU+XaTzUySirCOAbvJq4n47pKz54GGUuPWjyqEgIFgOrJmphUp0YQMQnI2jlg6w7/YjDcy+a68sHr7xUn/0HU/Oa2jIUPjmF0PMXO9hxOoscQ7Bnhfn9Pb9+DIwiEeV5XNoUhdK1StVDMxdeCLm9Mll7cp+fGJdpZ86T0g2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380459; c=relaxed/simple;
	bh=k5vZ5v04kF+SNpJumj+J1Clmo/WK+DuJDJ+dqdGfxgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEtopPTsBqAcnR0l1ycXadDW+9lHtQiFI5fPB1jzFdYjzE0/GkBwAHZO6lF2RZyg8sQztXnDNVKJ+x4V8zXEpr5lfDHbJLOsEJjfbch8Dqb3I853oTVtscsbjXPmc8+lp4cd9DYWz1GmrD9NoNyzRJxaYxY+irEHSv/1kykbvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW9eTHNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FA5C43390;
	Mon, 25 Mar 2024 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711380458;
	bh=k5vZ5v04kF+SNpJumj+J1Clmo/WK+DuJDJ+dqdGfxgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nW9eTHNZJQZ4frfnYSFxcHI9Zr4oCSfglPYt26veolD4SXrCiu3HOfvnUTWeFRVLl
	 dSAIU7p5MLFBLV6TNensdOPjmK+r0N6yOfqHN9Pqkx8q54xWjgS/16reooZmmb4S/c
	 MbOj+ZV2HEZajOVMgi0/hWUESWUGS4UcgS7o9sKOEGF2kJ3l6+4XfTnXX2kB4tTdGx
	 exOyBqBOs+BPm1zAPm8d16KxMMt/RpRF+KX2Kzw8/Ct9d6/06cOcZ8aYkpbHQ6ZEbm
	 XTaUtAfbPmw1T1kb36HqqDVqkn4sdiICNf4fSzunu6nDu9TkfzqnMrpDjZDDzfBI5W
	 o+ROXHrJZtYzA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: support to map continuous holes or preallocated address
Date: Mon, 25 Mar 2024 23:27:26 +0800
Message-Id: <20240325152726.797423-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325152726.797423-1-chao@kernel.org>
References: <20240325152726.797423-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports to map continuous holes or preallocated addresses
to improve performace of lookuping mapping info during read DIO.

[testcase 1]
xfs_io -f /mnt/f2fs/hole -c "truncate 1m" -c "fsync"
xfs_io -d /mnt/f2fs/hole -c "pread -b 1m 0 1m"

[before]
f2fs_direct_IO_enter: dev = (253,16), ino = 6 pos = 0 len = 1048576 ki_flags = 20000 ki_ioprio = 0 rw = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 0, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 1, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 2, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 3, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 4, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 5, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 6, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 7, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 8, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 9, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 10, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 11, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 12, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 13, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 14, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 15, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 16, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
.....
f2fs_direct_IO_exit: dev = (253,16), ino = 6 pos = 0 len = 1048576 rw = 0 ret = 1048576

[after]
f2fs_direct_IO_enter: dev = (253,16), ino = 6 pos = 0 len = 1048576 ki_flags = 20000 ki_ioprio = 0 rw = 0
f2fs_map_blocks: dev = (253,16), ino = 6, file offset = 0, start blkaddr = 0x0, len = 0x100, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_direct_IO_exit: dev = (253,16), ino = 6 pos = 0 len = 1048576 rw = 0 ret = 1048576

[testcase 2]
xfs_io -f /mnt/f2fs/preallocated -c "falloc 0 1m" -c "fsync"
xfs_io -d /mnt/f2fs/preallocated -c "pread -b 1m 0 1m"

[before]
f2fs_direct_IO_enter: dev = (253,16), ino = 11 pos = 0 len = 1048576 ki_flags = 20000 ki_ioprio = 0 rw = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 0, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 1, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 2, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 3, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 4, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 5, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 6, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 7, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 8, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 9, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 10, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 11, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 12, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 13, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 14, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 15, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 16, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
.....
f2fs_direct_IO_exit: dev = (253,16), ino = 11 pos = 0 len = 1048576 rw = 0 ret = 1048576

[after]
f2fs_direct_IO_enter: dev = (253,16), ino = 11 pos = 0 len = 1048576 ki_flags = 20000 ki_ioprio = 0 rw = 0
f2fs_map_blocks: dev = (253,16), ino = 11, file offset = 0, start blkaddr = 0xffffffff, len = 0x100, flags = 4, seg_type = 1, may_create = 0, multidevice = 0, flag = 3, err = 0
f2fs_direct_IO_exit: dev = (253,16), ino = 11 pos = 0 len = 1048576 rw = 0 ret = 1048576

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9c000ca4f808..47e9b1bddb9b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1521,6 +1521,9 @@ static bool map_is_mergeable(struct f2fs_sb_info *sbi,
 		return true;
 	if (flag == F2FS_GET_BLOCK_PRE_DIO)
 		return true;
+	if (flag == F2FS_GET_BLOCK_DIO &&
+		map->m_pblk == NULL_ADDR && blkaddr == NULL_ADDR)
+		return true;
 	return false;
 }
 
@@ -1645,6 +1648,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 				goto sync_out;
 			}
 			break;
+		case F2FS_GET_BLOCK_DIO:
+			if (map->m_next_pgofs)
+				*map->m_next_pgofs = pgofs + 1;
+			break;
 		default:
 			/* for defragment case */
 			if (map->m_next_pgofs)
@@ -1663,7 +1670,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		/* reserved delalloc block should be mapped for fiemap. */
 		if (blkaddr == NEW_ADDR)
 			map->m_flags |= F2FS_MAP_DELALLOC;
-		map->m_flags |= F2FS_MAP_MAPPED;
+		if (flag != F2FS_GET_BLOCK_DIO || !is_hole)
+			map->m_flags |= F2FS_MAP_MAPPED;
 
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
@@ -4192,12 +4200,13 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 * We should never see delalloc or compressed extents here based on
 	 * prior flushing and checks.
 	 */
-	if (WARN_ON_ONCE(map.m_pblk == NEW_ADDR))
-		return -EINVAL;
 	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
 		return -EINVAL;
 
 	if (map.m_flags & F2FS_MAP_MAPPED) {
+		if (WARN_ON_ONCE(map.m_pblk == NEW_ADDR))
+			return -EINVAL;
+
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
@@ -4206,9 +4215,17 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	} else {
 		if (flags & IOMAP_WRITE)
 			return -ENOTBLK;
-		iomap->length = blks_to_bytes(inode, next_pgofs) -
-				iomap->offset;
-		iomap->type = IOMAP_HOLE;
+
+		if (map.m_pblk == NULL_ADDR) {
+			iomap->length = blks_to_bytes(inode, next_pgofs) -
+								iomap->offset;
+			iomap->type = IOMAP_HOLE;
+		} else if (map.m_pblk == NEW_ADDR) {
+			iomap->length = blks_to_bytes(inode, map.m_len);
+			iomap->type = IOMAP_UNWRITTEN;
+		} else {
+			f2fs_bug_on(F2FS_I_SB(inode), 1);
+		}
 		iomap->addr = IOMAP_NULL_ADDR;
 	}
 
-- 
2.40.1


