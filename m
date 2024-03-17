Return-Path: <linux-kernel+bounces-105406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4587DD7C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F071F211CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B5E1BF50;
	Sun, 17 Mar 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPpW2uab"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0F652
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686603; cv=none; b=DYcDWuqgQXZQBFBVuwzeiF2QxBMsLYrgeAnBeuNEdKRMCkhz135h83E+oaxoRU12ITFPbBcagBjjNZjmkbxyzp+N8ryNH4/u30U0ao/Dxe8+nF34VDTH2wuOjpazCwkY5CLnUkzZVsgr+L2HmSwgDM5r9X28F0ChTzTBaqt01F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686603; c=relaxed/simple;
	bh=F5U5a4dmUdUcDm8+gZm4d1xNTN6lXnIX1wZHk1DN3IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcwyJ/2B3Pd2X9/Ig8oz1KyuAC3+GHbUnfqtItajmGjOL3bfZFi2q8laBjK77xUeqrg91yrfaAPNzujmfXmxugGbWnkOiiiPPhfpbGRiyuGRR+stuTXdm+aOFLAe8pjNwPG/KcEPbQiYp5ko97A2ZAvTpNukXpN16SNT5M6FTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPpW2uab; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d204e102a9so42491491fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710686599; x=1711291399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7i1qle43DJghAOAhcLatIUDn5bRRpZ4ZSCmPHdH/m8=;
        b=MPpW2uabwTQBkmFR5vHcSgHqPJAkQCmPWZGu8fGcMGle0PlofHQ4YUbrAQgAUPCRx0
         NO5NKgc5glIM7OxumCcG1X7XQkWt96lyeQvwtLsre3J3fS+/snoVL5vv4Q3pmapWLyum
         H914dFKeFxWXKl3ruPtIYrTOBf38Z6nNlCk/vvRDtfHl5aUerFZj9sCv9m78tmLYa2JA
         Yu00aCuqsbC/lZ7VvIcIvbB24MUmO7w2ZMrpvQVXZ2dm4xnorEdA85H5m/uoYv1xmw8L
         d5dwMqRbOxUO6Hf0RcyMIaTm1qsiC89VDxFgwC2ukNJiAFjK0UQTb+IzQUpdiwswjoqq
         hzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710686599; x=1711291399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7i1qle43DJghAOAhcLatIUDn5bRRpZ4ZSCmPHdH/m8=;
        b=a0Vw9O+xd52abEiGPYyTT233MCIPSaOTDtZFFneC2+rVuZGwmo7e1Mj46NEZz6ohI1
         UKkli9MIDRdRcpgAooru3Hm1h5BX0NqflER7pAmHgw0WRalNG9Nbey61aj02iVmr4OgZ
         oVu3AMSY87OUo5M4ObN1X7IIOn6yLr5DK0TR78BDi9H3SOqLV8YNXBQIC/PdCiGvL6p8
         U4l9HPpu4Eoz94/oqTR1H5PANiOTsr3zgTrjuejLCjykFIYGSbQJlodqw1rIc4jwj//w
         b03mtJcTFqceEjo5ofDEn2d4uAMA/ZQgpt1d+hv1oPAMQ43lxfLF/i4Ld9WeClystG+H
         ZnIw==
X-Forwarded-Encrypted: i=1; AJvYcCUQY/tp4xMsGs4E8SGmj6FToL2ooOZjIxqDyM9V6NjcANNXMd+qg3osHaMA5UnfXWmt/SnWn34usdKUD7GqwGjZX423B+YnI2Tpq6K0
X-Gm-Message-State: AOJu0Yyn3lFOI1A5x+saSJjIhfQg1R+nwjuVz5cIU9UCUKkGxdszCdJZ
	xLQ4ZERYuvvzjMdaIcN5CDkILohp7L2Gff+CbehpDanoQASPMNTFusH/7J+zG0SvMhf63SoSPlY
	OTXXMYB3I3BFi7ikEaCunX9A9AA==
X-Google-Smtp-Source: AGHT+IFxO/JV40qR4BlpOxNmW7xbooBba31uziSl8jssi9PWlhxCU7RWfHpA/lOHeNoVqgW3TYBVaZT4VgJSqMwE33g=
X-Received: by 2002:a2e:804a:0:b0:2d2:44df:b112 with SMTP id
 p10-20020a2e804a000000b002d244dfb112mr6072309ljg.41.1710686599112; Sun, 17
 Mar 2024 07:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com> <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
In-Reply-To: <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 17 Mar 2024 10:43:07 -0400
Message-ID: <CAMzpN2hZgEpJcyLqPhEqKSHy33j1G=FjzrOvnLPqiDeijanM=w@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, 
	brauner@kernel.org, bristot@redhat.com, bsegall@google.com, 
	dave.hansen@linux.intel.com, dianders@chromium.org, dietmar.eggemann@arm.com, 
	eric.devolder@oracle.com, hca@linux.ibm.com, hch@infradead.org, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kinseyho@google.com, 
	kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org, 
	mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com, 
	mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com, 
	peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com, 
	rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de, urezki@gmail.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 3:18=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Thu, Mar 14, 2024 at 11:40=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> w=
rote:
> >
> > On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha.tatashin@soleen=
com> wrote:
> > >On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >>
> > >> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
> > >> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote:
> > >> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin wrote:
> > >> > > > Second, non-dynamic kernel memory is one of the core design de=
cisions in
> > >> > > > Linux from early on. This means there are lot of deeply embedd=
ed assumptions
> > >> > > > which would have to be untangled.
> > >> > >
> > >> > > I think there are other ways of getting the benefit that Pasha i=
s seeking
> > >> > > without moving to dynamically allocated kernel memory.  One icky=
 thing
> > >> > > that XFS does is punt work over to a kernel thread in order to u=
se more
> > >> > > stack!  That breaks a number of things including lockdep (becaus=
e the
> > >> > > kernel thread doesn't own the lock, the thread waiting for the k=
ernel
> > >> > > thread owns the lock).
> > >> > >
> > >> > > If we had segmented stacks, XFS could say "I need at least 6kB o=
f stack",
> > >> > > and if less than that was available, we could allocate a tempora=
ry
> > >> > > stack and switch to it.  I suspect Google would also be able to =
use this
> > >> > > API for their rare cases when they need more than 8kB of kernel =
stack.
> > >> > > Who knows, we might all be able to use such a thing.
> > >> > >
> > >> > > I'd been thinking about this from the point of view of allocatin=
g more
> > >> > > stack elsewhere in kernel space, but combining what Pasha has do=
ne here
> > >> > > with this idea might lead to a hybrid approach that works better=
; allocate
> > >> > > 32kB of vmap space per kernel thread, put 12kB of memory at the =
top of it,
> > >> > > rely on people using this "I need more stack" API correctly, and=
 free the
> > >> > > excess pages on return to userspace.  No complicated "switch sta=
cks" API
> > >> > > needed, just an "ensure we have at least N bytes of stack remain=
ing" API.
> > >
> > >I like this approach! I think we could also consider having permanent
> > >big stacks for some kernel only threads like kvm-vcpu. A cooperative
> > >stack increase framework could work well and wouldn't negatively
> > >impact the performance of context switching. However, thorough
> > >analysis would be necessary to proactively identify potential stack
> > >overflow situations.
> > >
> > >> > Why would we need an "I need more stack" API? Pasha's approach see=
ms
> > >> > like everything we need for what you're talking about.
> > >>
> > >> Because double faults are hard, possibly impossible, and the FRED ap=
proach
> > >> Peter described has extra overhead?  This was all described up-threa=
d.
> > >
> > >Handling faults in #DF is possible. It requires code inspection to
> > >handle race conditions such as what was shown by tglx. However, as
> > >Andy pointed out, this is not supported by SDM as it is an abort
> > >context (yet we return from it because of ESPFIX64, so return is
> > >possible).
> > >
> > >My question, however, if we ignore memory savings and only consider
> > >reliability aspect of this feature.  What is better unconditionally
> > >crashing the machine because a guard page was reached, or printing a
> > >huge warning with a backtracing information about the offending stack,
> > >handling the fault, and survive? I know that historically Linus
> > >preferred WARN() to BUG() [1]. But, this is a somewhat different
> > >scenario compared to simple BUG vs WARN.
> > >
> > >Pasha
> > >
> > >[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.1714-10000=
0@home.transmeta.com
> > >
> >
> > The real issue with using #DF is that if the event that caused it was a=
synchronous, you could lose the event.
>
> Got it. So, using a #DF handler for stack page faults isn't feasible.
> I suppose the only way for this to work would be to use a dedicated
> Interrupt Stack Table (IST) entry for page faults (#PF), but I suspect
> that might introduce other complications.
>
> Expanding on Mathew's idea of an interface for dynamic kernel stack
> sizes, here's what I'm thinking:
>
> - Kernel Threads: Create all kernel threads with a fully populated
> THREAD_SIZE stack.  (i.e. 16K)
> - User Threads: Create all user threads with THREAD_SIZE kernel stack
> but only the top page mapped. (i.e. 4K)
> - In enter_from_user_mode(): Expand the thread stack to 16K by mapping
> three additional pages from the per-CPU stack cache. This function is
> called early in kernel entry points.
> - exit_to_user_mode(): Unmap the extra three pages and return them to
> the per-CPU cache. This function is called late in the kernel exit
> path.
>
> Both of the above hooks are called with IRQ disabled on all kernel
> entries whether through interrupts and syscalls, and they are called
> early/late enough that 4K is enough to handle the rest of entry/exit.

This proposal will not have the memory savings that you are looking
for, since sleeping tasks would still have a fully allocated stack.
This also would add extra overhead to each entry and exit (including
syscalls) that can happen multiple times before a context switch.  It
also doesn't make much sense because a task running in user mode will
quickly need those stack pages back when it returns to kernel mode.
Even if it doesn't make a syscall, the timer interrupt will kick it
out of user mode.

What should happen is that the unused stack is reclaimed when a task
goes to sleep.  The kernel does not use a red zone, so any stack pages
below the saved stack pointer of a sleeping task (task->thread.sp) can
be safely discarded.  Before context switching to a task, fully
populate its task stack.  After context switching from a task, reclaim
its unused stack.  This way, the task stack in use is always fully
allocated and we don't have to deal with page faults.

To make this happen, __switch_to() would have to be split into two
parts, to cleanly separate what happens before and after the stack
switch.  The first part saves processor context for the previous task,
and prepares the next task.  Populating the next task's stack would
happen here.  Then it would return to the assembly code to do the
stack switch.  The second part then loads the context of the next
task, and finalizes any work for the previous task.  Reclaiming the
unused stack pages of the previous task would happen here.


Brian Gerst

