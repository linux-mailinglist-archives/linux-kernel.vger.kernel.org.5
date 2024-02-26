Return-Path: <linux-kernel+bounces-81347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27186748D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D7F1C28508
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630A1C686;
	Mon, 26 Feb 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBfbrPRb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB896027A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949700; cv=none; b=fc+6wFrTtHHOKk6VWlw8Og2fhntZ4BYv8+yCD/LnD7eiFUCtTu0xzKdhoxtPyQGOpCweON7wI7yglSftI1OQxDHBbCpvIdaurkYnJOqjy3kRYElHQors/bRRd2RnP7Ln+aVzBrSffnhgadfFnfh291uleSzMFwzvi7/gWXlLIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949700; c=relaxed/simple;
	bh=E8F0ZCmU82aU1vZM9HjGgaP6K8kQAaxKdvncayLIhSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWulbo5ScBYnsFDmyIOr36InMiMswBfsPlZbNCjLrvBEhzGg7mZ5AiIFa2WL47AAS3eei/SrIVWuRSEByskQ3IjaHygjka0fJuk2m+0fud6YhBefm11MorIshHpwgEiamvFPJVm4HePt+l6AckX6edPWdd2ugyYeQKhrOUgidaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBfbrPRb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708949699; x=1740485699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8F0ZCmU82aU1vZM9HjGgaP6K8kQAaxKdvncayLIhSY=;
  b=HBfbrPRbvbIWIpQNk8Ec/ZVUiFjdquOC2Vu8e4b5WilD8VhrRJmXDLLx
   9SfY3ZXhhW3G9SOS4MslcdogAWFh49aizwZgAG6s5e3Js5wIEvJYGLsfw
   l6Z3VcSNASR4tZzPRJMNjfWjo7shRP7Wq32+dLPpvj1YEEfNhivi7EmHJ
   fJ3evvqSPqlyOIN74WNuj2AGYS5qcFzbIW9sMJCFEBpIhjVeatGtd3L9J
   4uoDsP1Cg8Iw2w0F4h/UdTVH+AbGTFJvxdCHEV/Wbm0lcpyTdOBpq/8r5
   0FuSiw59Fj04s/iWK7BPinWy+vq521LpwYF8hoiCLfu1a9dwi9jg83JSq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3362749"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3362749"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 04:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029957"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029957"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 04:14:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 979203C1; Mon, 26 Feb 2024 14:14:54 +0200 (EET)
Date: Mon, 26 Feb 2024 14:14:54 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org, 
	bp@alien8.de
Subject: Re: [RFC][PATCH 11/34] x86/cpu/intel: Prepare MKTME for "address
 configuration" infrastructure
Message-ID: <wtdmrkjfvlf4b5mkpqw537u6xuxkdajix2knbo5ivanjzzpvvg@qqlw7gaetujj>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183941.7CB634A5@davehans-spike.ostc.intel.com>
 <z52bbgqxtr7wpa3yqqgbwurb6vx6i7gpddae2rrbxkjasuhnuk@7zsudlb4tw6s>
 <b01f92b3-65ea-474b-8dc9-f2e1ca6ae0af@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b01f92b3-65ea-474b-8dc9-f2e1ca6ae0af@intel.com>

On Fri, Feb 23, 2024 at 08:22:16AM -0800, Dave Hansen wrote:
> On 2/23/24 03:33, Kirill A. Shutemov wrote:
> > On Thu, Feb 22, 2024 at 10:39:41AM -0800, Dave Hansen wrote:
> >> From: Dave Hansen <dave.hansen@linux.intel.com>
> >>
> >> Intel also does memory encryption and also fiddles with the physical
> >> address bits.  This is currently called for *each* CPU, but practically
> >> only done on the boot CPU because of 'mktme_status'.
> >>
> >> Move it from the "each CPU" ->c_init() function to ->c_bsp_init() where
> >> the whole thing only gets called once ever.  This also necessitates moving
> >> detect_tme() and its entourage around in the file.
> > The state machine around mktme_state doesn't make sense if we only call it
> > on boot CPU, so detect_tme() can be drastically simplified. I can do it on
> > top of the patchset.
> 
> That would be great.  Looking at it again, the (tme_activate !=
> tme_activate_cpu0) block is total cruft now.  It probably just needs to
> get moved to secondary CPU startup.

I have never saw the check to be useful. I think it can be just dropped.

The patch below makes detect_tme() only enumerate TME and MKTME. And
report number of keyid bits. Kernel doesn't care about anything else.

Any comments?

From 1080535093d21f025d46fd610de5ad788591f4b5 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 26 Feb 2024 14:01:01 +0200
Subject: [PATCH] x86/cpu/intel: Simplify detect_tme()

The detect_tme() function is now only called by the boot CPU. The logic
for cross-checking TME configuration between CPUs is no longer used. It
has never identified a real problem and can be safely removed.

The kernel does not use MKTME and is not concerned with MKTME policy or
encryption algorithms. There is no need to check them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 44 ++-----------------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4192aa4576f4..60918b49344c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -329,55 +329,20 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
 #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
 
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
 static int detect_tme(struct cpuinfo_x86 *c)
 {
-	u64 tme_activate, tme_policy, tme_crypto_algs;
-	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
+	int keyid_bits, nr_keyids;
+	u64 tme_activate;
 
 	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
 
-	if (mktme_status != MKTME_UNINITIALIZED) {
-		if (tme_activate != tme_activate_cpu0) {
-			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
-			pr_err_once("x86/tme: MKTME is not usable\n");
-			mktme_status = MKTME_DISABLED;
-
-			/* Proceed. We may need to exclude bits from x86_phys_bits. */
-		}
-	} else {
-		tme_activate_cpu0 = tme_activate;
-	}
-
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
 		return 0;
 	}
 
-	if (mktme_status != MKTME_UNINITIALIZED)
-		goto detect_keyid_bits;
-
 	pr_info("x86/tme: enabled by BIOS\n");
 
-	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
-	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
-		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
-
-	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
-		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
-				tme_crypto_algs);
-		mktme_status = MKTME_DISABLED;
-	}
-detect_keyid_bits:
 	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
 	nr_keyids = (1UL << keyid_bits) - 1;
 	if (nr_keyids) {
@@ -387,11 +352,6 @@ static int detect_tme(struct cpuinfo_x86 *c)
 		pr_info_once("x86/mktme: disabled by BIOS\n");
 	}
 
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
-	}
-
 	return keyid_bits;
 }
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

