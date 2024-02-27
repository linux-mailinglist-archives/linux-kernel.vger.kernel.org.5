Return-Path: <linux-kernel+bounces-82633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F62868778
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DBB1C21BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5C1947E;
	Tue, 27 Feb 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rdcCuWxN"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46D17727
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002862; cv=none; b=J83xQu/Yvh6hE2I7vNRbad3qVpEhCTOpm9W3dOAn8IWzU5EnBn6ZIUZkpUd0lwTg3kQUnZzT6mTVuhMC3tQFysBeGjILRrR3yEbVxnqmLtfqMsiWvSjqimPO9N4Ezbz+jNEK82+YA3uC0J7UPGjSyxP0ycoJAh+IzBBKTfQZLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002862; c=relaxed/simple;
	bh=yhXcOUr2TJWk/wNNiA1D6Q5q45wFN8idnbdKppdGcsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzcoT+gHiNGT6evIXTjjbbmKjdjUsN1E4Ol4SywDXcMLRZAn1ieglM7wxTTqTHvQa0i0Wl7GfPqJ9HDS3Q2cR8hSzFz4toL+3RVd9sAad/HyWUvhrOEPatbGc+DR4E6vFwrVNsaPPZEL7K4tiCywAV3Wrh1/32t9ATFjtEbF0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rdcCuWxN; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709002857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xeQWaahmZnWCMBq0OUjMZaQ1ukelciifHqNoME1DLpU=;
	b=rdcCuWxN+7eDOuR8InRBPhUFUUrein7N1DNL9bQLa97q2as9+CeTi5nqK462eIHVqlOpUJ
	DE0f8LQ8fdhx+dI+6x/6UCExMbuVB3JMsKt7mypwkmqm700CvAimAF/yYzvB+IbiOpxKK/
	l321fRfhM+btqf5QRTQctXh1OyKoTv0=
From: chengming.zhou@linux.dev
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] mm/zsmalloc: don't need to save tag bit in handle
Date: Tue, 27 Feb 2024 03:00:45 +0000
Message-Id: <20240227030045.3443702-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

We only need to save the position (pfn + obj_idx) in the handle, don't
need to save tag bit in handle. So one more bit can be used as obj_idx.

Actually, the tag bit is only useful in zspage's memory space, to tell
if an object is allocated or not.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 63ec385cd670..7d7cb3eaabe0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -110,7 +110,7 @@
 #define OBJ_TAG_BITS	1
 #define OBJ_TAG_MASK	OBJ_ALLOCATED_TAG
 
-#define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
+#define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
 #define HUGE_BITS	1
@@ -737,14 +737,12 @@ static struct page *get_next_page(struct page *page)
 static void obj_to_location(unsigned long obj, struct page **page,
 				unsigned int *obj_idx)
 {
-	obj >>= OBJ_TAG_BITS;
 	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
 static void obj_to_page(unsigned long obj, struct page **page)
 {
-	obj >>= OBJ_TAG_BITS;
 	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
 }
 
@@ -759,7 +757,6 @@ static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
 
 	obj = page_to_pfn(page) << OBJ_INDEX_BITS;
 	obj |= obj_idx & OBJ_INDEX_MASK;
-	obj <<= OBJ_TAG_BITS;
 
 	return obj;
 }
-- 
2.40.1


