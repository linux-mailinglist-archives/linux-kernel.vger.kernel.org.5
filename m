Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE07D72A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJYRuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjJYRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:49:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F7B137;
        Wed, 25 Oct 2023 10:49:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF2EC433C7;
        Wed, 25 Oct 2023 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698256192;
        bh=GfTn7Xee+oCBAL1wjgkcyUybl3bF+IE0RYsaSIgCmWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVjQaFBLNuLj6tf0nMM9dkdTLSzQJ2nilbMLvi//5ZNnxBgCF498kCqxgeq5fD3TN
         Q+SMDQ84yCAnOf9RSjnqhg4NJ3UNy9b5LG8biq8Snl6E9B0pi+HooxzgGXo7ZgEqim
         rBKA79B7NH6YTf7G5Ens/K0U7uo9y0Skk6VNQkkZg6JPbUzA4LhSsP+T8EFfSd99cI
         lhveiAZ99EFtzU2M1rudgc9xKYdXf+AsrFnshRSKjSa7cTPgA8sc4iZAlc+ixQQxQY
         Qd5UwgADNsgp/qFmnaiPqPb1Ch6eJv9yeWGkq4JiivvSxHhcv4VB8TOUz2kZRv8OZG
         h0MfQvqXaGdDA==
Date:   Wed, 25 Oct 2023 18:49:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Message-ID: <802e7f15-029c-4eb6-b0d8-53d16f7da37a@sirena.org.uk>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
 <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
 <ZTeHAqL5QB2w33RN@kernkonzept.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2sywMGf7CHfsxokJ"
Content-Disposition: inline
In-Reply-To: <ZTeHAqL5QB2w33RN@kernkonzept.com>
X-Cookie: There's no time like the pleasant.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2sywMGf7CHfsxokJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, 2023 at 10:57:38AM +0200, Stephan Gerhold wrote:

> I think it does not change much for this patch, though. Even when
> implemented in the core we still need to represent this situation
> somehow for regulator_is_enabled(). Simply returning 0 (disabled) or
> 1 (enabled) would be wrong. Do you think returning -EBUSY would be
> appropriate for that?

In these cases where we simply can't read the expectation is that we'll
always be using the logical state - one way of thinking about it is that
the operation is mostly a bootstrapping helper to figure out what the
initial state is.  A quick survey of users suggest they'll pretty much
all be buggy if we start returning errors, and I frankly even if all the
current users were fixed I'd expect that to continue to be a common
error.  I suppose that the effect of ignoring the possibility of error
is like the current behaviour though.

> The second challenge I see on a quick look is that both
> qcom_smd-regulator.c and qcom-rpmh-regulator.c use their reference
> counter internally in other function (e.g. to decide if a voltage change
> should be sent, see "vreg->enabled" checks). I think we would also need
> to add some rdev_is_enabled() function that would expose the core
> reference counter to the driver?

> Tracking the enable state in the driver (the way it is right now) is not
> that much code, so I'm not entirely sure if we might actually end up
> with more code/complexity when moving this to the core.

We have to do the reference count in the core anyway since it's a
reference count not just a simple on/off so it doesn't really cost us
anything to make it available to drivers.

--2sywMGf7CHfsxokJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU5VToACgkQJNaLcl1U
h9DB4wf7BiRuxxpXWmgvX+9voz3yXyMjnGHpDT7SedjySMwy6VoNAI4SRRINPF7y
IEMTL/lgYq89V0yfyp2HzXZJrjJ6nn+93l6fVj/0ya//0blP6du/EIsSpL2/fADl
FqFVPo4hd7Vx6XwJGFm7H1O1iPn84xq2muca1fdOvi58KVDbLTtV/ewWKh9IhGNs
NDCVv87dqn3QfIblJUEfOJRR5KKFb4LNdq8DzIdqAg93Pg7FsRtWpOL8/IOxpp9a
uUGESQA7gpqtIM9bZxAaA1XH4jV+g8mxEtScpoSfLQgRZruKY1lkarGU0mUmKrbh
h0V/GWJOTgdVf8sFflAYrBQtw8KB0w==
=GKpo
-----END PGP SIGNATURE-----

--2sywMGf7CHfsxokJ--
