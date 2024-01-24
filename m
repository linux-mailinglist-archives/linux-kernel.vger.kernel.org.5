Return-Path: <linux-kernel+bounces-37019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3F83AA48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C55DB20EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D077641;
	Wed, 24 Jan 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="N7OsNMUa"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9577639;
	Wed, 24 Jan 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100555; cv=none; b=GWFckQ9Vv7F9zfWTx5XlzvULfzDY5ZcQa3irFUfuTgoCU2v2aQeeTAv/kisCSzg4//5n13iAnEu4XHsYlOAwGwaKP/9KqUOFsWESZQjzO9zFVerO30FgJpv/ZGkoCejPHxiyM7kg+mKUo4ou6vaVPwNVCz3yhUxLI3jPCopS0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100555; c=relaxed/simple;
	bh=s6U31JdDDdI9PWpaMCc4XRAEGMxkDJjCGZP0a8Ic/GM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+3hXTQrXwoVZrii7ij4Bm9SYjDdLBnFHux2qabE5BRBbXQKpd9N0B3GstVwagRJy6NiUrUPRiBeiv2hxxI/ZddgfDqBvx2FLJyOcNw+QkK5KMv4Cbfb1bUa4Rj2Kdu0kWhB+IVNuCctoNYxH0NondTZ2hgXwHQfYJDY6qbD8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=N7OsNMUa; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706100550;
	bh=s6U31JdDDdI9PWpaMCc4XRAEGMxkDJjCGZP0a8Ic/GM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N7OsNMUarIxezT0AZ8LR73o0hZeU0gjeNTC7lHLePEsFDIZpPbZsPxj+wTeG1oGp/
	 URkMpC7Z8AXkToWwpNQVLagc0cLqo2+K4zZ/AprHRmWW/ldF0FFFm/8DfqPm1k6ate
	 qdPqYWaHAGWTdlCiPmKZmvBrMODC4l33VGSTYrWs=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9E47966DFC;
	Wed, 24 Jan 2024 07:49:08 -0500 (EST)
Message-ID: <9481b6d9d015aea25d8f2563bf7bd6f6462f758f.camel@xry111.site>
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
From: Xi Ruoyao <xry111@xry111.site>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
  libc-alpha@sourceware.org
Date: Wed, 24 Jan 2024 20:49:06 +0800
In-Reply-To: <mvmplxraqmd.fsf@suse.de>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
	 <mvmplxraqmd.fsf@suse.de>
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

On Wed, 2024-01-24 at 12:59 +0100, Andreas Schwab wrote:
> On Jan 24 2024, Xi Ruoyao wrote:
>=20
> > Now I'm suspecting this might be a kernel bug.=C2=A0 Any pointer to fur=
ther
> > triage?
>=20
> Is this a regression?

Initially I guessed it was perhaps a Glibc regression related to the
newly introduced clone3 usage on MIPS, but it fails with Glibc-2.35 too.

Not sure if this is a kernel regression, I'll try different kernels in
several hours (once I can physically access the system).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

