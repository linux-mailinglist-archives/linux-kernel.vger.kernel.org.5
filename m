Return-Path: <linux-kernel+bounces-107726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223448800CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9645A281B36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6A657B2;
	Tue, 19 Mar 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZWtxxc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BC657C3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862571; cv=none; b=g6LkguKaLneyC136gvYDhjfL9SkvKt3pQinRMpC0ICqmQhFVpSUGqnqddfeI++08BSWozYdlYSN1np9FVgPbN0bPYivXb0s6hDXBb5WDtTruX8znp0YXQ3u9QJfdmLofZEjdNbCmS5GRnzYSfhGKvYcylQhfdtINi9RK5V2qugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862571; c=relaxed/simple;
	bh=iJAPd0ipgicMGkX908976IS76z5XVjMBR9B+vqhfqwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsYsfzOllse9xXgUx90iYuA0/y4z+28ILL+fdtiWm5oKos9tR98/Pw2RyYVFmcZFqLPXiidVPKofC046wnANyoEp/BBvM74+GGzadDYs8ThZiGd6EL025up0v/3iuUnDmacqT725ZUs2X6+bgp1HIYNI5B9NOn/yZP8pf42dnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZWtxxc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CCC433C7;
	Tue, 19 Mar 2024 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710862571;
	bh=iJAPd0ipgicMGkX908976IS76z5XVjMBR9B+vqhfqwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZWtxxc0N8p6XpThgis/oJTvcVjOgG3ysNYcC7PRucqRbFVV7uGpuvqto9Tok6sOx
	 4Xdu4LWMHD1GMf5DlMjvIlJWSASbeXwNMcZkGIPQOXVn8PFWMv8Tg2/qmatpJpOKQO
	 pMyefMot3kDOunfPYkxRdZbhYW8XwvSq7XwlEDf5+4TxXfhZ46RTfkw3+IMJKksVRt
	 r+nDh/imSASMmvhLIHu3pDzpw2Y14UMlQQTzQSWLyCihbpBS5Ob0P5CDIHEUTnDaCU
	 6cCOtZUq0ENGfQ1tzlPYk/XV7+cTHO6rkaODFtgooBzxq969dLMUnFqi8XfLx0VXVg
	 CVMN5SUfYeznA==
Date: Tue, 19 Mar 2024 15:36:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Atish Patra <atishp@rivosinc.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID: <20240319-underfoot-dispense-dc30ea860e7c@spud>
References: <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240315-73aa13079ef83a4559869084@orel>
 <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>
 <20240318-such-animal-bf33de12dc3a@spud>
 <4bdaaff1-13ec-48c2-b165-6a8255784aef@rivosinc.com>
 <20240319-worry-video-66589b3ed8ae@spud>
 <20240319-3e72d732cbf2fcf1cb81f968@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0VH/cmxy7ZfdZ7Pd"
Content-Disposition: inline
In-Reply-To: <20240319-3e72d732cbf2fcf1cb81f968@orel>


--0VH/cmxy7ZfdZ7Pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 02:39:21PM +0100, Andrew Jones wrote:
> On Tue, Mar 19, 2024 at 09:06:34AM +0000, Conor Dooley wrote:
> > On Mon, Mar 18, 2024 at 05:48:13PM -0700, Atish Patra wrote:
> > > On 3/18/24 16:48, Conor Dooley wrote:
> > > > On Mon, Mar 18, 2024 at 03:46:54PM -0700, Atish Patra wrote:
> >=20
> > > > > For 2.b, either we can start defining pseudo extensions or adding
> > > > > vendor/arch/impid checks.
> > > > >=20
> > > > > @Conor: You seems to prefer the earlier approach instead of addin=
g the
> > > > > checks. Care to elaborate why do you think that's a better method=
 compared
> > > > > to a simple check ?
> > > >=20
> > > > Because I don't think that describing these as "errata" in the first
> > > > place is even accurate. This is not a case of a vendor claiming they
> > > > have Sscofpmf support but the implementation is flawed. As far as I
> > > > understand, this is a vendor creating a useful feature prior to the
> > > > creation of a standard extension.
> > > > A bit of a test for this could be "If the standard extension never
> > > > existed, would this be considered a new feature or an implementation
> > > > issue". I think this is pretty clearly in the former camp.
> > > >=20
> > >=20
> > > So we have 3 cases.
> > >=20
> > > 1. Pseudo extension: An vendor extension designed and/or implemented =
before
> > > the standard RVI extension was ratified but do not violate any standa=
rd
> > > encoding space.
>=20
> The vendor should name these extensions themselves.
>=20
> > >=20
> > > 2. Erratas: An genuine bug/design issue in the expected behavior from=
 a
> > > standard RVI extension (including violating standard encoding space)
>=20
> More on this below, but I think vendors should name these too.

Yah, both of these the vendor /should/ name it themselves but I don't
want some set in stone /must/ that locks someone who is not the vendor
=66rom upstreaming.

> > > 3. Vendor extension: A new or a variant of standard RVI extension whi=
ch is
> > > different enough from standard extension.
> > >=20
> > > IMO, the line between #2 and #1 may get blurry as we going forward be=
cause
> > > of the sheer number of small extensions RVI is comping up with (which=
 is a
> > > problem as well).
>=20
> The line between #1 and #2 is blurry because the only difference is the
> original intentions. The end result is that a vendor has implemented
> something that resembles a standard extension, but is not the same as the
> standard extension.

Aye, a large part of this is definitely based on intent. Or maybe
marketing rather than intent, but the two aren't all that different
as the public may not be privy to which it actually is.

I think you're missing a factor though - when the difference is
discovered. Equating #1 and #2 is fine when that difference is known
when the platform is originally supported, but if the divergence between
what's implemented and the spec is only discovered down the line...

> > All this stuff is going to be pretty case-by-case (to begin with at
> > least) so I'm not too worried about that sort of abuse.
>=20
> Case-by-case is reasonable, since it's probably too strict to always
> require new names. We can consider each proposed workaround as they
> come, but it's a slippery slope once workarounds are accepted.

=2E.. I think that means that having some workarounds are inescapable
really. Some sort of workaround could then be only way fix the problem
without a firmware update. That workaround might be triggered by the
m*id CSRs or it could be based on the firmware's SBI implemenation
or version IDs.
When it's something that never worked at all or was discovered early,
then ye equate the two.

> > > Just to clarify: I am not too worried about this particular case as w=
e know
> > > that T-head's implementation predates the Sscofpmf extension.
> > > But once we define a standard mechanism for this kind of situation, v=
endor
> > > may start to abuse it.
> >=20
> > How do you envisage it being abused by a vendor?
> > Pre-dating the standard extension does make this one fairly clear-cut,
> > but are you worried about people coming along and claiming to implement
> > XConorSscofpmf instead of Sscofpmf rather than suffer the "shame" of a
> > broken implementation?
>=20
> Other than the concern of the ballooning bitmap, I'd prefer this approach.
> If a vendor has implemented some extension which happens to be "almost
> Sscofpmf", then whether it was implemented before the Sscofpmf spec
> existed, or after, isn't really important. What's important is that it's
> only "almost Sscofpmf" and not _exactly_ Sscofpmf, which means it should
> not use the Sscofpmf extension name.

One of the reasons I keep bringing up when things were created prior to
the creation of Sscofpmf (and I guess the fact that the vendor never
claims to support Sscofpmf) is to highlight that we are not looking at
at one of these edge cases where we're only discovering that there's an
implementation issue on these CPUs that we need to work around silently.

> Since vendors are allowed to create
> their own XVendor names, then that shouldn't be a problem. Indeed, the
> abuse concern seems to be in the opposite direction, that vendors will
> try to pass off almost-standard extensions as standard extensions by
> trying to get workarounds into Linux. Maybe Linux policy should be to
> simply reject workarounds to extensions, requiring vendors to create new
> names instead.

I'd be inclined to agree (although there's gonna be some exceptions as I
mention above) - but it's easy for me to say that given I want people to
use riscv,isa-extensions on the DT side which cites specific versions of
extensions that a device is compliant with.
If people have issues with riscv,isa in DT, I'm can take a bit of a "oh
it doesn't work with riscv,isa? Tough shit, that's why we made the new
properties." approach and push people into new names.

With ACPI, I have absolutely no idea how you police any of that. The way
the code works rn is that both DT properties and ACPI share the exact
same extension "names". Obviously it doesn't need to be that way, but it
is handy. I'm kinda derailing here, but how would we map names to exact
features in ACPI land? When I last read the ACPI stuff it was very
non-specific and the kernel documentation
(Documentation/riscv/acpi.rst) cites a specific version of the ISA
manual that provides no information (and I guess never will?) about
vendor extensions.



--0VH/cmxy7ZfdZ7Pd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfmw5QAKCRB4tDGHoIJi
0hIFAQCLs0NzjXYCJ/7zHMUgLco1spswubzbUNYZ2TShM6HgeAEA8boGBFDNeYr/
8ekwlpES68ZwZP3Ja9cCRqx+LolSPgw=
=CklJ
-----END PGP SIGNATURE-----

--0VH/cmxy7ZfdZ7Pd--

