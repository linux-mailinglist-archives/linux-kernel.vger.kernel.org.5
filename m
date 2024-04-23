Return-Path: <linux-kernel+bounces-155018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306268AE46B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AF11C22B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5AC13443B;
	Tue, 23 Apr 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAhAIKkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4B1332B2;
	Tue, 23 Apr 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872417; cv=none; b=tMCr1q9noaSq4Cug25/o8mM7oW5tJLmMl26PwZcr4Q4IURZsCk1UAPbXF8hMw1VSf5VIeonpOcXQzI/6UxUy+v3gH++dMdK5Ka4+zZLykAGUZA6ruO9EF47Kq5uFbbnpg2ZZoLt2vLnUQDLECfTzh961Zyw3uVucw67Ufl1whqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872417; c=relaxed/simple;
	bh=ZV19rWlq0rMYP1iGul5iwqjLFaaRMHQBvl4e/eP0L5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st0NORnlBasfDjPp/sTvdCTq1iueqN30Ig5X00oK5xcbGiqCQGkzMuWYsdfKklUgg+nUdOfCtoYuTMpmZ8AxK8qFeSelhxsoSww2MAduBGuJykuG/oI2CnHKXus0YnvCPl+JawE32H03zsrpninx1u7syVoDVUZ0yda4MU+h8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAhAIKkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F76BC32786;
	Tue, 23 Apr 2024 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872417;
	bh=ZV19rWlq0rMYP1iGul5iwqjLFaaRMHQBvl4e/eP0L5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAhAIKkAgDPLXbe6Oq1zqeHsacbuk2yEQKDaMXWkXB6+Ct/74rXw6yMoeVyHrY4Dc
	 EF9fy0qyTJPhZqz3xx4C1qhF6Gk8lADwasAfRzvvIjRhI+pzVd6j1ggtkp4Ggjf/Vq
	 H5jdLvDAJpUAvHF0QvS8baSIzGyzmNqvCFcjQxWWvol1oo+Cb5q7lPR/9PbPha8tuT
	 eTgAol4woXIJEafloDTltEK4+sT4HoF10Jwk6OoUPMKoPnWkMoYFv7SKeI4llacwq5
	 R/oqM+m6xI6K7BWmiB+DV5f9ZGCldiLesXO/EOaeEeH/BvA8okbwEcD993Vx3wo8zc
	 F+WfBvq4X5jbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 10/18] fs/9p: drop inodes immediately on non-.L too
Date: Tue, 23 Apr 2024 07:01:06 -0400
Message-ID: <20240423110118.1652940-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit 7fd524b9bd1be210fe79035800f4bd78a41b349f ]

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 941f7d0e0bfa2..23cc67f29af20 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -310,6 +310,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.0


