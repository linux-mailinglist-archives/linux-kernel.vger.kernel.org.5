Return-Path: <linux-kernel+bounces-93792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77B87349B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8A81C21AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FA60B81;
	Wed,  6 Mar 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVWZ5zwK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57146605AD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721779; cv=none; b=J5KAvOUTo6sgAMx5ZDUA+ZyCsACtprlSeJ2djAvz3dwH9gYJrXuiJr8rRqTEJcF0IsePmtrG9JILlNu0surlYwdVe8mxx1Y2ZuX/YTt1ODIIHtS5rXCPl8GQac+bAAznxcIQHZh8OGS7e68tE9zbqfIEUlaY2Ba9mvAHRFuahBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721779; c=relaxed/simple;
	bh=5RHxSgtdvJKVCp5Pr7PrdSJPxWg3TC/UA6xoLVOm0PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4l7dXSb9RLtX/mR+plC3bixCwXBJhMVnaA9o7fmU+jJJtwpTRy1aOzoQ0+ITbgfh0XLG0J+c/kObh7ftn7V5WMwfRqRTzK2tLq2jhKmGx/52ZPVvNGlXVW6KdMNIiGbU9R4Lm7B8sLLxenez4yhtpb3EqMUe9CVuFt0gF9jDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVWZ5zwK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4C+lWpN1qDfU+nymiqOVXkY7IqPiijqTb8F5rFjpmTU=;
	b=eVWZ5zwKEn8D25OPaGhlp+G77eC1s/VFSQZFX7ZvRMeh6LSTS7vORfQP5vYpnprelmrGn3
	KuJgJbsHcZH70ERCBmFUM804XqyGrD2HnaJJymlEBNvkXJBUR+R4uXsI/nPNmfie/tWYzv
	8M0w72q+B0hvNuAmvVSMi4M5yivXI3k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-aSR7lTs0MGOXGlrFM8hoQg-1; Wed, 06 Mar 2024 05:42:54 -0500
X-MC-Unique: aSR7lTs0MGOXGlrFM8hoQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7927980F7E3;
	Wed,  6 Mar 2024 10:42:53 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A34D7111DCFF;
	Wed,  6 Mar 2024 10:42:44 +0000 (UTC)
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
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH RFC 07/13] mm/arm: Redefine pmd_huge() with pmd_leaf()
Date: Wed,  6 Mar 2024 18:41:41 +0800
Message-ID: <20240306104147.193052-8-peterx@redhat.com>
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

Most of the archs already define these two APIs the same way.  ARM is more
complicated in two aspects:

  - For pXd_huge() it's always checking against !PXD_TABLE_BIT, while for
    pXd_leaf() it's always checking against PXD_TYPE_SECT.

  - SECT/TABLE bits are defined differently on 2-level v.s. 3-level ARM
    pgtables, which makes the whole thing even harder to follow.

Luckily, the second complexity should be hidden by the pmd_leaf()
implementation against 2-level v.s. 3-level headers.  Invoke pmd_leaf()
directly for pmd_huge(), to remove the first part of complexity.  This
prepares to drop pXd_huge() API globally.

When at it, drop the obsolete comments - it's outdated.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Fabio Estevam <festevam@denx.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/mm/hugetlbpage.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index dd7a0277c5c0..c2fa643f6bb5 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -18,11 +18,6 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-/*
- * On ARM, huge pages are backed by pmd's rather than pte's, so we do a lot
- * of type casting from pmd_t * to pte_t *.
- */
-
 int pud_huge(pud_t pud)
 {
 	return 0;
@@ -30,5 +25,5 @@ int pud_huge(pud_t pud)
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_leaf(pmd);
 }
-- 
2.44.0


