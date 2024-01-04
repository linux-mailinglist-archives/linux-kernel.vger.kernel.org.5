Return-Path: <linux-kernel+bounces-16288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D683823C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CAB28754C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB931CFAF;
	Thu,  4 Jan 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="eBufPN/+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBB1DDF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=iMphVloIeKUNeeJm3gp+Gr4tQlsmrQhpofACzzv2WRg=; b=eBufPN/+upujT5lGNU/qW8wIZ5
	dfIWqOb43suhLnI3KLpBNoBX7eWaLZfaoYcjrBCAF11+FlOsT+GK+E8lItWOcN7EuU/5thiLWaEVq
	Bvpfv6y32jUxkdAxytxSw5mNJ4LV4d24U2Ew/qcy5fXvvfcYiFttFGZxwY5xo/+ZCWEq+l9TVb5y1
	v12Vq1UrXwcaJIbUoPe82h1wYBXsr31FfTXbFe1h9OUMErPcGmi2H86QTTloLiVG7ofGfEpB/rpye
	9T9P0xHag0lByTdAK1QAOrMzYMzxmLjeTyZGcIahdeMkNUg2Govrm0NejU78PX6xpAJ6B+tUx6mFr
	pa9xUJmg==;
Received: from [10.69.139.5] (helo=uriel.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rLHKG-00AxRy-09;
	Thu, 04 Jan 2024 00:35:32 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Sean Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org
Subject: Re: x86 SGDT emulation for Wine
Date: Thu, 04 Jan 2024 00:35:28 -0600
Message-ID: <2451911.jE0xQCEvom@uriel>
In-Reply-To: <1C37C311-CF8A-44EC-89B5-D826EF458708@zytor.com>
References:
 <2285758.taCxCBeP46@uriel> <ZZV65qJuJ67E_n9O@google.com>
 <1C37C311-CF8A-44EC-89B5-D826EF458708@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, January 3, 2024 9:33:10 AM CST H. Peter Anvin wrote:
> On January 3, 2024 7:19:02 AM PST, Sean Christopherson <seanjc@google.com=
>=20
wrote:
> >On Tue, Jan 02, 2024, Elizabeth Figura wrote:
> >> On Wednesday, December 27, 2023 5:58:19 PM CST H. Peter Anvin wrote:
> >> > On December 27, 2023 2:20:37 PM PST, Elizabeth Figura=20
<zfigura@codeweavers.com> wrote:
> >> > >Hello all,
> >> > >
> >> > >There is a Windows 98 program, a game called Nuclear Strike, which
> >> > >wants to
> >> > >do some amount of direct VGA access. Part of this is port I/O, which
> >> > >naturally throws SIGILL that we can trivially catch and emulate in
> >> > >Wine.
> >> > >The other part is direct access to the video memory at 0xa0000, whi=
ch
> >> > >in
> >> > >general isn't a problem to catch and virtualize as well.
> >> > >
> >> > >However, this program is a bit creative about how it accesses that
> >> > >memory;
> >> > >instead of just writing to 0xa0000 directly, it looks up a segment
> >> > >descriptor whose base is at 0xa0000 and then uses the %es override =
to
> >
> >> > >write bytes. In pseudo-C, what it does is:
> >...
> >
> >> > A prctl() to set the UMIP-emulated return values or disable it (givi=
ng
> >> > SIGILL) would be easy enough.
> >> >=20
> >> > For the non-UMIP case, and probably for a lot of other corner cases
> >> > like
> >> > relying on certain magic selector values and what not, the best opti=
on
> >> > really would be to wrap the code in a lightweight KVM container. I do
> >> > *not*
> >> > mean running the Qemu user space part of KVM; instead have Wine
> >> > interface
> >> > with /dev/kvm directly.
> >> >=20
> >> > Non-KVM-capable hardware is basically historic at this point.
> >>=20
> >> Sorry for the late response=E2=80=94I've been trying to do research on=
 what would
> >> be necessary to use KVM (plus I made the poor choice of sending this
> >> during the holiday season...)
> >>=20
> >> I'm concerned that KVM is going to be difficult or even intractable. H=
ere
> >> are some of the problems that I (perhaps incorrectly) understand:
> >>=20
> >> * As I am led to understand, there can only be one hypervisor on the
> >> machine at a time,
> >
> >No.  Only one instance of KVM-the-module is allowed, but there is no
> >arbitrary limit on the number of VMs that userspace can create.  The only
> >meaningful limitation is memory, and while struct kvm isn't tiny, it's n=
ot
> >_that_ big.>

Ah, thanks for the correction.

So if we're able to have one VM per thread, or one VM per process with one=
=20
vcpu per thread (but that one is capped at 1024 at least right now?), and w=
e=20
don't risk running into any limits, that does make things a great deal easi=
er.

Still, as Stefan said, I don't know if using a hypervisor is going to be=20
plausible for speed reasons.

> >> and KVM has a hard limit on the number of vCPUs.
> >>=20
> >>   The obvious way to use KVM for Wine is to make each (guest) thread a
> >>   vCPU.
> >>=20
> >> That will, at the very least, run into the thread limit. In order to
> >> avoid
> >> that we'd need to ship a whole scheduler, which is concerning. That's a
> >> huge component to ship and a huge burden to keep updated. It also means
> >> we need to hoist *all* of the ipc and sync code into the guest, which
> >> will take an enormous amount of work.
> >>=20
> >>   Moreover, because there can only be one hypervisor, and Wine is a
> >>   multi-
> >>=20
> >> process beast, that means that we suddenly need to throw every process
> >> into
> >> the same VM.
> >
> >As above, this is wildly inaccurate.  The only KVM restriction with resp=
ect
> >to processes is that a VM is bound to the process (address space) that
> >created the VM.  There are no restrictions on the number of VMs that can
> >be created, e.g. a single process can create multiple VMs.
> >
> >> That has unfortunate implications regarding isolation (it's been a dre=
am
> >> for years that we'd be able to share a single wine "VM" between multip=
le
> >> users), it complicates memory management (though perhaps not terribly?=
).
> >> And it means you can only have one Wine VM at a time, and can't use Wi=
ne
> >> at the same time as a "real" VM, neither of which are restrictions that
> >> currently exist.>>=20
> >>   And it's not even like we can refactor=E2=80=94we'd have to rewrite =
tons of
> >>   code to
> >>=20
> >> work inside a VM, but also keep the old code around for the cases where
> >> we
> >> don't have a VM and want to delegate scheduling to the host OS.
> >>=20
> >> * Besides scheduling, we need to exit the VM every time we would norma=
lly
> >> call into Unix code, which in practice is every time that the
> >> application does an NT syscall, or uses a library which we delegate to
> >> the host (including e.g. GPU, multimedia, audio...)
> >
> >Maybe I misinterpreted Peter's suggestion, but at least in my mind I was=
n't
> >thinking that the entire Wine process would run in a VM, but rather Wine
> >would run just the "problematic" code in a VM.
>=20
> Yes, the idea would be that you would run the "problematic" code inside a=
 VM
> *mapped 1:1 with the external address space*, i.e. use KVM simply as a
> special execution mode to give you more control of the fine grained machi=
ne
> state like the GDT. The code that you don't want executed in the VM conte=
xt
> simply leave unmapped in the VM page tables and set up #PF to always exit
> the VM context.

So yes, as long as we *can* organize things such that we exit the hyperviso=
r=20
every time we want to call into Unix code, then that's feasible. We have a=
=20
well-defined break between Windows and Unix code and it wouldn't be=20
inordinately difficult to shove the VM exit into that break. My concern was=
=20
that limitations on the number of VMs or vCPUs we can create would prevent =
us=20
from doing that, and effectively require us to implement a lot more inside =
the=20
VM, but as I understand that's not actually a problem.

That still leaves the question of performance though. If having to exit the=
 VM=20
that often for performance reasons isn't feasible, then that's still going =
to=20
force us to implement from scratch an inordinate amount of kernel/library c=
ode=20
inside the VM just to avoid the transition. Or, more likely, conclude that =
a=20
hypervisor just isn't going to work for us.


I'm not at all familiar with the arch code, and I'm sure I'm not asking=20
anything interesting, but is it really impossible to put CPU_ENTRY_AREA_RO_=
IDT=20
somewhere that doesn't truncate to NULL, and to put the GDT at a fixed addr=
ess=20
as well?



