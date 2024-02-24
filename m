Return-Path: <linux-kernel+bounces-79685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5486256A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139C2B21881
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6C51C5D;
	Sat, 24 Feb 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gu7Lvroj"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2B51C4D
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782766; cv=none; b=vAFeCohTZ5b/Bn1bzE/bvg0vFI/bEeR4JwTQrSwNeNImYc6x0TK6LxoaLAhclGTSCXxILeJGrCCjMVAGRd2A54l2Pl5WdBmFteGIQFyNzl9HgNbUnN32MgoNu408LrwJjbQkAQIPpSqt9VVHbgDRyb6kQ1gfhj1rKZqUAT2ecF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782766; c=relaxed/simple;
	bh=0w+HfXhDLJYSWTbKNdiUF24fjGbx/cau0omwIMYpSRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MjFE/GdS2xcVoHQy7UDlJUjKFEee7614WddJZvV5/OiuRoPpakZF3qI9XNVkehllmnfMimOfnPZX4WKVPFfXDe0LDSsfadW+nE5BzJsrv1sZn4kqf7r3jHv+nXMW9CHGuXNeomsYBws5IdS9r8cN4NCuG5JhB5+owEBA9rZHuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gu7Lvroj; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mXj0flxlBa8suq19xooxsemKwp/hQv6FgMgJ88zOfL4=;
	b=gu7LvrojhDeXhS4C/2tcUJexYlLdYQDYoABf0DbXfz+szLPnlPukerV2ISuq6StBhn5cuQ
	mXzsauikz5NeGrcPj+Bgdu0mZhMxqe0WIYBxQoqzsKGKvtv/UiJUXQ4+QvPiZa/+ash3vh
	2PPOCmVIzE0Mptj7zQzCSqlrUoP1Db0=
From: chengming.zhou@linux.dev
To: jack@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] udf: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:52:29 +0000
Message-Id: <20240224135229.830356-1-chengming.zhou@linux.dev>
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
 fs/udf/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index adb39e08b2f2..2217f7ed7a49 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -188,7 +188,6 @@ static int __init init_inodecache(void)
 	udf_inode_cachep = kmem_cache_create("udf_inode_cache",
 					     sizeof(struct udf_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT |
-						 SLAB_MEM_SPREAD |
 						 SLAB_ACCOUNT),
 					     init_once);
 	if (!udf_inode_cachep)
-- 
2.40.1


