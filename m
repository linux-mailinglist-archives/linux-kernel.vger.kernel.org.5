Return-Path: <linux-kernel+bounces-137601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F2689E47A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66751F22594
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DD1586FC;
	Tue,  9 Apr 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOjfp/7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0111586E5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694857; cv=none; b=qBgiz6BdccpXqJVK6mv2amb/hRO5nj5rts8HW5XHdnMKJvSQfEgvb8hgbScUtj2LRCR09TXDWAHuFyouOTxBxRj3ndVaGH44qQtotiHaUgc02QPEy1WdwRtszgSLsyiOa8c8ItPgOwvMg/3sH/OpG+zqr0ZxU6KFfw1dCab342M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694857; c=relaxed/simple;
	bh=+4w6Yn40335a0GsU306fLSUnzxXEUP2Ol6OJgXDYeI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWESsg5Sd7hxQyuviJrrBpDShVBqLCugikEXusCoUAy/ZafPvcXVdDvOAMULNUsPndNtp49VXWvhQ7woiQirgdTj++qN/fG7M4omriN7pvocQeM6L8svJies3muE9ICXNEyUSXCrImq08Yk37VXMMoy2XCKrcUcfWh57sp4klC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOjfp/7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B26AC433C7;
	Tue,  9 Apr 2024 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712694857;
	bh=+4w6Yn40335a0GsU306fLSUnzxXEUP2Ol6OJgXDYeI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOjfp/7g2+iX4WP7BmUILh7tqFC85L1DLkTG24ckMIrxOZGocygA/5bs19BDuOc3M
	 BDtYlBc+gY0lkLP8sezyoUt/3Qx8AV0wO1ptAMIQJNjHKglQcweQmZXRaW6aMeyWdZ
	 jz3fF0yGMNUcvDFc4GqmvwlU3eXu+JGxnYClbmc5OJc9MamBMmApbAvftFWvUCaDCi
	 ZLLFjUw1H5Fdf9Wv0Pjd3Sbx5dlmGQlRqc3cyQEH5jJwZi2NU1cnXJsJJX8bEOlhEB
	 bKt1XiCNEK2kCv6R0y1q5n9pAS7EogAtl1Ed1ndGkIbZl30272kQWaGuYQGUoDfNfy
	 zjtcH1ozj0BCw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: fix false alarm on invalid block address
Date: Tue,  9 Apr 2024 20:34:11 +0000
Message-ID: <20240409203411.1885121-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240409203411.1885121-1-jaegeuk@kernel.org>
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_ra_meta_pages can try to read ahead on invalid block address which is
not the corruption case.

Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index eac698b8dd38..b01320502624 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 		break;
 	case META_SIT:
 		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
-			goto err;
+			goto check_only;
 		break;
 	case META_SSA:
 		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
 			blkaddr < SM_I(sbi)->ssa_blkaddr))
-			goto err;
+			goto check_only;
 		break;
 	case META_CP:
 		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
 			blkaddr < __start_cp_addr(sbi)))
-			goto err;
+			goto check_only;
 		break;
 	case META_POR:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 			blkaddr < MAIN_BLKADDR(sbi)))
-			goto err;
+			goto check_only;
 		break;
 	case DATA_GENERIC:
 	case DATA_GENERIC_ENHANCE:
@@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 	return true;
 err:
 	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+check_only:
 	return false;
 }
 
-- 
2.44.0.478.gd926399ef9-goog


