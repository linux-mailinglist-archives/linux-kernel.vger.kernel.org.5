Return-Path: <linux-kernel+bounces-62685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D5852460
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F9E282E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8806F525;
	Tue, 13 Feb 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys7uGCn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADB2231C;
	Tue, 13 Feb 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783759; cv=none; b=D0qdE+q55wuSs/KYoa9GbUqWlGbF78LFxk2xKtX1VDWqLWGdz3GN9DvGdJAs45UatYDY4i/L2xVdD5gjAtwxFFMhVIxUl8fNfVUjmF9iB75EIQoNZRist9Rtqjlq0kxv7dk717etrFLs7yzp1CBUp3pUse6ramk4ZVloKdHN/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783759; c=relaxed/simple;
	bh=TqV7KVRznlneGnlaz5y1ne30oIJvxNcAm1FemHAhLp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9yV0muSb9R+/fNaYZVRqTEX5fBv5DfwRdlFpSmjYB29Jx4O9F0LCkuWTacTAI7CnU0WWW57YCT7mgoEc/9xBDkT7BGtmvKXufyifA98jsqT8Jlzja7EXBzZRzcQBTuVNGgIkINmfXSCliEhCqowdp09B9YV6lvezbg3ZzbARSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys7uGCn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD24C43390;
	Tue, 13 Feb 2024 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783759;
	bh=TqV7KVRznlneGnlaz5y1ne30oIJvxNcAm1FemHAhLp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ys7uGCn3ychQ9y3+QFVOroDTN68CE4UOSulcn2Sk+qle2p+ms/Y9wTTNSlyxAEDNf
	 DQrTxQ73TD90DRbcHZkdxi9b1qErxLI44YGHsNtRd1/2T6or2hn1Tur4gqSR9UxTYB
	 SoHkJ9a9fJ3h0RCcwbbNYm32t0HS7vLidxzIAHHiYkHaUPC0AyscRVw9Gq0U/QImAj
	 db0qcweYlA3dlnkas0sJzaH17fIlf3syNRQo/ac5jyjEcAJ7wWBxLldx5P6hcJ3tH7
	 uO0d4fALScwXP3zi/r6vRXszhEnzyQRnyjpDtS5lMnCKrdKp2DBWSfY1Svr4CTo2kB
	 AIZQc4SfHDMJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 02/28] fs/ntfs3: Improve ntfs_dir_count
Date: Mon, 12 Feb 2024 19:22:00 -0500
Message-ID: <20240213002235.671934-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 6a799c928b78b14999b7705c4cca0f88e297fe96 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/dir.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index c2fb76bb28f4..72cdfa8727d3 100644
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


