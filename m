Return-Path: <linux-kernel+bounces-79660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BE862547
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B6B213AA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CE446546;
	Sat, 24 Feb 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDQ23ZF6"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324145033
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782517; cv=none; b=jGbnu3hE/QmO4RLm4qT+ddju6UBrHTdlR7GhlQQgJNZ4kzdDX6/CBRiPJRpmfKwj2310C7p3ilTPpa6a5zy833ZX4SzRmO09FmXoPrm8WuNsevaq+VsEJBPi6fFmSrjkw0JhyivfDR5sadYJFDhgJ2ZQym8AnFxFFPsIfyYS5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782517; c=relaxed/simple;
	bh=ertTpHNzHgvw/tcu6bGp3eJUxO9Om1YFcu8QmASi9Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bDexPzMJwPuJjUwT2aPN5o4a0rexsPdS0LTNyjBaLuZDhGJ0juVtZqwAznOxq3HVT4s3vgpvtj8/oz04sTFKkXzR5ZZa2FIq5IJ08GuUGXa0zLwSLk5y3oNTlBn15GfsPfFVHp2htJE8sOYD0dE9H1drg1aYHkx8QMD73vxWiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDQ23ZF6; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Fo8sWlJ/uC7ypOrDPbM48EYETDoNPASkWu9rXz3QtU=;
	b=qDQ23ZF6BmdATLWcSP9PPVNVJy3YvqNe1TwF09qvESimMzZVKjAhgMu6ogWFCmBB3LfzZP
	3YgiKpWCWCyUHP1XhBX8Xt4jgewJnCisZrfsqxUM2qmHz4AQJTduZZFb/3wjYGN/5pZWGZ
	1GuGD04CaJKvFw8HUl/O398U2l1fRww=
From: chengming.zhou@linux.dev
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] fat: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:28 +0000
Message-Id: <20240224134828.829481-1-chengming.zhou@linux.dev>
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
 fs/fat/cache.c | 2 +-
 fs/fat/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 738e427e2d21..2af424e200b3 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -47,7 +47,7 @@ int __init fat_cache_init(void)
 {
 	fat_cache_cachep = kmem_cache_create("fat_cache",
 				sizeof(struct fat_cache),
-				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+				0, SLAB_RECLAIM_ACCOUNT,
 				init_once);
 	if (fat_cache_cachep == NULL)
 		return -ENOMEM;
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 5c813696d1ff..d9e6fbb6f246 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -787,7 +787,7 @@ static int __init fat_init_inodecache(void)
 	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
 					     sizeof(struct msdos_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (fat_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


