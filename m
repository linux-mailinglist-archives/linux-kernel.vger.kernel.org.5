Return-Path: <linux-kernel+bounces-101955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2506D87AD10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247E11C220B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8313AA42;
	Wed, 13 Mar 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flo1eiRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D913A89C;
	Wed, 13 Mar 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348164; cv=none; b=RFHSlvmYRuARkWUOIzy7ZW0vkSHvr90MnRmUxR63LRpXdRAxIUioVBOPnPHTJ/8qsBDRvQXz5P3f/Rxxa2E/wDMaVUvzaa/99bIx05IRzl+SXDYJ57QfKdTb3nPB0JSiFO1DbySLbb+X7IdvzDpm7L+lHawbD2D0ASR0vVsANQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348164; c=relaxed/simple;
	bh=/PQF0yX/ENGcXAUA1kKDscSZKucRJsSGt8v8NkP/bHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHWl7ki8xft168CGkkZJCcwcCyct7P1GzArtsF+DQ/zaen+cT0Hlfp9UXAXGhK6qiWNn9bLoGfE2QUnMcznctlNb1jEa1mULN9kQ5keIkopLtPZ08YoB5AZavUTg7p1CTWesiCaTv/E4aY+jqD3I6gN8Ginl0q8jUW8j5W4J3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flo1eiRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDA5C433F1;
	Wed, 13 Mar 2024 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348164;
	bh=/PQF0yX/ENGcXAUA1kKDscSZKucRJsSGt8v8NkP/bHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flo1eiRLsyoVLnrKIErZZC9bQS++9UqX08CRX2pi7eQgAcOmx7RN4/YRhy0TWx423
	 OuAzJf7Umf1gwPJBapv/Ih0YDbj8TjcrksWllDJTIFUC14BJM9x8NmJPwDufRFYQ+C
	 hy1o8s5D6tkCuIpICgh8VKLDf4wFHzUYtHINjrC8lzigvT/5/xrcxPGxxXSwIW4Sxc
	 UUegtwg4kk2gFldVQZbIzsB9e7ZubT6RKWnEOO8bqHFCOMaVLPV2wsew2cUTa7UTKM
	 DTM4RvguIItC0ahbWVHcoZCVsel0Rw/+QXofrL4hTO+0mycKJjimh29ALWc1URyUUl
	 7Q7oVAiiksQ/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 15/76] erofs: apply proper VMA alignment for memory mapped files on THP
Date: Wed, 13 Mar 2024 12:41:22 -0400
Message-ID: <20240313164223.615640-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 16a41d0db55a3..a859bf0f31df2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -340,4 +340,5 @@ const struct file_operations erofs_file_fops = {
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
 	.splice_read	= generic_file_splice_read,
+	.get_unmapped_area = thp_get_unmapped_area,
 };
-- 
2.43.0


