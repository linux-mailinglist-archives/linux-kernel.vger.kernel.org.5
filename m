Return-Path: <linux-kernel+bounces-37936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15A83B87E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7362728309C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084F10A17;
	Thu, 25 Jan 2024 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TP9P8j4w"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7610A01
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154596; cv=none; b=Xj3WV4TvD+aHxHTeNt/uNVPOHJqA2inZf3tE83o8Roa453J3wg9mvPZolMOUqAu726hxWnqAt8o/UYKx8jNObvhCEMP1Nn7HkmnlIAdqBql67kvdmHxuInO+GnxLhQ93HHytPBJDszBfJlngwEj8ccEDIyk1zRHKgFvcAVKrGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154596; c=relaxed/simple;
	bh=73ZPNorBDGeZQoqSY1zb/FAA9ykzNR/xXGUzku/jFWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVsXgrETX8NE/qyOEkaZT5V9BMJ3Gxr1/+mGzrvEjrlJW51hx/mmkYr6YMt6yBNWE2hY1hixqJ41malozHzkZQHyYYwD7RuchFvgO403WnTAUpMhiANHGRMkSzE7G/+ppBfLoL1It9mW/2Vafj9yEzYFgBUHrQUV1A91Bak43X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TP9P8j4w; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706154593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6+UflKme2rdjDNdZ2iFhopxIKTWi9f4kjyYutjoOt0=;
	b=TP9P8j4wYgzgj1xUO6g20xYqDXcVPDuvlJavt38IgPULE49lOg/3PDgmY31WgxvkrWC0OB
	zPmTNvyIyMZ2SPNVR06ETZJgsvj+dyVvmkfsvGAoKXc+s3tSZ4zq7dnfUVn4gLjT1aG2nI
	2vTQC2TNOTx5zN5/dz4JuMv46KNioxI=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@Oracle.com,
	lstoakes@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	vbabka@suse.cz,
	willy@infradead.org,
	surenb@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2 2/2] mm/mmap: remove find_vma_intersection() in vma_merge()
Date: Thu, 25 Jan 2024 11:49:22 +0800
Message-Id: <20240125034922.1004671-3-yajun.deng@linux.dev>
In-Reply-To: <20240125034922.1004671-1-yajun.deng@linux.dev>
References: <20240125034922.1004671-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We need to find the current vma by find_vma_intersection() in
vma_merge(). Since the src vma was passed, we can add a check to figure
out if the current vma is NULL or the src vma directly.

Remove find_vma_intersection() in vma_merge(). And initialize the next to
NULL when defining it.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f19bc53bc08e..ea02fdc91aa2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -869,7 +869,7 @@ static struct vm_area_struct
 	struct mm_struct *mm = src->vm_mm;
 	struct anon_vma *anon_vma = src->anon_vma;
 	struct file *file = src->vm_file;
-	struct vm_area_struct *curr, *next, *res;
+	struct vm_area_struct *curr = src, *next = NULL, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
@@ -890,14 +890,18 @@ static struct vm_area_struct
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	/* Does the input range span an existing VMA? (cases 5 - 8) */
-	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
+	/*
+	 * If the current vma and the prev vma are the same vma, it
+	 * means the current vma is NULL.
+	 * Does the input range span an existing VMA? (cases 5 - 8)
+	 */
+	if (prev == curr || addr != curr->vm_start || end > curr->vm_end)
+		curr = NULL;
 
 	if (!curr ||			/* cases 1 - 4 */
 	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
 		next = vma_lookup(mm, end);
-	else
-		next = NULL;		/* case 5 */
+					/* case 5 set to NULL above */
 
 	if (prev) {
 		vma_start = prev->vm_start;
@@ -921,7 +925,6 @@ static struct vm_area_struct
 
 	/* Verify some invariant that must be enforced by the caller. */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
 	VM_WARN_ON(addr >= end);
 
 	if (!merge_prev && !merge_next)
-- 
2.25.1


