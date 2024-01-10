Return-Path: <linux-kernel+bounces-22464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD61829E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE428A9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA124C3DC;
	Wed, 10 Jan 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeDcPZYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B84C3C6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85F1C433C7;
	Wed, 10 Jan 2024 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704902190;
	bh=Mev9R+M1cLaYjYBU2ZgT5jQ2ZNfBaieaMpJ0LyeLUqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeDcPZYqZH/yosqHy6J0lKKIXTr87XKELYPhOa4vt9rK8HdOlohar0v95Bx8OTdGH
	 qFkCOu0OtN6mz/BohFHwbJekpq/cRig3FNJMy81gq7ZjCx4Q+GqZRFbdFk2LWKfLwU
	 UqW8AC16aRfgHhoGD+CVoZibaW2tuPgF5iuMbzilseJNpgvVjFgYAZrwuFPgEB78OG
	 WV0NkkyJ+qt57r+azS6oThayuTFamklZZWYXTFl52aiYMK+5hVeAsy/CZ3k7mu4Zvw
	 gsotv0QM55jZHaZKlclvTSBRs5wPTZS/GgIMp2z1pttlcZwrYyX+zCDFpfpMi3TWWO
	 PcI2MR49Yy+Rw==
Date: Wed, 10 Jan 2024 16:56:27 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Michal Wajdeczko <michal.wajdeczko@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v4 6/6] drm/tests: managed: Add a simple test for
 drmm_managed_release
Message-ID: <2mgrb5lrm5oskkcauhdbegdb5jwhqx6unzlaltz6e2bzaqrzyr@dnkbsr3ykj7k>
References: <20240105101324.26811-1-michal.winiarski@intel.com>
 <20240105101324.26811-7-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="low44rvsz3fnl7ut"
Content-Disposition: inline
In-Reply-To: <20240105101324.26811-7-michal.winiarski@intel.com>


--low44rvsz3fnl7ut
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 11:13:24AM +0100, Micha=C5=82 Winiarski wrote:
> Add a simple test that checks whether the action is indeed called right
> away and that it is not called on the final drm_dev_put().
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/gpu/drm/tests/drm_managed_test.c | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/t=
ests/drm_managed_test.c
> index c1fc1f0aac9b2..91863642efc13 100644
> --- a/drivers/gpu/drm/tests/drm_managed_test.c
> +++ b/drivers/gpu/drm/tests/drm_managed_test.c
> @@ -41,6 +41,33 @@ static void drm_test_managed_run_action(struct kunit *=
test)
>  	KUNIT_EXPECT_TRUE_MSG(test, priv->action_done, "Release action was not =
called");
>  }
> =20
> +/*
> + * The test verifies that the release action is called immediately when
> + * drmm_release_action is called and that it is not called for a second =
time
> + * when the device is released.
> + */
> +static void drm_test_managed_release_action(struct kunit *test)
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
> +	drmm_release_action(priv->drm, drm_action, priv);
> +	KUNIT_EXPECT_TRUE_MSG(test, priv->action_done, "Release action was not =
called");
> +	priv->action_done =3D false;
> +
> +	drm_dev_unregister(priv->drm);
> +	drm_kunit_helper_free_device(test, priv->drm->dev);
> +
> +	KUNIT_EXPECT_FALSE_MSG(test, priv->action_done,
> +			       "Unexpected release action call during cleanup");
> +}
> +

I guess we can have something simpler if we switch action_done to a
counter and just check that the counter didn't increase.

And I think the custom messages should be removed there too.

Maxime

--low44rvsz3fnl7ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZZ6+KwAKCRDj7w1vZxhR
xTSyAP9WBatDxCR53O+71y/N+u/TGRvmdsq04Tz8iV4qA/vs8wD9E/+kUzgF0hBT
sPyni9+ICPNJdDcxH9Yh9B/2rk4Z6AY=
=1Mfc
-----END PGP SIGNATURE-----

--low44rvsz3fnl7ut--

