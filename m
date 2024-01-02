Return-Path: <linux-kernel+bounces-14784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5AF82224C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44B41F23360
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0915EBD;
	Tue,  2 Jan 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="NEKMyD8I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753115EA3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:To:From:Cc:Sender;
	bh=ry5FtHp9KdCzZFfH2yaJs2qqRv4eGjPod+PeIP9cMyQ=; b=NEKMyD8IHvpbpM2qxO/gZUV38q
	LMN4C4VRyaGfb2ucj/s4JtrGes6B1+0TMRUXMkwUOjMvJaF7CfpfJKflvIawcavIyv0Zsce6+K7bT
	eUz4lraSeC4r/dMCS/xfXmFK0QIcwPAxM8WRbAJcR+5wguFEqjN7mK5+47oAFj7J/WUr22VXaZCCd
	PDxoldU+uNABKJPBa9bh34BhH7X93vb3Q68xB4a7mAvC44Eth5yCmkhfumMdATIAU26OVtAVHGpRk
	r5n8bWwFYgNOUoMaRQa3LxJuC5OqksKtFGDm3Q1b3JuBA9AHUHsXNEFr7P37fpDXMuvoO4McrnF+d
	vBHGmAnA==;
Received: from [10.69.139.8] (helo=uriel.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rKkpO-009RyD-2i;
	Tue, 02 Jan 2024 13:53:31 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: x86 SGDT emulation for Wine
Date: Tue, 02 Jan 2024 13:53:26 -0600
Message-ID: <3207569.5fSG56mABF@uriel>
In-Reply-To: <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com>
References:
 <2285758.taCxCBeP46@uriel> <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, December 27, 2023 5:58:19 PM CST H. Peter Anvin wrote:
> On December 27, 2023 2:20:37 PM PST, Elizabeth Figura=20
<zfigura@codeweavers.com> wrote:
> >Hello all,
> >
> >There is a Windows 98 program, a game called Nuclear Strike, which wants=
 to
> >do some amount of direct VGA access. Part of this is port I/O, which
> >naturally throws SIGILL that we can trivially catch and emulate in Wine.
> >The other part is direct access to the video memory at 0xa0000, which in
> >general isn't a problem to catch and virtualize as well.
> >
> >However, this program is a bit creative about how it accesses that memor=
y;
> >instead of just writing to 0xa0000 directly, it looks up a segment
> >descriptor whose base is at 0xa0000 and then uses the %es override to
> >write bytes. In pseudo-C, what it does is:
> >
> >int get_vga_selector()
> >{
> >
> >    sgdt(&gdt_size, &gdt_ptr);
> >    sldt(&ldt_segment);
> >    ++gdt_size;
> >    descriptor =3D gdt_ptr;
> >    while (descriptor->base !=3D 0xa0000)
> >    {
> >   =20
> >        ++descriptor;
> >        gdt_size -=3D sizeof(*descriptor);
> >        if (!gdt_size)
> >       =20
> >            break;
> >   =20
> >    }
> >   =20
> >    if (gdt_size)
> >   =20
> >        return (descriptor - gdt_ptr) << 3;
> >   =20
> >    descriptor =3D gdt_ptr[ldt_segment >> 3]->base;
> >    ldt_size =3D gdt_ptr[ldt_segment >> 3]->limit + 1;
> >    while (descriptor->base !=3D 0xa0000)
> >    {
> >   =20
> >        ++descriptor;
> >        ldt_size -=3D sizeof(*descriptor);
> >        if (!ldt_size)
> >       =20
> >            break;
> >   =20
> >    }
> >   =20
> >    if (ldt_size)
> >   =20
> >        return (descriptor - ldt_ptr) << 3;
> >   =20
> >    return 0;
> >
> >}
> >
> >
> >Currently we emulate IDT access. On a read fault, we execute sidt
> >ourselves, check if the read address falls within the IDT, and return so=
me
> >dummy data from the exception handler if it does [1]. We can easily enou=
gh
> >implement GDT access as well this way, and there is even an out-of-tree
> >patch written some years ago that does this, and helps the game run.
> >
> >However, there are two problems that I have observed or anticipated:
> >
> >(1) On systems with UMIP, the kernel emulates sgdt instructions and retu=
rns
> >a consistent address which we can guarantee is invalid. However, it also
> >returns a size of zero. The program doesn't expect this (cf. the way the
> >loop is written above) and I believe will effectively loop forever in th=
at
> >case, or until it finds the VGA selector or hits invalid memory.
> >
> >    I see two obvious ways to fix this: either adjust the size of the fa=
ke
> >
> >kernel GDT, or provide a switch to stop emulating and let Wine handle it.
> >The latter may very well a more sustainable option in the long term
> >(although I'll admit I can't immediately come up with a reason why, other
> >than "we might need to raise the size yet again".)
> >
> >    Does anyone have opinions on this particular topic? I can look into
> >
> >writing a patch but I'm not sure what the best approach is.
> >
> >(2) On 64-bit systems without UMIP, sgdt returns a truncated address when
> >in 32-bit mode. This truncated address in practice might point anywhere =
in
> >the address space, including to valid memory.
> >
> >    In order to fix this, we would need the kernel to guarantee that the
> >    GDT
> >
> >base points to an address whose bottom 32 bits we can guarantee are
> >inaccessible. This is relatively easy to achieve ourselves by simply
> >mapping those pages as noaccess, but it also means that those pages can't
> >overlap something we need; we already go to pains to make sure that
> >certain parts of the address space are free. Broadly anything above the =
2G
> >boundary *should* be okay though. Is this feasible?
> >
> >    We could also just decide we don't care about systems without UMIP, =
but
> >
> >that seems a bit unfortunate; it's not that old of a feature. But I also
> >have no idea how hard it would be to make this kind of a guarantee on the
> >kernel side.
> >
> >    This is also, theoretically, a problem for the IDT, except that on t=
he
> >
> >machines I've tested, the IDT is always at 0xfffffe0000000000. That's not
> >great either (it's certainly caused some weirdness and confusion when
> >debugging, when we unexpectedly catch an unrelated null pointer access) =
but
> >it seems to work in practice.
> >
> >--Zeb
> >
> >[1] https://source.winehq.org/git/wine.git/blob/HEAD:/dlls/krnl386.exe16/
> >instr.c#l702
>=20
> A prctl() to set the UMIP-emulated return values or disable it (giving
> SIGILL) would be easy enough.
>=20
> For the non-UMIP case, and probably for a lot of other corner cases like
> relying on certain magic selector values and what not, the best option
> really would be to wrap the code in a lightweight KVM container. I do *no=
t*
> mean running the Qemu user space part of KVM; instead have Wine interface
> with /dev/kvm directly.
>=20
> Non-KVM-capable hardware is basically historic at this point.

Sorry for the late response=E2=80=94I've been trying to do research on what=
 would be=20
necessary to use KVM (plus I made the poor choice of sending this during th=
e=20
holiday season...)

I'm concerned that KVM is going to be difficult or even intractable. Here a=
re=20
some of the problems that I (perhaps incorrectly) understand:

* As I am led to understand, there can only be one hypervisor on the machin=
e=20
at a time, and KVM has a hard limit on the number of vCPUs.

  The obvious way to use KVM for Wine is to make each (guest) thread a vCPU=
=2E=20
That will, at the very least, run into the thread limit. In order to avoid=
=20
that we'd need to ship a whole scheduler, which is concerning. That's a hug=
e=20
component to ship and a huge burden to keep updated. It also means we need =
to=20
hoist *all* of the ipc and sync code into the guest, which will take an=20
enormous amount of work.

  Moreover, because there can only be one hypervisor, and Wine is a multi-
process beast, that means that we suddenly need to throw every process into=
=20
the same VM. That has unfortunate implications regarding isolation (it's be=
en=20
a dream for years that we'd be able to share a single wine "VM" between=20
multiple users), it complicates memory management (though perhaps not=20
terribly?). And it means you can only have one Wine VM at a time, and can't=
=20
use Wine at the same time as a "real" VM, neither of which are restrictions=
=20
that currently exist.

  And it's not even like we can refactor=E2=80=94we'd have to rewrite tons =
of code to=20
work inside a VM, but also keep the old code around for the cases where we=
=20
don't have a VM and want to delegate scheduling to the host OS.

* Besides scheduling, we need to exit the VM every time we would normally c=
all=20
into Unix code, which in practice is every time that the application does a=
n=20
NT syscall, or uses a library which we delegate to the host (including e.g.=
=20
GPU, multimedia, audio...)

  I'm concerned that this will be very expensive. Most VM users don't need =
to=20
exit on every syscall. While I haven't tested KVM, I think some other Wine=
=20
developers actually did a similar experiment using a hypervisor to solve so=
me=20
other problem (related to 32-bit support on Mac OS), and exiting the=20
hypervisor was prohibitively slow.

  Alternatively we ship *more* components to reimplement these things insid=
e=20
the VM (e.g. virgl/venus for GPU hardware, other virtio bits for interactin=
g=20
with e.g. multimedia hardware? enough of a cache to make block I/O reasonab=
ly=20
fast, a few layers of networking code...), which looks more and more ugly.

If nothing else, it's a huge hammer to fix this one problem for an applicat=
ion=20
which doesn't even currently work in Wine, *and* which isn't even a problem=
 on=20
sufficiently new hardware (and to fix other GDT problems which are only=20
theoretical at this point.)

=2D-Zeb



