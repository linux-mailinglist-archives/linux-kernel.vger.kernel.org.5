Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E375B359
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGTPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjGTPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012B134;
        Thu, 20 Jul 2023 08:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8082A61B5A;
        Thu, 20 Jul 2023 15:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2428CC433C9;
        Thu, 20 Jul 2023 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689867971;
        bh=a1PV8QZG/zqz27VM8jDoaoMF8mIYuM9C7Vx0332VoZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bC+3WEN9ZI0wkwc7yGRoolWyc3ChzR2nMBJZC/Cjqixxc4KDFlbDHxDaRXH9oAfFC
         dl+Kkb/qIwWjAMYhhh1iD3xZ+IrJCW6TL4sI9Eor6Is9ASrUIyx1UyhYUqsZgF3CbN
         cXAjFChx0VsNjBGHwKS1J/HZwmcYjSmVCwY/dvH/K96gDisIapllbW227oslHHCrAv
         bHDiYWA9m9WGb/m64LCLtTNFhKIT+T1Nh4bsOlNnSf0XIaMbfE/IacLkY4Y9dewRTU
         PDPKag7MFeYItwqXg84yXip/m2ZHwjZrTVZ3KNL30U/10TcVxpNiIgpmEF58GJUc0o
         p8zgiptEO42Lw==
Date:   Thu, 20 Jul 2023 16:46:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] spi: amlogic-spifc-a1: add support for
 max_speed_hz
Message-ID: <c118f69d-db32-4544-83d5-14de089d5b51@sirena.org.uk>
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
 <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
 <1jlefm6h8g.fsf@starbuckisacylon.baylibre.com>
 <5dc58681-d89f-8a8d-4da5-ccfa142fa15a@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rIgO7hjWxljNfj4v"
Content-Disposition: inline
In-Reply-To: <5dc58681-d89f-8a8d-4da5-ccfa142fa15a@sberdevices.ru>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rIgO7hjWxljNfj4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 06:41:11PM +0300, Martin Kurbanov wrote:
> On 11.07.2023 10:25, Jerome Brunet wrote:

> >> +	ret = clk_set_rate(spifc->clk, freq);
> >> +	if (ret)
> >> +		return ret;

> >> +	spifc->curr_speed_hz = freq;

> > There is no guarantee that clk_set_rate() has set the rate you have
> > requested, at least not precisely. You should call clk_get_rate() here.

> Are you referring to a situation where there is a change in the rate due
> to a request from another client, such as a sibling driver with the same
> parent clock?

The clock may simply not be able to generate exactly the rate you
requested, the rate will be rounded to some value that the clock can
actually generate.

--rIgO7hjWxljNfj4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5Vr4ACgkQJNaLcl1U
h9BanAf/TAsXNc+hfSP68yz4+OEr+7uK3DVU9ymeAUuAi/ksybVR0vSqYlZeDm0c
7Ilfl/jVxnXfF/NBA8tQdNu8qIX67fVhIWVxBLWA2p1/idx+cAa98gTeTr33Fg/5
dP/J/oqqWCmc7+lIOlyCQfyQelGqalUXRcWwkwj5aYo2gd1rez49E1/SCybQKqYR
UTJrHjRtKvkAoTPJ2/u4CK872i4PyDfcYqmClW6i/v3D9CF39nOo6/QJYx2fZuMn
napO9rczG5ViMNbt+37LYT1rsDAi9hk31doyxeFSp+MsvsFtDb5W5myMJbbbrEXc
6227n7xCLQ5H+LSYD56sTHyAr/H4IA==
=MtQJ
-----END PGP SIGNATURE-----

--rIgO7hjWxljNfj4v--
