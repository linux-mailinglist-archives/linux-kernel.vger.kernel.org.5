Return-Path: <linux-kernel+bounces-25188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6025782C94B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC981F23E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0315DFBF6;
	Sat, 13 Jan 2024 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syf/atgs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA50F9EB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 03:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78372C43330;
	Sat, 13 Jan 2024 03:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705118245;
	bh=RQ/5bYxkS3MyNG96Qf/wOP3mhXKTcQQqJW6nVAGR5yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syf/atgsKYI3WxMH06ywnV/Te/ggAxXMNSL4DKHuokLI71CB4OwWpBcIULcF+qcU2
	 fe28JdWhS0wGi29VFqMPcUzHiCDGofP9ZlpJXuZ3japDp8q3LYxzfEBK7FJBQUfkoP
	 9SzmGPqL9uyjV3Sa+gY1NAMoNGxfugggb5ubfC7rVxEDAedZP3dvjjj0IdiLzrOmFk
	 HOxJnBIkX+PAloeuTF9rtEBs7BBCGY9VnUUoH8KBtE4oqTzfmAQ3ulQCvLdMou6hYE
	 hL8fIb/Yc39UIsnzqjNcHj114X1NpTDJq1vNLvFFQyIUF0AhiIcS0x+XA5HesD/Klb
	 2PZr3VULR85Pw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v5 3/6] f2fs: compress: fix to check unreleased compressed cluster
Date: Sat, 13 Jan 2024 03:41:29 +0800
Message-Id: <20240112194132.25637-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240112194132.25637-1-chao@kernel.org>
References: <20240112194132.25637-1-chao@kernel.org>
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
v5:
- fix wrong condition pointed out by Daeho.
 fs/f2fs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 026d05a7edd8..4aef2310395f 100644
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
2.40.1


