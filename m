Return-Path: <linux-kernel+bounces-40335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3FD83DEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A51B21CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B6A1DA3A;
	Fri, 26 Jan 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDe6Slbw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159761CD0A;
	Fri, 26 Jan 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286440; cv=none; b=PjZeJI7zoxXLVqM668+N3XXkS/mv1UOvyL4hsLAA0df+Y2K/5QUGvI6ZIVY3/5zTxqZC342372DVUU4sc2KGkTKjwT9iaVb6K7XF6SUhmovjq1d7kzz18NGzuH/5Egyarv46JXTeRt8iq3+JCJhqR6uSk0L6R6oTfmxeYqqhHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286440; c=relaxed/simple;
	bh=5iYUflzMQ861be+XTIVmFUr4Ln1Nim3H4SbxbbWe3ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKpWgvVgpxJeLMh8VhEs1mx9vLfXioiEBXBoYn7D6LMF5uaelxyIr/UfWA3KHjpeb/bZ6WvNU3q1gzoBGp1XJmYe9DioRWruk4vego6un8qWUUY7Voz+0OBx7MnL1ZuvXWOjCef5V57kkWwXyV9MYpOwR9Qb3QhCvVcAa9TbOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDe6Slbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE93FC43390;
	Fri, 26 Jan 2024 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286439;
	bh=5iYUflzMQ861be+XTIVmFUr4Ln1Nim3H4SbxbbWe3ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDe6SlbwjI+YPW9Mq3T+ljgPcYzX/eBo9He4PP7xnAkQ3UIHA1WPDWOOgFnCWxTMX
	 sbyVew7uKtuwUQY4TByWSHuO6vaiaJtVDqNewZEeaCSskHi0gt3PpGTuk8dcv4289E
	 PRbgshtnZZP6EICURAZ6LAnGEe+ghr/mPM2wyY+CK6a2juWrTMtPM/aodsxN8MXpBU
	 3RomL+greBDmnbBhFByxPOczWjQfWah3NNndvSZmlsvETcI2TYXFovfVKc4ZoAFw/j
	 22AeT4kZ2SPTXDgvlkDvJiYLnbkRpSSr65VRZfhJlzCgyJeWDJqxzxooXRc5cCLuX8
	 LdAswQElQIAOA==
Date: Fri, 26 Jan 2024 16:27:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Yannic Moog <y.moog@phytec.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Primoz Fiser <primoz.fiser@norik.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH RFC for upstream 1/4] dt-bindings: display: panel-simple:
 add ETML1010G3DRA
Message-ID: <20240126-briskly-clang-d1e6ad7d40e8@spud>
References: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
 <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-1-8ec5b48eec05@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r9lRgXrshhnzpKAU"
Content-Disposition: inline
In-Reply-To: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-1-8ec5b48eec05@phytec.de>


--r9lRgXrshhnzpKAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Jan 26, 2024 at 09:57:23AM +0100, Yannic Moog wrote:
> Add Emerging Display Technology Corp. etml1010g3dra 10.1" LCD-TFT LVDS
> panel compatible string.
>=20
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

> [PATCH RFC for upstream 1/4]

The "for upstream" here is not really relevant, what else would the
patch be for?

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 11422af3477e..b6bbdb3dd2b2 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -139,6 +139,8 @@ properties:
>        - edt,etm0700g0edh6
>          # Emerging Display Technology Corp. LVDS WSVGA TFT Display with =
capacitive touch
>        - edt,etml0700y5dha
> +        # Emerging Display Technology Corp. 10.1" LVDS WXGA TFT Display =
with capacitive touch
> +      - edt,etml1010g3dra
>          # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel with
>          # capacitive touch
>        - edt,etmv570g2dhu
>=20
> --=20
> 2.34.1
>=20

--r9lRgXrshhnzpKAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPdYAAKCRB4tDGHoIJi
0sEDAQCUbSvrqkTDCHq38e07WTqHt54ixj8xqFG0ivlbAW5U1gEA4waKpK8VdRA+
t7JzmgjefDRvuYrmKoTlMNWpj1KBcAE=
=FDIS
-----END PGP SIGNATURE-----

--r9lRgXrshhnzpKAU--

