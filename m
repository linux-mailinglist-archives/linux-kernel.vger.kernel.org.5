Return-Path: <linux-kernel+bounces-93796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EB873501
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B6FB2DB26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7960871;
	Wed,  6 Mar 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNbaM2i1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C16086E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721804; cv=none; b=c1ye8KYpcGvgvBbg4WhSoxYyLO7bS73wcIdrkU19X6ryx/5AuI/eUu4Tzd7HRdV75brginYEmxO1g6SfzQNm6Uarss+KFo1xrmi1cPZZA5ZwzQwP2ns+NmH/jBz1UzMxeQgWLQcNtruGJvSvoyDupbCt5TcVmRG1WxdofJxeA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721804; c=relaxed/simple;
	bh=G6OxanI3sTRxSNp5lhYS2YR/ic0+r3tVkIbUpPCZPlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJqM0OFlrZQKt+JNgZMfDlexAtjBhAD1IJ7khsmQNBQv6vWcxG9gNn8wotpLrEUH/zl5HhubSqBnU9+xKr321yOchKUrezq+Nz3EjXoXVBDncSQyxMpu9zgfyrcIev4kA5y6IAt+MosksPgdvtvafXCrw7uKz15IkryuBZzmits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNbaM2i1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0nyH5cfLKLNUyYVewKsf1JegzIgt6HCOMbuZo9oALU=;
	b=JNbaM2i1mcgLCyvO2kCMCRyCWI3woMUGWJnRkU2x0mnKRh3LqRsXgdx7TaFuMdCLguPIye
	tB8myjg3ibFFBEbgSTYk0vXTKgWgVk7u5qvzztyI8pEb8b1WUOfsQFr5JF1hRRJBSZgA+p
	DzfK9R1Nb848u5Gm2PiJi4ZgC7GcfzI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-Hl-hIAJEPjGHPHHTtG8PNw-1; Wed,
 06 Mar 2024 05:43:17 -0500
X-MC-Unique: Hl-hIAJEPjGHPHHTtG8PNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21BBC1C0513A;
	Wed,  6 Mar 2024 10:43:17 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D539F111DCFF;
	Wed,  6 Mar 2024 10:43:10 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	sparclinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 10/13] mm/gup: Merge pXd huge mapping checks
Date: Wed,  6 Mar 2024 18:41:44 +0800
Message-ID: <20240306104147.193052-11-peterx@redhat.com>
In-Reply-To: <20240306104147.193052-1-peterx@redhat.com>
References: <20240306104147.193052-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Peter Xu <peterx@redhat.com>

Huge mapping checks in GUP are slightly redundant and can be simplified.

pXd_huge() now is the same as pXd_leaf().  pmd_trans_huge() and
pXd_devmap() should both imply pXd_leaf(). Time to merge them into one.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f87a7d90f2ae..de7188d2af86 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3005,8 +3005,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+		if (unlikely(pmd_leaf(pmd))) {
 			/* See gup_pte_range() */
 			if (pmd_protnone(pmd))
 				return 0;
@@ -3043,7 +3042,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
-		if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
+		if (unlikely(pud_leaf(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
 					  pages, nr))
 				return 0;
@@ -3096,7 +3095,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			return;
-		if (unlikely(pgd_huge(pgd))) {
+		if (unlikely(pgd_leaf(pgd))) {
 			if (!gup_huge_pgd(pgd, pgdp, addr, next, flags,
 					  pages, nr))
 				return;
-- 
2.44.0


