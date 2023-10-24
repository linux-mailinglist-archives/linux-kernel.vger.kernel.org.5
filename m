Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278197D5733
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjJXQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjJXQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:01:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D55BD7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3227CC433C7;
        Tue, 24 Oct 2023 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698163297;
        bh=Mf9kKkvzbQgiQoeDAatd1OQUmxwlJN/S9OyYQXKGEc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qK8WUa3bIEr5FMNqVlHlcv/pJpND1bXxoulr/BdaYyQf9uvQOkvA/Uzu6Jc6WDupb
         dlNYzubaHJCVOf15l3TRgXc8TaKMBgJJMS77aEXGNryEt8sxNcny3FYT/L4D2v2ewN
         GfKhZHL7iKMJyZidX9kSKrP9ljif52CGo1zIlMYUWZKFLM0qZsST/G/U+rtExG0oCL
         V2+0clA1AKHDy69ld3IHyhEGhn+jo+31END9zgXqbsnL0GpUgJmNJ4ey4sGzG4cf5r
         GUM6174Uht9M2HnTzvIUTvAn49uqLWDsY3FGKkghNhbDszK2kHBMUuw2ocn1bOA4KI
         RgfXGimBuwy9A==
Date:   Tue, 24 Oct 2023 17:01:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: fixed: add support for under-voltage
 IRQ
Message-ID: <8cec1d82-76f1-4547-a6a9-139d535b68d8@sirena.org.uk>
References: <20231024130842.2483208-1-o.rempel@pengutronix.de>
 <20231024130842.2483208-3-o.rempel@pengutronix.de>
 <471281bf-4126-496b-93ef-0807f4910ce7@sirena.org.uk>
 <20231024140634.GD3803936@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ZRbw1cI2dEt2bA3"
Content-Disposition: inline
In-Reply-To: <20231024140634.GD3803936@pengutronix.de>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ZRbw1cI2dEt2bA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, 2023 at 04:06:34PM +0200, Oleksij Rempel wrote:
> On Tue, Oct 24, 2023 at 02:26:24PM +0100, Mark Brown wrote:

> > We need a bit more policy here - the regulator could be critical to
> > system function but it could also be well isolated and just affecting
> > whatever device it's directly supplying in a way that the system can
> > tolerate and might even want to (eg, for something like a SD card or USB
> > port where end users are plugging in external hardware).

> Hm, how about devicetree property to indicate system critical nature of
> the regulator. For example "system-critical-regulator" or
> "system-critical-undervoltage-interrupt" ?

I'd probably go with the former.  As a code thing we probably want the
driver to generate an under voltage notification and then the core uses
that notification to trigger the power failure handling.  It feels like
we might end up doing something better in future but I'm not seeing it
right now and there's a fairly clear argument that this is a part of the
hardware design.  It shouldn't be too bad to do backwards compatibility
if required I think.

I'd put the property in the core regulator bindings then it'll work for
everything.

--6ZRbw1cI2dEt2bA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU36lsACgkQJNaLcl1U
h9DEMAf/b0hht0qoFdMoe5Xkj2U2OnGOK7SA/X4atAV+jFj6c8lqiDzcEA0O6Whe
vJKLyZaHjJmBjPxjkSBb2Cw3CSyIRQCy5cYEfil7m1ryhCApq35ZxDN3Fp09AJkx
C8KnYdQQouG1Y+VCigihXlMrMAU4ldCzDNqLMiZStToWj5cckDsB4X/G76zGJ+NV
YKpoLF0L5PXUbiKcQv2xbdPTdKZ0XAntTUa4cgVTQe494R0Z+LagUcppzZr6m+9k
c1MHoL0eoiANPW4917PzDUgXsCMIyFySzjNQRqAjaxLCJgTwLhkNmE3zy4Vkve/j
0rLWz3pyl3hVFzdEmhrTOZ07TU7jsA==
=YAgb
-----END PGP SIGNATURE-----

--6ZRbw1cI2dEt2bA3--
