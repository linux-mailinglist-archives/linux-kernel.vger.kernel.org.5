Return-Path: <linux-kernel+bounces-62572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69B85231A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319391F21FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B24416;
	Tue, 13 Feb 2024 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBziWRvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C71FCC;
	Tue, 13 Feb 2024 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783523; cv=none; b=na85pKlSNyNK2uQ0lkXGIQrkQIXlm2CN2CHAvMgEZTgBFUq6VdBqvtb4zpueoBx3z1nYec7oPvAj/n7gTxNdmDez2PDVjtZVSueDLBGZOy7QUBXAP69vK8ZmiSjHjD0AgRKu3HxOAU/cBWSbr14NWEB4VWw5b62GaBSiGNHDv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783523; c=relaxed/simple;
	bh=BoJ6LOeYpR9JZuCngqdOOTDBqOQtR5nqFkA3uXoihWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HObPgZREXWvUapBXv/NLukX2Zdw0xNNxX8vTns1ZKlO/S+3V+8Y7lBf8/LE5/qEElx8IwRtWcOCaQYyKw6XHML2ylBL62JcgflWWJdOtA48rZAezXIs3tDqlRTDHYq71AYFOTjo+w9P/ewLVLI8DA8xK9igKp37K/O4ReMCcwoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBziWRvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0122DC43390;
	Tue, 13 Feb 2024 00:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783522;
	bh=BoJ6LOeYpR9JZuCngqdOOTDBqOQtR5nqFkA3uXoihWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBziWRvo3YCF3yVBMItZP5ANqdY0C3tXo+uQ1i4LCvm3YToe3c1n8MgCXYESJQAAV
	 qcrRHvCMdBm3znqvhkZO8xD4kBRJtVlJyC9SlKo1MrEnoKdVCagjjE7CmUS2AGmkzV
	 OhUC9zRSM6xi63u7nMkE1d4wHB+sTF5UTfpZOSHxxrROZBks2++8gyN/kWZnQWJHlN
	 +IJDq8XCiVUOhr8ygtjWl7B8TrsiKjJS7WGjS1jpy378mrX1VAEob3lbIcbyUVcvid
	 kCroqzIEhC8MiyovCwNm4VlTFvuOClgp40ckSF982Z+6C3mpSBnlrti015qBV2V9Gu
	 opPvpjf77z4rQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 03/58] fs/ntfs3: Improve ntfs_dir_count
Date: Mon, 12 Feb 2024 19:17:09 -0500
Message-ID: <20240213001837.668862-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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


