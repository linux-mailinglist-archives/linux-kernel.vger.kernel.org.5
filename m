Return-Path: <linux-kernel+bounces-113933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8CC888772
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39F71F25E48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A421691B;
	Sun, 24 Mar 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN7CqtQU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F614A63E;
	Sun, 24 Mar 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321029; cv=none; b=kJ3Jj+bbeWKnMKCMT88bIR3lElQD4PdnViSQC116cju4r7lzNhUJaSydnqVRW5pG1vbaBvn9bG46JCN8l2X4yg4hsAkG2sI+AIW3VhXCVCawacSGoGd4fUx9SZ3wGPLim5wTyq9pDvQdl4+78XSZZG8260IWGdxz8SJuf4BwXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321029; c=relaxed/simple;
	bh=SPantjYY2aawnQ0TrCYbOico8kL69tU7bw3MKUThvss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJG0IqmaXYWOK8XLdkvejobsehLNn2qZNEb5997XgLOvd7i+e0BgD4j3kQ3N97X8HwqXdc3LtGB8jzd2kjw2tVIAdkfebbW3KPj6NH95Rn3pe5WGgIAZ5v1s9fuKIvLb03YEp84Sc2trCHRkdoX+QEG2vNsRyxnLf+BGIJI5n2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN7CqtQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3535C43394;
	Sun, 24 Mar 2024 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321028;
	bh=SPantjYY2aawnQ0TrCYbOico8kL69tU7bw3MKUThvss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PN7CqtQUb2gLclLQfFAeHrajGunFscqiymFrAX7Suj+z38r3AK40+7o04eWYuzxAW
	 9AdApuEgP4sY833+ahZ7LmxkecOb5ZOZe1YpihBpQlGkKfbrT8qeLOfYsUL+0JgJS2
	 jgfbIfcqs54LcOi4XSKXMvC26CUOZRTtC4RRlchqJb5R5mRPH0XazA2fbUJAb/5SoK
	 JHu4jdOfoXFRxYKEY0h1iloEfS6IWZO6F++YKdHgB5/2KcCBVQlm6P5GvYeZtCxuQT
	 sJJNjhp1U4AnPmtRUeg4M5lpBPyDIh41FXShMi+nNOKwWSol+3dy2Gcna5yrShoZeK
	 prM8okCZA+Xxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 591/713] f2fs: compress: fix to check compress flag w/ .i_sem lock
Date: Sun, 24 Mar 2024 18:45:17 -0400
Message-ID: <20240324224720.1345309-592-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit ea59b12ac69774c08aa95cd5b6100700ea0cce97 ]

It needs to check compress flag w/ .i_sem lock, otherwise, compressed
inode may be disabled after the check condition, it's not needed to
set compress option on non-compress inode.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 762b664ef38b2..a82dc1af16797 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3989,16 +3989,20 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 				sizeof(option)))
 		return -EFAULT;
 
-	if (!f2fs_compressed_file(inode) ||
-			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
-			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
-			option.algorithm >= COMPRESS_MAX)
+	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+		option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
+		option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
 
 	file_start_write(filp);
 	inode_lock(inode);
 
 	f2fs_down_write(&F2FS_I(inode)->i_sem);
+	if (!f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
-- 
2.43.0


