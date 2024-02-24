Return-Path: <linux-kernel+bounces-79698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D430862583
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E23CB20BA3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB145C08;
	Sat, 24 Feb 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qdYCT4F6"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB641238
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782970; cv=none; b=Y31zbSbi6f3wS7mxhPEYthq+BbBru97RStnVlTtzBIZUj/70zaNvu4tUKVlPe8Kp+13dOtJ9mTSB+e4uCFOsttKWb2/LDRm0uQO9eHz3w7+G5VNR4OkQlxzIJ+eGyJZMQ4RV+LY8Ic1Zdtw4JdLKsicO0fNijvjXcXgaEXA/+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782970; c=relaxed/simple;
	bh=wqU1XIu/v+XLJI/cRmz79wFtMQmM13m29GLow/wRHpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jh/NbQuwW50i5VdaeFnWRVqJRLlIOrLcaFgksDMUMaBMWThFHst/IwdUhl8nmiQS2ipZCs+6LM3R2qV+x+LuvfmEgdsdYK34EovtBUy5fgFR7PhdhdKgouMOJn+WeEgB8pCVNn30PrU6PAJmGUfxXG3EACoi4t4KOv0Oqpk5Gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qdYCT4F6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H3/ymnu2bwzOG1xtj6BGNVzrZoT5h88qsVffWfbXE5k=;
	b=qdYCT4F6bz4Qe/0lCwpHIJfEh2rWpncewCx1qRED1tdIAiGTo/SN7IC2h7uHYtwjkLleZ7
	1JoxdJfsml0uU5urGOe2IMY6u8HJks/QbKXk/vVkuvLPabtO1Wx2JklOpgQhngj2eKphPO
	Hi2IXjP5t5qNguzlKBi3zg5dx68Mc14=
From: chengming.zhou@linux.dev
To: jaharkes@cs.cmu.edu,
	coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] coda: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:56:01 +0000
Message-Id: <20240224135601.830560-1-chengming.zhou@linux.dev>
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
 fs/coda/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 479c45b7b621..9ce6b9929bc7 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -72,8 +72,8 @@ int __init coda_init_inodecache(void)
 {
 	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
 				sizeof(struct coda_inode_info), 0,
-				SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
-				SLAB_ACCOUNT, init_once);
+				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
+				init_once);
 	if (coda_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
-- 
2.40.1


