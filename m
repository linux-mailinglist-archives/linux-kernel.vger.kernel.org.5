Return-Path: <linux-kernel+bounces-72932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3385BAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB431F24B65
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155767E60;
	Tue, 20 Feb 2024 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sFquOSfJ"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C767C5B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429488; cv=none; b=hBQFwQa+TS7ZEH3HLkmO9i+mmYLllJH5YQ/5vkM9va8zPaPScyKeUiWpcM6jlOCwtFNLEelxKTUXDYzZlBUu0kMz0qOK5d9yapwGZxTPQ+7Uw/UuONRaj7xx3cf+X60R+Fl6jM7u6mU5UPxT8n+/iYNJ5EuQ9az+pkaqZei1Htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429488; c=relaxed/simple;
	bh=+hNOOnD6KYFH5W5qAnGzZngb3DqQxS5eWXbyLmHNF0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnBkASlfXkJz8mz1eUjPcKVur1/ZXT2FjB+lnWIgu0lS3V4grLim7uCAUAaxV/NmXC5jGWEVyNxHtB/BEmk2oXifNfryWM2BfeauqKz5bYXjGvv4W8ZeHpOPzBtH5/XhQUsBUeS8wLKi+DNqejtIzkAeAZ5ULZM8fYy4A6m9ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sFquOSfJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci79DiUWa7UnDzkerNUYQl6snYV1NrEQXPg7SGeMzMg=;
	b=sFquOSfJAfNaMCcn09Pz5sjO2zdozOZHHOKnWpE+LDSMzXP7F23EP9QanRL77oXcAT277F
	FC0SYpH2l+d3i9aCwXkf2Azx5DhAJIYgQhIpB19q7jstT7MPGibYDvOKlG4K6U8vBu87Ju
	bRtPc7aXmlSDbI5CnxSzfSZECVV6PY8=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:44:31 +0000
Subject: [PATCH RESEND 3/3] mm/zsmalloc: remove get_zspage_mapping()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-3-b7e9cbab9541@linux.dev>
References: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
To: hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 nphamcs@gmail.com, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429476; l=2848;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=Xgdlm55CLoh7bhkT80TmmQFtvDTRQ4HP1+zxTxJBYgU=;
 b=6L4Rze0bnsKiqR9+QLqh2qD7BDtQUhtZu8ueGs9RPgzByahXpM+6pkTSsBD1omm7SA3abUFN5
 ZTBlKgut6b+DoJxWVUkh0tjpPfx/6AV6Utfx4wSudSlGuNzInKTxDcM
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

Actually we seldom use the class_idx returned from get_zspage_mapping(),
only the zspage->fullness is useful, just use zspage->fullness to remove
this helper.

Note zspage->fullness is not stable outside pool->lock, remove redundant
"VM_BUG_ON(fullness != ZS_INUSE_RATIO_0)" in async_free_zspage() since
we already have the same VM_BUG_ON() in __free_zspage(), which is safe to
access zspage->fullness with pool->lock held.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c39fac9361d7..63ec385cd670 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -470,16 +470,6 @@ static inline void set_freeobj(struct zspage *zspage, unsigned int obj)
 	zspage->freeobj = obj;
 }
 
-static void get_zspage_mapping(struct zspage *zspage,
-			       unsigned int *class_idx,
-			       int *fullness)
-{
-	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
-
-	*fullness = zspage->fullness;
-	*class_idx = zspage->class;
-}
-
 static struct size_class *zspage_class(struct zs_pool *pool,
 				       struct zspage *zspage)
 {
@@ -708,12 +698,10 @@ static void remove_zspage(struct size_class *class, struct zspage *zspage)
  */
 static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 {
-	int class_idx;
-	int currfg, newfg;
+	int newfg;
 
-	get_zspage_mapping(zspage, &class_idx, &currfg);
 	newfg = get_fullness_group(class, zspage);
-	if (newfg == currfg)
+	if (newfg == zspage->fullness)
 		goto out;
 
 	remove_zspage(class, zspage);
@@ -835,15 +823,11 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
 	struct page *page, *next;
-	int fg;
-	unsigned int class_idx;
-
-	get_zspage_mapping(zspage, &class_idx, &fg);
 
 	assert_spin_locked(&pool->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
-	VM_BUG_ON(fg != ZS_INUSE_RATIO_0);
+	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
 
 	next = page = get_first_page(zspage);
 	do {
@@ -1857,8 +1841,6 @@ static void async_free_zspage(struct work_struct *work)
 {
 	int i;
 	struct size_class *class;
-	unsigned int class_idx;
-	int fullness;
 	struct zspage *zspage, *tmp;
 	LIST_HEAD(free_pages);
 	struct zs_pool *pool = container_of(work, struct zs_pool,
@@ -1879,10 +1861,8 @@ static void async_free_zspage(struct work_struct *work)
 		list_del(&zspage->list);
 		lock_zspage(zspage);
 
-		get_zspage_mapping(zspage, &class_idx, &fullness);
-		VM_BUG_ON(fullness != ZS_INUSE_RATIO_0);
-		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
+		class = zspage_class(pool, zspage);
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}

-- 
b4 0.10.1

