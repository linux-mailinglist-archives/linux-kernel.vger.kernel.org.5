Return-Path: <linux-kernel+bounces-79667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA986254F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41EF282E79
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15043162;
	Sat, 24 Feb 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="StsvjdgX"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CB47F58
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782586; cv=none; b=jDCoq8ksiKusYTgR1Iflz0B7/NTfpTTMcjhuAoJ9kO+4m3II+lyW33OU4E3PBiJLz3zg78Np1epcITIinecf0wz/M0dLxaC8TdpjXN7G4oUnc7TlVv9+T72VRCZ06Z8dxrqONGBc2zbiXemY0d/ssfcyAImnht+qs0oVre3zt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782586; c=relaxed/simple;
	bh=4MFdOxYZyXwnvdRHx0F3mEAjpWaAcsoYtGAnqfX0Rfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nu4wk6xAMiznESrGEUTEHXAQsakdDeMC4wE+2T0PLZa20bmGa95C9HXbgDcnpX33YQfU+u2BGPDsLh4sS2HqYnEhbVleq2X0Jopb8pnfDL2btCH3oK+OC2vYT4tjMi0C3iGCEzDn5H40mxQm2VBLyrGo98aKyazvl0pnSY2pnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=StsvjdgX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i4x53/DeAXqIuE63M4BYh0uJI9aRbpTRYh6DBcH50Cc=;
	b=StsvjdgXxJe3ET9i9V6PEo5Nq/3DBaGKQ59f34fgLmmQX0u2QLUxI1BjmE+QMkp6VR5PBj
	RiLlkC858MV0C52clfTPqdJ2f05iV8A3cxLpKZczKejWqgn7o8lNIvoHSABPjnS8gxZTmp
	coVThJqR/th/k3lVuN4SFdmO21PUvp8=
From: chengming.zhou@linux.dev
To: jlayton@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	zhouchengming@bytedance.com,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] minix: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:49:35 +0000
Message-Id: <20240224134935.829715-1-chengming.zhou@linux.dev>
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
 fs/minix/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 73f37f298087..7cbd2b9f4d11 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -87,7 +87,7 @@ static int __init init_inodecache(void)
 	minix_inode_cachep = kmem_cache_create("minix_inode_cache",
 					     sizeof(struct minix_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (minix_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


