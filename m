Return-Path: <linux-kernel+bounces-19327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6FA826B71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42981C21F96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7313ADC;
	Mon,  8 Jan 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0J4Jq8l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18B13AD8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704708963; x=1736244963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nAoV/4uxsiWvej/YdpQzm9DtSV2JOFymBVOkYdlfxs=;
  b=J0J4Jq8lr7DFyfrPF1dWNmSQcoZL1Au8YfZ/NGXfaWxP+K3A6EmSZ5Yp
   5UT8rxP/OVN8s5Olx2A00x9/Uubv/S8rX30Hiu/VOZnAqitKITB7SZxnj
   mX3MV0GA278frsmUMdXzFAfzHmmwSqtocmIueAxh6xMlmd8xbpbSYLmxT
   SzW+qpvsh29qFxEhumjCav5CgsBRdymrIShtqMTC2FGhy1l1KJwTb0/84
   frBwNAQfxS6rb/d3LpXNqikvCK59BC51MU2Q+3cFqGmN/Sch7g7v97QZs
   E82P/6B0ntesJdmis3wgskH50mgsmNtjt0eeJOV1aKm6GH6rVMdrWrAl7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4634134"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="4634134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:16:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="731062339"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="731062339"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:15:56 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6FAB5109E5C; Mon,  8 Jan 2024 13:15:53 +0300 (+03)
Date: Mon, 8 Jan 2024 13:15:53 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5.1 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Message-ID: <20240108101553.4zgji5emlw7cjlik@box.shutemov.name>
References: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
 <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
 <d23475c878ce1bc899a6b9f613252e985d97d094.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23475c878ce1bc899a6b9f613252e985d97d094.camel@intel.com>

On Mon, Jan 08, 2024 at 03:04:31AM +0000, Huang, Kai wrote:
> On Mon, 2023-12-25 at 11:05 +0300, Kirill A. Shutemov wrote:
> > If the helper is defined, it is called instead of halt() to stop the CPU
> > at the end of stop_this_cpu() and on crash CPU shutdown.
> > 
> > ACPI MADT will use it to hand over the CPU to BIOS in order to be able
> > to wake it up again after kexec.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> > 
> >  v5.1:
> >    - Fix build for !SMP;
> > 
> > ---
> >  arch/x86/include/asm/smp.h |  1 +
> >  arch/x86/kernel/process.c  |  7 +++++++
> >  arch/x86/kernel/reboot.c   | 12 ++++++++----
> >  3 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> > index 4fab2ed454f3..390d53fd34f9 100644
> > --- a/arch/x86/include/asm/smp.h
> > +++ b/arch/x86/include/asm/smp.h
> > @@ -38,6 +38,7 @@ struct smp_ops {
> >  	int (*cpu_disable)(void);
> >  	void (*cpu_die)(unsigned int cpu);
> >  	void (*play_dead)(void);
> > +	void (*stop_this_cpu)(void);
> >  
> >  	void (*send_call_func_ipi)(const struct cpumask *mask);
> >  	void (*send_call_func_single_ipi)(int cpu);
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index b6f4e8399fca..ea4c812c7bf3 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
> >  	 */
> >  	cpumask_clear_cpu(cpu, &cpus_stop_mask);
> >  
> > +#ifdef CONFIG_SMP
> > +	if (smp_ops.stop_this_cpu) {
> > +		smp_ops.stop_this_cpu();
> > +		unreachable();
> > +	}
> > +#endif
> 
> If I read correctly this will result in stop_this_cpu() having different
> behaviour for SMP and !SMP build for TDX guest.  For example, AFAICT
> machine_halt() also calls stop_this_cpu() on local cpu after it stops other
> cpus.  So for the local cpu, in SMP build it will calls into BIOS's reset vector
> but in !SMP it will call native_halt().

It doesn't make a difference in practice: both halt and giving CPU to
BIOS will be unrecoverable operation. Both are equally acceptable for
machine_halt().

> > +
> >  	for (;;) {
> >  		/*
> >  		 * Use native_halt() so that memory contents don't change
> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index 16dde83df49a..738b3e810196 100644
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -881,10 +881,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
> >  	cpu_emergency_disable_virtualization();
> >  
> >  	atomic_dec(&waiting_for_crash_ipi);
> > -	/* Assume hlt works */
> > -	halt();
> > -	for (;;)
> > -		cpu_relax();
> > +
> > +	if (smp_ops.stop_this_cpu) {
> > +		smp_ops.stop_this_cpu();
> 
> Could you explain why unreachable() is called in stop_this_cpu() but not here?

Compiler complained previously on stop_this_cpu() when it had halt() in
'else' case because the function is declared as __noreturn. I left
unreachable() after reworking it without 'else' to document the behaviour.

> > +	} else {
> > +		halt();
> > +		for (;;)
> > +			cpu_relax();
> > +	}
> 
> Similar to stop_this_cpu(), if you also call unreachable() here, then I think
> you can remove the 'else' here but directly calls halt() + cpu_relax() loop.

It doesn't make much difference to me. But okay, I will rework it the same
way in the next version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

