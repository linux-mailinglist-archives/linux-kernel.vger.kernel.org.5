Return-Path: <linux-kernel+bounces-42820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F96B84074A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB45287226
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA2657AD;
	Mon, 29 Jan 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCoPOiTL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE9657A9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535849; cv=none; b=qfjcGJHOxyzmY4/BZ8t0qDQ3oOalKB3jueKHIODiBYVoQWayrzPiZEu4Tk58nINhKeL9fh6ocYeae+8F4OwiK2SWV3PSISqChHmj29Sy5B0dtigvSLCKKXyyFOUJZ+40rl9Q7uqZb4Yypq1rBlKrD4vD/PtMmTx1cnzSUdhjnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535849; c=relaxed/simple;
	bh=S8kbVyjQ+Xxyq/e0oWsbM2LE48Ugi1oJFP+DJtdQZK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS1gtvxMYP3p0ZBOjtaSMinJVG0wYtGx9k1GHHjk4OC6clq98RWV57cXcIgjLDC2i+srynVfA2IT8wixRJhGHiNm4c/9S2lcZ8t9bxE1R5Trz7AWcz23slCNurgVRmOmBCwy18e0zHOeS1boqP8Lj8RE4GEPqojBEV6z/QNiLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCoPOiTL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706535847; x=1738071847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8kbVyjQ+Xxyq/e0oWsbM2LE48Ugi1oJFP+DJtdQZK8=;
  b=HCoPOiTLyZMpcCo9nXaEKAJceipANUFkcnRRy4Sb8XnQv4wVW1LJV6Fb
   AC9OT9aVEQPs8p/yVI1jRQsqHgtYVUh2FV71bvla92MEIveziyZo9Puqd
   7RYjezbx+oQTfr7af1c+iQm+3kTSRocK12ie0ScDmDXiTAV7DSw7J1QmP
   ZJgDE+222BtVo0eK7YMpqCCDb7P35HPkiUY78vQ15qVA+k++j5fznSGSz
   Pfe1jBbvGx28x5JfATtAajGT5kWiEcaQr6FnDhRfO7LX6kWsUySdUxdYt
   fannQw0LQ228dFQ4ZhOeBvFZiNIMPr8DE0VAuTKJdeagnVm9KQX6R2wJz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16311027"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16311027"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="931093593"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="931093593"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2024 05:44:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 992EC53C; Mon, 29 Jan 2024 15:34:26 +0200 (EET)
Date: Mon, 29 Jan 2024 15:34:26 +0200
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
Message-ID: <ao36mdmctptya2r25v3lvuocjbhllum2upmskxjcjtt3c7o3ii@nsghte2cnmkx>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
 <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>
 <r5logoyy46fztohkm6bjobomsrst2izbs2nsts4fegii2uswca@fovizly7y5ju>
 <fad515ec-aba3-4f48-b8be-ebc6640899e3@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad515ec-aba3-4f48-b8be-ebc6640899e3@amd.com>

On Mon, Jan 29, 2024 at 07:09:37AM -0600, Kalra, Ashish wrote:
> Hello Kirill,
> 
> On 1/29/2024 4:36 AM, Kirill A. Shutemov wrote:
> > On Mon, Jan 29, 2024 at 04:24:09AM -0600, Kalra, Ashish wrote:
> > > In case of SNP and crash/kdump case, we need to prevent the boot_ghcb being
> > > converted to shared (in snp_kexec_unshare_mem()) as the boot_ghcb is
> > > required to handle all I/O for disabling IO-APIC/lapic, hpet, etc., as the
> > > enc_kexec_unshare_mem() callback is invoked before the apics, hpet, etc. are
> > > disabled.
> > > 
> > > Is there any reason why enc_kexec_unshare_mem() callback is invoked in crash
> > > case before the IO-APIC/lapic, hpet, etc. are shutdown/disabled ?
> > Not really. Either way works for TDX. I've tested the patch below. Is it
> > what you want?
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 6585a5f2c2ba..3001f4857ed7 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -107,11 +107,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >   	crash_smp_send_stop();
> > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > -		x86_platform.guest.enc_kexec_stop_conversion(true);
> > -		x86_platform.guest.enc_kexec_unshare_mem();
> > -	}
> > -
> >   	cpu_emergency_disable_virtualization();
> >   	/*
> > @@ -129,6 +124,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >   #ifdef CONFIG_HPET_TIMER
> >   	hpet_disable();
> >   #endif
> > +
> > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > +		x86_platform.guest.enc_kexec_stop_conversion(true);
> > +		x86_platform.guest.enc_kexec_unshare_mem();
> > +	}
> > +
> >   	crash_save_cpu(regs, safe_smp_processor_id());
> >   }
> 
> Yes, this will work for SNP.

Okay, good. Will include the change into the next version of the patchset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

