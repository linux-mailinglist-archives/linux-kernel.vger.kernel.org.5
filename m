Return-Path: <linux-kernel+bounces-102075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75587AE30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D02283273
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CA715D5A6;
	Wed, 13 Mar 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcaKGuj8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D415CD6B;
	Wed, 13 Mar 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348456; cv=none; b=csmnetktS2TtwYjFz3+lneo4X83FcjIL2s9+x8KcYZQdmHXqyEG7XDw+w2GpYK+xk3SUUMTmcXta2F4wkWmRfjdeZcKy365gGUl2V3dX9TfV0hxKZjKGrI48rK/gia+ux53USAyMxdpTJJW0ti2D6XmiXdoVbC6nwyFlSjd04vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348456; c=relaxed/simple;
	bh=qn2fM80E1w/rF1OY2H5UOkBO47+ZXtu86DalO7stLGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Laawy6Bx/kVCKforl+akN8q00LkJVUse26QuoGECdjSMOPxbID8azpW5MpWjq7IIEipWesbjHqyzJTPJwKIMXbq1bpedop52EuusM1cNdLrpET4y0AXGAW5LFpN0c93oWYjB3YS4il1lYuOyUx8e9QWitT5tCKH2C2ya7ihA0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcaKGuj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F81C433C7;
	Wed, 13 Mar 2024 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348456;
	bh=qn2fM80E1w/rF1OY2H5UOkBO47+ZXtu86DalO7stLGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcaKGuj8n+ECGlm4qy9tcq3fnDefMBpr9fd3W7cIA2cN/I+T5pFYY/hdFeF2JCZuN
	 3+Y7J51A08mHzvDqLLlJ/vEJW4njedKWGzaVlxlfOBQXON4Aurzt0GmuKEetuU6gGG
	 WWP668KQgVhV1dCgLdHWQmMuD2sfZm7/GtjNP9AqGhk1L8woyfY+NwY4sQIkg+BlW7
	 tclJjZG/VcPaoKa++gRBERvUCmW9I4g5aY+I7m4tw5+y7iUWUVAQYC7uh41O4iERwq
	 gEfAVy4R4Fbya3fxo2Df6fK7mNFIdxEVoM6iZr0PucviXqdOBQnauTwD1rvpqtwqZN
	 mJw7a6yEKAhHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 49/73] ext4: refactor ext4_da_map_blocks()
Date: Wed, 13 Mar 2024 12:46:16 -0400
Message-ID: <20240313164640.616049-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 3fcc2b887a1ba4c1f45319cd8c54daa263ecbc36 ]

Refactor and cleanup ext4_da_map_blocks(), reduce some unnecessary
parameters and branches, no logic changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240127015825.1608160-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: acf795dc161f ("ext4: convert to exclusive lock while inserting delalloc extents")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ab2a7f9902887..64162470a7e6c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1729,7 +1729,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
 		if (ext4_es_is_hole(&es)) {
-			retval = 0;
 			down_read(&EXT4_I(inode)->i_data_sem);
 			goto add_delayed;
 		}
@@ -1774,26 +1773,9 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
 		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-
-add_delayed:
-	if (retval == 0) {
-		int ret;
-
-		/*
-		 * XXX: __block_prepare_write() unmaps passed block,
-		 * is it OK?
-		 */
-
-		ret = ext4_insert_delayed_block(inode, map->m_lblk);
-		if (ret != 0) {
-			retval = ret;
-			goto out_unlock;
-		}
-
-		map_bh(bh, inode->i_sb, invalid_block);
-		set_buffer_new(bh);
-		set_buffer_delay(bh);
-	} else if (retval > 0) {
+	if (retval < 0)
+		goto out_unlock;
+	if (retval > 0) {
 		unsigned int status;
 
 		if (unlikely(retval != map->m_len)) {
@@ -1808,11 +1790,24 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
+		goto out_unlock;
 	}
 
+add_delayed:
+	/*
+	 * XXX: __block_prepare_write() unmaps passed block,
+	 * is it OK?
+	 */
+	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	if (retval)
+		goto out_unlock;
+
+	map_bh(bh, inode->i_sb, invalid_block);
+	set_buffer_new(bh);
+	set_buffer_delay(bh);
+
 out_unlock:
 	up_read((&EXT4_I(inode)->i_data_sem));
-
 	return retval;
 }
 
-- 
2.43.0


