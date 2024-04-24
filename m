Return-Path: <linux-kernel+bounces-157405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7E8B111D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301D71F27B67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0316D4C3;
	Wed, 24 Apr 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5owhCdw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7413777A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980150; cv=none; b=PF4FBPL2EGBsxIKDtdkBUjzxwsgsaZHfqrUUyznLntGVjjcyxByFxjqPzvpKZ8wY00vMb3yci+ehhRpCb7EgYIqFMjGgwGqMpcOkPvNBDnMut8GdIJPtyFbQj6q/lSAnOAFAKTirOOVfbL/Fwu+d7AWg6F0FgwC6ditvtyxFAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980150; c=relaxed/simple;
	bh=Zx21olM6TIaTxOuCCMQe79AYeFL/GNrR4k4CavTnoaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sod3Q8YOAn8D/b5W/SWwOp/GHczPi+VYsCkNjVpq2k4SRh3NoJ09PwUd3yeOKLACfbi1wCFUZCUr/49jrEIvyW33TgAMFEDMW4dcU7sxDmtdhwUgtkfceGcYMqj83q4KL9Ui6E10zHywqQzfmE1WLePbEbg6rb5faI1zjI2wKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5owhCdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D0CC113CD;
	Wed, 24 Apr 2024 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980149;
	bh=Zx21olM6TIaTxOuCCMQe79AYeFL/GNrR4k4CavTnoaI=;
	h=From:To:Cc:Subject:Date:From;
	b=C5owhCdw5/jNzo4EXhhD4qYlKIO1w4wRmFxlqkBkF429P6nWjaizzpCPRdYDgUO/x
	 SFiBdn+15eoCMyccee/urI38e+ynLSuKp/oRoN4mXM/96/svlcmanFAqODmcSDvge4
	 wQUonhmhf9DHZrBZ0566qz+IvE3nLr0oa5Dbj2DFK8GjZL8pOZBVEY7gomsn1nnq3V
	 zXlJjhYzKKd3GhhFaRPG/6hJ7YlaoS2bI7miAeNHl+NSRH9PC9IpnVc5GbCr+q6VZP
	 vOVbdrolEmedOWq4aNmfhYeT7Rortcgcv7OsjBze8oH93rpjK5BSoWefTalpogDFvI
	 49H/wulrmnuww==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	stable@kernel.org
Subject: [PATCH] f2fs: fix false alarm on invalid block address
Date: Wed, 24 Apr 2024 17:35:48 +0000
Message-ID: <20240424173548.1515606-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_ra_meta_pages can try to read ahead on invalid block address which is
not the corruption case.

Cc: <stable@kernel.org> # v6.9+
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218770
Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5d05a413f451..55d444bec5c0 100644
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
2.44.0.769.g3c40516874-goog


