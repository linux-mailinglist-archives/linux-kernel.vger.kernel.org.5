Return-Path: <linux-kernel+bounces-101886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC387AC70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346371F2B719
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673207AE6F;
	Wed, 13 Mar 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1gafIOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50907AE42;
	Wed, 13 Mar 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348021; cv=none; b=eU7iWVOIlPuZlWyUkwjO3aAz9WptjtXAMXHEVlKlOce5XpHidHstE3RakUBulDYqbwW33VS7r6+va5Rogkqc9oN7v/kSUT445GFnVL9oeaed926zb7+Y8Ii45vq3tMF9xv7lfBCl2mAIv0u8Sg+iLQufQXZxYhAeMQa+AoUIKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348021; c=relaxed/simple;
	bh=U8MyWOAzXmXdXBKgmnHFvRhuLr+sEeBKWE4T0slEaZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ug7OHOvRJvN8PKAzeaMQUsj8uj4wTPK8K5WbeZc6lXcrLP3ItaorVSuDqciagRi5+CSJ/ssgyJp9X7bndTZt2wa5DSwWc4EqdxsfYU9YbHzOs3B8jA7aI2zRfgvD/CVWivd48fO0w9BKZc1HaNcEqitKDovWu7lYBQKac9Tb1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1gafIOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93ACC433C7;
	Wed, 13 Mar 2024 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348021;
	bh=U8MyWOAzXmXdXBKgmnHFvRhuLr+sEeBKWE4T0slEaZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1gafIOjPaUE3fMdjnjTJn+HQEOId4HQrEQ5ajRCCHbEw5P87Z9XyDZ2gXFuMZiWu
	 R450aweHumAqM4snIaYgh6oXBr+vADQ/LNqMHF6/v1bDgTkUXp7AdR3nACZwE7mDBD
	 xVohNmoxXZiFYB59fJP9qMJ1kTDSVFikdcQBWa1XwHNn16YKIO+GFRaTIgeDej/BZD
	 nQo90tovI+ObH3f49yQg9F6Ul2wwdnE3yjDPMPjsVhCAbvMLyKZ7AYICf9xSucsvFH
	 GiNDVA9diqERo1F7aa/A5H8ry6X/+Og+aXztIM4Vdmeu3j66tPxziGWc+L24RufaUg
	 LoeyOMWeHsqUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 18/71] erofs: apply proper VMA alignment for memory mapped files on THP
Date: Wed, 13 Mar 2024 12:39:04 -0400
Message-ID: <20240313163957.615276-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index b32801d716f89..9d20e5d23ae0b 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -440,4 +440,5 @@ const struct file_operations erofs_file_fops = {
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
 	.splice_read	= generic_file_splice_read,
+	.get_unmapped_area = thp_get_unmapped_area,
 };
-- 
2.43.0


