Return-Path: <linux-kernel+bounces-62641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDEC8523EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472E5282EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441925FEFC;
	Tue, 13 Feb 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIMAXOSA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7D5FDC8;
	Tue, 13 Feb 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783664; cv=none; b=J4ZswaAhujVG/MOu1IxQURNx1Rtb4jIdH9YWIDYN1i3SuiIT31b3R+Gg+BG7YMM8xtN+xQg73FF830/YpFEPkDiTfEKRrRse1BBunWHN+NzgTXZkSU8x40Br2v1/DlQAIGNxGII0wT8+5pSZ1KZo6jfaBUrn542+Z9gsbZVmXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783664; c=relaxed/simple;
	bh=mA0Fci1lxH5SIxnVuwWftnKr6FvNQtbKmvcVp0Ka064=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZKKT5S09ur7J7j/QkQDRMoBAFFiCLRyiAv4OoD7Nxe6ld+/Mq5eEFRJcmSIQMZh+99Lz4hEhqvgCqC8ew3EmcyII7eV7pf5fZYcAD09iDAKsL78ZixqE3ReT6KEIDJwHiPWkeQCbS8UCVGaLRNXWQavXEqrU/MulrGWipF0Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIMAXOSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DEEC433F1;
	Tue, 13 Feb 2024 00:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783664;
	bh=mA0Fci1lxH5SIxnVuwWftnKr6FvNQtbKmvcVp0Ka064=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIMAXOSAZqDebOnWdnEVdFZi6/9oRl3yZZG9iOmemBUHUGBORSBtkTBeSSrZDFENl
	 P1/xGObXVW102lWgJjtTnpxW3X3ynLuCofvFr2b52uZtyNS+Y94WnoQVMPdTuh7Gye
	 THEaY2XQdiYfm44a/r+oQkOj/JImusTF/xcTR6v11mUs6od5mdM6bNMaTGaINKo6ep
	 UVyo787yH32WOFz4xSQkGsuv4DQ+4Q3UPBD6M3g4shj48IILZu8vaShte1bpdp7EYh
	 hgXz4kdqm0A4ZDYnuedPhOeL6wjuzcktEYCehPHx/oEbQ/lOcbBpJLxia51k1yorQM
	 DRe4N6gzdFwfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 10/51] fs/ntfs3: Drop suid and sgid bits as a part of fpunch
Date: Mon, 12 Feb 2024 19:19:47 -0500
Message-ID: <20240213002052.670571-10-sashal@kernel.org>
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

[ Upstream commit e50f9560b8168a625703a3e7fe1fde9fa53f0837 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 6e1c456c9ae7..5530b4cf1ee5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -498,10 +498,14 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		ni_lock(ni);
 		err = attr_punch_hole(ni, vbo, len, &frame_size);
 		ni_unlock(ni);
+		if (!err)
+			goto ok;
+
 		if (err != E_NTFS_NOTALIGNED)
 			goto out;
 
 		/* Process not aligned punch. */
+		err = 0;
 		mask = frame_size - 1;
 		vbo_a = (vbo + mask) & ~mask;
 		end_a = end & ~mask;
@@ -524,6 +528,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			ni_lock(ni);
 			err = attr_punch_hole(ni, vbo_a, end_a - vbo_a, NULL);
 			ni_unlock(ni);
+			if (err)
+				goto out;
 		}
 	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
 		/*
@@ -563,6 +569,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		ni_lock(ni);
 		err = attr_insert_range(ni, vbo, len);
 		ni_unlock(ni);
+		if (err)
+			goto out;
 	} else {
 		/* Check new size. */
 		u8 cluster_bits = sbi->cluster_bits;
@@ -639,6 +647,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		}
 	}
 
+ok:
 	err = file_modified(file);
 	if (err)
 		goto out;
-- 
2.43.0


