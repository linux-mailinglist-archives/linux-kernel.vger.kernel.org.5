Return-Path: <linux-kernel+bounces-101677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2687AA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226E01C224E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F546535;
	Wed, 13 Mar 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="jGk8dCmO"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F2290A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343746; cv=none; b=Yb+Xcu1zWE03S+w5hr0fMOByGAmjRYTJ1nRKMrCXH6sodDzi/RuGz4hCWa27dDf8fpDV2e2LfMn3pVDs356Ylt8yLMPJ5S7gyXQiF0+o5tvnDsP0aEJt/sDycO/opfD1+7nbKwmHod/ZwRCNUG3+WEd/F3iIXP1jcuP5d5ryotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343746; c=relaxed/simple;
	bh=Dl+3f2HdEzwpKJlWUdV3VN7IJUCKtzspUN8ZJt8CP2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2Mjj2FQFT3J6OAzLhMsTL3mMNx7V51/NkiucRq1Nv4ed0lecu9V6CA1uyQXbqGgQzZlL7WgV0BRD9XN/d97bZYj91n+HSkI9XFGKEIEWat83WjaIXfcBN2pPvC/8f/I76MaBctGHr9i9+G7GVPogjGwFJB2NxzExXC3DfryGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=jGk8dCmO; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43095d80832so1912611cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710343743; x=1710948543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWKlYumLkX/+t+ibDwbAcEteYC479oCXqcOK3/Ft1Sg=;
        b=jGk8dCmORenBTsl0nLMJvlVgG/699gHBPqzO3Ju6kxSqFKtuqNsVz4R8U0Uwx1w1uk
         CVj1Xd5rKtymuWJQMYpHTBduNsxuWSA8VbMTbBG7Zr5tJV8dMRm+eqwS5agQ23qLXaUu
         INnBk6Jlg6G91/5GfDGVebpottBtDGulyxokOj1TIXoq/PlZJEKC2xCptTtpu4M0QSKI
         XFxdBYPPE9Fng/PmHVZC7Df7EUbhymVGiP8hG1Il1qVb1EbTWiw+VVqXWcmwYidBZRGh
         WIbL5SWTOnaEzWkuP8jaCePAU6ZhSNLZSeZxDk8zkwItuN6rqlrdfD+2f3dkcgbVhM8a
         +9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710343743; x=1710948543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWKlYumLkX/+t+ibDwbAcEteYC479oCXqcOK3/Ft1Sg=;
        b=u/bo2oQBtvj1ouUJOwbO5rYqzb+8qmbi0N2IvcxjKVzsp2UBgKGU05mKzAvYWZ2kqH
         wIjrmFHSy0pMa7rWUPjxdhuwN/Lgt9D8aG75pAmvTHCcBwBP9T18hiBikGp2WDJHzPry
         4mXDUmNN9X5tlWKgYwXPBsaJ8y5DsXgYU3+C/+ceRqBEis5fTjxY99ecLRF3DdfbAHZW
         dwIRmDMv0h+uBZMwnUa3ssyBEs4O4M3KnWfHOtwAmVAuidQ2XdoiUNOKoOa+dMR/Xt7w
         sBBdJbwJAQ4/WEbsj/TBCxGnuFkddhHSkmGt0GEhlTnEveNmsGdysdoxUi5ymei4R/BK
         ErYA==
X-Gm-Message-State: AOJu0YzA4IyevmPIox/fmXx8fDYyiG3otnJuHpzLzgIT8llAdCs108yf
	zoqJWs+pDHKlAwGPfaERQ8V/pieZT9FOIG211YiqrSq1dkx5n+4lMYxUDUV141G0uacdGwuTQ01
	WJS77jb9wy2ZHshdp5w0Ia8iV3Na7UVsOdVDMZQ==
X-Google-Smtp-Source: AGHT+IEFWsngRc36KlsisR2qyCNd3E/wD9YsSrdlX25LgRM0Ku6xw1Arb90QhWmAXGGmH9s8YBlIqxzNWtDBwy1ApS0=
X-Received: by 2002:a05:622a:1909:b0:42f:200b:8d0a with SMTP id
 w9-20020a05622a190900b0042f200b8d0amr4149422qtc.43.1710343743210; Wed, 13 Mar
 2024 08:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com> <87v85qo2fj.ffs@tglx> <CA+CK2bBgeK=rW3=RJSx8zxST8xnJ-VXSSYmKPVK9gHX3pxEWuQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBgeK=rW3=RJSx8zxST8xnJ-VXSSYmKPVK9gHX3pxEWuQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Mar 2024 11:28:26 -0400
Message-ID: <CA+CK2bAzJuCe06g_TEOh3B-hK+dXfUaGaOSTgzyxkN4zqpSU_A@mail.gmail.com>
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:43=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Mar 13, 2024 at 6:23=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> > On Mon, Mar 11 2024 at 16:46, Pasha Tatashin wrote:
> > > @@ -413,6 +413,9 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
> > >       }
> > >  #endif
> > >
> > > +     if (dynamic_stack_fault(current, address))
> > > +             return;
> > > +
> > >       irqentry_nmi_enter(regs);
> > >       instrumentation_begin();
> > >       notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEG=
V);
> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > index d6375b3c633b..651c558b10eb 100644
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -1198,6 +1198,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsign=
ed long hw_error_code,
> > >       if (is_f00f_bug(regs, hw_error_code, address))
> > >               return;
> > >
> > > +     if (dynamic_stack_fault(current, address))
> > > +             return;
> >
> > T1 schedules out with stack used close to the fault boundary.
> >
> >    switch_to(T2)
> >
> > Now T1 schedules back in
> >
> >    switch_to(T1)
> >      __switch_to_asm()
> >         ...
> >         switch_stacks()         <- SP on T1 stack
> > !        ...
> > !       jmp __switch_to()
> > !    __switch_to()
> > !       ...
> > !       raw_cpu_write(pcpu_hot.current_task, next_p);
> >
> > After switching SP to T1's stack and up to the point where
> > pcpu_hot.current_task (aka current) is updated to T1 a stack fault will
> > invoke dynamic_stack_fault(T2, address) which will return false here:
> >
> >         /* check if address is inside the kernel stack area */
> >         stack =3D (unsigned long)tsk->stack;
> >         if (address < stack || address >=3D stack + THREAD_SIZE)
> >                 return false;
> >
> > because T2's stack does obviously not cover the faulting address on T1'=
s
> > stack. As a consequence double fault will panic the machine.
>
> Hi Thomas,
>
> Thank you, you are absolutely right, we can't trust "current" in the
> fault handler.
>
> We can change dynamic_stack_fault() to only accept fault_address as an
> argument, and let it determine the right task_struct pointer
> internally.
>
> Let's modify dynamic_stack_fault() to accept only the fault_address.
> It can then determine the correct task_struct pointer internally.
>
> Here's a potential solution that is fast, avoids locking, and ensures ato=
micity:
>
> 1. Kernel Stack VA Space
> Dedicate a virtual address range ([KSTACK_START_VA - KSTACK_END_VA])
> exclusively for kernel stacks. This simplifies validation of faulting
> addresses to be part of a stack.
>
> 2. Finding the faulty task
> - Use ALIGN(fault_address, THREAD_SIZE) to calculate the end of the
> topmost stack page (since stack addresses are aligned to THREAD_SIZE).
> - Store the task_struct pointer as the last word on this topmost page,
> that is always present as it is a pre-allcated stack page.
>
> 3. Stack Padding
> Increase padding to 8 bytes on x86_64 (TOP_OF_KERNEL_STACK_PADDING 8)
> to accommodate the task_struct pointer.

Alternatively, do not even look-up the task_struct in
dynamic_stack_fault(), but only install the mapping to the faulting
address, store va in the per-cpu array, and handle the rest in
dynamic_stack() during context switching. At that time spin locks can
be taken, and we can do a find_vm_area(addr) call.

This way, we would not need to modify TOP_OF_KERNEL_STACK_PADDING to
keep task_struct in there.

Pasha

