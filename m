Return-Path: <linux-kernel+bounces-113922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A487B888762
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A091F25CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913CD214860;
	Sun, 24 Mar 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9fI+Rmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F814A61C;
	Sun, 24 Mar 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321025; cv=none; b=piNWvI2hEWip72lKTlXoSYL3zGzVuaTiIKwAJY9YK90IShu5FVOqVYv6+uBATtFzvodmjth34BCpG1wwdjlESY7P9IWFYNEOghtZONaOSbg3OPy/8bRoYLMh+u7FZ18abLFD/55ysKyx2C9za9gExzicVhfVx6B92gZ/Y0jKBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321025; c=relaxed/simple;
	bh=perYTdueoSfw7UTcDcRUsae0k1dNzWNsx1L/dSUmIQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbnwtBFvljSeIIAmUZa9ZYx62oguUT3JTX9Ume44dYqL7nbgWqjZ4WJHpId1MqQ4DXQb1uIFf2aC8i04c7DHdIwIYb5vEZaE0uTZVl9F5yWSYegl6sfU3p8c4CugB6vAdGvz9phohR8EPNpgJXy1vCLAFDzSmS4ytQmO7l6FX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9fI+Rmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADB3C43390;
	Sun, 24 Mar 2024 22:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321024;
	bh=perYTdueoSfw7UTcDcRUsae0k1dNzWNsx1L/dSUmIQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9fI+RmcLPu3IfyZfELcpo4nXwHUH7+Y2ekBxlpJYYGg3ecVyTxfG+P1huy2SJH6g
	 atHC0f/UQ0O2qi3fgR0zeshtXV47L4sHiLNyO8Mv1sqsdxMmOish8WpYemVNu5AUfK
	 sE3alzkG7zkH4glvr0+Abzm+X/98wZmrhN3tls+hWbG/YgLPD7mZlJ0uV3S6GIl/2u
	 fZkepSL9jxhubo/Z30J2Shn63sl9HFLFS7FvxBqjpAf3dcuDoYzokB/LPb5RZQwBJm
	 Y/p6ESQti1hRYWIUz3QthwJ9Zoq/DklEbdVakm/2RCn0uqr7HJBNfcBbHoW/yYXY5c
	 ftzv7uZSqOQag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 587/713] f2fs: compress: fix to check zstd compress level correctly in mount option
Date: Sun, 24 Mar 2024 18:45:13 -0400
Message-ID: <20240324224720.1345309-588-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index b0d6a643c9ef1..655cfadc92457 100644
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


