Return-Path: <linux-kernel+bounces-113466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344588848E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF821F2522D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2613B5BD;
	Sun, 24 Mar 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGnh/Nvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BB13B59D;
	Sun, 24 Mar 2024 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320267; cv=none; b=NcYNTAkbGVZoS+q0DqRCDVAWlPtCRNuEDbQo3LgzEwOFGSXcuXD/9bCwgKnRAS0fk5RkZZgL6AMmRq8SLjZPzzgWLuSyfz9wX0C+siO46q5SgoLIQR11f+s/XzHnCR17oWen6/vin/sfjpyySbgOL2g8ShDI9duIeJyYl1CdJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320267; c=relaxed/simple;
	bh=3nySBuCGCRUEtcDUg92Tm+c/LXym3mQM1piZ0mRIwOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CElkEVtlTNB698LiUU6Ko42p9fYtpJXijeAecP34hcv18F6WQgl/UR/ZCJIRWj2R2ityWgJ6xdeFaRFHcSH4uooBNkyRI+qc4XtczuVx5SLHSzt6xJRBZ16SJf2OFDF8zVRs9ISSOdpBCbgAN/66gLMDC2DR1qtxV4ZuAVzx9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGnh/Nvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853F3C433F1;
	Sun, 24 Mar 2024 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320267;
	bh=3nySBuCGCRUEtcDUg92Tm+c/LXym3mQM1piZ0mRIwOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGnh/Nvg8/Jxc9D1bydOHCnaYePz7kI7Qqr/+44z7n9Kum7pNvtGVxJEyp3uqiC0E
	 cEtGs7fz7g4Id1CUjUxTh5w55bPam4hBZTfcd5VTDh+9qXlMjvZfgeqKD1XR4KS+6Q
	 BfnKJZv9r3ZNdHJl8v7RUtiOIz7jUov+OTMVBBOia9yUSrSfxSnFUvYodSiQVjBW5g
	 a790TlMkCZIuatQBLK9xAk/3iVQwZoXELvBv0yrJJ+SSGwhN6Tob4qSoss2x1g9DSx
	 k+Uuh/zdwrLPCNeH+q6MBgP7pz93KDMZ4lPBCMg64XKPb9FeFmSc6muyryKaY1Zsj5
	 FUk6D3MyPKf2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 575/715] f2fs: compress: fix to check zstd compress level correctly in mount option
Date: Sun, 24 Mar 2024 18:32:34 -0400
Message-ID: <20240324223455.1342824-576-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 18cc4829f7e82..e64ce5abcdf44 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -663,7 +663,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 #ifdef CONFIG_F2FS_FS_ZSTD
 static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 {
-	unsigned int level;
+	int level;
 	int len = 4;
 
 	if (strlen(str) == len) {
@@ -677,9 +677,15 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
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


