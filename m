Return-Path: <linux-kernel+bounces-155539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9ED8AF3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C3EB2503B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9413D287;
	Tue, 23 Apr 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifvQO6n8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC613CF91
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888912; cv=none; b=Q9RCxEa/K3woFVIiia8bUhNIexl9R8mLLTEspuVV8wQluLFjTYlAfAFpRUNfIDuyn+XX8k0gRM2M4S/hMyY4a1SwWSMM21yLgs0chJobWic+wzw+ISWhEBDYzSaBBiK3Ja+ybilvee1bdYyba14UV0d3P6CtQB6Wo168gh0MBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888912; c=relaxed/simple;
	bh=bHyjoHr77jVo9CAvNPXLHXKFZ3NRGRlYQsxzS10sZsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUvs1WMApfY4cP9V56dX7LOJOGHJEJs4aa0wMSGVmkwKiquElXvyauhlula3QRMmzHtXs7/Vwof7ldunsdHB5jLKcp8/Pg/PwJsqRxmeiyez/clEku6hmcQwwab+38ID2Wc5BuiBAOtyqB+9YE3itT4dzIjOFK4Peqdg8fgrmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifvQO6n8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713888912; x=1745424912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bHyjoHr77jVo9CAvNPXLHXKFZ3NRGRlYQsxzS10sZsU=;
  b=ifvQO6n8gOLNoC0uMFbdpx9jSJlYkHukzTSw6FrkfAAPNjKkAb0qNxIq
   HSvvXg2Hhv4Q4kglzSM25PUod5fkMmWKm40+cAeVE5oTXi6hpDeBOG4QV
   tpPhSvODqnmPqp+As/em468nf7ZLiUuteJXfaEFxfON+0z+YFyYmzTYcr
   MV4Q9QbNSjUF72noZ13oMANk8UplSnH6rxG9SiJRCuwSTAh4b8vrA25/Z
   u7MAJWK91zYD6g6lN/FBc17aLrJr/eVm5yy2BEGDB30B/aKkYVmWUSCLg
   03iZwp9Px1lcg9nx6dkY3kSDhEVXG+P2VQhqRhoMMEcyggY7WDnXbltg8
   g==;
X-CSE-ConnectionGUID: qLy3E3oBRJCPSetAM8DI9w==
X-CSE-MsgGUID: eUd8KdmRTimlQge93VfpwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27000216"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="27000216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:15:11 -0700
X-CSE-ConnectionGUID: MO9KiCQiTWCU2KBSZu54Pw==
X-CSE-MsgGUID: Qv7a4b49SpiGmNjU2OqtFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24465567"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 09:15:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3C0D3192; Tue, 23 Apr 2024 19:15:08 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
Date: Tue, 23 Apr 2024 19:14:43 +0300
Message-ID: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some configurations I got
mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
Becuase the only user is guarged with a certain ifdeffery,
do the same for add_to_free_list().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: moved the function down to the respective ifdeffery block (Liam)
 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 33d4a1be927b..cd584aace6bf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -653,14 +653,6 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 	area->nr_free++;
 }
 
-static inline void add_to_free_list(struct page *page, struct zone *zone,
-				    unsigned int order, int migratetype,
-				    bool tail)
-{
-	__add_to_free_list(page, zone, order, migratetype, tail);
-	account_freepages(zone, 1 << order, migratetype);
-}
-
 /*
  * Used for pages which are on another list. Move the pages to the tail
  * of the list - so the moved pages won't immediately be considered for
@@ -6776,6 +6768,14 @@ bool is_free_buddy_page(const struct page *page)
 EXPORT_SYMBOL(is_free_buddy_page);
 
 #ifdef CONFIG_MEMORY_FAILURE
+static inline void add_to_free_list(struct page *page, struct zone *zone,
+				    unsigned int order, int migratetype,
+				    bool tail)
+{
+	__add_to_free_list(page, zone, order, migratetype, tail);
+	account_freepages(zone, 1 << order, migratetype);
+}
+
 /*
  * Break down a higher-order page in sub-pages, and keep our target out of
  * buddy allocator.
-- 
2.43.0.rc1.1336.g36b5255a03ac


