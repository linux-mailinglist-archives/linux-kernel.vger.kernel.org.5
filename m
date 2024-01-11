Return-Path: <linux-kernel+bounces-24127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C182B7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A801F22FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1D58AD7;
	Thu, 11 Jan 2024 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aarsen.me header.i=@aarsen.me header.b="bhvTGbHR"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB923A1B7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aarsen.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aarsen.me
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TB0wJ07LSz9sTK;
	Fri, 12 Jan 2024 00:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aarsen.me; s=MBO0001;
	t=1705015120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uV4GSFkVHyXs4nWz/DilseZ8Bw3FC/zNsrOEp7Vvvg=;
	b=bhvTGbHR6AKnB4wODIuOi/JzONqMS7afuZS8JcPMT0ikkC9ZeI+dH8odByFCkdrc/346ke
	C54rmtds+DjeiFg1cRt7AbQwWBVruNaiwTsMjIy2Vl6thQBSPXj0RUqyqvMSSTm68dFavx
	iZoW1vDVK3ZSABz9S/C1hvkEuemGdRyS1mPM+pYUN6/N7DkL5aZlHRjuWJ7x+pr7DIPETA
	AHsnx2z6dPKyHioO8xx+9nH5wBwXrKCbyFcQR87hHNwOitV4hxXkwn4Mk1s2JXaxr6RYA6
	hNoR72H8IXtn+ldwKNSq1YvErKbVN/0pNJMDT1s/Ev2qbVULPmpFTXiPBifwPw==
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
From: Arsen =?utf-8?Q?Arsenovi=C4=87?= <arsen@aarsen.me>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Date: Fri, 12 Jan 2024 00:09:30 +0100
In-reply-to: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
Message-ID: <86r0inmpbm.fsf@aarsen.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


David Howells <dhowells@redhat.com> writes:

> Here are a series of patches to start converting the kernel to C++.  It
> requires g++ v8.
>
> What rocks:
>
>  (1) Inline template functions, which makes implementation of things like
>      cmpxchg() and get_user() much cleaner.
>
>  (2) Inline overloaded functions, which makes implementation of things li=
ke
>      static_branch_likely() cleaner.
>
>  (3) Class inheritance.  For instance, all those inode wrappers that requ=
ire
>      the base inode struct to be included and that has to be accessed with
>      something like:
>
> 	inode->vfs_inode.i_mtime
>
>      when you could instead do:
>
> 	inode->i_mtime
>
> What I would disallow:
>
>  (1) new and delete.  There's no way to pass GFP_* flags in.
>
>  (2) Constructors and destructors.  Nests of implicit code makes the code=
 less
>      obvious, and the replacement of static initialisation with construct=
or
>      calls would make the code size larger.

This also disallows the primary benefit of C++ (RAII), though.  A lot of
static initialization can be achieved using constexpr and consteval,
too.

It is incredibly useful to be able to express resource ownership in
terms of automatic storage duration.

>  (3) Exceptions and RTTI.  RTTI would bulk the kernel up too much and
>      exception handling is limited without it, and since destructors are =
not
>      allowed, you still have to manually clean up after an error.
>
>  (4) Operator overloading (except in special cases).
>
>  (5) Function overloading (except in special inline cases).

Generic code, another significant benefit of C++, requires function
overloading, though.

>  (6) STL (though some type trait bits are needed to replace __builtins th=
at
>      don't exist in g++).

A lot of useful stuff that works fine in kernel contexts is in the STL,
though.  For instance, nearly everything from the iterators, ranges,
utility, memory, and algorithms library works fine.  Naturally,
concepts, type traits, and language support libraries are also fine.

>  (7) 'class', 'private', 'namespace'.

'class' does nothing that struct doesn't do, private and namespace serve
simply for encapsulation, so I don't see why banning these is useful.

>  (8) 'virtual'.  Don't want virtual base classes, though virtual function
>      tables might make operations tables more efficient.

Virtual base classes are seldom useful, but I see no reason to
blanket-ban them (and I suspect you'll never notice that they're not
banned).

> Issues:
>
>  (1) Need spaces inserting between strings and symbols.
>
>  (2) Direct assignment of pointers to/from void* isn't allowed by C++, th=
ough
>      g++ grudgingly permits it with -fpermissive.  I would imagine that a
>      compiler option could easily be added to hide the error entirely.

This should never be useful.

Have a lovely night!

>  (3) Need gcc v8+ to statically initialise an object of any struct that's=
 not
>      really simple (e.g. if it's got an embedded union).
>
>  (4) Symbol length.  Really need to extern "C" everything to reduce the s=
ize
>      of the symbols stored in the kernel image.  This shouldn't be a prob=
lem
>      if out-of-line function overloading isn't permitted.
>
> So far, it gets as far as compiling init/main.c to a .o file.
>
> Seriously, though...
>
> Apart from the cleaner inline functions allowed by templating, I'm not su=
re
> there's a lot of the C++ language that we would want to use in the kernel
> unless we want to go for more advanced classes implementing interesting t=
ypes.
>
> We could, for example, wrap things like userspace pointers, __be numbers,
> ioport addresses and control access to them that way, but I don't know th=
at it
> gains a whole load that sparse doesn't give us.
>
> And finally, doing this did find a few minor things that can be fixed.
>
> David
> ---
> David Howells (45):
>       Use UINT_MAX, not -1, to represent an invalid UID, GID or project ID
>       Fix exception_enter() return value
>       Fix loop var in be32_to_cpu_array() and cpu_to_be32_array()
>       Fix use of ACPI_COMPANION_SET()
>       C++: Set compilation as C++ for .c files
>       C++: Do some basic C++ type definition
>       C++: Define a header with some C++ type traits for type checking
>       C++: Implement abs() as an inline template function
>       C++: x86: Fix the x86 syscall table production for C++
>       C++: x86: Turn xchg(), xadd() & co. into inline template functions
>       C++: x86: Turn cmpxchg() & co. into inline template functions
>       C++: x86: Turn cmpxchg_double() & co. into inline template functions
>       C++: x86: Turn cmpxchg64() & co. into inline template functions
>       C++: x86: Turn put_user(), get_user() & co. into inline template fu=
nctions
>       C++: Need space between string and symbol
>       C++: Disable VERIFY_OCTAL_PERMISSIONS() for the moment
>       C++: Turn READ_ONCE(), WRITE_ONCE() & co. into inline template func=
tions
>       C++: Turn RCU accessors into inline template functions
>       C++: Turn ktime_add/sub_ns() into inline template functions
>       C++: init/main: Constify pointers
>       C++: Set the type of atomic64_t to s64
>       C++: Define apic_intr_mode after the enum definition, not before
>       C++: Don't do "extern asmlinkage"
>       C++: Fix BUILD_BUG_ON_ZERO()
>       C++: Fix void variables
>       C++: Can't have variable/member names the same as typedef names
>       C++: Disable __same_type() for the moment
>       C++: Move ctx_state enum out of struct context_tracking
>       C++: Move the print_line_t enum before first use
>       C++: Include linux/hrtimer.h from linux/timer.h
>       C++: Avoid using 'compl' and 'and' as names
>       C++: __to_fd() needs to reduce the size of v for struct fd::flags
>       C++: Move irqchip_irq_state enum
>       C++: Fix up use of LIST_POISON*
>       C++: Fix static_branch_likely/unlikely()
>       C++: Fix kernfs_type() int->enum
>       C++: Fix page_zonenum() int->enum
>       C++: mutex_trylock_recursive_enum() int->enum
>       C++: Fix spinlock initialisation
>       C++: Fix sema_init()
>       C++: Cast in bitops
>       C++: Hide C++ keywords
>       C++: Don't need to declare struct pgd_t after typedef
>       C++: Can't declare unsized-array in struct cgroup
>       C++: Move initcall_level_names[] to __initdata section
>
>
>  Makefile                               |   13 -
>  arch/x86/Makefile                      |    2
>  arch/x86/entry/syscalls/Makefile       |    8
>  arch/x86/entry/syscalls/syscallhdr.pl  |   73 ++++
>  arch/x86/entry/syscalls/syscalltbl.pl  |   95 +++++
>  arch/x86/include/asm/alternative.h     |   10 -
>  arch/x86/include/asm/apic.h            |    2
>  arch/x86/include/asm/arch_hweight.h    |    4
>  arch/x86/include/asm/atomic.h          |    2
>  arch/x86/include/asm/atomic64_64.h     |   12 -
>  arch/x86/include/asm/cmpxchg.h         |  430 +++++++++++-----------
>  arch/x86/include/asm/cmpxchg_64.h      |   28 +
>  arch/x86/include/asm/hw_irq.h          |   38 +-
>  arch/x86/include/asm/percpu.h          |   94 ++---
>  arch/x86/include/asm/perf_event.h      |    2
>  arch/x86/include/asm/processor.h       |    2
>  arch/x86/include/asm/special_insns.h   |    2
>  arch/x86/include/asm/tlbflush.h        |    1
>  arch/x86/include/asm/uaccess.h         |  630 +++++++++++++++++---------=
------
>  arch/x86/include/asm/uaccess_64.h      |   66 +--
>  arch/x86/kernel/asm-offsets_32.c       |    1
>  arch/x86/kernel/asm-offsets_64.c       |    1
>  arch/x86/purgatory/Makefile            |    2
>  include/asm-generic/bitops/le.h        |   32 +-
>  include/asm-generic/sections.h         |    2
>  include/linux/acpi.h                   |    2
>  include/linux/backing-dev-defs.h       |    4
>  include/linux/blkdev.h                 |   86 ++--
>  include/linux/build_bug.h              |    5
>  include/linux/byteorder/generic.h      |    4
>  include/linux/cgroup-defs.h            |    2
>  include/linux/compat.h                 |    2
>  include/linux/compiler-c++.h           |   54 +++
>  include/linux/compiler-gcc.h           |    5
>  include/linux/compiler.h               |   93 +----
>  include/linux/compiler_types.h         |    2
>  include/linux/context_tracking.h       |    4
>  include/linux/context_tracking_state.h |   14 -
>  include/linux/cpumask.h                |    4
>  include/linux/crypto.h                 |    4
>  include/linux/elevator.h               |   82 ++--
>  include/linux/file.h                   |    2
>  include/linux/interrupt.h              |   10 -
>  include/linux/irq.h                    |    1
>  include/linux/irqflags.h               |   10 +
>  include/linux/jump_label.h             |   41 +-
>  include/linux/kernel.h                 |   35 --
>  include/linux/kernfs.h                 |    2
>  include/linux/ktime.h                  |   12 +
>  include/linux/list.h                   |    8
>  include/linux/list_bl.h                |    4
>  include/linux/list_nulls.h             |    2
>  include/linux/lockdep.h                |    2
>  include/linux/mm.h                     |    2
>  include/linux/mutex.h                  |    5
>  include/linux/page-flags.h             |    3
>  include/linux/poison.h                 |    6
>  include/linux/printk.h                 |    4
>  include/linux/projid.h                 |    2
>  include/linux/rculist.h                |    4
>  include/linux/rculist_bl.h             |    2
>  include/linux/rcupdate.h               |  124 ++++--
>  include/linux/sched/task.h             |    2
>  include/linux/semaphore.h              |    5
>  include/linux/spinlock.h               |    2
>  include/linux/spinlock_types.h         |    4
>  include/linux/start_kernel.h           |    2
>  include/linux/stddef.h                 |   12 -
>  include/linux/sysctl.h                 |    6
>  include/linux/timer.h                  |    1
>  include/linux/trace_events.h           |   16 -
>  include/linux/types.h                  |   16 +
>  include/linux/uidgid.h                 |    4
>  init/main.c                            |    4
>  scripts/checksyscalls.sh               |    2
>  tools/power/cpupower/Makefile          |    1
>  tools/virtio/Makefile                  |    2
>  77 files changed, 1269 insertions(+), 1010 deletions(-)
>  create mode 100644 arch/x86/entry/syscalls/syscallhdr.pl
>  create mode 100644 arch/x86/entry/syscalls/syscalltbl.pl
>  create mode 100644 include/linux/compiler-c++.h


=2D-
Arsen Arsenovi=C4=87

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOYEARYKAI4WIQT+4rPRE/wAoxYtYGFSwpQwHqLEkwUCZaB3Tl8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0RkVF
MkIzRDExM0ZDMDBBMzE2MkQ2MDYxNTJDMjk0MzAxRUEyQzQ5MxAcYXJzZW5AYWFy
c2VuLm1lAAoJEFLClDAeosSTwXEA/2WeiN6RceukwQoywqag+9Xw6ySCAQ+3VMKP
9n24v8K8AQDmw6r1dXEefx/NBDRTNJmbY9Pcs0W6PeWEPPcBUGUTDQ==
=fs0M
-----END PGP SIGNATURE-----
--=-=-=--

