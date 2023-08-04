Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF77F77061F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjHDQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHDQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81808195
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15069620A7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E59C433C7;
        Fri,  4 Aug 2023 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167058;
        bh=75SJ9oNBzCAJTVXHwYi/Kh5zs6pseVYXb1yCfYgA/mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKjOU3vpN7JC2CXe5aMUE9S3kLh6RciGfHQojJgkF5K5Krx6WEEIWmz9iG/a6c1MZ
         cewyNachBMZ7agc8ueEc0tI1t8mDx0OCFAlhfzhaEpBrzvSgiQ/tRPVXyHu92O20BI
         VniNcHbAAIqdRkAe5L9z05FVhM0iFeIaLp+5jS4NrLrFm6tNiaI5ZtD6ELr0KV6Lvc
         Iv79/rbiJr5Ohx10KSVVh3WIivsTexgoBjKriJkig1oAB3l3BSThMhcyQKLl8otPzi
         baKmXMm+yPBttZWdGmVEZABjAiK1fGbOVRLEEDAQvzLhQxzYbsoNV/yGV5gWKT82Rh
         ENV2ukmHdKkHQ==
Date:   Fri, 4 Aug 2023 17:37:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/fpsimd: Only provide the length to cpufeature
 for xCR registers
Message-ID: <02b86e5c-221a-4e03-bdca-c7f7798e2e01@sirena.org.uk>
References: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
 <ZMvYSmpCfFQ2+m7q@arm.com>
 <3ccab5cb-9d19-40a2-ae9c-99d37996da9c@sirena.org.uk>
 <ZM0lRWTAE/b88V6U@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="crBqxbP703ArtQxr"
Content-Disposition: inline
In-Reply-To: <ZM0lRWTAE/b88V6U@arm.com>
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


--crBqxbP703ArtQxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 05:20:21PM +0100, Catalin Marinas wrote:
> On Thu, Aug 03, 2023 at 06:44:24PM +0100, Mark Brown wrote:
> > On Thu, Aug 03, 2023 at 05:39:38PM +0100, Catalin Marinas wrote:

> > > Maybe that's the simplest fix, especially if you want it in stable, but

> > Yeah, it's definitely the sort of change we want as a fix - anything
> > more invasive would be inappropriate.

> I'd say it's still ok if we can just rip come code out safely (the fake
> ID reg).

It's the safely bit that concerns me here - it feels like a great way to
discover why the code was there, possibly including a use that was there
in the past but has subsequently been removed so bites a stable version.

> > Both enumeration mechanisms were added in the initial series supporting
> > SVE for reasons that are not entirely obvious to me.  The changelogs
> > explain what we're doing with the pseudo ID register stuff but do not
> > comment on why.  There is a cross check between the answers the two give
> > which appears to be geared towards detecting systems with asymmetric
> > maximum VLs for some reason but I'm not sure why that's done given that
> > we can't cope if *any* VL in the committed set is missing, not just the
> > maximum.

> We can cope with different VLs if the committed map is built during boot
> (early secondary CPU bring-up). For any late/hotplugged CPUs, if they
> don't fit the map, they'll be rejected. Not sure where the actual
> maximum length matters in this process though (or later for user space).
> I assume the user will only be allowed to set the common VLs across all
> the early CPUs.

Indeed, since we need to check each VL in the set we expose to userspace
individually that will include the maximum VL which should mean that
having a separate check for the maximum VL is redundant.  That's always
been the case though which makes me worried about changing it for a fix
rather than a cleanup.

For KVM we need the stricter requirement that no additional VLs are
supported in the subset that KVM exports to clients since guests can
directly enumerate VLs from the hardware and we don't want the answer
changing depending on what physical CPU we schedule a vCPU on.  That
should similarly not need a distinct check for the maximum VL.

> > The whole thing is very suspect but given that we don't currently have
> > any ability to emulate systems with asymmetric vector lengths I'm a bit
> > reluctant to poke at it.

> The Arm fast models should allow such configuration, though I haven't
> tried.

They don't, SVE and SME are provided as a plugin and all their
configuration is done at the plugin level so there's no per PE or per
cluster options like there are for features implemented in the model
itself.

--crBqxbP703ArtQxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTNKUUACgkQJNaLcl1U
h9ChPgf/RWiApHGJIQPYa8cms3cTvqgKKSr9/njHe+zUNZhGdEfL3ZZs4ZMeXkLT
eJ9x34uz005RfUw962E0AKrKhplHMyPV1jdpZWIxE2/D79msOPOzkDQmEpvxK5N0
Iyun0jIXn8IJXrSfF2TUAEiQOyRemONPPmBcP/C/5CQt/gdjfYavwZKqyxO8PyjS
GdvAuvfS/EDyhL3vT5KLwabYd83xVUACJdQ3WNE9ELI735Z5KHmjbv/kcDyrFMd4
qYmXkLS2tdADrg/zGz4hF11t03Yv3u2aaHmm+ZaMXq3jnM5ar+F3BqHAPrHSSxBd
sCHFp0cxSNCMAO/QhfEzCYfNBkiqPA==
=bwZ7
-----END PGP SIGNATURE-----

--crBqxbP703ArtQxr--
