Return-Path: <linux-kernel+bounces-149608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B67E8A936C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03F7282225
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B3976029;
	Thu, 18 Apr 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sv8hVM3H"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0D77F2D;
	Thu, 18 Apr 2024 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422676; cv=none; b=DOg3TeQpYcR2rCzIHA7iIVpk8xZ/xEFGAcVnsFizE0hmn/7+beXcoP4jlUvv1BUaMrBKnGGfMID9CKob+Vk/517woLPqq3w51i6ThGSnB6STMueNxXbPPSX9G3HVeBshSeAQHiBNajOkYtV9ymaoytLwYlQD/LFkyZn9opGe4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422676; c=relaxed/simple;
	bh=F4j2YeFDdlVC8020K/Vmjs/sUEilFa5SrR5hL+gvFT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj/kXB9dEoz2HotzW0z1im0pOzM1MogieMmvQ0XmTb0xJaEi6wivvJD7CYnurlL+4vdzhF56PneZIoVcZOfI/96tuDKIFMYgXcy9NVMWd7eVlSHgKfV+EVHs/gl4H5RzzAyNT1OZNO5ZocnMp+mR7SUPCL8VKEIMO8WGLkxCr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sv8hVM3H; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43I6iHpb129585;
	Thu, 18 Apr 2024 01:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713422657;
	bh=90nyYzTpix82xLJuEEoTch0nJmxT21KfiXvrixbJ65w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sv8hVM3H+hR5A8dqlG9g7pm6vM8TGedLfXktfBdxO0+yomNvG6ZAd2va/R6gjby0V
	 z5Nk4LYXQLQgwb3gks78vHpV8HldHS5gtmiRQpRM9fA/Lf60DCr1CuwVaxsOlLjM1z
	 yq0QqKsvoFqnOCG3J5Fgc4DYwbjT4dHrQVFYQ2QU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43I6iGku021731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 01:44:17 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 01:44:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 01:44:16 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43I6iFJq099234;
	Thu, 18 Apr 2024 01:44:16 -0500
Date: Thu, 18 Apr 2024 12:14:15 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
CC: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Joao Paulo Goncalves
	<joao.goncalves@toradex.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Fix race condition during probe
Message-ID: <nhfnj5b44lrsh57ffxzsj5la6q36llq4qptyenmaor4xhnbqem@skyzmn4fyhkd>
References: <20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yxhrp7awxfgehq5t"
Content-Disposition: inline
In-Reply-To: <20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--yxhrp7awxfgehq5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joao,

On Apr 17, 2024 at 15:41:38 -0300, Joao Paulo Goncalves wrote:
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>=20
> When using davinci-mcasp as CPU DAI with simple-card, there are some
> conditions that cause simple-card to finish registering a sound card befo=
re
> davinci-mcasp finishes registering all sound components. This creates a
> non-working sound card from userspace with no problem indication apart
> from not being able to play/record audio on a PCM stream. The issue
> arises during simultaneous probe execution of both drivers. Specifically,
> the simple-card driver, awaiting a CPU DAI, proceeds as soon as
> davinci-mcasp registers its DAI. However, this process can lead to the
> client mutex lock (client_mutex in soc-core.c) being held or davinci-mcasp
> being preempted before PCM DMA registration on davinci-mcasp finishes.
> This situation occurs when the probes of both drivers run concurrently.
> Below is the code path for this condition. To solve the issue, defer
> davinci-mcasp CPU DAI registration to the last step in the audio part of
> it. This way, simple-card CPU DAI parsing will be deferred until all
> audio components are registered.

Good catch, thanks for the fix.

Reviewed-by: Jai Luthra <j-luthra@ti.com>

>=20
> Fail Code Path:
>=20
> simple-card.c: probe starts
> simple-card.c: simple_dai_link_of: simple_parse_node(..,cpu,..) returns E=
PROBE_DEFER, no CPU DAI yet
> davinci-mcasp.c: probe starts
> davinci-mcasp.c: devm_snd_soc_register_component() register CPU DAI
> simple-card.c: probes again, finish CPU DAI parsing and call devm_snd_soc=
_register_card()
> simple-card.c: finish probe
> davinci-mcasp.c: *dma_pcm_platform_register() register PCM  DMA
> davinci-mcasp.c: probe finish
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9fbd58cf4ab0 ("ASoC: davinci-mcasp: Choose PCM driver based on con=
figured DMA controller")
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index b892d66f78470..1e760c3155213 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2417,12 +2417,6 @@ static int davinci_mcasp_probe(struct platform_dev=
ice *pdev)
> =20
>  	mcasp_reparent_fck(pdev);
> =20
> -	ret =3D devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_comp=
onent,
> -					      &davinci_mcasp_dai[mcasp->op_mode], 1);
> -
> -	if (ret !=3D 0)
> -		goto err;
> -
>  	ret =3D davinci_mcasp_get_dma_type(mcasp);
>  	switch (ret) {
>  	case PCM_EDMA:
> @@ -2449,6 +2443,12 @@ static int davinci_mcasp_probe(struct platform_dev=
ice *pdev)
>  		goto err;
>  	}
> =20
> +	ret =3D devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_comp=
onent,
> +					      &davinci_mcasp_dai[mcasp->op_mode], 1);
> +
> +	if (ret !=3D 0)
> +		goto err;
> +
>  no_audio:
>  	ret =3D davinci_mcasp_init_gpiochip(mcasp);
>  	if (ret) {
> --=20
> 2.34.1
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--yxhrp7awxfgehq5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmYgwTsACgkQQ96R+SSa
cUWXrBAApnBEaeieeTJxw4vOCZ+HgP2Btgkjs72DfMCPJiJ/5cmgjRJiZNk2Xbzh
1jWiwvjvk0saPdbb1RyXvXo+sOKsYBlRQS8i8kpOIsx6S7eqZlsF9kkMcotiDe3m
zL4hQpcwevYmVCqnnTaZfTHAyMN2Tk+I7Np/I+86MgOt86L0N3GVPjlTts2EeKDY
/dfoDYgFfWqRfdZmGSFxVl4YdEmrwwvNK0u2CrUgXuSkvBhjQ6CZ0FW7GVH7z0nd
EBCT+ssdfPQK4Y5WlDrAfmlc3qSnhNoleSsDa1XjM58NadRZ/yq9t+rYWsQmRXVf
fTOdaCoWIyN1Iz66SxCZ2kJLpyTiQgwn2sM2UaE5IVCMaPjWorI2Ae9KqoGu/ygA
2sU37vn7gPBfT7+Y4t8OKrZIglYJ/CQEHcKrUjLfoRo5XcGfwdi0iLJmwNhnGLjs
rIClOzHfTmgRhioIOn2Ha7W5IW9it8StDt2LR4zCd3+gLNB/pyppKk1LPGy3VxE+
k0SuLkRNMWi3UHGrzyJnFb7YmWZbdlHAfd5NQWIwOarPt+PrwSfhrCj2qWkIV/38
qIir+32qM8LpYEbURnN/BzH/P6Z+c5/37E0fSe3eFa+Yajk1YmVM/d+I0arUMajJ
pU88RuDWpkvX6floGYsv4+lZ5DPG3ifNch0Lra1iL99jAJlf4iY=
=DnJd
-----END PGP SIGNATURE-----

--yxhrp7awxfgehq5t--

