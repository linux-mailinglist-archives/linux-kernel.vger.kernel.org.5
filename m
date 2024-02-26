Return-Path: <linux-kernel+bounces-80380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF06866790
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE68128188F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB31AAB1;
	Mon, 26 Feb 2024 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwvylUGm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E418EA1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911147; cv=none; b=TIju33PY7Tb9/GQ+8Q4YIP0wk0ZV/QazCcChWsgWcf1JThreX3ev2/iv9xVhhsRki0uIqXXGrbeGeQlJtWHoEAXj1LlS2482RA/MurIbrly4bz3lU8UTUUd66k+TiyjIdvSo/bCUoqebYOu1niuh5Q/ixLPt4xNJgZ5NtbSd3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911147; c=relaxed/simple;
	bh=swCJRsLLHSfSL70VZ8N2jxsoH3eh6oxUKRyJYOvWmVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJ91Ompqx8MQfxmTKQdKCpncvHn5nHE2cDOYaKh2vu1672uSVCufD2mNjDmQlfDq+2VN+OtQ4vQMEgF0tvax0B4BIOP60Vl/3TU6DyIqcUiEYuVqDnn5foZLqsuSLwFmMf5DThuAmpeRk0HTNqJxrFz3zEerF9W/Ltgmxcn2fLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwvylUGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8815C433C7;
	Mon, 26 Feb 2024 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708911146;
	bh=swCJRsLLHSfSL70VZ8N2jxsoH3eh6oxUKRyJYOvWmVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwvylUGmaR3/VKWOxYxEaJZFu7yTShWFdpZBHMKyTV7/KhCdXYdJQM4qdlXZ1cMVj
	 AVyHxWq2CW3omXby49h2WXemiInYv1+c3I7DL9A0PFq1qe+AtnLDIQr7ZSnWHEG+xZ
	 B/5L3O00WoJmT7Gu1CwyIF2pWGI4qDAcbkctSH1v9tDAhrofkeVJsl9MdcXOKqTyoK
	 cyYyg0iYkBIWb2Ogv5MJksLuVfAFi53CIeJMLbuyARUq8xPJY8Y+UvcCGpMM57RXgn
	 2xOrCsUd9OAvfpT7mXQQAVQOY3+Drbudsbcw8GsZRJutXUiPF9IvxrZFS4cIUg3IzC
	 L54KRQ7EBb9UA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: fix to reset fields for unloaded curseg
Date: Mon, 26 Feb 2024 09:32:08 +0800
Message-Id: <20240226013208.2389246-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226013208.2389246-1-chao@kernel.org>
References: <20240226013208.2389246-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In f2fs_allocate_data_block(), before skip allocating new segment
for DATA_PINNED log header, it needs to tag log header as unloaded
one to avoid skipping logic in locate_dirty_segment() and
__f2fs_save_inmem_curseg().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c159b0985596..5e45afd69f3f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3101,12 +3101,16 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int old_segno;
 
+	if (type == CURSEG_COLD_DATA_PINNED && !curseg->inited)
+		goto allocate;
+
 	if (!force && curseg->inited &&
 	    !curseg->next_blkoff &&
 	    !get_valid_blocks(sbi, curseg->segno, new_sec) &&
 	    !get_ckpt_valid_blocks(sbi, curseg->segno, new_sec))
 		return 0;
 
+allocate:
 	old_segno = curseg->segno;
 	if (new_curseg(sbi, type, true))
 		return -EAGAIN;
@@ -3451,6 +3455,13 @@ static void f2fs_randomize_chunk(struct f2fs_sb_info *sbi,
 		get_random_u32_inclusive(1, sbi->max_fragment_hole);
 }
 
+static void reset_curseg_fields(struct curseg_info *curseg)
+{
+	curseg->inited = false;
+	curseg->segno = NULL_SEGNO;
+	curseg->next_segno = 0;
+}
+
 int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		block_t old_blkaddr, block_t *new_blkaddr,
 		struct f2fs_summary *sum, int type,
@@ -3516,8 +3527,10 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 */
 	if (segment_full) {
 		if (type == CURSEG_COLD_DATA_PINNED &&
-		    !((curseg->segno + 1) % sbi->segs_per_sec))
+		    !((curseg->segno + 1) % sbi->segs_per_sec)) {
+			reset_curseg_fields(curseg);
 			goto skip_new_segment;
+		}
 
 		if (from_gc) {
 			get_atssr_segment(sbi, type, se->type,
@@ -4595,9 +4608,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 			array[i].seg_type = CURSEG_COLD_DATA;
 		else if (i == CURSEG_ALL_DATA_ATGC)
 			array[i].seg_type = CURSEG_COLD_DATA;
-		array[i].segno = NULL_SEGNO;
-		array[i].next_blkoff = 0;
-		array[i].inited = false;
+		reset_curseg_fields(&array[i]);
 	}
 	return restore_curseg_summaries(sbi);
 }
-- 
2.40.1


