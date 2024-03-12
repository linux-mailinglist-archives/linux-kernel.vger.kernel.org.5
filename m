Return-Path: <linux-kernel+bounces-100319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EAA8795AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A392836C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6A7A72D;
	Tue, 12 Mar 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5Rje2GO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589D78298
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252457; cv=none; b=bkQmuWOfX8D4WEna6y9zS09bEbRDGXKDfRIRqXiE74cWs7Mb1PslPcNvH67ZPs7qhUI3WD8vn5o18oazN9UhBjtA++ww+pEtf9fFcM8CmyuS2ms07NJ8q5v0CcFHx8jo6FxuiMgd5/+T9vI7/Hii9a8T59tilFOYx8dS1U5n4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252457; c=relaxed/simple;
	bh=VxlpGxDihZXj7jY5GEg/ShwUNDeC49+jqJqaSIfPhsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNKFhnlQ1XR22fhKe95I6xhaghP7tJ+6S3UUPzNi86aQwhzFGN4ImwMHOcbgqE046lYPTsAsstjEif1bEBetATU49Gv9BcijB5vfGdd0S8PkHLuRWAkxymZgFgsk50dbSZOxqUBoNHqi1loBZd0PSoezFrhgd2e0IV/LMxU5thI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5Rje2GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAEEC433C7;
	Tue, 12 Mar 2024 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710252457;
	bh=VxlpGxDihZXj7jY5GEg/ShwUNDeC49+jqJqaSIfPhsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5Rje2GOhhmmf2q6wh8tnNGuD3tTEdAt2GDgKJqBRsX83vpcz+vGfagvrnOnCBkML
	 jSth+OmJ0TmjvkKv/FHbMjGA9SKfvslDXJiOSsUgD/Qzf+nHqxX5fOv24mr0lK42ed
	 MVPfgfPkavIORcva44kvaPz20jSzsV6BY3BETPNO2nkia7j0w9Qth401Nx1dWJOpDj
	 0sHQKRzLSyrUiHHiGbnhg45kuRXaRhBokjUDzKs7sXjTrWg6f4oDGiOIH7oUY9w0Z+
	 6pzkeManYXfsh0kdOBXcQOWR6G0ULbZVy5Bh9UH5NVPMLppD3yUZZfadwNclBfbHhl
	 r3oA8T0eYwlwg==
Date: Tue, 12 Mar 2024 14:07:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Inochi Amaoto <inochiama@outlook.com>,
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
Message-ID: <20240312-evil-resource-66370b68b9b4@spud>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pq4l/U+EGNQPJ6t+"
Content-Disposition: inline
In-Reply-To: <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>


--Pq4l/U+EGNQPJ6t+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 03:56:29PM +0800, Qingfang Deng wrote:
> Hi Inochi,
>=20
> On Mon, Mar 11, 2024 at 3:13=E2=80=AFPM Inochi Amaoto <inochiama@outlook.=
com> wrote:
> >
> > On Mon, Mar 11, 2024 at 02:30:18PM +0800, Qingfang Deng wrote:
> > > T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
> > > reports non-zero marchid and mimpid. Remove the ID checks.
> > >
> >
> > Hi, Qingfang,
> >
> > IIRC, the existed C908 SoC (such as K230) have an early version
> > of C908 core. But C908 core itself may support Sscofpmf.
> > So I do not think removing the ID checks is a good idea. Instead,
> > I suggest adding CPUID of your SoC to this check.
>=20
> As of Feb 2024, the latest C908 revision does not support Sscofpmf.
> You may Google "C908R1S0" to see its user manual.
> But I think you're right. Even though C908 does not have Sscofpmf,
> T-Head may release new SoCs which do have Sscofpmf, and the check will
> break. I will submit a new patch with your suggested changes.

If on an SoC where they have updated vector to 1.0 and implemented both
Zicbom and Svpbmt instead of their custom stuff they did not implement
Sscofpmf I think we can expect they won't move away from their custom
implementation soon.
I do agree that we should not remove the ID checks entirely, but I also
do not want to be adding an ID for every SoC that needs this. I think we
should be getting this information from DT going forward.
The DT parsing is done prior to the application of boot time
alternatives, so I think we could apply the "erratum" based on the DT.

I'm also pretty sure that we can also modify the existing code for the
archid =3D=3D impid =3D=3D 0x0 case to set a pseudo isa extension so that t=
he
perf driver could do call riscv_isa_eextension_available() and not worry
about the specfic conditions in which that is true. It'd be something
like this patch:
https://lore.kernel.org/linux-riscv/20240110073917.2398826-8-peterlin@andes=
tech.com/
Just without removing the archid =3D=3D impid =3D=3D 0x0 case from the erra=
ta
code. If you're lost after reading that, I can probably throw together
some untested code for it.

Thanks,
Conor.

--Pq4l/U+EGNQPJ6t+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfBhowAKCRB4tDGHoIJi
0qpNAQDkCoYYNr9WEQUhd2aEI/zbE3vwTfDh+2GK9L7+lQaBUAD/Ub+ksm3LncKt
mAWaii+Of3v6TKIm+8K1yjxEtDdKlQE=
=5JMP
-----END PGP SIGNATURE-----

--Pq4l/U+EGNQPJ6t+--

