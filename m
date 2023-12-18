Return-Path: <linux-kernel+bounces-3207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F481692E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B991F223A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469311197;
	Mon, 18 Dec 2023 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbjhWmQv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E611C91;
	Mon, 18 Dec 2023 09:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF990C433C7;
	Mon, 18 Dec 2023 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702890310;
	bh=yAr4KLt08A7Iall+6S1OSy+IFrkOCzjW+AgOrCIVPKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbjhWmQvIZQyVfYOkuJm8tHcyZGWKsv9OSBNiZq31GpFDSNrmj6IgTFqSkvkSMgfn
	 +nCjAAhsczAAma4vp42q/dCqJozoRxZMeF7cMgdTjNKOXkHIerUIbeJeMNuJN3q/Qu
	 rCe+WdEyOoCgGsS3nt1B5vSVNQ7w7141J/DRAI/stPKR2mG/GLsU+1ylIArQL/PvIk
	 RJheNYZxKmhuC1/IHXHsIif9QERvDPYQFwu3cCF0TA3QGHPqO33eAarcagtA71p0DH
	 cb5CqNQIYLqPErT8KehTNCSRiljhSJy345vACn3bUGNU74NZdflBt7MDuu9vLw52Mt
	 gT8Oy6c/Hgw0Q==
Date: Mon, 18 Dec 2023 10:05:07 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/27] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
Message-ID: <rrtknir3vizvcyamp3kfy47r6uppn3wwevb6a5gln2k533t52z@otm6vum6pg43>
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-21-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syuqoz5ybbowf3nd"
Content-Disposition: inline
In-Reply-To: <20231216162639.125215-21-knaerzche@gmail.com>


--syuqoz5ybbowf3nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 05:26:31PM +0100, Alex Bee wrote:
> @@ -431,6 +452,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>  	else
>  		inno_conn_state->colorimetry =3D HDMI_COLORIMETRY_ITU_709;
> =20
> +	inno_conn_state->rgb_limited_range =3D
> +		drm_default_rgb_quant_range(mode) =3D=3D HDMI_QUANTIZATION_RANGE_LIMIT=
ED;
> +
>  	/* Mute video and audio output */
>  	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
>  		  v_AUDIO_MUTE(1) | v_VIDEO_MUTE(1));

This needs to be done at atomic_check time: the expectation is that by
the time you commit the state, everything is prepared for it.

Maxime

--syuqoz5ybbowf3nd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYALQwAKCRDj7w1vZxhR
xQzzAP0YVFac7ehXKiTwVJRxtQYeIMZmYW1VoSFT4wGJVIk8ZAD+PBIYdoQZJl7b
X7Gv0oBzZzU9IKJ+0sxAUitZEgq+5w8=
=+z9c
-----END PGP SIGNATURE-----

--syuqoz5ybbowf3nd--

