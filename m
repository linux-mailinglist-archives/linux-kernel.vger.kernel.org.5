Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2EF8092A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjLGUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:44:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8104C1713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:44:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B985C433C8;
        Thu,  7 Dec 2023 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701981859;
        bh=d9aDVM2UeURdax+lpotfrVgU9kIaouVQcvPA3ammyFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZcc6zBjxi6Hw9KA7xxdN1W62gPQWQyol1uN7QTMtxIa9WKnE8SU57t/mpAY9P/SX
         5nNnw8aAPE/oVuer1jDxJCVlgzt2vA6TB3fwrHdGItYH8OkEyOBZH6hG4tY8bxNLtx
         ECqcCpkgzxLdlpQxr5/zG2EG4fJL1Bh118j9IKBjVPcEfIZqGy1B+TgqzEIwj1LFpX
         cy4pdGbKaqiT6wiuahVBs5lHs9HF5KzqCHJ5JF+B1YN0JYWzIy2fbAsWq4XbL1T0rc
         RFmnzl1gJgB10ZwLq84RXu7RuC3M9q3od+CXqVReGoBzNmF4OWstUUC+dl/Jabh4em
         LNxMGKpu7q8gQ==
Date:   Thu, 7 Dec 2023 20:44:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 5/5] hwmon: Add support for Amphenol ChipCap 2
Message-ID: <6cce1b87-a9a9-4554-9dae-c24d1d276fb5@sirena.org.uk>
References: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
 <20231020-topic-chipcap2-v3-5-5b3bb50a5f0b@gmail.com>
 <04475f91-bdce-4677-894c-74c2bb8233d9@sirena.org.uk>
 <5b62afcb-254d-4dfc-8332-7979c62ea2c2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="84DjwU6xjfumnT6L"
Content-Disposition: inline
In-Reply-To: <5b62afcb-254d-4dfc-8332-7979c62ea2c2@gmail.com>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84DjwU6xjfumnT6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 09:34:58PM +0100, Javier Carrasco wrote:
> On 07.12.23 21:05, Mark Brown wrote:

> > This is very buggy.  A consumer should only disable a regulator if it
> > itself enabled that regulator (or it *requires* an exclusive regulator
> > which isn't a good fit here), and there's no guarantee that disabling a
> > regulator will actually result in a power off.  Either the board might
> > not physically or through constraints permit the state to change or
> > another user may have enabled the regulator.  The driver needs to keep
> > track of if it enabled the regulator and only disable it as many times
> > as it enabled it.

> The idea is actually that if alarms are required, an exclusive regulator
> will be necessary to trigger power cycles and enter the command mode.

There is a specific API for exclusive regulators which the driver is not
using, and it's unconditionally doing the disable/enable cycle here.

> In summary there would be two options: either a regulator is defined and
> can be controlled to trigger the command mode or no regulator was
> defined for this device and therefore no command mode is available i.e.
> interrupts cannot be configured. That would be the case for example when
> the supply is always on.

The driver needs to be explicitly configured for this and have separate
code paths for normal operation and operation where the supply can be
bounced like this.  In neither code path should the supply be optional.
Right now we don't have a mechanism for discovering optionally exclusive
and enable/disablable supplies which is what the device needs, we could
potentially add that since this does seem like a viable use case and we
already have enough information in the DT to say if the supply matches
the constraints.  Probably the two properties queryable separately.  If
that API were added then the driver would do a normal regulator_get()
then check if it has the capabilities it needs and either keep the
supply on all the time (or possibly just during measurements?) or enable
the alarm functionality.

--84DjwU6xjfumnT6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyLp0ACgkQJNaLcl1U
h9A0kwf6A9o+HV9MW3c5kq5qLVjTu0EmR00E8VExX9/QFePmhDWEVuPtI53Cky5I
vrpgnVTh4FtB23ga32jy7qHH/TpZ7knjqL1f7/iWmJED6Nl3GRQEXullQwAJoV1X
tdO3MjtjJ10YMB6CLdFE7LcNb5APUGAk46tpjigU4a8/Adkctw+G7DN9dJPDhH4U
w8pSe5reBCM7eLpW3YROF3M2j6Ucq60cYlCymE7ijJkhvU+tYvSHIXPLdK53JHxa
DRw75mqIKhSr/gMLpYq2QnyNkFzlr7YPoxTEVwp5IBbOXWbReoiOKvnx/zu4PwqF
ovHn/RKfkkdo03p4ohncAz0eThNaZw==
=5LYW
-----END PGP SIGNATURE-----

--84DjwU6xjfumnT6L--
