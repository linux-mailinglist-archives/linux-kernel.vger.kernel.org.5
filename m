Return-Path: <linux-kernel+bounces-151051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52C48AA861
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5651E1F220FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF96134DE;
	Fri, 19 Apr 2024 06:22:12 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A51D51C;
	Fri, 19 Apr 2024 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507732; cv=none; b=N9qQlHPiMwbwEZKSZVgLr4qDlDqRTzK5NoWsJxfLO9XlJHbhNHbp1KVBBm5c6Kavbe/LITVxT7k5lH4/b3F9n9hDPhSfQSoSVk3AujnA7k3aygQ14nqQduwhdPdLyb4hKoSnSq2ggzgO61LMuJhhuRvWQDRbAFI/JnLYuQIhdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507732; c=relaxed/simple;
	bh=Js+VQayBYdt/zVTyv4/27+aJ85wh2bym+YFjD9Wcy+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnCAN3F1hXXNDAXPnIVmtH07qMr1lDcGcKZrypcEW5OXdEspGpcEYTHvfwmmElGrcdkPRswEFfCy5Qj6MWz/iBQei+yDT8b0QtT+z/lEZqXG2kl6J2mJ+cGWWiTehr0TLXWj0TOgxXzualQ7gM9wnB5APBgzTul12mIl4JP9zqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VLPcs0fNfzNshZ;
	Fri, 19 Apr 2024 14:19:41 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id CDADE18007D;
	Fri, 19 Apr 2024 14:22:06 +0800 (CST)
Received: from huawei.com (10.175.101.107) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 14:22:06 +0800
From: Ye Bin <yebin10@huawei.com>
To: <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
	<chandan.babu@oracle.com>, <dchinner@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH RFC 1/2] xfs: fix potential create file failed
Date: Fri, 19 Apr 2024 14:18:47 +0800
Message-ID: <20240419061848.1032366-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419061848.1032366-1-yebin10@huawei.com>
References: <20240419061848.1032366-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)

In the file system expansion test and concurrent file creation and
writing scenarios, file creation fails occasionally.
The detailed test scheme is as follows:
1. If the remaining space is less than 128 MB, expand the space by 1 GB;
   --xfs_growfs /$DEV -D $bc -m 100
2. 32 processes create a file every 0.5s and write 4 KB to 4 MB data randomly.
   --filesize=$((RANDOM % 1024 + 1))
   --dd if=/dev/zero oflag=direct of=$filename bs=4K count=$filesize
There is a possibility that the file fails to be created after the preceding
steps are performed. However, when file creation fails, there are still
hundreds of megabytes of free space.The process of failing to create a file
is as follows:
      Direct write                            create file
xfs_direct_write_iomap_begin
 xfs_iomap_write_direct
   ...
  xfs_alloc_ag_vextent_near
   xfs_alloc_cur_finish
    xfs_alloc_fixup_trees
     xfs_btree_delete
      xfs_btree_delrec
       xfs_allocbt_update_lastrec
        case LASTREC_DELREC:
	 numrecs = xfs_btree_get_numrecs(block);
	 if (numrecs == 0)
	  len = 0;
	 pag->pagf_longest = be32_to_cpu(len);
	                                xfs_generic_create
					 xfs_create
                                          xfs_dialloc
					   for_each_perag_wrap_at
					    xfs_dialloc_good_ag
					     xfs_dialloc_try_ag  ->The last AG to alloc inode
					      xfs_ialloc_ag_alloc
					       ...
					       xfs_alloc_vextent_prepare_ag
					        xfs_alloc_fix_freelist
						 xfs_alloc_space_available
						  longest = xfs_alloc_longest_free_extent()
	                                           ->As pag->pagf_longest is equal to zero
						     longest is equal 1
	                                          if (longest < alloc_len)
	 						return false;
						  -> will return false, no space to
						     allocate for inode
As there isn't hold AGF buffer's lock when call xfs_alloc_space_available()
first time in xfs_alloc_fix_freelist(). If remove the last right leaf record
of CNT btree will update 'pag->pagf_longest' with zero. This process is hold
AGF buffer's lock.Above test case constructs repeatedly allocate space within
the same AG, increasing the concurrency between the two processes.
To solve above issue, there's need to hold AGF buffer's lock before call
xfs_alloc_space_available() to judge space is available for request.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 9da52e92172a..f4a083450a65 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2802,14 +2802,16 @@ xfs_alloc_fix_freelist(
 	/* deferred ops (AGFL block frees) require permanent transactions */
 	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
 
-	if (!xfs_perag_initialised_agf(pag)) {
-		error = xfs_alloc_read_agf(pag, tp, alloc_flags, &agbp);
-		if (error) {
-			/* Couldn't lock the AGF so skip this AG. */
-			if (error == -EAGAIN)
-				error = 0;
-			goto out_no_agbp;
-		}
+	/*
+	 * Get the a.g. freespace buffer.
+	 * Can fail if we're not blocking on locks, and it's held.
+	 */
+	error = xfs_alloc_read_agf(pag, tp, alloc_flags, &agbp);
+	if (error) {
+		/* Couldn't lock the AGF so skip this AG. */
+		if (error == -EAGAIN)
+			error = 0;
+		goto out_no_agbp;
 	}
 
 	/*
@@ -2829,20 +2831,6 @@ xfs_alloc_fix_freelist(
 			XFS_ALLOC_FLAG_CHECK))
 		goto out_agbp_relse;
 
-	/*
-	 * Get the a.g. freespace buffer.
-	 * Can fail if we're not blocking on locks, and it's held.
-	 */
-	if (!agbp) {
-		error = xfs_alloc_read_agf(pag, tp, alloc_flags, &agbp);
-		if (error) {
-			/* Couldn't lock the AGF so skip this AG. */
-			if (error == -EAGAIN)
-				error = 0;
-			goto out_no_agbp;
-		}
-	}
-
 	/* reset a padding mismatched agfl before final free space check */
 	if (xfs_perag_agfl_needs_reset(pag))
 		xfs_agfl_reset(tp, agbp, pag);
-- 
2.34.1


