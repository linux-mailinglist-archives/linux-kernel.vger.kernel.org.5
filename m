Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6897A01B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjINKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjINKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D41FC6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:32:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE97BC433C7;
        Thu, 14 Sep 2023 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694687537;
        bh=HWuwnMWwmoy6y7laW8KuI+FiHflIOtHqs/4Y7u4IyRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vt5N4LvG5mD+1xGzst1aDJ4tbntqF3o5GfmCS2r+ZXx0DW6ZYmygEFJMddzXLu7x0
         zqHabs+cbjvebiTmOWGujwGmfGDjL8lIxWDUUuXybrBzBwi/tsyh8iwSdYugHjqoer
         6TH84ietbmQGqsSOPZqIV06BGUFmDyrlYbLsROp1MKApKYcNm4yqQ4QrOkwKXvCo0d
         0xFnyfYeI5RbjQO737blVUnSZpeCWiknG7bR9bHa0cZpcDwY6l7r2460Jas1sjO8oi
         a9dNtbKbWKASHlI9rJ2lap/sa70puBAIyR2ecZMcR1pKMwnTBQYsg3DoCy1/biGzRo
         /mTE9uxV8ClBg==
Date:   Thu, 14 Sep 2023 11:32:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Only default to enabling SVE when present
Message-ID: <d090e3db-ebed-4cc8-a1f8-a2c15f8a39b1@sirena.org.uk>
References: <20230913-kvm-arm64-fp-init-v1-1-8ce9ba1cc4c4@kernel.org>
 <ZQJODdfwZLxc9o1l@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z0nQ7h2X83FBCQV9"
Content-Disposition: inline
In-Reply-To: <ZQJODdfwZLxc9o1l@linux.dev>
X-Cookie: Do clones have navels?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z0nQ7h2X83FBCQV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 14, 2023 at 12:04:29AM +0000, Oliver Upton wrote:
> On Wed, Sep 13, 2023 at 07:34:16PM +0100, Mark Brown wrote:

> > -		if (!vcpu_has_sve(vcpu) ||
> > -		    (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED))
> > +		if (cpus_have_final_cap(ARM64_SVE) &&
> > +		    (!vcpu_has_sve(vcpu) ||
> > +		     (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED)))

> vcpu_has_sve() already tests system_supports_sve(), so I don't believe
> this hunk is necessary.

That'll mean that the first branch of the || should always return true
on systems without SVE so we'll set CPTR_EL2_TZ, and there's also the
check for guest ownership as well.

--z0nQ7h2X83FBCQV9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUC4SsACgkQJNaLcl1U
h9CFOQf/QechB02CRL9EgDHH6cg1JKq0BnYtRhWUwz4dRh8P9+AOR9+EGb+HsFXO
fEDX/KBk6rjyAQxOdW4h9Xeiz3FwDwzqp5bByWlQqCBahox0Hu9tVq2B592IhzOm
Iskr9i0ysKw/oJ40YgBYB2dMuAEoS3kCk3rLGhzog4N59jzt3l/NkKt4SHkhjwtE
83pIAzF+TGu2g2fzMaDRYdGyA/RobSDnxGyLrDvSRyq4PVHIAzHWhS2+e5yoNid7
tNeo65Rxjumu3e8DdGhQarWfW9Rb51cWFIGEw3SqYn73DdnV7DBxMSVPaq1McW3n
cz1MP4Y8H+8mm+6rOtv5S4/SzzfEyQ==
=Ph8R
-----END PGP SIGNATURE-----

--z0nQ7h2X83FBCQV9--
