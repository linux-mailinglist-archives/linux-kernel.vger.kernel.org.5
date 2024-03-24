Return-Path: <linux-kernel+bounces-114615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791D889087
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD191F2B4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382432A2B43;
	Sun, 24 Mar 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg1k6JVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58814D459;
	Sun, 24 Mar 2024 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322273; cv=none; b=PZita1rKLVQD5Fp1oDqlDX4yXsJLDMW+9i0ZEn8GkSWVHzUoyfuzfuhkTX1bNLs7p57UolksxOzPbuYzdal0gxzxEofrVpIhBuY+A0ZZgnbjcoj5US2MT9HG8i1BZ+Fksk05aL3ydVt/WdFJgeJLfnbkOX477aAQrtPAe/KKgxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322273; c=relaxed/simple;
	bh=DsiknXDM5Y1398/MnTp5CbQ7kEr6WClKDUymDNkff1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNhTSLfIPBIG7OXeObHPU/UcfZ1Iq/QTutiiaLWKIVZg8pm9wGm8vq4S0ekN0vzYKzhgbIvDwtZKj5RtRBD88o252NRsiMAxBf8I4ukHkJbT/FAowEaYZv++kpKU/NplBCKdDcuSBdV4UKhzwltcoqC3rKNHj3olQkSuI2b6Nu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg1k6JVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE0DC433C7;
	Sun, 24 Mar 2024 23:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322272;
	bh=DsiknXDM5Y1398/MnTp5CbQ7kEr6WClKDUymDNkff1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eg1k6JVh6eNDeOY5ZkZ3zoLAvle8/xM63PZKDSIQO/QTAQDnnZhSub1gWOZgpSUYd
	 60u1borc5oSMVfEdKfW+z1zNgjSTp0SNwGD2Hk4vKUgiJy5GwwU2qMawapyd9j4iTN
	 WDLoVvgRs7wDZQnpkvMXWN4lWZk6WxKZCmLHUAgGLhSXcXV6Rwd8dhjS9e1ZmnDuHa
	 DAPZ0UohvqHactAzt/5vdDs1rT7NqUg4WnC+WQh3069dfslvaQOhHyt0jpRPgsUoTp
	 YN1Ezdzr8cprESsqXvO1r945zCQSdivenFSLXQss4L3C4alTEJxPFED/gsY7nZhpnY
	 vTa0SwD1uy2GQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 355/451] f2fs: compress: fix to check unreleased compressed cluster
Date: Sun, 24 Mar 2024 19:10:31 -0400
Message-ID: <20240324231207.1351418-356-sashal@kernel.org>
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

From: Sheng Yong <shengyong@oppo.com>

[ Upstream commit eb8fbaa53374e0a2d4381190abfe708481517bbb ]

Compressed cluster may not be released due to we can fail in
release_compress_blocks(), fix to handle reserved compressed
cluster correctly in reserve_compress_blocks().

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 46e4960a9dcf7..6c9f03e3be8e9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3609,7 +3609,13 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				goto next;
 			}
 
-			if (__is_valid_data_blkaddr(blkaddr)) {
+			/*
+			 * compressed cluster was not released due to it
+			 * fails in release_compress_blocks(), so NEW_ADDR
+			 * is a possible case.
+			 */
+			if (blkaddr == NEW_ADDR ||
+				__is_valid_data_blkaddr(blkaddr)) {
 				compr_blocks++;
 				continue;
 			}
@@ -3619,6 +3625,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		}
 
 		reserved = cluster_size - compr_blocks;
+
+		/* for the case all blocks in cluster were reserved */
+		if (reserved == 1)
+			goto next;
+
 		ret = inc_valid_block_count(sbi, dn->inode, &reserved);
 		if (ret)
 			return ret;
-- 
2.43.0


