Return-Path: <linux-kernel+bounces-79650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A90862536
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5470D1C20D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9A47781;
	Sat, 24 Feb 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tsd/xyA1"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC84644F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782431; cv=none; b=oR0rMnrn7gGMbTzgWy8ZqHMV30jXUgiMlm+rtXd5W/IBxpSqHVenK1I0GvNYM5Kkcsid3xqh3JpGfdgk3ef0FZx0LrXCyYXAzf5zDYMMBNRaiXZmYWCtH5T57PP/Razi90NakW8dtivDahQqy7O7FPCqmMuoA5koVWOx0zgszAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782431; c=relaxed/simple;
	bh=TFxpZgRuXyayLwRk90/gD6Q+/TLLRsVLR9K9/viwGUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hq/6weK4cxjHY2etJC8Pz2AL674SwxaYpQyO9QPz4heTXKL8lxlK7xvkyvBHmBNvZ9kC72xW9Xso+gxXn4cVxeZsM2O4flzfDsq64oVC3jhPa/TGE4DZMS4luRaz3uO+rqqDVgdbrtmEyS7LG6ppM7Tc+FOiEfiEAitvifVMbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tsd/xyA1; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q2kG9oqrXG5qM53wu9asQlqYJaIcQZWOeDEdQ25ayqQ=;
	b=Tsd/xyA1er8ii/mqCEL0IQ5s5P246ktrd1uTYfD9SAQeBOHGzvcU1bAhPC3hQXE4g8M4rP
	Scgj7roLfE3hbfvGVFXWiLoF/9Xxmv02p58XvNajrM9Ontj3AHIwLY7o9S8mkbAzEmPI0R
	Ir0BtJmiG3J2brqJr4mvNsQNtnoCURg=
From: chengming.zhou@linux.dev
To: aivazian.tigran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] bfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:47:01 +0000
Message-Id: <20240224134701.829157-1-chengming.zhou@linux.dev>
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
 fs/bfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 355957dbce39..db81570c9637 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -259,7 +259,7 @@ static int __init init_inodecache(void)
 	bfs_inode_cachep = kmem_cache_create("bfs_inode_cache",
 					     sizeof(struct bfs_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (bfs_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


