Return-Path: <linux-kernel+bounces-12311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EF081F344
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1562B21FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03470498B7;
	Wed, 27 Dec 2023 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tD12LFMf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F44988B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BRNwL0j860069
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 27 Dec 2023 15:58:22 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BRNwL0j860069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1703721502;
	bh=HGhnbKKkTHs2u5EQArDGNu1pMtU/2ik4/wYCHWpvWmc=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=tD12LFMf+7NXWO76B01kcy47u1v+Kb3Ud8gHXZ/FK5UznkF7owdATWlj17uhbVdWy
	 A+L8M+HlBLyED1XB9j65r2Zn9f3ssMJmP3OX1xTfTGVAYUC7RU9qihNcH4JB9VDI9p
	 eqTqo4q1rZP8tdP0Q/jAcBOaB5Pj4mSuUIRXqLgyswBaFLntGpM+zsWaR1ydVOe0Lu
	 HHx+k2FXgODIcBsZCsNswE+qSxFOZM2OUPihjIuPoM09Wy4jki7oY9/sY5gBK51W6l
	 pfZwbjKN40RKKEVgXTouwzZrVwYkdp5gs1yKhXyJPHpHGpgrqP0hmA9JcO6LX7owUf
	 bI9VJDFHxF4iQ==
Date: Wed, 27 Dec 2023 15:58:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Elizabeth Figura <zfigura@codeweavers.com>, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        wine-devel@winehq.org
Subject: Re: x86 SGDT emulation for Wine
User-Agent: K-9 Mail for Android
In-Reply-To: <2285758.taCxCBeP46@uriel>
References: <2285758.taCxCBeP46@uriel>
Message-ID: <868D3980-3323-4E4A-8A7A-B9C26F123A1E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 27, 2023 2:20:37 PM PST, Elizabeth Figura <zfigura@codeweavers=
=2Ecom> wrote:
>Hello all,
>
>There is a Windows 98 program, a game called Nuclear Strike, which wants =
to do=20
>some amount of direct VGA access=2E Part of this is port I/O, which natur=
ally=20
>throws SIGILL that we can trivially catch and emulate in Wine=2E The othe=
r part=20
>is direct access to the video memory at 0xa0000, which in general isn't a=
=20
>problem to catch and virtualize as well=2E
>
>However, this program is a bit creative about how it accesses that memory=
;=20
>instead of just writing to 0xa0000 directly, it looks up a segment descri=
ptor=20
>whose base is at 0xa0000 and then uses the %es override to write bytes=2E=
 In=20
>pseudo-C, what it does is:
>
>int get_vga_selector()
>{
>    sgdt(&gdt_size, &gdt_ptr);
>    sldt(&ldt_segment);
>    ++gdt_size;
>    descriptor =3D gdt_ptr;
>    while (descriptor->base !=3D 0xa0000)
>    {
>        ++descriptor;
>        gdt_size -=3D sizeof(*descriptor);
>        if (!gdt_size)
>            break;
>    }
>
>    if (gdt_size)
>        return (descriptor - gdt_ptr) << 3;
>
>    descriptor =3D gdt_ptr[ldt_segment >> 3]->base;
>    ldt_size =3D gdt_ptr[ldt_segment >> 3]->limit + 1;
>    while (descriptor->base !=3D 0xa0000)
>    {
>        ++descriptor;
>        ldt_size -=3D sizeof(*descriptor);
>        if (!ldt_size)
>            break;
>    }
>
>    if (ldt_size)
>        return (descriptor - ldt_ptr) << 3;
>
>    return 0;
>}
>
>
>Currently we emulate IDT access=2E On a read fault, we execute sidt ourse=
lves,=20
>check if the read address falls within the IDT, and return some dummy dat=
a=20
>from the exception handler if it does [1]=2E We can easily enough impleme=
nt GDT=20
>access as well this way, and there is even an out-of-tree patch written s=
ome=20
>years ago that does this, and helps the game run=2E
>
>However, there are two problems that I have observed or anticipated:
>
>(1) On systems with UMIP, the kernel emulates sgdt instructions and retur=
ns a=20
>consistent address which we can guarantee is invalid=2E However, it also =
returns=20
>a size of zero=2E The program doesn't expect this (cf=2E the way the loop=
 is=20
>written above) and I believe will effectively loop forever in that case, =
or=20
>until it finds the VGA selector or hits invalid memory=2E
>
>    I see two obvious ways to fix this: either adjust the size of the fak=
e=20
>kernel GDT, or provide a switch to stop emulating and let Wine handle it=
=2E The=20
>latter may very well a more sustainable option in the long term (although=
 I'll=20
>admit I can't immediately come up with a reason why, other than "we might=
 need=20
>to raise the size yet again"=2E)
>
>    Does anyone have opinions on this particular topic? I can look into=
=20
>writing a patch but I'm not sure what the best approach is=2E
>
>(2) On 64-bit systems without UMIP, sgdt returns a truncated address when=
 in=20
>32-bit mode=2E This truncated address in practice might point anywhere in=
 the=20
>address space, including to valid memory=2E
>
>    In order to fix this, we would need the kernel to guarantee that the =
GDT=20
>base points to an address whose bottom 32 bits we can guarantee are=20
>inaccessible=2E This is relatively easy to achieve ourselves by simply ma=
pping=20
>those pages as noaccess, but it also means that those pages can't overlap=
=20
>something we need; we already go to pains to make sure that certain parts=
 of=20
>the address space are free=2E Broadly anything above the 2G boundary *sho=
uld* be=20
>okay though=2E Is this feasible?
>
>    We could also just decide we don't care about systems without UMIP, b=
ut=20
>that seems a bit unfortunate; it's not that old of a feature=2E But I als=
o have=20
>no idea how hard it would be to make this kind of a guarantee on the kern=
el=20
>side=2E
>
>    This is also, theoretically, a problem for the IDT, except that on th=
e=20
>machines I've tested, the IDT is always at 0xfffffe0000000000=2E That's n=
ot=20
>great either (it's certainly caused some weirdness and confusion when=20
>debugging, when we unexpectedly catch an unrelated null pointer access) b=
ut it=20
>seems to work in practice=2E
>
>--Zeb
>
>[1] https://source=2Ewinehq=2Eorg/git/wine=2Egit/blob/HEAD:/dlls/krnl386=
=2Eexe16/
>instr=2Ec#l702
>
>

A prctl() to set the UMIP-emulated return values or disable it (giving SIG=
ILL) would be easy enough=2E

For the non-UMIP case, and probably for a lot of other corner cases like r=
elying on certain magic selector values and what not, the best option reall=
y would be to wrap the code in a lightweight KVM container=2E I do *not* me=
an running the Qemu user space part of KVM; instead have Wine interface wit=
h /dev/kvm directly=2E

Non-KVM-capable hardware is basically historic at this point=2E

