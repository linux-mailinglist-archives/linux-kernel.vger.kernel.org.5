Return-Path: <linux-kernel+bounces-79678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D1F86255E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065801C20E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9BD50A9D;
	Sat, 24 Feb 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uAB3KPMs"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2B50A77
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782688; cv=none; b=kK9K5AW1mLlXn4x/5NEEFO+8vKMqQ5VaZVkBYovmC9HzzUio4wG+kNW9UG0wmsOl93asI5RI7lT9htDDEAY+P2jIBbaI2ZyWaH1ww6NE8n/ln7yNf0eQDDsa+k0N9XOAikS1uc/2iUpBWpG8XZ9fZ14tyICA+FVWTq4UCd1Dy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782688; c=relaxed/simple;
	bh=ZdxhMHTzVuF1/QRR0hmv/QxCt/0niezpDusZgVtbK+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwSGXUBrEj46pn3ekstJETcSO8bgWAcUaFqSzIDNxxtfmdYHPCIYEuQRIwXAmvwMV1PYdsx8vbd4KXIjZ6j49qtKm5GjVTz9IjdtBZxqGC+oYsvBGqGosvKsQk2cJzrTj/c0ceSE+ojWfkn1V/Isx+sor7EoOdfi8+HL+hq+5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uAB3KPMs; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MjX/9EEuNZHjYwrAKJIFj1taYVlhVUommGLkaI9bk/8=;
	b=uAB3KPMsDCjoBheO/BHqojYw/qMRszfN58BfMoHY0H5+r+uWVSYhVppQpYXzrUKLkYOIft
	kWGDLe+B3g1ZZ6Kgw5RgZm7CwMc+RhswrGmfd6ktbLc/RnQbtfy5R/S/mIiikFlnF0rp3O
	SWHzsTFRK5hu/YU+km5IT5KmZ4tyJNk=
From: chengming.zhou@linux.dev
To: jack@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] quota: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:51:18 +0000
Message-Id: <20240224135118.830073-1-chengming.zhou@linux.dev>
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
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f73016c7bc39..dacbee455c03 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3008,7 +3008,7 @@ static int __init dquot_init(void)
 	dquot_cachep = kmem_cache_create("dquot",
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-				SLAB_MEM_SPREAD|SLAB_PANIC),
+				SLAB_PANIC),
 			NULL);
 
 	order = 0;
-- 
2.40.1


