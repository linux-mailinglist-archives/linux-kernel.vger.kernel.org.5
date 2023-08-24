Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED778790E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbjHXUD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbjHXUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F2E4E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC2166B6F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E42BC433C8;
        Thu, 24 Aug 2023 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692907392;
        bh=WYmFuBJO9WdKNHYDArQJT3iL6DRY2d4yac2t1qXjLLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpYaWczcqNaP4QuF4cxlnyxK1cKgRNdhLPI5ZL9xS8XYp/Fqmhf34G1lxCRgDBHzz
         NIMsttl9vDwd++TPgxf2KQvnL0GWBLqx3E/qFCgMdB7/r9xsXh6P3xrWToa3rwoV0t
         THOxKUHjLL/OnkA5KGVD+xNjBb1PvRdXntPR3u5PirNQfJE0GTTdJfo1fh/I4AlQs1
         IOXy4qRIsYeXnTpqGJRImB8nP4GnA5gy44hyi/+WlELxrd0irgXqHSuQMX8twfhlND
         JUfcPKxtjZxQIaFZ2eR+5ftBGWuK5mPFatsNLRwbDPrWCqiuu4/w1dVsUemlrNdxbn
         o+EU5dPMBjyaw==
Date:   Thu, 24 Aug 2023 21:03:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Use atomic operation
Message-ID: <ZOe3e7xFfWLd5aHx@finisterre.sirena.org.uk>
References: <20230823141558.957526-1-Naresh.Solanki@9elements.com>
 <61279ff7-c1ad-446c-aa5e-4222a5cbd9fb@sirena.org.uk>
 <CABqG17gQEa70kEDVVhNkOeM2SYdZ6-gkYfYJUNV+=NzyogK_PA@mail.gmail.com>
 <ZOeLjbN8i4i+/kd+@finisterre.sirena.org.uk>
 <e1416ea3-9e20-4662-b394-bc9f842bfccb@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tReW/oW6F/JMhIkK"
Content-Disposition: inline
In-Reply-To: <e1416ea3-9e20-4662-b394-bc9f842bfccb@hatter.bewilderbeest.net>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tReW/oW6F/JMhIkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2023 at 12:32:22PM -0700, Zev Weiss wrote:
> On Thu, Aug 24, 2023 at 09:55:41AM PDT, Mark Brown wrote:

> > Unless there's a strong positive reason to specifically use atomics it
> > seems better to avoid them, like I say they're full of landmines with
> > unexpeted behaviours and therefore something that sets off alarm bells
> > about needing careful study, the mutex is going to be less preformant
> > but is also much more clearly correct.

> I assume this patch was posted as a result of a comment I made on the
> original patch [1], but in hindsight I probably shouldn't have suggested it

I'm literally on a train right now with very intermittent connectivity:

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> [1] https://lore.kernel.org/lkml/d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net/

That's review of "regulator: userspace-consumer: Add regulator event
support".  Sorry, I had managed to reply on that thread but it keeps
getting buried under an avalanche of enormous serieses.

> as it's a relatively minor issue either way -- I think the other things
> brought up in that email are much more significant concerns.  Honestly I
> don't think that patch should be applied in its present form, though I see
> it's still present in the regulator/for-next and regulator/for-6.6 branches
> -- Mark, do you intend to include it as-is in your pull request to Linus for
> the 6.6 merge window?

If it's there I'm intending to include it, though I'm still thinking
about the numbers.

--tReW/oW6F/JMhIkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTnt3sACgkQJNaLcl1U
h9CThQf/SSiL26lfGsfNZSjrh5PWl14dsyAOfUDlqkbhyv17krz4CfuEyEHHzKbg
kQK6eB3lu/ISLpKUAL2ZjUEYR7nENI0pPqvbYd2pK8N3jjWDvTks7ZBYg1ZRmzIK
MJeX2QT7BMXFL3cgifZiqS3UPrrHBxvwzOLjVAKJekZVifdOtmTOEnhQ7n01QPBH
CLfbDFpKuetCx+oZkKfFopGwv4fq68ZIQsBEaWjQSxhNNZXNXIV9zrsARE4uBumu
bVPn0Cswl3/Yeria7Ht0ir4+r59ipMUncij2AQtz384ucbpRBhnV1hEHDbs2DsCZ
2CietddTPp/peKNhzk9hcVpUn4kYTw==
=7Cqb
-----END PGP SIGNATURE-----

--tReW/oW6F/JMhIkK--
