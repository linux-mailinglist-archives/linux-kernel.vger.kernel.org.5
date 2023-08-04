Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2476FFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjHDL5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B835B1;
        Fri,  4 Aug 2023 04:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F36AC61F84;
        Fri,  4 Aug 2023 11:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3301CC433C7;
        Fri,  4 Aug 2023 11:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691150225;
        bh=9dHPIWei1lQvg0gJ7x4MSUMPkCG5dKhD6C1oBv23fuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cn1s6G/uxcXadA0vnjvrmc9fNJzoBMgl0EPmPI8Zpf8J59g7sqNGGaW4B74fy+/mj
         KnFrsTMuc0s5drUhxhuK9bREK1+hREvd/VH5MQnAOK26jOBX4ZTPtTHiMqHfhXn/Iq
         lQ/UnrFDpTzwHlW1w2pzBOzwOIxjAEMVKmgLRAYzJpf5N66Wc/lv+RGUEVZmqU7CO8
         Sqb2kSD9g/CmODlGDDHqE69pKfzpXA47u04Urkl1CsADPxJCkmAQbUX8LK/n5pMxfC
         cRgGnEa4WX8t2z7tJ6FojOmGV7ednBicrxdR84XxDzO3ej3nle6Uli5Sr4RlEbqvat
         SO4LNy4MnGREg==
Date:   Fri, 4 Aug 2023 12:57:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     coolrrsh@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/2] fixes warning
Message-ID: <abc6fd12-345b-40ac-838c-7e7c954ffcbd@sirena.org.uk>
References: <20230804115121.34035-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EinGkbFxHzb+mjgS"
Content-Disposition: inline
In-Reply-To: <20230804115121.34035-1-coolrrsh@gmail.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EinGkbFxHzb+mjgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 05:21:20PM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>=20
> drivers/spi/spi-mpc512x-psc.c:493:5-13:
> WARNING: Unsigned expression compared with zero: mps -> irq < 0

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

>  	mps->irq =3D platform_get_irq(pdev, 0);
> -	if (mps->irq < 0)
> +	if ((int)mps->irq < 0)
>  		return mps->irq;

Casts are almost always the wrong choice.  If the issue is that the
value is unsigned and can't be negative casting it to signed isn't going
to help, though here possibly the type of the variable is wrong.

--EinGkbFxHzb+mjgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM54wACgkQJNaLcl1U
h9CjLAf4iPJD/78J99DOMVoPiGetjhuwUND1SXwkKmss/KVgI911p8J+nZKXVQIg
ktvKmMxfAMGqJG69wrBBa+u7+NqCP/vHGFHai3x7rJY0bcuy1GnWtYE3yw//rVQ+
gLMWsKHfzKySHHTBxiZOKz6g3V4brPfYVOSoYT4Ygmtp58XzCzR8bfQIzMqtGHKi
4IjPbIj4horjA1G6RuPo5sPA9fF/UIQOi4ZFPTCUhEj1h9hYvHRqL543qNvEsooL
BvztkYTIH+CL7HC7PnIxGnMUStYwbwo4nA0tHB4LSUIn/yMYXOKjtefR5npKhu/M
XEB2ccAhWvaWI+tSU6MMV++LWp9B
=B5cz
-----END PGP SIGNATURE-----

--EinGkbFxHzb+mjgS--
