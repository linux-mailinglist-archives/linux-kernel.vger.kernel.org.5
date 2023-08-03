Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73CE76F0D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjHCRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjHCRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF3139
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C0C361E40
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A0FC433C8;
        Thu,  3 Aug 2023 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691084669;
        bh=xbToJnsitmpQr7dyQAE6YSNce9jxCqcAqr9nftiV9hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbkLAvvoKKN+ovMAE7x536LkVFAIXOhysmVKiJAS3SbR8atp9arC8Cj9Aog5fvc6a
         z8TM41xY7yxf7ysFU7TPszllIu4UClaSLILBSvyoN3x+t/8ecccxCLAhPAiYUwu3xn
         LVLVy7tLhmNqPc/MHBfen5e8sZ6vtBSi/s4O98MfaVwOqfmLuClGPB5+nkCT5LJIRt
         eTpvBfbjr2ZcOrgVZiFs7qAqE+GtQuA9Q6y2NpyFDqN8EoqW8UfeRN3FG61ATHO/1b
         LBetBjmo3DvslnhKQs1W9K8j/xEjPF4jFUACni1+jn7ioWmq8GS58I0O1Kv2pOYUgn
         GKvHrNh4V66Mw==
Date:   Thu, 3 Aug 2023 18:44:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/fpsimd: Only provide the length to cpufeature
 for xCR registers
Message-ID: <3ccab5cb-9d19-40a2-ae9c-99d37996da9c@sirena.org.uk>
References: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
 <ZMvYSmpCfFQ2+m7q@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vxGQXyizg+rRua/b"
Content-Disposition: inline
In-Reply-To: <ZMvYSmpCfFQ2+m7q@arm.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vxGQXyizg+rRua/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 03, 2023 at 05:39:38PM +0100, Catalin Marinas wrote:
> On Mon, Jul 31, 2023 at 02:58:48PM +0100, Mark Brown wrote:

> > Since the only field we are interested in having the cpufeature code
> > handle is the length field and we use a custom read function to obtain
> > the value we can avoid these warnings by filtering out all other bits
> > when we return the register value, if we're doing that we don't need to
> > bother reading the register at all and can simply use the RDVL/RDSVL
> > value we were filling in instead.

> Maybe that's the simplest fix, especially if you want it in stable, but

Yeah, it's definitely the sort of change we want as a fix - anything
more invasive would be inappropriate.

> I wonder why we even bother with with treating ZCR_EL1 and SMCR_EL1 as
> feature registers. We already have verify_sme_features() to check for
> the mismatch. BTW, is vec_verify_vq_map() sufficient so that we can skip
> the maximum vector length check?

Both enumeration mechanisms were added in the initial series supporting
SVE for reasons that are not entirely obvious to me.  The changelogs
explain what we're doing with the pseudo ID register stuff but do not
comment on why.  There is a cross check between the answers the two give
which appears to be geared towards detecting systems with asymmetric
maximum VLs for some reason but I'm not sure why that's done given that
we can't cope if *any* VL in the committed set is missing, not just the
maximum.  It's not KVM because that has even stricter requirements and
can't cope with any extra supported VLs.  I'm not sure if the inclusion
in the cpufeature stuff is supposed to expose the registers via
emulation of mrs, though a brief test appears to indicate that this
doesn't actually work if it was ever intended to.

The whole thing is very suspect but given that we don't currently have
any ability to emulate systems with asymmetric vector lengths I'm a bit
reluctant to poke at it.

--vxGQXyizg+rRua/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTL53gACgkQJNaLcl1U
h9Bt5Qf9F5VS7o3Mpv4rLcY72PeZ7NvEVOMu7vHx21f8BXkDjGPiSbiXtOEAk/4v
8kOe/gVXUaBPftoMgMfIulcc+px7SMYs8Mygtbwq/LsW9wF67evocn53+bH0whuk
AITCFmGZCNACka8B9uZcvG4pMy1AECVO4CaAGtxHMT34QrllGAfnaLYTKrdfUgAN
21ySPev0zm8frkTzZiSw4LWaESjSbXtS3Yxqzi2HgRPIyIjbt6ZokWkzQZg42RBR
a+xkiqnURGvq3Zi8oF2Z7zkmX1UiSG9zOcFnRJ+Q6WNv81l513ElrOQzdW8tEUQl
7x5UsGIyLcN743uqxTnCAr9NAk5cJg==
=3hl9
-----END PGP SIGNATURE-----

--vxGQXyizg+rRua/b--
