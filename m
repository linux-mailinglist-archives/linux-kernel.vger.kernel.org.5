Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B325803A60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbjLDQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLDQf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:35:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C724B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:35:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AB6C433C8;
        Mon,  4 Dec 2023 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707735;
        bh=RQ6CIRjLqjiravdC8aSrTQktYRh4h2fGEz68FsNnRAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMAZb9cn05378BMue3R1ngB4/bH0ewXlbJmcLa37ociBcVm1LnlzToiVaPGxLXtMS
         hGYehjHUYLzUd54/a2zcQhQ3wLWdpaWwdQAEpVC+dr2O1rcjm9+4+4F9qOaf5bbvx2
         dOKpnLO1x+oXxuwXOsMRUZWnRGO8/juDxhH1zjk8yaOandP6rLw+XggSAHGyJqvFTx
         r2tp04BJPQBNBGjOCz7FzFjhqDJxhfQ4bNi4jg/jUhRVX/fV6ZZZlCA7kJvDHN0x0L
         KMWZhwFalVktw2OTkZfki5sC1y08M2PeliXVzdQUP3YK/a1kNB5C9uPImepsaan2xb
         Jva+RPGf1PDZA==
Date:   Mon, 4 Dec 2023 16:35:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
 <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
 <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
 <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
 <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
 <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hBOhkK5rJrdmtyTi"
Content-Disposition: inline
In-Reply-To: <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
X-Cookie: For office use only.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hBOhkK5rJrdmtyTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 11:29:05AM -0500, Hugo Villeneuve wrote:

> Do you have an example of a driver which is using regmap ranges like it
> should be done in this driver, that is using the exact same address for
> two or more registers? I found an example, but it doesn't seem
> applicable to the sc16is7xx driver because the two registers do not
> share a common address, for example they have addresses like 0x01 and
> 0x81, even though with the proper page selection, they finally map to
> address 0x01.

I don't understand what you mean here - you say that the addresses both
have addresses 0x1 and 0x81 but map to address 0x1.  What does the 0x81
refer to?  The comments in the driver seemed to indicate that there was
a single address which mapped to multiple underlying registers...

Searching for struct regmap_range_cfg should show a lot of users in
mainline.

--hBOhkK5rJrdmtyTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVt/9EACgkQJNaLcl1U
h9DsWQf/fKCCXlK99AdnqHl9yI2zD3DO1t8WYvVvqLYrpiGXqRgwf8NZCHZjwAqj
RHOtw7X7p3tLm2/aPT8fKg39ig/W0qvj5aXrjCth5Z60PXZArqiLMAjmsS4n+XTY
eKjOwmrkrR69YqsGWaYaY0MkmWiKJyRNZVR60xfQ7N1ddA3aObVPpHFgbQZ8knWq
S7tSmdIZH2bmA7P+jngQgvxW8GgHIB7MfAsX4t0dyCp5XG3fFDc+LfbmEset4lVo
2EXGFLKWq7Dc+M3GdzxYimDTkxUo77FoUn75gQo8bXpAKC4yxRuvh87BoaFLTIwO
GBg4kiNeI+rCZHcSQQt8ZWBXeVIqWA==
=XED8
-----END PGP SIGNATURE-----

--hBOhkK5rJrdmtyTi--
