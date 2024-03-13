Return-Path: <linux-kernel+bounces-101781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189087AB87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34471C21291
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEED8629F9;
	Wed, 13 Mar 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm7OcMrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999950A9D;
	Wed, 13 Mar 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347610; cv=none; b=aozwIzyFdiMWILrRtzMRih3aBjoGZO2P1A1cGScOvZ5JdZXGOSx/ssOKyLWPvCY1DoaK46sv+JJvc9WZLdIle0FNilzWu8W20ubMyTQAoleNnvOwDT9cARFAnUetKJ7YoYLjULK+yyzIF9dV7FNVvtdmhRHsFdIT1mp9pZTHgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347610; c=relaxed/simple;
	bh=KtxJDXB2dqy8VWH3BBhIQfZR3UVd/6MjguJ6kwSTkx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1CIE8BddpxDDfKNfESQJLhbyvDqX3cPV+vFAFVWcC2+IQ4QBbITaPwMoa9QxPlHA2MdcF3FhmASq5P5cmv566pbnrlQ5Ui0j9eZFl8r73qxvym1BiRG7SWYNIfVWsGeEJpbiB+1iVGNineNHEITnCV+69DfkKhNgGWEpvAO+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm7OcMrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9BFC433A6;
	Wed, 13 Mar 2024 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347609;
	bh=KtxJDXB2dqy8VWH3BBhIQfZR3UVd/6MjguJ6kwSTkx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mm7OcMrDsZ4mWA+2sxdlqn8zg/aFUr6NoV1mkHly1DT7daNhMuu+ORTqlI8m85r4p
	 6BcGLXmP9oEE1OP5DDdOwY+/PE4nUIyA5vdgEvgaLFkJ9BI0cypmrJ9Koq2rF8EZj+
	 JPoMx4a7TPML8G9ckCcUZGL0yP6A8o+mxHLYMtVt1SshISo8zBLOGuC/6o7YxIV414
	 S0ubEL3kn9XRYL5GHrjQ3YQ3R3mYX2Z5bsbSJay6ZCxMk5D3iHukuwSGwI+ufSewys
	 n+q6ft4g3UMzg+dwECpJVFVBKshyx7j/avPAAWzYYGFaMiN6D5U48icOp0YWv/Fou0
	 V4WgWAhNDHRag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 42/61] erofs: apply proper VMA alignment for memory mapped files on THP
Date: Wed, 13 Mar 2024 12:32:17 -0400
Message-ID: <20240313163236.613880-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index c98aeda8abb21..3d9721b3faa81 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -447,5 +447,6 @@ const struct file_operations erofs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
+	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
-- 
2.43.0


