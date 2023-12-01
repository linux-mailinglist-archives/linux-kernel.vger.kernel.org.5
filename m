Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9737E8015BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441812AbjLAVud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAVub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:50:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901ADFC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:50:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFBCC433C8;
        Fri,  1 Dec 2023 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701467438;
        bh=+unD+pWX96Y1kdDVAxBZ7bMp1TVUj6jkcNw1BaPS65Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lD7i61BrsR1vum22JMye1cgGgyHzYmTPfQgHiyBM+gWmfRFwW5q4QNEuKih7ppXrp
         uEZ6w8Sn/aCMbOHCzDjYS61GrI00spwsDarF8QwEtg6ZcNvTOhnQEJ4Am+0VGTm74d
         OI8i8fRZAhvc0g2o6LowV9lww1QBS9cNuCYrbuJwM+c2un3x5YTnYd7lB6GCFHXNGB
         2XyJ61IK/iXVBazsTItz+/BzxQvCh3hKqmJ0NiOI/MXtJLozgAvXE6OwtsDs7VpMYz
         hfsajJSfby98g4SFgALiefSNMRCjoUSj3/T6XnG/Cmktrixx0Hzbal9bN4/Sc8YAg6
         W8wGYYNldYDZQ==
Date:   Fri, 1 Dec 2023 21:50:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: enable controller before asserting CS
Message-ID: <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
References: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YmrIJOCZ+Tf3khLq"
Content-Disposition: inline
In-Reply-To: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YmrIJOCZ+Tf3khLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 04:40:14PM -0500, Ben Wolsieffer wrote:

> This patch fixes the bug by enabling the controller in prepare_message()
> and disabling it in unprepare_message(), which are called while CS is
> not asserted.

This feels like it'd be a good fit for moving to runtime PM - that way
we avoid bouncing the controller on and off between messages which is
probably better anyway.  The driver already does pinctrl management for
the device there.

> Note that bug is likely not present on the STM32H7, because it supports
> the AFCNTR bit (and this driver sets it), which keeps the SPI pins
> driven even while the controller is disabled.

It also occurs to me that this isn't going to work for devices which
chip select inverted - for them we can't stop driving chip select at all
since they need it held high when idle.  There aren't that many such
devices and it'd loose us the PM which is rather awkward...  I guess
that's an incremental issue with a more invasive fix though.

--YmrIJOCZ+Tf3khLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqVSgACgkQJNaLcl1U
h9BFLQf/UOjz4Pr4wbrh+8Ck/3QreTFHhHy4MfusQ1TVF32f4jX9Nw4JQA/rFs4S
21ni5xP33d8D9cAiNUWJK+a7rYML9TyFbSsHJXso/CMk2OwuFNoUVIs/5NG/e643
Xv8oxmLSchOs7/Es9eBewWXyoyOx44UJZ6Xkm3nTTDFdLcIWO7JXfeB63cI7+Rpe
UrehMBhcaftJmv2P3VCwNCYqz4zkKwJa0f8kBSMN/ypYzA/Q0xCoKEJw5rYQW6CW
yE6AU3uob0Hgs9UT7xONC7GQ1KEnEfrPrSAtSs3ZFNSvV5vmaVubMZklllhGU3cZ
laUraJqW1OZlhresrLnzhF/z4SCtgA==
=1M3S
-----END PGP SIGNATURE-----

--YmrIJOCZ+Tf3khLq--
