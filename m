Return-Path: <linux-kernel+bounces-12705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36981F924
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56E3B236C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF5101F3;
	Thu, 28 Dec 2023 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3UmvBck"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F69101DE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90591C433C9;
	Thu, 28 Dec 2023 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703773928;
	bh=PlqlUk5bd+3fk4WKcXVwPKIXLZLKGpamNP0JtbEVizc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3UmvBckldbFBMtcyi3xBTx28VUw1mf8I7YeImoXPWLb1YsrbuwkMEUL8dHxnC/QH
	 tUu+7M+5kN1T0M4IQWEo3M7Y31SJeeLGc4v5jIjFOLbTPH0LcGSA8fbhA57yX4bn2f
	 vaIzuIfnzXCGIZoKJiqwpLSdjxsv86uofKZ6zMVLqFa1II3ycsn+HRNzIc+LI3tY8L
	 PuQR6tWdMqErdbCa9J1nfYVRfE9OTooB4PYZO8hoXRRvie7f3FIJxJJcBH7hR+ANRD
	 v2/3CMDmlDZy4h6wHZhIa73FxBCl0vCtSSQV8y6ppQlUyHejH+382f2nMTCExoHAhP
	 inT/5EXcK82aA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/6] f2fs: compress: fix to check unreleased compressed cluster
Date: Thu, 28 Dec 2023 22:31:49 +0800
Message-Id: <20231228143152.1543509-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228143152.1543509-1-chao@kernel.org>
References: <20231228143152.1543509-1-chao@kernel.org>
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
index 026d05a7edd8..782ae3be48f6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3624,6 +3624,15 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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
@@ -3633,6 +3642,9 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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


