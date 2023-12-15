Return-Path: <linux-kernel+bounces-633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8A8143E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B18FB22434
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B314F93;
	Fri, 15 Dec 2023 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8pPYagq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D77D27A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702629866; x=1734165866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pN6Za6QS6gH0Sone+vJpcFhDUA34F+4C+dHQJlQSAlc=;
  b=g8pPYagqW54B+3rP7kbG30x2G57uGPTWvP0RzFRbhfynpsszj1+h/iOP
   HokDceLy04mFAzVFdrJ8qzp3T3evr7YoK4lKzGusm9LSby/itMMn4+iDy
   7OA5VIuFnIl4NFjb4p7TigvqCqZZlHLSwopGz84QKeuMcBKHwqHt1Ebmi
   eJc/MplvZrzjg/0L+jm7oTGeclutFfT3itcPElAqDoo5RJp29PEhEYzXx
   /+r95NgN6GCn9Eg1BF5xiMizvLRQpuzFBRCqZJEUZ9npXtxSP7uSPE6RV
   WOAmr76L88arzBzqQPUEDu6NPLe0TZqwiNY8yi9s5xy0ffD0ePUv37enb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426381356"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="426381356"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808895806"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="808895806"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.25.64])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:44:22 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Date: Fri, 15 Dec 2023 09:43:40 +0100
Message-ID: <20231215084417.2002370-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kmap() has been deprecated in favor of kmap_local_page().

Therefore, replace kmap() with kmap_local_page() in mm/memory.c.

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page-faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. The tasks can
be preempted and, when they are scheduled to run again, the kernel
virtual addresses are restored and still valid.

Obviously, thread locality implies that the kernel virtual addresses
returned by kmap_local_page() are only valid in the context of the
callers (i.e., they cannot be handed to other threads).

The use of kmap_local_page() in mm/memory.c does not break the
above-mentioned assumption, so it is allowed and preferred.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 mm/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7d9f6b685032..88377a107fbe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5852,7 +5852,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			if (bytes > PAGE_SIZE-offset)
 				bytes = PAGE_SIZE-offset;
 
-			maddr = kmap(page);
+			maddr = kmap_local_page(page);
 			if (write) {
 				copy_to_user_page(vma, page, addr,
 						  maddr + offset, buf, bytes);
@@ -5861,8 +5861,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 				copy_from_user_page(vma, page, addr,
 						    buf, maddr + offset, bytes);
 			}
-			kunmap(page);
-			put_page(page);
+			unmap_and_put_page(page, maddr);
 		}
 		len -= bytes;
 		buf += bytes;
-- 
2.43.0


