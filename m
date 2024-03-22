Return-Path: <linux-kernel+bounces-111898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996D887254
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95AF285C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92360ECA;
	Fri, 22 Mar 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfXJ7utq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3F60DC4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130197; cv=none; b=G/VPTbUj1WxnyuLq4mNIZ57koKTYWSWoePHInWxjHRK5GDTCM+/NxXx3REkvlSKcYcMZnAE7QjjHDy0iwUKMF7w+92OpJ1IHnU4oCnuGBhrp3RW1/Xy+0aPlmiyIJ7YKdrXkso3HS7MC1EqdnxFt1qTKBvZsT3+zseITrqc+plk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130197; c=relaxed/simple;
	bh=51E44xibqm2XCqxvXeVFkvEQyB4taeFDCUjpIpBBY3U=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=EEbb71WsOoAoQ7hXfNMl/hS9sR6r4cCN4BIxjw6dZZmWaihFWDqGFW40gdKVDgCbBWERtmCYtSH6EvdaH+pA/NjKqAIaHP/vo9rHho/o02LIs8e5dKs5C4/kbUeAHhtVcwC7LTN13lGkvDbij+oHlbkiqNq6/sUW4VnQf/PNKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfXJ7utq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130196; x=1742666196;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=51E44xibqm2XCqxvXeVFkvEQyB4taeFDCUjpIpBBY3U=;
  b=TfXJ7utqN6MegT8sc6NT7U6ma56/oLMUFri5jRmFIQg5X/as5a55xcJE
   Aajs0cM4VraXviqW3VjkZ3EAc6P1qZI3WufRZK+aLkJfSoojQPupL7tQN
   aAXqpzu3RG6aYKuzOrrAtMdU/7rT4PqlNEgIU8LJzXk1k3E82L9DJUiyN
   bqFGWJEooq76wBFMGAB+Fm53PLCcmujUqpdG5+vRfL7gniLx4Pqrnd93V
   35HKvjuptE+E4UUtgtCuALa37PBfmuB53lvgMv7mmSV17Hyw/NJ5IOylp
   cX4sFUEvhLHfiWvIqdh+QI0ZtrcWmBetMl7s/hT469mkqErux81PN2Jhv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28669710"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28669710"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15425579"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 22 Mar 2024 10:56:35 -0700
Subject: [PATCH 4/4] x86/xen: Enumerate NX from CPUID directly
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 22 Mar 2024 10:56:34 -0700
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
In-Reply-To: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
Message-Id: <20240322175634.80024377@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

xen_start_kernel() is some of the first C code run "Xen PV" systems.
It precedes things like setup_arch() or processor initialization code
that would be thought of as "very early".

That means that 'boot_cpu_data' is garbage.  It has not even
established the utter basics like if the CPU supports the CPUID
instruction.  Unfortunately get_cpu_cap() requires this exact
information.

Nevertheless, xen_start_kernel() calls get_cpu_cap().  But it
works out in practice because it's looking for the NX bit which
comes from an extended CPUID leaf that doesn't depend on
c->cpuid_level being set.

Stop calling get_cpu_cap().  Use CPUID directly.  Add a little
helper to avoid cluttering up the xen_start_kernel() flow.

This removes the risky, barely-working call to get_cpu_cap().

Note: The '& 31' strips the "capability" word off of an
      X86_FEATURE_* value.  It's a magic number, but there are
      a few of them sparsely scattered around and it's way
      shorter than any helper.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
---

 b/arch/x86/xen/enlighten_pv.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff -puN arch/x86/xen/enlighten_pv.c~xen-explain1 arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~xen-explain1	2024-03-22 09:30:25.499892614 -0700
+++ b/arch/x86/xen/enlighten_pv.c	2024-03-22 09:30:25.503892742 -0700
@@ -1306,6 +1306,21 @@ static void __init xen_domu_set_legacy_f
 
 extern void early_xen_iret_patch(void);
 
+/*
+ * It is too early for boot_cpu_has() and friends to work.
+ * Use CPUID to directly enumerate NX support.
+ */
+static inline void xen_configure_nx(void)
+{
+	bool nx_supported;
+	u32 eax = 0;
+
+	get_cpuid_region_leaf(0x80000001, CPUID_EDX, &eax);
+
+	nx_supported = eax & (X86_FEATURE_NX & 31);
+	x86_configure_nx(nx_supported);
+}
+
 /* First C function to be called on Xen boot */
 asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 {
@@ -1369,9 +1384,7 @@ asmlinkage __visible void __init xen_sta
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
-	/* Work out if we support NX */
-	get_cpu_cap(&boot_cpu_data);
-	x86_configure_nx(boot_cpu_has(X86_FEATURE_NX));
+	xen_configure_nx();
 
 	/*
 	 * Set up kernel GDT and segment registers, mainly so that
_

