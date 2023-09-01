Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF9678F9ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbjIAIWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbjIAIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635B10E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 145F961595
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B160C433C8;
        Fri,  1 Sep 2023 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693556550;
        bh=XVNvXX/bO1Ro06eni/vmFCMKGyb10EuUDjRJ/YuQe5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGpJZQeeoe17PB/NadGOgUFZG4t2IpUOtMbWOw00q1tzjtazKeKqTY77/pAY+2g2x
         IXLTrcNllVID6KXVtfS8ZPRwe6JbvUZ0f9ZOjvnSDR8fbySC6S+AAdLRlIJ/ETL3l/
         nAs6Zb/B1d/uvA+sJEdIADbdWEA14ARl08HsGdeTv72FNUTkn4KIGTtWNBjK1OLS2o
         koZbVa6Q6EOIuyT20iMz5IzZBpH58cn3z/ECYgn0axIToWd0YEFG55dqOcyKKOQL3+
         MWZdDC+YBOIMfKKFK3oXVYNQhpI4muXqFA2fCFSOShqXHD0g1GVDu00Yn9HRA0jtnz
         j/UUWNZOBmDYw==
Date:   Fri, 1 Sep 2023 10:22:27 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
Message-ID: <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
References: <20230830062546.720679-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vixf6243reldlhil"
Content-Disposition: inline
In-Reply-To: <20230830062546.720679-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vixf6243reldlhil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 30, 2023 at 08:25:08AM +0200, Javier Martinez Canillas wrote:
> The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
> .atomic_check() callback") moved the allocation of the intermediate and
> HW buffers from the encoder's .atomic_enable callback to primary plane's
> .atomic_check callback.
>=20
> This was suggested by Maxime Ripard because drivers aren't allowed to fail
> after drm_atomic_helper_swap_state() has been called, and the encoder's
> .atomic_enable happens after the new atomic state has been swapped.
>=20
> But that change caused a performance regression in very slow platforms,
> since now the allocation happens for every plane's atomic state commit.
> For example, Geert Uytterhoeven reports that is the case on a VexRiscV
> softcore (RISC-V CPU implementation on an FPGA).

I'd like to have numbers on that. It's a bit surprising to me that,
given how many objects we already allocate during a commit, two small
additional allocations affect performances so dramatically, even on a
slow platform.

Maxime

--vixf6243reldlhil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPGfQwAKCRDj7w1vZxhR
xfVLAP9dxCyR8NcP7vGi8pe9GAMot6B0+NAJGNbP1BSqAqT7AgEApq2pVdYbtyhJ
mus/ESrdgLkqvkCpz0hjM85UFKIMXAU=
=Lepu
-----END PGP SIGNATURE-----

--vixf6243reldlhil--
