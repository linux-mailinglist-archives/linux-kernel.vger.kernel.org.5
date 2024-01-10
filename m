Return-Path: <linux-kernel+bounces-22255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8454829B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891481F211D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B665948CEB;
	Wed, 10 Jan 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPhnoxYf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753534A994
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704893827; x=1736429827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3KjM4afpgsVkg16ec8qhOMcIMU+MFDkAz+XeEDCLYjk=;
  b=TPhnoxYfGeNSdELeoOn5XtcSkU7D6IW/Bg2Nj3hnlwke+dhZ4MzVXc/E
   FQKTo3G0bjFiAFl/JXkyUk2ERiOSPFO8TPvVGFa7E65BaAyg7JvKL6vCF
   NXn+gSkWb6vN6iv3eMBMWLdM3ThQKFEmyXY6eXbO5+4s8ReQPGbssFTOA
   DY0B/UjXfwq6oF3tkysPjegrDl35URIwHUundxkn+ZuJ1qTExezOE2rYt
   nv3FeZBF7/Nipz3B0F1Rpw9AnnapjlqVr8+xnLrn2xbj4ddX9n7Oo6Q5p
   wq5fHQXbyMiEsn+emZFj1TEY8rS04n1COJ4n4s8v/b7RO8D20CkglNG65
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="5291538"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5291538"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 05:37:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="24271084"
Received: from jganji-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.249.37.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 05:37:00 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 4DBCC109589; Wed, 10 Jan 2024 16:36:57 +0300 (+03)
Date: Wed, 10 Jan 2024 16:36:57 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ze Gao <zegao2021@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-coco@lists.linux.dev,
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>,
	Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH] x86/sev: x86/sev: enforce PC-relative addressing in
 clang
Message-ID: <20240110133657.vbpzplchgaim3bya@box>
References: <20240110012640.1335694-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110012640.1335694-1-kevinloughlin@google.com>

On Wed, Jan 10, 2024 at 01:26:39AM +0000, Kevin Loughlin wrote:
> SEV/SME code can execute prior to page table fixups for kernel
> relocation. However, as with global variables accessed in
> __startup_64(), clang does not currently generate PC-relative accesses
> for SEV/SME global variables, causing certain flavors of SEV hosts and
> guests to crash.
> 
> While an attempt was made to force PC-relative addressing for certain
> global SEV/SME variables via inline assembly (see snp_cpuid_get_table()
> for example), PC-relative addressing must be pervasively-enforced for
> SEV/SME global variables that can be accessed prior to page table
> fixups.
> 
> To avoid the error-prone approach of manually referencing each SEV/SME
> global variable via a general form of snp_cpuid_get_table(), it is
> preferable to use compiler flags for position-independent code (ex:
> `-fPIE`) that result in PC-relative accesses. While architecture-
> specific code for Linux can be pervasively compiled as position-
> independent on select architectures (ex: RISC-V), this is not currently
> the case for x86-64 and would require extensive changes (see "[PATCH
> RFC 00/43] x86/pie: Make kernel image's virtual address flexible" for
> example).
> 
> Fortunately, the relevant files for SEV/SME code do indeed support
> position-independent clang compilation, so we can use this technique to
> ensure all global variables in these files are accessed via PC-relative
> addressing.
> 
> Unlike clang, gcc does not currently allow `-fPIE` in conjunction with
> `mcmodel=kernel`. Thus, to preserve existing gcc behavior, this patch
> does not remove the (otherwise unnecessary) inline assembly that
> already enforces PC-relative addressing for select SEV/SME globals
> (mentioned above). If gcc supports these joint options in the future,
> we can remove such inline assembly and also apply this patch to gcc
> builds.
> 
> Tested by successful boot of SEV-SNP guest built with clang, alongside
> Adam Dunlap's necessary "[PATCH v2] x86/asm: Force native_apic_mem_read
> to use mov".
> 

Similar issues was fixed before with fixup_pointer() tricks. Have you
tried looking this direction.

Relevant thread starting with:

https://lore.kernel.org/all/20210920192341.maue7db4lcbdn46x@box.shutemov.name

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

