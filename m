Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666607D51E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjJXNgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjJXNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:36:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959EC6A47
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:26:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60007C433C8;
        Tue, 24 Oct 2023 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698153989;
        bh=017iYigc54wK1AgkfF311wOfS8sHvclf3x7swW1vb8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOT/LD03H8E9/zD2wPkCLr4kRtmpkWEiOFzJyccnWaTUKi36w6Xr+JmXUIx5wYlRk
         oenBdo3tCgTNO6WxpESGDrSmOIAKlfpL1P7zEdrP+xq2Z494umqDGXa8RteCF/kv2n
         z41w/QIjd8B/MzqTainPyO3IC00mVPRkSN8HobHr1/90WGey1LhXXVSWKioN1zC/iI
         JBDBt8qtbS31HW3qokkg7+buZJ21jne1Y0Slo0ReuCqt1pB3y4lCpwQGBkNFpNzWme
         qfIRh5xv872/GLGR5CiOKrjKQ5Ogn+k7dWOg3bkSEpSPXSc8y1+88SC0NEugJkgOTW
         2kNfyKAxg/+gA==
Date:   Tue, 24 Oct 2023 14:26:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: fixed: add support for under-voltage
 IRQ
Message-ID: <471281bf-4126-496b-93ef-0807f4910ce7@sirena.org.uk>
References: <20231024130842.2483208-1-o.rempel@pengutronix.de>
 <20231024130842.2483208-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uF8HXoNA/AGKb/YU"
Content-Disposition: inline
In-Reply-To: <20231024130842.2483208-3-o.rempel@pengutronix.de>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uF8HXoNA/AGKb/YU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 03:08:42PM +0200, Oleksij Rempel wrote:

> Add interrupt support for under-voltage notification. This functionality
> can be used on systems capable to detect under-voltage state and having
> enough capacity to let the SoC do some emergency preparation.
>=20
> This change enforce default policy to shutdown system as soon as
> interrupt is triggered.

=2E..

> +static irqreturn_t reg_fixed_under_voltage_irq_handler(int irq, void *da=
ta)
> +{
> +	hw_protection_shutdown("Critical voltage drop reached",
> +			       FV_DEF_EMERG_SHUTDWN_TMO);
> +
> +	return IRQ_HANDLED;
> +}

We need a bit more policy here - the regulator could be critical to
system function but it could also be well isolated and just affecting
whatever device it's directly supplying in a way that the system can
tolerate and might even want to (eg, for something like a SD card or USB
port where end users are plugging in external hardware).

--uF8HXoNA/AGKb/YU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU3xf8ACgkQJNaLcl1U
h9DtuAf+MSSbDFj6UK22EAUJGxqPboAwLoDDRg3zGxLEvO2ohr9XMV5N/KqVlsJI
FOq474QBednEQeLQKZEvlgP6b/xy+hSbJSl0KNwDm+ViHqiKZSJsIkktGbEqdXfS
hTalmmsiXjAF4ur04dgSRhd3i7bvIjktWH7RviF8zpYuBQvAhWcd9oO8H7L7y5Fw
v2XKE3AYSJRqE0tM2WhufObe6coA5c0ihRmHv69iyncrM6UqsEasb0vpI+hrir8x
ofqKsU8SUb5KvBfYMaqEXbp+mItuLZ25tUkQObZnAy+CLzONB4fPKroVccLpNc08
YvLpMrUBpXoCv6Oax7PPak5qYXdipw==
=TupP
-----END PGP SIGNATURE-----

--uF8HXoNA/AGKb/YU--
