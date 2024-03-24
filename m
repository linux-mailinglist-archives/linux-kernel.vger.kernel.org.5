Return-Path: <linux-kernel+bounces-113452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC8888472
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2041C23D31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB71AF1A8;
	Sun, 24 Mar 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3gi80nz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A541AF186;
	Sun, 24 Mar 2024 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320254; cv=none; b=Nlu1ZMG9y/p6WQu3yUbmIU8voQD9zMVHxfosGXhofIgQpFnot4C5wY7vm97oGNFlVEKuplZsTd0nA3BgxgAz1XIS1iRo0Ud4r9j8uJ3X9oT8eQ7JbfhIfzS/CD24mbbIdbZijjHlkoxOzfZNKINMT6BUx/j9JN5Nn8o9wAvyVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320254; c=relaxed/simple;
	bh=sp62AGwPN9jC2NSCgVXV9R8i9u5AyrXitDQKHzCoWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6CzL7Q4b/P0ogjN+SWtUzhwZrJ97/gMUazYsO7wGHDw8glr2pYpdX9qTrMpLMZFy9eK4InGfadOFsjDDfDxEfP5eevDV6Lvt3MV951vNj/BLsBn5occGNetAYsoQ+KxaW6fedf1T/2DJWjoqw9PoK1TOrEckdKzm9ZFb0mJJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3gi80nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C4C433A6;
	Sun, 24 Mar 2024 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320253;
	bh=sp62AGwPN9jC2NSCgVXV9R8i9u5AyrXitDQKHzCoWno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3gi80nzoRe6UIAGg6AEsgV2GS9ZWOhkNoIoq1pV4ykUW48/rfMlkqiHZjO0muHyD
	 H3wDegFKbMKvbYzWtM4LBZtvslUWI6euzfh121G2V5afQLr6m0hnPdsrsyCTyx0QlM
	 Wcq2fS8zHBJOSylSX3JzI8jhO6ET8nbSvcPIZzgECCCTSnu86Q7mG6On5hBYPB74kn
	 ya1OJo915O5SR9s2gTtG/Q4eF9xr5diCbNEOY2xdvwyLUi5SE4Fu625LVzDTxvqmyr
	 GB4wp7Ajcr77cdqwde045NKE7VVBY6N8pXyusBkHcjTKETzLV5THZndfj0435uJbgy
	 DuQiCMoB5/2Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 561/715] f2fs: compress: fix to check unreleased compressed cluster
Date: Sun, 24 Mar 2024 18:32:20 -0400
Message-ID: <20240324223455.1342824-562-sashal@kernel.org>
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
index b58ab1157b7ef..941e02c0953cc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3624,7 +3624,13 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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
@@ -3633,6 +3639,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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


