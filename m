Return-Path: <linux-kernel+bounces-20138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9817A827A77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAF5284D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3D56463;
	Mon,  8 Jan 2024 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBlo94uZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B05645E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704751113; x=1736287113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QWtHOj9jcmef+zZ+8hvlkxNwgvkmKP+JDW0HCkknOWc=;
  b=iBlo94uZDp5l7Qwhlv3AoN1/UQhB3FxvuHLup9ZBmUhqdXFwH8mcObfi
   57kULn/BskHNABHX/ldPej4OfGnO/jeZQDUm5sRmJCHflg3pY3pYZ/7jQ
   SwYFX0V7BY+NBwGU4NHUXJXpwz9KRWRvbHNsi1cUuwuP3EGHnyUbxuzpW
   vlWuCMrE8cTKZYDTTz0j9S4/6tpBbwltlRZLtBn89TZV4pgQXO5Wmwvhu
   gSBSXBPdN/3EoMmMrzghWxLyBORs7+UBUydZ83N7/dt86BkLbP4iqOEU0
   Nj+BnwT7WX+Jp7/b13gnk98kc/NjQvARZC0vexwh5lcHBIb4Uz7AcTYqX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19518179"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="19518179"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 13:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757750785"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="757750785"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 13:58:29 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id AD78B10944C; Tue,  9 Jan 2024 00:58:26 +0300 (+03)
Date: Tue, 9 Jan 2024 00:58:26 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv2] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <20240108215826.mgiasmqh6hmy2zwa@box.shutemov.name>
References: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
 <ZZwgbz4J_R8E1_uQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZwgbz4J_R8E1_uQ@google.com>

On Mon, Jan 08, 2024 at 08:18:55AM -0800, Sean Christopherson wrote:
> On Sun, Jan 07, 2024, Kirill A. Shutemov wrote:
> > @@ -220,6 +222,33 @@ SYM_CODE_START(trampoline_start64)
> >  	lidt	tr_idt(%rip)
> >  	lgdt	tr_gdt64(%rip)
> >  
> > +	/* Check if paging mode has to be changed */
> > +	movq	%cr4, %rax
> > +	xorq	tr_cr4(%rip), %rax
> 
> This is buggy, tr_cr4 is only 4 bytes.  And even if tr_cr4 were 8 bytes, the reason
> why nothing showed up in testing is also why only 4 bytes need to be XOR'd: the
> upper 32 bits of the result are never consumed.

Oh. Good catch. Will fix.

tr_cr4 will need to be changed to 8 bytes soonish. FRED uses bit 32 of the
register.

> > +	andq	$X86_CR4_LA57, %rax
> 
> Nit, this can be TEST instead of AND, e.g. I was looking to see if RAX was used
> anywhere in the flow.  And in theory it's possible a CPU could support uop fusing
> for TEST+Jcc but not AND+Jcc, cause shaving a cycle in this code is obviously
> super important ;-)
> 
> And as above, testl, not testq.

Fair enough. Will use testl.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

