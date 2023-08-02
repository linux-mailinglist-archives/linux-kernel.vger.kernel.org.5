Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82376CC81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjHBMVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjHBMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E4269E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB2A6194F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC7C433C8;
        Wed,  2 Aug 2023 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690978890;
        bh=ogitFwxiVJEn4CoyxI5FjfjwCwtkte8vNfmXWrRsODE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noRTLmnPH4uUx0Afpw1gJ8ege5fg4D1a0fUOXhzBHq+DUXSS9jSHxO5biX32qesZW
         8I7+h1LUbpKCZuAkziXo8HpxyrihD0SEJinYhS/3KBdK+foRNR3rdrIilK+iueUsjg
         aezU/56qaYPazZzw4GxAPqRkWX4NBPNW4tkIn1rfITfVKPcCrz2NyesyrHw+OO4f1G
         vmw5XpGWra56wqHoOqc/tjCf0Iow+Pw56psBfzqeRwiBBoZptVcglK01Cr1xiTP9oy
         UynVEjYZgMQjOm6yVl2mDzeHa5ODiHPws4DPq69umjWMVzDLK51UED+G0PyPP12HrH
         cp9QGxlh1jJKw==
Date:   Wed, 2 Aug 2023 13:21:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Only provide the length to cpufeature for
 xCR registers
Message-ID: <371e0fb4-0f99-40cc-b93f-0eae700d720c@sirena.org.uk>
References: <20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org>
 <20230802112122.GA27807@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1uDqYgO4mPaxFj58"
Content-Disposition: inline
In-Reply-To: <20230802112122.GA27807@willie-the-truck>
X-Cookie: Humpty Dumpty was pushed.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1uDqYgO4mPaxFj58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 02, 2023 at 12:21:23PM +0100, Will Deacon wrote:
> On Thu, Jul 27, 2023 at 10:31:44PM +0100, Mark Brown wrote:

> > -	return zcr;
> > +	return SYS_FIELD_GET(ZCR_ELx, LEN, zcr);

> Hmm, now this function looks like a mixture of code which relies on the
> LEN field living at the bottom of the register and code which is agnostic
> to that.

> Can we update the 'zcr |= vq_max - 1' part to use something like
> FIELD_PREP() instead?

There was a version 2 that was sent already which goes in the opposite
direction and just returns the value we would munge in without use of
any FIELD_ macros:

   https://lore.kernel.org/r/20230731-arm64-sme-fa64-hotplug-v2-1

which also addresses your issue?

--1uDqYgO4mPaxFj58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTKSkUACgkQJNaLcl1U
h9AHJwgAg+nXJyQuf3AqMJk5Q6LltUsyoWN4pcsTj9N7jmAjC3BzckwVSJWaHH8v
YSuer7bWaeNz+5UV56seMg5J8aOat1K0BdmgTdXK/km64a9QuWJWgVVH/piFZxhN
vxN0yhxhDKEeSTrL3AcJBs9Hw3bi3WgTAbX93UKL+o1NCjYrq5hG4LgJmOcC/VpA
AD0c95DbuucmUMAECd8JQjcnNrudyvhPqo+ANrePLtnt9lIDxqXrZYLjuAkDzebL
DaKuF5EVsunMkDvSYarJ3WHcNbetZx8teAB/NdghbIVZxXmqc2+nhTg6gcGoZ6gx
/TmPFrvCY3JJv8MspxcTi6mAdhaIMA==
=oEaC
-----END PGP SIGNATURE-----

--1uDqYgO4mPaxFj58--
