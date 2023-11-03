Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92C77E032C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346808AbjKCMva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKCMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:51:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DB1BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:51:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18181C433C8;
        Fri,  3 Nov 2023 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699015885;
        bh=UDL7uB32OPQl0Jwayq4f9Bb5i6GM793O2oZWoziNdVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yj7LUZyJbO/iNpBmRWjjobXwTdVjxx99MXyogvRH/H10YNKDmyUwF1ObN+bgemw12
         G3SboFEGjqs7xMDTQh+2aZnE9ucPaWTxdLLY79evL1SYAxWjSby43iMMXHAgGEc1ZD
         fRQK9gH7JrrYAx1MTuQX4zSCZRg/QV8j0eep6eKEOkelTScMejJpx54gxpVEeYX46w
         nt04Vtn5SgAq6cNNJH2qFf14RJeGTJyx0wNmzjWKcrtorltmVLoHLwshf0kwIIcZWh
         ZVLW3GYRoql40dXMvJqgCxhKovaKZHh7Pqu2h4r52Z998v22lqBu9zogXk/goMe8tY
         qzmoLJoVna12w==
Date:   Fri, 3 Nov 2023 12:51:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rui Zhang <zr.zhang@vivo.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        opensource.kernel@vivo.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Only increment use_count when
 enable_count changes
Message-ID: <916eb114-f3d3-4b10-a2c7-ccd411222989@sirena.org.uk>
References: <20231103074231.8031-1-zr.zhang@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gRndleOwOiyF1m8c"
Content-Disposition: inline
In-Reply-To: <20231103074231.8031-1-zr.zhang@vivo.com>
X-Cookie: He's dead, Jim.
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gRndleOwOiyF1m8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2023 at 03:42:31PM +0800, Rui Zhang wrote:

> The use_count of a regulator should only be incremented when the
> enable_count changes from 0 to 1. Similarly, the use_count should
> only be decremented when the enable_count changes from 1 to 0.

Why?

> In the previous implementation, use_count was sometimes decremented
> to 0 when some consumer called unbalanced disable,
> leading to unexpected disable even the regulator is enabled by
> other consumers. With this change, the use_count accurately reflects
> the number of users which the regulator is enabled.

If a consumer does an unbalanced disable the consumer is buggy and the
reference counting is wrong overall.  The bug is in the consumer driver
doing the unbalanced disable.

--gRndleOwOiyF1m8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVE7McACgkQJNaLcl1U
h9DSiwf/f1mCwwC300x8FnGYrkVH57HYVlt4f1mj99a5YunbNEFe/gYWMK8zNKnO
kCmc+QuQlFG0RO9eeDgBmchmSSY8Sjq6hDzKV08gJ/ve3086rK3U9sGoybBpTB2U
j7A0pVKIanC301kmd4fcUROb2tHIo6XqHL9A4QhKvAte6k30eiasfYiVxAwPO1gI
V30xrum8glb/Uxj49cNN+oWY5nLQxUs09B4t7quMfL3HT4027i550PEAyGyX/rPP
d5aAy/6RShrMSCzG0PyO4bJSsx6+Lmcfaw0BTTFzdx5iAbmQ/Rp/nAN3UfNkQ9g9
V2EsrUz7JBmmRcPWILQET7HIWfeN6Q==
=QJpM
-----END PGP SIGNATURE-----

--gRndleOwOiyF1m8c--
