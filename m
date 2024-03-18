Return-Path: <linux-kernel+bounces-106215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4A87EAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09A41F218DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC2751C42;
	Mon, 18 Mar 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y83Cv5wk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246375102E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771738; cv=none; b=sGO2YlN7+DDPQbqPa0Lljsq7uIl88isPZOFtdtIuQQtVdyuEqy+upy7YeK2cjALczgoVM6LbarDWYr7rR/tI0RCFcIrgE48LH7XWw4XtG5vqefZcXvx0yni0FvT6a+JqSwjRhtVaR+DOT5yFHH+jY4yXxiD6ohxc13F45CAX7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771738; c=relaxed/simple;
	bh=4/q/EMrAMtWY6Hm3er7C/PYaAI6HzuztCzjketcjdnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=rbeEGxRXUU3/EVOGv0t54x8hH6k/U12Qe53w8gjCkTuR+dXUWBP2GzUILxE6+LFmYCLvb2LXh7ymeTm7iL8BzoS3/Rna2lvuPgqsLl/+xbAGtPpNr+nrGzskBqIPz/lcb6fUuv+TTLxxmR0aLH4SHCeIw5b8NAIl0QpchBujDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y83Cv5wk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710771736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKTxTfeu0kP46EkkGNeeOEWSSdSnmFAW9kbc1VMhmsg=;
	b=Y83Cv5wkiorA1HXvLzZ4MyOYOeMwOWDXgObv8zt/wmsdK7v3dZ+i1dKf01OVYTztXPsgEE
	g76FrCSIpclYYZM9RPT+N8UkjD14GwqOH07tWhuHrvvUfymzwVtuYhjE+L0W0CxQaX5r9G
	Y74uJL7qK5Bgx2RisKww3YfEWGxdzik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-GqW5-K1AMTGX1X-eXiw5PA-1; Mon, 18 Mar 2024 10:22:12 -0400
X-MC-Unique: GqW5-K1AMTGX1X-eXiw5PA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBA65101A588;
	Mon, 18 Mar 2024 14:22:11 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB3EC492BC4;
	Mon, 18 Mar 2024 14:22:08 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 6/6] mm/mm_init.c: remove arch_reserved_kernel_pages()
Date: Mon, 18 Mar 2024 22:21:38 +0800
Message-ID: <20240318142138.783350-7-bhe@redhat.com>
In-Reply-To: <20240318142138.783350-1-bhe@redhat.com>
References: <20240318142138.783350-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Since the current calculation of calc_nr_kernel_pages() has taken into
consideration of kernel reserved memory, no need to have
arch_reserved_kernel_pages() any more.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/include/asm/mmu.h |  4 ----
 arch/powerpc/kernel/fadump.c   |  5 -----
 include/linux/mm.h             |  3 ---
 mm/mm_init.c                   | 12 ------------
 4 files changed, 24 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 3b72c7ed24cf..aa5c0fd5edb1 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -406,9 +406,5 @@ extern void *abatron_pteptrs[2];
 #include <asm/nohash/mmu.h>
 #endif
 
-#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
-#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
-#endif
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d14eda1e8589..ae8c7619e597 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1735,8 +1735,3 @@ static void __init fadump_reserve_crash_area(u64 base)
 		memblock_reserve(mstart, msize);
 	}
 }
-
-unsigned long __init arch_reserved_kernel_pages(void)
-{
-	return memblock_reserved_size() / PAGE_SIZE;
-}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1888b1935103..8147b1302413 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3221,9 +3221,6 @@ static inline void show_mem(void)
 extern long si_mem_available(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
-#ifdef __HAVE_ARCH_RESERVED_KERNEL_PAGES
-extern unsigned long arch_reserved_kernel_pages(void);
-#endif
 
 extern __printf(3, 4)
 void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9ed4b9e77c4a..370a057dae97 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2383,17 +2383,6 @@ void __init page_alloc_init_late(void)
 	page_alloc_sysctl_init();
 }
 
-#ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
-/*
- * Returns the number of pages that arch has reserved but
- * is not known to alloc_large_system_hash().
- */
-static unsigned long __init arch_reserved_kernel_pages(void)
-{
-	return 0;
-}
-#endif
-
 /*
  * Adaptive scale is meant to reduce sizes of hash tables on large memory
  * machines. As memory size is increased the scale is also increased but at
@@ -2436,7 +2425,6 @@ void *__init alloc_large_system_hash(const char *tablename,
 	if (!numentries) {
 		/* round applicable memory size up to nearest megabyte */
 		numentries = nr_kernel_pages;
-		numentries -= arch_reserved_kernel_pages();
 
 		/* It isn't necessary when PAGE_SIZE >= 1MB */
 		if (PAGE_SIZE < SZ_1M)
-- 
2.41.0


