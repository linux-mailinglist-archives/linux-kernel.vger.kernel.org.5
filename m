Return-Path: <linux-kernel+bounces-62714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583928524B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B44E1C23C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B818528A;
	Tue, 13 Feb 2024 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBnYgPNx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8123770;
	Tue, 13 Feb 2024 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783815; cv=none; b=Dfuwm29bEVxhtePNn7EpzGgp1goDwxbXiLt65cco1zJd51rWo7Qb1F5w5DHxI/Jxw8BcPQ2yqCHXVBA/oi3f5K6hyt84ALaZQ6AblV+1KH9EqnWvDkrbCVAOCZpTnjlZi1KDoIar7b0K4HefIxK6LseFUQzY5gUG6U9DPTMuUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783815; c=relaxed/simple;
	bh=TqV7KVRznlneGnlaz5y1ne30oIJvxNcAm1FemHAhLp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql/IzfO4ox2m7jw+7/sI1RmKRAk5e0A+ox3xQWxsF71LA58s0QGyDH7Wq8L8chbu5JxwN+NnyuRbHQZTV/6vyPT+dSM4Ha447DUxLHH7XD0sfbJ8imvsN1y+rwNsDb3HfGEDj2FxkSSS2JfrSupy4QrTo7/W9W70ob3o6kRzhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBnYgPNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB53C433F1;
	Tue, 13 Feb 2024 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783815;
	bh=TqV7KVRznlneGnlaz5y1ne30oIJvxNcAm1FemHAhLp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBnYgPNxYaLEjmqnv/+WfVz4xi9P3fSFjdldDKqoTvs6/lbJAHpLhyzc8z76OuOaw
	 LRGSHVkFBUkg/HD44LXQ13nldrUBFqeuhDLh5dvsRLu2VMZN4IuOV3ODgPJOF+4Rrh
	 5RGmKW0/nZ6SLwfZ6ySYGTMxoGxOAB+UJB9HZJicrZ8aMqllzjT7T2hHyYgPtakYVt
	 0H5ZFWr2CjwrRmhtpBQkLZLmG2Ff+t1xooWMbt7Mmp/UfxGr3SQRXiVzE+7ubSHuk6
	 NWd0VDhByjFAPWziVl/yNZD58/dHyLSgFXhBqL93e/AD2jypVCGG0Z+c6iVlYOv52s
	 N/p8Why2QvF1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 02/22] fs/ntfs3: Improve ntfs_dir_count
Date: Mon, 12 Feb 2024 19:23:04 -0500
Message-ID: <20240213002331.672583-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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


