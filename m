Return-Path: <linux-kernel+bounces-114396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B6888FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950101F2AFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A7175556;
	Sun, 24 Mar 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXCXnj43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F312197A2;
	Sun, 24 Mar 2024 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321806; cv=none; b=lOo2b19fC9k3OscXFuDWlaVw157a/tjFm30NDmmQEGu6mToLP5pTpzWAH2ZEVsPOGABd9KHgbMUAaWoSsS8MZwbUgZMW1IPTvDqGTzpaRRfoaE1sddPOHWeoKfrM0qMFcLVJ4O+6r73IIaDjNkhp9Sy/Tl3mF8bUf2gp1df8vaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321806; c=relaxed/simple;
	bh=LtYnrhYo+eNtp1rSFQNEN4dv3bTabf23/mW1wEBRXE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMp+XHXTveoUZFrw8Ek4GveTBZHYAxaUAVATITtb50BbAIL891qYUXDBXQ5vfDXkgyng/q5qeKeyBN+p9oDmXNC0uaKC0CbkkkIOsNvUW++79f4lR6Ug3tzpKI9iy3ZRznlaOR7zG0u4RYGz9+ksKb3KbzxNlYTaMvLb0BBb7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXCXnj43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D97C433F1;
	Sun, 24 Mar 2024 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321805;
	bh=LtYnrhYo+eNtp1rSFQNEN4dv3bTabf23/mW1wEBRXE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXCXnj43AJmFDQikBiY7WIZuRR06eXrsDKebV63LsroEvq9pvRU+MdR5pHV5bm9MO
	 QgluKq0/+p8gfjSWQ/OTZVyvFW40Ir56RsexnkzT7eQKmrJdVbOKi9n6TaF1Ba+p1G
	 9fQbpfDswMslMRgUAM7nww0l8CPldBo43c7xXmqs2fP5iunlLu1O5wV8x8p9os1Ifg
	 3QQnBK8I99mvrDpA4EU685wIyGJ5g5zS8Arry3hBwPeMAb3cHjbycvyIVzEQyBUEBF
	 1BzaTC9qOKoU9gjhyj19lYV7ZlR9vkzmPbCl3HTQnoheCx83DSoEtSheKokBhV5q2R
	 2yD77cJZmrMtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 533/638] f2fs: compress: fix to check compress flag w/ .i_sem lock
Date: Sun, 24 Mar 2024 18:59:30 -0400
Message-ID: <20240324230116.1348576-534-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit ea59b12ac69774c08aa95cd5b6100700ea0cce97 ]

It needs to check compress flag w/ .i_sem lock, otherwise, compressed
inode may be disabled after the check condition, it's not needed to
set compress option on non-compress inode.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f41788ab0cf45..2c2ddb0d15836 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3989,16 +3989,20 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 				sizeof(option)))
 		return -EFAULT;
 
-	if (!f2fs_compressed_file(inode) ||
-			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
-			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
-			option.algorithm >= COMPRESS_MAX)
+	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+		option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
+		option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
 
 	file_start_write(filp);
 	inode_lock(inode);
 
 	f2fs_down_write(&F2FS_I(inode)->i_sem);
+	if (!f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
-- 
2.43.0


