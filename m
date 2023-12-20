Return-Path: <linux-kernel+bounces-7519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4C81A93D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8808A1F23A52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDA482DC;
	Wed, 20 Dec 2023 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc//UKmY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD21D6A8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFBCC433C8;
	Wed, 20 Dec 2023 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703111695;
	bh=d9zxtgGvD0FyI9tDgmuHthjr3LnvFT1djbBAQIHHqVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tc//UKmY5eBORtXFIrS/YTHjOtG8CcbB4Jn2wqgDBrQJJ743cJrS9Y/iKMsT+172S
	 VV9lZYB2UESLqlCHUoP1ln3bQojQ1SkWKLqFDxgTe6Ez8U4jeXoNF5IhygSu9vWhut
	 j7gk4yUBRimouyu0Y9o8RnP9zQ16HqeciFutGfEpDVH8UffUtDQN5KfXBsYquYboCt
	 QY9lwhFiOK83jgBMDAyrok1XSC2U6VbqiuIZatc6ccGPMZ/zfgmcZGXcEvsdeWD1Fx
	 vdlJdHfKTGzDv6lNtafLpg4MTgdv1jwXCHVebZxEIcravMPvWt6/ZQO5mJviRYmLwO
	 f+hoto2ZoqEog==
Date: Wed, 20 Dec 2023 22:34:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
	alexghiti@rivosinc.com, anup@brainfault.org,
	samitolvanen@google.com, rppt@kernel.org,
	panqinglin2020@iscas.ac.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: put va_kernel_xip_pa_offset into CONFIG_XIP_KERNEL
Message-ID: <20231220-bash-booting-2dc46e8c41f7@spud>
References: <20231220103428.61758-1-cuiyunhui@bytedance.com>
 <594df6bc-0207-46f6-aa81-dcf1f3665917@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9VC1To1d/DjgDtuf"
Content-Disposition: inline
In-Reply-To: <594df6bc-0207-46f6-aa81-dcf1f3665917@ghiti.fr>


--9VC1To1d/DjgDtuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:14:59PM +0100, Alexandre Ghiti wrote:
> Hi Yunhui,
>=20
> On 20/12/2023 11:34, Yunhui Cui wrote:
> > opitmize the kernel_mapping_pa_to_va() and kernel_mapping_va_to_pa().
> >=20
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   arch/riscv/include/asm/page.h | 33 ++++++++++++++++++++-------------
> >   1 file changed, 20 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pag=
e.h
> > index 5488ecc337b6..0d2b479d02cd 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -113,8 +113,8 @@ struct kernel_mapping {
> >   	unsigned long va_pa_offset;
> >   	/* Offset between kernel mapping virtual address and kernel load add=
ress */
> >   	unsigned long va_kernel_pa_offset;
> > -	unsigned long va_kernel_xip_pa_offset;
> >   #ifdef CONFIG_XIP_KERNEL
> > +	unsigned long va_kernel_xip_pa_offset;
> >   	uintptr_t xiprom;
> >   	uintptr_t xiprom_sz;
> >   #endif
> > @@ -134,12 +134,25 @@ extern phys_addr_t phys_ram_base;
> >   #else
> >   void *linear_mapping_pa_to_va(unsigned long x);
> >   #endif
> > -#define kernel_mapping_pa_to_va(y)	({					\
> > -	unsigned long _y =3D (unsigned long)(y);					\
> > -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
> > -		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
> > -		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
> > -	})
> > +
> > +#ifdef CONFIG_XIP_KERNEL
> > +#define kernel_mapping_pa_to_va(y)							\
> > +	(((unsigned long)(y) < phys_ram_base) ?						\
> > +		(void *)((unsigned long)(y) + kernel_map.va_kernel_xip_pa_offset) :	\
> > +		(void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset + XIP_O=
FFSET))
> > +
> > +#define kernel_mapping_va_to_pa(y)						\
> > +	(((unsigned long)(y) < kernel_map.virt_addr + XIP_OFFSET) ?		\
> > +		((unsigned long)(y) - kernel_map.va_kernel_xip_pa_offset) :	\
> > +		((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET))
> > +#else
> > +#define kernel_mapping_pa_to_va(y)						\
> > +	((void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset + XIP_O=
FFSET))
> > +
> > +#define kernel_mapping_va_to_pa(y)						\
> > +	((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET)
> > +#endif
> > +
> >   #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
> >   #ifndef CONFIG_DEBUG_VIRTUAL
> > @@ -147,12 +160,6 @@ void *linear_mapping_pa_to_va(unsigned long x);
> >   #else
> >   phys_addr_t linear_mapping_va_to_pa(unsigned long x);
> >   #endif
> > -#define kernel_mapping_va_to_pa(y) ({						\
> > -	unsigned long _y =3D (unsigned long)(y);					\
> > -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFF=
SET) ? \
> > -		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
> > -		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
> > -	})
> >   #define __va_to_pa_nodebug(x)	({						\
> >   	unsigned long _x =3D x;							\
>=20
>=20
> Not sure using #ifdef optimizes anything since the compiler should do the
> same with the IS_ENABLED(CONFIG_XIP_KERNEL) and it does not really improve
> the readability of this file which is already overloaded with #ifdef, so I
> don't think this change is needed.

I would say that we explicitly do not want to move things that are
guarded by IS_ENABLED() to ifdeffery. In fact, we should move things in
the other direction if possible, especially for stuff like XIP_KERNEL
that nobody ever build tests.

--9VC1To1d/DjgDtuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYNsCgAKCRB4tDGHoIJi
0j5AAQDfD3hOrSf1w4Vr0SLOYvfQvnozBNrGfGmnoJXphENmagEAscxW3hYminqS
v99vGB5Ab9jM9vbhOdfgK4sEMKUPuAI=
=D6Wb
-----END PGP SIGNATURE-----

--9VC1To1d/DjgDtuf--

