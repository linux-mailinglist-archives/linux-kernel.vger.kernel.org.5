Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F47C026D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjJJRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjJJRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:20:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147F93;
        Tue, 10 Oct 2023 10:20:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39426C433C7;
        Tue, 10 Oct 2023 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696958406;
        bh=qCJusQWtmT7cmM9tukUxP7rBW0qd61lclOqkdLABC9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4AoOsv5XE1vd2PTasKy09QSiUySWg/qOeHiXxYa5Hl8L6f4B268VJ4FHQf5uDN+f
         OuGGGEdLfwRgw/dhsgHIKHIE0ZIBtbC3iWsrnib0rEbWvT2YeP8WSr1tA75Scm7m76
         rHLrobj6O8lSI2Urs9u2QZifRiXuAR3H+YqMgSXNWz9IDi45GgEzIhs2tT16vwiIUM
         +dwZTd2PFqrHVXzQSxVTXljAbuRTOzZzCZjmFsndVhQgZ0ZbTzwgSMOmc5X9bNUVbK
         Qq5L8uYim+az0tUwbMzBxbIsB1Pdf6ZQAOatqmrJZ/Pzk+illVXcyf/NQ7fSnUYGkc
         VsFGGOpovrRiQ==
Date:   Tue, 10 Oct 2023 18:19:59 +0100
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
Message-ID: <c2ee404d-d07f-42c6-b5ba-41659773e8eb@sirena.org.uk>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
 <20231010085906.3440452-3-o.rempel@pengutronix.de>
 <5e51792a-cc93-4364-a51b-c2b116d89369@sirena.org.uk>
 <20231010125531.GA3268051@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ih8Qo3EanWX6jsWc"
Content-Disposition: inline
In-Reply-To: <20231010125531.GA3268051@pengutronix.de>
X-Cookie: I feel partially hydrogenated!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ih8Qo3EanWX6jsWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 10, 2023 at 02:55:31PM +0200, Oleksij Rempel wrote:

> The hardware I am working with has an under-voltage sensor on the 24V
> supply regulator and some backup capacitors to run SoC for 100ms. I want
> to forward under-voltage events across a chain of different regulators
> to a designated consumer. For instance, to the mmc driver, enabling it
> to initiate shutdown before power loss occurs.  Additionally, a bit can
> be set in the volatile memory of a scratch pad in an RTC clock to record
> sudden power loss, which can be checked on the next system start.

So it sounds like the underlying need is to flag the notifications from
one of the regulators as being system wide and then take action based on
those notifications somewhere basically disconnected?  That does seem
like a good use case.

The MMC doesn't specifically care that it is handling a regulator
notification, it more wants to know that the system is dying and doesn't
really care how we figured that out so if we can hook it into a system
level notificaiton it'd be happy and would also be able to handle other
critical faults.  I would have thought that we should have some
mechanisms for this already for RAS type stuff but I'm drawing a blank
on what it actually is if there is an existing abstraction.  It could
potentially go through userspace though there's latency concerns there
which might not be ideal, there should at least be some policy for
userspace.

For the regulator itself we probably want a way to identify regulators
as being system critical so they start notifying.  It would be tempting
to just do that by default but that would likely cause some issues for
example with regulators for things like SD cards which are more likely
to get hardware problems that don't comprimise the entire system.  We
could do that with DT, either a property or some sort of runtime
consumer, but it might be better to have a control in sysfs that
userspace can turn on?  OTOH the ability do something about this depends
on specific hardware design...

I've copied in Sebastian since this sounds like the sort of thing that
power supplies might have some kind of handling for, or at least if we
need to add something we should make it so that the power supplies can
be joined up to it.  I do see temperature and capacity alerts in the
sysfs ABI for power supplies, but nothing for voltage.

I've also coped in Naresh and Zev who've been discussing something
vaugely similar with userspace notifications for the userspace consumer
- it's not the same thing given that you don't specifically need
userspace to be involved here but it feels like it might have something
of a similar shape, or at least there might be some shared interest.

--ih8Qo3EanWX6jsWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUlh74ACgkQJNaLcl1U
h9BF5Af/cNLrd9suEh0YQRnHMcZMOu5P6+gEvdfAYSXg0loxTuDLopt6elxYJCv2
zmqJiVW40ro7MaAB0jXUOtx24Pmq9+Bk6fzfMLa7VXbXagJWATmiyQSnSkppCyWM
92lTC3Q4ki1/ESroIxYQRWk7UMCPN+S4GC3qgOuRxrVhLjPJ+GcT9HFUeq8batZf
7ublB0wmAYUM4qZiTDMhxlxC0emAgob7u4qJXaeNOPk/26mksiuJTdeiDhMTx5b3
Ud3mzW+o8ErnRwNGAVAZ/kM+MH5idQAb6U1Kgu2XzDc6znqCie4e46XmekD0WeIT
q7CtZrlu1/m46hXmiF9WVnGe4p4UfQ==
=EDr0
-----END PGP SIGNATURE-----

--ih8Qo3EanWX6jsWc--
