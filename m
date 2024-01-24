Return-Path: <linux-kernel+bounces-37706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5083B427
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDB9288CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C7135A59;
	Wed, 24 Jan 2024 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Cvu/QdE/"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF21353F5;
	Wed, 24 Jan 2024 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132302; cv=none; b=t6FdT3gEad3j+mFyNOqnEl1xe8Y8ZvLsxasSxUU8e3uqLh7tGH7r+fUbHcy4yy4wCVudScIR868JrvqWX8fdH6Ka3LA4hatdyVjIsF9vQyXK1hcrcwhgms4wESVuYg+60EqJQ0CuFo7AGW4g6NVGvVSbLjZGoSx13Zje9vatC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132302; c=relaxed/simple;
	bh=6mY4cj8CJ8vFPelnuieKviTWwDNiq9cImboGHDPjJGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trGMtY82uilfPTb9li6tEd8YieaLvqxZg60pVz5vKVJnDMWU/YvuE7xHnm6ATSGT8sigDq0Mp5FYMbFBDG2FrrE3qNf3n12zrTAgRxVmwE8Rvs2Au8BzMZnBaYA2hjZk6oM5Tu7rWJqmrNarkzQ1e3tuS+VBs0a2rR/1QcfD3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Cvu/QdE/; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706132299;
	bh=6mY4cj8CJ8vFPelnuieKviTWwDNiq9cImboGHDPjJGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Cvu/QdE/iY9Wn/zxodNq1CDkCTJGGqfdWZhJ2wYw1v9hR4ZQ9oNJQjMfGdTJKVivL
	 jcR/yN454i8ljQpK97RdlB1tankDiqCgW12C186nJ2K+98F/AUkdJ1pFK2OnJkHmXT
	 qYl2tbVW6BFaQdLYH7ltIEkJn8B5bykC/pPLPkFc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id ADD6B66A7E;
	Wed, 24 Jan 2024 16:38:17 -0500 (EST)
Message-ID: <0625c3286a515ccb2ff5f7f58fd2019f81dd512e.camel@xry111.site>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
From: Xi Ruoyao <xry111@xry111.site>
To: Andreas Schwab <schwab@suse.de>, Ben Hutchings <ben@decadent.org.uk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
  libc-alpha@sourceware.org, Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jan 2024 05:38:16 +0800
In-Reply-To: <e8583a3ab0522b4e75ba0ada47b6f093b186fa81.camel@xry111.site>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
	 <mvmplxraqmd.fsf@suse.de>
	 <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
	 <0be1203c9df55432548c92281c8392dfa2f7d6bf.camel@xry111.site>
	 <e8583a3ab0522b4e75ba0ada47b6f093b186fa81.camel@xry111.site>
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

On Thu, 2024-01-25 at 05:32 +0800, Xi Ruoyao wrote:

/* snip */

> and the "interesting" aspects:
>=20
> 1. If I change the third parameter of "read" to any value >=3D 8, it no
> longer fails.=C2=A0 But it fails with any integer in [1, 8).
> 2. It fails no matter if I initialize buf.
> 3. It does not fail on arm64 (the only other port using
> lock_mm_and_find_vma I have access to).

Correction: I'd not realized many ports use lock_mm_and_find_vma even
before this series of changes.  I also have access to x86_64 and
loongarch64, and the failure seems specific to MIPS.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

