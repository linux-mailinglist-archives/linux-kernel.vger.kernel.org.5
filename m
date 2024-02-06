Return-Path: <linux-kernel+bounces-55154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D713F84B898
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9207F28C4DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08713247F;
	Tue,  6 Feb 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKPMwO3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC11332B8;
	Tue,  6 Feb 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231318; cv=none; b=NMgNxs0J6dTF1FTG/k1bhxs3o+dm7U60sVpm+NiOUAB73I+0+128L7FfQwzr+1q+30ALzJn1tlvlI5sAVxW39S5wmFtv2zowOMbeQZzAS29YKDpg/kaJJ0SbXpLTKrcxaYahhRGkL4bUdICi55nXCXjD8lEYUdqn/NnNBKFqEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231318; c=relaxed/simple;
	bh=rC14wVFYqy4h/Awdz20rT2AXbkytWG1Up7dvXS+wKTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt4Ce0ljXImEETEhanhjWRouP7fDadM0CTCGUKKCwGFx7HqRxKCejwvSQgOmZyzD1S6iMlS1vdMpLv1gq3SQOh0jMEbHIS5WVhzL2lwGwKtu/1pJ9JpCjOuAV93pLPLW2CPCNAJ/IyV9PQnUxCpleKeh1jxNp3zleAG7qqf9bK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKPMwO3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3A3C433F1;
	Tue,  6 Feb 2024 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707231318;
	bh=rC14wVFYqy4h/Awdz20rT2AXbkytWG1Up7dvXS+wKTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKPMwO3zpuufaHVwrevb03P/7KzYU8fGHI9AvBbZ+BUm6dQJOkhg4xx3hAPXMtvd4
	 3knWHB0o9HPhdijomX7dJQuwP/kMbs0o3Ymjwenj3p3oNkQcgeqq7iIteAPRPH3yPA
	 zg2o7DS/BiHmYC9YrHDwkC+KC47/bmtCXatzb7+WZlBMSZw2EobSXhBqJzB1oKSb9y
	 kzqUF6X6bBtmcWRypHZe1Szgl68JfDev8cJmc6dt4Bd+o+Rd7HsUfunMRlQEzDpYQa
	 /hbgYLE9FHo3ImSOy1YdZhPoqS5CNuxiPZbSXwPokiidMIIYtARn399TV1MnJc9mS9
	 bI0g1oIfIvdog==
Date: Tue, 6 Feb 2024 14:55:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: display: add STM32 LVDS device
Message-ID: <20240206-retail-thicket-75e6e0b1fe45@spud>
References: <20240206-lvds-v4-0-98d5f9af399d@foss.st.com>
 <20240206-lvds-v4-1-98d5f9af399d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O7hGylNQGhupJghO"
Content-Disposition: inline
In-Reply-To: <20240206-lvds-v4-1-98d5f9af399d@foss.st.com>


--O7hGylNQGhupJghO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 12:33:16PM +0100, Raphael Gallais-Pou wrote:
> Add "st,stm32mp25-lvds" compatible.
>=20
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--O7hGylNQGhupJghO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcJIUAAKCRB4tDGHoIJi
0ioEAQDsRUQ93I+XdwHLaxkV5SJzSoKt5JQzOfsQK+/3zHdkVAD+LY7mLq3aUNP+
xrS2FVr3QwhqlMobEa8ll1JafDbFTAI=
=OGHJ
-----END PGP SIGNATURE-----

--O7hGylNQGhupJghO--

