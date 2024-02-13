Return-Path: <linux-kernel+bounces-62633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B878523DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3624285ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F67E570;
	Tue, 13 Feb 2024 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Huuc3P6A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F96BE6B;
	Tue, 13 Feb 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783656; cv=none; b=LpSD1MkFwUtUV7RD8mXcAN01qyJWz92+VsE0M42M/eHONDxOSW7swjaW5X4s/VYhBElKdJE0xLu7Fndbj9/+dKjNjiIuQGaRruDd6FPaomLSaCGjWN2DAHg0NLMxFdGSzHCjPKUK92NP+M4xCpgsYYBVKnZIQg/0qO7aG72Ol1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783656; c=relaxed/simple;
	bh=4q8f+1EZ96FP3EZ+oGugQyTMVbkPPMDmROXjxrksiuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr9k/1RTcoYnCbMzhmL+E/9fRc/sGs6ao9bKjRBwCw510PSvzhc2DMpVe/dO4CfIm8o9uMTWz2mKDRVmE4rFZwrfTNbBQfZvGpUCgUFXeGgcS6O0ngeiAax+B7aJL2NHSCVV7gY91m/wBTTb54u5C+mZKApVrmkyMjPHgz/RV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Huuc3P6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC2DC43390;
	Tue, 13 Feb 2024 00:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783655;
	bh=4q8f+1EZ96FP3EZ+oGugQyTMVbkPPMDmROXjxrksiuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Huuc3P6AMDoHSyTZB7l/mVZrVAqh6oPFdho4waJ5Mk6wdBDemNs/lGwZCnDdJTZ2y
	 zZ1v0BAX8hiuIlXEytSz1X/NQ/Ey0hReY4BnbsBgPwKK/1fKiqbaXFndPvGro92cE6
	 xPyiiXWb0k5LWczjMBwvt50gfm1SmkvjAVKnjcfwo/D3/Ezalj4qyA1lw9ffcPGxRe
	 4icMyI1p6uzVnoH/QLdUD7Zp3c6J1KNEF54rpKfsC+MhBXYwi3ocZFsWfyY6Skgxxp
	 05UHDCqckxrmHGSIeh/kquhefr8/fzcupP4kpboU/IVIvFafaQVN4BHfmUexocMdga
	 cJWKb1pXZZnBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 02/51] fs/ntfs3: Modified fix directory element type detection
Date: Mon, 12 Feb 2024 19:19:39 -0500
Message-ID: <20240213002052.670571-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index ec0566b322d5..22ede4da0450 100644
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


