Return-Path: <linux-kernel+bounces-19359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648DB826BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8BBB21C83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906114A93;
	Mon,  8 Jan 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8cBdJ1m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661614A84
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2089CC43397;
	Mon,  8 Jan 2024 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704711124;
	bh=sfKZ2kHfxV9HPHSYjliuoTfI7Nt51hYocQh/PZfvhWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8cBdJ1mVHDxUsTD3j5JUxsOq3K41Qj4Y1HUr1B9DvwsuMtfcmd+CudWe0/sjnzLC
	 cB4hULjjgZtaK7rkLRCODemY7h26DLZkoz/00LbyY4lHAvPU6l/Ur92RC4FR8LfQwZ
	 kzl1y9TVWvlTIsSltGO+6cZVSp26O6jX6ZNSZk12WvuD755ddBDw+StfNE5wQRf1BZ
	 TX93I4sjmHbq7FkWra9jo52NOBJfXjZ+siDhGO2UMdOAw5niPrVM26cg3mtqrxzzzP
	 7UKvXe8bxpOTdhCduu5gbJRjzWS/EQLmtQpvAfhWsnqBAqfbTz5GISCjozhWMU6c9m
	 8UsEZHxtHJWqg==
Date: Mon, 8 Jan 2024 11:52:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Michal Wajdeczko <michal.wajdeczko@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v4 5/6] drm/tests: managed: Extract device initialization
 into test init
Message-ID: <3yoesok4yzvc565hmlbj4ybdihhzsofqsnpx3bnzg2phlbq3zf@55jn4zo24vvv>
References: <20240105101324.26811-1-michal.winiarski@intel.com>
 <20240105101324.26811-6-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ynvmvfuteawikynt"
Content-Disposition: inline
In-Reply-To: <20240105101324.26811-6-michal.winiarski@intel.com>


--ynvmvfuteawikynt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 11:13:23AM +0100, Micha=C5=82 Winiarski wrote:
> It simplifies the process of extending the test suite with additional
> test cases without unnecessary duplication.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/gpu/drm/tests/drm_managed_test.c | 37 +++++++++++++++---------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/t=
ests/drm_managed_test.c
> index 986a38c9144a5..c1fc1f0aac9b2 100644
> --- a/drivers/gpu/drm/tests/drm_managed_test.c
> +++ b/drivers/gpu/drm/tests/drm_managed_test.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
> =20
>  struct managed_test_priv {
> +	struct drm_device *drm;
>  	bool action_done;
>  };
> =20
> @@ -24,11 +25,26 @@ static void drm_action(struct drm_device *drm, void *=
ptr)
>   * device is released.
>   */
>  static void drm_test_managed_run_action(struct kunit *test)
> +{
> +	struct managed_test_priv *priv =3D test->priv;
> +	int ret;
> +
> +	ret =3D drmm_add_action_or_reset(priv->drm, drm_action, priv);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret =3D drm_dev_register(priv->drm, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	drm_dev_unregister(priv->drm);
> +	drm_kunit_helper_free_device(test, priv->drm->dev);
> +
> +	KUNIT_EXPECT_TRUE_MSG(test, priv->action_done, "Release action was not =
called");

Aside from the message here I already pointed out,

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ynvmvfuteawikynt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZZvT0QAKCRDj7w1vZxhR
xUjcAP9F4VU4nJFspkaO37BLPuWH06/oUpWOQzG7BGmgtUxEHAEAtUYmuvBS+A0A
S8IGzOW+79zQbKpyZgFjz/F8khdc7QE=
=zS7P
-----END PGP SIGNATURE-----

--ynvmvfuteawikynt--

