Return-Path: <linux-kernel+bounces-24646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB8382BFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2884D1F24AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654D6A031;
	Fri, 12 Jan 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcToq9du"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EF6A024
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705061859; x=1736597859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xvCX4d6bX2d4IAUESbi7SQnSQnl8gaBJl/nEkzGvOoo=;
  b=FcToq9durZcYm9L3BiWAr+IYgsb8X76Ndg+JDIc2XvToq7/E0SkuPIxC
   m2LVSBt/fJLGTKrLKnZqDkvexW664YnbSqU5VZzLcvG922nVnpNfwSpKv
   l8vz0mfBWbnV4xVYQK1MaOp+PWYYUxuLb5riREbcPqN64X3lq4l1+HsW/
   4mvVxR00kCsKDla/0bzPv35XQC3sy9mx8zpsNRhxQUCW9PCrdDXkxU6nn
   wqJFKOypXY/Gym/UlRpMZHrmrMNakBWP/QG1pALCAeIMQmKHzdLp0SLYC
   /c6sw/Jq9qlZlzvdd0D9eQ/xIfEO2geOAnMUezs3GddmK4rDOYvZVmTKu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20627413"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="20627413"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="775990528"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="775990528"
Received: from kschuele-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:17:27 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 13ED110A557; Fri, 12 Jan 2024 15:17:25 +0300 (+03)
Date: Fri, 12 Jan 2024 15:17:25 +0300
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
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Steve Rutherford <srutherford@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Wang Jinchao <wangjinchao@xfusion.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-coco@lists.linux.dev,
	Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <20240112121725.3amxlumpifhagamb@box>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111223650.3502633-1-kevinloughlin@google.com>

On Thu, Jan 11, 2024 at 10:36:50PM +0000, Kevin Loughlin wrote:
> SEV/SME code can execute prior to page table fixups for kernel
> relocation. However, as with global variables accessed in
> __startup_64(), the compiler is not required to generate RIP-relative
> accesses for SEV/SME global variables, causing certain flavors of SEV
> hosts and guests built with clang to crash during boot.
> 
> While an attempt was made to force RIP-relative addressing for certain
> global SEV/SME variables via inline assembly (see snp_cpuid_get_table()
> for example), RIP-relative addressing must be pervasively-enforced for
> SEV/SME global variables when accessed prior to page table fixups.
> 
> __startup_64() already handles this issue for select non-SEV/SME global
> variables using fixup_pointer(), which adjusts the pointer relative to
> a `physaddr` argument. To avoid having to pass around this `physaddr`
> argument across all functions needing to apply pointer fixups, this
> patch introduces the macro GET_RIP_RELATIVE_PTR() (an abstraction of
> the existing snp_cpuid_get_table()), which generates an RIP-relative
> pointer to a passed variable. Similarly, PTR_TO_RIP_RELATIVE_PTR() is
> introduced to fixup an existing pointer value with RIP-relative logic.

Can we replace existing fixup_pointer() (and other fixup_*()) with the new
thing? I don't think we need two confusing things for the same function.

Also, is there any reason why GET_RIP_RELATIVE_PTR() and
PTR_TO_RIP_RELATIVE_PTR() have to be macros? Inline functions would be
cleaner.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

