Return-Path: <linux-kernel+bounces-22130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD168299C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCC283646
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A622495D0;
	Wed, 10 Jan 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Agtz1M7D"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048454D589
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704887122; x=1736423122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3hr8WKe3hLRmQmvxepGB6Y30XVCdzwD/ynaPZtClRaU=;
  b=Agtz1M7DVualQghZ4zcpwpcoeN22cLhbsgq/1DIjFQVY2YTLmi4LtBHy
   10dTfF9tliZHp2vFw5Fl/OKmUX9lSpkkLNLIWPfi0mmlO1IionVBxPjxR
   LAh2xlllt+6FCESpi8+p0kkK3qBCfzG2wqRR66ZiTeqoy91nBdwNlp3ko
   JDBls9oHKB9g7S5KpVdo1bPiSxFBGRHFSod+Sf2dPJ06R1fKxmmG4p3Mo
   Hjiy7Cw2lMGAjQP7zPEnQSqlWBJYFZc6ilUWiQHQbM44xV8dZ4Lv93aSJ
   5HSs8eDtvX2FJ9/DdOBCdXUqQABO17GxDgA//csQy4CbDWR+I7BJR6GxG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="397345288"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397345288"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 03:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="901127739"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="901127739"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 03:45:19 -0800
Date: Wed, 10 Jan 2024 03:45:13 -0800
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
Message-ID: <ZZ6DSdaaoYKzgp4K@tassilo>
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

That seems to be fundamental problem.

> relocation. However, as with global variables accessed in
> __startup_64(), clang does not currently generate PC-relative accesses
> for SEV/SME global variables, causing certain flavors of SEV hosts and
> guests to crash.

And that's a hack to work around it.

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

But if gcc doesn't support it then it doesn't work.

It seems your approach with incompatible execution models between
the compilers is just a recipe for future patches only working
on one of the compilers because most code submitters probably
won't test both.

It would be better to at least use a unified execution model, if you want
to extend the hack and not fix the underlying issue.

-Andi

