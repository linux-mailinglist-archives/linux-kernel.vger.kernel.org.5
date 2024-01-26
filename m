Return-Path: <linux-kernel+bounces-40465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6C83E0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DF61F25B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF782208A7;
	Fri, 26 Jan 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="fx2AmksZ"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F8200B8;
	Fri, 26 Jan 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292057; cv=none; b=QAcqKBezHoXRig75grzkmacYIHtKWZ2K4tyMOk1dKiK0KQmHr3rqJWX/9gQez2paQHuhom1E69ph97hmSIPtnaUKzu1nVaoh3r9dexMpGZRk1imtcgRfwJpUX41A/VtyPf72vrBTZUp46/cK8GmdvTIta59DkCbpEoWWSrhN3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292057; c=relaxed/simple;
	bh=66yodsV9kY5hG2qOgHS8Pb9bSZO6F5IF9GXK6+EyybI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6Vm1Yz1KaXUUpZXpaagFPIOM30FjNw1Wq+jMTCumIdYwWwYvjBF5rgIQ2HiBK+NUuI/ewsjzIiHat2yEo80Hnvx+xospIj2nDeapYPUC6STl7oc9MYh+tnAlrKrJLOd2inB4Jvp1FHIvgeZj09+E/J9TmgBhGRTvDZV1tEPWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=fx2AmksZ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706292053;
	bh=66yodsV9kY5hG2qOgHS8Pb9bSZO6F5IF9GXK6+EyybI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fx2AmksZ45YocPyRDDniQVgwE/nLVkgdMormYw2A5hRgg6507JyJSV0veB8kasy3n
	 27cS70Yx+MU+0VEaLKa7FVXDTbE4oGVDecGctsrZ9XA56yjz2A12SDfndsfqH5OMD3
	 0sZ8MBJ0Lu3pS9wwuCJsC7BylpcfrqCf2EmpD3Eo=
Received: from [IPv6:240e:358:1181:9d00:dc73:854d:832e:3] (unknown [IPv6:240e:358:1181:9d00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C9599669BB;
	Fri, 26 Jan 2024 13:00:50 -0500 (EST)
Message-ID: <75779311d0ee527c95bcb6170c4490520d0548fd.camel@xry111.site>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
From: Xi Ruoyao <xry111@xry111.site>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, "linux-mips@vger.kernel.org"
	 <linux-mips@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Bogendoerfer
	 <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org, 
	regressions@lists.linux.dev
Date: Sat, 27 Jan 2024 02:00:47 +0800
In-Reply-To: <1e1ec730efc58f17ecf008a4600321e3d200ebda.camel@xry111.site>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
	 <4b715c9f-6a9e-4496-8810-670080cb715a@app.fastmail.com>
	 <1e1ec730efc58f17ecf008a4600321e3d200ebda.camel@xry111.site>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 20:58 +0800, Xi Ruoyao wrote:
> On Fri, 2024-01-26 at 12:33 +0000, Jiaxun Yang wrote:
> >=20
> >=20
> > =E5=9C=A82024=E5=B9=B41=E6=9C=8824=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=
=E5=8D=8810:42=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> > > Hi,
> > >=20
> > > When I'm testing Glibc master branch for upcoming 2.39 release, I
> > > noticed an alarming test failure on mips64el:
> >=20
> > So apparently it should be tracked as a regression.
> >=20
> > #regzbot ^introduced 4bce37a68ff884e821a02a731897a8119e0c37b7
> >=20
> > Should we revert it for now?
>=20
> I'd say "yes" if we cannot easily patch instruction_pointer() to handle
> delay slot.=C2=A0 Anyway the reversion will be a MIPS-only change.

Phew.  Just tried it and:

arch/mips/mm/fault.c: In function =E2=80=98__do_page_fault=E2=80=99:
arch/mips/mm/fault.c:111:26: error: passing argument 1 of =E2=80=98expand_s=
tack=E2=80=99 from incompatible pointer type [-Werror=3Dincompatible-pointe=
r-types]
  111 |         if (expand_stack(vma, address))
      |                          ^~~
      |                          |
      |                          struct vm_area_struct *
In file included from ./include/linux/pid_namespace.h:7,
                 from ./include/linux/ptrace.h:10,
                 from arch/mips/mm/fault.c:16:
/include/linux/mm.h:3431:56: note: expected =E2=80=98struct mm_struct *=E2=
=80=99 but argument is of type =E2=80=98struct vm_area_struct *=E2=80=99
 3431 | struct vm_area_struct *expand_stack(struct mm_struct * mm, unsigned=
 long addr);
      |                                     ~~~~~~~~~~~~~~~~~~~^~
cc1: some warnings being treated as errors

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

