Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A277C5243
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjJKLia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJKLi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:38:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551918F;
        Wed, 11 Oct 2023 04:38:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584D0C433C8;
        Wed, 11 Oct 2023 11:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697024306;
        bh=4fx02kIVzNS5/Linr6xalperWLzJEYnNr9bOurgYi+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqRScT5FTcuS3fYqdQHWtC5gAFPo1tF6UDWr2uuRZDMiuuIJrc0PU6OrpuV4nBIb+
         6lSnNp++41Vk1/p8G3bh94Sms/awnr5WMobOOwZJpQRuTc79uoHgrjBjCef1X8EqZ6
         yHaRL5sjr29GCbIqrWAT9rG2WyjvN9aNaT4Y3t3AS/lyIAm3omAVRDRIK8SUdozjrk
         FVpvJfQkbbuPO3Dp5ZAIyca8P0ud9BqGZtQ3aVvpqy3ok2JZRmhj2+tB/zd8TBkKWw
         YIoA9v3Mm5CY8NZFYxZK6AoZjmJbIfZxqu7ka9i4GeTeDRwD+7D9gi44XWPWfAc5Id
         1mqmAb8PDv5Sw==
Date:   Wed, 11 Oct 2023 12:38:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] regulator: fixed: forward under-voltage events
Message-ID: <2d14fd22-c37b-4c15-a2ea-a2fd2c201adb@sirena.org.uk>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
 <20231010085906.3440452-3-o.rempel@pengutronix.de>
 <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
 <20231010125531.GA3268051@pengutronix.de>
 <c2ee404d-d07f-42c6-b5ba-41659773e8eb@sirena.org.uk>
 <20231011075931.GA3305420@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9eSSa5JQlmOnKXkT"
Content-Disposition: inline
In-Reply-To: <20231011075931.GA3305420@pengutronix.de>
X-Cookie: What an artist dies with me!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9eSSa5JQlmOnKXkT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 09:59:31AM +0200, Oleksij Rempel wrote:

> Configuration through the device tree and kernel defaults is preferable.
> For instance, having a default kernel governor that doesn=E2=80=99t requi=
re user
> space configuration aligns with the project=E2=80=99s objectives.

That's policy though...

>=20
> > For the regulator itself we probably want a way to identify regulators
> > as being system critical so they start notifying.  It would be tempting
> > to just do that by default but that would likely cause some issues for
> > example with regulators for things like SD cards which are more likely
> > to get hardware problems that don't comprimise the entire system.  We
> > could do that with DT, either a property or some sort of runtime
> > consumer, but it might be better to have a control in sysfs that
> > userspace can turn on?  OTOH the ability do something about this depends
> > on specific hardware design...
> >=20
> > I've copied in Sebastian since this sounds like the sort of thing that
> > power supplies might have some kind of handling for, or at least if we
> > need to add something we should make it so that the power supplies can
> > be joined up to it.  I do see temperature and capacity alerts in the
> > sysfs ABI for power supplies, but nothing for voltage.
>=20
> Thank you for pointing towards the power supply framework. Given the hard=
ware
> design of my project, I can envision mapping the following states and
> properties within this framework:

There's also hw_failure_emergency_poweroff() which looks like exactly
what you're trying to trigger here.

> Considering the above mapping, my initial step would be to create a simple
> regulator coupled (if regulator is still needed in this casr) with a Devi=
ce
> Tree (DT) based power supply driver.  This setup would align with the exi=
sting
> power supply framework, with a notable extension being the system-wide
> notification for emergency shutdown upon under-voltage detection.

It sounds like this is actually a regulator regardless of if it also
appears via some other API.

--9eSSa5JQlmOnKXkT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUmiSsACgkQJNaLcl1U
h9AXKAf9E3DOuTsypes7HuEYKgcVvvwy45I43FH7VZN2D7Xf19e7tsoHXpWGap5f
LYqv2PoNNArcGBX/V8ioAhYv2GbICFWCefxawYDB8SM+xsKI0/4zRQfz9qKf4xax
pPgDcmCH4bfXsUYMTfjbRZ/l9CRAjwZuYJgJpjRQwlMGe/X1ZYDDAJ/2ulotdVqa
rWBb0vmafnGj/u3oUKOoNYwjUiK4zKRhE/YklWyVQ+APsGzyQ/6R2irdL7sQK0s4
dISgQYXzfljoo9Fpnyn5ZvMQEd1uZyPeyNkoLtcStmlg0SUuc5vPDn7aK0C0GSHf
UQzT4X8/qVMXalQjcHdeimxOL+Uy3A==
=k1e/
-----END PGP SIGNATURE-----

--9eSSa5JQlmOnKXkT--
