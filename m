Return-Path: <linux-kernel+bounces-62713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01818524B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799242864AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491E23758;
	Tue, 13 Feb 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnFQqt0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102CA22EE4;
	Tue, 13 Feb 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783814; cv=none; b=L2DZPDSf81SpXshKc5C20d9O4w1mxmJHFNzRP1DaSuamjzk2A18bhy1d0ci4MeJvg1UF8WpkRZSqphr97QZkj1haeaf4Vfnc2/r7yPIEK2Czu5s2KGmQWu5jHzpTKruvxqmFstaQPjzdyZxADX5Uj1FqEyoDhMsISebnxliIJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783814; c=relaxed/simple;
	bh=Cj6pQ9boaOw+HAqq3xcQolBE+yhny1YwI6Uzg4l7LBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfnU3XG80nguEQjZhUmZU++tQZIKBb4zmSHAKiEn280btVjt6eUwioIm/kpWbqRN3gIwIf1g8U8CvfdrFZIUaR/IzQ/s95GtR53H3JQ5gQi0scjBXRKXJ6T8r7QzW0cVG4Cv+i10t5a5C9EHOfy9rZJQuGBmI0oo22J5IFc7hsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnFQqt0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F791C43394;
	Tue, 13 Feb 2024 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783813;
	bh=Cj6pQ9boaOw+HAqq3xcQolBE+yhny1YwI6Uzg4l7LBw=;
	h=From:To:Cc:Subject:Date:From;
	b=MnFQqt0C7V56Rzu7JNOrHBFU4EJAzaEN6fMC55HwaC4ogtlCj6FcvMkvsHPhmJShN
	 GQEo2POV2ZAKE5dVftgWyE++KltEZgriH/7sEvTT/nlBJ2HTSqQwXRUMq+TWJMtkC1
	 0LjTrp2a8c5LrRpiPBH5QcYQ1h01lQxs93qsP/KxoQFLbM0vdQpIAZi3j9AG7xK2eT
	 vpo6eBQEqzLuWHhJoCr7jGjWmSgvoemHc+RJk3itGnyTeczVikHEYEtLk6szoLbikp
	 4nIxDQ6y3Em2wXHsPram4tiPGcHwHS1blwbE9t5tjN835Q42jivrh8Hoz/a3LudBmC
	 lfjMuxVFpjh8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 01/22] fs/ntfs3: Modified fix directory element type detection
Date: Mon, 12 Feb 2024 19:23:03 -0500
Message-ID: <20240213002331.672583-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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


