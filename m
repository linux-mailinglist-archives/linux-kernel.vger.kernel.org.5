Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA6771A95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjHGGlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4CF12A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C33A61554
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE57C433C7;
        Mon,  7 Aug 2023 06:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691390468;
        bh=shmkDixKjfxqPOOrej8a436ZyPxFgCre534PhMkTgyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxVD8Hp1iaXBb/k+3GfCnYUbLQrwZXepIexhr+bB3i12CvGu1/HUhgkqYVxip66NE
         zE3cZDqeeE9DByt2SwBSjhri8VRgVYOLRtY8jZzfjr5q5ulG0bGrsthbM8Kdfvkia7
         LWsS8vz5NcRTwmgYfdd0nOzLSRxDzAZ91hE6Vv+pK/eUiy7Mubr4DwgrofwHoG/VFC
         owsP8W+ZY/3UhwhGyVXACMr+CQMsp1Tal3r+x6MMvASR/gd7cOmQ3XvfQSwRIK8fEQ
         6XdsGUgLUsXjDzxgLG550/Raa9ALWyH/U1J/P3AZxBN+oRO+A30XLMjaG4jqOfiBCF
         0NwL9USzGJCEQ==
Date:   Mon, 7 Aug 2023 08:41:05 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] drm/panel_helper: Introduce drm_panel_helper
Message-ID: <bphkopaq76imqzut7xrx7aprqybhx3veajdympqhig2wqlix6c@64ck23rc5cv7>
References: <20230804210644.1862287-1-dianders@chromium.org>
 <20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxm7ekfl4brm6ey5"
Content-Disposition: inline
In-Reply-To: <20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cxm7ekfl4brm6ey5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Doug,

Thanks for working on this :)

On Fri, Aug 04, 2023 at 02:06:07PM -0700, Douglas Anderson wrote:
> The goal of this file is to contain helper functions for panel drivers
> to use. To start off with, let's add drm_panel_helper_shutdown() for
> use by panels that want to make sure they're powered off at
> shutdown/remove time if they happen to be powered on.
>=20
> The main goal of introducting this function is so that panel drivers
> don't need to track the enabled/prepared state themselves.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

It shouldn't be necessary at all: drivers should call
drm_atomic_helper_shutdown at removal time which will disable the
connector (which in turn should unprepare/disable its panel).

If either the driver is missing drm_atomic_helper_shutdown, or if the
connector doesn't properly disable the panel, then I would consider that
a bug.

Maxime

--cxm7ekfl4brm6ey5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZNCR+AAKCRDj7w1vZxhR
xUuTAQCAryTeq8rxbABCSj1+5dZaS94tv1e24Y3awd+OHda54gD+MOimHLia2BN8
S9vFKOumNJpLn7fm+W9z9AHJA1tCXQw=
=TfNh
-----END PGP SIGNATURE-----

--cxm7ekfl4brm6ey5--
