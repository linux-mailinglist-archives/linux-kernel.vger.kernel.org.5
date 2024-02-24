Return-Path: <linux-kernel+bounces-79676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85A86255C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8D128283E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9434F20D;
	Sat, 24 Feb 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmiHS760"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6F4F1E2
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782666; cv=none; b=UM4GmMrQOWpjCzWw09Ke6CG5BtyDi9wLz0TCiZC1JANtDSBjfAxTCnyhmHzKgpLSSqHIPfWFCHgMBdbU4A0ZzoG41wZbSKvi1aTxcJ6ohBD11Zxxq+hpukGkLNJSeSu/RXdJrp5XVlpqf3aq5R5ImRXJ60Zj2bv/0tv5HVqe9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782666; c=relaxed/simple;
	bh=wl08YTsGOyV0uYb3qAMrkDbzG88wVeA9z9Yorr+gl8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/1dJM5osX2D6laZVY6lavyQhPnefzCOF1ke0XoqGlB7J5sA9SMRo6c7fkpSJ5M8VJ+jBZIU1ce0NG7GWciDjskiGvVFjiam4WzHprbl+06gyqTSvHRrSIxR/tXRgm7Yws1BkZ+IWNJNBAp7MpgqABozAI2gxzDzEjXaOu34ydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmiHS760; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=74hjnfbXzM8xetty/Ed80q8BUXl/uQI6df4zjuHD8Vw=;
	b=qmiHS760GDgKjG/a0wRBh7B4A5YMiZLOpWfGIYXZ+DAhyHt525NTNrMDKtUxYi3g+WMTO+
	/aliFpbp8CXqeuxme2KANYK3m+lJQVaSRsr7E03mon62cGscGPUXD9tebBp4+eF+nujfxU
	SvBsdOqQLcZtObIavSM6Y9zceCtaLus=
From: chengming.zhou@linux.dev
To: al@alarsen.net
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] qnx4: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:50:56 +0000
Message-Id: <20240224135056.830013-1-chengming.zhou@linux.dev>
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
 fs/qnx4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 6eb9bb369b57..d7a77040e42f 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -359,7 +359,7 @@ static int init_inodecache(void)
 	qnx4_inode_cachep = kmem_cache_create("qnx4_inode_cache",
 					     sizeof(struct qnx4_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (qnx4_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


