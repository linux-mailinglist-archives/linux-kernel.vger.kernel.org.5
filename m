Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDC80706B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378370AbjLFM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:59:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985971A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:59:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0104C433C9;
        Wed,  6 Dec 2023 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701867569;
        bh=lvar08RZ4ORslbEb1luF1/IJqQVEnF3URQJLMAYkhoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1pB5nV18CuS2PHe3L+ATKsQxhSiOiP+u92khN6+OwRfquc8/6aNV+xmKwIMvjtYl
         4wfnynO7HAaGTKQY9Sj+2t6iF9PwPbSZFtabUaueRekoWVedimFrbVwoo7SU+XNnWd
         AcBkffwJ59POnly2CwLOJFE44jtHmcM8BjjJHCu+jpWhx5i7HfA8Htbs9VEamSp68V
         lOzdEXvTvbdq3TRIHhLhiap3hCD1hk+/Hjeh3vV1umfjcWFvDNA2Nro1nM+/8IgcRR
         uM+BFpWIsf8Hc/xlKZctAzNuJ5FI8V6mMI7R+HFd7xCrzY9IjGil78gavXK3aF+cGb
         v4UjG+vStQdMg==
Date:   Wed, 6 Dec 2023 13:59:26 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/mipi-dsi: Fix detach call without attach
Message-ID: <b3wltiggcukzseiv4vixy3tbhel3c5htzfgr77yjolb3z7wrh7@h746u326byrb>
References: <20230921-dsi-detach-fix-v1-1-d0de2d1621d9@ideasonboard.com>
 <17b43cb8-1543-48d2-830a-b9f6dd50fc15@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ru2mkl7w2cdikn2"
Content-Disposition: inline
In-Reply-To: <17b43cb8-1543-48d2-830a-b9f6dd50fc15@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ru2mkl7w2cdikn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 06, 2023 at 02:48:58PM +0200, Tomi Valkeinen wrote:
> Hi mipi dsi maintainers (I'm not sure who that is =3D),
>=20
> On 21/09/2023 13:50, Tomi Valkeinen wrote:
> > It's been reported that DSI host driver's detach can be called without
> > the attach ever happening:
> >=20
> > https://lore.kernel.org/all/20230412073954.20601-1-tony@atomide.com/
> >=20
> > After reading the code, I think this is what happens:
> >=20
> > We have a DSI host defined in the device tree and a DSI peripheral under
> > that host (i.e. an i2c device using the DSI as data bus doesn't exhibit
> > this behavior).
> >=20
> > The host driver calls mipi_dsi_host_register(), which causes (via a few
> > functions) mipi_dsi_device_add() to be called for the DSI peripheral. So
> > now we have a DSI device under the host, but attach hasn't been called.
> >=20
> > Normally the probing of the devices continues, and eventually the DSI
> > peripheral's driver will call mipi_dsi_attach(), attaching the
> > peripheral.
> >=20
> > However, if the host driver's probe encounters an error after calling
> > mipi_dsi_host_register(), and before the peripheral has called
> > mipi_dsi_attach(), the host driver will do cleanups and return an error
> > from its probe function. The cleanups include calling
> > mipi_dsi_host_unregister().
> >=20
> > mipi_dsi_host_unregister() will call two functions for all its DSI
> > peripheral devices: mipi_dsi_detach() and mipi_dsi_device_unregister().
> > The latter makes sense, as the device exists, but the former may be
> > wrong as attach has not necessarily been done.
> >=20
> > To fix this, track the attached state of the peripheral, and only detach
> > from mipi_dsi_host_unregister() if the peripheral was attached.
> >=20
> > Note that I have only tested this with a board with an i2c DSI
> > peripheral, not with a "pure" DSI peripheral.
> >=20
> > However, slightly related, the unregister machinery still seems broken.
> > E.g. if the DSI host driver is unbound, it'll detach and unregister the
> > DSI peripherals. After that, when the DSI peripheral driver unbound
> > it'll call detach either directly or using the devm variant, leading to
> > a crash. And probably the driver will crash if it happens, for some
> > reason, to try to send a message via the DSI bus.
> >=20
> > But that's another topic.
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > ---
>=20
> Any comments? I can push this via drm-misc, but I'd like an ack.

An ack is a requirement, it's not optional.

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--5ru2mkl7w2cdikn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXBwLgAKCRDj7w1vZxhR
xVm2AP4lzzMS9AIxLfwi+DBan5rF0+9sRuEawKmLVG5Dhlr8pgEA5aQqW0Jxatak
kWZMCHxy4Rne5nN91Y54zMv2CT24UQY=
=1mwD
-----END PGP SIGNATURE-----

--5ru2mkl7w2cdikn2--
