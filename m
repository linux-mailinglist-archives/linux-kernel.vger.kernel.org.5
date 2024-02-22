Return-Path: <linux-kernel+bounces-77160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23668601C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722091F28406
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69A6E616;
	Thu, 22 Feb 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e26LNNjI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037756E5E3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627176; cv=none; b=EJByfHpXvFq4ZoCLaMf3jlGl0ERJFa6tc8kMWuFs17vx+wO+zQ7Ab58XUvDhNCyexPLavd417PSJIbhjUujYLvAf8AZn8bboQKg39+YpK0o4uhKxbnDt9Uk/KtrSSNCpmxLqw3FcCNuE8lqmd9ppuOQFQXaCV/PDiNrLmTs+vj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627176; c=relaxed/simple;
	bh=54nIGzcSRinqh/gqJc7uUClCQgBTJWKE3mQsU0/+39M=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=fvrdzLhdJZTO6jj8xSvbltKq+qA1GOEjn+eOmkdi1hgCyAKag5Z4YBd0HabzTKJtz9XgUymS23PkL4neQppP1nFXcnOoF1mazF117I1E48YX7A3ADB4KxOD0FH6wGBkgH/ZkubXSLXR1ClQFKmsXyKWE0/ClgLLp7p9dzIvYJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e26LNNjI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627176; x=1740163176;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=54nIGzcSRinqh/gqJc7uUClCQgBTJWKE3mQsU0/+39M=;
  b=e26LNNjIBucQIGmtd40DA59i5VO6rMeLqwpUdRVtLEqAcVk4h3KEUoKX
   7/qXVXRWaUbAeFqBhgFXYN2s2SQbmmhqrPuisuMVwinW8gWtQIIiNS/Xw
   zoQzCmLz60IUhow8JGGjQi+ZzBwEj0OYSCucAg5/lO2ghX0+rH0biNAYx
   ++lLPRpXkqW7f9jkdjX/BC9k+aPxn48XjUZm6bdWQ3eIqKZZJ7jRxBo04
   5QX47wookAWHn5DbMS+uEHzOurH7zDC4Y+COENVWbY4kKvtP44X2PYK1v
   awI1U3pPOqUCPU5tdklGAjDrfATC2V9pXPBu7TKSgmhkHTUuXnvYWsmnb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031723"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031723"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975421"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:35 -0800
Subject: [RFC][PATCH 06/34] x86/boot: Use consistent value for iomem_resource.end
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:34 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183934.033178B5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The 'struct cpuinfo_x86' values (including 'boot_cpu_info') get
written and overwritten rather randomly.  They are not stable
during early boot and readers end up getting a random mishmash
of hard-coded defaults or CPUID-provided values based on when
the values are read.

iomem_resource.end is one of these users.  Because of where it
is called, it ended up seeing .x86_phys_bits==MAX_PHYSMEM_BITS
which is (mostly) a compile-time default.  But
iomem_resource.end is never updated if the runtime CPUID
x86_phys_bits is lower.

Set iomem_resource.end to the compile-time value explicitly.
It does not need to be precise as this is mostly to ensure
that insane values can't be reserved in 'iomem_resource'.

Make MAX_PHYSMEM_BITS available outside of sparsemem
configurations by removing the #ifdef CONFIG_SPARSEMEM in the
header.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/sparsemem.h |    3 ---
 b/arch/x86/kernel/setup.c          |   10 +++++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff -puN arch/x86/kernel/setup.c~iomem_resource_end arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~iomem_resource_end	2024-02-22 10:08:51.048554948 -0800
+++ b/arch/x86/kernel/setup.c	2024-02-22 10:21:04.485531464 -0800
@@ -51,6 +51,7 @@
 #include <asm/pci-direct.h>
 #include <asm/prom.h>
 #include <asm/proto.h>
+#include <asm/sparsemem.h>
 #include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
@@ -813,7 +814,14 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	early_reserve_memory();
 
-	iomem_resource.end = (1ULL << x86_phys_bits()) - 1;
+	/*
+	 * This was too big before.  It ended up getting MAX_PHYSMEM_BITS
+	 * even if .x86_phys_bits was eventually lowered below that.
+	 * But that was evidently harmless, so leave it too big, but
+	 * set it explicitly to MAX_PHYSMEM_BITS instead of taking a
+	 * trip through .x86_phys_bits.
+	 */
+	iomem_resource.end = (1ULL << MAX_PHYSMEM_BITS) - 1;
 	e820__memory_setup();
 	parse_setup_data();
 
diff -puN arch/x86/include/asm/sparsemem.h~iomem_resource_end arch/x86/include/asm/sparsemem.h
--- a/arch/x86/include/asm/sparsemem.h~iomem_resource_end	2024-02-22 10:19:56.842831828 -0800
+++ b/arch/x86/include/asm/sparsemem.h	2024-02-22 10:20:21.207804806 -0800
@@ -4,7 +4,6 @@
 
 #include <linux/types.h>
 
-#ifdef CONFIG_SPARSEMEM
 /*
  * generic non-linear memory support:
  *
@@ -29,8 +28,6 @@
 # define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
 #endif
 
-#endif /* CONFIG_SPARSEMEM */
-
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
 extern int phys_to_target_node(phys_addr_t start);
_

