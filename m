Return-Path: <linux-kernel+bounces-52010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2078492BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44996B211FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F99455;
	Mon,  5 Feb 2024 03:17:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233EA8F56
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707103019; cv=none; b=rAkTIbBaKJkWW9s8ngW6ExuQWmihX507fGwfa2DLqKm0y6dUhBawEHuoyRllzZG/yj4lKs4B2V5OafEnBsrzGltlshCMndDXlXKzrx8+tkPTJEondbNs022iQZQLbFZ5qBNdWyAfgQ0kulrlgpZF7rnzRA8V8do5ct8c+mEqXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707103019; c=relaxed/simple;
	bh=kUGQIlKf+E+jZpQtg6FfXU6fycbgpqbfjW3cKjCIpA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NdqNsKsW0xtYJJ9zvIcaE0CqJplVkNwgvATwyJ8xL/rVd9ih3SiXzLmeZ6Ojpop9mvZOcUXF0GSUTmSNFixXyQOO44mrgStj6Cq8bZdfN6v9cZaSLPne7XgnpKwbfuXcYS6gh/DYrs4oAQnukkWX3+vI8V7mzfmWj6R06mzhWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619521FB;
	Sun,  4 Feb 2024 19:17:37 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54B783F762;
	Sun,  4 Feb 2024 19:16:53 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/cma: Drop CONFIG_CMA_DEBUG
Date: Mon,  5 Feb 2024 08:46:47 +0530
Message-Id: <20240205031647.283510-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All pr_debug() prints in (mm/cma.c) could be enabled via standard Makefile
based method. Besides cma_debug_show_areas() should always be called during
cma_alloc() failure path. This seemingly redundant config, CONFIG_CMA_DEBUG
can be dropped without any problem.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc3.

 mm/Kconfig | 9 ---------
 mm/cma.c   | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ffc3a2ba3a8c..35fa9940e61f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -901,15 +901,6 @@ config CMA
 
 	  If unsure, say "n".
 
-config CMA_DEBUG
-	bool "CMA debug messages (DEVELOPMENT)"
-	depends on DEBUG_KERNEL && CMA
-	help
-	  Turns on debug messages in CMA.  This produces KERN_DEBUG
-	  messages for every CMA call as well as various messages while
-	  processing calls such as dma_alloc_from_contiguous().
-	  This option does not affect warning and error messages.
-
 config CMA_DEBUGFS
 	bool "CMA debugfs interface"
 	depends on CMA && DEBUG_FS
diff --git a/mm/cma.c b/mm/cma.c
index 7c09c47e530b..ed6581ef50c1 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -14,11 +14,6 @@
 
 #define pr_fmt(fmt) "cma: " fmt
 
-#ifdef CONFIG_CMA_DEBUG
-#ifndef DEBUG
-#  define DEBUG
-#endif
-#endif
 #define CREATE_TRACE_POINTS
 
 #include <linux/memblock.h>
@@ -387,7 +382,6 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	return ret;
 }
 
-#ifdef CONFIG_CMA_DEBUG
 static void cma_debug_show_areas(struct cma *cma)
 {
 	unsigned long next_zero_bit, next_set_bit, nr_zero;
@@ -412,9 +406,6 @@ static void cma_debug_show_areas(struct cma *cma)
 	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
 	spin_unlock_irq(&cma->lock);
 }
-#else
-static inline void cma_debug_show_areas(struct cma *cma) { }
-#endif
 
 /**
  * cma_alloc() - allocate pages from contiguous area
-- 
2.25.1


