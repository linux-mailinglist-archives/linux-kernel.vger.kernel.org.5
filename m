Return-Path: <linux-kernel+bounces-117232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6988A8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D653657B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04313DDB6;
	Mon, 25 Mar 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIJBcOZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC2153806;
	Mon, 25 Mar 2024 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376298; cv=none; b=AN1me4kNceDB7wYqF1cErRj3Gm/+yXVPbOKE/a60KGkJXYbxpBQ1I39FJh4hTdP313SMpWZGYzy+49GlydfCchGxG/YQnz/D7ohlMym/Wc9A3FHddzYauDlqrrbi1JLkgFSSJF+h7I1fK+OWQvauk2tKm72W/U6BQCqVWeZe9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376298; c=relaxed/simple;
	bh=jbD2Lb5wA/eUCNXCJLVthr6/MzEiKX6SqxWZxnTuOnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhIhKkT2YqMOINhxnxyGwNB1kyRxXZ7Wwe0PQeJfOgVC0YDtV43ESpld4We7mlMMO7WD8tk5m6tRRWulbbEd45/rRZBisz3cGZp5xXqD9mgLF2IdZGUmtSpN/Lh1CrE7jIEV37KJ2rW3z/5HhxfyZaxIOBfMLw3g1uAQKYfe+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIJBcOZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551B6C3278D;
	Mon, 25 Mar 2024 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711376298;
	bh=jbD2Lb5wA/eUCNXCJLVthr6/MzEiKX6SqxWZxnTuOnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIJBcOZwUhINwFcGdCy+3ok576TN9S810xuZ8ZzXc+YsDCkkdm2aFq4Rb/QQx0lUi
	 1wCvxXFctAcTrEW1JWL8HrusNRZ090ozLa1y+/4W1HSAvRJjjagI3SeojbTeSEOpth
	 JVqpRvqwRP4xMipGrKVSugC394E0I0wHmQz9uqnRmKjiVb/ma5GFpOxfhYS80hw1VN
	 kVa+H456ovUt/aptnwA12NIMQRD+kFb7iLum3bA1g0EF9EYSVIOthLrTUNXqEuuQBR
	 8qkEq2K1UK+3Qux+vNE58QmXDQuoGAu7RuT+3ssdB6orI+bYKjCVexSqifI7VacJfd
	 +OE8pqjMaaDuA==
Date: Mon, 25 Mar 2024 14:18:08 +0000
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
	trevor.wu@mediatek.com, maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com, shraash@google.com,
	amergnat@baylibre.com, nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de, dianders@chromium.org,
	frank.li@vivo.com, allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com, ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com, nfraprado@collabora.com,
	alsa-devel@alsa-project.org, shane.chien@mediatek.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 05/22] ASoC: mediatek: Add common machine soundcard
 driver probe mechanism
Message-ID: <6b9dd2ad-a24e-497a-8a5c-c7c04475cf5d@sirena.org.uk>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
 <20240313110147.1267793-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HA8wmAlBS5gx6s1i"
Content-Disposition: inline
In-Reply-To: <20240313110147.1267793-6-angelogioacchino.delregno@collabora.com>
X-Cookie: Is it clean in other dimensions?


--HA8wmAlBS5gx6s1i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:01:30PM +0100, AngeloGioacchino Del Regno wrote:
> Add a common machine soundcard driver probe function that supports both
> DSP and AFE-direct usecases and also provides a hook for legacy machine
> soundcard driver probe mechanisms.
>=20
> Note that the hook is there because, even for legacy probe, a lot of the
> actual code can still be commonized, hence still reducing duplication
> for the legacy devicetree retrocompatibility cases.
>=20
> This common probe function deprecates all of the inconsistent previous
> probe mechanisms and aims to settle all of the MediaTek card drivers on
> consistent and common devicetree properties describing wanted DAIs,
> device specific DAI configuration and DAI links to codecs found on
> each device/board.

This breaks allmodconfig builds:


/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In funct=
ion =E2=80=98mtk_sof_dai_link_fixup=E2=80=99:
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:18:41: er=
ror: initialization discards =E2=80=98const=E2=80=99 qualifier from pointer=
 target type [-Werror=3Ddiscarded-qualifiers]
   18 |         struct mtk_sof_priv *sof_priv =3D soc_card_data->sof_priv;
      |                                         ^~~~~~~~~~~~~
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In funct=
ion =E2=80=98mtk_sof_card_probe=E2=80=99:
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:58:41: er=
ror: initialization discards =E2=80=98const=E2=80=99 qualifier from pointer=
 target type [-Werror=3Ddiscarded-qualifiers]
   58 |         struct mtk_sof_priv *sof_priv =3D soc_card_data->sof_priv;
      |                                         ^~~~~~~~~~~~~
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In funct=
ion =E2=80=98mtk_sof_find_tplg_be=E2=80=99:
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:76:41: er=
ror: initialization discards =E2=80=98const=E2=80=99 qualifier from pointer=
 target type [-Werror=3Ddiscarded-qualifiers]
   76 |         struct mtk_sof_priv *sof_priv =3D soc_card_data->sof_priv;
      |                                         ^~~~~~~~~~~~~
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In funct=
ion =E2=80=98mtk_sof_check_tplg_be_dai_link_fixup=E2=80=99:
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:116:41: e=
rror: initialization discards =E2=80=98const=E2=80=99 qualifier from pointe=
r target type [-Werror=3Ddiscarded-qualifiers]
  116 |         struct mtk_sof_priv *sof_priv =3D soc_card_data->sof_priv;
      |                                         ^~~~~~~~~~~~~
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c: In funct=
ion =E2=80=98mtk_sof_card_late_probe=E2=80=99:
/build/stage/linux/sound/soc/mediatek/common/mtk-dsp-sof-common.c:147:41: e=
rror: initialization discards =E2=80=98const=E2=80=99 qualifier from pointe=
r target type [-Werror=3Ddiscarded-qualifiers]
  147 |         struct mtk_sof_priv *sof_priv =3D soc_card_data->sof_priv;
      |                                         ^~~~~~~~~~~~~
cc1: all warnings being treated as errors

--HA8wmAlBS5gx6s1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBh58ACgkQJNaLcl1U
h9Dw2Qf+OK6uEVJdUDAeL+cRMOtxJ5v8lWJ4kCDEd4EzMY8PITg8YZaxDb1HJs18
yfD4+oR2f/uMSGayxCnuRgzBthSs96xOJ34EkRpUgsB81RrC1Jjv5zWwIP1SCQlN
e2rKPS4ccBdE5uowKduc5TIbqbgbjLCArqTpqHDX6IBQP4A3SqYkcv/tOwFHuC/t
kE6+fH8gG7hQ9no9cE3WumRCLDyE8rRca6smAENrfcco8/5DCg2LqJ+SOEC64X+o
TYw0mmtRwPdObNmdHyrCtfk9XppdDLh21bKZrQvpj7WW2+EqSzbYLdyxvArVbzMq
bEqhwUbisC0nv6/RJbKsKWZy/N3IUA==
=6CF1
-----END PGP SIGNATURE-----

--HA8wmAlBS5gx6s1i--

