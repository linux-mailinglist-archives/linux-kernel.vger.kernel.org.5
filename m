Return-Path: <linux-kernel+bounces-134221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B3689AF34
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C2F1C21D3D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4B011181;
	Sun,  7 Apr 2024 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiKKm2z1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F849107A6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474777; cv=none; b=uGm7yiGJiDEaYlhDrInLqBuDrUSzBB9Vxa1gdiu9ImvF/18Ra3gJoUKlk30UoGvqwu6oj3YCkVnhQfB1ybuJGT/dYF+2/YP43YSg0ePgX8BIS0mT9w1Rnt2gJW6uvvbT26JuKIPpM2zEmkIkUJ/fWFBoFVOnUsBI/qrB/IIY/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474777; c=relaxed/simple;
	bh=M0/dwoy3n4OuzNbOOGe4V4klmcbe/S0AlwHuaNRNolw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJ5SqCh0Kuo9FR/BiWvEDC39uRmZ9yzFhxms654PvXaBZLKxJTdxUgyWousNQ72q63LdbCQeVNV+1IF8D1NGtufkeBvfgLHIErLpqdYEUGy+9rAcQ0QLSb9di7mSHyV9Hwqaf8Sz4DgKX46oDquQL0zDSpPBqqvzRCxIfh7B4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiKKm2z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DEC43390;
	Sun,  7 Apr 2024 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712474777;
	bh=M0/dwoy3n4OuzNbOOGe4V4klmcbe/S0AlwHuaNRNolw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiKKm2z1nI2lPSoS8JXqg29xDl3qEuJBR0uZ7KUwK7FNDx5n1Q/JtYFuPbdNxPkHE
	 kI3Txf7+vJHAVmg5nNVYfpfMKIVBlVgX9ZBKa8RQcHwnhGxqoy5ZG73S/p2762tCEL
	 bB7KlyirZFgt2KdxNLY8DbG/G8zBPMypytAQmBXeeY5ZT+PSLkya0dDAA6XgDNRFXV
	 QiOXWf8PkC9hxamEBwGTmGLRItScqapqPx7POTCyXdXnU/tCt3ZQXKkknEXlkNXXyK
	 r3b47ADfPaBday+P7h4tSGmzr6y1BZuaQJ+SfK4NfIxOfvUCxIMfi56d+zziSZsugz
	 kdvI8SuzaDl5A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 2/2] f2fs: compress: fix to relocate check condition in f2fs_ioc_{,de}compress_file()
Date: Sun,  7 Apr 2024 15:26:04 +0800
Message-Id: <20240407072604.3488169-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240407072604.3488169-1-chao@kernel.org>
References: <20240407072604.3488169-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compress flag should be checked after inode lock held to avoid
racing w/ f2fs_setflags_common() , fix it.

Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca401cf8152a..232dd5fc8ab3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4142,9 +4142,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4155,7 +4152,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4220,9 +4218,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4233,7 +4228,8 @@ static int f2fs_ioc_compress_file(struct file *filp)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.40.1


