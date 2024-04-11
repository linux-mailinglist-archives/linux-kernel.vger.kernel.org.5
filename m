Return-Path: <linux-kernel+bounces-139826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4D98A0833
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0296F282036
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BDB13D28C;
	Thu, 11 Apr 2024 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeCaLcCJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5413CAB8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816063; cv=none; b=j0xHWAHVryMnyTG5XJoeUVjABYRo68sKMIDSnhex4yv3pkeb+DhNUl3KQ2+XFh4SsuB6nnB69OQFldrhzaIXCD9a8CodjSEh9RtrT0mWIzUF8X1mftzGrkmoDq6o7wyC0HaSujkLaJ9eYsH7wybs9eJXxq7nO9ncwjBH3Vh425c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816063; c=relaxed/simple;
	bh=qC1mthl25nwOp6y3rOKx92fTxAINpkUFXHoU2+YaTrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6eqGTLfoOvO7fXNnKERBcwzpdrlfyD6UXiLBdWpzfHiHyqZ+lrxtYSWYXNG9NUEPOqT+1i/5mbgxsTzLPf/BN8x8qMSi0NPlIsHi81uVDPVZvXjE/3R30jsa/o9gogkxF7lq/clPAIJhUGuBmBqtgiuYFmGACkNwX3FWfup0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeCaLcCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6C0C433C7;
	Thu, 11 Apr 2024 06:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816062;
	bh=qC1mthl25nwOp6y3rOKx92fTxAINpkUFXHoU2+YaTrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeCaLcCJY1GT60Q7AK9seqx+UVCi+HEDRS5ESPdYFwWmaoRyhC+uf8a/tp1U0dwjT
	 wt6uBhs92tZ7dBvQAr+9+kTUJhGOXqlsZ006oR64EZ1MC85axd3cARsi2cW3k23YRX
	 uLnA3kT7VS+kVAk04VJJBr4LxERj6mfwFZ+2LoOMpc8wlCYJgEKWVGTgQVENb+Mems
	 C3vD9bBLeWtulpk4I7Wa+g01SjslvX8DWmJvfnMgz8WhRM9emVqFyfZSEQpbnQzwTX
	 lMZCl8JaL46hQAO17OlxhJS3dshevOSZB0qc9ifR5HdY5RwAu5x3ZEfH+wU6dzA+xI
	 +s6u98GnpUpOw==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	hughd@google.com,
	chrisw@sous-sol.org,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>
Subject: [PATCH v5 03/10] mm/ksm: add folio_set_stable_node
Date: Thu, 11 Apr 2024 14:17:04 +0800
Message-ID: <20240411061713.1847574-4-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411061713.1847574-1-alexs@kernel.org>
References: <20240411061713.1847574-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Turn set_page_stable_node() into a wrapper folio_set_stable_node, and then
use it to replace the former. we will merge them together after all
place converted to folio.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ef5c4b6d377c..3c52bf9df84c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1109,6 +1109,12 @@ static inline void set_page_stable_node(struct page *page,
 	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
 }
 
+static inline void folio_set_stable_node(struct folio *folio,
+					 struct ksm_stable_node *stable_node)
+{
+	set_page_stable_node(&folio->page, stable_node);
+}
+
 #ifdef CONFIG_SYSFS
 /*
  * Only called through the sysfs control interface:
@@ -3241,7 +3247,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 		 * has gone stale (or that folio_test_swapcache has been cleared).
 		 */
 		smp_wmb();
-		set_page_stable_node(&folio->page, NULL);
+		folio_set_stable_node(folio, NULL);
 	}
 }
 #endif /* CONFIG_MIGRATION */
-- 
2.43.0


