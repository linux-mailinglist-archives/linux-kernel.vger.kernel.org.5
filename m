Return-Path: <linux-kernel+bounces-79689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0852B862571
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE421F21C08
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E384EB5C;
	Sat, 24 Feb 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nxghxwh8"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294D4EB44
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782806; cv=none; b=uPoqc9UspTPomvcvHFoQBg2s1C0J79Mi72OZCD5AQOdkGwE0I8p0JjZMw4ttp1nOSVYoNOzeeZLSH+vsdg8d7sv8uUfiukhDHp/kJ9wClfZIBqi+f3XAJmcunUGFLk9oDMd/s7D7fhq5mxFhHnZXFspRs5jDtBYGVxeEde15P2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782806; c=relaxed/simple;
	bh=bEGn2J5/QbumsNiNGa6Dgx6ckOXPMfjFRZxIVpHJI3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N86j07EB0JvN/OmiMHWkn9jSE5rVILx0wJWYrRXc/NZwwZ8AxcH57HI4D7fopoVvP+dVoZpR6ajjhXPtubndEy2AP6JhGMnTEnousPOJZJS4uXck+B9NsDxnuyF7sFokvlSnxrJEAGyDwDuNS+CCMQNnASe6Ws4CKdXMGFCFmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nxghxwh8; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SZzDSQYEVw7qQaWV6Jin3tdxUrvj5JLzXNMOrmaw1cs=;
	b=Nxghxwh8BomOvEVqvRFU9rM5RXLd1spVtFnx2sixHfrlTcIZ8C2XRf99P74E1E4ZY2SnIz
	nOj06ILSxCkSY7DTW78ShdLsBClP3ZaNCYNJYhROOEjYdXxSS66SrPFean4T3Fq7tEKlwV
	J71bXYgC6Uvhd09IVpVLlMaHAmWxRRM=
From: chengming.zhou@linux.dev
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] vfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:53:15 +0000
Message-Id: <20240224135315.830477-1-chengming.zhou@linux.dev>
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
 fs/buffer.c  | 2 +-
 fs/dcache.c  | 2 +-
 fs/inode.c   | 2 +-
 fs/mbcache.c | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b55dea034a5d..9a54077de87d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3122,7 +3122,7 @@ void __init buffer_init(void)
 	int ret;
 
 	bh_cachep = KMEM_CACHE(buffer_head,
-				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD);
+				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
 	 */
diff --git a/fs/dcache.c b/fs/dcache.c
index 6ebccba33336..71a8e943a0fa 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3139,7 +3139,7 @@ static void __init dcache_init(void)
 	 * of the dcache.
 	 */
 	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
-		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
+		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_iname);
 
 	/* Hash may have been set up in dcache_init_early */
diff --git a/fs/inode.c b/fs/inode.c
index 6d0d54230363..d2e8e3884b36 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2286,7 +2286,7 @@ void __init inode_init(void)
 					 sizeof(struct inode),
 					 0,
 					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
-					 SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					 SLAB_ACCOUNT),
 					 init_once);
 
 	/* Hash may have been set up in inode_init_early */
diff --git a/fs/mbcache.c b/fs/mbcache.c
index fe2624e17253..e60a840999aa 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -426,8 +426,7 @@ EXPORT_SYMBOL(mb_cache_destroy);
 
 static int __init mbcache_init(void)
 {
-	mb_entry_cache = KMEM_CACHE(mb_cache_entry,
-					 SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD);
+	mb_entry_cache = KMEM_CACHE(mb_cache_entry, SLAB_RECLAIM_ACCOUNT);
 	if (!mb_entry_cache)
 		return -ENOMEM;
 	return 0;
-- 
2.40.1


