Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627597FEAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbjK3Iig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344980AbjK3Iic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:38:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C610DB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:38:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EB2C433D9;
        Thu, 30 Nov 2023 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701333517;
        bh=3f4PCKBuYDS/P+l0eRzusj//XC10y90AiINJ1mwoS5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgFgs5aVUNhfK5jkDO9qxnDY8SRhyumOnhAACdENGLLOYbGJQPVRyOmnK/ZGTJh7N
         e1TWBDOH78S7vCbQIuej8kLVz/UnZ86ksZaKP8ELS9Z3/kPjPl9zsGRtuiq6bXNw2H
         1HOD4a0EoBB0VfDeTFq7WySrabzTPiZEIbZeAaXRBP7s56ZJJw77fvOCjjTgRNwsDs
         zMCYch69i3eu/l34rjgX8C42XoEEvkP+kNrBav+g4Vs5yfI0TEbKmrTsfsXsehYOkF
         Y1MLo/ca0CZ5EpM+87EOkEngCeR/qvlmPv2rG4WxaZahjMaOnBxZg1YsbeFWJn7yat
         hgxIC+mDareKQ==
Date:   Thu, 30 Nov 2023 09:38:35 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH 2/2] drm/tests: managed: Add a simple test for
 drmm_managed_release
Message-ID: <3sio7356dxi5nbld2eupih3rzazvef4ebusrpdrhabnpg7pns4@5zxfnd4az4li>
References: <20231129221412.1180549-1-michal.winiarski@intel.com>
 <20231129221412.1180549-3-michal.winiarski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nal4dtzzote2yu2x"
Content-Disposition: inline
In-Reply-To: <20231129221412.1180549-3-michal.winiarski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nal4dtzzote2yu2x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for creating a test for that, that's really appreciated :)

On Wed, Nov 29, 2023 at 11:14:12PM +0100, Micha=C5=82 Winiarski wrote:
> Add a simple test that checks whether the action is indeed called right
> away and that it is not called on the final drm_dev_put().
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/gpu/drm/tests/drm_managed_test.c | 65 ++++++++++++++++++------
>  1 file changed, 50 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/t=
ests/drm_managed_test.c
> index 1652dca11d30c..a645ea42aee56 100644
> --- a/drivers/gpu/drm/tests/drm_managed_test.c
> +++ b/drivers/gpu/drm/tests/drm_managed_test.c
> @@ -12,6 +12,8 @@
>  #define TEST_TIMEOUT_MS	100
> =20
>  struct managed_test_priv {
> +	struct drm_device *drm;
> +	struct device *dev;
>  	bool action_done;
>  	wait_queue_head_t action_wq;
>  };
> @@ -26,42 +28,75 @@ static void drm_action(struct drm_device *drm, void *=
ptr)
> =20
>  static void drm_test_managed_run_action(struct kunit *test)
>  {
> -	struct managed_test_priv *priv;
> -	struct drm_device *drm;
> -	struct device *dev;
> +	struct managed_test_priv *priv =3D test->priv;
>  	int ret;
> =20
> -	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> -	init_waitqueue_head(&priv->action_wq);
> +	ret =3D drmm_add_action_or_reset(priv->drm, drm_action, priv);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> =20
> -	dev =3D drm_kunit_helper_alloc_device(test);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +	ret =3D drm_dev_register(priv->drm, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	drm_dev_unregister(priv->drm);
> +	drm_kunit_helper_free_device(test, priv->dev);

I think we'll need two patches here, one to convert to having an init
function, and one to actually add the new test, it's pretty confusing as
it is.

> =20
> -	drm =3D __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,=
 DRIVER_MODESET);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
> +	ret =3D wait_event_interruptible_timeout(priv->action_wq, priv->action_=
done,
> +					       msecs_to_jiffies(TEST_TIMEOUT_MS));
> +	KUNIT_EXPECT_GT(test, ret, 0);
> +}
> =20
> -	ret =3D drmm_add_action_or_reset(drm, drm_action, priv);
> +static void drm_test_managed_release_action(struct kunit *test)
> +{
> +	struct managed_test_priv *priv =3D test->priv;
> +	int ret;
> +
> +	ret =3D drmm_add_action_or_reset(priv->drm, drm_action, priv);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
> =20
> -	ret =3D drm_dev_register(drm, 0);
> +	ret =3D drm_dev_register(priv->drm, 0);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
> =20
> -	drm_dev_unregister(drm);
> -	drm_kunit_helper_free_device(test, dev);
> +	drmm_release_action(priv->drm, drm_action, priv);
> +	KUNIT_EXPECT_TRUE(test, priv->action_done);
> +	priv->action_done =3D false;
> +
> +	drm_dev_unregister(priv->drm);
> +	drm_kunit_helper_free_device(test, priv->dev);
> =20
>  	ret =3D wait_event_interruptible_timeout(priv->action_wq, priv->action_=
done,
>  					       msecs_to_jiffies(TEST_TIMEOUT_MS));
> -	KUNIT_EXPECT_GT(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static int drm_managed_test_init(struct kunit *test)
> +{
> +	struct managed_test_priv *priv;
> +
> +	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +	init_waitqueue_head(&priv->action_wq);

Also, I know that it was there before, but I'm not sure it's valid from
a lifetime point of view. Or at least, we have to think hard enough
about it to just remove that construct

> +	priv->dev =3D drm_kunit_helper_alloc_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> +
> +	priv->drm =3D __drm_kunit_helper_alloc_drm_device(test, priv->dev, size=
of(*priv->drm),
> +							0, DRIVER_MODESET);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);

For example by storing the drm_device struct in the priv structure
directly, and thus everything will just work out.

Maxime

--nal4dtzzote2yu2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWhKCgAKCRDj7w1vZxhR
xb1nAQDoFA7eK6k4vMebPc69Mn8c5dpfEOdMUwahXkSWMEL/vQD/WmVgGnKC+weA
C/jQ19tn3571o1sQ/8HEgSUsEmQh3w0=
=L/hk
-----END PGP SIGNATURE-----

--nal4dtzzote2yu2x--
