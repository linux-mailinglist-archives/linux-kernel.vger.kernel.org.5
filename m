Return-Path: <linux-kernel+bounces-106829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58DA87F43A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51338282327
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC25F86C;
	Mon, 18 Mar 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpVtI+ro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25C5F859
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805717; cv=none; b=U3+CBvVvGyzliwusiIorYhUPqksEk8YdHX73kjxCkeeyaj/MoYNpWH/gEcXLqCLXt4ZetYPCI3O5SNz+IPo+PiZUZxPYZ8Aj+MIJsWiufIyxItvluGpjFgLPbQXsDWNm9ECuLG6ZMamWuRu2GCZc9bBOmO2A/hHaCwo5KC5igdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805717; c=relaxed/simple;
	bh=Cn6JLaHFakVOrCPLqDt4/1WgZyxDmKrIjDcII8XUGIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSwpw98QS8PNR+6UYnyKj8WhJx0mJrO5B7nZqtajRwu1Zuqk/1dJi7nPs7aRMG6uCZzjQtDaiVVNjoNVLP64cLnGTMILt3GMoPgX28LyBKEfiCsA55zrDZqrm0GslllQozixpZD2aUtu7pm8yAcQsTd+9+kE+tqwZZll0WxGJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpVtI+ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F5FC433F1;
	Mon, 18 Mar 2024 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710805716;
	bh=Cn6JLaHFakVOrCPLqDt4/1WgZyxDmKrIjDcII8XUGIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpVtI+ro/2zMIR0B9qiL8hvLpHsmloDW2NP/k9jsl5O+ZLcT/YTJ/9xl5fZGzigqa
	 4lpgDM2qi1CtpYmPoucPaxFs7U0/Kt8EwqWaffnC/+6Ag9y0QO/Ims65lj9/r63FOD
	 H1EDkS9pEIRmYPLwcGmecNbYvcDXFLWifXXVnC8Cqj2MZsrZesWx8IDI/0u+7qZLjr
	 +Qo1KC35zJrrlY2zQeZaZrJxDEROIgq3ne5CsVYu/qaEIUvRoU/vqi+7SUJZcH3/bj
	 /9tnKZBIbo/mB853fNvZCRh1F2q8YFhoniUcov1Khxm3W96SCE1RZdI/SDjUIE/FiN
	 X2i+yqqk9INfQ==
Date: Mon, 18 Mar 2024 23:48:31 +0000
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
Message-ID: <20240318-such-animal-bf33de12dc3a@spud>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240315-73aa13079ef83a4559869084@orel>
 <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7t9HXeunHB+b3F/8"
Content-Disposition: inline
In-Reply-To: <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>


--7t9HXeunHB+b3F/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 03:46:54PM -0700, Atish Patra wrote:
> On 3/15/24 01:11, Andrew Jones wrote:
> > On Wed, Mar 13, 2024 at 09:31:26AM +0800, Inochi Amaoto wrote:
> > ...
> > > IMHO, it may be better to use a new DT property like "riscv,cpu-errat=
a" or
> > > "<vendor>,cpu-errata". It can achieve almost everything like using ps=
eudo
> > > isa. And the only cost I think is a small amount code to parse this.
> > >=20
> >=20
> > What's the ACPI equivalent for this new DT property? If there isn't one,
> > then the cost is also to introduce something to the ACPI spec and add t=
he
> > ACPI parsing code.
> >=20
> > I'd much rather we call specified behaviors "extensions", whether they
> > are vendor-specific or RVI standard, and then treat all extensions the
> > same way in hardware descriptions and Linux. It'd also be best if errata
> > in extension implementations were handled by replacing the extension in
> > the hardware description with a new name which is specifically for the
> > behavior Linux should expect. (Just because two extensions are almost t=
he
> > same doesn't mean we should say we have one and then have some second
> > mechanism to say, "well, not really, instead of that, it's this". It's
> > cleaner to just remove the extension it doesn't properly implement from
> > its hardware description and create a name for the behavior it does hav=
e.)
> >=20
> > Errata in behaviors which don't have extension names (are hopefully few)
> > and are where mvendorid and friends would need to be checked, but then =
why
> > not create a pseudo extension name, as Conor suggests, so the rest of
> > Linux code can manage errata the same way it manages every other behavi=
or?
> >=20
> > The growth rate of the ISA bitmap is worth thinking about, though, since
> > we have several copies of it (at least one "all harts" bitmap, one bitm=
ap
> > for each hart, another one for each vcpu, and then there's nested virt.=
=2E.)
> > We don't have enough extensions to worry about it now, but we can
> > eventually try partitioning, using common maps for common bits, not
> > storing bits which can be inferred from other bits, etc.
>=20
> This is my biggest worry going forward. We already have a ever growing
> standard RVI extension list. On top of that we have genuine vendor
> extensions. IMHO, errata are bit different than extensions as there will =
be
> few vendor extensions in the future but many hardware erratas :)

I dunno, I think there's going to be plenty of both. We may not see (or
use) a lot of vendor extensions in mainline Linux, but they will exist.

> If we start calling every hardware errata as an pseudo ISA extensions, we
> will much bigger problem maintaining it in the future.

I've explained to you at least once already that this is not my goal.
Where there are genuine issues with the implementation of an extension
creating a "pseudo" extension is not what I am suggesting we do.
I have no problem with with the approach taken for the SiFive errata,
for example.

> We discussed this earlier during the Andes PMU extension series[1] as wel=
l.
> We have three types of extensions in discussions now.
>=20
> 1. standard RVI extensions
> 2. Vendor extensions
> 	a. Genuine vendor extension
> 	b. Vendor erratas which can be described as pseudo-extensions now

> Keeping all these within a single ISA bitmap space seems very odd to me.
> I think the feasible approach would be to partition the standard and vend=
or
> ISA extension space as you suggested.

Let's be clear - partitioning the space is unrelated to the detection
method. We can go ahead and partition the space and use "pseudo"
extensions or we can have a unified space but use archid/impid for
detection. Having a unified space is the simpler thing to implement
right now, but it totally does not stop us breaking them out in the
future. We could even gate these custom implementations behind config
options if bloat is a concern - but multiplatform kernels are likely to
enable all the options anyway.

> For 2.b, either we can start defining pseudo extensions or adding
> vendor/arch/impid checks.
>=20
> @Conor: You seems to prefer the earlier approach instead of adding the
> checks. Care to elaborate why do you think that's a better method compared
> to a simple check ?

Because I don't think that describing these as "errata" in the first
place is even accurate. This is not a case of a vendor claiming they
have Sscofpmf support but the implementation is flawed. As far as I
understand, this is a vendor creating a useful feature prior to the
creation of a standard extension.
A bit of a test for this could be "If the standard extension never
existed, would this be considered a new feature or an implementation
issue". I think this is pretty clearly in the former camp.

I do not think we should be using m*id detection implementations of a
feature prior to creation of a standard extension for the same purpose.
To me the main difference between a case like this and VentanaCondOps/Zicond
is that we are the ones calling this an extension (hence my use of pseudo)
and not the vendor of the IP. If T-Head were to publish a document tomorrow
on the T-Head github repo for official vendor extensions, that difference
would not even exist any longer.

I also do not believe that it is a "simple" check. The number of
implementations that could end up using this PMU could just balloon
if T-Head has no intention of switching to Sscofpmf. If they don't
balloon in this case, there's nothing stopping them ballooning in a
similar case in the future. We should let the platform firmware tell us
explicitly, be that via DT or ACPI, what features are supported rather
than try to reverse engineer it ourselves via m*id.

That leads into another general issue I have with using m*id detection,
which I think I have mentioned several times on the list - it prevents the
platform (hypervisor, emulator or firmware) from disabling that feature.

If I had a time machine back to when the T-Head perf or cmo stuff was
submitted, I was try to avoid any of it being merged with the m*id
detection method.

> I agree that don't have the crystal ball and may be proven wrong in the
> future (I will be definitely happy about that!). But given the diversity =
of
> RISC-V ecosystem, I feel that may be our sad reality.

I don't understand what this comment is referring to, it lacks context
as to what the sad reality actually is.

I hope that all made sense and explained why I am against this method
for detecting what I believe to be features rather than errata,
Conor.

--7t9HXeunHB+b3F/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfjSzwAKCRB4tDGHoIJi
0hjTAQDU4iC54GGVQ58RwoBxuNpru5MnUhSu1JGRrSiUc83oCwEA83inmGv2dOAL
hhn4SEc7b8EAwecO1yhS+VZqoKz/NAE=
=nUaP
-----END PGP SIGNATURE-----

--7t9HXeunHB+b3F/8--

