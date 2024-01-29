Return-Path: <linux-kernel+bounces-42597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A896840398
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FC31F213CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38945F564;
	Mon, 29 Jan 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLXdZQBX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8015EE60
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526849; cv=none; b=uI+tSKbtdQ/oQKjxEXw1D36gQLo5RlzJ1QUiZb/9iBWBYPtsZhLdiuHU4EDoFI2cCga97615Z7T4g0IRs65OxNrUgnkAsl4arz/zNjXo4Ajs9fuoHXvfjc0ZyfmI31t0uEcR63XL45siDZQVQu8RbDZhuN15HKEWNZyJ+jrGTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526849; c=relaxed/simple;
	bh=I4gxSa9YE8dZelntOrU+Hi4kAJP1ulsGJuomatELRgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL/Xfd3eCnca9I7sSCr5Tg5NawG1YksQaDlSdoxKu+dT44yirpxGtVRwnQtL1KDN97QbTWaA46WgYKXYcBr34a6f9nQI49mzsOxorrFrrdjoigxouwm6e5aLaA5BD1V47RB57+qVdOkJigTiq3xBE8PU3BaDw+pFyiI6xld/yZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLXdZQBX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706526848; x=1738062848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4gxSa9YE8dZelntOrU+Hi4kAJP1ulsGJuomatELRgY=;
  b=PLXdZQBXrFbo25ZV2gOoOH//kXVUtu2SzVzV0ZFixR9XqZ5vVT+G5YeI
   pvw9K14rSVc/i4GhlhPxkBqcuBzcFJvjwa/OkcFEb8NCKZktUnbmG0RYf
   QAeeZPr3pYZoJL5ohKj6Vezxnk5tWZjWZF9SBalTJUz7UoekZ2TcA8H3j
   UOoM0sOB8bZuNQg7q0i349wTEaX7LopG/O0FggThUwlLIb0ggH5sexeSv
   HEW4o/S/5xWKlP5y29q9PwsJGaujuvWoITo6fisjfwtiqHkKxGFUn3VfT
   jirAKJXFwCMBBBKa8w5Eu6YRJEEk1Z0yA4GIx4HN1fEH8OCSme83WDIhE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21448887"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21448887"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="878044370"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="878044370"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2024 03:14:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 29C46125; Mon, 29 Jan 2024 12:36:09 +0200 (EET)
Date: Mon, 29 Jan 2024 12:36:09 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <r5logoyy46fztohkm6bjobomsrst2izbs2nsts4fegii2uswca@fovizly7y5ju>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
 <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>

On Mon, Jan 29, 2024 at 04:24:09AM -0600, Kalra, Ashish wrote:
> In case of SNP and crash/kdump case, we need to prevent the boot_ghcb being
> converted to shared (in snp_kexec_unshare_mem()) as the boot_ghcb is
> required to handle all I/O for disabling IO-APIC/lapic, hpet, etc., as the
> enc_kexec_unshare_mem() callback is invoked before the apics, hpet, etc. are
> disabled.
> 
> Is there any reason why enc_kexec_unshare_mem() callback is invoked in crash
> case before the IO-APIC/lapic, hpet, etc. are shutdown/disabled ?

Not really. Either way works for TDX. I've tested the patch below. Is it
what you want?

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 6585a5f2c2ba..3001f4857ed7 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -107,11 +107,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	crash_smp_send_stop();
 
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
-		x86_platform.guest.enc_kexec_stop_conversion(true);
-		x86_platform.guest.enc_kexec_unshare_mem();
-	}
-
 	cpu_emergency_disable_virtualization();
 
 	/*
@@ -129,6 +124,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		x86_platform.guest.enc_kexec_stop_conversion(true);
+		x86_platform.guest.enc_kexec_unshare_mem();
+	}
+
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

