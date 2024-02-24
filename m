Return-Path: <linux-kernel+bounces-79684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F11862569
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE2D1F2305A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADE4E1D0;
	Sat, 24 Feb 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GsrWa2qo"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFA4E1BD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782751; cv=none; b=Sm7CmIYSn7Sur/uqVGXFZzZ0Mn6dm/HwfQQqGZkMTqJNKSO+3N5qLQCzZc9vUYXg+ZATxSIkrdrm2MrwEa/bVStWbG77mpFvUm1+l1gYOIhNsLnL45fzeGkAxJSmguYDXUXWuqggHw7MU28r0ItgbLrMMSEfrNusP5yAiVvyjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782751; c=relaxed/simple;
	bh=Tz6THqrHvtchIgwhGtEJU01NYlucwhimzkFZKcdzw5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZDZ9ujS4oIEh4pqwkzPzTZdzRi95Pao2sZa1inT9GqffnRQXgDrTMq5aVkuJzkepvAVo/Afz/x8N2xR0/6dNZqqz7KMgasRp4IEBbqJ/9NpDD9vXNct2NDp1+AjEEyc9zxNwWJd+x0NnVl+Pwc+250qE21A84GCaiKunn4AyAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GsrWa2qo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=URTB6rIWK/XPxRdAWncFE1qTwzE1f3lanP0572+Z/9s=;
	b=GsrWa2qoDfJGxu2TTHaWuOK9G9PAz7e3ZFqKC1y/RVkFjvDZzpxngfDyWPUHtkB6mCSf9d
	++vFoldKPsG2M8FsluhNQjO7pvS7fIdyPvZXaPlgfKi+GNWmDawTCFrIR7rjRDUzeIaO2X
	pz/tdDyWBiLwppsBcW7jbq+6WLSt11U=
From: chengming.zhou@linux.dev
To: richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] ubifs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:52:17 +0000
Message-Id: <20240224135217.830331-1-chengming.zhou@linux.dev>
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
 fs/ubifs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f780729eec06..8ae7648021a8 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2433,8 +2433,8 @@ static int __init ubifs_init(void)
 
 	ubifs_inode_slab = kmem_cache_create("ubifs_inode_slab",
 				sizeof(struct ubifs_inode), 0,
-				SLAB_MEM_SPREAD | SLAB_RECLAIM_ACCOUNT |
-				SLAB_ACCOUNT, &inode_slab_ctor);
+				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
+				&inode_slab_ctor);
 	if (!ubifs_inode_slab)
 		return -ENOMEM;
 
-- 
2.40.1


