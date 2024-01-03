Return-Path: <linux-kernel+bounces-15706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB78230A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3049E1F2487A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE11C68C;
	Wed,  3 Jan 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aqweOPi0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28FA1C683
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 403FXFDW3589428
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Jan 2024 07:33:15 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 403FXFDW3589428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1704295996;
	bh=oRFRY7ymFYRPfb4uY5/cZy3nbPYtAymysIGmROa2vNE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=aqweOPi00UvcD0DrS4eZjkaUGr0S46AytMU0bAOz9brI4XMB5Uys6EMK1xzGQ4sIb
	 CrNNqmn/ybfagyAeT0WGetmQQvFm3tzBf4DJpk4cjt4kSXY+W3Z0VHg60oumLSzNjZ
	 +cxOkICPxTU1uu1glsqS6zMisDCv1nHjXZKfjYG21WEpSLQDADkURBBqUY/CsNAlAh
	 ZublkcIGh5+viNmyZpekrh5UkSEI6kYsRCX1oRf/fze8e1bMjo2YRRzppfvrbiOVXr
	 h552wHDz6OZdhRnupALQuwgA6CQEA6/wVD6HaLv4mVO8NvYi0T9JGj8coIIS2Tqi3D
	 GDeh42ydvQnSw==
Date: Wed, 03 Jan 2024 07:33:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sean Christopherson <seanjc@google.com>,
        Elizabeth Figura <zfigura@codeweavers.com>
CC: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        wine-devel@winehq.org
Subject: Re: x86 SGDT emulation for Wine
User-Agent: K-9 Mail for Android
In-Reply-To: <ZZV65qJuJ67E_n9O@google.com>
References: <2285758.taCxCBeP46@uriel> <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com> <3207569.5fSG56mABF@uriel> <ZZV65qJuJ67E_n9O@google.com>
Message-ID: <1C37C311-CF8A-44EC-89B5-D826EF458708@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 3, 2024 7:19:02 AM PST, Sean Christopherson <seanjc@google=2Ecom=
> wrote:
>On Tue, Jan 02, 2024, Elizabeth Figura wrote:
>> On Wednesday, December 27, 2023 5:58:19 PM CST H=2E Peter Anvin wrote:
>> > On December 27, 2023 2:20:37 PM PST, Elizabeth Figura <zfigura@codewe=
avers=2Ecom> wrote:
>> > >Hello all,
>> > >
>> > >There is a Windows 98 program, a game called Nuclear Strike, which w=
ants to
>> > >do some amount of direct VGA access=2E Part of this is port I/O, whi=
ch
>> > >naturally throws SIGILL that we can trivially catch and emulate in W=
ine=2E
>> > >The other part is direct access to the video memory at 0xa0000, whic=
h in
>> > >general isn't a problem to catch and virtualize as well=2E
>> > >
>> > >However, this program is a bit creative about how it accesses that m=
emory;
>> > >instead of just writing to 0xa0000 directly, it looks up a segment
>> > >descriptor whose base is at 0xa0000 and then uses the %es override t=
o
>> > >write bytes=2E In pseudo-C, what it does is:
>
>=2E=2E=2E
>
>> > A prctl() to set the UMIP-emulated return values or disable it (givin=
g
>> > SIGILL) would be easy enough=2E
>> >=20
>> > For the non-UMIP case, and probably for a lot of other corner cases l=
ike
>> > relying on certain magic selector values and what not, the best optio=
n
>> > really would be to wrap the code in a lightweight KVM container=2E I =
do *not*
>> > mean running the Qemu user space part of KVM; instead have Wine inter=
face
>> > with /dev/kvm directly=2E
>> >=20
>> > Non-KVM-capable hardware is basically historic at this point=2E
>>=20
>> Sorry for the late response=E2=80=94I've been trying to do research on =
what would be=20
>> necessary to use KVM (plus I made the poor choice of sending this durin=
g the=20
>> holiday season=2E=2E=2E)
>>=20
>> I'm concerned that KVM is going to be difficult or even intractable=2E =
Here are=20
>> some of the problems that I (perhaps incorrectly) understand:
>>=20
>> * As I am led to understand, there can only be one hypervisor on the ma=
chine=20
>> at a time,
>
>No=2E  Only one instance of KVM-the-module is allowed, but there is no ar=
bitrary
>limit on the number of VMs that userspace can create=2E  The only meaning=
ful
>limitation is memory, and while struct kvm isn't tiny, it's not _that_ bi=
g=2E
>
>> and KVM has a hard limit on the number of vCPUs=2E
>>
>>   The obvious way to use KVM for Wine is to make each (guest) thread a =
vCPU=2E=20
>> That will, at the very least, run into the thread limit=2E In order to =
avoid=20
>> that we'd need to ship a whole scheduler, which is concerning=2E That's=
 a huge=20
>> component to ship and a huge burden to keep updated=2E It also means we=
 need to=20
>> hoist *all* of the ipc and sync code into the guest, which will take an=
=20
>> enormous amount of work=2E
>>=20
>>   Moreover, because there can only be one hypervisor, and Wine is a mul=
ti-
>> process beast, that means that we suddenly need to throw every process =
into=20
>> the same VM=2E
>
>As above, this is wildly inaccurate=2E  The only KVM restriction with res=
pect to
>processes is that a VM is bound to the process (address space) that creat=
ed the
>VM=2E  There are no restrictions on the number of VMs that can be created=
, e=2Eg=2E a
>single process can create multiple VMs=2E
>
>> That has unfortunate implications regarding isolation (it's been a drea=
m for
>> years that we'd be able to share a single wine "VM" between multiple us=
ers),
>> it complicates memory management (though perhaps not terribly?)=2E And =
it means
>> you can only have one Wine VM at a time, and can't use Wine at the same=
 time
>> as a "real" VM, neither of which are restrictions that currently exist=
=2E
>>=20
>>   And it's not even like we can refactor=E2=80=94we'd have to rewrite t=
ons of code to=20
>> work inside a VM, but also keep the old code around for the cases where=
 we=20
>> don't have a VM and want to delegate scheduling to the host OS=2E
>>=20
>> * Besides scheduling, we need to exit the VM every time we would normal=
ly call=20
>> into Unix code, which in practice is every time that the application do=
es an=20
>> NT syscall, or uses a library which we delegate to the host (including =
e=2Eg=2E=20
>> GPU, multimedia, audio=2E=2E=2E)
>
>Maybe I misinterpreted Peter's suggestion, but at least in my mind I wasn=
't thinking
>that the entire Wine process would run in a VM, but rather Wine would run=
 just
>the "problematic" code in a VM=2E
>

Yes, the idea would be that you would run the "problematic" code inside a =
VM *mapped 1:1 with the external address space*, i=2Ee=2E use KVM simply as=
 a special execution mode to give you more control of the fine grained mach=
ine state like the GDT=2E The code that you don't want executed in the VM c=
ontext simply leave unmapped in the VM page tables and set up #PF to always=
 exit the VM context=2E

