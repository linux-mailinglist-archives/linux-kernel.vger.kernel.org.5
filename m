Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4687E80C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbjKJSRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbjKJSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02A38E80
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:18:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A8FC433C8;
        Fri, 10 Nov 2023 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699625923;
        bh=A04DKyynpbL+kyv3aLhCQb9LEAuygJfW0BtVcdATL/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8Ua5o9JO8S5fXlam/8qnw1Z3zdivcVH/ca6Eg+Hl8RI85VDFwDDO39HaHX+IOYht
         5deWrPbW5gjwnh2qCdiD9/7gVyOtvG8+BqVwFKdp0H+iIDEsA29p2mow+oGxZpeSF5
         bWW5g08wbOJN/nHlLg6PVYOV+xLWZO9TNc2LiZfiPemjwXKCHCt8mpsFLFcfrC2sSW
         FlyRwVNJRIyk+JTU2ZIOHiEBhuzeD1i7lepIzhPyhrcTepXIwi603szei2FQdEAxfP
         4FSSNzOIt5QmtFQQlBKiuDnu+QI27ZENyCsebl32ghd62AzuV5Ijr2SlUgMcvnjyKQ
         oz/9v99wPgscw==
Date:   Fri, 10 Nov 2023 15:18:40 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dipam Turkar <dipamt1729@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch, mairacanal@riseup.net,
        javierm@redhat.com, arthurgrillo@riseup.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tests: Add KUnit tests for
 drm_mode_create_dvi_i_properties()
Message-ID: <f2nkuewkbcgbqjfklpqf74lgiwnidcyr3bgr42neq3xnrvawcp@g4iketyic4q4>
References: <20231110110323.381215-1-dipamt1729@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jjzec3bttiztr4j"
Content-Disposition: inline
In-Reply-To: <20231110110323.381215-1-dipamt1729@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6jjzec3bttiztr4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 10, 2023 at 04:33:23PM +0530, Dipam Turkar wrote:
> Introduce unit tests for the drm_mode_create_dvi_i_properties() function =
to ensure
> the proper creation of DVI-I specific connector properties.
>=20
> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>  drivers/gpu/drm/tests/drm_connector_test.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index c66aa2dc8d9d..aad63839b5e5 100644
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
> @@ -58,10 +61,27 @@ static void drm_test_get_tv_mode_from_name_truncated(=
struct kunit *test)
>  	KUNIT_EXPECT_LT(test, ret, 0);
>  };
> =20
> +static void drm_test_mode_create_dvi_i_properties(struct kunit *test)

You should document what this test is checking.

Probably something like:

/*
 * Test that drm_mode_create_dvi_i_properties() succeeds and have
 * created the DVI-I subconnector and select subconectors properties.
 */

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
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subcon=
nector_property);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_=
property);

These two should be expectations, not assertions.

>  static struct kunit_case drm_get_tv_mode_from_name_tests[] =3D {
>  	KUNIT_CASE_PARAM(drm_test_get_tv_mode_from_name_valid,
>  			 drm_get_tv_mode_from_name_valid_gen_params),
>  	KUNIT_CASE(drm_test_get_tv_mode_from_name_truncated),
> +	KUNIT_CASE(drm_test_mode_create_dvi_i_properties),

This test suite is meant to test drm_get_tv_mode_from_name. Please
create a new test suite for the function you're testing.

We should also add a few more tests, like calling it twice will still
return 0 on the second attempt for example.

Maxime

--6jjzec3bttiztr4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZU47wAAKCRDj7w1vZxhR
xS5qAP9BvwybHTDWHWNUcwVoUMfCC0PAmQuRLkn3bi03ygAHBQD/XTK4qbfNQnz5
BWH74qOeF3uqLI2fCQl0NzXqeqddsgE=
=q5ln
-----END PGP SIGNATURE-----

--6jjzec3bttiztr4j--
