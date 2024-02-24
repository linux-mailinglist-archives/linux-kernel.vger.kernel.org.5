Return-Path: <linux-kernel+bounces-79654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1924E86253D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D3A1C20E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81FF482C6;
	Sat, 24 Feb 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DygGrPT9"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37047F59
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782471; cv=none; b=MrNFqM4uRzVWWoVNK70UWtWzJoutyvqO56Qp3HfsMN8E05RH+mCGy/He9luKKQR8iir8aOAEjZWHtsDYGYRTOlDN0JqretLxggpFCdsg/iTTWs0mR+4M2C+ZbJ9dzaeRBhV2IL/J1tOPvra0kWNxA4bwdU2dOfklduJxl36wAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782471; c=relaxed/simple;
	bh=MnxFmmZlc6bm6/lKn+sX4uxeyVh8a20tKg8vCAqBINU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZUx5G5adwNXFmTxmpm3Ph22+g5R6/yzy1+7y0R37gWX9s+2raW5qBlal+nPaTQCk6g8n+Jt4FsbaB/GKFyY3qmitwXS0iDQPVjHeRPmJfVzqGbrAzCDZGrXir2mOcTO19+kZ2eU4EqthqBOwxX5xJ61AA8VYVyM31GQn2tzaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DygGrPT9; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MxLyvi/CesOdpl8bUomYtKdQqg/V7o5lynW7iESDMvc=;
	b=DygGrPT9wAYcu9Wp8nigEYTzm/4P0xHbUkyfUn9s7IQW5ECNhGGE6soXmRxP6pWWm7ZSlw
	TJb3qZHwyjz/6RrGbggt2lGNzjRhm0Z3nDro/BEl35BCYTDLDfb9QKRNSEl5cX9kyLReCI
	PyC0cjHmN18QnyR086UM6UgpRopRB6c=
From: chengming.zhou@linux.dev
To: brauner@kernel.org,
	bodonnel@redhat.com,
	jack@suse.cz,
	zhouchengming@bytedance.com,
	chuck.lever@oracle.com,
	amir73il@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] efs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:47:42 +0000
Message-Id: <20240224134742.829325-1-chengming.zhou@linux.dev>
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
 fs/efs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efs/super.c b/fs/efs/super.c
index c837ac89b384..e4421c10caeb 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -98,8 +98,8 @@ static int __init init_inodecache(void)
 {
 	efs_inode_cachep = kmem_cache_create("efs_inode_cache",
 				sizeof(struct efs_inode_info), 0,
-				SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
-				SLAB_ACCOUNT, init_once);
+				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
+				init_once);
 	if (efs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
-- 
2.40.1


