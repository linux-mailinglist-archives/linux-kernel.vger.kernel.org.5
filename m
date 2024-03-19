Return-Path: <linux-kernel+bounces-107276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7683287FA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E005F1F22028
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953D7C0A6;
	Tue, 19 Mar 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMQ+YVGv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C07C081
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839200; cv=none; b=I+Ie1Km59I6xgMy4sGFTVl5Xf1Jl6zP+2OChAGR7WB4I8fvspwCWQfk8rjAmaLY7koPWX4dsyRz1aPdJkTFKWrMWJYQ0J3sxeEwSgHykb+ixCLeyOdTS4+P88E8+Y4hUW+uO0xzm2S8xx6Bt4ms5W/W1gUBW1KGXRs4fdazbItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839200; c=relaxed/simple;
	bh=Besk0i9lF9pASA+SWwpUURawOL5FpQ1zrAOiGhmEKXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEbcvx+PXd89SuW8XdVyO2o9nPxd254pA5R37XWnLabKK6VsjK00SJSHqvowWlZa+ZvWL1gG4cZ6wOuxw+vsTQo/PTlF2YYsulFvXa8ardRvlzWah8e4FLuB7Xg7TY4iGRSHxE/re2o52/XsknEttlC+L2NjI7gVobPs5EiuRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMQ+YVGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1106BC433F1;
	Tue, 19 Mar 2024 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710839200;
	bh=Besk0i9lF9pASA+SWwpUURawOL5FpQ1zrAOiGhmEKXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMQ+YVGvD4hcB+2Y4+3f0qdkBJoIg5HTTaVr/30L/4GgMd0+lxZkGvZdTuteIoelT
	 ihx9YeykEO8pW9VyaXA4JjmMm+iARhl3+xD769AnMG306O1sZeBtngTGf2MKRdWFCj
	 6RYKqNllHa20nry/sVmekFz5ySVSZ5G4FY0QheDwQBGEz76stIXrKGYSzQxNCH5Hjo
	 eOn3o5XULzT5H0xSdM+ai4skwHpr373CZdzvBt7WF6ZQs/1BbgUrHk19Rg13flOZFA
	 69i/MaVYx5vWLIpInSuTZj1EoI83Ube2loi326EnAa9+DcWgX7kaU+xMfDNkphQnNk
	 t1BDNWM9sMzgw==
Date: Tue, 19 Mar 2024 09:06:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Atish Patra <atishp@rivosinc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
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
Message-ID: <20240319-worry-video-66589b3ed8ae@spud>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240315-73aa13079ef83a4559869084@orel>
 <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>
 <20240318-such-animal-bf33de12dc3a@spud>
 <4bdaaff1-13ec-48c2-b165-6a8255784aef@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jDYWah4eJAonImXm"
Content-Disposition: inline
In-Reply-To: <4bdaaff1-13ec-48c2-b165-6a8255784aef@rivosinc.com>


--jDYWah4eJAonImXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 05:48:13PM -0700, Atish Patra wrote:
> On 3/18/24 16:48, Conor Dooley wrote:
> > On Mon, Mar 18, 2024 at 03:46:54PM -0700, Atish Patra wrote:

> > > For 2.b, either we can start defining pseudo extensions or adding
> > > vendor/arch/impid checks.
> > >=20
> > > @Conor: You seems to prefer the earlier approach instead of adding the
> > > checks. Care to elaborate why do you think that's a better method com=
pared
> > > to a simple check ?
> >=20
> > Because I don't think that describing these as "errata" in the first
> > place is even accurate. This is not a case of a vendor claiming they
> > have Sscofpmf support but the implementation is flawed. As far as I
> > understand, this is a vendor creating a useful feature prior to the
> > creation of a standard extension.
> > A bit of a test for this could be "If the standard extension never
> > existed, would this be considered a new feature or an implementation
> > issue". I think this is pretty clearly in the former camp.
> >=20
>=20
> So we have 3 cases.
>=20
> 1. Pseudo extension: An vendor extension designed and/or implemented befo=
re
> the standard RVI extension was ratified but do not violate any standard
> encoding space.
>=20
> 2. Erratas: An genuine bug/design issue in the expected behavior from a
> standard RVI extension (including violating standard encoding space)
>=20
> 3. Vendor extension: A new or a variant of standard RVI extension which is
> different enough from standard extension.
>=20
> IMO, the line between #2 and #1 may get blurry as we going forward because
> of the sheer number of small extensions RVI is comping up with (which is a
> problem as well).

Aye, I think some of that is verging on ridiculous.

> Just to clarify: I am not too worried about this particular case as we kn=
ow
> that T-head's implementation predates the Sscofpmf extension.
> But once we define a standard mechanism for this kind of situation, vendor
> may start to abuse it.

How do you envisage it being abused by a vendor?
Pre-dating the standard extension does make this one fairly clear-cut,
but are you worried about people coming along and claiming to implement
XConorSscofpmf instead of Sscofpmf rather than suffer the "shame" of a
broken implementation?
All this stuff is going to be pretty case-by-case (to begin with at
least) so I'm not too worried about that sort of abuse.

> > I do not think we should be using m*id detection implementations of a
> > feature prior to creation of a standard extension for the same purpose.
> > To me the main difference between a case like this and VentanaCondOps/Z=
icond
> > is that we are the ones calling this an extension (hence my use of pseu=
do)
> > and not the vendor of the IP. If T-Head were to publish a document tomo=
rrow
> > on the T-Head github repo for official vendor extensions, that differen=
ce
> > would not even exist any longer.
> >=20
>=20
> Exactly! If vendor publishes these as an extension or an errata, that's a
> binding agreement to call it in a specific way.

I don't agree that we are bound to call it the way that the vendor does.
We should just review these sorts of things on a case-by-case basis,
committing to doing what the vendor says is abusable.

> > I also do not believe that it is a "simple" check. The number of
> > implementations that could end up using this PMU could just balloon
> > if T-Head has no intention of switching to Sscofpmf. If they don't
> > balloon in this case, there's nothing stopping them ballooning in a
>=20
> Ideally, they shouldn't as it a simple case of CSR number & IRQ number.
> If they care to implement AIA, then they must change it to standard sscof=
pmf
> as the current IRQ violates the AIA spec. But who knows if they care to
> implement AIA or not.

What kinda "worried" me here is that the c908 implements /both/ Zicbom
and the T-Head CMO instructions and /both/ Svpbmt and their original
misuse of the reserved bits but they do not support Sscofpmf. Maybe it
just was not feasible to migrate entirely (but they did for vector) or
to support both interrupt numbers and to alias the CSR, but it seemed
like the opportunity to standardise a bunch of other stuff was taken,
but this particular extension was not. That's why I was worried that
we'd see some ballooning in these specific checks.

> > similar case in the future. We should let the platform firmware tell=20
> > explicitly, be that via DT or ACPI, what features are supported rather
> > than try to reverse engineer it ourselves via m*id.
> >=20
> Fair enough.
>=20
>=20
> > That leads into another general issue I have with using m*id detection,
> > which I think I have mentioned several times on the list - it prevents =
the
> > platform (hypervisor, emulator or firmware) from disabling that feature.
> >=20
>=20
> If that is the only concern, platform can just disable the actual
> extension(i.e. sscofpmf in this case) to disable that feature for that
> particular vendor.

Right. Maybe I wasn't clear that this is a problem with using m*id for
/detection/ of extensions and not with using m*id to work around
implementation issues with the extension. In the latter case, you're
applying a fixup only when the actual extension is communicated to be
present, which leaves that control in the hands of the platform.

> > If I had a time machine back to when the T-Head perf or cmo stuff was
> > submitted, I was try to avoid any of it being merged with the m*id
> > detection method.
> >=20
> > > I agree that don't have the crystal ball and may be proven wrong in t=
he
> > > future (I will be definitely happy about that!). But given the divers=
ity of
> > > RISC-V ecosystem, I feel that may be our sad reality.
> >=20
> > I don't understand what this comment is referring to, it lacks context
> > as to what the sad reality actually is.
> >=20
> > I hope that all made sense and explained why I am against this method
> > for detecting what I believe to be features rather than errata,
> > Conor.
> >=20
>=20
> Yes.Thanks again for the clarification. Again, I am not opposed to the id=
ea.
> I just wanted to understand if this is the best option we have right now.

--jDYWah4eJAonImXm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZflVmgAKCRB4tDGHoIJi
0uTJAP4tm/qyPBI8P5hE3evFbYiu1vAiujb+43plrJuxa47r3wEAlCRQB/ZNIQsx
+sADJZ94egfK/DR3Hm3z77uDJVFY/Qk=
=qQhH
-----END PGP SIGNATURE-----

--jDYWah4eJAonImXm--

