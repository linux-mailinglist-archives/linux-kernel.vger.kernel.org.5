Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2945758359
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjGRRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjGRRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25497CC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE68761689
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FE7C433C8;
        Tue, 18 Jul 2023 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689700695;
        bh=qllRDtRzTypdZztvcnHwPcbsEQrFc/2Bk+u5pdDyOOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhEwSrVAhaV4JxPjCqoHkgK65jNKKiFjp9EvfPDQDnSLS4MgACggBCn0r42wwCInN
         yRwAf9szLO8IkvkKStI83NQrK05PNXalZqkcuE+j3gYiRjX+W53qhSc6r2xqif2Gds
         4AnyH6/Q2yWN49dGzC496d9FthaHk8xPwBQX8HYHCJ5AU/Rv5XFF2bcWrLf6MikBJp
         dOcf+p0sP4UrSvWi9iKVX0KVcu1U/ODblcE9VXrtPfAQBPbMgyLP7dPTmpJFmNjUnK
         h0h3imKK++hIIcXs+XzllMfBdsECIVPOz2piukDIBCepEceKZonIyh86kYBvI/Tfx5
         kPrhO7slgTCEg==
Date:   Tue, 18 Jul 2023 18:18:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: maple: Clear async flag when doing a maple tree
 cache sync
Message-ID: <563cf3d2-08bd-4768-950a-02e89fa6b6c8@sirena.org.uk>
References: <20230718171346.1002994-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jX0zQrUA1ZrYLM9B"
Content-Disposition: inline
In-Reply-To: <20230718171346.1002994-1-ckeepax@opensource.cirrus.com>
X-Cookie: Nothing happens.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jX0zQrUA1ZrYLM9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 06:13:46PM +0100, Charles Keepax wrote:
> The normal regcache_sync function sets the async flag on the register
> map. The maple tree sync code uses a temporary buffer, which is freed
> after the register is written, however, as the async flag is set the
> buffer might not be used until after it is freed. Fix this by clearing
> the async flag in the maple tree sync function.

It would be better to push this down into the rbtree code which is what
really wants this.

--jX0zQrUA1ZrYLM9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2yVEACgkQJNaLcl1U
h9CrLQf/e18FV13uCRRk0ryECfTcb8N093348JVmoJABfUmDeV5wJ1dKE0Q768WH
4hc0TN7GtZcEs7tUewjrvVgu1DiU70drj/X2o2EYl55CltHYDNVgeVKjGJTD9VoK
j8SOklqawxR3CdfeOxkglEuPlaoDeeko3KXtKeQ/DzAatjvQFQM7V0DZFjqufTYA
7OUTVqe9A5ttLx0kn1SX50VeXGhvkZwEEhgKH8elBP6qz5Q8DO1B4YkRekwL/IKX
ccqTP9luFBLOj5EVL9wh6cNyM/9cch/+lF/UVCgoRS3nbZAvUbxQiAKdgiKOrywG
CPKa6dhBKpkHrKPZxbVnaJMbS5ZvIQ==
=e8u1
-----END PGP SIGNATURE-----

--jX0zQrUA1ZrYLM9B--
