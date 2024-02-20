Return-Path: <linux-kernel+bounces-73817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA485CBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A16282C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6D154BE3;
	Tue, 20 Feb 2024 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCURf4g0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903C151CEB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471370; cv=none; b=ff0qOkfsBsE6jiPQQv5vP5rOazlw2IpC+LMG6W9x+D1fkBUFHbranDPXgMECNqWf+AGrBtezAqznvUaZTGnmeL5IlcMZ3pAaKTDTflvdI05eV1Syeysf4MI6L3tS4Wa4cSTB6ZZJ6CWsGVlyvZmG8+qINXzNzdaA7R1sBX2QhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471370; c=relaxed/simple;
	bh=CBp5JjqsLlKrQ4BNGdzZd5rg9Xdr48xFXWUha9mjqMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3ahkmnysA1+MA0oSJTlDjwQkwg7Z5y8jrwBLri5JZaf/B7K7/F8crWPZB5lKz+8WeXBDLJ3Leklj+djrtAzAjyu3ryZtNdGW7fpygr+Pbl7N56XsJG+ZReS8I+emsON2UJdHWOwuQcXl/mH96prN8VLHzqgb1xMcqW6jRQIFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCURf4g0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D29EC433C7;
	Tue, 20 Feb 2024 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708471369;
	bh=CBp5JjqsLlKrQ4BNGdzZd5rg9Xdr48xFXWUha9mjqMk=;
	h=From:To:Cc:Subject:Date:From;
	b=JCURf4g0DN9i5rfqoTbGnrdxhM3Icz9HiY+JaPFhD/Vy00aaUyiSlcDK+qhCKRHe4
	 Ho23d5Tk0ARSTuOyIiXNl1w3y7WD7MxcbgvuUrvpLJGQ1LnK8nMWpX+g3GxQNyXSBL
	 6lqJqOHjTWb0jWAnfk0Btwya+uHHAZpXGFNcVBKoX2w9ADVxVyLfvgBV7piMPa3vi2
	 LlQFJ/qCULU8kupAvJvCWxJs3lSey6emyWkv8NnNU1Nq6lT4RRkxBsN8XwAcAER0+6
	 oU8yqP8oNSNUb92exDuKtvR2ojnkhNf0eQmslQ8PHsD7TmRQla/mcX5711a0g49pIM
	 BygBxghqVqC7A==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: check number of blocks in a current section
Date: Tue, 20 Feb 2024 15:22:45 -0800
Message-ID: <20240220232247.2856-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
the number of blocks in a section instead of the segment.

Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 63f278210654..9fe5ec619456 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -560,16 +560,16 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 	/* check current node segment */
 	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
-		left_blocks = BLKS_PER_SEG(sbi) -
-				get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+		left_blocks = BLKS_PER_SEC(sbi) -
+				get_ckpt_valid_blocks(sbi, segno, true);
 		if (node_blocks > left_blocks)
 			return false;
 	}
 
 	/* check current data segment */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-	left_blocks = BLKS_PER_SEG(sbi) -
-			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+	left_blocks = BLKS_PER_SEC(sbi) -
+				get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
 		return false;
 	return true;
-- 
2.44.0.rc0.258.g7320e95886-goog


