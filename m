Return-Path: <linux-kernel+bounces-77167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A458601D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B774F289F01
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96286137905;
	Thu, 22 Feb 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RX4MhTwE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896873F23
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627185; cv=none; b=mXoiSdKjYM8BZHy53WUY8QS0VRRNsbR/gi7HABPwjeDB8hWyEx3BvqLo4Zs2PKyYHFrPeYe5/++rC1+B562dIyWZSIhZXpBFPb6MC9IMCg/bu57ieS4AT5++RUSgFKmtzO9QcoU9uFRpywrEHj983elrvkrI1weoVjrQw/mVgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627185; c=relaxed/simple;
	bh=/PqHI8dXtTkUo2JUzmH+1ZxYuceTKX87drzFBQmtdRg=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=qy7j+FmrhqDKWt8AXLyiqZ7eQp6fDIsvC9Tv7DpobfkmXMbKXcTwPX1njkX+k+MPIaDShksOI4mo1/sMz9PrPoKr67h/vxOtCZWYVrJeRheLBOQb71ixGNx050Vzxa8oHJcDqap6EAjj/uJsc5iWtwK816LIJp7Jy0fFa5W2RCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RX4MhTwE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627185; x=1740163185;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=/PqHI8dXtTkUo2JUzmH+1ZxYuceTKX87drzFBQmtdRg=;
  b=RX4MhTwEszzjfcWGhP0wbKNEql+fZcLSI8F7KVpDq9THLyRksNIvumFo
   Zw9QCcvOs+FzXLeM75D3PeEjdqdZrbG3DVpL1fpIm44QD63QLpDoZpa7i
   QJWKNUVNbRl908lyVo+7fj0OuWpUXbvmm1ePMHpjCcccu3+449ISXQ+xw
   BKWIuxKK9FR3IpsyhN7q8FObLN3kY2URJiDyFVQFbg5ppPMSAdMZTb9zl
   qUkjmOgkAIotLh+Htj8O5yu15+5wHPXMaJYwAZ0EF7GoTVOrxT9NVHskw
   5iGFbLY0c0DqJxf3k/61DKiUpwkHJO3KNJeGPmOWLACR/kXFsC9obJw7o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031784"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031784"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975499"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:45 -0800
Subject: [RFC][PATCH 13/34] x86/boot: Use address reduction config to handle erratum
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:44 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183944.5B4F16F1@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Continue to chip away at sites that muck with ->x86_phys_bits.  This
one is an oldie but a goodie:

	af9c142de94e ("[PATCH] x86_64: Force correct address space size for MTRR on some 64bit Intel Xeons")

Evidently, the CPUs in question "report 40bit, but only have 36bits
of physical address space."  Since there's now a handy way to reduce
the amount of physical address bits, use that to reduce from 40->36.

This means there are now two (Intel) users of the address bits
reduction feature.  There is no way a 2005-era CPU will ever have TME,
but it is still nice to be more explicit about the possibility of a
collision.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/intel.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff -puN arch/x86/kernel/cpu/intel.c~intel-phys-addr-errata arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~intel-phys-addr-errata	2024-02-22 10:08:54.772701150 -0800
+++ b/arch/x86/kernel/cpu/intel.c	2024-02-22 10:08:54.776701306 -0800
@@ -242,11 +242,6 @@ static void early_init_intel(struct cpui
 		c->x86_cache_alignment = 128;
 #endif
 
-	/* CPUID workaround for 0F33/0F34 CPU */
-	if (c->x86 == 0xF && c->x86_model == 0x3
-	    && (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
-		c->x86_phys_bits = 36;
-
 	/*
 	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states.
@@ -344,7 +339,7 @@ static void early_init_intel(struct cpui
 #define MKTME_UNINITIALIZED		2
 static int mktme_status = MKTME_UNINITIALIZED;
 
-static void detect_tme(struct cpuinfo_x86 *c)
+static int detect_tme(struct cpuinfo_x86 *c)
 {
 	u64 tme_activate, tme_policy, tme_crypto_algs;
 	int keyid_bits = 0, nr_keyids = 0;
@@ -368,7 +363,7 @@ static void detect_tme(struct cpuinfo_x8
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
 		mktme_status = MKTME_DISABLED;
-		return;
+		return 0;
 	}
 
 	if (mktme_status != MKTME_UNINITIALIZED)
@@ -401,16 +396,28 @@ detect_keyid_bits:
 		mktme_status = MKTME_ENABLED;
 	}
 
-	/* KeyID bits effectively lower the number of physical address bits */
-	bsp_addr_config.phys_addr_reduction_bits = keyid_bits;
+	return keyid_bits;
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
 {
+	int keyid_bits = 0;
+
 	resctrl_cpu_detect(c);
 
 	if (cpu_has(c, X86_FEATURE_TME))
-		detect_tme(c);
+		keyid_bits = detect_tme(c);
+
+	/* KeyID bits effectively lower the number of physical address bits */
+	bsp_addr_config.phys_addr_reduction_bits = keyid_bits;
+
+	/* CPUID workaround for 0F33/0F34 CPU */
+	if (c->x86 == 0xF && c->x86_model == 0x3
+	    && (c->x86_stepping == 0x3 || c->x86_stepping == 0x4)) {
+		/* Warn if MKTME and this workaround collide: */
+		WARN_ON_ONCE(keyid_bits);
+		bsp_addr_config.phys_addr_reduction_bits = 4;
+	}
 }
 
 #ifdef CONFIG_X86_32
_

