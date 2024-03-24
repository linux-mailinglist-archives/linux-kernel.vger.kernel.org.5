Return-Path: <linux-kernel+bounces-115731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCBC88974E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD59A1C2D4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90B7361341;
	Mon, 25 Mar 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYayPjI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615822197C8;
	Sun, 24 Mar 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321809; cv=none; b=qJqKoEZ5ggWlB97Uql0kkvLkac3V62pwdkAh0tQpOYFFCVXrtRjf4lYPftGGtTSMG4hJLRDyq4lyC3RbqCnbIRRAN3KQWl/UG17bVCKc8gNOiCId/gxBRHe/xljBZs8l4Q5Mq58W/gLEj3aDH15JrZCfkvSPrNSPMbvFGSQnsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321809; c=relaxed/simple;
	bh=nEDO/0XGTNtem6HpiNI4+3w9EGHAwaFyTBbnA6UkIn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEF0zyKyDK9xhZ+Ux3HU/KcNu7w+2Ebe7ZqvZWUJLZMEzUpbFSzo5l6f8zRV4Fj+ec9TrP5Sdw+OlLTCxpD3LecB/IN6kXCIEZEZylkfFpCS2/GXULYhWrzQT2C5LzTF4qkAb9gjhJSuOUO6S237eUIJ5AXHowXMSUyEPLb3Ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYayPjI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F66EC433C7;
	Sun, 24 Mar 2024 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321809;
	bh=nEDO/0XGTNtem6HpiNI4+3w9EGHAwaFyTBbnA6UkIn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYayPjI8POdFSItwQJE4C/a5X7FMRAHoK+ufgMyhaa/ctwvJGIsnnCVJ8xNg2/Gqc
	 UgYNCM/z6z2krVrAEwrPpZMbyTxQSKGBI3M/7WS+fUW5uJm61LJyuFhqel0Provm5L
	 g6N6TR6itWUzujRE7npFM1M6qXStvJS9mxKvxQsyp6QKlgYiHQchCprD+ZdC4mTHRg
	 bZjkZBemkAh1U+IFwAPLo7woOmx0A9nuAV1onAqYafHBzcB8XKMs4Lj9/wlqJLZeFr
	 44CISWLsUEzUvViRvSFAomx2ozr8hvkNmO0paMv4HnS1YexRkBqDlWDTOR6dmMW70Z
	 vGlneU2FZ3wbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 537/638] f2fs: fix to use correct segment type in f2fs_allocate_data_block()
Date: Sun, 24 Mar 2024 18:59:34 -0400
Message-ID: <20240324230116.1348576-538-sashal@kernel.org>
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
index e77591a0cc118..e995823d271f6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3490,12 +3490,12 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
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


