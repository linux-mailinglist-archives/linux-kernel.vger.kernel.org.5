Return-Path: <linux-kernel+bounces-76496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2285F7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F991F240F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E260BBB;
	Thu, 22 Feb 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDPZhRsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC21E3D54D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604340; cv=none; b=NQaH3lpqkrfYFjLFxv1H0WeQHJVov5QA/K9ClLBPas2gIvq9tJ6OuJ26gB3oNEGgnQFrQMJuB6FF/g/6as3aujKYpt8mZWKxlLme1rE8uvr4xC8PUTpqPo4AcRdJFIj6Eg3bHveYv5oalHDLFUWDV0rhkvUwy5tJRpdY8qluS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604340; c=relaxed/simple;
	bh=kfTRBKt4Nbx/JzbJcvx90tf0O1Cn9EETCkS6TLsrw28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3hotsL/J/HVVNSnWEaPlazkTzWDcblBsVD8QLwX2VGxNm1YSW8x/c6nPEZaYjDHObhH2S6QvN9sy/ek1HtB6CuAmQVen/PeGcJWnHLoAyU99sx/QDW0vfeavZjCgrf6Key8UXTjmpC3tbsqVaiyyhKQCW0YgQiVNlQw34NWiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDPZhRsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47646C433A6;
	Thu, 22 Feb 2024 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604339;
	bh=kfTRBKt4Nbx/JzbJcvx90tf0O1Cn9EETCkS6TLsrw28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDPZhRslysG7G8AyvkqI8r9ViKpQOP+RQuHHkMeCIcT4GE6xkcFtwtOUwLrA0HTcl
	 e4fhoauXNziXTHN2W1w3JUYD94c04YFog4zl54zZ09EZ6jcyrTi7wexP0TnXtj41nF
	 pZTBiZLeS/XcY5dcSQtyG4jIEVKsl2UBDJqWeNyV9VuhMGrKpv/KdbsVKrGscfycZs
	 QhzasHFMgiDW5BvPoK7K2rKzb71cWIRmOZQwNRDpSSzgNP/yAm26lcgVx8YVM2n2+f
	 DDU+YdTK9Ami/i3bRM0Z+vfc8fG5QArg94/tJ+r/12G9OJ4dloiaGhIVHElja3U7FB
	 kkEf90HRJXeuA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: fix to don't call f2fs_stop_checkpoint in spinlock coverage
Date: Thu, 22 Feb 2024 20:18:49 +0800
Message-Id: <20240222121851.883141-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240222121851.883141-1-chao@kernel.org>
References: <20240222121851.883141-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_stop_checkpoint(, false) is complex and it may sleep, so we should
move it outside segmap_lock spinlock coverage in get_new_segment().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d0209ea77dd2..8edc42071e6f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2646,6 +2646,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
 	bool init = true;
 	int i;
+	int ret = 0;
 
 	spin_lock(&free_i->segmap_lock);
 
@@ -2671,9 +2672,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
 		if (secno >= MAIN_SECS(sbi)) {
-			f2fs_stop_checkpoint(sbi, false,
-				STOP_CP_REASON_NO_SEGMENT);
-			f2fs_bug_on(sbi, 1);
+			ret = -ENOSPC;
+			goto out_unlock;
 		}
 	}
 	segno = GET_SEG_FROM_SEC(sbi, secno);
@@ -2704,7 +2704,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
 	__set_inuse(sbi, segno);
 	*newseg = segno;
+out_unlock:
 	spin_unlock(&free_i->segmap_lock);
+
+	if (ret) {
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
+		f2fs_bug_on(sbi, 1);
+	}
 }
 
 static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
-- 
2.40.1


