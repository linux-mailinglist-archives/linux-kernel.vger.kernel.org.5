Return-Path: <linux-kernel+bounces-69200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACB98585A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B1B22755
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A19A145FE3;
	Fri, 16 Feb 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WnwjsxD1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921A1350DA;
	Fri, 16 Feb 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109080; cv=none; b=FHe6ktGz0p66+Rd7oaL/FWUphn2e9LLTPhdLllA2vCVrpVwFc3sZ7Ozm1LAfKW3xKbZWSyk8AWoDNOd8RXpmX9xwiydfu4qRB925+Ybiox/ist5A69Eng/MyHlrBqQEGPRf1P3tG2FPSg1pNSi2kw8i0d3QdEMSnc2BcdLMoWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109080; c=relaxed/simple;
	bh=hJV2Di9TWXWAH3jf5tFtKbA4cNPOaMlqPYf8O81MJlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzX8HJuw3lTLzPe7/rhqkaaQ+nessS4K0+m5lHCzexDwlQQmcb/XwwwEBrQ12ckP9JUrYJRvXYqitKYq2WNgZDZs04tOURTu58Prpx8UGhnxGVUPMm38A4O8ctjHLwJlnooUaldcVXze+9qy7AvXUk+fnNVb6jEJfOLIyEpLKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WnwjsxD1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JPht/1NFabyfyAOA5BnhQyFPe9WOLuLC26kmHTjwpJ4=; b=WnwjsxD1L1lvhPKHcta+fg5QNv
	mNvLs2E2BVgDiXG1+rHXoVpgxMdweoF9Z2/QMR1miNan5T+p9pxwVUexrD0fzJRd32j1ZQc+rUOE/
	rFRXTBwu9OXwEiyLB5XvSnD0fXw8C0xLmH8XSGYVkSYh3kCbEqTrLeMy/O5Iz+S43136WS33xxVyg
	43ePNyMUTLCyiv58BFK8ket/CJEtNsLx2PMuTmHc70Y4WGS99GrItcIBoXuAseN071UXVmNrJagnq
	8EyLtNzGZ1LrbvCNbw3qhKQe7coIJR2tNt21j+DZ5ta3RSeWN0Mp9pEejrT/Xdqa5Aqfdtj/4Zlz9
	Fc7OTCpw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb3Bz-00000005ODb-2ifl;
	Fri, 16 Feb 2024 18:44:11 +0000
Date: Fri, 16 Feb 2024 18:44:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [RFC 6/8] KEYS: PGP data parser
Message-ID: <Zc-s-42WoZhW_2c8@casper.infradead.org>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
 <20240216152435.1575-7-petrtesarik@huaweicloud.com>
 <Zc-Q5pVHjngq9lpX@casper.infradead.org>
 <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>

On Fri, Feb 16, 2024 at 05:53:01PM +0100, Roberto Sassu wrote:
> On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:
> > On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
> > > From: David Howells <dhowells@redhat.com>
> > > 
> > > Implement a PGP data parser for the crypto key type to use when
> > > instantiating a key.
> > > 
> > > This parser attempts to parse the instantiation data as a PGP packet
> > > sequence (RFC 4880) and if it parses okay, attempts to extract a public-key
> > > algorithm key or subkey from it.
> > 
> > I don't understand why we want to do this in-kernel instead of in
> > userspace and then pass in the actual key.
> 
> Sigh, this is a long discussion.

Well, yes.  When you don't lay out why this is of value, it turns into a
long discussion.  This isn't fun for me either.

> PGP keys would be used as a system-wide trust anchor to verify RPM
> package headers, which already contain file digests that can be used as
> reference values for kernel-enforced integrity appraisal.

The one example we have of usage comes in patch 7 of this series and is:

gpg --dearmor < <PGP key> | keyctl padd asymmetric "" @u

And you're already using two userspace programs there.  Why not a third?

gpg --dearmor < <PGP key> | ./scripts/parse-pgp-packets | keyctl padd asymmetric "" @u

> With the assumptions that:
> 
> - In a locked-down system the kernel has more privileges than root
> - The kernel cannot offload this task to an user space process due to
>   insufficient isolation
> 
> the only available option is to do it in the kernel (that is what I got
> as suggestion).

This sounds like there's some other way of getting the key into the
kernel which doesn't rely on userspace.  Or are you assuming that nobody
bothered to trojan 'cat'?

