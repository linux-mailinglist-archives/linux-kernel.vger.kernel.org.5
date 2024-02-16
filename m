Return-Path: <linux-kernel+bounces-69404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5C858883
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337DB1F22D97
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5612FF9B;
	Fri, 16 Feb 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC+NeT1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6B1DFFD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122731; cv=none; b=Kv/2firmXwXz28XnTxHUzFHxigNWyfgM1mRIGBIcgpKs/E05/cAjD8bNxeSB9HrukJ6VHa1XACITulFFyMJQD62hfG2kbhOreO+GkMyNcRS+wWhlbal03tM9ugaLyjKse/wLqsyjf31GzfQvEcUgyKAzOutZ9NdnQjRzGV+F278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122731; c=relaxed/simple;
	bh=c6HKSK2nlZ4KsJ8exupjfyksGkk+o2n/wAUv5WGdAgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KlPY64zQUFrFRlSZuFMrL2XdzTEAGFdjFkcvnGBVEiRZ5tLsY6OdxYNQP6QsDwewQKF6t8wQGCMBJsSRUsW3HIiWIeh5HI6q7/G+PbscVN+2hMl47jpyyj5OFZ6Ip5UU0YC9wQzicRg0p/w0llxf7fm18/0SkYPoQJdW36bTr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC+NeT1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C419C433F1;
	Fri, 16 Feb 2024 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708122730;
	bh=c6HKSK2nlZ4KsJ8exupjfyksGkk+o2n/wAUv5WGdAgM=;
	h=From:To:Cc:Subject:Date:From;
	b=PC+NeT1+C/iDjvmSSQ8T/upGHRveFsAL4W0Ln+vG+fY4WJOP/cyHmpENFfnkFFTxq
	 fAqpHVEfOZaywCIDmTxU+q8FXksga+fPeW9U8Xby6hiWhIDR5RAmVt1PYFa3HWm6Pv
	 DtsKv69LdufuklA6u+jHz5A7vhoA3lAURB8Ok8tQYYjf45iBOGckyW8YbDDu/hU5I7
	 nVy3uofx5NQsip3qd782f82+5LTvzPRjEJF6ih21lo4LrOryuEVdeyqbfVAY6MreYC
	 pqShMEdzI9xtW7ZorrVGpAd7/z7lzMzhaUAX8KWYu2fDy5vjLNUysQFelgHdHJU3HN
	 F2VKUS5kDQlFw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix write pointers all the time
Date: Fri, 16 Feb 2024 14:32:07 -0800
Message-ID: <20240216223208.443024-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if the roll forward recovery stopped due to any error, we have to fix
the write pointers in order to mount the disk from the previous checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 +-
 fs/f2fs/super.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b3baec666afe..8bbecb5f9323 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	 * and the f2fs is not read only, check and fix zoned block devices'
 	 * write pointer consistency.
 	 */
-	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
+	if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
 		if (!err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0b3b18715bec..a2b7a5c448b5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4656,7 +4656,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
 	 * check zoned block devices' write pointer consistency.
 	 */
-	if (!err && !f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
+	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_check_write_pointer(sbi);
 		if (err)
 			goto free_meta;
-- 
2.44.0.rc0.258.g7320e95886-goog


