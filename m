Return-Path: <linux-kernel+bounces-82497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB06286855F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E9228630C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA20A468E;
	Tue, 27 Feb 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuCWLFkB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBC1847
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995598; cv=none; b=u3/J+MeJcoxnKIhxWFV+wePXTKg+Mo/7HYCn2HRSMFn9V5Ac20Vb1mM5bAE3GeAT5veBxLkfUsVf6+QCdXAKqwGm87XBJW3pVZHPhee3qQvKs87VQf8rMOd4/TExsCsPZ+mHzQ5E76DXU9XcBq2MPB2D/NwT3dBEZfkqpk8vzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995598; c=relaxed/simple;
	bh=PWnCDVadzwnCzOJQlQa+l48fd4sQecfuYbwfY7CEwaU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMzlQcZe8JuZHta8eMue279U6e3E4W9Q99zW4GwChnpNYPx8UM6nhv6VG/20Uv+FrNvxu0UfcxbrfjgQG9/browry6jJPfkFRFiydX1k5c6DDrapqeJJr+EIOoY9OkuhPunPGYRctn9oZO3OstT5IbESXycLPG2/M/VKw0N/e3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuCWLFkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82D9C433C7;
	Tue, 27 Feb 2024 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708995598;
	bh=PWnCDVadzwnCzOJQlQa+l48fd4sQecfuYbwfY7CEwaU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=kuCWLFkBYrC5qwm8KigVMjHB13jWyY1zqGAAZKA0HxmFMFZmydp1RcPLppjU8TQGw
	 YMJxCMLoUVvpufpXx8ANbyax3TH1UXo4qWeNdaZvQP2Mb4NKsZXRcW1GA2j9bFZIoI
	 fvC3/5wW1lx5xB8NplQCwRyqkHYXRyurbr3VE+bJGNyDQbekMDUodCxnYshV3pqzfP
	 l0/yZ7rthdNyTfw2cJD7WBay1bte7RMVw0NuPMim4+lGZcVdCeaWv70TUw2XqXGj5R
	 OrgeB5EXCV1ZaGVqewaxmzS1t6cF/H7PsbM+GMeSzFLxRgG5hS/qGWrrmJuPrJFAKX
	 dJm8YtMhYYsUg==
Date: Mon, 26 Feb 2024 16:59:56 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/5 v2] f2fs: fix write pointers all the time
Message-ID: <Zd00DE6mXbt509sX@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-2-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223205535.307307-2-jaegeuk@kernel.org>

Even if the roll forward recovery stopped due to any error, we have to fix
the write pointers in order to mount the disk from the previous checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 from v1:
  - preserve error

 fs/f2fs/recovery.c | 15 +++++++--------
 fs/f2fs/super.c    | 11 +++++++----
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b3baec666afe..3078d5613748 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -863,7 +863,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	int ret = 0;
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
-	bool fix_curseg_write_pointer = false;
 
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "recover fsync data on readonly fs");
@@ -894,8 +893,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	else
 		f2fs_bug_on(sbi, sbi->sb->s_flags & SB_ACTIVE);
 skip:
-	fix_curseg_write_pointer = !check_only || list_empty(&inode_list);
-
 	destroy_fsync_dnodes(&inode_list, err);
 	destroy_fsync_dnodes(&tmp_inode_list, err);
 
@@ -913,11 +910,13 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	 * and the f2fs is not read only, check and fix zoned block devices'
 	 * write pointer consistency.
 	 */
-	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
-			f2fs_sb_has_blkzoned(sbi)) {
-		err = f2fs_fix_curseg_write_pointer(sbi);
-		if (!err)
-			err = f2fs_check_write_pointer(sbi);
+	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sbi->sb)) {
+		int err2 = f2fs_fix_curseg_write_pointer(sbi);
+
+		if (!err2)
+			err2 = f2fs_check_write_pointer(sbi);
+		if (err2)
+			err = err2;
 		ret = err;
 	}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d91e57ca6110..77348fd0a42b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4674,11 +4674,14 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
 	 * check zoned block devices' write pointer consistency.
 	 */
-	if (!err && !f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
-		err = f2fs_check_write_pointer(sbi);
-		if (err)
-			goto free_meta;
+	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sb)) {
+		int err2 = f2fs_check_write_pointer(sbi);
+
+		if (err2)
+			err = err2;
 	}
+	if (err)
+		goto free_meta;
 
 	f2fs_init_inmem_curseg(sbi);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


