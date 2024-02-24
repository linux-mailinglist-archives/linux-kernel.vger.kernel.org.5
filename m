Return-Path: <linux-kernel+bounces-79677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6286255D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4291F2258D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1BD4F895;
	Sat, 24 Feb 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BXIddex7"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33324F889
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782680; cv=none; b=oITMM/5ME0+jEnOS548MIkDo/itSy/WfR3cbewgprDF02UHtuMfhFEU3hOU7DNJMo6I9UZ5PYneSzbOUYWQBC1br1t9toc/YhPOaIy4W2la/nkAK0CiTaAVw1UXFXJL5YZwW3IX6NUTW2th6hBZD5j5V8nRvtyKGgA21la52V8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782680; c=relaxed/simple;
	bh=E8gOdk4qDXMZO4hZyBuAkJNFKg7KWxTReDB275QcaHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gh4r6K9oanibgg1pSeN0DrOyLd7ERrp1qmh1h27AMcUbp6EhwWpt6PlpRZm2fAzpMqzCjTW+TLx8jv6ShPDiArzS3wKCU+PeS7ky4yXNZw5VrrrfeS3iBUFJ8lmMqp+34jfi/l+Kvl2xoO+fucBGZrAnqvERn38Z5zo77KGfDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BXIddex7; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3VufTCS7F5iLOvmBR+64v/qes/CNnheC94yZv5dBp3M=;
	b=BXIddex7t4hgFaXDlKx+vVYL7H1e/QUSp7rnRTPinr23kgNU2r09Ro95/H7tIkkLR3FDA+
	9/ei7+QvGiQ/Z7mGdv2cEBNrdGC5C/fbBWZzupJNnpMEffs6f5nqEQM6p3OsgD8WcRHr+R
	Ko29xmi5kF3P7/xtLGNsaZxoaYGxLGo=
From: chengming.zhou@linux.dev
To: jlayton@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] qnx6: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:51:04 +0000
Message-Id: <20240224135104.830045-1-chengming.zhou@linux.dev>
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
 fs/qnx6/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index a286c545717f..405913f4faff 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -615,7 +615,7 @@ static int init_inodecache(void)
 	qnx6_inode_cachep = kmem_cache_create("qnx6_inode_cache",
 					     sizeof(struct qnx6_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (!qnx6_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1


