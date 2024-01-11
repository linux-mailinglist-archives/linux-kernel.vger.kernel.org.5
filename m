Return-Path: <linux-kernel+bounces-23106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EC082A7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472541F270C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426463C7;
	Thu, 11 Jan 2024 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGSnIZta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB16122
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C729C433C7;
	Thu, 11 Jan 2024 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704955339;
	bh=MgTBqfpW4ceY7D/ZgQAK+Zn24N05AWu5xNXVmlv4Wws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGSnIZtanogh2vTawgkVs54ULVkfJNrwKWHxHZO1GhBgblXF6lpZFbS7qZfLcbB5w
	 mYQLbUzmtUCliNZKpMHlBTErJC2m2vMRMLUoI02YCi8vuxu4JOyYbER7o6bZ2Ag+so
	 +0h9lMJN5+Lwiz98J9oHs+59IlADjoAjLSxz861Ur97rIyhBqt24wLUUjPAfBZMD7B
	 eEy6dcUOj7vxNeEMDJKQg9PNqNClf5BN/+64oeqFXrPy037EPFJPOVcugt8Z8CxqmK
	 w3QzsTCUWo4oJ9xfy4UMhJJcIeNVuN0Rdwf/xcHMCzdqU8REdbZ0zrdyotHQNE2pFI
	 kEElJyPKijATw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 3/6] f2fs: compress: fix to check unreleased compressed cluster
Date: Thu, 11 Jan 2024 14:42:05 +0800
Message-Id: <20240111064208.2969599-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240111064208.2969599-1-chao@kernel.org>
References: <20240111064208.2969599-1-chao@kernel.org>
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
v4:
- merge check condition suggested by Daeho.
 fs/f2fs/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 026d05a7edd8..80d9c4c096f0 100644
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
@@ -3633,6 +3639,9 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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


