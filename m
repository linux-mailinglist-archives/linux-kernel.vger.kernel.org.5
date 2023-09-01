Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A4578FD48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349455AbjIAMbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjIAMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:31:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DD10D4;
        Fri,  1 Sep 2023 05:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9654DCE2389;
        Fri,  1 Sep 2023 12:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376AC433CA;
        Fri,  1 Sep 2023 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693571458;
        bh=LccWUx7dWTdmftZs5xNwbt3DhF0oc/l/wJCxtvQ1bA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrCL3k6bT1B0OGj4V7PhfPPZ2UdLD93SJ85ELYzJLX67egguq+6UndzMqPuUuWcO6
         HNRQI/dMl9BAWowNhlrn6bZcANf6nta0dmU4pHIGn+ec8AvmvmSqO7fP3Stw26EKtq
         jhQ5w9/fOukiNZDPfhdanUnWd93hqIC4rIMtDRKUJFmZ4mk/9aAzDkiDZvxo7qO8dD
         s92huNbfgqYLpJqKyhSOy/ZZPZ5u7AuRf5NDjQkdbxVUBODizRPK0hcQMqFlGjbvq6
         qtOEOxNoxD/cCjUIfII43Eobuxr6SugSIWjbYjkdrpD6bRTu6cYYF+eGuIU84BpJIp
         wxMtowBWiYflQ==
Date:   Fri, 1 Sep 2023 13:30:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <ba9803e9-3aff-42b9-87ad-4e6d75d36d87@sirena.org.uk>
References: <20230901111548.12733-1-brgl@bgdev.pl>
 <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aRVg3yvkBIbYIC2W"
Content-Disposition: inline
In-Reply-To: <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
X-Cookie: Dealer prices may vary.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aRVg3yvkBIbYIC2W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 02:15:39PM +0200, Linus Walleij wrote:
> On Fri, Sep 1, 2023 at 1:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> > +       struct gpiod_lookup_table *lookup __free(kfree) =3D NULL;

> Whoa!
> This is really neat.
> As noted, it will confuse static checkers at no end, but they just have
> to adopt. (CC to Dan C if he now runs into this.)

It also doesn't look amazing for humans, it's very not C like...

--aRVg3yvkBIbYIC2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTx2XsACgkQJNaLcl1U
h9AQJAf/YLKDGyQrBl9ERMjPBP4tkmHABfNt31zSpEPCIs+RXikFEb96jh/70llV
2PaiSl0Cf3OZedYetb90HM/aFjbtE/ilcdi+9WJYrnPnYmolrxlSWTFIKkUoTbbZ
gTmTEoa3RVM7nZgg0RvtQFjDsmMOfZ2Nx10PalR0TaiYoNLz3O77h5559zyYIcVY
9VFyVrSeWskb5S+pv+HVl1IbF05WNhBiuT0MDxc9zcMPP4SST0gDx4iee/2RED+v
F+R+pg/DwJ/7vssymkEhmlZXNch2I3Rt70fOkUzMPx8qeCfK5AfLbnLHL/R2Fgn1
AgGRppXXUacwqlYsUm0ju5fYWkjOzw==
=xrpJ
-----END PGP SIGNATURE-----

--aRVg3yvkBIbYIC2W--
