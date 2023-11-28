Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82F7FC2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346599AbjK1PJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346571AbjK1PJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:09:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F2D45
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:09:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E24C433CA;
        Tue, 28 Nov 2023 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701184176;
        bh=S4bgiYUP21DwI7+UOp+Rc5V33gFVMAbp28HLFbPCGcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmYmlxFcp2G43v8JayKuqAr76duiGA0PahFxkFC5KEm3SkvTShcCK9qaU0NbLTGaP
         y0gPqZPPaHHS8e4AttXAB2CsbiTCbhOsomdej/qwkMD91ghQtczICA44TflWuI5bZD
         iij7FseeKgqjgqTzOY2rVyWofo/C05V5Cyl+ZHb6NACBCPmi+sUGVDGyYMLzxXAG8D
         3l+eZJ+5wxh27VLNqepKWbT20HeWI0TR4h2ER/sef1KeiUJXW5gE1i8dsThxpPsa/t
         ZNcGNhjYSflLhNrstGNC/hURdhdVQLtFME3JK9MfOLv/oITK8pN7iAsjoKTeUDBSQv
         /pajZFr80h7nw==
Date:   Tue, 28 Nov 2023 16:09:34 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dipam Turkar <dipamt1729@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch, mairacanal@riseup.net,
        javierm@redhat.com, arthurgrillo@riseup.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/tests: Add KUnit tests for
 drm_mode_create_dvi_i_properties()
Message-ID: <goxsh3zfoaacariu2dst5ww6ta7g2ubk24impowabvmfte5d4a@fxemdptwshzs>
References: <20231110192452.734925-1-dipamt1729@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xd6p4uebt7quuk7k"
Content-Disposition: inline
In-Reply-To: <20231110192452.734925-1-dipamt1729@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xd6p4uebt7quuk7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2023 at 12:54:53AM +0530, Dipam Turkar wrote:
> Introduce unit tests for the drm_mode_create_dvi_i_properties() function =
to ensure
> the proper creation of DVI-I specific connector properties.
>=20
> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>  drivers/gpu/drm/tests/drm_connector_test.c | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index c66aa2dc8d9d..9ac1fd32c579 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -4,6 +4,9 @@
>   */
> =20
>  #include <drm/drm_connector.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_kunit_helpers.h>
> =20
>  #include <kunit/test.h>
> =20
> @@ -58,6 +61,30 @@ static void drm_test_get_tv_mode_from_name_truncated(s=
truct kunit *test)
>  	KUNIT_EXPECT_LT(test, ret, 0);
>  };
> =20
> +/*
> + * Test that drm_mode_create_dvi_i_properties() succeeds and
> + * DVI-I subconnector and select subconectors properties have
> + * been created.
> + */
> +static void drm_test_mode_create_dvi_i_properties(struct kunit *test)
> +{
> +	struct drm_device *drm;
> +	struct device *dev;
> +
> +	dev =3D drm_kunit_helper_alloc_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	drm =3D __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0,=
 DRIVER_MODESET);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
> +
> +	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subcon=
nector_property);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_=
property);
> +
> +	// Expect the function to return 0 if called twice.

This is not the proper comment format

> +	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);

This should be in a separate test, with a separate description. We want
to test two things: that the function works well, and that the function
still works if we call it a second time.

> +}
> +
>  static struct kunit_case drm_get_tv_mode_from_name_tests[] =3D {
>  	KUNIT_CASE_PARAM(drm_test_get_tv_mode_from_name_valid,
>  			 drm_get_tv_mode_from_name_valid_gen_params),
> @@ -70,7 +97,18 @@ static struct kunit_suite drm_get_tv_mode_from_name_te=
st_suite =3D {
>  	.test_cases =3D drm_get_tv_mode_from_name_tests,
>  };

The test should be next to the test suite definition

> +static struct kunit_case drm_connector_tests[] =3D {
> +	KUNIT_CASE(drm_test_mode_create_dvi_i_properties),
> +	{ }
> +};
> +
> +static struct kunit_suite drm_connector_test_suite =3D {
> +	.name =3D "drm_connector",

That's too generic, the test suite is only about
drm_mode_create_dvi_i_properties(), not drm_connector in general.

> +	.test_cases =3D drm_connector_tests,
> +};
> +
>  kunit_test_suite(drm_get_tv_mode_from_name_test_suite);
> +kunit_test_suite(drm_connector_test_suite);

kunit_test_suites

Maxime

--xd6p4uebt7quuk7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWYCrQAKCRDj7w1vZxhR
xZhoAP9/HSr1uPgk3bR/O7z+sJhZ8oF8HIDcczUezdS6TxzzRgD/UqFNjWcuLggw
67V6UEyZYpHGgXIdMD7K6Tk5eL5x5QQ=
=1gZ7
-----END PGP SIGNATURE-----

--xd6p4uebt7quuk7k--
