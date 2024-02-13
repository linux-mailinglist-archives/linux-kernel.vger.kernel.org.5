Return-Path: <linux-kernel+bounces-62684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642085245E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADDE1F24672
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3275722301;
	Tue, 13 Feb 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkEV7UgR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434D2207A;
	Tue, 13 Feb 2024 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783758; cv=none; b=DF1pt0znp4qoYf5V1Pv8PHrUDccxupX6GfvNeJ7+/vlHri+0pu996oFsqfGbGpIUIDztPtEvD8TC280k+2CK6SqPcKjiM2ZyEUKDPh7yC+QFQxhUUdTqsDICcm5ArPlSjpxoi1xMlKS5ESHSTyAFYO2FKlXGXy9tBE7Xv6xPN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783758; c=relaxed/simple;
	bh=Cj6pQ9boaOw+HAqq3xcQolBE+yhny1YwI6Uzg4l7LBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmwAmhfswwnKlyXbqdhIg2wLrDWna9P0AdpkKRO08CNzPJZtYOLNvHJv8WRvdtfU/829/L0FE/xEH/aENKNgdUmVhs2RMCYldTCr8COcKrvGMgiB7Wdr5bu/qFPGr+WjDRhLdVVJ4T3adup/itNfz+gjeLvA88/Eas+OrM+0qKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkEV7UgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52804C433F1;
	Tue, 13 Feb 2024 00:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783758;
	bh=Cj6pQ9boaOw+HAqq3xcQolBE+yhny1YwI6Uzg4l7LBw=;
	h=From:To:Cc:Subject:Date:From;
	b=jkEV7UgRuOtuyfKu8Hmuxlchw4Ba7hSzwP55H6htH5nMebxLkzfOVwCbgQLkOH061
	 5c4SSUKMDvDiuMZ0FGQx9DSMLeZiTf1KKPyWL6Dt97l0sjc2w73XDNRdNe6dbSSY/4
	 zyg2g+sDYGLL1tbXZR3O9g2ZDAKF4kbRV45jsRkHztX7WX70iy8cW0HsWvbFjNXzkK
	 W96umbqt1C+6oOf1WqEQTxyQVvAqC8nV7aysg6RpnSFC5UA+p7TuswY9QsHG9Orat0
	 H7mj2U37AVD9yh/paCIJKHHNiXzLKRpJKTJCa6gDFSTRILFTBJ3WJRbtfN0lFVDO+U
	 ZTx5QYsatkziw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 01/28] fs/ntfs3: Modified fix directory element type detection
Date: Mon, 12 Feb 2024 19:21:59 -0500
Message-ID: <20240213002235.671934-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 22457c047ed971f2f2e33be593ddfabd9639a409 ]

Unfortunately reparse attribute is used for many purposes (several dozens).
It is not possible here to know is this name symlink or not.
To get exactly the type of name we should to open inode (read mft).
getattr for opened file (fstat) correctly returns symlink.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/dir.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index d4d9f4ffb6d9..c2fb76bb28f4 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -309,11 +309,31 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		return 0;
 	}
 
-	/* NTFS: symlinks are "dir + reparse" or "file + reparse" */
-	if (fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT)
-		dt_type = DT_LNK;
-	else
-		dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+	/*
+	 * NTFS: symlinks are "dir + reparse" or "file + reparse"
+	 * Unfortunately reparse attribute is used for many purposes (several dozens).
+	 * It is not possible here to know is this name symlink or not.
+	 * To get exactly the type of name we should to open inode (read mft).
+	 * getattr for opened file (fstat) correctly returns symlink.
+	 */
+	dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+
+	/*
+	 * It is not reliable to detect the type of name using duplicated information
+	 * stored in parent directory.
+	 * The only correct way to get the type of name - read MFT record and find ATTR_STD.
+	 * The code below is not good idea.
+	 * It does additional locks/reads just to get the type of name.
+	 * Should we use additional mount option to enable branch below?
+	 */
+	if ((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) &&
+	    ino != ni->mi.rno) {
+		struct inode *inode = ntfs_iget5(sbi->sb, &e->ref, NULL);
+		if (!IS_ERR_OR_NULL(inode)) {
+			dt_type = fs_umode_to_dtype(inode->i_mode);
+			iput(inode);
+		}
+	}
 
 	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
-- 
2.43.0


