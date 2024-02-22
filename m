Return-Path: <linux-kernel+bounces-77187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA218601E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D5DB2B724
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4514EFE0;
	Thu, 22 Feb 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMmQWUkS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1014F982
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627215; cv=none; b=VZ8ltX3SM7EEXqfTktvOLfhoeymi+6lUmMK2Hku8mrtAyXRo7wqaqLtPTdjBLIUAGTtUGrL4xBJGs3Y5ccDIvMATCQkaGa7Um+8wjh9vrPEm5ZHXhyZpvmYpuMppP861gSdpb8qc3khMeZEy5E4OM/LBE8LrczbvVqIVtF2SwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627215; c=relaxed/simple;
	bh=Obutb+ESHGeqmvetKboeJ++LnGPxlJatRe9M06PslHw=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=gIHQ94+l4riQqWIhf2058H41ZUxIkj8iblHnhOYUW0TVtuS582a2MNbcNlHZVQOMiXw2keKuh97ywG4Ivmmn7ib0Ag4xP8rnhKTs0PezTuIooqSuTtzZOAlQ/MGzpkl64CwWo/jjI4sHQat6dTiyIwr2RmGG7tqZaNZL7CuYxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMmQWUkS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627212; x=1740163212;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Obutb+ESHGeqmvetKboeJ++LnGPxlJatRe9M06PslHw=;
  b=XMmQWUkSPSoZY/ijTDEWeuGmpzCV/TRXR3n8mcCJMRTlsLEO8TRD6/Vu
   5dFBurbEcjD36x7UdTggNcymPUyOzzaJ6FyctAxQnBhJutwZBjlVBsGgg
   C+j6+WF08SxcytSPc79XAyIMHvTtW/ub6ij0ekuWmDxXtORfYcXcPzAW4
   BJ497F5Eguey5fw4Yo2uOsr5l1WHnkTynukjPB7SX08elVLTBKew+4DOR
   SeACujQ59sr8jWJbFJOdulX2xo60BIvhxWCt6qhTWNaAOf4sBfojJWfK8
   Bd8Z0YFAi9AGyTtyiehltfXS0vzzbsPOmgXmLoDuu3CQvxIvPeNg3Mawd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584605"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584605"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265302"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:10 -0800
Subject: [RFC][PATCH 33/34] x86/cpu: Make get_cpu_address_sizes() static and __init
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:09 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184009.B40837D5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Now that all the other users are gone and the final user is in the same file
and __init, get_cpu_address_sizes() can be static and __init.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/common.c |    2 +-
 b/arch/x86/kernel/cpu/cpu.h    |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/x86/kernel/cpu/common.c~get_cpu_address_sizes-__init arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~get_cpu_address_sizes-__init	2024-02-22 10:09:04.677089966 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:09:04.681090123 -0800
@@ -1109,7 +1109,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 }
 
-void get_cpu_address_sizes(struct cpuinfo_x86 *c)
+static void __init get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 	bool vp_bits_from_cpuid = true;
diff -puN arch/x86/kernel/cpu/cpu.h~get_cpu_address_sizes-__init arch/x86/kernel/cpu/cpu.h
--- a/arch/x86/kernel/cpu/cpu.h~get_cpu_address_sizes-__init	2024-02-22 10:09:04.677089966 -0800
+++ b/arch/x86/kernel/cpu/cpu.h	2024-02-22 10:09:04.681090123 -0800
@@ -64,7 +64,6 @@ static inline void tsx_ap_init(void) { }
 extern void init_spectral_chicken(struct cpuinfo_x86 *c);
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
-extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
 extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
 extern void init_intel_cacheinfo(struct cpuinfo_x86 *c);
_

