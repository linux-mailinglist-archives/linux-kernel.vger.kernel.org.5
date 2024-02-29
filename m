Return-Path: <linux-kernel+bounces-87315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8764286D291
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAEC287F74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6FB13440A;
	Thu, 29 Feb 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh0u6oAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B7160658
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232578; cv=none; b=p2aEnvJxcairTaL2JDASob3euj7OfJWyqgQ1mMGYbhwmIBDA4QKsiZtOofY1TNZIFd1q+lonU+3JyWvctk66q1xTBKCLZNz5o4bBqsszrJOVCORmte0SVCYut4ko4M9qXxqZronkqUNFH3pFG6N41iYUgnBh2kMkX0bBxSBb6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232578; c=relaxed/simple;
	bh=g3CmCefCR3WTlSDWS7AR0w1JmH5qdIML/k+fMyWnZrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLMtb1AF/douph14FQUjWoBybQjGK4kbKDek420i4B81KAt5OJk8HyJUrHDnuPwJCfjsYsl8znDt+w4Amxf8vvNJJAhFbAOxDQ71Lw2F0NkMSIZELE8XzLN2azG8ROItUOByxRuIBVre16X7iSuGbfqIrc6QhUOn0FHw1PKki8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh0u6oAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2533C433F1;
	Thu, 29 Feb 2024 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709232578;
	bh=g3CmCefCR3WTlSDWS7AR0w1JmH5qdIML/k+fMyWnZrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lh0u6oAqD+hlx1hr9y6lWjo1N6YgUMLDJDpuWiS0Qsh9aktJTaqnCGj0WauHkzlNM
	 AN4E6QBpTX9WB7AvcuOASBJ2H2L3e5sa2Yh4IjJzdqk03hgB8WyYio2IpOFBMRqScS
	 miLCXbLetiRnKs7tDaGHb0oHxRX3eRDe4ELtRf/lpCTkdUG6/aA/AehF2E4Hd3MGvy
	 CDucI063YmGTdqoom/N0fIVz6j0rWpKCmSssXB0D5USm/aYk9zG+2KL/VyPakdiSfN
	 WJL8czU0lKr4DwBJDDcRK+7VUVmQ1hPWMvpM7cM3N7Naczb5zcMJz2I/QGYn7zWQcz
	 /7SZqunHlDWLg==
Date: Thu, 29 Feb 2024 18:49:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: Set unaligned access speed at compile time
Message-ID: <20240229-dolphin-pennant-eef41ce44043@spud>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
 <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>
 <20240229-company-taste-daa305961e3a@spud>
 <ZeDO4CVOi6q4u8Lt@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RHgBMEh0Tn/kbG98"
Content-Disposition: inline
In-Reply-To: <ZeDO4CVOi6q4u8Lt@ghost>


--RHgBMEh0Tn/kbG98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 10:37:20AM -0800, Charlie Jenkins wrote:
> On Thu, Feb 29, 2024 at 12:26:37PM +0000, Conor Dooley wrote:
> > On Tue, Feb 27, 2024 at 03:13:14PM -0800, Charlie Jenkins wrote:
> >=20
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index bffbd869a068..ad0a9c1f8802 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -690,25 +690,58 @@ config THREAD_SIZE_ORDER
> > >  config RISCV_MISALIGNED
> > >  	bool "Support misaligned load/store traps for kernel and userspace"
> > >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > > +	depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGNED=
_ACCESS
> > >  	default y
> > >  	help
> > >  	  Say Y here if you want the kernel to embed support for misaligned
> > >  	  load/store for both kernel and userspace. When disable, misaligned
> > >  	  accesses will generate SIGBUS in userspace and panic in kernel.
> > > =20
> > > +choice
> > > +	prompt "Unaligned Accesses Support"
> > > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > > +	help
> > > +	  This selects the hardware support for unaligned accesses. This
> > > +	  information is used by the kernel to perform optimizations. It is=
 also
> > > +	  exposed to user space via the hwprobe syscall. The hardware will =
be
> > > +	  probed at boot by default.
> > > +
> > > +config RISCV_PROBE_UNALIGNED_ACCESS
> > > +	bool "Probe for hardware unaligned access support"
> > > +	help
> > > +	  During boot, the kernel will run a series of tests to determine t=
he
> > > +	  speed of unaligned accesses. This probing will dynamically determ=
ine
> > > +	  the speed of unaligned accesses on the boot hardware.
> > > +
> > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > +	bool "Assume the system expects emulated unaligned memory accesses"
> > > +	help
> > > +	  Assume that the system expects emulated unaligned memory accesses.
> > > +	  When enabled, this option notifies the kernel and userspace that
> > > +	  unaligned memory accesses will be emulated by either the kernel or
> > > +	  firmware.
> > > +
> > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > +	bool "Assume the system supports slow unaligned memory accesses"
> > > +	depends on NONPORTABLE
> > > +	help
> > > +	  Assume that the system supports slow unaligned memory accesses. T=
he
> > > +	  kernel may not be able to run at all on systems that do not suppo=
rt
> > > +	  unaligned memory accesses.
> > > +
> > >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > > -	bool "Assume the CPU supports fast unaligned memory accesses"
> > > +	bool "Assume the system supports fast unaligned memory accesses"
> > >  	depends on NONPORTABLE
> > >  	select DCACHE_WORD_ACCESS if MMU
> > >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >  	help
> > > -	  Say Y here if you want the kernel to assume that the CPU supports
> > > -	  efficient unaligned memory accesses.  When enabled, this option
> > > -	  improves the performance of the kernel on such CPUs.  However, the
> > > -	  kernel will run much more slowly, or will not be able to run at a=
ll,
> > > -	  on CPUs that do not support efficient unaligned memory accesses.
> > > +	  Assume that the system supports fast unaligned memory accesses. W=
hen
> > > +	  enabled, this option improves the performance of the kernel on su=
ch
> > > +	  systems.  However, the kernel will run much more slowly, or will =
not
> > > +	  be able to run at all, on systems that do not support efficient
> > > +	  unaligned memory accesses.
> > > =20
> > > -	  If unsure what to do here, say N.
> > > +endchoice
> >=20
> > Thinking about this some more, you've got 6 different options here:
> >=20
> > 1 probed with no emulation available (choice set to probe + RISCV_MISAL=
IGNED=3Dn)
> > 2 probe with in-kernel emulation available (choice set to probe + RISCV=
_MISALIGNED=3Dy)
> > 3 in-kernel emulation only (choice set to emulated + RISCV_MISALIGNED=
=3Dy)
> > 4 no in-kernel emulation but report emulated (choice set to emulated + =
RISCV_MISALIGNED=3Dn)
> > 5 slow unaligned (choice set to slow)
> > 6 fast unaligned (choice set to fast)
> >=20
> > Out of these, only 2 and 3 are portable options, since 1, 4 and 5 will
> > cause uabi issues if the CPUs or firmware does not support unaligned
> > access & 6 will not run in the same circumstances.
> >=20
> > My first thought here was about the motivation for the patch and what it
> > has resulted in. Being able to support HAVE_EFFICIENT_ALIGNED_ACCESS is
> > pretty nice, but it then seems like beyond that we are introducing
> > configuration for configurations sake, without looking at what the
> > resultant kernels will be useful for. Having 6 different options for how
> > the kernel can be configured in this way seems excessive and I don't
> > really get why some of them are even useful.
> >=20
> > Take for example situation 4. Unless I have misunderstood the Kconfig
> > options above, if you configure a kernel in that way, it will always
> > report as emulated, but there is no emulation provided. This just seems
> > like a option that's only purpose is setting a hwprobe value, which is
> > a dog wagging the tail situation to me.
>=20
> This goes back to my earlier comment that it would make sense for
> somebody to select "emulated" even if the unaligned address is being
> emulated by firmware. However, there may be no users for this and if
> needed we can add that in the future.

I don't think that is going to provide any useful information, give you
will never be able to know if slow means "slow but done by the cpu" or
"slow but emulated by the firmware".

> > The other thing is about what options are actually marked as
> > NONPORTABLE, given it is done in the choice option - but whether or not
> > something is actually non-portable actually depends on whether or not
> > the in-kernel emulator exists.
> >=20
> > I think what I would do here is simplify this quite a bit, starting by
> > making RISCV_MISALIGNED an internal option that users cannot enable but
> > is selected by the PORTABLE choice options. I would then re-work the
> > choice options a bit. My 4 would be:
> >=20
> > 1 probe: probe at boot time, falling back to emulated if not performant
> > 2 emulated: always emulate it in the kernel
> > 3 slow: don't probe or emulate in the kernel
> > 4 fast: Your current fast option
>=20
> Emulated doesn't mean that the kernel will always emulate the unaligned
> accesses. It means that the kernel has the ability to emulate them. It
> will only emulate them if the CPU traps on unaligned accesses. Kernel
> code can choose to forcefully align an address it thinks may cause an
> unaligned access, but that's slightly different from emulated.

Sure, make option 2 "don't probe at boot time, emulate it in the kernel
if we trap". I suppose in this case though, to get a correct output in
hwprobe you'd have to still attempt an unaligned access at boot time to
see if you trap but it will not perform the speed test?

> Emulated is much slower than "slow", so it seems like it unfairly
> penalizes "slow" to group the options for firmware emulated with a CPU
> that actually just does slow unaligned accesses.

As I said in my previous email, "slow" has a huge variance and may not
be meaningfully faster. I wonder if it might actually even be slower on
some systems that emulate it in firmware?

> > 1 & 2 select RISCV_UNALIGNED and are portable because they contain the
> > emulated support and thus satisfy the UABI constaints.
> > 3 & 4 are marked NONPORTABLE. I think 3 will run on systems that don't
> > support unaligned accesses but it will have UABI problems. 4 for the
> > reason mentioned in the Kconfig option above.
> >=20
> > I think that that gives you 4 meaningful options, what do you think?


--RHgBMEh0Tn/kbG98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDRvQAKCRB4tDGHoIJi
0uLbAP9EkOlrmXqXDmXwhQuFR4n96SjxTLwNUO7NxCY114XrxQEA8eG8jvK0H2EP
T/+eAiYGoInxBD9gSiL1NYiVz0CdAAA=
=xNU8
-----END PGP SIGNATURE-----

--RHgBMEh0Tn/kbG98--

