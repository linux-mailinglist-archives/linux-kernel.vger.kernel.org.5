Return-Path: <linux-kernel+bounces-141027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097F68A1A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53E4B25EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE41CA6CD;
	Thu, 11 Apr 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGaTBU7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E51CA6BA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849923; cv=none; b=qX/BhX3EMbodPNgDL39DdZHFCCfnRhE+L3+um4DTA8rQjo/rvRBP9o8lFnrPs2OAPG1zpAjG6216lzN3c7Nm/O///ec7kFsPu24mjwSVSt/X7UD7Y5SI65nbD/F7X2tnGNgZt91iLXF7G9yuzvN3HnF1MlIkQ85UW4dSq+XMnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849923; c=relaxed/simple;
	bh=0XIFigNg8okTi2XcwCJDslMjIxGNFSCDsSh68/q0Ud4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl06GZOQTmgqiin3OLd7xhP+qQEOwqQC5EvtdnxAopEepzgDsI7MIXioLMVGGFWHiSGwRDgQzkxK21XTG4CyQAv34oBgOdrXowY8F587J4SScviNGPPFbN6dZzES/GGWkH64YXYOYZA0LnvHTdORDdxYIez4XnlrPSVU07SvAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGaTBU7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE207C113CE;
	Thu, 11 Apr 2024 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849923;
	bh=0XIFigNg8okTi2XcwCJDslMjIxGNFSCDsSh68/q0Ud4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGaTBU7dJ/KuPVA22cvjffRpSftlAU4O+LZZLSuPk3heq+ij90Fsc7u3tN9JEsmIU
	 lt6D6iwTiFikA3C0RWCvWY1lIdpzdaDrnUJeyMPYpI/oOSiSj+oDQrdRZKnt0IqKOE
	 7D9KZ2d51dyUy3fqlmFxFECXFdXtiwlklgm2RhJhwIIo3IJ8ivMcfzzeabnW57Irqd
	 lPWciXlA5yanNZE8QiY2lE66HZoawFU9OTMsRQFmMO8zH0YRcrOq00SaJsJmR4YWbX
	 SEu0Q1TzjcQCjKyUR9JdkI/4Mqu0+3JSGch87GkcLkhh+BRFknnUkA7kO29MmPTcx6
	 LrwpuKlS+G+Eg==
Date: Thu, 11 Apr 2024 08:38:41 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Message-ID: <20240411153841.zexbsqrdli54kiez@treble>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <90405c43-daca-48e4-b424-d66d6bf4dd87@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90405c43-daca-48e4-b424-d66d6bf4dd87@citrix.com>

On Thu, Apr 11, 2024 at 11:06:37AM +0100, Andrew Cooper wrote:
> > +#define __do_syscall(table, func_direct, nr, regs)			\
> > +({									\
> > +	unsigned long __rax, __rdi, __rsi;				\
> > +									\
> > +	asm_inline volatile(						\
> > +		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
> > +			    ANNOTATE_RETPOLINE_SAFE			\
> > +			    "call *%[func_ptr]\n\t",			\
> 
> This wants to be a plain maybe-thunk'd indirect call, and without the
> ANNOTATE_RETPOLINE_SAFE.
> 
> Or you're going to get into cases where some combinations of command
> line options do unexpected things e.g. retpolining everything except the
> syscall dispatch.

In that case won't X86_FEATURE_INDIRECT_SAFE get cleared, resulting in
the above using a direct call?  Or did I miss something?

-- 
Josh

