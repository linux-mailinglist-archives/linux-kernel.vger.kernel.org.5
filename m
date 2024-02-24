Return-Path: <linux-kernel+bounces-79657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC5862542
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55691C20E68
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ED3433D4;
	Sat, 24 Feb 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BI1C8Hva"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FA541C74
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782501; cv=none; b=aVz4aYuMKaLDjnbl5dhajdL2FyDd3/OA4JwfGnKS0kQscBn+46ASHrfOSu1Tc047NUE7OOcw8w8hG0wXef2w62aUcxK5pThQlb23b7WRO9iAKrXpvQNMUkFCO+1NsoQp+/zbC76n8AP7C7VPekFqTtJcPdaXgZs3wANMtJUF0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782501; c=relaxed/simple;
	bh=j6m4PB9nZL+Vs/fyNF5Wkaix8i5kA54i3RrzOAcSgV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFwqREWlYHkVzEJ+HVACFE4JbseqyjYyZ+LWLPvz77/kBzNKA+Ry6+BIwDYUNkPJwP9nzgOULO08IPN20qZYI3cufrwksJ314gQPqePBLnDsVegsRkYH5KSvLHZk3iFcA2bMyH1+kDXLgiL7xY2V1fb9zqpGbnoU/ZYHJxSiNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BI1C8Hva; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gM2elDK8BW00zbxGp1C738caKYJ1uhpdKk71pGsCu7Y=;
	b=BI1C8HvanvpJ4+pbCCjt7e+Hogey6YRVqmNgbMXsOKbaPCqHFmPRAjd2h1s9AE4Rjt+HpF
	PKbR2lTX42RIUWEOCquQhHJi2jOlC+GhI3TZQLat66yKDQHaYstiLb/ZNmD+DhhQFkGYXd
	ZEagBqUmp2uGVzVJUjZb0Qm794cZY48=
From: chengming.zhou@linux.dev
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] exfat: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:03 +0000
Message-Id: <20240224134803.829394-1-chengming.zhou@linux.dev>
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
 fs/exfat/cache.c | 2 +-
 fs/exfat/super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 5a2f119b7e8c..7cc200d89821 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -46,7 +46,7 @@ int exfat_cache_init(void)
 {
 	exfat_cachep = kmem_cache_create("exfat_cache",
 				sizeof(struct exfat_cache),
-				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+				0, SLAB_RECLAIM_ACCOUNT,
 				exfat_cache_init_once);
 	if (!exfat_cachep)
 		return -ENOMEM;
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index d9d4fa91010b..db6a2ebed94b 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -811,7 +811,7 @@ static int __init init_exfat_fs(void)
 
 	exfat_inode_cachep = kmem_cache_create("exfat_inode_cache",
 			sizeof(struct exfat_inode_info),
-			0, SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD,
+			0, SLAB_RECLAIM_ACCOUNT,
 			exfat_inode_init_once);
 	if (!exfat_inode_cachep) {
 		err = -ENOMEM;
-- 
2.40.1


