Return-Path: <linux-kernel+bounces-79664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD186254C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C0D1C203B1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BC48CCC;
	Sat, 24 Feb 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qyAZg+fA"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A5481AA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782556; cv=none; b=i3DOU97+d5Qo3FRGESNGKNoWyF5fsLtddu4eccybuPdNRQxj76iyi0zoS26QYRrT2v0uc4oaI2l4OYatfSIg3TzPZvScBB5RTr2hJvp0DdE8/Zm3PTJFagH4QY5hmJzwNubLuCdMFRfwPqJVOQzpX/fEkWRIzCADhEC9GekCwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782556; c=relaxed/simple;
	bh=fPm8z6Vlgh2x4u6W8NT6ATvsB1HvmadAvSYFjjUjFtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QvZ/auPPVcVwkVElyRsKMaZGLfVPderGJ700wk4fZEyJwTIHwGYDw4g6qsentNsPOfK3JMVA/CrtijdUnnHTiEmYs7U1bwFX5NXKZVIgcMWCQpkKIRPSxPViV2ubeSyKzz3IJ9NoeHj7MsvQeinmNEbiIHj2MClf6PC+XVLNcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qyAZg+fA; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qGy50kGciDjXed7i0CTgLTCv6G1RgEfykLkGxo6Hn9c=;
	b=qyAZg+fAG2npLmhJaRcfTYiHcbzw8usH4biZvxJPJBSfza8dmYkhp5TWjUFcX3bl12yAU4
	kEO+Fw117PJepxTO+JbBBIL1XDCkHTMG6AdiFaLLkzfeb8dniH6W8TKu2INT8S7f9EQSSx
	Ot8zncik7psFCaHjiuYhAvwYfHPoTTc=
From: chengming.zhou@linux.dev
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] isofs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:49:01 +0000
Message-Id: <20240224134901.829591-1-chengming.zhou@linux.dev>
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
 fs/isofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 379c9edc907c..2a616a9f289d 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -93,7 +93,7 @@ static int __init init_inodecache(void)
 	isofs_inode_cachep = kmem_cache_create("isofs_inode_cache",
 					sizeof(struct iso_inode_info),
 					0, (SLAB_RECLAIM_ACCOUNT|
-					SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					SLAB_ACCOUNT),
 					init_once);
 	if (!isofs_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1


