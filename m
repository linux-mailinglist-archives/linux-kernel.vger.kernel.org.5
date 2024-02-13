Return-Path: <linux-kernel+bounces-64525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A8A853FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458151C28E13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177F62A01;
	Tue, 13 Feb 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn1P7E1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE862A03;
	Tue, 13 Feb 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866161; cv=none; b=WRNRZw+fPCXBMxJrOPXe507/64o1WfPTxRzNEwlfTzx2fOlPj8n6Jwmo3XLjmxOAvkZ3++eHFGiV7Mif4SfQeYQdVUfUCBJkuhJV3yfGvgQ4wq8sIIBtEjliEGIF8Yksedq6Jz3yw68lNnulFINehQZ0wcixYrz+rjHZtm470hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866161; c=relaxed/simple;
	bh=hinPmoPhl1rsFt6fsXA2B1S8eFJZZOCkprZAD+0tFQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNnKATlhleoks79QD4KzDK5DmbbqotMpq+Ts/6v8QEczU244aHEAt/AxzIvK4qvLMXQV/2YhwdoCX/f4GnMNQNIKFBkkaacXSxK9Gvzv9WEKISkN56diejJuEM2AgBA9MMVQrK5zlKGWX1ol7OXO6r6a1gqi6c9nLYxIwN+RqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn1P7E1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F6CC433C7;
	Tue, 13 Feb 2024 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707866160;
	bh=hinPmoPhl1rsFt6fsXA2B1S8eFJZZOCkprZAD+0tFQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qn1P7E1uLlh6m2DDVr5QufQ0h9lp023Pt9QfDgeJQ0iTrC4Arm2nEOj9qXSNtB+iM
	 uWCZFssBBYMtd2vRFTr9t7A36b+2rPwRJwHzffKKwXl+j9GzVVtM5tabPIoDddC8Ea
	 5XWaO6nZDou0aK+s+NE4AfZw0YhkefrQHwF5Yfp7ZqatPDKmZgaVNSjiwkF1eyi/D2
	 MLf/E0BB94pO8P8gVfgU3hiVG/R4ebI+Izhletgi38QFYhlsDhbrE/8pfdTNsR3RBr
	 MJuxCD8vkRlWaat4r4kMb60Po6IDuXC+fbDUgBnYTGBkOYM8zpgaw4groLgPqELm7T
	 poa4S9B3DD/UQ==
Date: Tue, 13 Feb 2024 23:15:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH -fixes v2 3/4] riscv: Add ISA extension parsing for Sm
 and Ss
Message-ID: <20240213-earflap-easing-370492840507@spud>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-4-samuel.holland@sifive.com>
 <20240213-dangle-taco-2742f6087a3e@spud>
 <ff3bd436-12f8-4cde-881d-89a005ad85c0@sifive.com>
 <b7ad2bd4-a19e-486e-8be2-3b56f288d5d0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AsYNsV7RM7t347ws"
Content-Disposition: inline
In-Reply-To: <b7ad2bd4-a19e-486e-8be2-3b56f288d5d0@app.fastmail.com>


--AsYNsV7RM7t347ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 03:43:27PM -0500, Stefan O'Rear wrote:
> On Tue, Feb 13, 2024, at 3:22 PM, Samuel Holland wrote:
> > On 2024-02-13 12:07 PM, Conor Dooley wrote:
> >> On Mon, Feb 12, 2024 at 07:37:34PM -0800, Samuel Holland wrote:
> >>> Previously, all extension version numbers were ignored. However, the
> >>> version number is important for these two extensions. The simplest way
> >>> to implement this is to use a separate bitmap bit for each supported
> >>> version, with each successive version implying all of the previous on=
es.
> >>> This allows alternatives and riscv_has_extension_[un]likely() to work
> >>> naturally.
> >>>
> >>> To avoid duplicate extensions in /proc/cpuinfo, the new successor_id
> >>> field allows hiding all but the newest implemented version of an
> >>> extension.
> >>>
> >>> Cc: <stable@vger.kernel.org> # v6.7+
> >>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>>  - New patch for v2
> >>>
> >>>  arch/riscv/include/asm/cpufeature.h |  1 +
> >>>  arch/riscv/include/asm/hwcap.h      |  8 ++++++
> >>>  arch/riscv/kernel/cpu.c             |  5 ++++
> >>>  arch/riscv/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++--=
--
> >>>  4 files changed, 51 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> >>> index 0bd11862b760..ac71384e7bc4 100644
> >>> --- a/arch/riscv/include/asm/cpufeature.h
> >>> +++ b/arch/riscv/include/asm/cpufeature.h
> >>> @@ -61,6 +61,7 @@ struct riscv_isa_ext_data {
> >>>  	const char *property;
> >>>  	const unsigned int *subset_ext_ids;
> >>>  	const unsigned int subset_ext_size;
> >>> +	const unsigned int successor_id;
> >>>  };
> >>> =20
> >>>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> >>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/=
hwcap.h
> >>> index 5340f818746b..5b51aa1db15b 100644
> >>> --- a/arch/riscv/include/asm/hwcap.h
> >>> +++ b/arch/riscv/include/asm/hwcap.h
> >>> @@ -80,13 +80,21 @@
> >>>  #define RISCV_ISA_EXT_ZFA		71
> >>>  #define RISCV_ISA_EXT_ZTSO		72
> >>>  #define RISCV_ISA_EXT_ZACAS		73
> >>> +#define RISCV_ISA_EXT_SM1p11		74
> >>> +#define RISCV_ISA_EXT_SM1p12		75
> >>> +#define RISCV_ISA_EXT_SS1p11		76
> >>> +#define RISCV_ISA_EXT_SS1p12		77
> >>> =20
> >>>  #define RISCV_ISA_EXT_MAX		128
> >>>  #define RISCV_ISA_EXT_INVALID		U32_MAX
> >>> =20
> >>>  #ifdef CONFIG_RISCV_M_MODE
> >>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SM1p11
> >>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SM1p12
> >>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
> >>>  #else
> >>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SS1p11
> >>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SS1p12
> >>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
> >>>  #endif
> >>> =20
> >>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> >>> index d11d6320fb0d..2e6b90ed0d51 100644
> >>> --- a/arch/riscv/kernel/cpu.c
> >>> +++ b/arch/riscv/kernel/cpu.c
> >>> @@ -215,6 +215,11 @@ static void print_isa(struct seq_file *f, const =
unsigned long *isa_bitmap)
> >>>  		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].=
id))
> >>>  			continue;
> >>> =20
> >>> +		/* Only show the newest implemented version of an extension */
> >>> +		if (riscv_isa_ext[i].successor_id !=3D RISCV_ISA_EXT_INVALID &&
> >>> +		    __riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].s=
uccessor_id))
> >>> +			continue;
> >>> +
> >>>  		/* Only multi-letter extensions are split by underscores */
> >>>  		if (strnlen(riscv_isa_ext[i].name, 2) !=3D 1)
> >>>  			seq_puts(f, "_");
> >>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> >>> index c5b13f7dd482..8e10b50120e9 100644
> >>> --- a/arch/riscv/kernel/cpufeature.c
> >>> +++ b/arch/riscv/kernel/cpufeature.c
> >>> @@ -113,23 +113,29 @@ static bool riscv_isa_extension_check(int id)
> >>>  	return true;
> >>>  }
> >>> =20
> >>> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_s=
ize) {	\
> >>> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_s=
ize, _successor) {	\
> >>>  	.name =3D #_name,								\
> >>>  	.property =3D #_name,							\
> >>>  	.id =3D _id,								\
> >>>  	.subset_ext_ids =3D _subset_exts,						\
> >>> -	.subset_ext_size =3D _subset_exts_size					\
> >>> +	.subset_ext_size =3D _subset_exts_size,					\
> >>> +	.successor_id =3D _successor,						\
> >>>  }
> >>> =20
> >>> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, =
_id, NULL, 0)
> >>> +#define __RISCV_ISA_EXT_DATA(_name, _id) \
> >>> +	_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, RISCV_ISA_EXT_INVALID)
> >>> =20
> >>>  /* Used to declare pure "lasso" extension (Zk for instance) */
> >>>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> >>> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, AR=
RAY_SIZE(_bundled_exts))
> >>> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, \
> >>> +			    _bundled_exts, ARRAY_SIZE(_bundled_exts), RISCV_ISA_EXT_INVAL=
ID)
> >>> =20
> >>>  /* Used to declare extensions that are a superset of other extension=
s (Zvbb for instance) */
> >>>  #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> >>> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> >>> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), R=
ISCV_ISA_EXT_INVALID)
> >>> +
> >>> +#define __RISCV_ISA_EXT_VERSION(_name, _id, _preds, _preds_size, _su=
ccessor) \
> >>> +	_RISCV_ISA_EXT_DATA(_name, _id, _preds, _preds_size, _successor)
> >>> =20
> >>>  static const unsigned int riscv_zk_bundled_exts[] =3D {
> >>>  	RISCV_ISA_EXT_ZBKB,
> >>> @@ -201,6 +207,16 @@ static const unsigned int riscv_zvbb_exts[] =3D {
> >>>  	RISCV_ISA_EXT_ZVKB
> >>>  };
> >>> =20
> >>> +static const unsigned int riscv_sm_ext_versions[] =3D {
> >>> +	RISCV_ISA_EXT_SM1p11,
> >>> +	RISCV_ISA_EXT_SM1p12,
> >>> +};
> >>> +
> >>> +static const unsigned int riscv_ss_ext_versions[] =3D {
> >>> +	RISCV_ISA_EXT_SS1p11,
> >>> +	RISCV_ISA_EXT_SS1p12,
> >>> +};
> >>> +
> >>>  /*
> >>>   * The canonical order of ISA extension names in the ISA string is d=
efined in
> >>>   * chapter 27 of the unprivileged specification.
> >>> @@ -299,8 +315,16 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> >>>  	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
> >>>  	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
> >>>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
> >>> +	__RISCV_ISA_EXT_VERSION(sm1p11, RISCV_ISA_EXT_SM1p11, riscv_sm_ext_=
versions, 0,
> >>> +				RISCV_ISA_EXT_SM1p12),
> >>> +	__RISCV_ISA_EXT_VERSION(sm1p12, RISCV_ISA_EXT_SM1p12, riscv_sm_ext_=
versions, 1,
> >>> +				RISCV_ISA_EXT_INVALID),
> >>>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> >>>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
> >>> +	__RISCV_ISA_EXT_VERSION(ss1p11, RISCV_ISA_EXT_SS1p11, riscv_ss_ext_=
versions, 0,
> >>> +				RISCV_ISA_EXT_SS1p12),
> >>> +	__RISCV_ISA_EXT_VERSION(ss1p12, RISCV_ISA_EXT_SS1p12, riscv_ss_ext_=
versions, 1,
> >>> +				RISCV_ISA_EXT_INVALID),
> >>>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> >>>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >>>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> >>> @@ -414,6 +438,14 @@ static void __init riscv_parse_isa_string(unsign=
ed long *this_hwcap, struct risc
> >>>  				;
> >>> =20
> >>>  			++ext_end;
> >>> +
> >>> +			/*
> >>> +			 * As a special case for the Sm and Ss extensions, where the vers=
ion
> >>> +			 * number is important, include it in the extension name.
> >>> +			 */
> >>> +			if (ext_end - ext =3D=3D 2 && tolower(ext[0]) =3D=3D 's' &&
> >>> +			    (tolower(ext[1]) =3D=3D 'm' || tolower(ext[1]) =3D=3D 's'))
> >>> +				ext_end =3D isa;
> >>>  			break;
> >>>  		default:
> >>>  			/*
> >>=20
> >>=20
> >> Hmm, looking at all of this (especially this hack to the "old" parser),
> >> I feel more like these should be promoted to a property of their own.
> >> The "old" parser was designed to handle numbers, and here when you're
> >> interested in the values behind the numbers (which is a first iirc), y=
ou
> >> don't make any use of that. I don't really want to see a world where
> >
> > I had a version of this code that parsed the numbers and stored them as=
 integers
> > in `struct riscv_isainfo`. It didn't work with of_property_match_string=
() as
> > used for riscv,isa-extensions, since that function expects the extensio=
n name to
> > be the full string.

I don't think I actually want what I am about to say, but it's not as if we
are forced to parse it in that way for all properties. It's handy AF to be
able to reuse reuse that function, and that was part of my goal originally
with the property, but we are not locked into using
of_property_match_string() if there's some specific property where that's
getting in our way. That's kinda an aside though..

> > Either we would need to change the code to parse a version
> > number out of each string in the riscv,isa-extensions list (and make th=
e binding
> > a bunch of regexes), or we need a separate "extension" entry (and DT bi=
nding
> > entry) for each supported version.
>=20
> Version numbers aren't real, there's no compatibility promise that we can
> consistently rely on so we treat riscv,isa-extensions as simply containing
> alphanumeric extensions.  This was an intentional part of simplifying ris=
cv,isa
> into riscv,isa-extensions.

You seem to recall my motivations better than I do!

> > I chose the second option, and as a consequence I didn't actually need =
to parse
> > the integer value in the ISA string code path either.
> >
> >> we have every single iteration of smNpM under the sun in the property,
> >> because there's a fair bit of churn in the isa. Granted, this applies =
to
> >> all the various, the difference for me is the level of churn.
> >
> > Indeed. In fact, one thought I had while looking at this code is that w=
e should
> > be ignoring any extension in the ISA string with a version < 1.0 or >=
=3D 2.0,
> > since those won't be compatible with what we expect.
>=20
> I might go further and say that we should only accept specific exact vers=
ions of
> extensions other than Ss/Sm.

This is what we do, right? Every property is supposed to match to
exactly the frozen or ratified spec, so they do have exactly one version
at present. The property descriptions should contain that information.

> This could be revisited after the recent "semver
> for ISA extensions" policy is tested at least once under real-world condi=
tions.
>=20
> Right now we have two ratified versions of Ss/Sm, soon to be three, and o=
ne
> ratified version of all other extensions.  I hardly think this is an exce=
ssive
> amount of churn.

Yeah, maybe it's fine. I'm just overthinking it and there isn't a
problem.

> >> Or maybe we can still with the properties you have, but instead of
> >> treating them like any other extension, handle these separately,
> >> focusing on the numbering, so that only having the exact version
> >> supported by a cpu is possible.
> >
> > Maybe I'm misunderstanding what you're saying here, but it is already t=
he case
> > that the DT for a CPU would only contain the exact version of the privi=
leged ISA
> > supported by that CPU.
>=20
> If privileged spec versions are boolean extensions, then you would say "s=
s1p11",
> "ss1p12", "ss1p13" as separate/simultaneous extensions.

> This is needed in order
> to allow simple support checks as described in the riscv,isa-extensions c=
over
> letter.

Yes, it is explicitly a goal of riscv,isa-extensions that you can look
for a specific extension in the list if that is all you care about. If
you go and drop ss1p11 because you support ss1p12 it defeats that. I
don't know off the top of my head how to enforce ss1p12 requiring ss1p11
in json schema, but I do have an idea of where to start...

> > With this implementation, the fact that the integer version gets expand=
ed to a
> > series of flags is supposed to be invisible in the DT and to userspace.=
 I
> > realize I don't quite succeed there: putting "ss1p13" in the ISA string=
 should
> > work, but does not.
> >
> >> I'm still pretty undecided, I'd like to think about this a little bit,
> >> but I think we can do better here.
> >
> > Sure, no problem. I'm happy to implement whatever we agree on. Though o=
ne
> > consideration I had is that this is all in support of fixing a bug in v=
6.7, so I
> > wanted the changes to be backportable.
> >
> > I suppose the easy way out for backporting is to check for RISCV_ISA_EX=
T_ZICBOZ
> > for now, and then solve the larger problem once there is some other use=
r of the
> > envcfg CSR (or another Ss1p12 feature).
>=20
> I support that course of action.

I saw another mail suggesting that Zicbom implied Ss1p12, I think that
should be reasonable position to take for now.

Cheers,
Conor.

--AsYNsV7RM7t347ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcv4LAAKCRB4tDGHoIJi
0t99AQDDmipW0/rE80xzw9hdTclhte6GkpZZn2Io2aqlWfceTwD/a0/nfDNaJQ9d
a6UdQjJORN/DHFRQ9ak2naHPQ+KQpgg=
=ffp6
-----END PGP SIGNATURE-----

--AsYNsV7RM7t347ws--

