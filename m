Return-Path: <linux-kernel+bounces-121339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B56588E640
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230041F3092B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC28B154C11;
	Wed, 27 Mar 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hu6pNYAq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5135154BED
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544767; cv=none; b=X+NAiICJnYTnPdJqGyF1obqGrVIyKjn1tOnY/8rznSRl/9yBea3gQxzKfrxG4dtUqdg8XeQfOaT+t/VOTTNnu714LrDDwJlHQiz9LBI/0QwYBuZkIG8r5A+rdBmQX8CzuXNhrdRV6Z+ZWnBd/FkE82gkAScGFdztObV4eUShAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544767; c=relaxed/simple;
	bh=lz/X6qb6AMvUSigIWTdX8rnHxjWqLuYuDOp4idLDdDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia/FOEjj35OOl11aMrp+T6mvlIZ6H0hIZQTTm8m/QmLHC7pCD6BCsAsoWA6U/ck8KT9vh+JuQkN/lHQHAeI7KQCnLrfy+8GEiIBQlZ1Unbo0FL1XpEYKt4zyBHrfDfDROw1OvDncS7U7vKvnxBbrJ7ERoEQujMJu6HNy8g6Wga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hu6pNYAq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711544763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSD1jJkroCyXm61fF+oNruRo3coWmssTF4skwAil3Lw=;
	b=Hu6pNYAqCAazk3FG1Lfp7hQJl8jz/7OPUseDgNpCDGKEAt9W69jVuPb5xbbJvgJ10uUXa4
	cu4+AepXlBC7F3jvo4C6lK4YnuOOoTXX6mM0TBpNO5PIr018NgDKg+rNlsLwbovHIPaTF2
	Tw/WxxpQPQjEQZo7UcjGO1tEF/3UP10=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-n4vWnbRDMPWu0T-sgcsqLg-1; Wed, 27 Mar 2024 09:06:00 -0400
X-MC-Unique: n4vWnbRDMPWu0T-sgcsqLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82920800265;
	Wed, 27 Mar 2024 13:05:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 203CF1C060D0;
	Wed, 27 Mar 2024 13:05:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH RFC 3/3] mm: use "GUP-fast" instead "fast GUP" in remaining comments
Date: Wed, 27 Mar 2024 14:05:38 +0100
Message-ID: <20240327130538.680256-4-david@redhat.com>
In-Reply-To: <20240327130538.680256-1-david@redhat.com>
References: <20240327130538.680256-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Let's fixup the remaining comments to consistently call that thing
"GUP-fast". With this change, we consistently call it "GUP-fast".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c    | 2 +-
 mm/khugepaged.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 387b394754fa..c668e11cd6ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1810,7 +1810,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  * C. Return the page to the page allocator
  *
  * This means that any page may have its reference count temporarily
- * increased by a speculative page cache (or fast GUP) lookup as it can
+ * increased by a speculative page cache (or GUP-fast) lookup as it can
  * be allocated by another user before the RCU grace period expires.
  * Because the refcount temporarily acquired here may end up being the
  * last refcount on the page, any page allocation must be freeable by
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 38830174608f..6972fa05132e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1169,7 +1169,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * huge and small TLB entries for the same virtual address to
 	 * avoid the risk of CPU bugs in that area.
 	 *
-	 * Parallel fast GUP is fine since fast GUP will back off when
+	 * Parallel GUP-fast is fine since GUP-fast will back off when
 	 * it detects PMD is changed.
 	 */
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
-- 
2.43.2


