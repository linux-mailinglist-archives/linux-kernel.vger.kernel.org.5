Return-Path: <linux-kernel+bounces-79671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A479C862555
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFE11F211D7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E7481DD;
	Sat, 24 Feb 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tiiXBZVQ"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837B482D3
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782630; cv=none; b=qlFJpQx3uL+jfE5zvg2RwVIDVGj/QHl6DAOi7an8EwzuVklKbEYdiK+oqL0mP856ki4C9sDFCWIKOd9SYZCILTwYP9EIQ79UF0hDgfYqQO/fZmnHcpufpdmURvToWfbI1lYzY6hwVHSpWQ1/rV2HGMHZY7TDNX9u99xwPKWUTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782630; c=relaxed/simple;
	bh=HmRLhF5fb+Bx1Evyd8/oJ99w7ry44Kp+JXWgUAabeOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ChztU6DZZay5rpryZzOCmLcN5vcxWl3Z3IrdzJREM8TwTm6HSDwZ09LeMeb81BDE1WfNHJ5uGqGFqHF+0HSDrtM1n49ddyopsPhkWffRIbOPGilpqnYy9+TfVKJLxbw2Bfc7FyrnCZHxKUifUCgA8CUIupXoRKoRQOY21f5MI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tiiXBZVQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aelfqzuJQ6T5UUNCOQe5JJFs8b0Xd9SxQNCpIqfAQRc=;
	b=tiiXBZVQ1Y/oLjmYvX4+W419ToA8rTtL7C5bppBEEZ7ZO3YBGcnqzMf2FQnmPmBNEtPxDj
	WRzUCKc4s+tH8F0fDoqamCn444/YjoPfdL1FHSquiL0QrIOJ8Ox7KLOkxqelI3M7shBl6q
	im3NvQqbeNrIHrk3fmROcSVrLJtFS+8=
From: chengming.zhou@linux.dev
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	keescook@chromium.org
Cc: jack@suse.cz,
	zhouchengming@bytedance.com,
	azeemshaikh38@gmail.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] ocfs2: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:50:08 +0000
Message-Id: <20240224135008.829878-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/ocfs2/dlmfs/dlmfs.c | 2 +-
 fs/ocfs2/super.c       | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 85215162c9dd..7fc0e920eda7 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -578,7 +578,7 @@ static int __init init_dlmfs_fs(void)
 	dlmfs_inode_cache = kmem_cache_create("dlmfs_inode_cache",
 				sizeof(struct dlmfs_inode_private),
 				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-					SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					SLAB_ACCOUNT),
 				dlmfs_init_once);
 	if (!dlmfs_inode_cache) {
 		status = -ENOMEM;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 014c22c4d9d9..8aabaed2c1cb 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1706,18 +1706,17 @@ static int ocfs2_initialize_mem_caches(void)
 				       sizeof(struct ocfs2_inode_info),
 				       0,
 				       (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 				       ocfs2_inode_init_once);
 	ocfs2_dquot_cachep = kmem_cache_create("ocfs2_dquot_cache",
 					sizeof(struct ocfs2_dquot),
 					0,
-					(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD),
+					SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
 					NULL);
 	ocfs2_qf_chunk_cachep = kmem_cache_create("ocfs2_qf_chunk_cache",
 					sizeof(struct ocfs2_quota_chunk),
 					0,
-					(SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD),
+					SLAB_RECLAIM_ACCOUNT,
 					NULL);
 	if (!ocfs2_inode_cachep || !ocfs2_dquot_cachep ||
 	    !ocfs2_qf_chunk_cachep) {
-- 
2.40.1


