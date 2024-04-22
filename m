Return-Path: <linux-kernel+bounces-153237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1168ACB41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2738F281EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849701448F6;
	Mon, 22 Apr 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SofLs8EC"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC26482C1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783163; cv=none; b=m4pMaiik3DNRl9j+ZAktlO4DiavgGqwTXIhIfA1+VRt7GiyAaVR4y9tcxARRVrYdexu3mQBpElbrt1vfknAFph3vOc2Z1Au1M2eIcZTTADDXIBi6afuDo6B5qPlmfQpAZsKCIFQgQs7iGuCtd4HN2lnBs35DgZwT/dZ1moKDwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783163; c=relaxed/simple;
	bh=XDoMtI7bzd4H+3LWdrpe/D0kJlyFAvMW8N0fANSJKIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgxIvZeaLYPeKndRlH70bvCdr/TKm+/URQNtpU4KG5zBwvzw2KxHPL0iNMcCLhZtmgm3zutiwu9XXfDN+plBk6bFoZrKsHAeMING1qkOzXO7OX4H6YRqn1Kg9E79cpYBWji3rResbx07WgJwAaLUMRZBbUCBLnqCGyoOgTvVmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SofLs8EC; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713783158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ESBueFFCicxxXb4Z+7ylQzVlc77asvp92RLfamr44V8=;
	b=SofLs8ECkVtz6Kcgh+S7ngLkJQLF/4Alo5ZBK/DZIM81VMdvqANwmxIw/JoYXVmLtD83AP
	j5tYXmAHSmQJypffgp1qUUJsoIyfR36wT6RiMmlmrrJn3vUUco6U/xH+p4b0XJ9woV4lkQ
	dkQ5Bjj+5/a9lsXcnA8cqJykoc0+zEU=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/rmap: remove unnecessary page_table_lock
Date: Mon, 22 Apr 2024 18:52:12 +0800
Message-Id: <20240422105212.1485788-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

page_table_lock is a lock that for page table, we won't change page
table in __anon_vma_prepare(). As we can see, it works well in
anon_vma_clone(). They do the same operation.

Remove unnecessary page_table_lock in __anon_vma_prepare().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/rmap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..e894640a9327 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -187,7 +187,6 @@ static void anon_vma_chain_link(struct vm_area_struct *vma,
  */
 int __anon_vma_prepare(struct vm_area_struct *vma)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	struct anon_vma *anon_vma, *allocated;
 	struct anon_vma_chain *avc;
 
@@ -208,8 +207,6 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	}
 
 	anon_vma_lock_write(anon_vma);
-	/* page_table_lock to protect against threads */
-	spin_lock(&mm->page_table_lock);
 	if (likely(!vma->anon_vma)) {
 		vma->anon_vma = anon_vma;
 		anon_vma_chain_link(vma, avc, anon_vma);
@@ -217,7 +214,6 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 		allocated = NULL;
 		avc = NULL;
 	}
-	spin_unlock(&mm->page_table_lock);
 	anon_vma_unlock_write(anon_vma);
 
 	if (unlikely(allocated))
-- 
2.25.1


