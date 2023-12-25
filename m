Return-Path: <linux-kernel+bounces-11009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFC481E006
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D221C20AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E36F5101A;
	Mon, 25 Dec 2023 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="iB4W3z8X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727F51010
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1703502682;
	bh=GkgmunfoJwbAasFfuGJQtRLTNoSHgiQxffHDvaqDY8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iB4W3z8XvBGOGJDZFER6AQlXhr4JaH7IM+gRVISt3T/0Ik2nQ/1SLirXidbgDdAE7
	 F12GrPi0JhW8eIhpDzhnH7k3ZRGkvC02TQ3sAXC63q/KsjSU9CLL3hhhjj0Dy190dS
	 WE5ox1sap8R8M9iHKbSj/WOak3u5VnLZXLFQr6qo=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 2D515669C1;
	Mon, 25 Dec 2023 06:11:21 -0500 (EST)
Message-ID: <61b95cfbcf7b812348b543189ce7f4539c082ccd.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Let cores_io_master cover the largest NR_CPUS
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, maobibo <maobibo@loongson.cn>
Cc: loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev, Xuefeng Li
	 <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, Xuerui Wang
	 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Date: Mon, 25 Dec 2023 19:11:19 +0800
In-Reply-To: <CAAhV-H5Rs4BGKHZrA5bxSh0=4uhPx7vbVwBXtdtfU4hemN2QjA@mail.gmail.com>
References: <20231225070002.1350705-1-chenhuacai@loongson.cn>
	 <3db5c086-db9b-cb3a-5521-44f18cb55c4a@loongson.cn>
	 <CAAhV-H5Rs4BGKHZrA5bxSh0=4uhPx7vbVwBXtdtfU4hemN2QjA@mail.gmail.com>
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

On Mon, 2023-12-25 at 17:19 +0800, Huacai Chen wrote:
> On Mon, Dec 25, 2023 at 5:13=E2=80=AFPM maobibo <maobibo@loongson.cn> wro=
te:
> >=20
> >=20
> >=20
> > On 2023/12/25 =E4=B8=8B=E5=8D=883:00, Huacai Chen wrote:
> > > Now loongson_system_configuration::cores_io_master only covers 64 cpu=
s,
> > > if NR_CPUS > 64 there will be memory corruption. So let cores_io_mast=
er
> > > cover the largest NR_CPUS (256).
> > >=20
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > =C2=A0=C2=A0 arch/loongarch/include/asm/bootinfo.h | 4 ++--
> > > =C2=A0=C2=A0 arch/loongarch/kernel/acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > > =C2=A0=C2=A0 arch/loongarch/kernel/smp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > > =C2=A0=C2=A0 3 files changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/i=
nclude/asm/bootinfo.h
> > > index c60796869b2b..32fd0319594a 100644
> > > --- a/arch/loongarch/include/asm/bootinfo.h
> > > +++ b/arch/loongarch/include/asm/bootinfo.h
> > > @@ -30,7 +30,7 @@ struct loongson_system_configuration {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int boot_cpu_id;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cores_per_node;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cores_per_package;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long cores_io_master;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long cores_io_master[4];
> > Can the hardcoded 4 be defined something like this?
> > =C2=A0=C2=A0=C2=A0=C2=A0 DIV_ROUND_UP(CONFIG_NR_CPUS, sizeof(long))
> Can this be used to define arrays?

Yes, it's basically just expanded to (((CONFIG_NR_CPUS) + (sizeof(long))
- 1) / (sizeof(long)).  Per the C standard (C99 section 6.6 p6) it's an
integer constant expression and can be used as array size.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

