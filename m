Return-Path: <linux-kernel+bounces-72922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1385BABC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449DB1C2127F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E56930E;
	Tue, 20 Feb 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rw7EWm1j"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D86692F6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429058; cv=none; b=mb5W3SOX/TovIJx2qeRb5Ij4UQoOBFUA53E3MLo7dSrCu/0+r4O+ZzFjBbhCI5Sz1RvwraH8GI6DkLhc/Wt2L9DSQbOZvPokuoFRN/sQYzhMxTsciBR4aQzEWCgFhqQ5aVGXrpV8EH0k8gLhrScEvoWjfebZXsdx66MOVgUNVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429058; c=relaxed/simple;
	bh=6InzT0zOMfVSMMUoPS5SFnvU1MpP5NB5EaOK+7nKFWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OL0uyn/OCHrncDp8cYTcOXlSWr9DgIxH/tQ7Mcdy9968IuYceOZiM1tf4nzpSzmMEo03SgeUoLmSm6Gh17/QWrOC0dSrTkFNd8TGazgCm1sIEr4C84tkHLPu/CrdAs8Mp2g2ZGDS0x6WqqptuFafAY1w5zIwdy91L0wwJ5Fcwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rw7EWm1j; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+Zlu/jyffC3tcPYynjlrJGPDukZUfRAC+HVlLoluho=;
	b=rw7EWm1jRAZ0ejyR0syJMxY+LC8andr9N4hT/S2TcsUdJVzr5zpj1ve+7DC0aFKLOP6Zh+
	oQAbX4OcdcWxRXxp0WVl9onzMqu+Bu4Srq5jwKDUIbVPErTVJ6F3iLf7W+N/3VP2mgkjg8
	CojlsKYsoHjEm5Q7HClBNZpzfqtRCIk=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:37:00 +0000
Subject: [PATCH RESEND 3/3] mm/zsmalloc: remove unused zspage->isolated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-b4-szmalloc-migrate-v1-3-fc21039bed7b@linux.dev>
References: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
To: hannes@cmpxchg.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com, yosryahmed@google.com
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429041; l=2725;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=4NV6DsrM5S+/h7ppU/k8FOJs/bnqzH3nRRreQTC9eDs=;
 b=kFZpk3aIR7kadOlGiYlEg29vShKRkOcKdJVmvW0zBNOCVbMMCVgKRPWfv2u+eEVnktHzunOZC
 ngUBXQ3+ObdCLuVC2DKsIPzNqJKn3UcHHx0R9m/63qvgYW0ar4p5gkN
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The zspage->isolated is not used anywhere, we don't need to maintain it,
which needs to hold the heavy pool lock to update it, so just remove it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f2ae7d4c6f21..a48f4651d143 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -116,7 +116,6 @@
 #define HUGE_BITS	1
 #define FULLNESS_BITS	4
 #define CLASS_BITS	8
-#define ISOLATED_BITS	5
 #define MAGIC_VAL_BITS	8
 
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
@@ -246,7 +245,6 @@ struct zspage {
 		unsigned int huge:HUGE_BITS;
 		unsigned int fullness:FULLNESS_BITS;
 		unsigned int class:CLASS_BITS + 1;
-		unsigned int isolated:ISOLATED_BITS;
 		unsigned int magic:MAGIC_VAL_BITS;
 	};
 	unsigned int inuse;
@@ -1732,17 +1730,6 @@ static void migrate_write_unlock(struct zspage *zspage)
 }
 
 #ifdef CONFIG_COMPACTION
-/* Number of isolated subpage for *page migration* in this zspage */
-static void inc_zspage_isolation(struct zspage *zspage)
-{
-	zspage->isolated++;
-}
-
-static void dec_zspage_isolation(struct zspage *zspage)
-{
-	VM_BUG_ON(zspage->isolated == 0);
-	zspage->isolated--;
-}
 
 static const struct movable_operations zsmalloc_mops;
 
@@ -1771,21 +1758,12 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
-	struct zs_pool *pool;
-	struct zspage *zspage;
-
 	/*
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
-	zspage = get_zspage(page);
-	pool = zspage->pool;
-	spin_lock(&pool->lock);
-	inc_zspage_isolation(zspage);
-	spin_unlock(&pool->lock);
-
 	return true;
 }
 
@@ -1850,7 +1828,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	kunmap_atomic(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
-	dec_zspage_isolation(zspage);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release the pool's lock.
@@ -1872,16 +1849,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
-	struct zs_pool *pool;
-	struct zspage *zspage;
-
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
-
-	zspage = get_zspage(page);
-	pool = zspage->pool;
-	spin_lock(&pool->lock);
-	dec_zspage_isolation(zspage);
-	spin_unlock(&pool->lock);
 }
 
 static const struct movable_operations zsmalloc_mops = {

-- 
b4 0.10.1

