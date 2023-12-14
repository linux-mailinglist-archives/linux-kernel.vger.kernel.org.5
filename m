Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A47812AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjLNIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:47:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D2E3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:48:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2380C433C8;
        Thu, 14 Dec 2023 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702543685;
        bh=bWHJ2nEewYvkEMXif5fsymjDtt1zbVHkI49YReVBsDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPD0dHulfnGTLBExOIGRTAfiqj1Qk7C1wGbXEFFA+Pt+rXyiZAj7vbwEaxmbG0WwT
         fXFFyJk+4cXRjuEuZOaIW2zJfaQWQVhtRrRRMs9UBCIfoOA/vwGoNjuOsMobs2oBCm
         /x6JnOvRPji6GrvOos2Yw0oUNQ7Twg7kRtElj5s2rVwBJyXcyMMHWXpshWSCkkceSt
         DYWU1oSq1eOTpMnCRdiI6PV+tNisgz0AazAxpQrLs1AbDcui/7JAAaAoEKbqsOi4RV
         TbFefK+3/aSdO1enpIiXwv3fnydWvBXHZc2tXzUZCp7iO2AVsS4o+JMKrdmlVqf3VR
         5MriRhjZBtS9w==
Date:   Thu, 14 Dec 2023 09:48:02 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v5 18/44] drm/vc4: hdmi: Create destroy state
 implementation
Message-ID: <rr5wvkunjglkxozfsvf5zvffwzznq6zt5mzvxw5rx2rpyfzecb@kauuy72x43gj>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-18-6538e19d634d@kernel.org>
 <CAPY8ntBe9RfSjdnd5Smx23La5gQaR9WqY8ehXQyp=4D_11N55Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34euckmdvwkupler"
Content-Disposition: inline
In-Reply-To: <CAPY8ntBe9RfSjdnd5Smx23La5gQaR9WqY8ehXQyp=4D_11N55Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--34euckmdvwkupler
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, Dec 12, 2023 at 11:40:26AM +0000, Dave Stevenson wrote:
> On Thu, 7 Dec 2023 at 15:50, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Even though we were rolling our own custom state for the vc4 HDMI
> > controller driver, we were still using the generic helper to destroy
> > that state.
> >
> > It was mostly working since the underlying state is the first member of
> > our state so the pointers are probably equal in all relevant cases, but
> > it's still fragile so let's fix this properly.
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Thanks for the review, I've applied that patch now.

Could you also review the framework changes (patches 6 to 16) ?

Thanks!
Maxime

--34euckmdvwkupler
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXrBQgAKCRDj7w1vZxhR
xRk8AQDdN5Neajg11B6buyB2iqOXxDC3Ad8XCWlmcjkK9I1jTQEAv+RIYp6M3cV0
8PQqOi1QiT/3hX+WMjreXGSqFUgQCg8=
=hVnz
-----END PGP SIGNATURE-----

--34euckmdvwkupler--
