Return-Path: <linux-kernel+bounces-111143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2401D886850
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C5F283F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CA3F9E8;
	Fri, 22 Mar 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhuQzHg2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED83F9D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096512; cv=none; b=KmtUu2aZvoaJ+oO5TyZMhznrWS85i2x7Jk6B3VkrfpwTZ87ERbZDO+I2p0hLeMkCkkJKcbyC5YgS7RSr/s/E8qTvwIcRLOUIu3OdDFSNOXKuxMA05md+e8fLf76xh8jur0Yjw5spuaNs8tSG6eVyBVO5oNWNlWbwTcQVP7AGXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096512; c=relaxed/simple;
	bh=S+tu/Us/naajLYwRUmTRqpD4Xo/mrCDuxEPxhqR6e8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGsFFtG1jRDdX87BC/DRYCB4fMn39e9pN9QzC41JOFEZFeNzR092yquxKhnVsFbFPs0ma7Q7+daWnzE61qWovnOyhuQNUX1KvwNFFFcf51DYf/vprC9OzqLMMyA+8j3qMfJDuPvL2LFRyUWYCCCLNdGZfGWXkc8gfwBiU057Te4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhuQzHg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DC7C43390;
	Fri, 22 Mar 2024 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096512;
	bh=S+tu/Us/naajLYwRUmTRqpD4Xo/mrCDuxEPxhqR6e8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhuQzHg2zIDfH+NNdpucuHBPSFDXUngQkMtXneTPOFB3EXsUgkeeJH4rsslCkfhG5
	 4wFPvYbHSCE1xnudBCQq/bBl6/P0nYNJuw0bYM9e5eLZxxb+YECPnd20i5Txxb4zKs
	 gGttqYPNlKI/hzAMzVxPjsOAuaBXmXgrApgVatUr4bxEiDjBVgiiVca6abAnh8U2g7
	 k7CNbcR2g5fpVxGiJbyhueHZGdKDDJIz8FplT+V78W6m8/Vb9yRVw27y5h1+wbwVth
	 M0199e2qvjbnu+xUqBsqOJYP3AyHoE+7ixgaOs8916eariT5tsdciqmT0QRoiDGDPy
	 kyPPjQTt5vogA==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v2 14/14] mm/ksm: remove set_page_stable_node
Date: Fri, 22 Mar 2024 16:37:01 +0800
Message-ID: <20240322083703.232364-15-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322083703.232364-1-alexs@kernel.org>
References: <20240322083703.232364-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Remove the func since all caller are gone. Also remove the
VM_BUG_ON_PAGE() because it's not applicable for a folio.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index d7c4cc4a0cc1..136909f0c5d5 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1094,17 +1094,10 @@ static inline struct ksm_stable_node *page_stable_node(struct page *page)
 	return folio_stable_node(page_folio(page));
 }
 
-static inline void set_page_stable_node(struct page *page,
-					struct ksm_stable_node *stable_node)
-{
-	VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
-}
-
 static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
-	set_page_stable_node(&folio->page, stable_node);
+	folio->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
 }
 
 #ifdef CONFIG_SYSFS
-- 
2.43.0


