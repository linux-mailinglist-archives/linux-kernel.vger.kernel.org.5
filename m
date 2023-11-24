Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98FC7F6EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjKXItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjKXIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:48:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26988D6C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:49:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B774C433CB;
        Fri, 24 Nov 2023 08:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700815743;
        bh=ts0KYH2uDH1q8ALGoS/p959d2Z3AhGWJPg58oHHCRiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPkLbo7WvA5ps/jIBO4P0QiKaOtmRQvI+hrI43BegqFBdXQ0euxanJoeOutDImOzZ
         26rKPC2WhMG2dFM6otNzxvJxKZ9ucdxy5MbV8I94wwaCOzlYMCBzEhYQ0xtznrkJi3
         brGuMwgvz6TTB5x50Ggg57G8n40J6dSlvfaEijB+Cv5ptnROBVXgy9l43PcGPp6zoV
         2NWARGz6wntemBdtMKqNV+Xt7OFKIwKE0R3whpBkYfuXrmqTAGyKkasar+T2QRsnbo
         RBDdftQw/wva2ea2uW42I821gm8uFZ7OIAHU7WkhUgCMzVwmBjIuYOiU1Xowyll51U
         rj+QjC1pXZLLw==
Date:   Fri, 24 Nov 2023 09:49:00 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4] drm/test: add a test suite for GEM objects backed by
 shmem
Message-ID: <dkh6t5cya7tw4wz5aqrgvnqqnyzzgvbyvezxexy6pyspju5qbd@cdl4vvs7kvnt>
References: <20231123100147.212645-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rtvjqun5bfrvozeq"
Content-Disposition: inline
In-Reply-To: <20231123100147.212645-1-marpagan@redhat.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rtvjqun5bfrvozeq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Nov 23, 2023 at 11:01:46AM +0100, Marco Pagani wrote:
> +static int drm_gem_shmem_test_init(struct kunit *test)
> +{
> +	struct device *dev;
> +	struct fake_dev {
> +		struct drm_device drm_dev;
> +	} *fdev;
> +

[...]

> +
> +	/*
> +	 * The DRM core will automatically initialize the GEM core and create
> +	 * a DRM Memory Manager object which provides an address space pool
> +	 * for GEM objects allocation.
> +	 */
> +	fdev = drm_kunit_helper_alloc_drm_device(test, dev, struct fake_dev,
> +						 drm_dev, DRIVER_GEM);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdev);

Sorry I missed it earlier, but you don't need the intermediate structure
if you use

struct drm_device *drm;

drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0, DRIVER_GEM);
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);

Maxime

--rtvjqun5bfrvozeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWBjfAAKCRDj7w1vZxhR
xXUQAP9od+klgBILfGLPVPTSdxphG1xUGLo3XXyblMPTgFMz7gEAxqV2NxcgWYJO
vkBCPIX+LUVttVYWyhQvIJ3y+kFqogM=
=eplg
-----END PGP SIGNATURE-----

--rtvjqun5bfrvozeq--
