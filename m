Return-Path: <linux-kernel+bounces-141881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901EE8A249F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEAF285FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403418E1C;
	Fri, 12 Apr 2024 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQKYw04F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D58182DF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894263; cv=none; b=jRPRlrjtDoQeUeq+zwEZD4bADOG3oLs11O/7KJ9X1asx9Bsi21ZZPlxdIyHtF7IlZvaDp2NMaTaogSqRBcckUWxKGFGzgqZPzcCjEPyKGxCx/IwYmMvtB5bvVcfGbhliXaYcKb5y9gPaaCAG99yFHhCBFeiE7Nl9GD3hiQwndbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894263; c=relaxed/simple;
	bh=HftxzaE9Ivv2zYcfAmECwLVSWn99hniqvpXpDRHcfyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRA0bKHr8dWG75R5rJK5aOfXAlIzcX+G1siVQ6hC4OJmptlCVVhPFVhSczbgIV2XIeCIC0LQat61EcUP+fPtD46fQxPTM0cq/hDQidr7+OA1R1VQAsvzCsqOYjWfLhy3EnZa1rO6lV904RozP4Ae4KrU7Xo9n1lvrmICGIwz7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQKYw04F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F957C2BBFC;
	Fri, 12 Apr 2024 03:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712894262;
	bh=HftxzaE9Ivv2zYcfAmECwLVSWn99hniqvpXpDRHcfyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQKYw04FIDJn7vaJT/4CGOiS4NFm+PjZEsSSagn+dwJktckx/sY9pK59P8XRSf2xd
	 DLdTJslYnUwZprjZ0Q8flkUoKeuZ5TK+GuQA7uTKia056LTumKAwr1JBkM51yDPg8S
	 Igso7FWQu3YVtI2rjFtMd/chSNO12cghWoCNYZBA7l57ji9rtuK+Imbos+0KXvWjMd
	 Oi26COcxdVd9IxwO8tZUx7j6I1GCdc/VVHQgP0PkfFCWNACFi9OgzoFh2Ct9+D/crF
	 2TqK0qdbGhHRFPJXzqyet/YXtxRMfmg6TOm2Ft7/49nY71gPcZCtUgVsx3ATmbxvKp
	 WHccfWaufeXAQ==
Date: Thu, 11 Apr 2024 20:57:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Message-ID: <20240412035740.ojgvlqahqlm2umsx@treble>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <20240412001522.3zp2mzked4ksglkl@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412001522.3zp2mzked4ksglkl@desk>

On Thu, Apr 11, 2024 at 05:15:22PM -0700, Pawan Gupta wrote:
> > + * Do either a direct or an indirect call, depending on whether indirect calls
> > + * are considered safe.
> > + */
> > +#define __do_syscall(table, func_direct, nr, regs)			\
> > +({									\
> > +	unsigned long __rax, __rdi, __rsi;				\
> > +									\
> > +	asm_inline volatile(						\
> > +		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
> > +			    ANNOTATE_RETPOLINE_SAFE			\
> > +			    "call *%[func_ptr]\n\t",			\
> 
> This will likely not insert the lfence before the indirect call in
> spectre_v2=eibrs,lfence mode. As X86_FEATURE_INDIRECT_SAFE is not
> cleared when eIBRS is enabled, this will not be converted to direct
> call.

Hm, I think the problem here is that SPECTRE_V2_EIBRS_LFENCE confusingly
sets X86_FEATURE_RETPOLINE.  So the following bit unintentionally takes
effect:

	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
		spec_ctrl_disable_kernel_rrsba();
		if (rrsba_disabled)
			return;
	}

If RRSBA gets disabled (which is likely), bhi_select_mitigation()
returns early and X86_FEATURE_INDIRECT_SAFE doesn't get cleared.

"LFENCE; CALL" is most definitely not a retpoline, so it's weird for
SPECTRE_V2_EIBRS_LFENCE to be setting X86_FEATURE_RETPOLINE.  We should
fix that.

Honestly, I think SPECTRE_V2_EIBRS_LFENCE is obsolete anyway.  It was
originally intended to be a BHI mitigation, but the real-world
benchmarks I've seen are showing it to be quite a bit slower than the
actual BHI mitigations.

Plus it's only a partial fix because the speculative window after the
branch can still be big enough to do multiple loads.

For similar reasons I'm thinking we should also remove the non-eIBRS
version (SPECTRE_V2_LFENCE).

I'll make some patches to do that, with warnings printed if somebody
tries to use them.  They can just fall back to the (more secure and
generally faster) defaults.

> [...]
> > @@ -1720,6 +1744,7 @@ static void __init spectre_v2_select_mitigation(void)
> >  
> >  	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
> >  		pr_err(SPECTRE_V2_LFENCE_MSG);
> > +		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> 
> I don't know if it intentional, this seems to be the duplicate of
> X86_FEATURE_INDIRECT_SAFE clear later in SPECTRE_V2_LFENCE mode. Also it
> seems a bit odd to do this here in SPECTRE_V2_CMD handling.

Yeah, I accidentally left that in from an earlier implementation.  It's
harmless but I'll clean that up too with a new patch unless Ingo wants
to remove that line.

-- 
Josh

