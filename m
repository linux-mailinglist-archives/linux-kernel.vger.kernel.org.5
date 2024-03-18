Return-Path: <linux-kernel+bounces-106661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CB87F1AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A728280E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288358136;
	Mon, 18 Mar 2024 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX8vzqRU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D8250EC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795782; cv=none; b=i8th+IkSiZqjt836DK/sryDvZg/xHs3YytTAaBguhM8tJOEpey1hsWF0kWE63w30XoQiHLoAHB1lW2+xMMEMODjEa96p+iX6Vx12fSTfVCE3mUf6T0mUZpUebrhc0EaCQND/IZZ7y2gmI+ks7giTx7DEEXXy62zCocx6CxWFGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795782; c=relaxed/simple;
	bh=Vv3HQy11IP2LQR/uQVs/P+bSmRO749wrsaVehu1bjo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1dO6Aug+Gj2XXxJdEPja1g0JN0SuunK1QrUEU93rfMdtF7wPYMxix3qReBqT+ELTmDQ2bzgK27FZXFYAh7ESft5a43miOJggdDN4jS8WJ2YGW32YEeKSG96PSIVTvUIED4EeXQ+LpSzoXnbEwyIfwi+ZnoEJv8zjSUZK3U7LKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX8vzqRU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513d247e3c4so4020036e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710795779; x=1711400579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HedJcrSxPQdXLuoYD1u0yMNVHwaM2bPmO6FcpMXPtg=;
        b=DX8vzqRU2jKDNvwKCoHQ6fOVvlmpvyn65HAeaApTh+vwRUP5C10IYoHYV85ItZVMAS
         8Hj3tuiqgUHJBRpiOZBknRfm3RUS4AmcbKMy3sQsGL6vamje5EZFKBgTIq3Xxd2+DgEA
         O0GiBZZwWZTA8oO8G3Rb0tH7/NDoDRsU48eCkBgVeT9mdOMEODrxlE3AtI0e6rEaJOmL
         2Bj0uneNGIWmE1u7UJ0hvxDgEmGRHYjcvMv4Qn+02+vYf9Es4mH0DMSZGI5lq+/OnQtm
         5EvHYBKEpLNqtYKJtEv3AhDQnDUioHWNiVJRreAUeCrmKevZNSNhAUypLyHYZpjFVG5W
         P6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795779; x=1711400579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HedJcrSxPQdXLuoYD1u0yMNVHwaM2bPmO6FcpMXPtg=;
        b=MVfxK0VgeIO/f66qt7nE9S5oabHm2s0NxRtDedWV5NV248UsEaTiUkF+rscVb/78in
         ihcIPeFvKmeIgKNcPbLWMGwDPMRE+I1LFxGEKxME5/ZUZCf4lthE8/qarsOhuu9sOZiC
         /GSXsvIK7mn+MSqhkq8LZuJhQYx8gT/jIAZSnBOdV8PCxUkT/1xTPgYGQ1h79sj1Zzoy
         9GFoAzGTKc+dyAOsYq12Its/6KAsOHNjtNjRKQc8ypjzTA+o3Eo5UGl+m7eeVS+RVW9C
         29t2e6oB0I2iETlEDpg91fUUCDWc3wA4NjemVQlKNprRVdJ803BvL/nLlk2HfoSuIJgt
         13tg==
X-Forwarded-Encrypted: i=1; AJvYcCUwkhz5u3neBIDblSSBDlCq183cmxM8fhLfWIPWr4Zd3lTkEzINSkfUHVLpypp5V/6zbfcJ4eWlJtAinKZTMuTOAskmLudE6LjOYPPl
X-Gm-Message-State: AOJu0YwkU0BmVNHKed4BTwbf4jfROgsqc2TsdhdEsUHw/eEKIuEZpRDJ
	v89SMIqnhJH8XFO3d03aV6uMmTFqC/vwl4gXFA8T8Jg6Nh7J2S76k7UOhkMjeAwsfmBeBQbqFzQ
	GqWuSfyIXvZFQZuNGxw5iSs7uvw==
X-Google-Smtp-Source: AGHT+IFJGMO1vXOqGkBJWLc3mzMExY0GPMC678LKTt28lEkLyqW704bJ3SplAQTTBSU+7DTlk1jVuqKmC++jdQNJu8g=
X-Received: by 2002:a19:6914:0:b0:513:ca5c:fccc with SMTP id
 e20-20020a196914000000b00513ca5cfcccmr274112lfc.7.1710795778518; Mon, 18 Mar
 2024 14:02:58 -0700 (PDT)
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
 <CA+CK2bBTrrJerZMdJrKhg683H4VmnqbgkGu2VG2UuirWNm1TnA@mail.gmail.com>
 <CAMzpN2jmQoG9Cw56JOh7t_Y21Fax3bA9iAEA2B7TLnYs5ycdJQ@mail.gmail.com> <CA+CK2bDO=LV8nEFn=q6w3Pyna3aqKAiFEzHMb-d7xzMOThOXSQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDO=LV8nEFn=q6w3Pyna3aqKAiFEzHMb-d7xzMOThOXSQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 18 Mar 2024 17:02:46 -0400
Message-ID: <CAMzpN2i8SRkgUZ+XSj7wJrtRn=-mB=7v7=C8auES=FAW_MFN-Q@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 11:00=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sun, Mar 17, 2024 at 5:30=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > On Sun, Mar 17, 2024 at 12:15=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On Sun, Mar 17, 2024 at 10:43=E2=80=AFAM Brian Gerst <brgerst@gmail.c=
om> wrote:
> > > >
> > > > On Sat, Mar 16, 2024 at 3:18=E2=80=AFPM Pasha Tatashin
> > > > <pasha.tatashin@soleen.com> wrote:
> > > > >
> > > > > On Thu, Mar 14, 2024 at 11:40=E2=80=AFPM H. Peter Anvin <hpa@zyto=
r.com> wrote:
> > > > > >
> > > > > > On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha.tatashi=
n@soleen.com> wrote:
> > > > > > >On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@=
infradead.org> wrote:
> > > > > > >>
> > > > > > >> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wr=
ote:
> > > > > > >> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox w=
rote:
> > > > > > >> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H. Peter Anvin=
 wrote:
> > > > > > >> > > > Second, non-dynamic kernel memory is one of the core d=
esign decisions in
> > > > > > >> > > > Linux from early on. This means there are lot of deepl=
y embedded assumptions
> > > > > > >> > > > which would have to be untangled.
> > > > > > >> > >
> > > > > > >> > > I think there are other ways of getting the benefit that=
 Pasha is seeking
> > > > > > >> > > without moving to dynamically allocated kernel memory.  =
One icky thing
> > > > > > >> > > that XFS does is punt work over to a kernel thread in or=
der to use more
> > > > > > >> > > stack!  That breaks a number of things including lockdep=
 (because the
> > > > > > >> > > kernel thread doesn't own the lock, the thread waiting f=
or the kernel
> > > > > > >> > > thread owns the lock).
> > > > > > >> > >
> > > > > > >> > > If we had segmented stacks, XFS could say "I need at lea=
st 6kB of stack",
> > > > > > >> > > and if less than that was available, we could allocate a=
 temporary
> > > > > > >> > > stack and switch to it.  I suspect Google would also be =
able to use this
> > > > > > >> > > API for their rare cases when they need more than 8kB of=
 kernel stack.
> > > > > > >> > > Who knows, we might all be able to use such a thing.
> > > > > > >> > >
> > > > > > >> > > I'd been thinking about this from the point of view of a=
llocating more
> > > > > > >> > > stack elsewhere in kernel space, but combining what Pash=
a has done here
> > > > > > >> > > with this idea might lead to a hybrid approach that work=
s better; allocate
> > > > > > >> > > 32kB of vmap space per kernel thread, put 12kB of memory=
 at the top of it,
> > > > > > >> > > rely on people using this "I need more stack" API correc=
tly, and free the
> > > > > > >> > > excess pages on return to userspace.  No complicated "sw=
itch stacks" API
> > > > > > >> > > needed, just an "ensure we have at least N bytes of stac=
k remaining" API.
> > > > > > >
> > > > > > >I like this approach! I think we could also consider having pe=
rmanent
> > > > > > >big stacks for some kernel only threads like kvm-vcpu. A coope=
rative
> > > > > > >stack increase framework could work well and wouldn't negative=
ly
> > > > > > >impact the performance of context switching. However, thorough
> > > > > > >analysis would be necessary to proactively identify potential =
stack
> > > > > > >overflow situations.
> > > > > > >
> > > > > > >> > Why would we need an "I need more stack" API? Pasha's appr=
oach seems
> > > > > > >> > like everything we need for what you're talking about.
> > > > > > >>
> > > > > > >> Because double faults are hard, possibly impossible, and the=
 FRED approach
> > > > > > >> Peter described has extra overhead?  This was all described =
up-thread.
> > > > > > >
> > > > > > >Handling faults in #DF is possible. It requires code inspectio=
n to
> > > > > > >handle race conditions such as what was shown by tglx. However=
, as
> > > > > > >Andy pointed out, this is not supported by SDM as it is an abo=
rt
> > > > > > >context (yet we return from it because of ESPFIX64, so return =
is
> > > > > > >possible).
> > > > > > >
> > > > > > >My question, however, if we ignore memory savings and only con=
sider
> > > > > > >reliability aspect of this feature.  What is better unconditio=
nally
> > > > > > >crashing the machine because a guard page was reached, or prin=
ting a
> > > > > > >huge warning with a backtracing information about the offendin=
g stack,
> > > > > > >handling the fault, and survive? I know that historically Linu=
s
> > > > > > >preferred WARN() to BUG() [1]. But, this is a somewhat differe=
nt
> > > > > > >scenario compared to simple BUG vs WARN.
> > > > > > >
> > > > > > >Pasha
> > > > > > >
> > > > > > >[1] https://lore.kernel.org/all/Pine.LNX.4.44.0209091832160.17=
14-100000@home.transmeta.com
> > > > > > >
> > > > > >
> > > > > > The real issue with using #DF is that if the event that caused =
it was asynchronous, you could lose the event.
> > > > >
> > > > > Got it. So, using a #DF handler for stack page faults isn't feasi=
ble.
> > > > > I suppose the only way for this to work would be to use a dedicat=
ed
> > > > > Interrupt Stack Table (IST) entry for page faults (#PF), but I su=
spect
> > > > > that might introduce other complications.
> > > > >
> > > > > Expanding on Mathew's idea of an interface for dynamic kernel sta=
ck
> > > > > sizes, here's what I'm thinking:
> > > > >
> > > > > - Kernel Threads: Create all kernel threads with a fully populate=
d
> > > > > THREAD_SIZE stack.  (i.e. 16K)
> > > > > - User Threads: Create all user threads with THREAD_SIZE kernel s=
tack
> > > > > but only the top page mapped. (i.e. 4K)
> > > > > - In enter_from_user_mode(): Expand the thread stack to 16K by ma=
pping
> > > > > three additional pages from the per-CPU stack cache. This functio=
n is
> > > > > called early in kernel entry points.
> > > > > - exit_to_user_mode(): Unmap the extra three pages and return the=
m to
> > > > > the per-CPU cache. This function is called late in the kernel exi=
t
> > > > > path.
> > > > >
> > > > > Both of the above hooks are called with IRQ disabled on all kerne=
l
> > > > > entries whether through interrupts and syscalls, and they are cal=
led
> > > > > early/late enough that 4K is enough to handle the rest of entry/e=
xit.
> > >
> > > Hi Brian,
> > >
> > > > This proposal will not have the memory savings that you are looking
> > > > for, since sleeping tasks would still have a fully allocated stack.
> > >
> > > The tasks that were descheduled while running in user mode should not
> > > increase their stack. The potential saving is greater than the
> > > origianl proposal, because in the origianl proposal we never shrink
> > > stacks after faults.
> >
> > A task has to enter kernel mode in order to be rescheduled.  If it
> > doesn't make a syscall or hit an exception, then the timer interrupt
> > will eventually kick it out of user mode.  At some point schedule() is
> > called, the task is put to sleep and context is switched to the next
> > task.  A sleeping task will always be using some amount of kernel
> > stack.  How much depends a lot on what caused the task to sleep.  If
> > the timeslice expired it could switch right before the return to user
> > mode.  A page fault could go deep into filesystem and device code
> > waiting on an I/O operation.
> >
> > > > This also would add extra overhead to each entry and exit (includin=
g
> > > > syscalls) that can happen multiple times before a context switch.  =
It
> > > > also doesn't make much sense because a task running in user mode wi=
ll
> > > > quickly need those stack pages back when it returns to kernel mode.
> > > > Even if it doesn't make a syscall, the timer interrupt will kick it
> > > > out of user mode.
> > > >
> > > > What should happen is that the unused stack is reclaimed when a tas=
k
> > > > goes to sleep.  The kernel does not use a red zone, so any stack pa=
ges
> > > > below the saved stack pointer of a sleeping task (task->thread.sp) =
can
> > > > be safely discarded.  Before context switching to a task, fully
> > >
> > > Excellent observation, this makes Andy Lutomirski per-map proposal [1=
]
> > > usable without tracking dirty/accessed bits. More reliable, and also
> > > platform independent.
> >
> > This is x86-specific.  Other architectures will likely have differences=
.
> >
> > > > populate its task stack.  After context switching from a task, recl=
aim
> > > > its unused stack.  This way, the task stack in use is always fully
> > > > allocated and we don't have to deal with page faults.
> > > >
> > > > To make this happen, __switch_to() would have to be split into two
> > > > parts, to cleanly separate what happens before and after the stack
> > > > switch.  The first part saves processor context for the previous ta=
sk,
> > > > and prepares the next task.
> > >
> > > By knowing the stack requirements of __switch_to(), can't we actually
> > > do all that in the common code in context_switch() right before
> > > __switch_to()? We would do an arch specific call to get the
> > > __switch_to() stack requirement, and use that to change the value of
> > > task->thread.sp to know where the stack is going to be while sleeping=
.
> > > At this time we can do the unmapping of the stack pages from the
> > > previous task, and mapping the pages to the next task.
> >
> > task->thread.sp is set in __switch_to_asm(), and is pretty much the
> > last thing done in the context of the previous task.  Trying to
> > predict that value ahead of time is way too fragile.
>
> We don't require an exact value, but rather an approximate upper
> limit. To illustrate, subtract 1K from the current .sp, then determine
> the corresponding page to decide the number of pages needing
> unmapping. The primary advantage is that we can avoid
> platform-specific ifdefs for DYNAMIC_STACKS within the arch-specific
> switch_to() function. Instead, each platform can provide an
> appropriate upper bound for switch_to() operations. We know the amount
> of information is going to be stored on the stack by the routines, and
> also since interrupts are disabled stacks are not used for anything
> else there, so I do not see a problem with determining a reasonable
> upper bound.

The stack usage will vary depending on compiler version and
optimization settings.  Making an educated guess is possible, but may
not be enough in the future.

What would be nice is to get some actual data on stack usage under
various workloads, both maximum depth and depth at context switch.

> >  Also, the key
> > point I was trying to make is that you cannot safely shrink the active
> > stack.  It can only be done after the stack switch to the new task.
>
> Can you please elaborate why this is so? If the lowest pages are not
> used, and interrupts are disabled what is not safe about removing them
> from the page table?
>
> I am not against the idea of unmapping in __switch_to(), I just want
> to understand the reasons why more generic but perhaps not as precise
> approach would not  work.

As long as a wide buffer is given, it would probably be safe.  But it
would still be safer and more precise if done after the switch.



Brian Gerst

