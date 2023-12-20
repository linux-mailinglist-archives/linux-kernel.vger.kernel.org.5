Return-Path: <linux-kernel+bounces-7014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348981A087
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B681C21185
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B83D0B2;
	Wed, 20 Dec 2023 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL7AZ7SR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343E3B2B3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8229AC433C9;
	Wed, 20 Dec 2023 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080786;
	bh=v4LG7qKqe/M+w+R9MpQa9X4bJKEDltOmx7SXeOQu0+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OL7AZ7SRexIAReodySDXML3iH2ENLvevRKCZBxFla/XCSj4J9zJLC1wtYmtdpbRlk
	 gw89uKyBFqkPsyV4hoNrqupk4BsEgh5LsguNh4j3c2o21x/mEzvpCvKSmmqQdwl0B1
	 xvVuzC23KncXqWNCUTWuY1Qa9RzkARpusQnqsCPKN1dYS4LT/8CzWncLobPQYMEfMJ
	 54ptx4MbXrSvaUFIXL6OZoAkmy/1YRQYAYX5vKtZxl87pWshX/cXjQsdNxZhlQblsB
	 BuKQ+8HAbPp+PHB/iQ9snsIiVZLFvg45E3XPIGxrhOlpVOS6tjB7aqL9aMNHS9phbn
	 50aZGm6QlwLDA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/6] f2fs: compress: fix to check unreleased compressed cluster
Date: Wed, 20 Dec 2023 21:59:31 +0800
Message-Id: <20231220135934.3471407-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220135934.3471407-1-chao@kernel.org>
References: <20231220135934.3471407-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Yong <shengyong@oppo.com>

Compressed cluster may not be released due to we can fail in
release_compress_blocks(), fix to handle reserved compressed
cluster correctly in reserve_compress_blocks().

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c5e681fc1d58..c200b4c81baf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3643,6 +3643,15 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				goto next;
 			}
 
+			/*
+			 * compressed cluster was not released due to
+			 * it fails in release_compress_blocks().
+			 */
+			if (blkaddr == NEW_ADDR) {
+				compr_blocks++;
+				continue;
+			}
+
 			if (__is_valid_data_blkaddr(blkaddr)) {
 				compr_blocks++;
 				continue;
@@ -3652,6 +3661,9 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		}
 
 		reserved = cluster_size - compr_blocks;
+		if (!reserved)
+			goto next;
+
 		ret = inc_valid_block_count(sbi, dn->inode, &reserved);
 		if (ret)
 			return ret;
-- 
2.40.1


