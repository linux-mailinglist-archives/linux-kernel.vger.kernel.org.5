Return-Path: <linux-kernel+bounces-157716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D308B1500
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9066B1C2337A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649515697B;
	Wed, 24 Apr 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4cYjUuW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADC13B5A6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992646; cv=none; b=sceTucMWShGSXhdX+xWKKANcfe/DzQrZLXybBZSNOZfyPHMiOfa31CvblpLy4gNvjDn42dzOJvluIrnLSh2n9uF/GKfNtKviOBgl09qDrj9UubSSW0dKs41G8vq3d3AiKtiBLBjW87DqVY3Qk2M382VsPb8jCGkItjVRl56ETn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992646; c=relaxed/simple;
	bh=ix7rFjnRQ5SWxjWOREETBLkfLTNt4KOdjYJOgb7Wa48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzLdhx6+pLu2uRm/EBu1yLn6djLvJ0Z2mNp7YDIxoi4e2HHYIfmqfmW7DVGzprLaYg9t1o4Pf3Yg3qfyU0nyy6jjeh0JqMls6SKcDW3FQzliJA9uFZ+1tkQZGKq/SakGU4sWMpUOjAW4LFtxs6OJJjRfCWB+pBONuQjn8LyM47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4cYjUuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6D6C113CD;
	Wed, 24 Apr 2024 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713992645;
	bh=ix7rFjnRQ5SWxjWOREETBLkfLTNt4KOdjYJOgb7Wa48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4cYjUuW8XffaDl3CZU7iBmJufxV2K/uEbL1nYrLyla8Be12TP7BOnAm6MISwLe4n
	 +owZwshXH8swXvz9hMJc0kwliUxlxtohLnnV3kLVoFR/LIWYowsTuHdqonRZY7Sz5w
	 FFM/PaSN8h3yUULKDhcpSW0z45yxrK3KvLPjpCiiTeNRaGGmfuJuQMwRmwiXwrlqsw
	 JVJTpGPmH2Nennyl2mfSdwfR1p3xGAItCa/NuWtMKogADPb79uaT6jcG28TheTNa/X
	 O7cmhIGit6DtHQOvp1RFS75/PtwpD7M6BO7tF3tsUJlDCtHtmIe7dKCJ2mmd4kmGYD
	 31yX/xnnLpW8w==
Date: Wed, 24 Apr 2024 22:04:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] firmware: microchip: don't unconditionally print
 validation success
Message-ID: <20240424-overthrow-punch-75d29c804296@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
 <20240410-throwing-sandworm-7d03e4e2f4e8@spud>
 <46925bcd-ad92-4c02-90f3-11da5c627391@ghiti.fr>
 <20240424-impish-platonic-5edf54ffda92@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ifV/mwX84ctBZOL3"
Content-Disposition: inline
In-Reply-To: <20240424-impish-platonic-5edf54ffda92@spud>


--ifV/mwX84ctBZOL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 09:59:36PM +0100, Conor Dooley wrote:
> On Wed, Apr 24, 2024 at 10:26:35PM +0200, Alexandre Ghiti wrote:
> > Hi Conor,
> >=20
> > On 10/04/2024 13:58, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >=20
> > > If validation fails, both prints are made. Skip the success one in the
> > > failure case.
> > >=20
> > > Fixes: ec5b0f1193ad ("firmware: microchip: add PolarFire SoC Auto Upd=
ate support")
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >   drivers/firmware/microchip/mpfs-auto-update.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/=
firmware/microchip/mpfs-auto-update.c
> > > index 33343e83373c..298ad21e139b 100644
> > > --- a/drivers/firmware/microchip/mpfs-auto-update.c
> > > +++ b/drivers/firmware/microchip/mpfs-auto-update.c
> > > @@ -218,10 +218,12 @@ static int mpfs_auto_update_verify_image(struct=
 fw_upload *fw_uploader)
> > >   	if (ret | response->resp_status) {
> > >   		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
> > >   		ret =3D ret ? ret : -EBADMSG;
> > > +		goto free_message;
> > >   	}
> > >   	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
> > > +free_message:
> > >   	devm_kfree(priv->dev, message);
> > >   free_response:
> > >   	devm_kfree(priv->dev, response);
> >=20
> >=20
> > This should go into -fixes, but not sure if you take care of this or if
> > Palmer should, please let me know so that I can remove this from my lis=
t :)
>=20
>=20
> Yea, probably this and "firmware: microchip: clarify that sizes and
> addresses are in hex" should go on fixes. FYI, I usually set the
> delegate on patchwork for things that I take to me, so generally you
> should be able to tell from that.

I picked up 2 and 3. I'll send a PR with them later in the week, thanks
for the reminder. Patches like these I kinda dislike applying without a
review, but don't really get reviewed unless I harass someone at work to
do so, which I did not do here.

Cheers,
Conor.

--ifV/mwX84ctBZOL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZilzwgAKCRB4tDGHoIJi
0vppAQC+iCnthozRZn/Qlrt86aJDn/JQ/efXnyPpP3OXNvYZbwEA3I9jtWV2vFwI
q0P3V+3MafmQrL5VNaaXW1n5RvYlLgw=
=aDBO
-----END PGP SIGNATURE-----

--ifV/mwX84ctBZOL3--

