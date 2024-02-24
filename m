Return-Path: <linux-kernel+bounces-79648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F893862534
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70091F228EE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5447A5D;
	Sat, 24 Feb 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5GnozRH"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CD046436
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782418; cv=none; b=GLdbBMx1rXV8UewgippgcI9rEU9bt1GNGCNUqP8WGYKg6vZs7FHJD00YUFPV8tiTQ3Bm8xkO7IEvjtJW0o9jB8k3YqRX8NRCZLmJfkGwjLVIjJ/MAvvkz3iBaa3P7fp/kcE2YL/gFdTdFbXaGNPfeZ34SWbWY8FijKsBFaYllco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782418; c=relaxed/simple;
	bh=9o4ItFnQkF0G7rDEIpOqVgLxMM11vE0VMqUAksQdmYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YoX0YRFr5sjZG5hBEJxEPpxyJafQSqypTHkwAtw9AWjSEdrZKk2Tzq7sSZfYLNjhw+I8P12uhsfaocdZfOhY6mcFPWrKuHqhn+cUPe3ykZQJrJX1eaYu+8m5uOOg2XQmxTPHtyi4rXro5P1FPuea/4OJKAsdRuWDQnUG/RvKDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5GnozRH; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R0N4mdAY/CNTfeRGszBe8GaA+/sz2rbWH4NYR0SsEuE=;
	b=C5GnozRHe5XmCcqz5SvmjsgVf95ZmodYUD55amGF7DYdFB9Zsh2x83jKl3IYFdrq6eAd1K
	LR44recvXsKiIeglG/WvxXD75EdIkkWfVRotkbmlvsxySTdHWtV/DGddSqccftOdBYbeov
	UwVn123fC8GgnPcN8kaU5x53CHHQRtk=
From: chengming.zhou@linux.dev
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] bdev: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:46:46 +0000
Message-Id: <20240224134646.829105-1-chengming.zhou@linux.dev>
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
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 140093c99bdc..e7adaaf1c219 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -383,7 +383,7 @@ void __init bdev_cache_init(void)
 
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-				SLAB_MEM_SPREAD|SLAB_ACCOUNT|SLAB_PANIC),
+				SLAB_ACCOUNT|SLAB_PANIC),
 			init_once);
 	err = register_filesystem(&bd_type);
 	if (err)
-- 
2.40.1


