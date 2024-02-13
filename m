Return-Path: <linux-kernel+bounces-62634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE808523DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A481F22787
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B365EE9B;
	Tue, 13 Feb 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6ak9Uas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD680E57F;
	Tue, 13 Feb 2024 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783656; cv=none; b=Da53aMxp7MSMHSLL5jxnPKO1sDjbQqPCMAiSdr+dZvb1G+fRWSXhLpPB91X8g5zYpReMkisLBONJ6SkWX+ss9Bv8rElzw9ybGswA3kXaSjPAhIDXWXlzSuRlKgVXkGkSUWYA2epqw7YHHuDy+1AhwJKYkFoaast08PM7lKBorNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783656; c=relaxed/simple;
	bh=BoJ6LOeYpR9JZuCngqdOOTDBqOQtR5nqFkA3uXoihWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcqCGE1O4q/fK6ThnB68VzwzRnSWoE+jLEGquK3gOhHAtG6x1I2H3szIpKVSJBxZUnJGkaDKLgPva290y8lP6SPMC+BmV1p09Rpc8eK+UZhVqJhplBtAAsX+G2b1skYKKes4L6h9BF23f0/ZPKo9yXcKDAewVp8olIKjuD7F57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6ak9Uas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED0C433C7;
	Tue, 13 Feb 2024 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783656;
	bh=BoJ6LOeYpR9JZuCngqdOOTDBqOQtR5nqFkA3uXoihWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6ak9UaslvK+66h/lnS2Unohg+nJGyvTGqGvHuOaXNxcsJJ9eKCXnoWksBQ5eTRLK
	 c2dvYwtqrPFPsyBPIr73yc/2OqujgXecBkJRdzfbjKv4CesIYwpRDcKI2BjnrnMDAe
	 ES2QNAjZPAuR/WF7reoIoha3RxNxtaY4yIkky7I/T8vf0eWYiadYV/uO5P2322sUni
	 aCWvQl+hCXHCZm6U+fx8C/UB3VUY+DmmP1uBc8GnvT8B99y5+RWU70oTITEOUNIYSY
	 kDrHem9vxF0OHej5g8JJAJH624bbFLemN92iXk6Da+lYy2VUHp6rWszlgYULis4ava
	 pDjdpw8IfKGPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 03/51] fs/ntfs3: Improve ntfs_dir_count
Date: Mon, 12 Feb 2024 19:19:40 -0500
Message-ID: <20240213002052.670571-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 6a799c928b78b14999b7705c4cca0f88e297fe96 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/dir.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 22ede4da0450..726122ecd39b 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -515,11 +515,9 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 	struct INDEX_HDR *hdr;
 	const struct ATTR_FILE_NAME *fname;
 	u32 e_size, off, end;
-	u64 vbo = 0;
 	size_t drs = 0, fles = 0, bit = 0;
-	loff_t i_size = ni->vfs_inode.i_size;
 	struct indx_node *node = NULL;
-	u8 index_bits = ni->dir.index_bits;
+	size_t max_indx = ni->vfs_inode.i_size >> ni->dir.index_bits;
 
 	if (is_empty)
 		*is_empty = true;
@@ -563,7 +561,7 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 				fles += 1;
 		}
 
-		if (vbo >= i_size)
+		if (bit >= max_indx)
 			goto out;
 
 		err = indx_used_bit(&ni->dir, ni, &bit);
@@ -573,8 +571,7 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 		if (bit == MINUS_ONE_T)
 			goto out;
 
-		vbo = (u64)bit << index_bits;
-		if (vbo >= i_size)
+		if (bit >= max_indx)
 			goto out;
 
 		err = indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
@@ -584,7 +581,6 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 
 		hdr = &node->index->ihdr;
 		bit += 1;
-		vbo = (u64)bit << ni->dir.idx2vbn_bits;
 	}
 
 out:
-- 
2.43.0


