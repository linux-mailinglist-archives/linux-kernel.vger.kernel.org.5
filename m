Return-Path: <linux-kernel+bounces-72436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4CF85B32C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE85E282254
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1795B1EB48;
	Tue, 20 Feb 2024 06:53:23 +0000 (UTC)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24035A0EA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412002; cv=none; b=lcSkhogZml2s281+pASrW+R4S9ZNKZX539toPbFQnm6hSDDPhOLLazqKqHFzENHjWmqz89oc1anJBZPBrUpkYc34CI2EydBYkdC/+1AUFxgvlwwigDCt3XOUOrRftoPEvVPFxqTx/N5/z0oG3jsr0FIh298FPvPR3fBrBrpEd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412002; c=relaxed/simple;
	bh=Xgdlm55CLoh7bhkT80TmmQFtvDTRQ4HP1+zxTxJBYgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csdfBp9om3xLSuf75mQvrNWJTAshWvGKdUwzRWpg9ka9FIye+kjulrM7vj/AuP4Lu9Gt9YmHB8VS2bjZg7JX5egJAtzjvfOUa6lAPmtA3U9xa0nFKNm1Lg5nfiFdTEkrscD5S/GABiJatiYAfHERZ31yb0NG71XrzDS3RSJicls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 20 Feb 2024 06:53:02 +0000
Subject: [PATCH 3/3] mm/zsmalloc: remove get_zspage_mapping()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-3-5c5ee4ccdd87@bytedance.com>
References: <20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com>
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com>
To: nphamcs@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 hannes@cmpxchg.org, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708411986; l=2848;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=Xgdlm55CLoh7bhkT80TmmQFtvDTRQ4HP1+zxTxJBYgU=;
 b=4q+yd5glcFZOpqCIQVbVR4X3XsoatKtXTiqyOtq8q0ZNNs6UmVHGxbOU+0d386EdCTHQyVWJv
 SM+DhZwPpWWCQGQV68PH4ymGQj6BE3cFFbARfeA4fYqACKEosa6yAsu
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

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

