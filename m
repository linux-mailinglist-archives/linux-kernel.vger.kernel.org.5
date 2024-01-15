Return-Path: <linux-kernel+bounces-26491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA2182E1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000CD1F22D48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322EE1AACD;
	Mon, 15 Jan 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NPa52H9b"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC21AABC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 73AC340E01A9;
	Mon, 15 Jan 2024 20:47:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 77EnVeJyFhvV; Mon, 15 Jan 2024 20:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705351644; bh=TVY6gJjvwhH/ULoloQ3TbejbwKrrbUPZG3A9u663HrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPa52H9blg3O9/d3LIMQfpSI254TJ0oH0cn6fSs+PMNoEPW+JBScuwIbCANvQtWPZ
	 d0TPqza/v03p28MZEreBcavm/Dap4GYCAxhR1JyxeZsY2OG2fH6RVrnDK7/yueY8Ej
	 Kq2rMt+SIC5IepyaULUnFehPhS2gK1kayp7bjwwAzoXWbHiedI+qiJjVPqWlDDC4mZ
	 iuYgZPxrvnMpHPz0NOCeknpar+ic/3am6JID36WBLZor8Fg0QHJ/OxNsYdlqeiTeqC
	 ANHX4nBYzWgU/iKFIfvFC3b/yDMLQA8By1Q7NXRFmrUDcdDzUFXUD/KBAOg2k25xlg
	 71YhlGXei1O2rA+tyW9iDWwkQ1fGM6IVwGeHWY3qBAOe23/R0yC15hOma2uh7czaFl
	 3NdQfX/GpY3YNCaqaXK/i7FMbAVJp86nIZ/PO9BU++Gtdx56yFY71WP2jFojKLub0b
	 MCFSSMgT2dy3GLiTHlTShJosK5YoFOQtFRdeYkcTmBzrVNyKeqw5rG9x5TgmCIIAsF
	 ONwwNbAw2vCnkm21Rn5f86JfYFg0OmpBLnQb2bdiATFkZPF3PysuxuATHh225Md5Uk
	 JaqzciAiZfybjjKmWIZ7k189MO59dGbJjD2kC0del34fGTRtdFj7m+vNFqHZR5bFXv
	 ACaC98vfCf8np1xbnkp0mqvg=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC5B740E00C5;
	Mon, 15 Jan 2024 20:46:39 +0000 (UTC)
Date: Mon, 15 Jan 2024 21:46:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
	Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111223650.3502633-1-kevinloughlin@google.com>

On Thu, Jan 11, 2024 at 10:36:50PM +0000, Kevin Loughlin wrote:
> SEV/SME code can execute prior to page table fixups for kernel
> relocation. However, as with global variables accessed in
> __startup_64(), the compiler is not required to generate RIP-relative
> accesses for SEV/SME global variables, causing certain flavors of SEV
> hosts and guests built with clang to crash during boot.

So, about that. If I understand my gcc toolchain folks correctly:

mcmodel=kernel - everything fits into the high 31 bit of the address
space

-fPIE/PIC - position independent

And supplied both don't make a whole lotta of sense: if you're building
position-independent, then mcmodel=kernel would be overridden by the
first.

I have no clue why clang enabled it...

So, *actually* the proper fix here should be not to add this "fixed_up"
gunk everywhere but remove mcmodel=kernel from the build and simply do
-fPIE/PIC.

I'd say...

I could also be missing something obvious ofc.

> Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
> Fixes: c9f09539e16e ("x86/head/64: Check SEV encryption before switching to kernel page-table")
> Fixes: b577f542f93c ("x86/coco: Add API to handle encryption mask")
> Tested-by: Kevin Loughlin <kevinloughlin@google.com>

You don't need to add your Tested-by tag - it is kinda assumed that
people submit patches *after* testing them. Although I have a gazillion
examples where that is not the case...

:-\

> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

