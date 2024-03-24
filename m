Return-Path: <linux-kernel+bounces-114384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82163888A26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5DA290C06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76272174965;
	Sun, 24 Mar 2024 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOKISH5D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963413DB9A;
	Sun, 24 Mar 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321785; cv=none; b=sZM+MVpdInjcpWkvV4zZ2SO9RvyQK5nIav9XyKbuTNI0JSeHjxLChtljYO8SiHgG3szY2Poz2eaX6M8mhbwYXeHhxG0/Qn+VtvnC09Muq5jTPp3tCKDrYiGNhJ1YPDzjbFItHhGc6budkjOIkOJgSGS+xwzc369R8goApkV0IvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321785; c=relaxed/simple;
	bh=20v7p8yXnB6NUZQzw377e8P7YW4lCPE96iNF/FxfLIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJmtnDRGbP6VrltxTYXUykTa/5V7JST9Zstf6SzAoYIJntS+Y5UM7sF/UVxT7J6s9F0H7vDxheaMS5JG4nmriNgez6btg8U7bXSr3YdRDJ/KM+goswMhox6LMhGJMc0GQwyWINZc5YLCz/Mu1C1EN3ab/XVKFnd0dQc/fzV2C8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOKISH5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18457C433C7;
	Sun, 24 Mar 2024 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321783;
	bh=20v7p8yXnB6NUZQzw377e8P7YW4lCPE96iNF/FxfLIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOKISH5D6PZgSi6ndlNmofRRYXHCMMro9oTsAp8pk6lwLeCwLvyjVq43uNcv9IFur
	 X2pkMNjbQKNIr6p7pamuXH8PCbcBYPEU7sPe52INCLQvtb5Lvvb3L6pshXQxFZfq2L
	 sTcWxUqRxeVLHYhjBVlvK0pWUGDMhJ0n3qSsMuZfnDyziCpE46C61yuLMAovDb+WaK
	 5ZYu4pbDfQtPpKEmSWKTGy39HwCpICCB5a9H31sNdg/FIeYrW0eeAozVkQQijm+ehm
	 3qStu5vpfC28snzU9BNII3e/pDSKxUsHkI/1g0UHNK5q7VoDJTVtgl0lpFHU/j6POg
	 xkiKePlwbP/oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 511/638] f2fs: compress: fix to check unreleased compressed cluster
Date: Sun, 24 Mar 2024 18:59:08 -0400
Message-ID: <20240324230116.1348576-512-sashal@kernel.org>
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
index dcf2d926ab59d..436a59d33c923 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3631,7 +3631,13 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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
@@ -3641,6 +3647,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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


