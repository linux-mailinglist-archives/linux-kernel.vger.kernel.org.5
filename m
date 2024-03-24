Return-Path: <linux-kernel+bounces-115979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB3B8898FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD85295519
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650C1396665;
	Mon, 25 Mar 2024 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRDWy+2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A34548EC;
	Sun, 24 Mar 2024 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322286; cv=none; b=TnbhVKNq5e2Ayf3JDnsuFmL0X8hUckp2a/HzTBr3gibOcmKlfD6l/pMCUboQGtPDlPx9hwRFlz6guajWJxYHzSKpDf22JbUWMQbv5oHCGv3iYsQ5MHpJ16CjeNqdnC1+BxmKb7ChH9pXA5ePT/fEenxfAF9OX4gOtY/n6CkTriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322286; c=relaxed/simple;
	bh=aOtOQZUuSnr0lLTRQxgN4glJphn+Zqcuou6Khw4hzys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFPV1sLPPHq00NAWQUCyw5j2pRn41RydgyclAhSNEuT0Vg5TE/whzwymR4w/o+elO8J7OglhqTxK8iu4GUm6aWoUDU8Q/lzez7n1Udfbz6g9Bu6yzNxg22730KBEQ38E8PnWkva2Vaa5RsjC3GhRc45zXWp4l4hMpwMIatOWLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRDWy+2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A66C433F1;
	Sun, 24 Mar 2024 23:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322286;
	bh=aOtOQZUuSnr0lLTRQxgN4glJphn+Zqcuou6Khw4hzys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRDWy+2y1EUqJIls0jBQOBsj9l6b0iAInF8/JuvpVBYI39LsJDzlVX2+6Zjaoxnfs
	 DZ/YJNTsHaNJkSconS+mbylOhCJ7wADGjuGdPeR5zkT7ZWe6x+RrdhxqzwbmidRJK3
	 siH61iCq2g2PzoCVuZ9XSbs9arLZ2vC2yV0KzV1BtYdcp1Ub/NAImGQXCVgU5py4JR
	 QWN9TBYyGGArGoZ3IxIrJRSvl5uNmBihHYXB/rGdHgE7mCq2MT2GVMR7Vcz5lu+cW+
	 ReIHx3ZzT/iX80gCTu2phFlduqKejbh5lQ48t9pkLcYSJy73+IH5IUMOi3Vy1jz05N
	 2Tn9+xpYkVqpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 369/451] f2fs: compress: fix to check zstd compress level correctly in mount option
Date: Sun, 24 Mar 2024 19:10:45 -0400
Message-ID: <20240324231207.1351418-370-sashal@kernel.org>
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

[ Upstream commit e39602da752cd1d0462e3fa04074146f6f2803f6 ]

f2fs only support to config zstd compress level w/ a positive number due
to layout design, but since commit e0c1b49f5b67 ("lib: zstd: Upgrade to
latest upstream zstd version 1.4.10"), zstd supports negative compress
level, so that zstd_min_clevel() may return a negative number, then w/
below mount option, .compress_level can be configed w/ a negative number,
which is not allowed to f2fs, let's add check condition to avoid it.

mount -o compress_algorithm=zstd:4294967295 /dev/sdx /mnt/f2fs

Fixes: 00e120b5e4b5 ("f2fs: assign default compression level")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0c0d0671febea..c529ce5d986cc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -649,7 +649,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 #ifdef CONFIG_F2FS_FS_ZSTD
 static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 {
-	unsigned int level;
+	int level;
 	int len = 4;
 
 	if (strlen(str) == len) {
@@ -663,9 +663,15 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 		f2fs_info(sbi, "wrong format, e.g. <alg_name>:<compr_level>");
 		return -EINVAL;
 	}
-	if (kstrtouint(str + 1, 10, &level))
+	if (kstrtoint(str + 1, 10, &level))
 		return -EINVAL;
 
+	/* f2fs does not support negative compress level now */
+	if (level < 0) {
+		f2fs_info(sbi, "do not support negative compress level: %d", level);
+		return -ERANGE;
+	}
+
 	if (!f2fs_is_compress_level_valid(COMPRESS_ZSTD, level)) {
 		f2fs_info(sbi, "invalid zstd compress level: %d", level);
 		return -EINVAL;
-- 
2.43.0


