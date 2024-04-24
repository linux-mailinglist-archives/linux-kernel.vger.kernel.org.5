Return-Path: <linux-kernel+bounces-157712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58508B14F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1551C2193D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BAC156971;
	Wed, 24 Apr 2024 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3ncoNB6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DE13A401
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992380; cv=none; b=enipPYqg3/7jpB7+SOEVChAZSuwPMTdsj8ZWNvzgKn2HA218wmxDaUTgy+Y8HxiuRfDGMdUJiDcVNXHFG9fQ39tN0AQP+nMKzvI+IltTAIk/G2l1xNV85yQoo93udKN+XSxiovvuNGd6wcQ3N653yBdRfGE1+wohDx/90efK7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992380; c=relaxed/simple;
	bh=AtbHrS/SRHBMPOyZWKxUQceaSfXzElYHYKOrTpS9txM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMipxQaiRvEdCABljtq0iGXztbt4D9Aj+7KSPxZGe4A1BhuL1b3PMqCka2SeJ5GszvgFAzLTZVWWtQ5L284ya7lT99AuFRwtI5C8tnBUTJC7TvELg+03nBYTQwGT1ICMRMdbb5jxiqeiWrbFWqV9CTitoVVxElGZKsUMmNhmVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3ncoNB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67CFC113CD;
	Wed, 24 Apr 2024 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713992380;
	bh=AtbHrS/SRHBMPOyZWKxUQceaSfXzElYHYKOrTpS9txM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3ncoNB6xJbHsBwLMGl9yGOIyBnLv69hx3sUqeXYBUgZIP8WuXJ+7udJKg5sFbvGM
	 UeZj3tVu15TUd/6GsoH0zjDko2v3Q5MjMKi+/eybAQuFU1yJWtxpxyDA8M9fDou5hx
	 HaK7BQ0ODJU99BoU5QwTQ+tcsFBu+jqbXdHgZE0lx0OYt3fJrKhZj6sjPAgERXr28z
	 hNno4vUlPVVi8FCWTfFo7t2ucUfLNELfU41oZPK3HVTZf7XLdyjF+DrzuvTEeOt6lb
	 Evy30KTiG/24zmWpu3giejMvv8A+XTpKN3vdOMo/HGw4PXLsxadJbk3BuEidaKLL3y
	 lTcXDaxYwTnNA==
Date: Wed, 24 Apr 2024 21:59:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] firmware: microchip: don't unconditionally print
 validation success
Message-ID: <20240424-impish-platonic-5edf54ffda92@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
 <20240410-throwing-sandworm-7d03e4e2f4e8@spud>
 <46925bcd-ad92-4c02-90f3-11da5c627391@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wfvFrLcwJu/CsjjT"
Content-Disposition: inline
In-Reply-To: <46925bcd-ad92-4c02-90f3-11da5c627391@ghiti.fr>


--wfvFrLcwJu/CsjjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:26:35PM +0200, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On 10/04/2024 13:58, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > If validation fails, both prints are made. Skip the success one in the
> > failure case.
> >=20
> > Fixes: ec5b0f1193ad ("firmware: microchip: add PolarFire SoC Auto Updat=
e support")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >   drivers/firmware/microchip/mpfs-auto-update.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/fi=
rmware/microchip/mpfs-auto-update.c
> > index 33343e83373c..298ad21e139b 100644
> > --- a/drivers/firmware/microchip/mpfs-auto-update.c
> > +++ b/drivers/firmware/microchip/mpfs-auto-update.c
> > @@ -218,10 +218,12 @@ static int mpfs_auto_update_verify_image(struct f=
w_upload *fw_uploader)
> >   	if (ret | response->resp_status) {
> >   		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
> >   		ret =3D ret ? ret : -EBADMSG;
> > +		goto free_message;
> >   	}
> >   	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
> > +free_message:
> >   	devm_kfree(priv->dev, message);
> >   free_response:
> >   	devm_kfree(priv->dev, response);
>=20
>=20
> This should go into -fixes, but not sure if you take care of this or if
> Palmer should, please let me know so that I can remove this from my list =
:)


Yea, probably this and "firmware: microchip: clarify that sizes and
addresses are in hex" should go on fixes. FYI, I usually set the
delegate on patchwork for things that I take to me, so generally you
should be able to tell from that.

Cheers,
Conor.


--wfvFrLcwJu/CsjjT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZilyuAAKCRB4tDGHoIJi
0u8sAQDXfCnN72t0usUB/TxsxGQh0meKlPPQxL/1JGYczIUeNAD+OrnpAgicXCAn
OWkhvywo60dsKPA2IK3qlkCprCFbkwQ=
=oLCZ
-----END PGP SIGNATURE-----

--wfvFrLcwJu/CsjjT--

