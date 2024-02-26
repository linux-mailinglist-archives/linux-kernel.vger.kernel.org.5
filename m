Return-Path: <linux-kernel+bounces-80379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B1186678F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BCE1C210E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDBF156CF;
	Mon, 26 Feb 2024 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWyg8I8P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16521427E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911144; cv=none; b=oHgtEZJdq6mc123ASCLXx5SGVy9c8aXNXPKei+GmgFKeNpNUl5UkEAODeMdI+UqPmfE2hJKQD2JmYe1KNFHRRl+MLS50fVLCInB68g1eCrVaoj1v3seVKYoYz/4w4BStJbgK5vkaOnlh9hVTGhovDzzCy4+c2tc1Sn1BDUSX2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911144; c=relaxed/simple;
	bh=7/djeaK+/NFoE++1IozOSNTPK98LJgs6sV030L2n1tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gWpuCvS0FiVV1Qall2a8H1QaaWzVfl4Pb4oxJ1zamS0OFmV2uqz0Wqd0yhZwMdvKCN0Yb6B6pkXqv34gzu2gtLKLOKLi5EJ7qzNvbS5VQLaAHRgL2z3Acwj3NvH0/n0DkjZuhid6dF5VXT5AbCTQeGLAQU2GszHYp0VXWXxV/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWyg8I8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF2EC43390;
	Mon, 26 Feb 2024 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708911144;
	bh=7/djeaK+/NFoE++1IozOSNTPK98LJgs6sV030L2n1tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWyg8I8Pg2PCw71IP12fMFIHDuAm3fqRKfnA9rFN0gPFb6kcT91MwHqEJyIji0ByZ
	 auPFCDznLaELDhRTAee29UojTw8lGc0gSWWUwbM43K+ynZSMCVn8pfAm6Fnt666s9v
	 WFtPKn33AySGF6bufcBV1R/JrxZ4byX2hcHeTc36cWy0f2/DchrnpFDMQMuUR74sNQ
	 z4SyUf0KxzHEXY/nVkxr4yxn7qgqW+MgIhbBFgMGdZVQHitGMza+yN2BZvYGkBi5Wr
	 AGywWzms+as6pTBJiK3IpXo7sP6DDPozZm4aelQZVqSxw63U2G5YcuovxNwFwZp62v
	 EdypU4okNf3AA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: clean up new_curseg()
Date: Mon, 26 Feb 2024 09:32:07 +0800
Message-Id: <20240226013208.2389246-3-chao@kernel.org>
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

Move f2fs_valid_pinned_area() check logic from new_curseg() to
get_new_segment(), it can avoid calling __set_free() if it fails
to find free segment in conventional zone for pinned file.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 847fe0b7f29f..c159b0985596 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2715,12 +2715,19 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 got_it:
 	/* set it as dirty segment in free segmap */
 	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
+
+	/* no free section in conventional zone */
+	if (new_sec && pinning &&
+		!f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
 	__set_inuse(sbi, segno);
 	*newseg = segno;
 out_unlock:
 	spin_unlock(&free_i->segmap_lock);
 
-	if (ret) {
+	if (ret == -ENOSPC) {
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
 		f2fs_bug_on(sbi, 1);
 	}
@@ -2796,19 +2803,17 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int segno = curseg->segno;
 	bool pinning = type == CURSEG_COLD_DATA_PINNED;
+	int ret;
 
 	if (curseg->inited)
 		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
 
 	segno = __get_next_segno(sbi, type);
-	if (get_new_segment(sbi, &segno, new_sec, pinning)) {
-		curseg->segno = NULL_SEGNO;
-		return -ENOSPC;
-	}
-	if (new_sec && pinning &&
-	    !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
-		__set_free(sbi, segno);
-		return -EAGAIN;
+	ret = get_new_segment(sbi, &segno, new_sec, pinning);
+	if (ret) {
+		if (ret == -ENOSPC)
+			curseg->segno = NULL_SEGNO;
+		return ret;
 	}
 
 	curseg->next_segno = segno;
-- 
2.40.1


