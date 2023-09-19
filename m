Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9327A62D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjISM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjISM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:26:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7769DF3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:26:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82091C433C7;
        Tue, 19 Sep 2023 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695126395;
        bh=U9pqCXoYKmZIxNp4ZZfVXcfKIkNgbZXV1xvjTr2DFE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ECC/8mJECW5aRwAQxAierixo6cuXLcZY1jNtJp6QbQHfL9dyYX8ETWjYNFUXwiZj9
         DR50g46oPPnN6LrKD9z8xnt45VY6Tvm5Lwt1LQnAcGY/axO9jbCS3N+HkqIiWZG96W
         Dy18dLygzfAHOZQKydVO3W4ivV5ZzppMbzbISp7ZJUZG3h/vdhks5m1KsuOeYKtCxa
         EwHc1LdqvmHT+6FXuPQvdwAHtHNLOzc6zp8s5aq6pGed1ZXYyeyv6xwej/ZpzM5izJ
         Ad0jToNH3ft4xlUjEClqJioZdzcWa8IW8NAZBChVt4EQO4Gj5dxnIBOembLbdZuKWE
         dorqB1hxPFZmA==
Date:   Tue, 19 Sep 2023 13:26:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] regulator: mt6358: return error for get/set mode op on
 linear range LDO
Message-ID: <d81640db-010f-49a9-8485-4442ba857a94@sirena.org.uk>
References: <20230919083647.3909889-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QwwjSc6QhijmvlPO"
Content-Disposition: inline
In-Reply-To: <20230919083647.3909889-1-wenst@chromium.org>
X-Cookie: You buttered your bread, now lie in it.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QwwjSc6QhijmvlPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 04:36:46PM +0800, Chen-Yu Tsai wrote:
> The buck and linear range (VSRAM_*) regulators share one set of ops.
> This set includes support for get/set mode. However this only makes
> sense for buck regulators, not LDOs. The callbacks were not checking
> whether the register offset and/or mask for mode setting was valid or
> not. This ends up making the kernel report "normal" mode operation for
> the LDOs.
>=20
> Instead, make the callbacks return -EINVAL if the mode register mask is
> not set, signaling that it is not supported.

It would be better to use separate ops for the two cases, that way the
core knows that the operations aren't supported and can handle things
better.

--QwwjSc6QhijmvlPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUJk3UACgkQJNaLcl1U
h9Dglgf9Gt6tPZBfcx38Whb5fZ2laULepfxlbfnu+Inb7vXr3cn/rfHzZKy/hIjY
zKQnkZOT1OLcw7TFaJ7ogJoHbgZr/2uMHCUu9Omfyx9KPW2GYmwP1MWiQTPFYq0g
n71QZ+7jsXXxtO4Vqqh1JFNLbfUKrWIJYyBWA2KSVfASjJQSmUkyXFdEsgJKU08x
gjlKwIROF0VVrGiegc6cN6SWYSMYLb8n5CIvm9OpqXWoOqDNaARrFddvilOOa6rM
VSIBzIfILarJTnM81Do1p4YjVbOaHKjNN1H8ZIb2ww2QHXrqMEmrByBnD65va6VT
GI0gzH+oo2RLTX5vRuIvFFcdDmVPTA==
=Jj59
-----END PGP SIGNATURE-----

--QwwjSc6QhijmvlPO--
