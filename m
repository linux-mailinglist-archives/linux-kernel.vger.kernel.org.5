Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2578762B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbjHXQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbjHXQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DE1707
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA7D62F6E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE0FC433C7;
        Thu, 24 Aug 2023 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692896177;
        bh=dP9g90j64qCMaovLVrE7U0qD7d+y+h/LejDD9mU3yPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEq06/3g8UQcYZditNWGtFR2BOKIRJA9n+l15LpuqibLWq9NO9+IRKGeDhgplAXpU
         c3uOH5lDRiDpPeMvMpPgSErsX1dFRFjoAwjpixkQ0v8syBjKLW82fbD62Y0tE/stTQ
         kr0TXU0RHJjq2h+RKKmg2f8Wqq/veBuTB3n0Mv/MIytNdM2INC8lxOsPMUD5Wlse3h
         L0TYKDZB3Y92juwDP0qbh8i1zwC6ZLuBUlgVjTcdwC8qykK3IUg3QYdkvpBLTVWpUH
         Pxt1XHYantu+xCJNfxuUM9EJFXhp6lQoJpxmw3b8KQCX/PLq85AYFI+0P84rwP6lE6
         QkOoS3IIRC/dg==
Date:   Thu, 24 Aug 2023 17:55:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, zev@bewilderbeest.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Use atomic operation
Message-ID: <ZOeLjbN8i4i+/kd+@finisterre.sirena.org.uk>
References: <20230823141558.957526-1-Naresh.Solanki@9elements.com>
 <61279ff7-c1ad-446c-aa5e-4222a5cbd9fb@sirena.org.uk>
 <CABqG17gQEa70kEDVVhNkOeM2SYdZ6-gkYfYJUNV+=NzyogK_PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KrS/+9BqGAjkOSin"
Content-Disposition: inline
In-Reply-To: <CABqG17gQEa70kEDVVhNkOeM2SYdZ6-gkYfYJUNV+=NzyogK_PA@mail.gmail.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KrS/+9BqGAjkOSin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2023 at 04:34:05PM +0530, Naresh Solanki wrote:
> On Wed, 23 Aug 2023 at 20:41, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Aug 23, 2023 at 04:15:57PM +0200, Naresh Solanki wrote:

> > > Replace mutexes with atomic operations.

> > Why?  Generally atomics are more complicated and hard to understand and
> > get right.

> Since the operations involved here are simple & short & can be managed by
> atomic operation.

Unless there's a strong positive reason to specifically use atomics it
seems better to avoid them, like I say they're full of landmines with
unexpeted behaviours and therefore something that sets off alarm bells
about needing careful study, the mutex is going to be less preformant
but is also much more clearly correct.

--KrS/+9BqGAjkOSin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTni4wACgkQJNaLcl1U
h9Bx+wf/aU1+udSDaC7KUPjl07nB/QaQKEc6w62DknVQxJWIw4OiZSOt1OZrsEpb
7WaMQ2sJ9mjtLSYiRPZcIIAKNvBsoDBvOYc7mw+mi6quTXU5jBBY//YRiCSb7Ugc
ZWEYkIBC+upqo3eZNPWaq2QKvM7XuMLg5AlFpyQcThxSW2HZp9XBHEpihfQAQG/c
tujvViKKNl/b7OjnI0QQP0RRSg6z7HZV+mzbgnPqJLMcObdptuQzORpzhp4HJhCH
iOwhnSzzymXDMgv4rBsBvK90ryuUJZb3OJQSweK7XtW4OAXcX5DbQ77yxaws++gg
BfZV+/sjHSMW6ytBorxgwGD99td7+w==
=f4my
-----END PGP SIGNATURE-----

--KrS/+9BqGAjkOSin--
