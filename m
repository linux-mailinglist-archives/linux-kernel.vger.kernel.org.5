Return-Path: <linux-kernel+bounces-20284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBCA827CD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F231F24208
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1675257B;
	Tue,  9 Jan 2024 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsx5NgFC"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658D23B1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704767166; x=1736303166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ntTFhgz1h7IGs75VitS84UbD82B8uL3db9/I2c/7MQk=;
  b=fsx5NgFCjsJ92YOEXJ7zxyvI/nFgx+gmhhwsfr81mPccdksaT1kdcARZ
   uOU4T1F12KN0I6ZXaNFU0zSDaDPsysGS12FcOy1eDxeFNEwhqYsNWxlVQ
   EuwskCxKSU/M+kCZBb+LkgV2+Qn2seGJ8cCZYpcQOD4xyNZslWbIiaBYA
   Si47bG4WAk9S3VniEKugWU41zXADvZgYM3Yl1ZNk6u1DjCg0aOqLgYqbL
   reOG37dSgh3w04xCSZKyV8rHCQ/NgxMG54Iy95gEFZJKVkkjgEIUE5Ktj
   6fTXpyDkqKBu6YcA53w9cPGRjqlz/8dQfVUxMuuzV3+2o1iwkNoqp3fHE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="484241883"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="484241883"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="16116191"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:26:05 -0800
Date: Mon, 8 Jan 2024 18:26:03 -0800
From: Andi Kleen <ak@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCHv2] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <ZZyuu2UZuz8OvZ1B@tassilo>
References: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
 <b69afad98d043ddfb685982c9977105f1b563485.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69afad98d043ddfb685982c9977105f1b563485.camel@intel.com>

> This seems depends on the BIOS will always use 4-level paging.  Can we make such
> assumption?

Yes I believe it's fine. All BIOS on 5 level capable systems currently 
only use 4-level when passing control to someone else.

(although I cannot find the quote in the UEFI spec currently, will check
on that)

The UEFI run time environment is defined as 4-level. Changing that would
break compatibility OS supprt at least for run time services.


> 
> > +
> > +	/* Paging mode is correct proceed in 64-bit mode */
> > +
> > +	LOCK_AND_LOAD_REALMODE_ESP lock_rip=1
> > +
> > +	movw	$__KERNEL_DS, %dx
> > +	movl	%edx, %ss
> > +	addl	$pa_real_mode_base, %esp
> > +	movl	%edx, %ds
> > +	movl	%edx, %es
> > +	movl	%edx, %fs
> > +	movl	%edx, %gs
> > +
> > +	movl	$pa_trampoline_pgd, %eax
> > +	movq	%rax, %cr3
> > +
> > +	jmpq	*tr_start(%rip)
> 
> IIUC you won't be using __KERNEL_CS in this case?  Not sure whether this matters
> though, because the spec says in 64-bit mode the hardware treats CS,DS,ES,SS as
> zero.

That's a good catch. Might be better to use __KERNEL_CS. Otherwise if a
IRET happens later and it tries to reload CS it might fault. Probably
doesn't happen before another reload happens anyways, but it's better
to avoid it.

-Andi

