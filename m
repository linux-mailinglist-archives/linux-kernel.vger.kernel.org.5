Return-Path: <linux-kernel+bounces-101840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33D87AC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5B2B2403C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C968B70CD6;
	Wed, 13 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5zy+oR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787C70CC4;
	Wed, 13 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347876; cv=none; b=b+lF0IJ1TH5z+J1cUD94GEB5ZbgT41LKpSG9insXQ3dPP0H67OShkHDSmEtYOmrLVzjeVkLkA9K0sMqzfxspE4oKBajFGMVFL+QtZdqJUAIisHL62f+NHrIaeoDF6l9yR2XuE085oz4HGrEqI+cRFE0ua3NixPO6Zb1fqrW4jfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347876; c=relaxed/simple;
	bh=B82JFhnF2PrynKJl6Epqr1Dmh7qWoDe8dYPbBKT1PTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNVDX70NpYbFoch6wO1zeGvCr4WHUYWk66pkoyFbaXfBjyogwbmkdJ9v9h8HWD5IzQe7eMmCpUB5uIacbzFMNn1FXzEqIJRxNNHUXrXa1n5obNcyb8/Zymxh7sMuuGM8WrGJZoWUaGwFFEkl4HXjpZKJ6GLUwg68APgkdGE+UHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5zy+oR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2327CC433A6;
	Wed, 13 Mar 2024 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347876;
	bh=B82JFhnF2PrynKJl6Epqr1Dmh7qWoDe8dYPbBKT1PTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5zy+oR62wCuE7GRvT5O5g1ts/b5iXp8DlctC9BrSCj3KpjuzU9//zeClUnBdpdK+
	 3TQ6tR6PF166c27lVNPIqNXOBVeAugXgtCUJxHkqTYn7mxEFpbdQfgXonmjuIX3LmJ
	 jFtIQYYa72Idjej1gJochWPgasKrJZRWw93h5vuP1hVFYtTQm8SbhZiOBj3g7Fjrmj
	 KnI4e7ux2F0vX87EE44qOhmcJhK5qCE+vE1pxy8B/Ro+ykP0e/h6/yjRZMh+2HGJ7W
	 VJuTmIuPXFgxHGqPJgO6VBybpaf9Tlc0AwuDYomQJAHZ2nP1ov1nLshzgKaSL4o4mS
	 bmKV/UQrV9LiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 37/60] erofs: apply proper VMA alignment for memory mapped files on THP
Date: Wed, 13 Mar 2024 12:36:44 -0400
Message-ID: <20240313163707.615000-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 4127caee89612a84adedd78c9453089138cd5afe ]

There are mainly two reasons that thp_get_unmapped_area() should be
used for EROFS as other filesystems:

 - It's needed to enable PMD mappings as a FSDAX filesystem, see
   commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
   mappings");

 - It's useful together with large folios and
   CONFIG_READ_ONLY_THP_FOR_FS which enable THPs for mmapped files
   (e.g. shared libraries) even without FSDAX.  See commit 1854bc6e2420
   ("mm/readahead: Align file mappings for non-DAX").

Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")
Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
Fixes: e6687b89225e ("erofs: enable large folios for fscache mode")
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20240306053138.2240206-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0c2c99c58b5e3..977bc23f96e47 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -448,5 +448,6 @@ const struct file_operations erofs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
+	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
-- 
2.43.0


