Return-Path: <linux-kernel+bounces-79662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD6862549
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA701C20F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9644C3F9CB;
	Sat, 24 Feb 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ms/zeVZy"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD94D59B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782536; cv=none; b=B8Is323zNZGz87jm9YkNRajmxVg0bCosKiZkQxGqC2p9RXgfVVHZnm/0KtPQ2162fUvDeK9+ncx8jKS3DG/CPCuIKD/fAuNqbLfsJf8QMJKwwg7vMRxoFCQhj4HqgVMspYyIp99N4QXCOJiZaAj07mlNFzbPEOz+IigrwomPuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782536; c=relaxed/simple;
	bh=y2pUB53F1wMAZ04nzFKOITyd4dvsaa9cjjMHjK96d5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=neITvV/zq4t1cDmWhXb0Q1LWciMLYUJitqLBfuZFuMT4KNk/zsinyibGbVkr4JqP1q8GHVGoYFJD7zRe1yXYwBKuVQVo/COxc5gKJz4o75CR2VHJldenzaIr6oTpDKCOL/i+iI+qJrMQZVFZp4uxFbQm1m21yUGZRSkRWndj9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ms/zeVZy; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rikMo19CagWQcspLQnXP+zWMLIAYXL5i/D+P5ICzeiQ=;
	b=ms/zeVZyBJ5AE0Ryv8ygow1uTLiltSGM7YRvR9KT3WlR5UcXaXJ2GENMtdT3zBCI/rgEAi
	7Un6qkTkajDJJz1lIJvGijrmeMRnBu0hxFcnrv7SnqsUwrkhmKNVidnFyzzCNgBYMcN+OW
	FGzABBKfQhgjeZNO9TeKoMOlyLu98BY=
From: chengming.zhou@linux.dev
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] gfs2: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:47 +0000
Message-Id: <20240224134847.829536-1-chengming.zhou@linux.dev>
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
 fs/gfs2/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 79be0cdc730c..04cadc02e5a6 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -111,7 +111,6 @@ static int __init init_gfs2_fs(void)
 	gfs2_inode_cachep = kmem_cache_create("gfs2_inode",
 					      sizeof(struct gfs2_inode),
 					      0,  SLAB_RECLAIM_ACCOUNT|
-						  SLAB_MEM_SPREAD|
 						  SLAB_ACCOUNT,
 					      gfs2_init_inode_once);
 	if (!gfs2_inode_cachep)
-- 
2.40.1


