Return-Path: <linux-kernel+bounces-42726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8084059F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F3F1F223D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA22E67E71;
	Mon, 29 Jan 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apaxodvu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6267E61
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532497; cv=none; b=lTi92et+A/CIOc44grrUlRdl0x5HjFWEC1UwE3vGEuVnPDL39vSNSYDhX7MqvEJOW0EXRO8HVO64r77SneGnpyPb98Gls+jRgaOVzyf05jc6gx/T6bhdoTMwpRgwjjK9LGZ9IqFWog+VFPfUUaTNNl6szfJwzHyxP1p4I3Ivte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532497; c=relaxed/simple;
	bh=WCHlJn12la69YWdL2YUOIZTol8Gam56seomR3cgdlf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDG7goiikzHUYHV5agBHLP3F9pI28q7kUCV8eFPzJCDakTMO9EQgFxd2UQ/3uAe5+WkEf64LmRMfBK9z+65pmb0AZS5Q4u7fcPlDActcxK41SJ0JkNjyTndJ72MQN2YgDY8eIYn6nNs72Wa+d2wok9Um3RxIJwGCWXEDOrr9DiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apaxodvu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706532494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cS+fj/Ib0GI5otmzNrt4qLpnZeCkiOZS5Y+GTIa0gvY=;
	b=apaxodvu5Ho0lNvtdBYOSlY+///nImabbZg/KUjDpZzYNNy6HQZmIXeyUgTBFbKddQy3Er
	FV5Bsfw92j0Brddd0eo9WZf6QF8wwHk9PKIya6+GiZR5y6TdPWIcxXtdicOfSPAydzGtBI
	0FvUvmVHlfbJSnu0pB/Iz2ItPEEP+l8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-uopDDWlrNyiX6spNRSMRFQ-1; Mon, 29 Jan 2024 07:48:10 -0500
X-MC-Unique: uopDDWlrNyiX6spNRSMRFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8CA6867943;
	Mon, 29 Jan 2024 12:48:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99F798B;
	Mon, 29 Jan 2024 12:48:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v3 12/15] mm/memory: pass PTE to copy_present_pte()
Date: Mon, 29 Jan 2024 13:46:46 +0100
Message-ID: <20240129124649.189745-13-david@redhat.com>
In-Reply-To: <20240129124649.189745-1-david@redhat.com>
References: <20240129124649.189745-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

We already read it, let's just forward it.

This patch is based on work by Ryan Roberts.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a3bdb25f4c8d..41b24da5be38 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -959,10 +959,9 @@ static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
  */
 static inline int
 copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
-		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		 struct folio **prealloc)
+		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
+		 int *rss, struct folio **prealloc)
 {
-	pte_t pte = ptep_get(src_pte);
 	struct page *page;
 	struct folio *folio;
 
@@ -1103,7 +1102,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		/* copy_present_pte() will clear `*prealloc' if consumed */
 		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
-				       addr, rss, &prealloc);
+				       ptent, addr, rss, &prealloc);
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
-- 
2.43.0


