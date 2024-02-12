Return-Path: <linux-kernel+bounces-61937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8278518AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6531C21BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC17C3D0B5;
	Mon, 12 Feb 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2cu4EFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C853D0A9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754107; cv=none; b=qXePAiaR2WEC0D1NGP9A2A2Se1IA3P4c2GOojGVlPCSFtmS7KS6Jr0ktPupwNmVI6eGpyB+ePSkniKdXWu79yFBGFAE0Uf0ndvtjIWwgmxx1WeL8Lt5G5T9gJTLLMBdiblJfo4WQrb2Wg61lUsOezozYg5vF6IB01i3TxZA2tgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754107; c=relaxed/simple;
	bh=Ms3jETJiDb4EcBDYV1Y+i+GWoHhcisMI0xE0j1gpI2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEl6lgIbisSlfx4WYVTes1dNxmnOjhGPmBG84QnVR/Qe8F4nbycD9xPGSujYJprh+3NnwUyaTvkI4gQXHBxGH4IwgPdZmmLcJwBbPKPHmgQfGZUqShlCk86/SldSYXFd4fERF6x5PH2N2c8ilsHyCK1A6DG/GUQddTvbOv93WoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2cu4EFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDACC433F1;
	Mon, 12 Feb 2024 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707754105;
	bh=Ms3jETJiDb4EcBDYV1Y+i+GWoHhcisMI0xE0j1gpI2U=;
	h=From:To:Cc:Subject:Date:From;
	b=Y2cu4EFD9qnbjoBlUafM0p11mG6L9waqaPUOVxb3yX9hTK5vzLE9F8XWhDI6IcLmg
	 Tp4nhkaXMZnGfzGPa3ksH8oosIPoxTCPn9h0P1mQ38KhCX7faXRb+3ZGdm3ck0jmLN
	 5+8rkiYhkXB4jgwbr0iq5ni1uful1cNP/MKAi8vZFSBGPs6kw8uY+BQhYWHQ2rt217
	 RMs8GsQDU/BM2pcdXtCyJeBym5B/Zd60gUBjLWDLJayQD6E02/ahNkwrPnaS/W57fE
	 4/wjDkVOivyTfojCafXj/cFOs2MfI4qIw69QFGMs6+Jn7t+xOp8ncAiQACXa+6laJK
	 zhskNU2ffhURg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: compress: fix to check zstd compress level correctly in mount option
Date: Tue, 13 Feb 2024 00:08:18 +0800
Message-Id: <20240212160818.1020903-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs only support to config zstd compress level w/ a positive number due
to layout design, but since commit e0c1b49f5b67 ("lib: zstd: Upgrade to
latest upstream zstd version 1.4.10"), zstd supports negative compress
level, so that zstd_min_clevel() may return a negative number, then w/
below mount option, .compress_level can be configed w/ a negative number,
which is not allowed to f2fs, let's add check condition to avoid it.

mount -o compress_algorithm=zstd:4294967295 /dev/sdx /mnt/f2fs

Fixes: 00e120b5e4b5 ("f2fs: assign default compression level")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b718bebfaa1..a29b8e25a2ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -669,7 +669,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 #ifdef CONFIG_F2FS_FS_ZSTD
 static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 {
-	unsigned int level;
+	int level;
 	int len = 4;
 
 	if (strlen(str) == len) {
@@ -683,9 +683,15 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
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
2.40.1


