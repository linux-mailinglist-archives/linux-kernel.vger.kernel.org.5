Return-Path: <linux-kernel+bounces-147812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA48A79FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7321C21919
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B611186A;
	Wed, 17 Apr 2024 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYx9gupW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCBA63A9;
	Wed, 17 Apr 2024 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315165; cv=none; b=rr77Depjq7TuwV9VF9zWgvt7gEWbGTMyheNmsz9gAhfLit5FV+9R4bgMYEHAeAuK8IbntRzKdhYwz/jR1p8hAiDjSBit0AJDE9MdRVrGmdRAWa8ggO7A4jcGKXoUcHePS6AKCEn5mc/bp8JxVT2n0UaEgKw8keV+qQw55ZDf5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315165; c=relaxed/simple;
	bh=YVAp4IOd+ftXbliGWV6sMKzUBLNAQxl+/AiTbHPv/7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5oFjoqbg1HKoP50eeSQbnvNXH1/EQL2y/Q/nUi6TVnXIhwIePVxMcj6os8BpuaGh2W9X33PgcUyHZb+m9sFImmHXPv17KlaQ2YBBr/2aO0clO8yEP5dKjyjPVIGRTH+1MifSK7A95iNeQEwLG5mCTJRA7LuoYT9XNNmto3UhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYx9gupW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1D6C113CE;
	Wed, 17 Apr 2024 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713315164;
	bh=YVAp4IOd+ftXbliGWV6sMKzUBLNAQxl+/AiTbHPv/7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYx9gupWYdoBX48zuNmRYqbVMANTV4V5eoBnl0zec5YHRT5vP3OS/snMGTUITWR6v
	 UwNhFLOpi1owo/qPKqdAN12YSjIO+DY6Giu1LUUlc5Djo18W/050eEaHV+CtzAQgnF
	 /MiiWPfD8sQQBKHdxwSioWzPJS7d9M2QM0V0XDocEW6dhHPosDxPWRcbt69rarTom1
	 Dcl5ItCAYOMs5rnWplVDZVpbX5IxENDBJeC/8NSSi9XKcMSsMBoTsbBpvMbZuCz6T3
	 9rdR8dVwHTrZyXSN1hUs3hXllTbxRp8KTkeBMu3MBhy7QKt8xkCIXB5nC5G95NE/VQ
	 pQY4eIHZOBIeQ==
Date: Wed, 17 Apr 2024 09:52:41 +0900
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	keescook@chromium.org, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com
Subject: Re: [PATCH v1 5/6] regulator: mtk-dvfsrc-regulator: Refactor and add
 MT8192/MT8195 vregs
Message-ID: <Zh8dWdE8V8-GhNlF@finisterre.sirena.org.uk>
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
 <20240416153805.431118-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="whh3nrJglfd7igwd"
Content-Disposition: inline
In-Reply-To: <20240416153805.431118-6-angelogioacchino.delregno@collabora.com>
X-Cookie: TANSTAAFL


--whh3nrJglfd7igwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 05:38:04PM +0200, AngeloGioacchino Del Regno wrote:
> This driver never worked, and never got even compiled, because it was
> missing the DVFSRC driver entirely, including headers it relies on!
>=20
> Perform a full (or nearly full) refactoring of the MediaTek DVFSRC
> controlled Regulators driver: this retains support for the MT6873,
> MT8183 and MT8192 SoCs, and adds MT8195.
>=20
> As part of the refactoring, this driver is now probed using its own
> devicetree compatible, as this is a child of the main DVFSRC driver
> and gets probed as a subnode of that.

Given what you're doing this would probably be easier to review as
two commits, one removing the existing driver and another adding the new
code.

--whh3nrJglfd7igwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYfHVgACgkQJNaLcl1U
h9DwsQgAgK6OWXJu6ieNWkutjauhJjUe5+l5WxV0KrzASn7I8CFbXNeSgxtx8AZ/
Wv1MYw70APANEtgwkVwwwzu9dxHg+NCPglVwkhmhCevxOvAx8klLFChvsfzjCvmq
pvke+sh5Y/A+8ryIisIA7btD1obFfxLXFQm17W4JggKi47e+QDiah3sQqVzpfDPr
G17pX6KxNc/S+YzkT/BmWcT9uGKucU10R082NScoBU5lsdrAyGnowwhJVNcL5N4J
tUJJXB1VnSi1Q4fOXB4wpxihXwGDZnwb2kgLp2hgRAMXaQv2BbCfk0IAy8DE69yr
lEi56TB4d1sxHrvVO/RTnarkSfcfMQ==
=+F1c
-----END PGP SIGNATURE-----

--whh3nrJglfd7igwd--

