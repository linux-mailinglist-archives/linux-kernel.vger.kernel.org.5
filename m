Return-Path: <linux-kernel+bounces-51490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F2848BD5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F233D28513F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56CB651;
	Sun,  4 Feb 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTSi/5ss"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEE8F72
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031560; cv=none; b=WgrR1LKqf99v6P4WzH/fpuvyDxN/5llubSmnG6YFDKM9Tv+RATF9EGYkMWVDgXAS5psXNc/eNICRE0k7ihqd0mSJQxzMb/Jw4vMvYyUAh7H95J0b6DTLHju4AUD25s7VTcf6MdR0HnpLgDGa+yPkhasu5KQnX6QalPkTAEXDE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031560; c=relaxed/simple;
	bh=XCrF050gBkNnvs/zW5kUe24x6uor+IW7v7gGuky9BFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4MlbeB+/XdFXiX+h+XyPZSig34C2Nfos3S9girNTA1fgpKQgyuZ5sbjDD5hRkEGSGMpUxKn3Gjhr//Qb/nmjiDHTIk/tYeAai4v1YZzCRw5cSxMeZ8FIKiNWOc61B1YZdS5+hQxrcdHxbWL22VdQO7baBgYY16qBl8NkzywPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTSi/5ss; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707031555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XjdCCFvLZWXa+p6w0grRH8helkAbuAcZzUNjMEzv69g=;
	b=jTSi/5ssnW+B2nZEdWTkraj+NF2JCrWuvd7e4JHe7/hl/HGvc17fKTh1a9EEBhUmJ1eZuB
	IV+7vK5AwGnnzGePtP11nEJeG/oz0XWhA7hfYhzPjMNdi0smuMpmmce88hja0a/2MpU6BR
	GhRfx1q4MHJCktItjGy6MfTjjsUQkkc=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Gang Li <gang.li@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>
Cc: Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP system
Date: Sun,  4 Feb 2024 15:25:24 +0800
Message-Id: <20240204072525.1986626-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Randy Dunlap and kernel test robot reported a warning:

```
WARNING: unmet direct dependencies detected for PADATA
  Depends on [n]: SMP [=n]
  Selected by [y]:
  - HUGETLBFS [=y] && (X86 [=y] || SPARC64 || ARCH_SUPPORTS_HUGETLBFS [=n] || BROKEN [=n]) && (SYSFS [=y] || SYSCTL [=n])
```

hugetlb parallelization depends on PADATA, and PADATA depends on SMP, so
when the SMP config is disabled, the dependency of hugetlb on padata
should be downgraded to single thread.

Fixes: f2f635264b98 ("hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/lkml/ec5dc528-2c3c-4444-9e88-d2c48395b433@infradead.org/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402020454.6EPkP1hi-lkp@intel.com/
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
```
Hi Andrew, this fix patch is based on mm/mm-unstable.
Thanks!
```
---
 fs/Kconfig   | 2 +-
 mm/hugetlb.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 3abc107ab2fbd..f2bc73fc0417e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,7 +261,7 @@ menuconfig HUGETLBFS
 	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	depends on (SYSFS || SYSCTL)
 	select MEMFD_CREATE
-	select PADATA
+	select PADATA if SMP
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf3d5dfb921e6..1b01b244fb50b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3457,6 +3457,7 @@ static void __init gather_bootmem_prealloc_node(unsigned long start, unsigned lo
 
 static void __init gather_bootmem_prealloc(void)
 {
+#ifdef CONFIG_PADATA
 	struct padata_mt_job job = {
 		.thread_fn	= gather_bootmem_prealloc_node,
 		.fn_arg		= NULL,
@@ -3469,6 +3470,9 @@ static void __init gather_bootmem_prealloc(void)
 	};
 
 	padata_do_multithreaded(&job);
+#else
+	gather_bootmem_prealloc_node(0, 0, NULL);
+#endif
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
@@ -3568,6 +3572,7 @@ static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 
 static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 {
+#ifdef CONFIG_PADATA
 	struct padata_mt_job job = {
 		.fn_arg		= h,
 		.align		= 1,
@@ -3600,7 +3605,9 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 	job.max_threads	= num_node_state(N_MEMORY) * 2;
 	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;
 	padata_do_multithreaded(&job);
-
+#else
+	hugetlb_pages_alloc_boot_node(0, h->max_huge_pages, h);
+#endif
 	return h->nr_huge_pages;
 }
 
-- 
2.20.1


