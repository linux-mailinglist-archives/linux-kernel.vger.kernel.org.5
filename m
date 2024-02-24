Return-Path: <linux-kernel+bounces-79659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2A862546
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E58128277D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6D4C63D;
	Sat, 24 Feb 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rnZTlDbB"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142142066
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782511; cv=none; b=mGpOiaRl6HkmI8X7QC2qUNFtTvkoZL4CGiNkbjRscvHe7JVwF1H32JCIhwPrPWIhTdlc01VZ5v4HinqA77vJ5rtaNnAEo24HZQAsXLmPBLs4I3/IOHV3Xz29zQLupO4qmgYV3bSXciFKec6a96+vqZQqBXKSgPnGHwrYeCVOiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782511; c=relaxed/simple;
	bh=gjpQvFIgjZlHKyIkt0qRYUk2GAyjE8Smgcka3Izj1fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b6EG5u0Szfucj1dQ59x8j8JIKsb+bLKPhR4m4hnlTaYyxAuuYSJNnNlhgm4Rr6STgxHM51EiCv1lFegvde3kTAl7m+FoHTB35yZ+ErPV18OVEKD/79vW7S9+FD4oXpW9DBeWdW4AZe0qZd/12BmxWi76wyair2/JfAe0ldObWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rnZTlDbB; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7sBe7F6MZ5jdMe38w+z3gikhfjHHuKvxVMduY0ftaNg=;
	b=rnZTlDbB/wrrkLhpxFO4v/fyeWsmlhxAiCusqEiK3t4C4N9rYG00iBqZx2tCcFnV19t7hR
	1AH18VAfTs+tZJdQkr21gJBN5HcXTymc7wY6alOiD78WI8ShcMKPqoLuOGARF6bB7LIXo9
	fw7YKoS2dDb/PD00bbOQiwwcSVIRRM0=
From: chengming.zhou@linux.dev
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] ext4: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:22 +0000
Message-Id: <20240224134822.829456-1-chengming.zhou@linux.dev>
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
 fs/ext4/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eb689fb85ce9..9a744f22aa24 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1500,8 +1500,7 @@ static int __init init_inodecache(void)
 {
 	ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
 				sizeof(struct ext4_inode_info), 0,
-				(SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
-					SLAB_ACCOUNT),
+				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
 				offsetof(struct ext4_inode_info, i_data),
 				sizeof_field(struct ext4_inode_info, i_data),
 				init_once);
-- 
2.40.1


