Return-Path: <linux-kernel+bounces-40646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12983E397
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEA01C249FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67402421A;
	Fri, 26 Jan 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="bt+bM6L/"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE051CA9C;
	Fri, 26 Jan 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303043; cv=none; b=I1VFCZrPv9U76CmjNlzHBxjtGsddbJKNWb1JLrP4sdU2RkhFce7U1rgwOcXqnhrlR5mI625ZE1P+A4Ad+wrpmYCWr31gvie8Tqd1N0hLkoOKod7eg1ifYLnz4eXXdZu+wZmNs553QRUo8TJgfhqlvfe01kABFVCcYPeyP8zrw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303043; c=relaxed/simple;
	bh=nqQ4IdgixdgGfdDx0ML46uM91lk8P3kyQ6NMybJB6Eo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8X0DiUiUtLF7oOBCfSDuC2Su12u2y3hbqx5GA7Dbz5H7jzR1Fs7oJ5qao6g4UISkQgzky2BgdMHoSPp3HRKuU/ttfD0kDloEQANAPyaC4ecmnYz3GaFIkxzRf7dD3IS1pJMJcqa+56I9EBV8i79ocwPZrXjmFq6bCU4MmnKJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=bt+bM6L/; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706303040;
	bh=nqQ4IdgixdgGfdDx0ML46uM91lk8P3kyQ6NMybJB6Eo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bt+bM6L/UaBZ/6t8E65kWFt6YqeyIWi5ZTxXNw2C2snwYQyaI5366AOjXz95kY9Kc
	 qL/UO/U3yXIkJXpk65ft4OkQMTQ6y0Aviy40bwFKapN7h8bJ0aUGqpEze5UqHHrasu
	 SK986//UkMWcdLfNPLkgcGwvcAPc8S8+KecdsvaI=
Received: from [IPv6:240e:358:1181:9d00:dc73:854d:832e:3] (unknown [IPv6:240e:358:1181:9d00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0610E66A26;
	Fri, 26 Jan 2024 16:03:55 -0500 (EST)
Message-ID: <17369fe8574440ef8550cbe1bdfb08e515416fe5.camel@xry111.site>
Subject: Re: [PATCH] mips: Call lose_fpu(0) before initializing fcr31 in
 mips_set_personality_nan
From: Xi Ruoyao <xry111@xry111.site>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Jiaxun Yang
	 <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>,  YunQiang Su <wzssyqa@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 linux-kernel@vger.kernel.org
Date: Sat, 27 Jan 2024 05:03:50 +0800
In-Reply-To: <20240126205920.11487-3-xry111@xry111.site>
References: <20240126205920.11487-3-xry111@xry111.site>
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

Please ignore this for wrong address of stable@.  Will send v2.

On Sat, 2024-01-27 at 04:59 +0800, Xi Ruoyao wrote:
> If we still own the FPU after initializing fcr31, when we are preempted
> the dirty value in the FPU will be read out and stored into fcr31,
> clobbering our setting.=C2=A0 This can cause an improper floating-point
> environment after execve().=C2=A0 For example:
>=20
> =C2=A0=C2=A0=C2=A0 zsh% cat measure.c
> =C2=A0=C2=A0=C2=A0 #include <fenv.h>
> =C2=A0=C2=A0=C2=A0 int main() { return fetestexcept(FE_INEXACT); }
> =C2=A0=C2=A0=C2=A0 zsh% cc measure.c -o measure -lm
> =C2=A0=C2=A0=C2=A0 zsh% echo $((1.0/3)) # raising FE_INEXACT
> =C2=A0=C2=A0=C2=A0 0.33333333333333331
> =C2=A0=C2=A0=C2=A0 zsh% while ./measure; do ; done
> =C2=A0=C2=A0=C2=A0 (stopped in seconds)
>=20
> Call lose_fpu(0) before setting fcr31 to prevent this.
>=20
> Closes: https://lore.kernel.org/linux-mips/7a6aa1bbdbbe2e63ae96ff163fab03=
49f58f1b9e.camel@xry111.site/
> Fixes: 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
> Cc: stable@vger.linux.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
> =C2=A0arch/mips/kernel/elf.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 5582a4ca1e9e..7aa2c2360ff6 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -11,6 +11,7 @@
> =C2=A0
> =C2=A0#include <asm/cpu-features.h>
> =C2=A0#include <asm/cpu-info.h>
> +#include <asm/fpu.h>
> =C2=A0
> =C2=A0#ifdef CONFIG_MIPS_FP_SUPPORT
> =C2=A0
> @@ -309,6 +310,11 @@ void mips_set_personality_nan(struct arch_elf_state =
*state)
> =C2=A0	struct cpuinfo_mips *c =3D &boot_cpu_data;
> =C2=A0	struct task_struct *t =3D current;
> =C2=A0
> +	/* Do this early so t->thread.fpu.fcr31 won't be clobbered in case
> +	 * we are preempted before the lose_fpu(0) in start_thread.
> +	 */
> +	lose_fpu(0);
> +
> =C2=A0	t->thread.fpu.fcr31 =3D c->fpu_csr31;
> =C2=A0	switch (state->nan_2008) {
> =C2=A0	case 0:

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

