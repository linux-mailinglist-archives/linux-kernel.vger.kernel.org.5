Return-Path: <linux-kernel+bounces-103215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D54C87BC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA31284AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE76F50F;
	Thu, 14 Mar 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3L14v3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217C6E5F6;
	Thu, 14 Mar 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417909; cv=none; b=R4u9xg55kTjCvggf+8GN9kqQOXx5/fZjjGh2lDAsGu2GCfJMN6TZuKJ8mywh16HBme5HJcddydWGQWaCdVO6DKuye//3y7XCS2h5fZRaoxpz/7HTELM49NnsRqD2wK35AUoGRymZtKPgB1sa0+1hb+pA4J5n7POIoIa4++MRNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417909; c=relaxed/simple;
	bh=JZwrOZDBFM4h/ynerY9rzycucCItCakGta+7niAWv34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOKE/4Oy0BnmSpurtF1Taa6BPwJJLalMyxeQRGrThplAyRkiVVOi3V9/Q8F7zPvdAu6p26k3aspduU+8WSGwXzv3628WPWKFXWgcccRyJSpMCXYkDyvF03NkckZ8cvgVlOIyQu5zICzSUch+1/Fi+SsUFxxO9prwzae2ZKLUlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3L14v3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75D7C433F1;
	Thu, 14 Mar 2024 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710417909;
	bh=JZwrOZDBFM4h/ynerY9rzycucCItCakGta+7niAWv34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3L14v3UAfRtphABQURAy5hQTD8gXfvP+lZKPlr74q8Kz6VP/Mai4gnpuAA2jcgrt
	 EOY6WTGmaqw+zR0YwGPUakdMF9ysfVJHD+FOMYVG0es/sFTOZbC2B0HFrencD1+Bjd
	 HThHKuJcu+DeY0YJ+/0E87pn38YjoV+J3VMdHY1Xrnll7FhtMe8nhwNjfAVYd4GveJ
	 bJNd+Ee99OLBrJgzSQZF1KoSbjTNkVACbSrgrL3glcUaOfCvK1Eq3sIiZVYXpTrqlN
	 y/L1gSHlZZ0v/f2rPzMc+hdX1ifSpU7oPTbwJMK7+r8/mgU3Pl6STUuw+to239Zt39
	 XwJuUTioiZpkQ==
Date: Thu, 14 Mar 2024 13:05:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Michal Simek <michal.simek@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-media@vger.kernel.org
Subject: Re: [PATCH v2 8/8] drm: xlnx: Intoduce TPG CRTC driver
Message-ID: <20240314-esoteric-delicate-sidewinder-5dc4db@houat>
References: <20240312-dp-live-fmt-v2-0-a9c35dc5c50d@amd.com>
 <20240312-dp-live-fmt-v2-8-a9c35dc5c50d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwejoxn4vhiy7i6i"
Content-Disposition: inline
In-Reply-To: <20240312-dp-live-fmt-v2-8-a9c35dc5c50d@amd.com>


--kwejoxn4vhiy7i6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 12, 2024 at 05:55:05PM -0700, Anatoliy Klymenko wrote:
> DO NOT MERGE. REFERENCE ONLY.
>=20
> Add CRTC driver based on AMD/Xilinx Video Test Pattern Generator IP. TPG
> based FPGA design represents minimalistic harness useful for testing links
> between FPGA based CRTC and external DRM encoders, both FPGA and hardened
> IP based.
>=20
> Add driver for AMD/Xilinx Video Timing Controller. The VTC, working in
> generator mode, suplements TPG with video timing signals.
>=20
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>

As I said previously, we don't want to have unused APIs, so this patch
should be in a good enough state to be merged if we want to merge the
whole API.

> +/* ---------------------------------------------------------------------=
--------
> + * DRM CRTC
> + */
> +
> +static enum drm_mode_status xlnx_tpg_crtc_mode_valid(struct drm_crtc *cr=
tc,
> +						     const struct drm_display_mode *mode)
> +{
> +	return MODE_OK;
> +}
> +
> +static int xlnx_tpg_crtc_check(struct drm_crtc *crtc,
> +			       struct drm_atomic_state *state)
> +{
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	int ret;
> +
> +	if (!crtc_state->enable)
> +		goto out;
> +
> +	ret =3D drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> +	if (ret)
> +		return ret;
> +
> +out:
> +	return drm_atomic_add_affected_planes(state, crtc);
> +}
> +

[...]

> +
> +static u32 xlnx_tpg_crtc_select_output_bus_format(struct drm_crtc *crtc,
> +						  struct drm_crtc_state *crtc_state,
> +						  const u32 *in_bus_fmts,
> +						  unsigned int num_in_bus_fmts)
> +{
> +	struct xlnx_tpg *tpg =3D crtc_to_tpg(crtc);
> +	unsigned int i;
> +
> +	for (i =3D 0; i < num_in_bus_fmts; ++i)
> +		if (in_bus_fmts[i] =3D=3D tpg->output_bus_format)
> +			return tpg->output_bus_format;
> +
> +	return 0;
> +}
> +
> +static const struct drm_crtc_helper_funcs xlnx_tpg_crtc_helper_funcs =3D=
 {
> +	.mode_valid =3D xlnx_tpg_crtc_mode_valid,
> +	.atomic_check =3D xlnx_tpg_crtc_check,
> +	.atomic_enable =3D xlnx_tpg_crtc_enable,
> +	.atomic_disable =3D xlnx_tpg_crtc_disable,
> +	.select_output_bus_format =3D xlnx_tpg_crtc_select_output_bus_format,
> +};

=46rom that code, it's not clear to me how the CRTC is going to be able to
get what the format is.

It looks like you hardcode it here, but what if there's several that
would fit the bill? Is the CRTC expected to store it into its private
structure?

If so, I would expect it to be in the crtc state, and atomic_enable to
just reuse whatever is in the state.

Maxime

--kwejoxn4vhiy7i6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfLn7QAKCRDj7w1vZxhR
xSvRAQDBl2QlIoZyi0ODQ+MZMNWBU6kh/mje8vQzNdYdrUgsbQEApcQO+aeY7fXf
KFceNVFn3+gdg8H4vaDQkRqOjheGcg8=
=knUA
-----END PGP SIGNATURE-----

--kwejoxn4vhiy7i6i--

