Return-Path: <linux-kernel+bounces-79686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03986256B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC833B20BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6E46450;
	Sat, 24 Feb 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KNTFUq2Q"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A545032
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782778; cv=none; b=Ks5Y+fuA+CzrdXgA0Vd4Tp5JVMNOKjbckKGSaUusJv+Er05uFnzfvOvQyw9I7xAZmWy4XzNeN5kMJmIKNhI76rDC6lM+YxzSk5CQ/NNeZLhzKmrV3pmyd3VcVzoqg51W7Tn9TTTht2YOB5BA+2mAbupPIWbLHkZrQkczo7YXvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782778; c=relaxed/simple;
	bh=4xCZ87ofqhn+mZ02rNDXeZZ2CvHmguZE2SQHPTimieg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5EW6WUeZlLepCSTH0Ycd59gWaCYgy9zQ2dgTxmZdf/K5vJsaU7AJnjcVXySXCsj6ooOSw08nHGzypNLxctfmK5l7JaG4FBMpN4d+GNaX+Zwl5DjqEN+g5oGNMmlCqS9FD3ktZUAEIBVmyE1fS7+71ZgIUAyhmDALTdsIpBcl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KNTFUq2Q; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rYMFkq+ll6ODceL4IY+KD8y0LqHupyUnLzlW6j2Pb6w=;
	b=KNTFUq2QJy/ueeF02jeVLU72xmH5hB/LrAA+RGSQojawOzHq+kjLaykiwftObxZNmaH7Z8
	CniIlrxATBnpQQsmw3Goc0XLlEG684Abi+y9B0WQKvUBj9fhvXEZHYcqw9QgazP1d/y52P
	3T5rQywS0TQ25Fd3SFEIbDG4pYzCMxs=
From: chengming.zhou@linux.dev
To: dushistov@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] ufs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:52:43 +0000
Message-Id: <20240224135243.830381-1-chengming.zhou@linux.dev>
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
 fs/ufs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index a480810cd4e3..126295a9bb70 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1470,8 +1470,7 @@ static int __init init_inodecache(void)
 {
 	ufs_inode_cachep = kmem_cache_create_usercopy("ufs_inode_cache",
 				sizeof(struct ufs_inode_info), 0,
-				(SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
-					SLAB_ACCOUNT),
+				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
 				offsetof(struct ufs_inode_info, i_u1.i_symlink),
 				sizeof_field(struct ufs_inode_info,
 					i_u1.i_symlink),
-- 
2.40.1


