Return-Path: <linux-kernel+bounces-17366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C7824C52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECA81C21AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA501FA5;
	Fri,  5 Jan 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pVxPiJn2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FA1C10
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40512YT6016561
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Jan 2024 17:02:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40512YT6016561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1704416555;
	bh=q8QKGt84aDPz/NrH2h2/49trV2VNrRxxZG7yzaVjy1k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pVxPiJn2+OpZfycZvXd/v+ZFHsjRIN+pzu+jOXXTFAC2uDmAQtF9MYOj8eJoaoHuk
	 h3atTBJm522v+pmyNiebDN0ZFD55IaLUmZMhPsVFtJp7EpXnyzax+vtfk6XVua42yP
	 CMRRjMvjxJYHY0cqjZ486BFpYL0fNFMS+mx6l46pMvofxdJmyXT5/OE5jl+rbJkBWf
	 9rDLFx9VfNLhU+Vkxpq5SvLML7MHacszhy3kCnyf/pw7LUiQjtONNX+sK7eMSicV3I
	 8J2BLjWNIWdBqAbgpezR35Z8jbyl3Wj3LwxxDG912/mVTlo+VvcKnvX6YwZd3zoYHD
	 vFJkwMT7WOF+A==
Date: Thu, 04 Jan 2024 17:02:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Elizabeth Figura <zfigura@codeweavers.com>,
        Sean Christopherson <seanjc@google.com>
CC: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        wine-devel@winehq.org
Subject: Re: x86 SGDT emulation for Wine
User-Agent: K-9 Mail for Android
In-Reply-To: <2451911.jE0xQCEvom@uriel>
References: <2285758.taCxCBeP46@uriel> <ZZV65qJuJ67E_n9O@google.com> <1C37C311-CF8A-44EC-89B5-D826EF458708@zytor.com> <2451911.jE0xQCEvom@uriel>
Message-ID: <B042BACA-839E-4A42-9BAA-AC7E58624250@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 3, 2024 10:35:28 PM PST, Elizabeth Figura <zfigura@codeweavers=
=2Ecom> wrote:
>On Wednesday, January 3, 2024 9:33:10 AM CST H=2E Peter Anvin wrote:
>> On January 3, 2024 7:19:02 AM PST, Sean Christopherson <seanjc@google=
=2Ecom>=20
>wrote:
>> >On Tue, Jan 02, 2024, Elizabeth Figura wrote:
>> >> On Wednesday, December 27, 2023 5:58:19 PM CST H=2E Peter Anvin wrot=
e:
>> >> > On December 27, 2023 2:20:37 PM PST, Elizabeth Figura=20
><zfigura@codeweavers=2Ecom> wrote:
>> >> > >Hello all,
>> >> > >
>> >> > >There is a Windows 98 program, a game called Nuclear Strike, whic=
h
>> >> > >wants to
>> >> > >do some amount of direct VGA access=2E Part of this is port I/O, =
which
>> >> > >naturally throws SIGILL that we can trivially catch and emulate i=
n
>> >> > >Wine=2E
>> >> > >The other part is direct access to the video memory at 0xa0000, w=
hich
>> >> > >in
>> >> > >general isn't a problem to catch and virtualize as well=2E
>> >> > >
>> >> > >However, this program is a bit creative about how it accesses tha=
t
>> >> > >memory;
>> >> > >instead of just writing to 0xa0000 directly, it looks up a segmen=
t
>> >> > >descriptor whose base is at 0xa0000 and then uses the %es overrid=
e to
>> >
>> >> > >write bytes=2E In pseudo-C, what it does is:
>> >=2E=2E=2E
>> >
>> >> > A prctl() to set the UMIP-emulated return values or disable it (gi=
ving
>> >> > SIGILL) would be easy enough=2E
>> >> >=20
>> >> > For the non-UMIP case, and probably for a lot of other corner case=
s
>> >> > like
>> >> > relying on certain magic selector values and what not, the best op=
tion
>> >> > really would be to wrap the code in a lightweight KVM container=2E=
 I do
>> >> > *not*
>> >> > mean running the Qemu user space part of KVM; instead have Wine
>> >> > interface
>> >> > with /dev/kvm directly=2E
>> >> >=20
>> >> > Non-KVM-capable hardware is basically historic at this point=2E
>> >>=20
>> >> Sorry for the late response=E2=80=94I've been trying to do research =
on what would
>> >> be necessary to use KVM (plus I made the poor choice of sending this
>> >> during the holiday season=2E=2E=2E)
>> >>=20
>> >> I'm concerned that KVM is going to be difficult or even intractable=
=2E Here
>> >> are some of the problems that I (perhaps incorrectly) understand:
>> >>=20
>> >> * As I am led to understand, there can only be one hypervisor on the
>> >> machine at a time,
>> >
>> >No=2E  Only one instance of KVM-the-module is allowed, but there is no
>> >arbitrary limit on the number of VMs that userspace can create=2E  The=
 only
>> >meaningful limitation is memory, and while struct kvm isn't tiny, it's=
 not
>> >_that_ big=2E>
>
>Ah, thanks for the correction=2E
>
>So if we're able to have one VM per thread, or one VM per process with on=
e=20
>vcpu per thread (but that one is capped at 1024 at least right now?), and=
 we=20
>don't risk running into any limits, that does make things a great deal ea=
sier=2E
>
>Still, as Stefan said, I don't know if using a hypervisor is going to be=
=20
>plausible for speed reasons=2E
>
>> >> and KVM has a hard limit on the number of vCPUs=2E
>> >>=20
>> >>   The obvious way to use KVM for Wine is to make each (guest) thread=
 a
>> >>   vCPU=2E
>> >>=20
>> >> That will, at the very least, run into the thread limit=2E In order =
to
>> >> avoid
>> >> that we'd need to ship a whole scheduler, which is concerning=2E Tha=
t's a
>> >> huge component to ship and a huge burden to keep updated=2E It also =
means
>> >> we need to hoist *all* of the ipc and sync code into the guest, whic=
h
>> >> will take an enormous amount of work=2E
>> >>=20
>> >>   Moreover, because there can only be one hypervisor, and Wine is a
>> >>   multi-
>> >>=20
>> >> process beast, that means that we suddenly need to throw every proce=
ss
>> >> into
>> >> the same VM=2E
>> >
>> >As above, this is wildly inaccurate=2E  The only KVM restriction with =
respect
>> >to processes is that a VM is bound to the process (address space) that
>> >created the VM=2E  There are no restrictions on the number of VMs that=
 can
>> >be created, e=2Eg=2E a single process can create multiple VMs=2E
>> >
>> >> That has unfortunate implications regarding isolation (it's been a d=
ream
>> >> for years that we'd be able to share a single wine "VM" between mult=
iple
>> >> users), it complicates memory management (though perhaps not terribl=
y?)=2E
>> >> And it means you can only have one Wine VM at a time, and can't use =
Wine
>> >> at the same time as a "real" VM, neither of which are restrictions t=
hat
>> >> currently exist=2E>>=20
>> >>   And it's not even like we can refactor=E2=80=94we'd have to rewrit=
e tons of
>> >>   code to
>> >>=20
>> >> work inside a VM, but also keep the old code around for the cases wh=
ere
>> >> we
>> >> don't have a VM and want to delegate scheduling to the host OS=2E
>> >>=20
>> >> * Besides scheduling, we need to exit the VM every time we would nor=
mally
>> >> call into Unix code, which in practice is every time that the
>> >> application does an NT syscall, or uses a library which we delegate =
to
>> >> the host (including e=2Eg=2E GPU, multimedia, audio=2E=2E=2E)
>> >
>> >Maybe I misinterpreted Peter's suggestion, but at least in my mind I w=
asn't
>> >thinking that the entire Wine process would run in a VM, but rather Wi=
ne
>> >would run just the "problematic" code in a VM=2E
>>=20
>> Yes, the idea would be that you would run the "problematic" code inside=
 a VM
>> *mapped 1:1 with the external address space*, i=2Ee=2E use KVM simply a=
s a
>> special execution mode to give you more control of the fine grained mac=
hine
>> state like the GDT=2E The code that you don't want executed in the VM c=
ontext
>> simply leave unmapped in the VM page tables and set up #PF to always ex=
it
>> the VM context=2E
>
>So yes, as long as we *can* organize things such that we exit the hypervi=
sor=20
>every time we want to call into Unix code, then that's feasible=2E We hav=
e a=20
>well-defined break between Windows and Unix code and it wouldn't be=20
>inordinately difficult to shove the VM exit into that break=2E My concern=
 was=20
>that limitations on the number of VMs or vCPUs we can create would preven=
t us=20
>from doing that, and effectively require us to implement a lot more insid=
e the=20
>VM, but as I understand that's not actually a problem=2E
>
>That still leaves the question of performance though=2E If having to exit=
 the VM=20
>that often for performance reasons isn't feasible, then that's still goin=
g to=20
>force us to implement from scratch an inordinate amount of kernel/library=
 code=20
>inside the VM just to avoid the transition=2E Or, more likely, conclude t=
hat a=20
>hypervisor just isn't going to work for us=2E
>
>
>I'm not at all familiar with the arch code, and I'm sure I'm not asking=
=20
>anything interesting, but is it really impossible to put CPU_ENTRY_AREA_R=
O_IDT=20
>somewhere that doesn't truncate to NULL, and to put the GDT at a fixed ad=
dress=20
>as well?
>
>
>

Putting the GDT at a fixed address is pretty much a no-go for a variety of=
 reasons=2E As I said, a prctl() to specify the desired return information =
*on UMIP-capable hardware* is certainly doable=2E However, it does not addr=
ess things like fixed selectors that have come up=2E

Note that there is no fundamental reason you cannot run the Unix user spac=
e code inside the VM container, too; you only need to vmexit on an actual s=
ystem call=2E KVM might be able to assist there by providing a "short-circu=
it mode", allowing a system call vmexit to invoke the system call directly =
rather than having to bounce back to user space =E2=80=93 twice=2E

I have to say I'm really impressed how far Wine has come that this level o=
f compatibility are now on the radar screen=2E

Now, in the case this is a single application that is no longer being upda=
ted, then there is of course the BFI solution of detecting the app and patc=
hing the relevant code=2E For an application that *is* updated, it might be=
 possible to reach out to the developer (and/or Steam, if applicable) and h=
elp them making their code compatible while fulilling their direct objectiv=
es=2E



