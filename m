Return-Path: <linux-kernel+bounces-79682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F78862567
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0C71C212FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7A4D9EF;
	Sat, 24 Feb 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PWHQCkLC"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F854D9ED
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782728; cv=none; b=C+XiNDhOdSaljqL0pLElTN7KEeyGLCqN7aIKKRl2SfDq0skeQ+VXKuJnncn0Cb7Rfloj75YvFHRUc0dZvdMfUYzrpYCfwDEHdsVmFha6EUIKrstI/WOJ/esl0oMkJgovQSCRXmF/MrJsvPpnoqO1lytv3bZHvgFWh+l9011I6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782728; c=relaxed/simple;
	bh=pAAAxXuKk3bDEpM1Nllu3MJWcu5wPZETzx26K/+WDoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmCHNH52GxpvQiT0BVwwS04HKIZSflkH+ButyO20mMvZyuEGX73pji6My/aqmV2HyqKl8HCoPMyqqtyVKWDFipFmx4g1pNYv6wRcDd6XSFoF+fAkaBmfiKs8NE1G1L4rqQHmCFBKJQRgh0HobBNd8NBH2Hqm0D4i2RCm48sTB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PWHQCkLC; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ND9qkOV1UkP+sYsDXzGAEHeSsE1orS6VTkDbzqTzyZA=;
	b=PWHQCkLCZpj6yvd7E9Te5q8UpIWPTPXkDxyeP31TCjoPntb/hlfLzFWHVLHZNXBVizijXf
	gW5duMB5UbKtLobD0OuRXEQqlXgNFYtray9DvaQ5E4avxbbOEpyeJqVffkaUSMMQn4ocBg
	K5EVfpNTVQuBNCzR4PRxk5AxCZLDaHI=
From: chengming.zhou@linux.dev
To: brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] sysv: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:51:58 +0000
Message-Id: <20240224135158.830266-1-chengming.zhou@linux.dev>
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
 fs/sysv/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 5a915b2e68f5..76bc2d5e75a9 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -336,7 +336,7 @@ int __init sysv_init_icache(void)
 {
 	sysv_inode_cachep = kmem_cache_create("sysv_inode_cache",
 			sizeof(struct sysv_inode_info), 0,
-			SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
+			SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
 			init_once);
 	if (!sysv_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1


