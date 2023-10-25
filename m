Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02E7D7526
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjJYUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:07:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6A12A;
        Wed, 25 Oct 2023 13:07:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B00FC433C9;
        Wed, 25 Oct 2023 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698264461;
        bh=c9hY4E7jNHBShkUUZ0IIyWNWNrY3oYNTtk51W23cdQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9b7mj3Rvwlumnqd+iAxFml04cedqz1VNqRw7ZOpi+Ms5Tz2+VR9XaoQdBG2uhCBu
         m2Pgphd4aG/1B19GZYT+ZvK497Y0KaC8Hq3ow70yk1qH5Bt36qm+ltwt4oEbgvc82y
         Ri/hVZYApxi1B/Wer954MhIRxDvs/7Xho5Goo2rktPYUGVsRXTm/IIqNMeT1MH3WQO
         ddFU0/HrHoxwA/rmhJ7OU2dZRsLM5uIjySzUFE0QfAXgQGS4oDEdmMXferM5rpSbUg
         YkOE9+oOTCtTlQH/ec73SO8TcUCiY4R5DkoaT/2XEtqu+3Gp7KjdM3CNDJGYbQDigV
         Kry5GkHjqZ8kw==
Date:   Wed, 25 Oct 2023 21:07:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Message-ID: <b1cf1c20-4fc6-40cd-932d-0937d78ea1dd@sirena.org.uk>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
 <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
 <ZTeHAqL5QB2w33RN@kernkonzept.com>
 <802e7f15-029c-4eb6-b0d8-53d16f7da37a@sirena.org.uk>
 <ZTlx13fBddvf4n0h@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g2hqgQBCw4uunBRz"
Content-Disposition: inline
In-Reply-To: <ZTlx13fBddvf4n0h@gerhold.net>
X-Cookie: There's no time like the pleasant.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g2hqgQBCw4uunBRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 25, 2023 at 09:51:51PM +0200, Stephan Gerhold wrote:
> On Wed, Oct 25, 2023 at 06:49:47PM +0100, Mark Brown wrote:

> > In these cases where we simply can't read the expectation is that we'll
> > always be using the logical state - one way of thinking about it is that
> > the operation is mostly a bootstrapping helper to figure out what the
> > initial state is.  A quick survey of users suggest they'll pretty much
> > all be buggy if we start returning errors, and I frankly even if all the
> > current users were fixed I'd expect that to continue to be a common
> > error.  I suppose that the effect of ignoring the possibility of error
> > is like the current behaviour though.

> regulator_is_enabled() already returns error codes in various cases,
> e.g. regulator_is_enabled_regmap() returns the original error code from
> the regmap_read() call if that fails. So if users ignore that and
> interpret the value as logical one they either don't care (which is
> probably fine in some cases?) or already use it wrong. Or am I missing
> something?

That's broadly what I just indicated.  Expecting anybody to do anything
useful with an error report is probably optimistic, but it's probably
going to give the same behaviour as we have currently so it's probably
fine.

> > We have to do the reference count in the core anyway since it's a
> > reference count not just a simple on/off so it doesn't really cost us
> > anything to make it available to drivers.

> I assume you're referring to "use_count" as the reference counter?

Yes.

> On a closer look I think it cannot be used as-is for my purpose:

>  1. With "regulator-boot-on", set_machine_constraints() explicitly
>     enables the regulator, but doesn't increase the use_count.
>     In that case we should return true in ->is_enabled(). I'm not sure
>     how we would know, just based on use_count = 0.

OK, so use_count plus other information we also already have to hand.
Or OTOH it's not that much overhead to track the enable state explicitly
for hardware without readback as you're suggesting below if it ends up
being too much hassle.

>  2. To cleanup unused regulators that may or may not be enabled we need
>     to know if the regulator was ever explicitly enabled/disabled before.
>     It's pointless to send a disable request for a regulator that we
>     already disabled explicitly before (after a enable -> disable cycle).
>     use_count just tells us if there is currently a user, but not if
>     there was one before.

It's pointless, but equally well it's not huge overhead.

> I think I would literally need to move the existing "enabled" field from
> the RPM regulator drivers to the core and manage it similarly there
> based on ->enable() and ->disable() calls. Which would be a (slight)
> overhead for all regulators rather than being isolated for the few RPM
> regulator drivers.

These aren't the only regulators with this limitation, we've also got
similar open coding for GPIO controlled regulators like the fixed
regualtor for example.

--g2hqgQBCw4uunBRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU5dYYACgkQJNaLcl1U
h9CeoQf9GrG1ZXfwu4S3UmgmHdp/ON9f+Wh+FEWdiwReoUY+kbRwtjoKqk/QQFFL
M+WuBNZyzkdDDotlVFUkAWNgWVn3WN6VjavgvNqv7vUePrYirPZUCLH8BOJTUWAv
aEbBj8RebicIbsRsmdr6nuKo5l8P0pj9OpgbKTg1JwFqRtXbkR+y+peZu0BVDtN8
qGFk1bXYH9yD8qT5rjdigc74tSlqkyCj/eH9B2hO4YxeyixK+Kdokw9yr4xwAu8f
+XpQ8YALA8yVw/ebravxfl1CHW0FaqoyW5KkyB4Z/RmYhhT+7wQisnXLQ2pUynMX
637bnpuWKiZI4M7p9v3XnBo5P4HWuQ==
=O9bn
-----END PGP SIGNATURE-----

--g2hqgQBCw4uunBRz--
