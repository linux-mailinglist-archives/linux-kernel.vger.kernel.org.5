Return-Path: <linux-kernel+bounces-79679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB72862562
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48489282ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09573F8E0;
	Sat, 24 Feb 2024 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPrphNMa"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A142062
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782705; cv=none; b=Q+nkLNczdeDLpWx5TUt9q+tIKi3ivqZiyEEXBC7IeBtuEVqx/EORKynlCH3QCPYaJEEkg0ZkfmxDWhM7otF2xSrGPqg0GOD33E17ktIaXtXX3HrYBg9Nzu+gaB1u+GPyzWD3b7zl1RurvlEaostn/r8NZ0QlLRfKyizFivQpTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782705; c=relaxed/simple;
	bh=0HytFD/tyVaeJTvM/fgnatyML0f1wMEWMqwkSs7yR68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MYsHri94xrtiD6eyDeNk4bKN0Z1slzl74qmzDhvgXq2BcEyd2G5Mux8Gv6t819VPQvwV821B6jujr4yuLL7MzMT+AVdfX9arf435dJ/Orn3pBC+rYthBXGCORFM2KiIW/fhXtZgTKp+tZ7wDseWDFP1ZZzPKXeAbLVld4Fu5LdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPrphNMa; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CmJz42G9JhQx8iKY3mn6xzpqK7TOGtG9hztza61CoYQ=;
	b=mPrphNMaYGBWv+DMh+Kb4Mr255aGd1Qhdjpx5hlnxNq1IIAfL7u0XP3MswjXXySk92b21O
	oIiDlUnU+AWNBukXnugArhnEGBf5ZFyy6L2qc0efPIv5JlBQ2E1uEZq9eRzqG3UrjBQ1MV
	K0jTtPRo3UvIK7GI9N5TQ2/mcuNkWfE=
From: chengming.zhou@linux.dev
To: jack@suse.cz,
	jlayton@kernel.org,
	brauner@kernel.org,
	zhouchengming@bytedance.com
Cc: reiserfs-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] reiserfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:51:26 +0000
Message-Id: <20240224135126.830110-1-chengming.zhou@linux.dev>
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
 fs/reiserfs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 7b3d5aeb2a6f..ab76468da02d 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -670,7 +670,6 @@ static int __init init_inodecache(void)
 						  sizeof(struct
 							 reiserfs_inode_info),
 						  0, (SLAB_RECLAIM_ACCOUNT|
-						      SLAB_MEM_SPREAD|
 						      SLAB_ACCOUNT),
 						  init_once);
 	if (reiserfs_inode_cachep == NULL)
-- 
2.40.1


