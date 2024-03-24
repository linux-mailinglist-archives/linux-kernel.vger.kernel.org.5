Return-Path: <linux-kernel+bounces-115540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB868895FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1553B29F62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C2247F73;
	Mon, 25 Mar 2024 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTfd0efA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2D1EF7C7;
	Sun, 24 Mar 2024 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321032; cv=none; b=CWOnmMW1Novyz2J/YWEJIHuKBEjt6WSkGDeWqmFtuqR7VoLBFauPYkKmIy+s0iUM2caN+MkmPuI0XyjigdjpUL4k4RE9pSxWIrRQGJh70l1AxIQyuOxYWw6F0OaZoxl8kHQVYKSIlBLYW2Ax05MN+aG8VBFS3tBOggBO4TnObUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321032; c=relaxed/simple;
	bh=lBPcE1Ic6z1sS/Iye+yuDhIyA+ugd+Zw7quz6IQHgDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+1NIe+MfNbKlVc6kqHOD2goQjM4i4FLXydGfHrfwRodh7KRIiOAjnBGpTbIrgQF4dDXTVxEV1SzYpJpTQ0NO/mCPgBxxqVWEmc97wfc3sm+NZanN5C9dZsdm7hv429Xh9yg7hEHtnINgvT6BpYJ5oEv/R0VPFJXeBF7sOVZfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTfd0efA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8330C433C7;
	Sun, 24 Mar 2024 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321032;
	bh=lBPcE1Ic6z1sS/Iye+yuDhIyA+ugd+Zw7quz6IQHgDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTfd0efAUlbUqk0Pz/M1a2BmAb+8wfvWPeKJQJygsP6cyigDIqHrZoQHYv872towh
	 IV0wKF8zh4MN/zdrygcWMFuLpLrq0cXEHdDp+d4pbmRB8ewKjJTM2ilJNNijLCwbBC
	 S4ElwgfBm7rGQZV8XHfF6ywe2fiRiCQdISfuytmTjEwo6Uq4tA0dXym/7Crr2sXyYE
	 +cY1/XPQiXI4wKJQgV942H2+qMfLmrgjA0DtZ8BwZu9wh1lvGO5SOPLi81ggeHB8HV
	 NDWYkLu9PJTlFIXfGbKdcyM7QKSg1nkMU/0fWYbmBek4N6AzZG7DSAT3y6glGvTrgw
	 EaCDuI8qKgSAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 595/713] f2fs: fix to use correct segment type in f2fs_allocate_data_block()
Date: Sun, 24 Mar 2024 18:45:21 -0400
Message-ID: <20240324224720.1345309-596-sashal@kernel.org>
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
index cb49b2d15c59d..7b7ed2dac16b8 100644
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


