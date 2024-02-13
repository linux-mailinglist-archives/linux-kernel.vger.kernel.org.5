Return-Path: <linux-kernel+bounces-62578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCD852333
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458171C234BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9309F4FA;
	Tue, 13 Feb 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koWj6oOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C43CA47;
	Tue, 13 Feb 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783530; cv=none; b=oBdIWGP3Y0zcGTQL1YQU71BnKJzuLSvWdCuXKrqgy+lsNWiqYPJcmtXqnVPrifb7JvsZsnTR5XDBMHJJyuesVLViH1H9EyPyl5OdcE6hK2JAa6CTNO47PjAACBlsovlapgTwEYxGfzp8EsLo3mDF23i9GKhLqJBW0rAX8Jal8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783530; c=relaxed/simple;
	bh=22t+kw7AgkxCl5zSuoWiGHP3raWmAYRqSEDdEY6z3LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXox/H7mkJfvbXKqQChWn2SoiiMp0BpSp6S0VLNc1AyyJ5o31S+4LXJoLoz7v1w0AGf3pg2jgRS/0NPXHrruM1qquCla+IIFJVnhWFE9SUT0Gyl4UqhJOqfwUSOtNoZmpZUAHOlAJ0mpwE5NxSOQqjKsE0lv9Aykn2VZXf6oATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koWj6oOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3F0C433C7;
	Tue, 13 Feb 2024 00:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783529;
	bh=22t+kw7AgkxCl5zSuoWiGHP3raWmAYRqSEDdEY6z3LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koWj6oOH5zZfV3Ul85l0zVsS5xJmggFfPEpgbBm/dJI6gvBRTmid50e3y3zahoh1X
	 bjXNImyO8j1ZO85kaw5mBtc7G/ujBTRPPhdItTCL5fWj1x4Wj89q7PTrU0FNXOG9NG
	 boPZLlL1vq2Qug8r1/WWZt61nLbsw62Zm1KbgnCkFdN+LBlmACXeeGSMCaONTC21uM
	 ZUf4ZmYFHYy23qQG6z22CmzvHq6NL9jrFKo0olaefIKpb8Mg52tns9OH+AyEqxUzR+
	 52UAcpAmdRUeYt02DvYr8DIcoX3YUhRAiT281+W+yOMZeIFNQWhXWYpUe0uuAbk76W
	 7HgnPAodCZvdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 09/58] fs/ntfs3: Correct use bh_read
Date: Mon, 12 Feb 2024 19:17:15 -0500
Message-ID: <20240213001837.668862-9-sashal@kernel.org>
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

[ Upstream commit a40b73f608e7de2120fdb9ddc8970421b3c50bc9 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c  | 19 +++++++++----------
 fs/ntfs3/inode.c |  7 +++----
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index a5a30a24ce5d..5691f04e6751 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -188,6 +188,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	u32 bh_next, bh_off, to;
 	sector_t iblock;
 	struct folio *folio;
+	bool dirty = false;
 
 	for (; idx < idx_end; idx += 1, from = 0) {
 		page_off = (loff_t)idx << PAGE_SHIFT;
@@ -223,29 +224,27 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 			/* Ok, it's mapped. Make sure it's up-to-date. */
 			if (folio_test_uptodate(folio))
 				set_buffer_uptodate(bh);
-
-			if (!buffer_uptodate(bh)) {
-				err = bh_read(bh, 0);
-				if (err < 0) {
-					folio_unlock(folio);
-					folio_put(folio);
-					goto out;
-				}
+			else if (bh_read(bh, 0) < 0) {
+				err = -EIO;
+				folio_unlock(folio);
+				folio_put(folio);
+				goto out;
 			}
 
 			mark_buffer_dirty(bh);
-
 		} while (bh_off = bh_next, iblock += 1,
 			 head != (bh = bh->b_this_page));
 
 		folio_zero_segment(folio, from, to);
+		dirty = true;
 
 		folio_unlock(folio);
 		folio_put(folio);
 		cond_resched();
 	}
 out:
-	mark_inode_dirty(inode);
+	if (dirty)
+		mark_inode_dirty(inode);
 	return err;
 }
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index fa6c7965473c..bba0208c4afd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -345,9 +345,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			inode->i_size = le16_to_cpu(rp.SymbolicLinkReparseBuffer
 							    .PrintNameLength) /
 					sizeof(u16);
-
 			ni->i_valid = inode->i_size;
-
 			/* Clear directory bit. */
 			if (ni->ni_flags & NI_FLAG_DIR) {
 				indx_clear(&ni->dir);
@@ -653,9 +651,10 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 			off = vbo & (PAGE_SIZE - 1);
 			folio_set_bh(bh, folio, off);
 
-			err = bh_read(bh, 0);
-			if (err < 0)
+			if (bh_read(bh, 0) < 0) {
+				err = -EIO;
 				goto out;
+			}
 			folio_zero_segment(folio, off + voff, off + block_size);
 		}
 	}
-- 
2.43.0


