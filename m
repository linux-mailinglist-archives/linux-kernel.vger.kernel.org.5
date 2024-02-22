Return-Path: <linux-kernel+bounces-77172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E1E8601D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522501F290EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09E140E2B;
	Thu, 22 Feb 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZHNMckL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E7137932
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627192; cv=none; b=DslV5nsxNgrAz7Yzu5gKuQKI1/HbU6Mib5R6C6skahxlDSob69q1ZEpg14tcLwETT2sdvx+5OEPxP7awdXqug20pN+4D+z6wDeDxdmN4Yfv5PTvVcjckV00oS+8usRepIrTwUN3xZ1gZ4F5epmcAI8fqo1tBsWm752jcuYs3+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627192; c=relaxed/simple;
	bh=tiABm/o18DPqMhSfzvK1w9HdGuxe4IVkXU92OGIYjng=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=UZOLwPqxKMatEtR2m5EWFHBH7DbBt8WPgzBcombK7wRVaZk2FCeAka8gPV7w79SbzER5ewNUjGGLvcKjNco+GKzYMdKJIlCjEwO56qEb+Rfd0ZCnE3H0KOehfs+5GJyBZDFf6WMP7XHUNbC5QOkdKvgY9qc1n5YL6iL3p0jJRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZHNMckL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627192; x=1740163192;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=tiABm/o18DPqMhSfzvK1w9HdGuxe4IVkXU92OGIYjng=;
  b=YZHNMckLx4OE1Yfdx78bBnLVuhg24KVBrYgHQmss2t6vqs4Ti9CZpKKn
   fJA+E9ydCEasxmUcYtyoLYxx1wIMk0lmaziSRKUzpoukRn1c+nqpdPgaD
   fw/gtCFdUZjL4GhrEGSCn9WYncUr6G8rQAFzcg6CZLU1ZaTN6bPcDYSch
   sHSVGzreIjNFqSKuXT8xDyukMMG1hSB0O5QwXtTRw85p1WycT80qdqxNe
   pbdeyxYh5aPRd900FrFxVS83TBLchWg49t1a8jCkYt8mUtsgRLkDzDg4+
   mCV7TCHqOFYGeEY2itCuqW16drs/amtK3OVj/tQarV77tcQaFk+ni7lpd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031824"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031824"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975552"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:51 -0800
Subject: [RFC][PATCH 18/34] x86/cpu/centaur: Move cache alignment override to BSP init
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:50 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183950.92A959F2@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The 'x86_cache_alignment' is yet another system-wide value which is stored
per-cpu.  Stop initializing it per-cpu on (some) Centaur CPUs and move it
to a new BSP init function.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/centaur.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff -puN arch/x86/kernel/cpu/centaur.c~centaur-c_early_init arch/x86/kernel/cpu/centaur.c
--- a/arch/x86/kernel/cpu/centaur.c~centaur-c_early_init	2024-02-22 10:08:57.268799139 -0800
+++ b/arch/x86/kernel/cpu/centaur.c	2024-02-22 10:08:57.268799139 -0800
@@ -61,12 +61,8 @@ static void init_c3(struct cpuinfo_x86 *
 	if (c->x86_model >= 6 && c->x86_model < 9)
 		set_cpu_cap(c, X86_FEATURE_3DNOW);
 #endif
-	if (c->x86 == 0x6 && c->x86_model >= 0xf) {
-		c->x86_cache_alignment = x86_clflush_size() * 2;
-		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
-	}
-
-	if (c->x86 >= 7)
+	if ((c->x86 == 0x6 && c->x86_model >= 0xf) ||
+	    (c->x86 >= 7))
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 }
 
@@ -217,6 +213,12 @@ static void init_centaur(struct cpuinfo_
 	init_ia32_feat_ctl(c);
 }
 
+static void bsp_init_centaur(struct cpuinfo_x86 *c)
+{
+	if (c->x86 == 0x6 && c->x86_model >= 0xf)
+		c->x86_cache_alignment = x86_clflush_size() * 2;
+}
+
 #ifdef CONFIG_X86_32
 static unsigned int
 centaur_size_cache(struct cpuinfo_x86 *c, unsigned int size)
@@ -241,6 +243,7 @@ static const struct cpu_dev centaur_cpu_
 	.c_vendor	= "Centaur",
 	.c_ident	= { "CentaurHauls" },
 	.c_early_init	= early_init_centaur,
+	.c_bsp_init	= bsp_init_centaur,
 	.c_init		= init_centaur,
 #ifdef CONFIG_X86_32
 	.legacy_cache_size = centaur_size_cache,
_

