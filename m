Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195FB7FA295
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjK0OZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjK0OYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:24:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62A213D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:24:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C7AC433C7;
        Mon, 27 Nov 2023 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701095078;
        bh=6o6WiiW5vMWoso1wugzB6W7zAENqZGxNfsw46EhA5Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8p8fU0xHZI1AT78w1hQe0jjlSkJjrwNVQq/L+MQE5tLmPq6aTL1T3u5P3vHRRPfG
         voyE9HYuCFj/fKyx9mjB9AzO38gX1ljTnl+gKfDWhl8DR1/Ff8iQLUld4uY5Ly+Zpf
         WCtIeYRwYPG6hFDHfFj3sO95UNcEsOJJoabPkX82UxPOMEJDEETv4EOi4vl0CH9HnE
         r74t01i88hlV1GQZNN8BwZHHNDfNp2HK9jN7pGqzp9f15y+g+me9cWIgqeP9R46gaO
         DfjyvkZP/fOpsc3tXsFOXQCah/1Etg9+FZ7FvRN6IUw0boP56OxnBHm0ng4KHkY/qj
         vXdFx3fmVWTKQ==
Date:   Mon, 27 Nov 2023 14:24:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWSmlfWYSbQHVvOk@finisterre.sirena.org.uk>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <CANhJrGPop=tL8y+chvPwMpSZYF1pkeWeRp3xL+7JsuY=U0fyag@mail.gmail.com>
 <2023112722-headdress-kissing-8c9f@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GnVq4IS3znoTYk/l"
Content-Disposition: inline
In-Reply-To: <2023112722-headdress-kissing-8c9f@gregkh>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GnVq4IS3znoTYk/l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 27, 2023 at 01:08:24PM +0000, Greg Kroah-Hartman wrote:

> Yes, using device tree would be good, but now you have created something
> that is device-tree-specific and not all the world is device tree :(

AFAICT the idiomatic thing for ACPI would be platform quirks based on
DMI information.  Yay ACPI.  If the system is more Linux targetted then
you can use _DSD properties to store DT properties, these can then be
parsed out in a firmware interface neutral way via the fwnode API.  I'm
not sure there's any avoiding dealing with firmware interface specifics
at some point if we need platform description.

> Also, many devices are finally moving out to non-device-tree busses,
> like PCI and USB, so how would you handle them in this type of scheme?

DT does have bindings for devices on discoverable buses like PCI - I
think the original thing was for vendors cheaping out on EEPROMs though
it's also useful when things are soldered down in embedded systems.

--GnVq4IS3znoTYk/l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVkppQACgkQJNaLcl1U
h9DzJgf/XZUIgoFfylrAspVzy9yXRhGFCwnuYJ3iQcB6u9nrbRn4Q23KaWhqcE0D
jOJpQrRYwe5aO4uKTjd0aVhVrG1CxKduAiFumXEv4cklRha0Q+wL8KNakiP4RCJQ
q48wd503qPV3zXpNrzTQiJfoP2um+AhLoy3b+xRAwkc+GH4r6m21KEfPQ55LVo1j
34LrG9W97d/PsfdRyejjSbEl2iXD6Axs1z7/kCixJ4+6mckRgpgnpokNEav3RBoN
DNkDOMZG88u8wtjnMiqupqw4SoWrK0LD+OjxITxu5O9PajfAlmzW2OHGsVmw5dBw
7FynB37oyWMtsKfu+RUQz9rtt2McZg==
=W9Ia
-----END PGP SIGNATURE-----

--GnVq4IS3znoTYk/l--
