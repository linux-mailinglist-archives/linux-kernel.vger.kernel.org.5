Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1E75A2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGSXFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjGSXFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD771FD5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634FE61856
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD3DC433C8;
        Wed, 19 Jul 2023 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689807904;
        bh=c1kAyeT2/7KBAbpwmXh29pZEF+q5kPnmaag+EJh1Qqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpQUOWn0AUvgiKnjHXCW98+iWCMP6lmissWkdrVkhhBMx670uNxYDYApeuyDKjac2
         xHFzX+/JHcRB5quj4i0hzpJ7VlYETbWitMggzafz8TTtzkHXHP/0w4GnfqY57cFTH0
         /sxjVfihXxWNL4SyZhmFV1R3xzSuRUXDZ6DBym8eNyi+M9M6Uz7WGhe2o7c+kp5c2n
         B4+ywrf9f7hMDnPyeU5cAvT7Q4/7mbhOxqRNqcRFM+jDuHRC/TuKG6cWjNZC4rRYyL
         yiWoNYErvEhRmKbIWC/Dqv7MDyly8NpV3EbgSTQ8uKuMPYKu4LqOwcCXO5WsbED2+j
         4QmBFfCihUMNg==
Date:   Thu, 20 Jul 2023 00:05:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Message-ID: <ZLhsHMwP/rVGjCju@finisterre.sirena.org.uk>
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A5P8Z+9FrGkNcy3S"
Content-Disposition: inline
In-Reply-To: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A5P8Z+9FrGkNcy3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 19, 2023 at 03:37:54PM -0700, Guenter Roeck wrote:

> - Update the unit test regmap configuration to avoid using
>   spinlock as locking mechanism for rbtree tests.
>   That would work, but fail to catch situations where this happens
>   in the real world.

Do this.  The test is buggy, users should simply not do this.  Users who
need to allocate in atomic context need to use a cache type which does
not do dynamic allocation.

--A5P8Z+9FrGkNcy3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS4bBkACgkQJNaLcl1U
h9Dafgf/dK6D/11jkZ63HNvQzpHuADBC0CuUaJWRu5fjj8ZtK4mjcjGvld76/TVH
+oMpY9rLcu5ZdVNThv2xFDbawvW8HO4Td0aqMdcR62MEAkn6NpCBbhMK6eVm/Xzs
Go+NDnEEZbhJSbH/RKKuuzxCL2AEAUJLrcvOoU2XNcl/p8kTYJu+W/WMFZMqfe1Y
2xd6bmBBqhatY/7rsUxwg+CFjFseqoUU01QttdD7kFleKcD1wxl+qbz3hae4L+lz
aRxYXwhH0JvvGOchTUcYS20d88VDIiQMJRl5APGtMyi4FyOF8SeNzr20WgmbyBmL
1mp4bBeIq4AQj+XDgrJipRcT6vZ9/g==
=xA8a
-----END PGP SIGNATURE-----

--A5P8Z+9FrGkNcy3S--
