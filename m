Return-Path: <linux-kernel+bounces-85261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2EC86B324
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459021F28DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5D15B99B;
	Wed, 28 Feb 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3twjr27"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEF73515
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134177; cv=none; b=RSDd3yGG4D0iUaLd3BsfqDxBvjy/MPGACx3fWkLuOcuzBRAVqXEf+foz0YrJnEmslG7pRsmIKAEEEudT1E0wA/It4IvyrLTKP4spLbwTBDcRmmhMCZK5uz4aLLJkb0s9vnF/udrStWVpl7s2RyDg0lUI6OJI4EnhgaoXFan8yBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134177; c=relaxed/simple;
	bh=lRf/rIbATsUTI1YkCvuC+3znuOvvZIuYq5dyiYZsoXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojcgJunHPgTX5rAbeRxpEo2OmC48cEeJUAiqWRKmvdqK1E0zZWE1gFQviNAXkOhyHSErJbQhWMrb/ODBYrfioGc9ZmfoY/QF1ZTMQ/Cmz39HegG+pGQLapop84NybHeynbsJDxMqoThXtbYNdOv3wc04MJP/ELLq8dTVkR3KheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3twjr27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5403CC433F1;
	Wed, 28 Feb 2024 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134176;
	bh=lRf/rIbATsUTI1YkCvuC+3znuOvvZIuYq5dyiYZsoXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3twjr27b1HacuKRDSNxpv4YwUtDnjvSa7PX91jk2W+KLQn/tKQeVrFP5cBBaFMKY
	 yfqR4EQNDiRuQsYvGU5EAuabsTfXLPkmKGxgd2RgeU1Obd+WbHAuowDK8sGTrok57w
	 oPBzz2RYsBcaPd8y8BjPwKKkrWUhttL4CuV99jxSUsHJLzOALFQZYjM4Pt9y7MKt15
	 7der0X817Nodjt8yQR9gYxYm/kbUIlm0HjwIhXVLcNrP/NFrzfGKHtFRlxSizYWGp5
	 RbSXTVrB77BXGBg3NfiFWf3nHoi4D37BJC1kh2TzDhJthU6Urv0W5yhbZkTCH1S73e
	 Q9PP4zay7kgtA==
Date: Wed, 28 Feb 2024 16:29:33 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Michal Simek <michal.simek@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/atomic-helper: Add select_output_bus_format
 callback
Message-ID: <20240228-nifty-flashy-shrew-905edc@houat>
References: <20240226-dp-live-fmt-v1-0-b78c3f69c9d8@amd.com>
 <20240226-dp-live-fmt-v1-4-b78c3f69c9d8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cidk5nrah5kgputl"
Content-Disposition: inline
In-Reply-To: <20240226-dp-live-fmt-v1-4-b78c3f69c9d8@amd.com>


--cidk5nrah5kgputl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 08:44:45PM -0800, Anatoliy Klymenko wrote:
> Add select_output_bus_format to CRTC atomic helpers callbacks. This
> callback Will allow CRTC to participate in media bus format negotiation
> over connected DRM bridge chain and impose CRTC-specific restrictions.
> A good example is CRTC implemented as FPGA soft IP. This kind of CRTC will
> most certainly support a single output media bus format, as supporting
> multiple runtime options consumes extra FPGA resources. A variety of
> options for FPGA are usually achieved by synthesizing IP with different
> parameters.
>=20
> Incorporate select_output_bus_format callback into the format negotiation
> stage to fix the input bus format of the first DRM bridge in the chain.
>=20
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>  drivers/gpu/drm/drm_bridge.c             | 19 +++++++++++++++++--
>  include/drm/drm_modeset_helper_vtables.h | 31 ++++++++++++++++++++++++++=
+++++
>  2 files changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 521a71c61b16..453ae3d174b4 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -32,6 +32,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_print.h>
> =20
> @@ -879,7 +880,8 @@ static int select_bus_fmt_recursive(struct drm_bridge=
 *first_bridge,
>  	unsigned int i, num_in_bus_fmts =3D 0;
>  	struct drm_bridge_state *cur_state;
>  	struct drm_bridge *prev_bridge;
> -	u32 *in_bus_fmts;
> +	struct drm_crtc *crtc =3D crtc_state->crtc;
> +	u32 *in_bus_fmts, in_fmt;
>  	int ret;
> =20
>  	prev_bridge =3D drm_bridge_get_prev_bridge(cur_bridge);
> @@ -933,7 +935,20 @@ static int select_bus_fmt_recursive(struct drm_bridg=
e *first_bridge,
>  		return -ENOMEM;
> =20
>  	if (first_bridge =3D=3D cur_bridge) {
> -		cur_state->input_bus_cfg.format =3D in_bus_fmts[0];
> +		in_fmt =3D in_bus_fmts[0];
> +		if (crtc->helper_private &&
> +		    crtc->helper_private->select_output_bus_format) {
> +			in_fmt =3D crtc->helper_private->select_output_bus_format(
> +							crtc,
> +							crtc->state,
> +							in_bus_fmts,
> +							num_in_bus_fmts);
> +			if (!in_fmt) {
> +				kfree(in_bus_fmts);
> +				return -ENOTSUPP;
> +			}
> +		}
> +		cur_state->input_bus_cfg.format =3D in_fmt;

I don't think we should start poking at the CRTC internals, but we
should rather provide a helper here.

>  		cur_state->output_bus_cfg.format =3D out_bus_fmt;
>  		kfree(in_bus_fmts);
>  		return 0;
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_m=
odeset_helper_vtables.h
> index 881b03e4dc28..7c21ae1fe3ad 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -489,6 +489,37 @@ struct drm_crtc_helper_funcs {
>  				     bool in_vblank_irq, int *vpos, int *hpos,
>  				     ktime_t *stime, ktime_t *etime,
>  				     const struct drm_display_mode *mode);
> +
> +	/**
> +	 * @select_output_bus_format
> +	 *
> +	 * Called by the first connected DRM bridge to negotiate input media
> +	 * bus format. CRTC is expected to pick preferable media formats from
> +	 * the list supported by the DRM bridge chain.

There's nothing restricting it to bridges here. Please rephrase this to
remove the bridge mention. The user is typically going to be the
encoder, and bridges are just an automagic implementation of an encoder.

And generally speaking, I'd really like to have an implementation
available before merging this.

Maxime

--cidk5nrah5kgputl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZd9RXQAKCRDj7w1vZxhR
xabiAPwMUBllLVjJ2R8GSARBjyjpbidi/etMNmmjB31GnUsLCQD9GXcs+YhUV+XC
WZuXsHmZaEgjQI0Yn+ELSS5uW/RRqgg=
=PnFN
-----END PGP SIGNATURE-----

--cidk5nrah5kgputl--

