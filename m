Return-Path: <linux-kernel+bounces-79147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E685861E38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C088B223A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22114149385;
	Fri, 23 Feb 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDztIDUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674571482E7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721738; cv=none; b=N+CSZpL2HlT26SKJOchMPO5O+7gHNSoOm/JAPbgPbMn8qSN+kbyhpXEP2SMzKARy0o05g/kGuDqdqPr/k5ZrSuIoa8uVztY14TIEUEM+UiPTwzkJEo7gxzj8PHI/L+Xdgh96mSDWZ+zXoEcP9LJb/XHE++WxU0NwDrpGsAeYlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721738; c=relaxed/simple;
	bh=1gKonBQkHb/HxNH0cWOVYXamRfmS4ibjq2hXF1LjSXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUMrPDfxa/hQt/0+UU/1Z0HdIQPcuW7ljbo7hT0gX0uvBrUZLZDeBdV9xB82Z2CYHvJ14dee8pGRxu4XmlCNuMG7s6ALDoptOccFh/O5afUcWoV9wxnqIB82hUAbaksD30CdCp3IO4aKugexILKDF2nmDc0TtthciFs71LBDY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDztIDUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8180C433C7;
	Fri, 23 Feb 2024 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721737;
	bh=1gKonBQkHb/HxNH0cWOVYXamRfmS4ibjq2hXF1LjSXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDztIDUMIf1uQI3wEPns47jCdJLcgDmWlGKrDDrzZPfvjYREA206ffnpHXWjr8NoN
	 1E1L3M677M9HaICSVu7GqwVPSS0gBAJkgule8HcadYMs8pialTn+Oo59lqQIw+vNwt
	 jlouFmp59ZghxaJN2TnlEmF9erPZoJdfJL1XuhrJta4b4DScZ/tzkwLJpZkDE6I535
	 CD13j4vOBtp9MiZRkcEfbc55lmB4jw/WP7M+TGrHxTipMhogw6jCdTPeHtSXsj5Px7
	 EFFF6vjgT6aRfcTQ6HtUXZSNtISV958zN2YFFGwIb9ps1emAkvT8ilyeI18ouCpGSW
	 RDSSuPrZGO9AQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: fix write pointers all the time
Date: Fri, 23 Feb 2024 12:55:32 -0800
Message-ID: <20240223205535.307307-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240223205535.307307-1-jaegeuk@kernel.org>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
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
index 2e41142d07c0..4d03ce1109ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4673,7 +4673,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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


