Return-Path: <linux-kernel+bounces-113915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D962888757
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976661F23E51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D8D212574;
	Sun, 24 Mar 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pErq8HCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABC43AB4;
	Sun, 24 Mar 2024 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321008; cv=none; b=m2Ahxn4FlXbbxd0Ymm2s7JkqTlJWaYTrYzIZAB7Q/a7VNEntDAQ2u+bSH1Ho0SwqYt2lZWr/DAd7yNDSyBibHx7NhLQXMqbEf661vnUaSnXdNiLh2FnYdkSr+Ti+4LxwPpf8oKYrbA1dey6m4po//VCplWEnBNArH0GJwmaS0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321008; c=relaxed/simple;
	bh=YwUHoIoI+YU3f9pCODPkvt6pbROHpbZYcDXdvhp8+Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cf4yWl4yFm6CYMzzjR8rqvcQwonRdThCnSLdGZIUoD/NJHZfvJ2JrZ26VL6rmb/Y/fit9rekVvI3DLRI/9DtKeqau1wM3wHosNeRFcFx/48hnEEPJYaEbOWLNls/UN9fect0A5u2v41iHkZfXYhrdiMVFR2gx03XWp3KZ82lVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pErq8HCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BE2C43390;
	Sun, 24 Mar 2024 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321006;
	bh=YwUHoIoI+YU3f9pCODPkvt6pbROHpbZYcDXdvhp8+Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pErq8HCoPyFxWMA8MyXZmhARMFyyt+fc8amiZdtMCBgoHnzL7AOXbYYXFm2QKZjjE
	 MD7JbRA/PIbU8Mjo33NauuvtO0v0dbly/P2m7283poP3Zsq47EwxSyAOw9kPyOMidI
	 HWAPJaFhnvgHTJQ/fjauxNv9xyHQPgl5I/ltc5/PRDzgI9ZUdWprH24t1C8b/pm2TY
	 2QehFpm/J9vKkdvoQsEnNDIPjoXNGlVkHYixOz6W6nxssXgCLCBPfzZXM/xXQNjdZf
	 3mHTG0tRnwB8QMO0hRe4wLSw2yEMcFMDgiWmWuFvM7QF6rWwVb92XpZo/GI2DoIsPM
	 YljLfNkdIM+VA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 569/713] f2fs: compress: fix to check unreleased compressed cluster
Date: Sun, 24 Mar 2024 18:44:55 -0400
Message-ID: <20240324224720.1345309-570-sashal@kernel.org>
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
index a05781e708d66..01b6295341918 100644
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


