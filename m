Return-Path: <linux-kernel+bounces-79645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F388E86252F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94417B218E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955117BBF;
	Sat, 24 Feb 2024 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M3xfCMXr"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70419E559
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782393; cv=none; b=niyFAZTFVNMcBam/CtuwE8vtOwbnwsvE4w17XxPxRrvA2kIstyJCAuKsGn7m/2PZM2cvHiLQoO9gqoKpDLF5M+i8A7SJ0rQd/4Yy9QwPXZ9aNdSRPWgmHItNtrL42pZcqkDji19Wd470tv068Rm+QQJ8M76jNbOn6bvlKFHryCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782393; c=relaxed/simple;
	bh=znUWX/WHxO8E1DbbTZpiulV0UzSDhdKmfWMj15MOtIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jsdXtSVM4XsBOGGYkUjxxbGZF2U++w5VWgybwlePNTGBU/RY/09Vk31gUBgw5MHYcltDA0qYSru18MgIsCKXlEB/AocrfQdi/3GYEAKAfToPdHGVS0FdWumNm5gHkJXxVQYveJowshsOwaL1BplnouPS7x7jvYTH3/+9HLYTnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M3xfCMXr; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xPD7kQrj4QVbyIPYEPjgeoIpw5sjNPJYGKf/24Kh9AY=;
	b=M3xfCMXr476j/PJU5PkafSSrNC1/XpanlWyf+pMtahIvilWPTFF6BiCr0lbtfrBJrgEj1f
	m2e+Mq6e8ebaxVQVXha97vHCKqAXNy4vFT4RpdpjckByIjdfzAOTOwvF6J1R97+Wt9sxOk
	aeqiuWKo8wFd/C3/a3AbjwY5hzlHKPk=
From: chengming.zhou@linux.dev
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] 9p: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:46:17 +0000
Message-Id: <20240224134617.829016-1-chengming.zhou@linux.dev>
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
 fs/9p/v9fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 61dbe52bb3a3..281a1ed03a04 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -637,7 +637,7 @@ static int v9fs_init_inode_cache(void)
 	v9fs_inode_cache = kmem_cache_create("v9fs_inode_cache",
 					  sizeof(struct v9fs_inode),
 					  0, (SLAB_RECLAIM_ACCOUNT|
-					      SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					      SLAB_ACCOUNT),
 					  v9fs_inode_init_once);
 	if (!v9fs_inode_cache)
 		return -ENOMEM;
-- 
2.40.1


