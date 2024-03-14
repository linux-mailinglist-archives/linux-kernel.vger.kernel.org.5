Return-Path: <linux-kernel+bounces-103777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD8387C45F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D17AB21FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F960763EC;
	Thu, 14 Mar 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5j0NKIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8EE74E31
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448880; cv=none; b=GsTIT/+XedXF8FRGYN3aMkzz45QAsZLhhQrV16lynqzQJ41XlEp1xrlVJE349tqHZUhh6xW0DJEcSNtDq2jWHNfjfSyxq5m8jjwLs1EGBXf1x6dBwxmNjKJqcFo5KetOqwhdCiOrJ1AEc5NDpLkDRJ9w9YLdOGRdWpfCYAxjt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448880; c=relaxed/simple;
	bh=D8dmCbnX6rijB2nPz1wQDTif25zMAHPrUq0OSfJuNeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr8jeByTT+2qwF71TFcRFtkZLR5S6kC7CnF7JNVRZQz2jgd8hpBuBQhaicSAl/oK4A+hAMfbH81W3/stOeGOY54EFnSirdYTVQSP3aXRUzgo9GD02WFd3APjfJs4bV8vQ+GkrV7ldJthu0tcakbx0Unppb59QrvbFiKxl5k1gYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5j0NKIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652ACC433F1;
	Thu, 14 Mar 2024 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710448880;
	bh=D8dmCbnX6rijB2nPz1wQDTif25zMAHPrUq0OSfJuNeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5j0NKIgtC9wYzEQDR7OqXRqnqwvYIK6xaMMZELt10g+TDIYs2sG/ZzPOC0RfzHLr
	 3d6iDw4Vn4IP8s8zK97INEis4zXyGyisQKNUnbfFoQh/eNtf9IkXAQCdn859mbKGNY
	 m2tHSJI4S/X1A/bxniT3FSCKD5w6I/0z6Yh0StWCLl8D/+4ojCS3V2fOEAAw4ICCim
	 LzOplpM0A0NYvBM+dbgg0f+rOd0AE8Bo2vZdBB90d5o0trWYOj5i+VgoE/uBiCbfup
	 SDpJkdBDWtb1TyvT08xT+mOwXXLKda6UdycdcRGdiFYXWrR9jRuxjg5iLObCjSZ48b
	 NSq7SnRX42hug==
Date: Thu, 14 Mar 2024 20:41:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Qingfang Deng <dqfext@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID: <20240314-pep-announcer-2d7f10ff8b65@spud>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7VnajYQ5dXc+P0Cg"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>


--7VnajYQ5dXc+P0Cg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 09:31:26AM +0800, Inochi Amaoto wrote:
> On Tue, Mar 12, 2024 at 02:07:31PM +0000, Conor Dooley wrote:
> > On Mon, Mar 11, 2024 at 03:56:29PM +0800, Qingfang Deng wrote:
> > > Hi Inochi,
> > >=20
> > > On Mon, Mar 11, 2024 at 3:13=E2=80=AFPM Inochi Amaoto <inochiama@outl=
ook.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2024 at 02:30:18PM +0800, Qingfang Deng wrote:
> > > > > T-Head C908 has the same IRQ num and CSR as previous C9xx cores, =
but
> > > > > reports non-zero marchid and mimpid. Remove the ID checks.
> > > > >
> > > >
> > > > Hi, Qingfang,
> > > >
> > > > IIRC, the existed C908 SoC (such as K230) have an early version
> > > > of C908 core. But C908 core itself may support Sscofpmf.
> > > > So I do not think removing the ID checks is a good idea. Instead,
> > > > I suggest adding CPUID of your SoC to this check.
> > >=20
> > > As of Feb 2024, the latest C908 revision does not support Sscofpmf.
> > > You may Google "C908R1S0" to see its user manual.
> > > But I think you're right. Even though C908 does not have Sscofpmf,
> > > T-Head may release new SoCs which do have Sscofpmf, and the check will
> > > break. I will submit a new patch with your suggested changes.
> >=20
> > If on an SoC where they have updated vector to 1.0 and implemented both
> > Zicbom and Svpbmt instead of their custom stuff they did not implement
> > Sscofpmf I think we can expect they won't move away from their custom
> > implementation soon.
> > I do agree that we should not remove the ID checks entirely, but I also
> > do not want to be adding an ID for every SoC that needs this. I think we
> > should be getting this information from DT going forward.
> > The DT parsing is done prior to the application of boot time
> > alternatives, so I think we could apply the "erratum" based on the DT.
> >=20
> > I'm also pretty sure that we can also modify the existing code for the
> > archid =3D=3D impid =3D=3D 0x0 case to set a pseudo isa extension so th=
at the
> > perf driver could do call riscv_isa_eextension_available() and not worry
> > about the specfic conditions in which that is true. It'd be something
> > like this patch:
> > https://lore.kernel.org/linux-riscv/20240110073917.2398826-8-peterlin@a=
ndestech.com/
> > Just without removing the archid =3D=3D impid =3D=3D 0x0 case from the =
errata
> > code. If you're lost after reading that, I can probably throw together
> > some untested code for it.
>=20
> I agree to use something to replace the existing check, but using a pseudo
> isa extension is not a good idea. There are two reasons:=20
>=20
> 1. Pseudo isa is misleading. As it is not the real isa, setting this in i=
sa
> list may make userspace think errata a feather.

If we wanted to suppress sharing this information to userspace we could,
but I don't even see what the harm is in userspace knowing.
I also disagree with this even really being an erratum in the first place
as they implemented something before a spec was created. It's not an
implementation of Sscofpmf with a bug. I don't think that calling it a
"real" vendor extension is problematic either, just I am the one calling
it that, not T-Head themselves.

> 2. Using pseudo isa is more like an abuse of reserved isa bits, which mea=
ns
> kernel may need infinite bits to handle the errata.

What makes it an abuse of a "reserved" bit? There's no rule on
disallowing something vendor-specific there. Given the amount of standard
ISA extensions that are being created compared to CPU errata, I don't
think that I'm particularly worried about vendor specific stuff being
the reason for infinite bits being needed either.

If there do come to be issues with the number of extensions we care
about, we could split things per vendor I suppose.

> IMHO, it may be better to use a new DT property like "riscv,cpu-errata" or
> "<vendor>,cpu-errata". It can achieve almost everything like using pseudo
> isa. And the only cost I think is a small amount code to parse this.

I suppose we could do that, but accounting for vendor specifics was one
of the goals for the property I only just added and that I am suggesting
to use here.

--7VnajYQ5dXc+P0Cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfNg6wAKCRB4tDGHoIJi
0pvxAP9f5n67FdcXaDeJLe8wvqIkMnLvLHJt1Uimlhexcor/lgEAkHeDx1gCVOz4
gSFJsa/+ha0YnGA/h8Ili4wHIx6rhA0=
=9+If
-----END PGP SIGNATURE-----

--7VnajYQ5dXc+P0Cg--

