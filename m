Return-Path: <linux-kernel+bounces-40110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26FC83DA67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312D41C20E46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70D1B807;
	Fri, 26 Jan 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="D4WfYUJx"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5D1B5B2;
	Fri, 26 Jan 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273912; cv=none; b=sUvWX+PHReL8/gUKZ1kAKxlnkf4y+EWCatS73SxmjF1UeDa7X+DA29USWR9KYon3KYIp1WPf3XeCet+xUBpvGiFhR5AF2ZOadzFfwR0qh4m+kfwrpcednxgGRRdRGn/vc3AnnYdy9d2yvIAXUbCiaM3yUy0AuO8g6Bn0g70+I8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273912; c=relaxed/simple;
	bh=eiX/XU3X7izRhpQ8i5uryQdr0UqEctOorWGygOsy5UI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEGcu9gMIVkmycLRZ60Zg+7XovAThmg/vT91L3eG8F9NohFLsNobxG77rmziOQ3xkU6DkND/QOM7+eVSPuktouV5ccV3JI+epdtx50AYik1bc6kfhSE+2LO/G2WtqEp3oS5OGeQLLUHtr+CILmXAm2l7+swcFE7G0nePcu6Mi/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=D4WfYUJx; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706273902;
	bh=eiX/XU3X7izRhpQ8i5uryQdr0UqEctOorWGygOsy5UI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D4WfYUJxkj8nZVD4yhBt2yM509Q7H7i3L4lt2HkzVsFXGjr7Ym6NyVpBpxWbUIzUc
	 Lf9+rphGsCNs2TLwLbd4L9qrK9iYA/ywuvShsS1ljItoMjcaRslcj6h6v0SVE4i3AL
	 Ne8o4mxQzY0WmlS1J9gC3nuoiVBONKUzUufqgg0I=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7C67F6690B;
	Fri, 26 Jan 2024 07:58:18 -0500 (EST)
Message-ID: <1e1ec730efc58f17ecf008a4600321e3d200ebda.camel@xry111.site>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
From: Xi Ruoyao <xry111@xry111.site>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, "linux-mips@vger.kernel.org"
	 <linux-mips@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Bogendoerfer
	 <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org, 
	regressions@lists.linux.dev
Date: Fri, 26 Jan 2024 20:58:16 +0800
In-Reply-To: <4b715c9f-6a9e-4496-8810-670080cb715a@app.fastmail.com>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
	 <4b715c9f-6a9e-4496-8810-670080cb715a@app.fastmail.com>
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

On Fri, 2024-01-26 at 12:33 +0000, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B41=E6=9C=8824=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=
=E5=8D=8810:42=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >=20
> > When I'm testing Glibc master branch for upcoming 2.39 release, I
> > noticed an alarming test failure on mips64el:
>=20
> So apparently it should be tracked as a regression.
>=20
> #regzbot ^introduced 4bce37a68ff884e821a02a731897a8119e0c37b7
>=20
> Should we revert it for now?

I'd say "yes" if we cannot easily patch instruction_pointer() to handle
delay slot.  Anyway the reversion will be a MIPS-only change.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

