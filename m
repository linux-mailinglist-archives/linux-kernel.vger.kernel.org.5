Return-Path: <linux-kernel+bounces-117048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69E88A669
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585EB1C3C719
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D097B161915;
	Mon, 25 Mar 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvNscglB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B016192B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370785; cv=none; b=gFZ8GGXFygCrTtAUagbfjODgncS0ErwC+cI/OIrFcLmsw2cNnJwse3o11r1JzACtMXILMHUTo10GTtNDSif7VUnFfT0xnqXXyMw7welQN8R1VeKZlFbcU54k01SbfXldc2TGc44KPjVenJbUh3TnaABrHNHTL4yuY5KEoNcHgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370785; c=relaxed/simple;
	bh=S+tu/Us/naajLYwRUmTRqpD4Xo/mrCDuxEPxhqR6e8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkQ7/pIBtX5oOuptRPOEkpuqhfFk2RJxp7JmwVpeaFkJLH6L6/kiVCt9I1a7o+8ZL1DQ+1SUJtJSJZsx40/Vj6iuOwiEUEwzF2u7cM4PEWKxr4aIp8H1bGWZFjdY+LGsjF+3ULgu77a9fn5/W+9yfbE3hAGKeRnbZkBMFSKUiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvNscglB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A90C43390;
	Mon, 25 Mar 2024 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370785;
	bh=S+tu/Us/naajLYwRUmTRqpD4Xo/mrCDuxEPxhqR6e8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvNscglBOtArFIziHJISGyWfpSQgvEjzi2V85RJigyMkJAUyjE4z1ReQJ/PIJSSXK
	 fnB7wj6WL/CVS9I7Oeg6UH7+80lg/zNhOGX+YNQlKNlh2LmFzlLW7BkoYIvYvEpQds
	 Uccm1d6RduJh5VK4zvtMgDW9YJKv7K8+0fskz7o1dBrAFz2AGE2B6pjndW+KT6PwEw
	 UTFfg2NyGuFyG20oDXmM0LrLWcuLmLpRPAIPk7dUgiYvCpFV515hW6hEWgKf8Mo1B0
	 WrSjM/A2arN5eRndkDsjXZTbtHZX7K7WUe9EhnDP6M7JmGydKPrrRDCRq+Tpo236Co
	 Q3B8ZPqKqhPBg==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryncsn@gmail.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v3 14/14] mm/ksm: remove set_page_stable_node
Date: Mon, 25 Mar 2024 20:49:01 +0800
Message-ID: <20240325124904.398913-15-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325124904.398913-1-alexs@kernel.org>
References: <20240325124904.398913-1-alexs@kernel.org>
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


