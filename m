Return-Path: <linux-kernel+bounces-116091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFD8889933
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E02A6350
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAEE3A6CC7;
	Mon, 25 Mar 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOyQCUI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7764178892;
	Sun, 24 Mar 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323556; cv=none; b=XGp3YVEAncCfxXMxU2g5Oz4SJVrHDwsRTIoWKobdgLGwailtEuhllusGep9KJd7GQ9RdKSuq3/FF7Uo6Yty4DbDxAK17iAZC81VpgXKQ6p8TVr9mwV1GLeMughGNgfT86orMAvnEZFljCT3rsi8kpYPamoVa2CpR/wpyj9L9VEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323556; c=relaxed/simple;
	bh=lZFfoPXFBxOkB7PgjL8OTievXiEPGECdOK6yZNTcPk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae4Xrip3AWIo/Fnj4Ohj6/wr5vyyTe9LhbYbZFlbbQL4v3b4MzDYnGfzdB08Pygu1o9wPeKG7gvODTzo86ScBcJiVDrtCgBUSydYoXiTNsLxxa6aeJA7KBYHCgs7O9VfOkipiKZvQ2PQc34soAW0f1gIddfdkDvmxs9NHwBV8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOyQCUI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ABAC433A6;
	Sun, 24 Mar 2024 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323555;
	bh=lZFfoPXFBxOkB7PgjL8OTievXiEPGECdOK6yZNTcPk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOyQCUI0XkoQ/B5dsTf2+zPHBaelNs9hw1O2pkMgsr7vItMqt4r5u7HpCbkrCsUMH
	 JZp57RSobtpyi/PFppyaZDJccs4lifHCYtdvzuIwsMT0SjGDaWVUaz7RYPghQulqfD
	 tf6d6BAUFT/IiYtOCb8Z+ew9Woc4n1sxIgQY0h0dJVD0xq4jIK/VJCOHWYvQ8WvPFw
	 s52Zxh/1E547VCfU1B+F2eed0im48SblIXmVHRqpm9Rmxk0dfcx0r2Dq3y19zzCJR3
	 J7xK/InNXN3sKhZgQweEh8XVnmrO01vESYPvuNnjHxOeHsxMXNZMCtBLv7tQNLzzsd
	 CLyYcxHlYiaNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 262/317] f2fs: compress: fix to check unreleased compressed cluster
Date: Sun, 24 Mar 2024 19:34:02 -0400
Message-ID: <20240324233458.1352854-263-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 489854d841e75..bab83ce4fe091 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3566,7 +3566,13 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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
@@ -3576,6 +3582,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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


