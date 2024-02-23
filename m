Return-Path: <linux-kernel+bounces-79146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27422861E32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B8A28607D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B341474C0;
	Fri, 23 Feb 2024 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU2nOLhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A325750
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721737; cv=none; b=N/ipj/3Gw4YaK1Ps5OgAQdETwMgOsaUxHuZHaeuwFCwtH4vN3X7+F/xWikDoZ+SAZxTQEftUuGpiOy+9EzeGaKk6dlliIuDbVa8G87eIBvHme87ZzqAJ4nQAk3oNmdIG9Z2FGGccILJVIoZAQAe6oIxJofne/pHIWT/C1HS42uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721737; c=relaxed/simple;
	bh=wi3u34VTGkwAs5nfIRnTyLTx4oN1qD3NGEQPACYbTI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5f/YPmNHC1UELxZzh/E+4QprHxWsjYnaTp2+RyHLkulqosglOxu8tRetiX78PI9LAmPYI35ltduGS1XTYkTXh/f9yG70mJorMExvF1sUSuYF6acLMyDPVQI6cR0e3x229xqCN1gtBm1xPKl45cpsVTxDSfRrR4hIKcnagJKzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU2nOLhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F407EC433F1;
	Fri, 23 Feb 2024 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721737;
	bh=wi3u34VTGkwAs5nfIRnTyLTx4oN1qD3NGEQPACYbTI8=;
	h=From:To:Cc:Subject:Date:From;
	b=aU2nOLhPL/RgRvW9sZrWBoEMGkQMKGW41pCk2KlqkmzUhp/hX99bvOtMW1LhYDrRd
	 UpXbRlEDrnjPSA3Z0KBG+IoFaWzSBmJB5x+OAf7GWurnmoXDD9q/kagKm6IOFreHzz
	 zivFOs6zRM2qczbiEPefUbwQ7scYiP/8CYr1mRvTg+F+cnhc74lt0vVXBOuKVVfEr8
	 VBkam+Zf9kUUPIV/XoXtvKMjO6CFCv7tkPcou25L5en85RW/vXwcC0McK1fxlaluYF
	 R0/oJ/6kTuYdO9+fGO9js6zx5uU1LlNkAeML4+TgHU7wP4amKPogX86X9vGjFsbnL2
	 136s3D2xeMrbg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: check number of blocks in a current section
Date: Fri, 23 Feb 2024 12:55:31 -0800
Message-ID: <20240223205535.307307-1-jaegeuk@kernel.org>
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

In addtion, let's check the entire node sections when checking the avaiable
node block space. It does not match one to one per temperature, but currently
we don't have exact dirty page count per temperature. Hence, use a rough
estimation.

Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3edd3809b6b5..15bf5edd9b3c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -561,23 +561,23 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int dent_blocks)
 {
 
-	unsigned int segno, left_blocks;
+	unsigned segno, left_blocks;
 	int i;
 
-	/* check current node segment */
+	/* check current node sections, which counts very roughly */
+	left_blocks = 0;
 	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
-		left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
-				get_seg_entry(sbi, segno)->ckpt_valid_blocks;
-
-		if (node_blocks > left_blocks)
-			return false;
+		left_blocks += CAP_BLKS_PER_SEC(sbi) -
+				get_ckpt_valid_blocks(sbi, segno, true);
 	}
+	if (node_blocks > left_blocks)
+		return false;
 
-	/* check current data segment */
+	/* check current data section for dentry blocks. */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-	left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
-			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+	left_blocks = CAP_BLKS_PER_SEC(sbi) -
+			get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
 		return false;
 	return true;
@@ -626,7 +626,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 
 	if (free_secs > upper_secs)
 		return false;
-	else if (free_secs <= lower_secs)
+	if (free_secs <= lower_secs)
 		return true;
 	return !curseg_space;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


