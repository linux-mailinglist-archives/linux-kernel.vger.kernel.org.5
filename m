Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242D175B206
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGTPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjGTPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFE1BC8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9829B6192B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57E7C433C7;
        Thu, 20 Jul 2023 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689865666;
        bh=D+hQXPrMshA/U5wjFi6rAJMpGP2W+4CxhxCtnEiE/xU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urpHe9wPUhebkKoCh52Bc5WGa9pHp4l1BPOLU0+koPQmflsU05QKYyAw2xzLoj/Xc
         Vjb88o47cc+KkFNw+RfDSHV/FvIxg1WG3ge4nHZf5HN0Nictc9MZNdLddWCFkWT+FD
         nb7yg/KTsVZOV/FUQxRlARe10Woda7SnJzfTXM3Nf450up1SPeMYYh81eFHpm1Lnb8
         6gXLirrJtaOug9We/3C1i1VSSoAmzdxpAoNNvzpZCizKmxudhpmQoTZBpZFNGrdoZy
         A4DUzJAj1Ni/xG1qHMdwJYIuIyt9uMY0x8RTU3g2/6h4NVHaN0EEwrFRahIRRV6rIC
         56tsaFDC44yjw==
Date:   Thu, 20 Jul 2023 16:07:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Message-ID: <12e6144c-0d24-4556-beef-d754273992e4@sirena.org.uk>
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
 <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
 <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EGunCXXrCK9bgf3e"
Content-Disposition: inline
In-Reply-To: <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EGunCXXrCK9bgf3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 08:03:13AM -0700, Guenter Roeck wrote:
> On 7/20/23 07:31, Mark Brown wrote:

> > They're both independently fine, but I wouldn't expect anything that's
> > running in atomic context to be actually using dynamic allocations.

> Which one do you prefer ? As I mentioned in my second patch, there are
> two drivers which use fast_io together with REGCACHE_RBTREE and thus
> are likely affected by this problem. Dan's solution would cover that,
> while my current RFC patch would likely cause those drivers to fail.
> Plus, of course, they could get stuck if they actually end up trying to
> sleep while allocating memory.

Like I say I don't think it's an either/or - we can do both
independently, they both make sense standalone and don't conflict with
each other.

--EGunCXXrCK9bgf3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5TbwACgkQJNaLcl1U
h9CJ6wf/cNHtI4TfyujAWBqtEZ4NxSxM/02oA6xd/U1ecrlyaR7eM5dPCef5Va1l
hpGmdQVT2zEe911685P4shWZrpKy/tFLqA05XN8/pkE/3y6grgP7wTbacbSGQuoG
T8WezcYrmRD3XXRlqA6TTM4OSRSzApgh88gM1SoD8K9YXHkII1SnkNofVJ/sXVUq
qI+AAqR1uw1eRE4QhmXHtdQgvRkrYXsLaKAGQLQxiFDVVSF3AL2igBDKmOS8/CC4
yOSg/NiCdz14cUA2t455lMLE7N4gBWKdCToBukEa/Y77a/8eNRWCCY6GGwl2cUWg
YIgB0SQJC8IJMpXHQHcKpu8wI0hUtA==
=XydL
-----END PGP SIGNATURE-----

--EGunCXXrCK9bgf3e--
