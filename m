Return-Path: <linux-kernel+bounces-79666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9586254E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7287A1F22FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232242056;
	Sat, 24 Feb 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a2CtTmIs"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9328E3C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782577; cv=none; b=mOXOIgsUoFNJ90gP+DN1UgCW+h0QGWc5r0NORcXY5VjphbDFsk6N00ruuW1UubgIocMSsmLIDWjT5FmlEPWillLBzr0T4L4Yp3XTqpsNQZDV5NIUTOJcsy9cvFKAQBXSMYeqBd9XoUM8YJNtfXFIZkvaw66V4YnmqJwnkBjEisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782577; c=relaxed/simple;
	bh=F7G686b7Abc0cpBWp4Y7+mtkigyVLN6ul/isR1ksPWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TOh+XQkWtnge4vwDD0HPoE4ymVvyCtj+aFOniDb1QP1TIV2ncQSsP9sIlE6DCRB8/ldfFdLtWD/gxTsJRoG0d/gIgMYgYqpKChUDQCfCRaAdvrlAXo4J7D4lMPqxI1EhWjzo8U/CfZmnXXpj/x7pIQ9xUB58Cou1uSRzOif1dCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a2CtTmIs; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RjzkEuT2X9YH+2nQqDYsuYIdSPZdn5kxHlvSnIWCZkc=;
	b=a2CtTmIsMTLRqT7yJ/7XVHv3+mE8p6Ghfpc3swFYnUCo7x5jRJyixOJwZeo1YCjHJ9CPdk
	xcUe4yq1tNI+EyXffBVllc0KNcnbRj0yVM4zzfOauN3g2B3j8xpnh5aZCRdvWneYuqoA1v
	fI+M6iNAc3h3vQAOSwhQmYPV2YeMcyQ=
From: chengming.zhou@linux.dev
To: shaggy@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	zhouchengming@bytedance.com
Cc: amir73il@gmail.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] jfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:49:25 +0000
Message-Id: <20240224134925.829677-1-chengming.zhou@linux.dev>
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
 fs/jfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index ff135a43b5b7..e1be21ca5d6e 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -932,7 +932,7 @@ static int __init init_jfs_fs(void)
 
 	jfs_inode_cachep =
 	    kmem_cache_create_usercopy("jfs_ip", sizeof(struct jfs_inode_info),
-			0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
+			0, SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
 			offsetof(struct jfs_inode_info, i_inline_all),
 			sizeof_field(struct jfs_inode_info, i_inline_all),
 			init_once);
-- 
2.40.1


