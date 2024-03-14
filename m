Return-Path: <linux-kernel+bounces-102689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C43287B5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA06528369A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB8D27E;
	Thu, 14 Mar 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dAi9n/RM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22B8F55
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377683; cv=none; b=TZutsL0DVe3556rP8BiVZyNMxUasdvomBiCWQdK76k5CqI+7Df3p5gUVTe1FPI/u0z5JLLXFXT6KaU8kvwG4cPDQwosEuFFwhfGTcNdsNVQlkIJFLzE6W1cBL4bToGiCjEO4Qdbz0YTvcmp15AixHHIgGbNQ8RwzhO6kNw96Egk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377683; c=relaxed/simple;
	bh=urZYEhkOjhiW7omV6Hau96GGQsXjogpoamI/c12JFlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvTEqFniVTh5bGlVz96HZ3Wd1MIWTnykGVvyiKX18aJh8idM0NLz1X0G4BmfYAlS/Xokw7ATWOhr6G5xEmXe1g0cjw/uuDIuMP9gL9JCUjUgg2zvgRTzWBXA5du2BrxC14x6IYNoTqKMg5YntUXWBA+SJKKqFoJIBmUWA0An9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dAi9n/RM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y16FDE8fAPRzoyd3hzzZJsRMIkVkBbl8vnhWWzqELbo=; b=dAi9n/RMn/ptj6OJSi9OgXjOyR
	tDZPFaq5sSp4732/6rUz9KaNge5wN9Zqu05E9be1vnRnUXw2oDL9DEskCzo1gQRWyhbhWbVN3tQGc
	plqtMNv8ADqUgRHsc8cMlmwt9icx7Y7UCXL7xpQeQ7mR4vl/5axUYOFB439UAgpMMzHQzHjb01kAO
	M/2Evz9y4hSCSyDqomxADHXr+OBK2Ehk4hDuVAY6oSrAiX99kLW8g6vvfJa90E99ME3ORcgvz+kBI
	KQnmLb3FDo0FpGpwFdGiSzwisjOQGoipYTTNFskzCn9X87prdTbIXzJs9XwU4XM6yZweuUzXBAMS4
	rc8dcZRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkZMj-0000000CQo7-13QE;
	Thu, 14 Mar 2024 00:54:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	jhubbard@nvidia.com,
	vbabka@suse.cz,
	mgorman@suse.de,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 3/3] mm/vmstat: simplfy extfrag_show_print with fragmentation_index()
Date: Wed, 13 Mar 2024 17:54:35 -0700
Message-ID: <20240314005436.2962962-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314005436.2962962-1-mcgrof@kernel.org>
References: <20240314005436.2962962-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

fragmentation_index() already uses the stack for the struct contig_page_info,
so just use that and enhance the documentation for fragmentation_index().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/vmstat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..582f89b37ccf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1129,7 +1129,10 @@ unsigned int extfrag_for_order(struct zone *zone, unsigned int order)
 			info.free_pages);
 }
 
-/* Same as __fragmentation index but allocs contig_page_info on stack */
+/*
+ * Same as __fragmentation index but allocs contig_page_info on stack,
+ * useful when walking a zone as interrupts are disabled.
+ */
 int fragmentation_index(struct zone *zone, unsigned int order)
 {
 	struct contig_page_info info;
@@ -2227,15 +2230,11 @@ static void extfrag_show_print(struct seq_file *m,
 	unsigned int order;
 	int index;
 
-	/* Alloc on stack as interrupts are disabled for zone walk */
-	struct contig_page_info info;
-
 	seq_printf(m, "Node %d, zone %8s ",
 				pgdat->node_id,
 				zone->name);
 	for (order = 0; order < NR_PAGE_ORDERS; ++order) {
-		fill_contig_page_info(zone, order, &info);
-		index = __fragmentation_index(order, &info);
+		index = fragmentation_index(zone, order);
 		seq_printf(m, "%2d.%03d ", index / 1000, index % 1000);
 	}
 
-- 
2.43.0


