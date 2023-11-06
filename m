Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728A17E2672
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKFOSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:18:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF452BB;
        Mon,  6 Nov 2023 06:18:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3E5C433C9;
        Mon,  6 Nov 2023 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699280316;
        bh=u8svhs0OTz5m3eqVl0RH5Bqa1jew0U6A6zJ0pPCqAbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeEOcEYy4AKuikIhbFmIe9zY4l8Y2Z/ygsBFJyULM1V8Lu/Xgc1NbPlc9CYmy8AFw
         KBp8zz/P2ZBHTGR5hP2U4UAwWFQo2zjayyritV8exdFIUS5DVfQigm8EOGM/nCF1Tk
         qRB90XgEq68w0bvOSqTcJPqHLuNwvxo83ztX1zAO0pVh3/Rtqny6UGJVC6n1LXAX7V
         mha/BkxhB3jeFW0nnYaLKkFi6Pp4oo/z0fqhoNJQQhcUzFKc4sdkisAJ5lW5iWMCzr
         4eje0uMQy/5jBDuvFIe62GgbcEJUPsPP0mkmgPoERoRaHzGHpdE5MXsZj8dzkY51jW
         dzdzD7eMBLy3w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1r00Rm-0000MC-1Y;
        Mon, 06 Nov 2023 15:19:22 +0100
Date:   Mon, 6 Nov 2023 15:19:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] gnss: ubx: add support for the reset gpio
Message-ID: <ZUj16pzYG_6WR5Jc@hovoldconsulting.com>
References: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
 <20230921133202.5828-4-wsa+renesas@sang-engineering.com>
 <ZS1AxSRL4F5WBvnC@hovoldconsulting.com>
 <ZTYcD8l+lUlLog91@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2TOfkmwbPXlIz3N9"
Content-Disposition: inline
In-Reply-To: <ZTYcD8l+lUlLog91@ninjato>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2TOfkmwbPXlIz3N9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 09:09:03AM +0200, Wolfram Sang wrote:
> > So this means that the reset line will be asserted indefinitely in case
> > the GNSS receiver is not used. Are you sure that's a good idea?
>=20
> Yup. Saves power. We do this for our ethernet PHYs as well. Any reasons
> not to do this?

AFAIK you should generally not try to use reset this way as you may end
up leaking current (and possibly other complications).
=20
> > I don't know yet which module this is for, or how this signal is
> > supposed to be used, but the above makes this look more like an
> > active-high (regulator) enable signal. Perhaps that's what it is or
> > should be modelled as (i.e. as a fixed regulator).
>=20
> Nope, it is a RESET_N pin.

And the neo-m8 hardware integration manual explicitly says that it shall
not be used as a disable signal:

	1.5 I/O pins
	RESET_N: Reset input
	Driving RESET_N low activates a hardware reset of the system.
	Use this pin only to reset the module. Do not use RESET_N to
	turn the module on and off, since the reset state increases
	power consumption.

Some of the other modules in this family says so explicitly also in the
datasheet.

Johan

--2TOfkmwbPXlIz3N9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZUj15gAKCRALxc3C7H1l
CJIwAQCUyRJ2dOra5odtunrzTEfmSEGT8aqQKG1u1/YOvdgjWgD/d4i5DubnOWFW
dGzRIgQl92TRBa3jBbCYWLFr0uqHdQ0=
=Z+gS
-----END PGP SIGNATURE-----

--2TOfkmwbPXlIz3N9--
