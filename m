Return-Path: <linux-kernel+bounces-104627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4887D137
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A37E2834C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F04424215;
	Fri, 15 Mar 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4jo0++bu"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6531A38CB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520404; cv=none; b=bJ0HFdWFbqeyN0Z2uO0dcuPCxb4Z6/bCIyWK0+DSxoPmUJBbg435g3Z03FTioDvY2NImk/Z90PwbshwYP3G4U8BFOHu0+Q84lZVrA9CDlnazveosT6fPjEagygCpDMfOtkR6BlEnfWmnORAnFGRo6/hyx+id9ABZU1R4buBbgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520404; c=relaxed/simple;
	bh=LO0Zr/GLl4s39PFXiCRUnzvMdT04tRnGWvO+kTGhuyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sfl6hH4JZibFvbjHGG/mkPt4d5E2Whz+gFSUQ4emzbX8aSpEJ9wnq+QPMuDSg8SShHuLWPAJj1cHxBI1euI1q3gpY7RMgnfgZxt9JQX0c7DAV8ENercFfI1jRcHUoAO0SlyvqwM9TczT4TqnCgZgBcAHKvqDP5VsYGFJfKgJrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4jo0++bu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29ad35a8650so2636934a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710520402; x=1711125202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0vd6XzAeV5v4ivDd04XpMwJ9YpCKTgd+ISRLmLX3pQ=;
        b=4jo0++buJOArLkC7PFDFrPct0wLN5xYabYZMqg0AEVF+SqqACHxc+7jV55GuvLRfVF
         iKtTgg7SRX3n+GpX/ga1/pMMaK2GjCQt3s9kFr+4gOIf1nsBNEIa7iri97RxyNRckK3s
         8nDO+0vLZKgrr117DB/qQSVQbtF5mPhPLMBn+UtIszArMrIw2np+JvlmZjml75cjsaut
         kYvcon20osIbODVrpBLaw8gwZy8ds8ApR+uNM1dJPYQPPN2CiV3Oe/FxIzkyCfd8o6qE
         30ww+LeW2B+cTWk3TsfbVXZKxATV2357BfdOPRD1O2YnVlaAAXpA74bKycj9rRECEpnj
         QrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520402; x=1711125202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0vd6XzAeV5v4ivDd04XpMwJ9YpCKTgd+ISRLmLX3pQ=;
        b=WMsMgGP8ZFfu+yUiwUt78t5FmfwvD4MmiIzQ1RBwAheFH7erL0BdYZtPEK45xkNdDJ
         XuKB+ikr8pFBbxpnYwKso6wFFPnagzvR8Dx87ROQFGPGzzQXXnsfRyWFkN8gcdieM4YF
         5L6oIMF+z+C68PzWW0GWabUlKuoPNI2HDAlzWf8btTvWR8paswmt/5iekxwjfHNfWjlc
         fxZYzwaRtbXCreelEctZI2y5PgZ4CzE5O8ddUEhXanAPkeUzDLOD2D9vgNg036EOL4Eh
         qvX6PtJG5/j6qdbpXa3nr72mLZFBqKFO3EmqxW3Ea5+7koG2kZqMuGB44gAk7A2Y2mOW
         fbDw==
X-Forwarded-Encrypted: i=1; AJvYcCU3octsTi72z4Q2LcPp0PLgunK3EUsp+QtpVOgX+oGeA8rfHypS9VI+C2Co7TYjSZ64IxwUAt1UYK9ApvP8UM3sMZ++CiAQ/6nFghaO
X-Gm-Message-State: AOJu0YysHdq7PXMk3NHztLODfpm4asR6kMVZKujgLYO3MsiV+Zfi58Sc
	Uno/c9PP7Fw/S8919kUnZZaL0RggriKS1fkzdgoyHOYO+oPbLqkBSg9C0ZYJX6aJV8OwUwcwyk4
	uvg==
X-Google-Smtp-Source: AGHT+IGdiMDlL2VIqKf17p/pmhHD0iaaQbLWNXlaCGwPbixCtEt0kY7FcuoU0JAcuYNR9a2A1AhG3MZLeEI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:be02:b0:29d:dd40:cd92 with SMTP id
 a2-20020a17090abe0200b0029ddd40cd92mr14155pjs.0.1710520401991; Fri, 15 Mar
 2024 09:33:21 -0700 (PDT)
Date: Fri, 15 Mar 2024 09:33:20 -0700
In-Reply-To: <54ae3bbb-34dc-4b10-a14e-2af9e9240ef1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <8f64043a6c393c017347bf8954d92b84b58603ec.1708933498.git.isaku.yamahata@intel.com>
 <e6e8f585-b718-4f53-88f6-89832a1e4b9f@intel.com> <bd21a37560d4d0695425245658a68fcc2a43f0c0.camel@intel.com>
 <54ae3bbb-34dc-4b10-a14e-2af9e9240ef1@intel.com>
Message-ID: <ZfR4UHsW_Y1xWFF-@google.com>
Subject: Re: [PATCH v19 007/130] x86/virt/tdx: Export SEAMCALL functions
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Tina Zhang <tina.zhang@intel.com>, Hang Yuan <hang.yuan@intel.com>, Bo2 Chen <chen.bo@intel.com>, 
	"sagis@google.com" <sagis@google.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	Erdem Aktas <erdemaktas@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 14, 2024, Dave Hansen wrote:
> On 3/14/24 18:17, Edgecombe, Rick P wrote:
> > I guess there are three options:
> > 1. Export the low level seamcall function
> > 2. Export a bunch of higher level helper functions
> > 3. Duplicate __seamcall asm in KVM
> > 
> > Letting modules make unrestricted seamcalls is not ideal. Preventing
> > the compiler from inlining the small logic in the static inline helpers
> > is not ideal. Duplicating code is not ideal. Hmm.
> > 
> > I want to say 2 sounds the least worst of the three. But I'm not sure.
> > I'm not sure if x86 folks would like to police new seamcalls, or be
> > bothered by it, either.
> 
> #3 is the only objectively awful one. :)
> 
> In the end, we actually _want_ to have conversations about these things.
>  There are going to be considerations about what functionality should be
> in KVM or the core kernel.  We don't want KVM doing any calls that could
> affect global TDX module state, for instance.

Heh, Like this one?

        static inline u64 tdh_sys_lp_shutdown(void)
        {
        	struct tdx_module_args in = {
        	};
        
        	return tdx_seamcall(TDH_SYS_LP_SHUTDOWN, &in, NULL);
        }

Which isn't actually used...

> But I'd also defer to the KVM maintainers on this.  They're the ones
> that have to play the symbol exporting game a lot more than I ever do.
> If they cringe at the idea of adding 20 (or whatever) exports, then
> that's a lot more important than the possibility of some other silly
> module abusing the generic exported __seamcall.

I don't care much about exports.  What I do care about is sane code, and while
the current code _looks_ pretty, it's actually quite insane.

I get why y'all put SEAMCALL in assembly subroutines; the macro shenanigans I
originally wrote years ago were their own brand of crazy, and dealing with GPRs
that can't be asm() constraints often results in brittle code.

But the tdx_module_args structure approach generates truly atrocious code.  Yes,
SEAMCALL is inherently slow, but that doesn't mean that we shouldn't at least try
to generate efficient code.  And it's not just efficiency that is lost, the
generated code ends up being much harder to read than it ought to be.

E.g. the seemingly simple

        static inline u64 tdh_mem_page_remove(hpa_t tdr, gpa_t gpa, int level,
        				      struct tdx_module_args *out)
        {
        	struct tdx_module_args in = {
        		.rcx = gpa | level,
        		.rdx = tdr,
        	};

        	return tdx_seamcall_sept(TDH_MEM_PAGE_REMOVE, &in, out);
        }

generates the below monstrosity with gcc-13.  And that's just one SEAMCALL wrapper,
*every* single one generates the same mess.  clang-16 is kinda sorta a little
better, as it at least inlines the helpers that have single callers.

So my feedback is to not worry about the exports, and instead focus on figuring
out a way to make the generated code less bloated and easier to read/debug.

Dump of assembler code for function tdh_mem_page_remove:
   0x0000000000032b20 <+0>:	push   %r15
   0x0000000000032b22 <+2>:	xor    %eax,%eax
   0x0000000000032b24 <+4>:	movabs $0x8000ff0000000006,%r15
   0x0000000000032b2e <+14>:	push   %r14
   0x0000000000032b30 <+16>:	mov    %rcx,%r14
   0x0000000000032b33 <+19>:	mov    $0xb,%ecx
   0x0000000000032b38 <+24>:	push   %r13
   0x0000000000032b3a <+26>:	movslq %edx,%r13
   0x0000000000032b3d <+29>:	push   %r12
   0x0000000000032b3f <+31>:	or     %rsi,%r13
   0x0000000000032b42 <+34>:	mov    $0x11,%r12d
   0x0000000000032b48 <+40>:	push   %rbp
   0x0000000000032b49 <+41>:	movabs $0x8000020300000000,%rbp
   0x0000000000032b53 <+51>:	push   %rbx
   0x0000000000032b54 <+52>:	sub    $0x70,%rsp
   0x0000000000032b58 <+56>:	mov    %rdi,(%rsp)
   0x0000000000032b5c <+60>:	lea    0x18(%rsp),%rdi
   0x0000000000032b61 <+65>:	rep stos %rax,%es:(%rdi)
   0x0000000000032b64 <+68>:	mov    (%rsp),%rax
   0x0000000000032b68 <+72>:	mov    %r13,(%r14)
   0x0000000000032b6b <+75>:	mov    $0xa,%ebx
   0x0000000000032b70 <+80>:	mov    %rax,0x8(%r14)
   0x0000000000032b74 <+84>:	mov    0x18(%rsp),%rax
   0x0000000000032b79 <+89>:	mov    %rax,0x10(%r14)
   0x0000000000032b7d <+93>:	mov    0x20(%rsp),%rax
   0x0000000000032b82 <+98>:	mov    %rax,0x18(%r14)
   0x0000000000032b86 <+102>:	mov    0x28(%rsp),%rax
   0x0000000000032b8b <+107>:	mov    %rax,0x20(%r14)
   0x0000000000032b8f <+111>:	mov    0x30(%rsp),%rax
   0x0000000000032b94 <+116>:	mov    %rax,0x28(%r14)
   0x0000000000032b98 <+120>:	mov    0x38(%rsp),%rax
   0x0000000000032b9d <+125>:	mov    %rax,0x30(%r14)
   0x0000000000032ba1 <+129>:	mov    0x40(%rsp),%rax
   0x0000000000032ba6 <+134>:	mov    %rax,0x38(%r14)
   0x0000000000032baa <+138>:	mov    0x48(%rsp),%rax
   0x0000000000032baf <+143>:	mov    %rax,0x40(%r14)
   0x0000000000032bb3 <+147>:	mov    0x50(%rsp),%rax
   0x0000000000032bb8 <+152>:	mov    %rax,0x48(%r14)
   0x0000000000032bbc <+156>:	mov    0x58(%rsp),%rax
   0x0000000000032bc1 <+161>:	mov    %rax,0x50(%r14)
   0x0000000000032bc5 <+165>:	mov    0x60(%rsp),%rax
   0x0000000000032bca <+170>:	mov    %rax,0x58(%r14)
   0x0000000000032bce <+174>:	mov    0x68(%rsp),%rax
   0x0000000000032bd3 <+179>:	mov    %rax,0x60(%r14)
   0x0000000000032bd7 <+183>:	mov    %r14,%rsi
   0x0000000000032bda <+186>:	mov    $0x1d,%edi
   0x0000000000032bdf <+191>:	call   0x32be4 <tdh_mem_page_remove+196>
   0x0000000000032be4 <+196>:	cmp    %rbp,%rax
   0x0000000000032be7 <+199>:	jne    0x32bfd <tdh_mem_page_remove+221>
   0x0000000000032be9 <+201>:	sub    $0x1,%ebx
   0x0000000000032bec <+204>:	jne    0x32bd7 <tdh_mem_page_remove+183>
   0x0000000000032bee <+206>:	add    $0x70,%rsp
   0x0000000000032bf2 <+210>:	pop    %rbx
   0x0000000000032bf3 <+211>:	pop    %rbp
   0x0000000000032bf4 <+212>:	pop    %r12
   0x0000000000032bf6 <+214>:	pop    %r13
   0x0000000000032bf8 <+216>:	pop    %r14
   0x0000000000032bfa <+218>:	pop    %r15
   0x0000000000032bfc <+220>:	ret
   0x0000000000032bfd <+221>:	cmp    %r15,%rax
   0x0000000000032c00 <+224>:	je     0x32c2a <tdh_mem_page_remove+266>
   0x0000000000032c02 <+226>:	movabs $0x8000020000000092,%rdx
   0x0000000000032c0c <+236>:	cmp    %rdx,%rax
   0x0000000000032c0f <+239>:	jne    0x32bee <tdh_mem_page_remove+206>
   0x0000000000032c11 <+241>:	sub    $0x1,%r12d
   0x0000000000032c15 <+245>:	jne    0x32b64 <tdh_mem_page_remove+68>
   0x0000000000032c1b <+251>:	add    $0x70,%rsp
   0x0000000000032c1f <+255>:	pop    %rbx
   0x0000000000032c20 <+256>:	pop    %rbp
   0x0000000000032c21 <+257>:	pop    %r12
   0x0000000000032c23 <+259>:	pop    %r13
   0x0000000000032c25 <+261>:	pop    %r14
   0x0000000000032c27 <+263>:	pop    %r15
   0x0000000000032c29 <+265>:	ret
   0x0000000000032c2a <+266>:	call   0x32c2f <tdh_mem_page_remove+271>
   0x0000000000032c2f <+271>:	xor    %eax,%eax
   0x0000000000032c31 <+273>:	add    $0x70,%rsp
   0x0000000000032c35 <+277>:	pop    %rbx
   0x0000000000032c36 <+278>:	pop    %rbp
   0x0000000000032c37 <+279>:	pop    %r12
   0x0000000000032c39 <+281>:	pop    %r13
   0x0000000000032c3b <+283>:	pop    %r14
   0x0000000000032c3d <+285>:	pop    %r15
   0x0000000000032c3f <+287>:	ret
End of assembler dump.

