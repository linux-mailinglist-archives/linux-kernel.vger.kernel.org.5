Return-Path: <linux-kernel+bounces-37313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACBF83AE21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AE81F25032
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917D7E770;
	Wed, 24 Jan 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="eXRZqweJ"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C757E565;
	Wed, 24 Jan 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112836; cv=none; b=trZeDoHrRiYQb8SgnyBKfpkaplN07P4LbgWKaguvJJzGJTZ//xpYpXkpQOwq5cLyUfk+fheXEoNbeh2tK+tHxXXelr+fMoLcjEwvp1G6xw6e3Pt5Y3S5rCyEngF257AsJTUnL8kI5ODqs9QvDRbDwKyM76UV6K//rvx/Nw7iZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112836; c=relaxed/simple;
	bh=+rReAANx2iYEhcc46qGz07QWQ4XTbUlAYD3+TJ2mY7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVFXbRtleJhKomIeOWJTex9wV43pOZDIlLGFmuLRleAo+g1SZYudNI9BNVvbmkf2COBRiCjJi53CyoNJ3VVUTE9XkurlrABSqG6Rd+KLHGbLMf7tEnNlMjUt60J4tM9E8MbNebbc+J+Y9fBZ5RKw826DO8yn3fJsFJdSunFN//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=eXRZqweJ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706112832;
	bh=+rReAANx2iYEhcc46qGz07QWQ4XTbUlAYD3+TJ2mY7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eXRZqweJVlbCHlhCnvRrFOaqMIpPKjUVh2KH5bg9tYap0qGulTtYm8qIWwYyUMtqp
	 ud8fBhW0GjfjEEOSZJqcBnp6phDkyjdOpSuoSuGfzqos7hRJfDKV5N6cjKh5RJb6lP
	 kw2N+86ipI39NvZw5Gu6T6BQy9XxIhjvSdPchoa8=
Received: from [IPv6:240e:358:113a:a00:dc73:854d:832e:5] (unknown [IPv6:240e:358:113a:a00:dc73:854d:832e:5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id ED182669C3;
	Wed, 24 Jan 2024 11:13:48 -0500 (EST)
Message-ID: <0be1203c9df55432548c92281c8392dfa2f7d6bf.camel@xry111.site>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
From: Xi Ruoyao <xry111@xry111.site>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
  libc-alpha@sourceware.org
Date: Thu, 25 Jan 2024 00:13:43 +0800
In-Reply-To: <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
	 <mvmplxraqmd.fsf@suse.de>
	 <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
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

On Wed, 2024-01-24 at 20:49 +0800, Xi Ruoyao wrote:
> On Wed, 2024-01-24 at 12:59 +0100, Andreas Schwab wrote:
> > On Jan 24 2024, Xi Ruoyao wrote:
> >=20
> > > Now I'm suspecting this might be a kernel bug.=C2=A0 Any pointer to f=
urther
> > > triage?
> >=20
> > Is this a regression?
>=20
> Initially I guessed it was perhaps a Glibc regression related to the
> newly introduced clone3 usage on MIPS, but it fails with Glibc-2.35 too.
>=20
> Not sure if this is a kernel regression, I'll try different kernels in
> several hours (once I can physically access the system).

Not happening with kernel 5.18.1.  I can do a bisection but it will take
several days, I guess.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

