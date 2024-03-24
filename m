Return-Path: <linux-kernel+bounces-115727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414D88974C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D35A297ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8CB362977;
	Mon, 25 Mar 2024 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+32kRtW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAF1EFFE3;
	Sun, 24 Mar 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321801; cv=none; b=oeCMZYBsCfCnFtMNSKg7toB/HQEbej1lIp7aE98RadDqlrmr9KeBGU2E2wBfO/jTBFvLTLhvxELJ4B2kE5d5HAZNWtGyocHLiLnlWTebAHHncCTeNRlSoiuITYCfn0pZ2PfA2T/JOdi5Sz6NhS9c/eASRiBu6UMIlVxiwIZUFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321801; c=relaxed/simple;
	bh=OxTIR7rV/5rT/5PypXbolzVwCAZmqOoV4J85b4kmV8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhwU86BdRpmQJwNhiFts33xV1PP5zOF32l9st4jEM3e9wRcJNC2wejD3n5fxy1YZ5g0gYWNCTHDD2/WFksRH7QaXRHLUJzSqLVTcC3B4cmqD5Qwqy5tEx4P2PynWcXIcUU/ePFAKg0BLJPLHEOMCdhOsLN9B6jV6dud4Uf/siBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+32kRtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B58C433F1;
	Sun, 24 Mar 2024 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321801;
	bh=OxTIR7rV/5rT/5PypXbolzVwCAZmqOoV4J85b4kmV8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+32kRtWYV9ImjoA+Pd5v/DbukaqDnDRy0uNPKFeH1gh7xZXC3M5NLDt9tS0o+zBR
	 1I6C4Za16qMI4oTC15GLjr7Ju8ZgaBLbpOfAmyFXPKMjngLrNhdTKDdhk8p6t9xYXH
	 txiqZNMkfuP1rFytTkfXeK+dZFLkaP9XIrc9nOfBCNrC43HNbNqa2WDpcfQXwpQ4Ko
	 vgkikpkDRK3lSZkFoz+ngaXIz9o0XTl1dKhSCVIDJOGQ0ce5YsF3iijurORXZlaOyN
	 suS2DWXDyuCNCZysGlM10exSV+PDXnTt1/fPkymIdvbHhQZemPR04IU7Ky3rcUQIhf
	 ny5V0IFEukEfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 529/638] f2fs: compress: fix to check zstd compress level correctly in mount option
Date: Sun, 24 Mar 2024 18:59:26 -0400
Message-ID: <20240324230116.1348576-530-sashal@kernel.org>
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
index d0a659b906656..76d94889e45cd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -648,7 +648,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 #ifdef CONFIG_F2FS_FS_ZSTD
 static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 {
-	unsigned int level;
+	int level;
 	int len = 4;
 
 	if (strlen(str) == len) {
@@ -662,9 +662,15 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
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


