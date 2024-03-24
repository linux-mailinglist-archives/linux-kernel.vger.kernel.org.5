Return-Path: <linux-kernel+bounces-114614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2C888B51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C9D293884
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BEC2A2B3D;
	Sun, 24 Mar 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrmHdHSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9A14D458;
	Sun, 24 Mar 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322273; cv=none; b=T7phn0/u5Om7nC/tr2yPYtHah8+aqXQJPLtYnS8zq/g+0aLW5lKgVh7DSKmO4UBLq0Da5a1xfdsd/XNzAzzYuDEslHgOBsrcdMKdkxcaokL4sd46UCBzgmivN7J0Eh9s8IA8JMFDHiEb2ZG/079034cCrlyqi1/+PQ6zqhyI4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322273; c=relaxed/simple;
	bh=F8H3HJDHsxovhZt1b8ulvrfsnrUvjn3+y6E72couSek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRbI+JNF4WO+9tLfsr4P6H/Zsm40E+7ELZVS+tqoCenKntRyhUaIQUSl6GxPXwiYfcvIQert/7IS8YS7pgm8SnkXFBLwH5OyGg/nvrMethAn3/PKYjKRhsEclZRkODf/+lFNGe8w/tKoL54fzMZdFHHAQyYVcnnGu1XnSBtXP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrmHdHSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F038EC43390;
	Sun, 24 Mar 2024 23:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322273;
	bh=F8H3HJDHsxovhZt1b8ulvrfsnrUvjn3+y6E72couSek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrmHdHSlKD3Csp1LaxfXcToD8Tm0XtMbKb1Ji/Az18XCQPEYrmgAY61/B2BXrXeHs
	 /RJOsUXFOlVwVZ3X+5C8+JI28dMS1JbZrumukGYMk5ShMBZZfGDPiwFJ8XYOyi4cBH
	 iPjqx0bf36cCsERnQfJbspIt8gaIyGfqk4WxnWA0LpZ+yPAW4NBGcP1LuPbqLTbc4O
	 QM9a7g8x2Kmuy6pEreLmOBH6NHbmOfAOEwtw83nPMomZqRj+RImO/+et5M4btQqDzO
	 Ufqn0PNRemqypeA/022TgNhmpi4x4BXLGhrtr8rFc1NPu6F2pViz26+kCqoGX8dXEG
	 CDpHj9E6F109g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 356/451] f2fs: simplify __allocate_data_block
Date: Sun, 24 Mar 2024 19:10:32 -0400
Message-ID: <20240324231207.1351418-357-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3cf684f2f8e0229714fb6d051508b42d3320e78f ]

Just use a simple if block for the conditional call to
inc_valid_block_count.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3f0ba71451c27..77b825fdeec85 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1420,13 +1420,12 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 		return err;
 
 	dn->data_blkaddr = f2fs_data_blkaddr(dn);
-	if (dn->data_blkaddr != NULL_ADDR)
-		goto alloc;
-
-	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
-		return err;
+	if (dn->data_blkaddr == NULL_ADDR) {
+		err = inc_valid_block_count(sbi, dn->inode, &count);
+		if (unlikely(err))
+			return err;
+	}
 
-alloc:
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	old_blkaddr = dn->data_blkaddr;
 	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
-- 
2.43.0


