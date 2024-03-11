Return-Path: <linux-kernel+bounces-99647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F97878B67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813731C209FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82358AB2;
	Mon, 11 Mar 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="d0oheDZR"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC356B99
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198662; cv=none; b=rhR60fhHI4QVo9Ly3nSA5qK2xP7EiN6YoHf42XyaAosR/B5zXBV277k4y0jnk6vl21/Vp+3EfEH7SLixYIx+cuFXxcelE8WWM1DNBa0GLc6TUa3fJzruDw2ZOWXazVlrgl6XwTSHas6j+VIvYzotA4OF/7J0BcLndzfVR0DX84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198662; c=relaxed/simple;
	bh=m31uyX13+qw8Km7SHDq8vFu1cJ+s3/HJVlzsir+o2Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE5SK6v3ccOgourHSyjIMLlR8jx2FhYCPR2dBWqhyFhw6aTMBTdPQaQvTO3z3DL1c6RjYNFJrPjl5zW3Ov9tjzswOj3kEZrkwgBUtUP7/347CubF8X/pqHJm6ELF8AYxdOG9URkoup7V3zFgL6NjNGPmnRGN5XaAaB23jZVLD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=d0oheDZR; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42ef17b4021so21280661cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710198659; x=1710803459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z9HP99X7oLrFR1aslFElOrXkza3lJ4OyqDHRFASCoQ=;
        b=d0oheDZRIVnVP4cIz3nWa2hZ2HAVtB13WQzK4pAFiL7+23r4CRb2fSh/1+iNLgB3w2
         8eWQoldILDJn0OubUgvYBgICik5JnFQLzumaUOzt0pQYQNFtwkh710FZIsOhxLMQ706y
         sjYzGRdxu95eXv4JS5DpL8mkMYfQkO4yfL/Yemnt0CFhjMpQFUrNxfYD/3nbDHbwOvQJ
         KlY8IPt/DzMLSGV+zjAHF2FHtkyz7agIvnbRz5Xy44DJIGa4jwDbCBShI3ycpQdOvhrm
         9YyJJfBc76rg3HEeNcwntQABKW2OngXzjjOjWPgu9xyOXrSHS88NrhXnwKAWZNvwxKUx
         Q8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710198659; x=1710803459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z9HP99X7oLrFR1aslFElOrXkza3lJ4OyqDHRFASCoQ=;
        b=nH9TS441mRPg3LEQz2kbQLh16KYUFWVQ2Qq/aRyXd+jzC7hp2lUdoIgg7yVhEAwxHB
         /T4WPsdDyKNzlvzNIBmhlU5WuTEdPnCioagvMd+T/ukRji9z8ZiRTR3iCjvcML0KFcuF
         lkhLVIt+XkyTP09D1D5d9j2MQDcnZqRimiHFls35l9UTkwbKoDjmax4yKOpjirW44LEW
         5R47UkYYQ0DjxJ9HBiQxCzv2lBKoTzboknkupsYjpgIsLoZnEBMr2H4T1FkzZsSUuvWV
         qhQaZI2rBVryBLrT8LgwDqqCL8VuMqtWdWyXQCCYmoJZq2cYatKfsXvVLVUqzpFYj6b2
         iQUQ==
X-Gm-Message-State: AOJu0Yx+R+/JMqyprm4kfK1gHzYH2wX/ZdO+QyYyvmenKDynyHbpU53n
	y+mAtJbFZZ5mQKZnbhH0JpSIsUrC8o1sRXx3xv2OvBNntDBAZG2grnO3Gcy0fAq7djYml7iSvct
	IAhDVehPdOq2pg9ruXxWRFj1aLbX92Oc0J5LGuA==
X-Google-Smtp-Source: AGHT+IEJdnE50QXqM/K7jj7wicyKnrktqPjkZamGpF6ft1iHaPJKY8A5T1CSlm3xWVcth4HPqWnA3BQpx+QsfW7MXg4=
X-Received: by 2002:a05:622a:1709:b0:42f:1c28:8fcf with SMTP id
 h9-20020a05622a170900b0042f1c288fcfmr11702005qtk.40.1710198659483; Mon, 11
 Mar 2024 16:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com> <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
In-Reply-To: <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 11 Mar 2024 19:10:23 -0400
Message-ID: <CA+CK2bA22AP2jrbHjdN8nYFbYX2xJXQt+=4G3Rjw_Lyn5NOyKA@mail.gmail.com>
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
To: Andy Lutomirski <luto@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Christian Brauner <brauner@kernel.org>, bristot@redhat.com, 
	Ben Segall <bsegall@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, dianders@chromium.org, 
	dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com, 
	"hch@infradead.org" <hch@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, jpoimboe@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, juri.lelli@redhat.com, 
	Kent Overstreet <kent.overstreet@linux.dev>, kinseyho@google.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lstoakes@gmail.com, mgorman@suse.de, 
	mic@digikod.net, michael.christie@oracle.com, Ingo Molnar <mingo@redhat.com>, 
	mjguzik@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 6:17=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
>
>
> On Mon, Mar 11, 2024, at 9:46 AM, Pasha Tatashin wrote:
> > Add dynamic_stack_fault() calls to the kernel faults, and also declare
> > HAVE_ARCH_DYNAMIC_STACK =3D y, so that dynamic kernel stacks can be
> > enabled on x86 architecture.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/x86/Kconfig        | 1 +
> >  arch/x86/kernel/traps.c | 3 +++
> >  arch/x86/mm/fault.c     | 3 +++
> >  3 files changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 5edec175b9bf..9bb0da3110fa 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -197,6 +197,7 @@ config X86
> >       select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
> >       select HAVE_ARCH_USERFAULTFD_MINOR      if X86_64 && USERFAULTFD
> >       select HAVE_ARCH_VMAP_STACK             if X86_64
> > +     select HAVE_ARCH_DYNAMIC_STACK          if X86_64
> >       select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> >       select HAVE_ARCH_WITHIN_STACK_FRAMES
> >       select HAVE_ASM_MODVERSIONS
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index c3b2f863acf0..cc05401e729f 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -413,6 +413,9 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
> >       }
> >  #endif
> >
> > +     if (dynamic_stack_fault(current, address))
> > +             return;
> > +
>
> Sorry, but no, you can't necessarily do this.  I say this as the person w=
ho write this code, and I justified my code on the basis that we are not re=
covering -- we're jumping out to a different context, and we won't crash if=
 the origin context for the fault is corrupt.  The SDM is really quite unam=
biguous about it: we're in an "abort" context, and returning is not allowed=
  And I this may well be is the real deal -- the microcode does not promis=
e to have the return frame and the actual faulting context matched up here,=
 and there's is no architectural guarantee that returning will do the right=
 thing.
>
> Now we do have some history of getting a special exception, e.g. for espf=
ix64.  But espfix64 is a very special case, and the situation you're lookin=
g at is very general.  So unless Intel and AMD are both wiling to publicly =
document that it's okay to handle stack overflow, where any instruction in =
the ISA may have caused the overflow, like this, then we're not going to do=
 it.

Hi Andy,

Thank you for the insightful feedback.

I'm somewhat confused about why we end up in exc_double_fault() in the
first place. My initial assumption was that dynamic_stack_fault()
would only be needed within do_kern_addr_fault(). However, while
testing in QEMU, I found that when using memset() on a stack variable,
code like this:

rep stos %rax,%es:(%rdi)

causes a double fault instead of a regular fault. I added it to
exc_double_fault() as a result, but I'm curious if you have any
insights into why this behavior occurs.

> There are some other options: you could pre-map

Pre-mapping would be expensive. It would mean pre-mapping the dynamic
pages for every scheduled thread, and we'd still need to check the
access bit every time a thread leaves the CPU. Dynamic thread faults
should be considered rare events and thus shouldn't significantly
affect the performance of normal context switch operations. With 8K
stacks, we might encounter only 0.00001% of stacks requiring an extra
page, and even fewer needing 16K.

> Also, I think the whole memory allocation concept in this whole series is=
 a bit odd.  Fundamentally, we *can't* block on these stack faults -- we ma=
y be in a context where blocking will deadlock.  We may be in the page allo=
cator.  Panicing due to kernel stack allocation  would be very unpleasant.

We never block during handling stack faults. There's a per-CPU page
pool, guaranteeing availability for the faulting thread. The thread
simply takes pages from this per-CPU data structure and refills the
pool when leaving the CPU. The faulting routine is efficient,
requiring a fixed number of loads without any locks, stalling, or even
cmpxchg operations.

> But perhaps we could have a rule that a task can only be scheduled in if =
there is sufficient memory available for its stack.

Yes, I've considered this as well. We might implement this to avoid
crashes due to page faults. Basically, if the per-CPU pool cannot be
refilled, we'd prevent task scheduling until it is. We're already so
short on memory that the kernel can't allocate up to 3 pages of
memory.

Thank you,
Pasha

>  And perhaps we could avoid every page-faulting by filling in the PTEs fo=
r the potential stack pages but leaving them un-accessed.  I *think* that a=
ll x86 implementations won't fill the TLB for a non-accessed page without a=
lso setting the accessed bit, so the performance hit of filling the PTEs, r=
unning the task, and then doing the appropriate synchronization to clear th=
e PTEs and read the accessed bit on schedule-out to release the pages may n=
ot be too bad.  But you would need to do this cautiously in the scheduler, =
possibly in the *next* task but before the prev task is actually released e=
nough to be run on a different CPU.  It's going to be messy.

