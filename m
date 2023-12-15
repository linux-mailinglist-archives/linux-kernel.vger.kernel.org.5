Return-Path: <linux-kernel+bounces-766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A528145B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B53D1F23DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCD25579;
	Fri, 15 Dec 2023 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0kM2Uu2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271325546
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F56C433CA;
	Fri, 15 Dec 2023 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702636447;
	bh=0zM8JDSAA7dbY9XQraW+2kVK9oURsh8Sn1ND1qFpbTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0kM2Uu21g15zMfNFuyexSnC3wUZEkgsYugPDFYIBl8nJ8KkzEvBOaq+eIWIHliVv
	 kDWuRECuHDtPPPXAClLkxbr2RsE5Goz/a6iVsH4xQ9K3lvlZLgXxqrqMJCDbqIEYVK
	 8YOFsfMlTRdWHkL6VW/L+brCVXCpOMpn1TnuIqzPe+pDfqkb2hwlAD3t7TshhJL7Rc
	 qAb3yros3bqbIFh0E4++VDTxJHPwSqUXVtrJye8DiWle8Apd9Lz5JPRko9O9WOP3yO
	 ksa2qAqS9bJpb+NTNuY6jA0YrfjrE06kJAWJbRRhJxHDwoQjRpCTg8ynIkE9BDXSxt
	 7TGQdDM/E7m8A==
Date: Fri, 15 Dec 2023 11:34:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Michal Wajdeczko <michal.wajdeczko@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v3 2/3] drm/tests: managed: Extract device initialization
 into test init
Message-ID: <nopfuutpsvckycqoasndveo5ufnar3yra57on55yznp5zwpodc@tjcnie3guy2r>
References: <20231211220939.215024-1-michal.winiarski@intel.com>
 <20231211220939.215024-3-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7r44nner6zxrid2"
Content-Disposition: inline
In-Reply-To: <20231211220939.215024-3-michal.winiarski@intel.com>


--c7r44nner6zxrid2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:09:38PM +0100, Micha=C5=82 Winiarski wrote:
> It simplifies the process of extending the test suite with additional
> test cases without unnecessary duplication.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/gpu/drm/tests/drm_managed_test.c | 51 +++++++++++++++++-------
>  1 file changed, 36 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/t=
ests/drm_managed_test.c
> index 1652dca11d30c..15bd2474440b5 100644
> --- a/drivers/gpu/drm/tests/drm_managed_test.c
> +++ b/drivers/gpu/drm/tests/drm_managed_test.c
> @@ -12,6 +12,7 @@
>  #define TEST_TIMEOUT_MS	100
> =20
>  struct managed_test_priv {
> +	struct drm_device *drm;
>  	bool action_done;
>  	wait_queue_head_t action_wq;
>  };
> @@ -24,35 +25,54 @@ static void drm_action(struct drm_device *drm, void *=
ptr)
>  	wake_up_interruptible(&priv->action_wq);
>  }
> =20
> +/*
> + * The test verifies that the release action is called automatically whe=
n the
> + * device is released.
> + */
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
> +	ret =3D wait_event_interruptible_timeout(priv->action_wq, priv->action_=
done,
> +					       msecs_to_jiffies(TEST_TIMEOUT_MS));
> +	KUNIT_EXPECT_GT_MSG(test, ret, 0, "Release action was not called");

The addition of the message should be in a separate patch

> +}
> +
> +static int drm_managed_test_init(struct kunit *test)
>  {
>  	struct managed_test_priv *priv;
> -	struct drm_device *drm;
>  	struct device *dev;
> -	int ret;
> =20
>  	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> -	init_waitqueue_head(&priv->action_wq);
> =20
>  	dev =3D drm_kunit_helper_alloc_device(test);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> =20
> -	drm =3D __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,=
 DRIVER_MODESET);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
> +	/*
> +	 * DRM device can't be embedded in priv, since priv->action_done needs
> +	 * to remain allocated beyond both parent device and drm_device
> +	 * lifetime.
> +	 */
> +	priv->drm =3D __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*pr=
iv->drm), 0,
> +							DRIVER_MODESET);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
> =20
> -	ret =3D drmm_add_action_or_reset(drm, drm_action, priv);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> -
> -	ret =3D drm_dev_register(drm, 0);
> -	KUNIT_ASSERT_EQ(test, ret, 0);
> +	init_waitqueue_head(&priv->action_wq);
> =20
> -	drm_dev_unregister(drm);
> -	drm_kunit_helper_free_device(test, dev);
> +	test->priv =3D priv;
> =20
> -	ret =3D wait_event_interruptible_timeout(priv->action_wq, priv->action_=
done,
> -					       msecs_to_jiffies(TEST_TIMEOUT_MS));
> -	KUNIT_EXPECT_GT(test, ret, 0);
> +	return 0;
>  }
> =20
>  static struct kunit_case drm_managed_tests[] =3D {
> @@ -62,6 +82,7 @@ static struct kunit_case drm_managed_tests[] =3D {
> =20
>  static struct kunit_suite drm_managed_test_suite =3D {
>  	.name =3D "drm-test-managed",
> +	.init =3D drm_managed_test_init,
>  	.test_cases =3D drm_managed_tests
>  };
> =20
> --=20
> 2.43.0
>=20

--c7r44nner6zxrid2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXwrnQAKCRDj7w1vZxhR
xdTkAP9Xx9QASfyt+BaF3DUiBfsEEb55Z6BnIUk3ZC5Hb/eP+AD9GOAhzr9p1sEU
KPjEPtZIZW4z+Nhf6QLpV320DP5MyAA=
=Aa4r
-----END PGP SIGNATURE-----

--c7r44nner6zxrid2--

