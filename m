Return-Path: <linux-kernel+bounces-62640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCFC8523EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799C0B26FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CCE5FDC7;
	Tue, 13 Feb 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3NUdC2+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4E5FBBA;
	Tue, 13 Feb 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783663; cv=none; b=VPXGAm5qxy7G73i+cy1SfvJhLVJ2ALocyz80NhIfoJjskWjuHDeTTvP73q2tMbeROCj0yUQfON0atP0ROMYXUnufkvhwvhgdUwstG8gqSdKVTdvu31SNmHav/tsT+1opKvCGtg/tX5kAOZTBsqh7Lv6WsRVFH2PCNQgncEHf7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783663; c=relaxed/simple;
	bh=zHSXicWjjxO3o/RSM0TPOy8SI/IrnIdYwj/uQeM+qXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2bLQWh958gV2/vF7ZUrsOwzsL0v9REQzk2fMJPTPgZ4ANJdkRUev/EE1KxnDyXxk4H75s88hkhdvzZCbMZfdisP0nTFfbJNf5z6ZxFHckFpp2lz/LZR0kbPf8Y6XMk42gIp4xb6x/xvjTaaB0SrC2EibrtJX//BiauDAeGZ54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3NUdC2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6D9C43390;
	Tue, 13 Feb 2024 00:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783663;
	bh=zHSXicWjjxO3o/RSM0TPOy8SI/IrnIdYwj/uQeM+qXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3NUdC2+xwdwDcPgHsZ8nzKMIqbXpK6vxBNup4fZqZbJlafUMkyr1I6LNeEBVmSrJ
	 rJ5V/N/AyzdpQv0n9g8KG+95tor7I498Ci1MnClZGtVc/ZVs2QDhhNpX06lxHfyaQD
	 U25c2ukCuxzRu59iW+LVcSH67T0mjkQS0qwalInFjj7iLVFe1GFDaw+lyTWwi1LOB+
	 lStyT+DWuzWZFLJitVWTklbU5zVCqdnJ+BuSN5bzLnaURumekXCVrc7C24ocsuKc4a
	 SyLIIFqzvn6m0pBJsrtl2o+7GkHqNV3ruWRr2nm4hf3HRYZR9qvlhDUmhUj0cJMyhZ
	 QofoU3NhxoG4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 09/51] fs/ntfs3: Add file_modified
Date: Mon, 12 Feb 2024 19:19:46 -0500
Message-ID: <20240213002052.670571-9-sashal@kernel.org>
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

[ Upstream commit 4dea9cd522424d3002894c20b729c6fbfb6fc22b ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1f7a194983c5..6e1c456c9ae7 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -632,11 +632,17 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 					    &ni->file.run, i_size, &ni->i_valid,
 					    true, NULL);
 			ni_unlock(ni);
+			if (err)
+				goto out;
 		} else if (new_size > i_size) {
 			inode->i_size = new_size;
 		}
 	}
 
+	err = file_modified(file);
+	if (err)
+		goto out;
+
 out:
 	if (map_locked)
 		filemap_invalidate_unlock(mapping);
@@ -1040,6 +1046,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
+	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (is_encrypted(ni)) {
@@ -1067,6 +1074,12 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		goto out;
 
+	err = file_modified(iocb->ki_filp);
+	if (err) {
+		ret = err;
+		goto out;
+	}
+
 	if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
 		/* Should never be here, see ntfs_file_open(). */
 		ret = -EOPNOTSUPP;
-- 
2.43.0


