Return-Path: <linux-kernel+bounces-22561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04682829FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC711C22AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDEE4D102;
	Wed, 10 Jan 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7sPz6UQ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6134D130
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704908985; x=1736444985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3tMaRHrNobztAav5ypuwIp4QVL+27VKqJqu4MQ0v50=;
  b=V7sPz6UQsT/Z+DCgRIDNgsK8goV8gESCOLo4/dcsg8yqxQhmNS/KbmTb
   ZZQYVv5Ger8S6SB+hatHfZ8G1YMYYtM/x5AG8/1pdJp7vIdMg+ESZkdKa
   aMrGQrjmfcDEo/Bey4CPJGhuoOp9oZ+988R5SztzCD3rBL3LhCeFzRc0t
   hAfmV6nZ9MlQ1l/edMzGEALbqh9fIMsjkZePn17G50eozeJ08Zxx6LLAe
   7m5F1LcqgtsfCyRXpXLKmDI8rgzrnvT6tjCE0xA0jUzmdDlbfsDijN2Ep
   NrZMs6dHVI2aPBBuTiaRL8KXrmHmBOklQecoKzjGoWTLwSFcjUKLBoMuo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="402373794"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="402373794"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 09:49:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="30687266"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 09:49:46 -0800
Date: Wed, 10 Jan 2024 09:49:44 -0800
From: Andi Kleen <ak@linux.intel.com>
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-coco@lists.linux.dev,
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>,
	Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH] x86/sev: x86/sev: enforce PC-relative addressing in
 clang
Message-ID: <ZZ7YuEexYSaZYmLK@tassilo>
References: <20240110012640.1335694-1-kevinloughlin@google.com>
 <ZZ6DSdaaoYKzgp4K@tassilo>
 <CAGdbjmJcQeLWroBkbRC-cFQ6OuMHONsGLzpUrrA5k3uc8Rzkmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGdbjmJcQeLWroBkbRC-cFQ6OuMHONsGLzpUrrA5k3uc8Rzkmw@mail.gmail.com>

> On that note, I do have another version of this patch that abstracts
> snp_cpuid_get_table() into a macro along the lines of...
> 
> #define GET_RIP_RELATIVE_PTR(var) \
> ({  \
>  void *ptr; \
>  asm ("lea "#var"(%%rip), %0" \
>       : "=r" (ptr) \
>       : "p" (&var)); \
>  ptr; \
> })
> 
> ...and uses this new macro to access all SEV/SME global variables (not
> just the cpuid_table). It's similar in nature to `fixup_pointer()`
> (currently defined in arch/x86/kernel/head64.c) but doesn't require us
> to pass around `physaddr` from `__startup64()`. This wouldn't
> introduce any new execution model changes between clang vs gcc and
> would be consistent with the kernel's current approach of relying on
> developers to manually apply fixups for global variable accesses prior
> to kernel relocation. I can send an RFC v2 for the
> GET_RIP_RELATIVE_PTR() version of this patch.

That looks like a far better solution indeed.

Ideally objtool would check for this, perhaps with a new ELF
section. But actually doing that might be far more work, so perhaps not
worth it.

Thanks,

-Andi

