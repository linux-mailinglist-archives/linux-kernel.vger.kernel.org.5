Return-Path: <linux-kernel+bounces-14132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061B2821833
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12541C21526
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4BA468C;
	Tue,  2 Jan 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VkxwVMqd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554D2116;
	Tue,  2 Jan 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1704182949;
	bh=rfgD7wZxYb3q3Dx3Za3Q0wUzALNwOb57oBPgRsgGEhg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VkxwVMqdveqAGWhyd+OVaZM8AZENzYgSY/np/cKWR/nmvD0l8poLVV4Xsh3p6yvUO
	 VjncBlXIdtzeQp+9FKVTutNAiCq1wOXwpV458UztG/CuQQwnLVA4hs1wY9SWH0D3kn
	 sj/5k2Bszg9lJwNZ+SZPdHij4UebdjlOybIsVWMQ=
Received: from [IPv6:240e:358:11a9:2200:dc73:854d:832e:3] (unknown [IPv6:240e:358:11a9:2200:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 392B366963;
	Tue,  2 Jan 2024 03:09:04 -0500 (EST)
Message-ID: <22af410fe1f60e7fc04cafbe03cfc50b36b53ae3.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Fix and simplify fcsr initialization on
 execve
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Eric Biederman <ebiederm@xmission.com>,
  Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Jinyang He <hejinyang@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 loongarch@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Tue, 02 Jan 2024 16:09:00 +0800
In-Reply-To: <CAAhV-H6dJtc3ZpEBnJzKdh691KQck771KOR0Lj41VLZ-Rc1ZwQ@mail.gmail.com>
References: <20240101172143.14530-2-xry111@xry111.site>
	 <CAAhV-H6dJtc3ZpEBnJzKdh691KQck771KOR0Lj41VLZ-Rc1ZwQ@mail.gmail.com>
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

On Tue, 2024-01-02 at 10:35 +0800, Huacai Chen wrote:

/* snip */

> > The only other architecture setting FCSR in SET_PERSONALITY2 is MIPS.
> > They do this for supporting different FP flavors (NaN encodings etc).
> > which do not exist on LoongArch.=C2=A0 I'm not sure how MIPS evades the=
 issue
> > (or maybe it's just buggy too) as I don't have a running MIPS hardware
> > now.
> I think you can use QEMU. :)

I'll investigate it later.

> > So for LoongArch, just remove the current->thread.fpu.fcsr setting from
> > SET_PERSONALITY2 and do it in start_thread, after lose_fpu(0).=C2=A0 An=
d we
> > just set it to 0, instead of boot_cpu_data.fpu_csr0 (because we should
> > provide the userspace a consistent configuration, no matter how hardwar=
e
> > and firmware behave).
> I still prefer to set fcsr to boot_cpu_data.fpu_csr0, because we will
> add LoongArch32 later, not sure whether something will change.

I just seen fpu_csr0 is initialized to FPU_CSR_RN which is just 0 for
LA64, so my concern about firmware & hardware leaving non-zero FCSR is
not valid.  I'll send v2 to keep using boot_cpu_data.fpu_csr0 then.

>=20
>=20
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

