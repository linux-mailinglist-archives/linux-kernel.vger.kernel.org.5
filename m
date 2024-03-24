Return-Path: <linux-kernel+bounces-114627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635B888BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58ADEB2BD27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D718925A;
	Sun, 24 Mar 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORPHxq/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491414E2DF;
	Sun, 24 Mar 2024 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322291; cv=none; b=i9JGURvRsNUH16EUvmfDjUg2H7u4mL+IazLgYxXXf0AJolPWXvBsbgSojH8CuL4NS3l6NjVRgNnmAiBxtWfEf6fsrWYu9OYWvvu4n6Dxf2dhUPu9BGwUXH61scuIIOYlOTx/tR8uDNLD2urmA+svR3372qdYU/7WSeFLpfsWoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322291; c=relaxed/simple;
	bh=FkxFwxbtkX0dAUbTMCyunygwaislvnQT5Pikzr1hP2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=areuF7jVUDL+GZstfp090BRDnLNkXMtYWqD53Yh4BN7v+hcPEYDqUrIH2KOxiLfAHLFKy7xrcoK3MmTH2BeRewKTli/haQklTGtWJwCA5d/9ehMtKv/tycqpkHxdlVbFNxx01k/xBzH2DPBsbD68dKRLTlETnn5eyinLSkTaDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORPHxq/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C66C43390;
	Sun, 24 Mar 2024 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322290;
	bh=FkxFwxbtkX0dAUbTMCyunygwaislvnQT5Pikzr1hP2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORPHxq/KOkyUbKlOHwQ7jhjUhJU//iDRWT+UvjHByGuesUBceEuCp7CeFz5dHf6RB
	 lDqV95mCoNsfX6VXOpnjD+LoYXAEM8Yf+NjxIWSueY4bxWYus7zYkxarbwJh1xLnTd
	 umoassVc9pl/Yt67jUxs66Pb0UTV+Xal4kHDEcg8mgnU9i7Rps0usnHzlqKOzH8mES
	 uzFX5MlRTc0YqgbN8FnKVxyl1YYAG85D0z4fn965MEoubVt3GDcfApFRJQpCwnu4Xr
	 KG8QOGvupOEfvpLYCsZ3Z4UMTeVlsYcjs6k5c7U5DrvKUiJ91Rf1aSbd/+6V/k6OK0
	 1LdbNqHKaKOMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 373/451] f2fs: compress: fix to check compress flag w/ .i_sem lock
Date: Sun, 24 Mar 2024 19:10:49 -0400
Message-ID: <20240324231207.1351418-374-sashal@kernel.org>
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
index 96b59c87f30c7..be4cab941d299 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3967,16 +3967,20 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
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


