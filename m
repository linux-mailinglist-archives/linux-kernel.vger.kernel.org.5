Return-Path: <linux-kernel+bounces-106256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100FA87EB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82392823C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC34EB43;
	Mon, 18 Mar 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="02mzyNVH"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019E433D2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774023; cv=none; b=EZNryB0/X7ONlfVhSQiVYOtX59QFHLg1BN0uL4n1Cha9FBjLbSVtZ8LtRkuhLyDWtMJpp+o79UG5fW0OwzzNh38YpWPR8tm3NEyb2LMsJTL6lCgiiztjU99/c0+N49lbz0/uqWzjzKVV/SrSZKkdNJrEJVBN4M6U5ytynTwBDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774023; c=relaxed/simple;
	bh=/5wOHq8D729bR1w0gQ3INy3HnqgULliS/kSdP4VUmY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5ZZ+kq+5Xhu3zegXVdpoOvdJ6qk97MBYGt44c7JVa7a7lb5ZNsf8VGGm6peaUtcHTo5iZpddswC4hkAZpKD2qxdcYPj89PWKuLLESkTtBxUMHIpbhzpculPT+KIBoZ+c/3rFYRaWmVmlHOf1I0SpgnXgvXUthQC9WljCsJC4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=02mzyNVH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430ad286ab8so18358181cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710774020; x=1711378820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+shnp82RbLRqc2AkjpVqF0AOwVt5CxDjgyssKZw0cc=;
        b=02mzyNVHZfynLgIqGrPZmWiG0vmrrj/n1bx+PlU5Ev51xcaF+IE+AfogZmLQlox/49
         DvxN5EG9mS17XW4ZtbgZKc3kI3L8/cTMVO5g6QDEHhz/2KduRQ41ChNov0E870HrngQO
         vW9uIlu40xMTeQH7SLT65Z/m20I55mwtX8zz7Vsvp9Kl6Aqq3Xf8VJxLlS+QFaU5DyaP
         lbYdfY2W6oa1Hw6bGR2D1u2subEZzH2jNnxbgYmFaCWioXq14sURT/oIP8fUSwRV9b4N
         mqQN+erqxeiSRxg+L2fFPYbhBz/cjXcEmj6iJH/fs7BnbYh1TK8EvrAE0faXzfgiZDyX
         5rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710774020; x=1711378820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+shnp82RbLRqc2AkjpVqF0AOwVt5CxDjgyssKZw0cc=;
        b=Q/4jjPwthCnzChJTos5guw36Q90tTAeieUE0GSaXTkDYz0T6Se1k0qkqEdliqLW3CH
         tocpizdbyo4WSaKBTLtkHGXsFhWI44mU9hwG6giisWsEDp06Fe7Hb+KJ756C9Bfd2A/Q
         wcdsdiH8PIFZa3pcOrbt3meiwLqHVFl8ixzYL9xIBlwyhe/cm1locYZ+E9esLy+L6jco
         +b21r1oP9H8Pa+UZOhzecOqaLCrffHoEyxMCcCzSg3z4fGiKAspT772l5SX06PQZvyUj
         o63J0xL7dLQ0M7ImwsQJRuhuOYIgD55mlNQPobq5ps/jUZQVB8g9OJL6w80Xl2dJet9I
         Ohew==
X-Forwarded-Encrypted: i=1; AJvYcCVkRvaCDy7QIWgvK/5u4G6l+iI1a3TlYPaLdU9DcJ354MgdohFt1nMnWwMKA5yof71Jr8wzlYzrQUm1fFeJdPuS13OQ/HvN4Q/1jl43
X-Gm-Message-State: AOJu0YyIhc9E9+qzWoCeN/Vi6rDsKx44zlZcFTr+3BZ/aQ7DLDOxJWaZ
	PKqjB/Ry0sYkZ90DeXBrLuDYtKYf7EOf4PezQ7YBw3Ihnxpdqj7K3jqxtQxVzJVIjz9iNtnGUD0
	M6FlMzYkvtLGxrvoHLZeuiHOSZe+Xvz7CKGxZKg==
X-Google-Smtp-Source: AGHT+IFMCVN3DyNjvpkBYstWXw8M6j9fwRsZ5+JfPArocJEh9Sx3W1W6nY/urkXbdB3jioudY31zNEkrOjzjsq9fjEg=
X-Received: by 2002:ac8:584c:0:b0:42e:ed2b:95ff with SMTP id
 h12-20020ac8584c000000b0042eed2b95ffmr18892142qth.1.1710774020038; Mon, 18
 Mar 2024 08:00:20 -0700 (PDT)
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
 <CAMzpN2hZgEpJcyLqPhEqKSHy33j1G=FjzrOvnLPqiDeijanM=w@mail.gmail.com>
 <CA+CK2bBTrrJerZMdJrKhg683H4VmnqbgkGu2VG2UuirWNm1TnA@mail.gmail.com> <CAMzpN2jmQoG9Cw56JOh7t_Y21Fax3bA9iAEA2B7TLnYs5ycdJQ@mail.gmail.com>
In-Reply-To: <CAMzpN2jmQoG9Cw56JOh7t_Y21Fax3bA9iAEA2B7TLnYs5ycdJQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Mar 2024 10:59:43 -0400
Message-ID: <CA+CK2bDO=LV8nEFn=q6w3Pyna3aqKAiFEzHMb-d7xzMOThOXSQ@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Brian Gerst <brgerst@gmail.com>
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

On Sun, Mar 17, 2024 at 5:30=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Sun, Mar 17, 2024 at 12:15=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Sun, Mar 17, 2024 at 10:43=E2=80=AFAM Brian Gerst <brgerst@gmail.com=
> wrote:
> > >
> > > On Sat, Mar 16, 2024 at 3:18=E2=80=AFPM Pasha Tatashin
> > > <pasha.tatashin@soleen.com> wrote:
> > > >
> > > > On Thu, Mar 14, 2024 at 11:40=E2=80=AFPM H. Peter Anvin <hpa@zytor.=
com> wrote:
> > > > >
> > > > > On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha.tatashin@=
soleen.com> wrote:
> > > > > >On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@in=
fradead.org> wrote:
> > > > > >>
> > > > > >> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrot=
e:
> > > > > >> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wro=
te:
> > > > > >> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin w=
rote:
> > > > > >> > > > Second, non-dynamic kernel memory is one of the core des=
ign decisions in
> > > > > >> > > > Linux from early on. This means there are lot of deeply =
embedded assumptions
> > > > > >> > > > which would have to be untangled.
> > > > > >> > >
> > > > > >> > > I think there are other ways of getting the benefit that P=
asha is seeking
> > > > > >> > > without moving to dynamically allocated kernel memory.  On=
e icky thing
> > > > > >> > > that XFS does is punt work over to a kernel thread in orde=
r to use more
> > > > > >> > > stack!  That breaks a number of things including lockdep (=
because the
> > > > > >> > > kernel thread doesn't own the lock, the thread waiting for=
 the kernel
> > > > > >> > > thread owns the lock).
> > > > > >> > >
> > > > > >> > > If we had segmented stacks, XFS could say "I need at least=
 6kB of stack",
> > > > > >> > > and if less than that was available, we could allocate a t=
emporary
> > > > > >> > > stack and switch to it.  I suspect Google would also be ab=
le to use this
> > > > > >> > > API for their rare cases when they need more than 8kB of k=
ernel stack.
> > > > > >> > > Who knows, we might all be able to use such a thing.
> > > > > >> > >
> > > > > >> > > I'd been thinking about this from the point of view of all=
ocating more
> > > > > >> > > stack elsewhere in kernel space, but combining what Pasha =
has done here
> > > > > >> > > with this idea might lead to a hybrid approach that works =
better; allocate
> > > > > >> > > 32kB of vmap space per kernel thread, put 12kB of memory a=
t the top of it,
> > > > > >> > > rely on people using this "I need more stack" API correctl=
y, and free the
> > > > > >> > > excess pages on return to userspace.  No complicated "swit=
ch stacks" API
> > > > > >> > > needed, just an "ensure we have at least N bytes of stack =
remaining" API.
> > > > > >
> > > > > >I like this approach! I think we could also consider having perm=
anent
> > > > > >big stacks for some kernel only threads like kvm-vcpu. A coopera=
tive
> > > > > >stack increase framework could work well and wouldn't negatively
> > > > > >impact the performance of context switching. However, thorough
> > > > > >analysis would be necessary to proactively identify potential st=
ack
> > > > > >overflow situations.
> > > > > >
> > > > > >> > Why would we need an "I need more stack" API? Pasha's approa=
ch seems
> > > > > >> > like everything we need for what you're talking about.
> > > > > >>
> > > > > >> Because double faults are hard, possibly impossible, and the F=
RED approach
> > > > > >> Peter described has extra overhead?  This was all described up=
-thread.
> > > > > >
> > > > > >Handling faults in #DF is possible. It requires code inspection =
to
> > > > > >handle race conditions such as what was shown by tglx. However, =
as
> > > > > >Andy pointed out, this is not supported by SDM as it is an abort
> > > > > >context (yet we return from it because of ESPFIX64, so return is
> > > > > >possible).
> > > > > >
> > > > > >My question, however, if we ignore memory savings and only consi=
der
> > > > > >reliability aspect of this feature.  What is better unconditiona=
lly
> > > > > >crashing the machine because a guard page was reached, or printi=
ng a
> > > > > >huge warning with a backtracing information about the offending =
stack,
> > > > > >handling the fault, and survive? I know that historically Linus
> > > > > >preferred WARN() to BUG() [1]. But, this is a somewhat different
> > > > > >scenario compared to simple BUG vs WARN.
> > > > > >
> > > > > >Pasha
> > > > > >
> > > > > >[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.1714=
-100000@home.transmeta.com
> > > > > >
> > > > >
> > > > > The real issue with using #DF is that if the event that caused it=
 was asynchronous, you could lose the event.
> > > >
> > > > Got it. So, using a #DF handler for stack page faults isn't feasibl=
e.
> > > > I suppose the only way for this to work would be to use a dedicated
> > > > Interrupt Stack Table (IST) entry for page faults (#PF), but I susp=
ect
> > > > that might introduce other complications.
> > > >
> > > > Expanding on Mathew's idea of an interface for dynamic kernel stack
> > > > sizes, here's what I'm thinking:
> > > >
> > > > - Kernel Threads: Create all kernel threads with a fully populated
> > > > THREAD_SIZE stack.  (i.e. 16K)
> > > > - User Threads: Create all user threads with THREAD_SIZE kernel sta=
ck
> > > > but only the top page mapped. (i.e. 4K)
> > > > - In enter_from_user_mode(): Expand the thread stack to 16K by mapp=
ing
> > > > three additional pages from the per-CPU stack cache. This function =
is
> > > > called early in kernel entry points.
> > > > - exit_to_user_mode(): Unmap the extra three pages and return them =
to
> > > > the per-CPU cache. This function is called late in the kernel exit
> > > > path.
> > > >
> > > > Both of the above hooks are called with IRQ disabled on all kernel
> > > > entries whether through interrupts and syscalls, and they are calle=
d
> > > > early/late enough that 4K is enough to handle the rest of entry/exi=
t.
> >
> > Hi Brian,
> >
> > > This proposal will not have the memory savings that you are looking
> > > for, since sleeping tasks would still have a fully allocated stack.
> >
> > The tasks that were descheduled while running in user mode should not
> > increase their stack. The potential saving is greater than the
> > origianl proposal, because in the origianl proposal we never shrink
> > stacks after faults.
>
> A task has to enter kernel mode in order to be rescheduled.  If it
> doesn't make a syscall or hit an exception, then the timer interrupt
> will eventually kick it out of user mode.  At some point schedule() is
> called, the task is put to sleep and context is switched to the next
> task.  A sleeping task will always be using some amount of kernel
> stack.  How much depends a lot on what caused the task to sleep.  If
> the timeslice expired it could switch right before the return to user
> mode.  A page fault could go deep into filesystem and device code
> waiting on an I/O operation.
>
> > > This also would add extra overhead to each entry and exit (including
> > > syscalls) that can happen multiple times before a context switch.  It
> > > also doesn't make much sense because a task running in user mode will
> > > quickly need those stack pages back when it returns to kernel mode.
> > > Even if it doesn't make a syscall, the timer interrupt will kick it
> > > out of user mode.
> > >
> > > What should happen is that the unused stack is reclaimed when a task
> > > goes to sleep.  The kernel does not use a red zone, so any stack page=
s
> > > below the saved stack pointer of a sleeping task (task->thread.sp) ca=
n
> > > be safely discarded.  Before context switching to a task, fully
> >
> > Excellent observation, this makes Andy Lutomirski per-map proposal [1]
> > usable without tracking dirty/accessed bits. More reliable, and also
> > platform independent.
>
> This is x86-specific.  Other architectures will likely have differences.
>
> > > populate its task stack.  After context switching from a task, reclai=
m
> > > its unused stack.  This way, the task stack in use is always fully
> > > allocated and we don't have to deal with page faults.
> > >
> > > To make this happen, __switch_to() would have to be split into two
> > > parts, to cleanly separate what happens before and after the stack
> > > switch.  The first part saves processor context for the previous task=
,
> > > and prepares the next task.
> >
> > By knowing the stack requirements of __switch_to(), can't we actually
> > do all that in the common code in context_switch() right before
> > __switch_to()? We would do an arch specific call to get the
> > __switch_to() stack requirement, and use that to change the value of
> > task->thread.sp to know where the stack is going to be while sleeping.
> > At this time we can do the unmapping of the stack pages from the
> > previous task, and mapping the pages to the next task.
>
> task->thread.sp is set in __switch_to_asm(), and is pretty much the
> last thing done in the context of the previous task.  Trying to
> predict that value ahead of time is way too fragile.

We don't require an exact value, but rather an approximate upper
limit. To illustrate, subtract 1K from the current .sp, then determine
the corresponding page to decide the number of pages needing
unmapping. The primary advantage is that we can avoid
platform-specific ifdefs for DYNAMIC_STACKS within the arch-specific
switch_to() function. Instead, each platform can provide an
appropriate upper bound for switch_to() operations. We know the amount
of information is going to be stored on the stack by the routines, and
also since interrupts are disabled stacks are not used for anything
else there, so I do not see a problem with determining a reasonable
upper bound.

>  Also, the key
> point I was trying to make is that you cannot safely shrink the active
> stack.  It can only be done after the stack switch to the new task.

Can you please elaborate why this is so? If the lowest pages are not
used, and interrupts are disabled what is not safe about removing them
from the page table?

I am not against the idea of unmapping in __switch_to(), I just want
to understand the reasons why more generic but perhaps not as precise
approach would not  work.

> > > Populating the next task's stack would
> > > happen here.  Then it would return to the assembly code to do the
> > > stack switch.  The second part then loads the context of the next
> > > task, and finalizes any work for the previous task.  Reclaiming the
> > > unused stack pages of the previous task would happen here.
> >
> > The problem with this (and the origianl Andy's approach), is that we
> > cannot sleep here. What happens if we get per-cpu stack cache
> > exhausted because several threads sleep while having deep stacks? How
> > can we schedule the next task? This is probably a corner case, but it
> > needs to have a proper handling solution. One solution is while in
> > schedule() and while interrupts are still enabled before going to
> > switch_to() we must pre-allocate 3-page in the per-cpu. However, what
> > if the pre-allocation itself calls cond_resched() because it enters
> > page allocator slowpath?
>
> You would have to keep extra pages in reserve for allocation failures.
> mempool could probably help with that.

Right. Mempool do not work when interrupts are disabled, but perhaps
we can use them to keep per-cpu filled with a separate thread. I will
think about it.

Thanks,
Pasha

