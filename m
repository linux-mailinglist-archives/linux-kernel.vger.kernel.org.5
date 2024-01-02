Return-Path: <linux-kernel+bounces-14264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB07821A60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679A1B21A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB42ADDAD;
	Tue,  2 Jan 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="M7imy2eY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25376D528;
	Tue,  2 Jan 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1704192519;
	bh=f4OQ1ZNLcLTkfVKTa0KnB7uTCXzUZK0q6WupCf7F0ss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M7imy2eYubvLYstc4XOHXKYbzCNqXLJgUjS8XUXUbWgOvKfdWTgDVMs55JXev+E4U
	 h490habAEDFwY/jQ2BDBytStmmUV3Ehbfz8RsdLQDJC3F7yMfp/+N2nU+2xMrqxBEE
	 Ps7kPH0aSrl6I++ekZEHhcFxzIzNnMQyqwL7K8LM=
Received: from [IPv6:240e:358:11a9:2200:dc73:854d:832e:3] (unknown [IPv6:240e:358:11a9:2200:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 07F2766F45;
	Tue,  2 Jan 2024 05:48:31 -0500 (EST)
Message-ID: <7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site>
Subject: MIPS: fcsr31 may be dirty after execve when kernel preempt is
 enabled (was: Re: [PATCH v2] LoongArch: Fix and simplify fcsr
 initialization on execve)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <keescook@chromium.org>,  Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He
 <hejinyang@loongson.cn>, loongarch@lists.linux.dev,  linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 linux-mips@vger.kernel.org
Date: Tue, 02 Jan 2024 18:48:27 +0800
In-Reply-To: <f6e0b3a0e08a8100fa5dc9345af8582ff664321c.camel@xry111.site>
References: <20240102101711.10872-2-xry111@xry111.site>
	 <f6e0b3a0e08a8100fa5dc9345af8582ff664321c.camel@xry111.site>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 18:25 +0800, Xi Ruoyao wrote:
> On Tue, 2024-01-02 at 18:17 +0800, Xi Ruoyao wrote:
> > The only other architecture setting FCSR in SET_PERSONALITY2 is MIPS.
> > They do this for supporting different FP flavors (NaN encodings etc).
> > which do not exist on LoongArch.=C2=A0 I'm not sure how MIPS evades the=
 issue
> > (or maybe it's just buggy too) but I'll investigate it later.
>=20
> Phew.=C2=A0 I just managed to recommission my 3A4000 and I can reproduce =
the
> issue as well with Linux 5.18.1 (the latest kernel release when I
> decommissioned it) and CONFIG_PREEMPT=3Dy.
>=20
> % cat measure.c
> #include <fenv.h>
> int main() { return fetestexcept(FE_INEXACT); }
>=20
> % echo $((1./3))
> 0.33333333333333331
>=20
> % while ./a.out; do ; done
> (stopped in seconds)
>=20
> I'm building the mainline kernel on the 3A4000 now, will see if the
> issue still exists...

Still happening with 6.7.0-rc8.  I'm not sure how to fix it for MIPS.=20
Maybe lose_fpu in SET_PERSONALITY2? But to me doing so will be really
nasty.  Anyway I'll leave this for MIPS maintainers.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

