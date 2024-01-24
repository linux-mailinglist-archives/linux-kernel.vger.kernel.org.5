Return-Path: <linux-kernel+bounces-37762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DB83B4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F971C23621
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78CC135A77;
	Wed, 24 Jan 2024 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="HT3nftoI"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD21350FE;
	Wed, 24 Jan 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136145; cv=none; b=BceZ0GCewftKxNIpIBsb7mQPnDad28sw9tZN86t9sj2vG5qJo7O7AKuLKkGVp2A6eRavgPLgZGqK3pWNHrh8V6JBTXUc5gdxu2YZAauv66p3PlLxfv5cPSyi7AyaxvBUE8S6g1DAf9z0NIVKV+A2Yl/qDtpBXHJBAT8Gl0+uQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136145; c=relaxed/simple;
	bh=KoXSSJKPTYYexPum4KDiT/NOY0PKY796Tu6U+oEogvs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4mkcZpAvG2SzV3MKl4JWfHsc95zqPUBbJfVEZMSdE+u7h4UM70gUQcSbAnBXDa3fsc10Q0DbSbAjlHN8lP0o5W/D16rKGwICFH4ZzfaI44OMxdcAQgBbYfUB4JA/lf2z53Cvcjr9Bpc8mIxXj/wN0HTFsF9cKUSsy1MALreHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=HT3nftoI; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706136140;
	bh=KoXSSJKPTYYexPum4KDiT/NOY0PKY796Tu6U+oEogvs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HT3nftoIFNbvvj4mMEhW6fqY2/MfM9lUqtRu6Xke7kZ1t99GRzaRpYvK4GEpQioj2
	 U3ALuTFrDXaDvM/JLOCU7AnG4Nyiy8VbCH4AuAskhsZzaIH0SN9xAQ3MQ8ETu2TnjD
	 ZSJzQK8QA9IL9bIzh8HYDVyTfNyDcntHpWpxlUOU=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 266F766F42;
	Wed, 24 Jan 2024 17:42:18 -0500 (EST)
Message-ID: <41f026468cc70abad5e6500657953f5ef575ac81.camel@xry111.site>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
From: Xi Ruoyao <xry111@xry111.site>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Schwab <schwab@suse.de>, Ben Hutchings <ben@decadent.org.uk>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
  libc-alpha@sourceware.org
Date: Thu, 25 Jan 2024 06:42:17 +0800
In-Reply-To: <CAHk-=whkEXGOCEZFO2vAZ9rDd8uW8MJwFNYg9KXaC_vZVso6iA@mail.gmail.com>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
	 <mvmplxraqmd.fsf@suse.de>
	 <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
	 <0be1203c9df55432548c92281c8392dfa2f7d6bf.camel@xry111.site>
	 <e8583a3ab0522b4e75ba0ada47b6f093b186fa81.camel@xry111.site>
	 <CAHk-=wgVrw+8P68Sy2krcc3QFbm_eu_DRs0-i7mct_0BDORZuA@mail.gmail.com>
	 <CAHk-=whkEXGOCEZFO2vAZ9rDd8uW8MJwFNYg9KXaC_vZVso6iA@mail.gmail.com>
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

On Wed, 2024-01-24 at 14:10 -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 13:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >=20
> >=20
> > And I think the "fails with any integer in [1, 8)" is because the MIPS
> > "copy_from_user()" code is likely doing something special for those
> > small copies.
>=20
> .Lcopy_bytes_checklen\@: does COPY_BYTE(0) for the first access, which is
>=20
> #define COPY_BYTE(N)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOADB(t0, N(src), .Ll_exc\@);=
=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SUB=C2=A0=C2=A0=C2=A0=C2=A0 le=
n, len, 1;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beqz=C2=A0=C2=A0=C2=A0 len, .L=
done\@;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STOREB(t0, N(dst), .Ls_exc_p1\=
@)
>=20
> so yeah, for 'copy_to_user()" (which is what that "read (fd, buf, 7)"
> will do, we have that user space write ("STOREB()") in the branch
> delay slot of the length test.
>=20
> So that matches.
>=20
> And it only fails when
>=20
> =C2=A0(a) you're unlucky, and that stack buffer
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[16] =3D {=
};
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 happens to be just under the last page that has =
been accessed, so
> you get a page fault
>=20
> =C2=A0(b) you hit a mmap_sem already being locked, presumably because
> another thread is doing that fork().

So I added a stupid hack:

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..e663eb517bbf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -92,6 +92,12 @@
 #include "internal.h"
 #include "swap.h"
=20
+#ifdef __mips__
+#include "asm/branch.h"
+#undef instruction_pointer
+#define instruction_pointer(x) exception_epc(x)
+#endif
+
 #if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST=
)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame fo=
r last_cpupid.
 #endif

and it indeed "solved" the problem.

> Anyway, I'm pretty sure this is the bug, now some MIPS person just
> needs to fix the MIPS version of "instruction_pointer()" to do what
> "exception_epc()" already does.

Agree.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

