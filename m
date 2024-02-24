Return-Path: <linux-kernel+bounces-79669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA301862553
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2273B1C21281
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230846525;
	Sat, 24 Feb 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TK1450Yc"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535E41776
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782604; cv=none; b=QJLaR2d1o+fM+w37ESH2J5+PJWF4MiS/nxpsAhCEbU4FzIGdLhcQawSemkpb5rp6q/HB/5YBiDcL18jolaybqmDBQyvRlm5lsh++Rc03lLGuzyNIskbuavOp9jIV2T2fnxt5pSqWmRgZpPpljLicZB7rv8iG8Qrvig0bzfclKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782604; c=relaxed/simple;
	bh=iVX51BWEAQ/tBRGRi7sXFK0Dh55yCzQr74w4x7cKqmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ABI68q8OkePKspD8zc09Yd3/5z3qpeIwK+cyM8Kaxuc3HcpcFXWhXqRVyJHSwNB0kKTWWeZqZ7B4Fm7WDgVTxvbY+/yc7PSoEmbAb5lSTBK/CIUwxLKo8aUklI7RywsRaxMpOkfnicrJ0w8CfGHNGoTh+zgKzjB73/OLYnSbtv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TK1450Yc; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nP0aXPHN1//zeHwFg1qsEvtNSGNzpSy74r5uLpS77GY=;
	b=TK1450YccZNtor9uLGphP27kTLtLNc47Ao+HxJdGlJkE8LqQM5lUk2FDIYEG71k4wAGHyi
	KfMjkqKe2gkyCJa624rG9/msV8bMboG1JxVWYueCac5JCMIWC/ci+G23Af8DgfwoU3Fb/O
	SOL+ldIsGYhJpDZ2bZUXC2JyRyEG/Ao=
From: chengming.zhou@linux.dev
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] nfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:49:50 +0000
Message-Id: <20240224134950.829783-1-chengming.zhou@linux.dev>
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
 fs/nfs/direct.c     | 3 +--
 fs/nfs/inode.c      | 2 +-
 fs/nfs/nfs42xattr.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index c03926a1cc73..7af5d270de28 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -1037,8 +1037,7 @@ int __init nfs_init_directcache(void)
 {
 	nfs_direct_cachep = kmem_cache_create("nfs_direct_cache",
 						sizeof(struct nfs_direct_req),
-						0, (SLAB_RECLAIM_ACCOUNT|
-							SLAB_MEM_SPREAD),
+						0, SLAB_RECLAIM_ACCOUNT,
 						NULL);
 	if (nfs_direct_cachep == NULL)
 		return -ENOMEM;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ebb8d60e1152..93ea49a7eb61 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2372,7 +2372,7 @@ static int __init nfs_init_inodecache(void)
 	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
 					     sizeof(struct nfs_inode),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (nfs_inode_cachep == NULL)
 		return -ENOMEM;
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 49aaf28a6950..9535ec133e93 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -1017,7 +1017,7 @@ int __init nfs4_xattr_cache_init(void)
 
 	nfs4_xattr_cache_cachep = kmem_cache_create("nfs4_xattr_cache_cache",
 	    sizeof(struct nfs4_xattr_cache), 0,
-	    (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD),
+	    SLAB_RECLAIM_ACCOUNT,
 	    nfs4_xattr_cache_init_once);
 	if (nfs4_xattr_cache_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


