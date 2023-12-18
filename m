Return-Path: <linux-kernel+bounces-3201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADB816911
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33BE283488
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201711198;
	Mon, 18 Dec 2023 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJyM4RTB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04710A3A;
	Mon, 18 Dec 2023 09:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09537C433C7;
	Mon, 18 Dec 2023 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702890148;
	bh=TZ1qeOneNQ+Kp1nPdTQpgPP/PrwbFnsKYUfWZDPHe0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJyM4RTBWIm84JSEAzF1mcwkNdnxjThccNLa2pk/GK4sH8wSu8RvxxFOzJpNuRqBP
	 6p0NBzcD2qgrWrlTZbM7oeNc2djGfmjEYeA2RZwU5QiOzcZcqaAqvharae9rLTQJzj
	 JBtDm+CUUdA+E49UM1D3Y+hcWw+ZEcRrwE8GtGiy/KMDs/gqQ4Lrj6Xt2QnTSP4cEE
	 VcMKtrZMmtSWDZ/Gyf2cOE73JvrVxsqrXmMm82a8V3//tT4tzYzhEiojyYZYVxPN74
	 x4T7ISgd6N7fGINKAsKCmm1TxVJkakrJE8y94HFHtaTNiLFfXcKqrdJ3GKVfmIOGER
	 jrAOT83q+betg==
Date: Mon, 18 Dec 2023 10:02:25 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/27] drm/rockchip: inno_hdmi: Subclass connector
 state
Message-ID: <rvovzl6rqkaa2hvml75if5bjasqnyh2r354jdjpa5gckfpcxv4@wlknpt7lhncq>
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-19-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tgmjpqpodl54ltwn"
Content-Disposition: inline
In-Reply-To: <20231216162639.125215-19-knaerzche@gmail.com>


--tgmjpqpodl54ltwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for working on that, it's much better now.

On Sat, Dec 16, 2023 at 05:26:29PM +0100, Alex Bee wrote:
> +static struct drm_connector_state *
> +inno_hdmi_connector_duplicate_state(struct drm_connector *connector)
> +{
> +	struct inno_hdmi_connector_state *inno_conn_state;
> +
> +	if (WARN_ON(!connector->state))
> +		return NULL;
> +
> +	inno_conn_state = kmemdup(to_inno_hdmi_conn_state(connector->state),
> +				  sizeof(*inno_conn_state), GFP_KERNEL);
> +
> +	if (!inno_conn_state)
> +		return NULL;
> +
> +	__drm_atomic_helper_connector_duplicate_state(connector,
> +						      &inno_conn_state->base);
> +
> +	return &inno_conn_state->base;
> +}
> +
>  static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
>  	.fill_modes = inno_hdmi_probe_single_connector_modes,
>  	.detect = inno_hdmi_connector_detect,
>  	.destroy = inno_hdmi_connector_destroy,
>  	.reset = drm_atomic_helper_connector_reset,
> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_duplicate_state = inno_hdmi_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };

You also need a custom reset and atomic_destroy_state implementations

Maxime

--tgmjpqpodl54ltwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYAKoQAKCRDj7w1vZxhR
xeXgAP0dm8ueiyjPijuT11zIfwizPjY/rTS6El5eaNit+KQxEAD/URSB0sSl8WnY
9E1cY7E8Tc8MjFuD9r0dgc7gDppJEgg=
=bDg+
-----END PGP SIGNATURE-----

--tgmjpqpodl54ltwn--

