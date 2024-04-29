Return-Path: <linux-kernel+bounces-162661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CA8B5EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3837E1C2130B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF784D02;
	Mon, 29 Apr 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULmvL0e+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4E83CB9;
	Mon, 29 Apr 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407239; cv=none; b=A9gc0p84xbGQYp2uXwjNL+O0Emn7NiuPwuXPjecqIls+B3aoFXAxC8mKjGsij5m3/6/tI7fRntap2BEiH2iOBTbtzdgtDCeo5jBJ49b5XpwnOoMEk42dU5JGQEyQ40d4C+Fw5DlyK+Rr7iO5/ZeEnrXA76YzZAfA+AkZDyCSKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407239; c=relaxed/simple;
	bh=2oFLRsAgw53HjrPHJfiYkkbK08cBxJ1ZVH2NeS3iJU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI+K4WbMpx18Y71bKZ9qee8KIaFFYG8HSOtuunRE0r/a3AqeiUgR0UFKVBC5RUGJob4IDly6P/NiYMgHg/wV3pSPPAYbzkko7YfyboUdSKzagSsPOnzA6GzCN9CiW6xzUk2becD1gpBk5tUs/2WSVQVtYHbX88QVcaU2Gtw1pzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULmvL0e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35538C113CD;
	Mon, 29 Apr 2024 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714407238;
	bh=2oFLRsAgw53HjrPHJfiYkkbK08cBxJ1ZVH2NeS3iJU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULmvL0e+8/UYbIjh1UWsrEwtwqrgUyH65IYS1AHQwX59qHb6amZBYOpM5rKV4mluO
	 /Fr4t+AUoowzReyDVQoT3UP1ZWS+hFnEr06ra8uWkh+DudjprANd7gJKudBV1sfxOj
	 uItLx0EN9snwEZNV0l8IQXP11f049XWOPKbuXHS8vIjOVaQpVr5H3tiPPhSACP/K2J
	 ExgIdiDKOUqs4Eo03ZdEy8SQiO39grXQ8iOfuH2W51j4PyOOVvN/KIIAzCua3PJV8j
	 11oi+jn0ViRGIVhAREs5OZjg04HHZvKAIIhpTDtGHggtTJbpuRQsf5qcyvP/pm4x1A
	 schkbqt4UBxbQ==
Date: Tue, 30 Apr 2024 01:13:56 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH 2/2] regulator: rtq2208: Fix RTQ2208 buck ramp delay and
 ldo vout setting and segmentaion fault when devm_of_regulator_put_matches is
 called
Message-ID: <Zi_HRJ6xJ8cEhKAy@finisterre.sirena.org.uk>
References: <1714385807-22393-1-git-send-email-alina_yu@richtek.com>
 <1714385807-22393-3-git-send-email-alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CMFEKwFL0XCdxy2X"
Content-Disposition: inline
In-Reply-To: <1714385807-22393-3-git-send-email-alina_yu@richtek.com>
X-Cookie: lisp, v.:


--CMFEKwFL0XCdxy2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 06:16:47PM +0800, Alina Yu wrote:

> ramp_delay range of bucks is changed.
> The maximum ramp up and down range is shorten from 64mVstep/us tor 16mVstep/us/.
> The LDO's Vout is adjustable if the haardware setting allow it, and it can be set either 1800mv or 3300mv.
> Additionally, the discharge register is chaned to other position.
> The discharge register has been moved to another position.
> In this version, a software bug has been fixed. rtq2208_ldo_match is no longer a local variable,
> which prevents invalid memory access when devm_of_regulator_put_matches is called.

As covered in submitting-patches.rst since this is a bunch of different
changes that don't really overlap it should be split into multiple
patches, for example the change of the ramp time for the DCDCs should be
separate to all the LDO stuff.

> -		if (init_data->constraints.min_uV == init_data->constraints.max_uV)
> -			rdesc->desc.fixed_uV = init_data->constraints.min_uV;
> +		fixed_uV = of_property_read_bool(match->of_node, "richtek,use-fix-dvs");
> +
> +		if (fixed_uV) {
> +			desc->n_voltages = 1;
> +			desc->fixed_uV = init_data->constraints.min_uV;
> +			desc->ops = &rtq2208_regulator_ldo_fix_ops;
> +		} else {
> +			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
> +			desc->volt_table = rtq2208_ldo_volt_table;
> +			desc->ops = &rtq2208_regulator_ldo_adj_ops;
> +		}

The driver shouldn't need to look at the constraints to set up the
operations for the hardware, if the regulator can be configured for
multiple voltages just register it that way and let the core figure out
if we ever actually want to change the voltage.

--CMFEKwFL0XCdxy2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvx0MACgkQJNaLcl1U
h9A9ygf/b3X8dbsjTS9LgrAuYbruOGAJnJaScqP+1gX0zNEp0EFUHrtJPJ4T4mZU
QqwtkJWQgMcw/9pt62Av3woKE2P684R4nExzH0rUOxdchYNHQN71NB8BingBqX+a
NZp5iqeorVGrRBdSjbDmI6w0UYS0cRbGhxn6gZ4HCtkC+9THf0N6YFdrA6RuhwRx
BUWG6LZbDxdPD/B9ePz5R8OIy7W3u/sGf5iy5KIc/KoLTh+EGnHrM6Ldr2s+ZoEn
fv5pyBI0ZgzsvKxhtPhEkxvZTJMIA30cpYm3sxzoTj9Pjz9lJPs/iddRu04N+RMU
81nq1XlHyqNRI7o8eE5HFb4cQP4jeg==
=BqI3
-----END PGP SIGNATURE-----

--CMFEKwFL0XCdxy2X--

