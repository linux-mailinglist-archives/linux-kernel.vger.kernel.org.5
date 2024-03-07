Return-Path: <linux-kernel+bounces-96250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CD887593B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250811C20E46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA813B79B;
	Thu,  7 Mar 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6M0hn9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87624138497;
	Thu,  7 Mar 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846971; cv=none; b=NZ946lI4mEOGPGVxP3rJpzItN7lKJOj+GNffGdrccGv7/UUZWtbvasPzTH6HuMvbDJITzcfwJF01MiUEmOn/Bci312OZQK6KgqW+Js0pkSAl3Q1MCN/75Pia4TiOkB1mCe8pDZ70IfNdu9yVnYzVEMtpbnBBQCwCdzOfiaMe9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846971; c=relaxed/simple;
	bh=HE1ZAIAEp6ujzFJHi+0GrvFAheNm6mH4Io3mGj+1sI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1au2mo+KM5t0MPJtLNA/Ka51KZVqCBzQaVT5V1LnKrmMT0P3cHb5+aVAOPquSSETliJta2QdcF6vptm1ikA1cXOjFPa2ijSxyHTjLXLIgUNUs9RL497VZ0ka2F0DAiuX9l+Qn1DNdAXgmx5/ehgT3FuHmf/4rHDfovg4isvXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6M0hn9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD2EC43390;
	Thu,  7 Mar 2024 21:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709846971;
	bh=HE1ZAIAEp6ujzFJHi+0GrvFAheNm6mH4Io3mGj+1sI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6M0hn9vfAj39Z7b85xV/LSMmxWs2UR+hnbO3sEP9duy2Ul7X5klX1iYYFc4iEf/6
	 EyBA6PLodCu4YsF7JJcgDLs1XVXsV8l5KMyklyax9iSsoWF1+/nB1PLVol5zCrbn4C
	 48xe/JVFAMOj2kdtfuYu3nd8nTorcuEsv+r8ozWziECcItFxMYuwrK4LEt6RUflkV9
	 yutgQX9sWO0reOhhy0si0wm7oz1ih291O+A2nNdNSr5J5nez0O3ZoDIxSYH00TP2lF
	 jvUMQ/lFaSJ8RrQlvHfOFmKD3P3U5MbL9x2CW1Mxje+yhj7lY7rhfKeq33FGM9Z/Of
	 rdwLuRrIAPKcg==
Date: Thu, 7 Mar 2024 21:29:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, conor.dooley@microchip.com,
	nayna@linux.ibm.com, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org, jarkko@kernel.org,
	rnsastry@linux.ibm.com, peterhuewe@gmx.de, viparash@in.ibm.com
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
Message-ID: <20240307-freely-sassy-cae2bdeae800@spud>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
 <87jzmenx2c.fsf@mail.lhotse>
 <768fc5f1-3919-477e-a8e6-16a7e8536add@linux.ibm.com>
 <20240307-cytoplasm-compare-6656aae737ac@spud>
 <71c151b2-b03a-49a7-87b9-fc902b0cf328@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HM7wPvaND7fChimB"
Content-Disposition: inline
In-Reply-To: <71c151b2-b03a-49a7-87b9-fc902b0cf328@linux.ibm.com>


--HM7wPvaND7fChimB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 04:15:01PM -0500, Stefan Berger wrote:
>=20
>=20
> On 3/7/24 15:39, Conor Dooley wrote:
> > On Thu, Mar 07, 2024 at 10:11:03AM -0500, Stefan Berger wrote:
> > > On 3/7/24 05:41, Michael Ellerman wrote:
> > > > Stefan Berger <stefanb@linux.ibm.com> writes:
> >=20
> > > >=20
> > > diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> > > b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> > > index 3c1241b2a43f..591c48f8cb74 100644
> > > --- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> > > +++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> > > @@ -30,6 +30,11 @@ properties:
> > >         size of reserved memory allocated for firmware event log
> > >       $ref: /schemas/types.yaml#/definitions/uint32
> > >=20
> > > +  linux,sml-log:
> > > +    description:
> > > +      firmware event log
> >=20
> > Can you provide a more complete description here please as to what the
> > different between this and the other property? If I was populating a DT
> > I would have absolutely no idea whether or not to use this or the other
> > property, nor how to go about actually populating it.
> > The "log" in your example doesn't look like an actual log of any sort,
> > but I know nothing about TPMs so I'll take your word for it that that's
> > what a TPM log looks like.
>=20
> In the example I cannot give a log but only a part of it. The log is in
> binary format and in case of TPM 2.0 starts with a header followed by log
> entries about what was measured. I don't think it's necessary to even give
> the full log header here. You do need some TPM specific knowledge about t=
he
> 'firmware even log'.
>=20
>=20
> The existing properties are described like this:
>=20
>   linux,sml-base:
>     description:
>       base address of reserved memory allocated for firmware event log
>     $ref: /schemas/types.yaml#/definitions/uint64
>=20
>   linux,sml-size:
>     description:
>       size of reserved memory allocated for firmware event log
>     $ref: /schemas/types.yaml#/definitions/uint32
>=20
> Would this describe the new property 'better' by prefixing it with
> 'embedded'?

IMO, no that's not any better. Spell it out so that someone who doesn't
know his arse from his elbow when it comes to tpm immediately knows that
this means the entire tpm log is inside the dtb. The paragraph you wrote
above gives more information about what this property is populated with
than the property description does.

>   linux,sml-log:
>     description:
>       embedded firmware event log
>     $ref: /schemas/types.yaml#/definitions/uint8-array
>=20
>=20
> >=20
> > > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > > +
> > >     memory-region:
> > >       description: reserved memory allocated for firmware event log
> > >       maxItems: 1
> > >=20
> > >=20
> > > Is my patch missing something?
> >=20
> > I think you also need the dependantSchema stuff you had in your original
> > snippet that makes the linux,* properties mutually exclusive with
> > memory-region (or at least something like that).
> >=20
> I modified my new example now like this:
> ...
>             ibm,loc-code =3D "U9080.HEX.134CA08-V7-C3";
>             linux,sml-log =3D <00 00 00 00 03 00 00>;
>             linux,sml-size =3D <0xbce10200>;   <-- added

>             ibm,loc-code =3D "U8286.41A.10082DV-V3-C3";
>             linux,sml-base =3D <0xc60e 0x0>;
>             linux,sml-size =3D <0xbce10200>;
>             linux,sml-log =3D <00 00 00 00 03 00 00>;   <- added
>=20
> It errors out on bad examples, which is good.

Aye, that is covered by your new oneOf for this one binding. The
dependantSchema bit in tpm-common.yaml enforces it for all tpm devices.
It also covers the memory-region property being mutually exclusive with
the linux,sml-{base,size} properties so I think you need to extend that
to also cover linux,sml-lof property.

> > Please make sure you CC the DT maintainers and list on the v2 and Lukas
> > Wunner too.
>=20
> Yes, I have them already cc'ed here.

To: Conor Dooley <conor@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-integrity@vger.kernel.org,=
 linuxppc-dev@lists.ozlabs.org, conor.dooley@microchip.com, nayna@linux.ibm=
=2Ecom, Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, jarkk=
o@kernel.org,
        rnsastry@linux.ibm.com, peterhuewe@gmx.de, viparash@in.ibm.com

You have Lukas, one of the three DT maintainers and not the list as far
as I can see. Correct me please if I am wrong.

Thanks,
Conor.

--HM7wPvaND7fChimB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoxtgAKCRB4tDGHoIJi
0iTlAQC+lgVF1MVkW4LiyDrFodhZNcs01tiw7DhYzmudOhbraAEA5Cq47/2c7Jw4
tafxUPGjqtltnoQxd3Ip5VYZvLXIQwY=
=c4Aj
-----END PGP SIGNATURE-----

--HM7wPvaND7fChimB--

