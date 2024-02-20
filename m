Return-Path: <linux-kernel+bounces-72921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B285BABB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A12C1C233BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0FC692EB;
	Tue, 20 Feb 2024 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPjn6G6S"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584C67E89
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429054; cv=none; b=NV/0ucRMBhhRjnHY4kmaW+gTrZUobYjjlYJiNhp5/gbXdcocYDd1l+bd8vcxjJceiVI2uMnobpQR+11IfOy9dbCusfVU6THel06xVRqeCRofZJTh3cUn6SVdVzfoRXMzu1pAGLg5hBg8NOMNdR6k/tHDZuN0/RPMcFF9w2nmkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429054; c=relaxed/simple;
	bh=4heB2Ziqn7TJxtytS2+rZO3pE9/2o+DwcPf5a+meqjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlDuC/0pMHZPqCP29x7MK4tklJKe2SkSYP8qekWCtVWvpl1xQKgXNIIJGdE9tXbQ5VGcEs1Rldc9aeV96iDkZnEMq3YVW/xEkkQG3gh8dOm0ve5f/Phv+SkM41g7fM+4Sdy+PV60lRURfEEJkbtM2ogUfXubB0nt6H30TxSsfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPjn6G6S; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92Vtmk4shKGDy68G7cvQyAOzVy7wB5PQ3z9H0ogo7j8=;
	b=oPjn6G6Sm/vrC4om3sEOub6fZmmj5FSnVFKEkEH7SgYTvgp/jDUgGz84ktCIkpOeFOxDM1
	aaZVmFQv4ip0oB8UG+ursJb5tM3HpMRXVGwjdzGBrp+dMoxzHmx+32D3PswWnuc04qd5BZ
	vjKroKX4jLtlQRmCUe7EaIrZA9EktAs=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:36:59 +0000
Subject: [PATCH RESEND 2/3] mm/zsmalloc: remove migrate_write_lock_nested()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-b4-szmalloc-migrate-v1-2-fc21039bed7b@linux.dev>
References: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
To: hannes@cmpxchg.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com, yosryahmed@google.com
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429041; l=2959;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=OUia51YESybtl45fp4ZaNAosIUgwtCmJ4/X7GVIhXhM=;
 b=8ijbXFuBVbIAfmOXcNTVodntrXfcwjB4acsw5QXCN052rSsXXdYpcn6HbsyCIPUDL5ekuERGC
 VMk9bAuraaKBIadh21NRdWVdE5N/IMKOvjmOxFePXE7syuPQng8VanC
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The migrate write lock is to protect the race between zspage migration
and zspage objects' map users.

We only need to lock out the map users of src zspage, not dst zspage,
which is safe to map by users concurrently, since we only need to do
obj_malloc() from dst zspage.

So we can remove the migrate_write_lock_nested() use case.

As we are here, cleanup the __zs_compact() by moving putback_zspage()
outside of migrate_write_unlock since we hold pool lock, no malloc or
free users can come in.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 64d5533fa5d8..f2ae7d4c6f21 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -279,7 +279,6 @@ static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
 static void migrate_write_lock(struct zspage *zspage);
-static void migrate_write_lock_nested(struct zspage *zspage);
 static void migrate_write_unlock(struct zspage *zspage);
 
 #ifdef CONFIG_COMPACTION
@@ -1727,11 +1726,6 @@ static void migrate_write_lock(struct zspage *zspage)
 	write_lock(&zspage->lock);
 }
 
-static void migrate_write_lock_nested(struct zspage *zspage)
-{
-	write_lock_nested(&zspage->lock, SINGLE_DEPTH_NESTING);
-}
-
 static void migrate_write_unlock(struct zspage *zspage)
 {
 	write_unlock(&zspage->lock);
@@ -2003,19 +1997,17 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			dst_zspage = isolate_dst_zspage(class);
 			if (!dst_zspage)
 				break;
-			migrate_write_lock(dst_zspage);
 		}
 
 		src_zspage = isolate_src_zspage(class);
 		if (!src_zspage)
 			break;
 
-		migrate_write_lock_nested(src_zspage);
-
+		migrate_write_lock(src_zspage);
 		migrate_zspage(pool, src_zspage, dst_zspage);
-		fg = putback_zspage(class, src_zspage);
 		migrate_write_unlock(src_zspage);
 
+		fg = putback_zspage(class, src_zspage);
 		if (fg == ZS_INUSE_RATIO_0) {
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
@@ -2025,7 +2017,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
 		    || spin_is_contended(&pool->lock)) {
 			putback_zspage(class, dst_zspage);
-			migrate_write_unlock(dst_zspage);
 			dst_zspage = NULL;
 
 			spin_unlock(&pool->lock);
@@ -2034,15 +2025,12 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		}
 	}
 
-	if (src_zspage) {
+	if (src_zspage)
 		putback_zspage(class, src_zspage);
-		migrate_write_unlock(src_zspage);
-	}
 
-	if (dst_zspage) {
+	if (dst_zspage)
 		putback_zspage(class, dst_zspage);
-		migrate_write_unlock(dst_zspage);
-	}
+
 	spin_unlock(&pool->lock);
 
 	return pages_freed;

-- 
b4 0.10.1

