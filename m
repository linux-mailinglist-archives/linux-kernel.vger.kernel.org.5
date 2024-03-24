Return-Path: <linux-kernel+bounces-113474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FAE88849C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B801C23F79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503461B4524;
	Sun, 24 Mar 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZurLnNWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022C1B450A;
	Sun, 24 Mar 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320275; cv=none; b=g9VdYShftyFp3iID+FlppvfheAopbhZstELdeLPXF6Dn47jGOICv5ZyzqDSdsaY0JLPbHrWCXNezVNsnBBATN9IFz6V9s5eooyA+5I2962OJE8xzeZFV+0GXjVa0JVvE1VqCVo+66SKh3Y5wG11UQe2SOUe3Qv5VEA/PUqHnO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320275; c=relaxed/simple;
	bh=Cf9FS8dK+OhDjAn/jaSTG4fEILd5Xjj77aPsV2aCYBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDtqvxYBo3reVcmZM6ihzy8rss3zlTf2H9trt1fAv0BC6MhHC6KNKs368y8pbmnL/WReq06z6ROnAvuHQGaUUj6kZQzPWAhQr8i2cCoTXxTYmv1qA81Z772O/NajcTIuhEd76WkHrQNVBN1hXYDkrzdVcso9BL9zMsuDjUCZ4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZurLnNWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772D3C433C7;
	Sun, 24 Mar 2024 22:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320275;
	bh=Cf9FS8dK+OhDjAn/jaSTG4fEILd5Xjj77aPsV2aCYBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZurLnNWtvG0xA6NwQp51qhOGgyafoQ3/V+LU8Hmv2q4D1rgmYlc5a88sCjUiz5tOG
	 90AiUnjyWLg/wn/v6f76eYCoz7rsnoZklNJ6pDMT1456HeqKkTF0SZi4hsiLriHENd
	 /lUFcNSGjHt42iShymzb23Qt2lBMxb2g6uiSlnCmzFWU6QUrCga48cxsZEAzMDS9nq
	 jaDacQR5eg6cePl3uYVP8mlppKFrHJbVqMt+1e/ly/GSGOM2Mkng2zxsFH5XtXtZdd
	 hcVjshDMaBIFP4ku/KWGgzVD31Nls9kkCSu46pZoIyxWHQcj3inf+R7uc8NVs9QFMQ
	 OXwYBWERI5jXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 583/715] f2fs: fix to use correct segment type in f2fs_allocate_data_block()
Date: Sun, 24 Mar 2024 18:32:42 -0400
Message-ID: <20240324223455.1342824-584-sashal@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 7324858237829733dec9c670170df2377c5ca6e2 ]

@type in f2fs_allocate_data_block() indicates log header's type, it
can be CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC, rather than
type of data/node, however IS_DATASEG()/IS_NODESEG() only accept later
one, fix it.

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ef5b3848426b0..77409e3665954 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3491,12 +3491,12 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
-	if (IS_DATASEG(type))
+	if (IS_DATASEG(curseg->seg_type))
 		atomic64_inc(&sbi->allocated_data_blocks);
 
 	up_write(&sit_i->sentry_lock);
 
-	if (page && IS_NODESEG(type)) {
+	if (page && IS_NODESEG(curseg->seg_type)) {
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
 		f2fs_inode_chksum_set(sbi, page);
-- 
2.43.0


