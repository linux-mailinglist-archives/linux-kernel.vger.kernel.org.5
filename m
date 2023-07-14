Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49E77544E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGNWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGNWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B2273B;
        Fri, 14 Jul 2023 15:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01AE61DF2;
        Fri, 14 Jul 2023 22:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8CEC433C8;
        Fri, 14 Jul 2023 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689373510;
        bh=qDAdjbbNlaVXlCeDOKpbdViqCZhRVYY1UfiTYWHEDSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1H+uPy54DnRZBBx7hZqzSWgQ0m+FxHI0sY4IworOAqOfEuKNR4yl2sfkIhTEBhQm
         jfnysbAi/wF2tRZ8lUkZ4wprtGOqxpCTIMzOE60rTe8vshdGRW0Bx7sWBgfXF9wXaW
         ePOn4Nz0XLAb0iVns/pHs6b7EECFPF1Ho+MHz8h9w8o1m75RCTpJ00H4Y1G1ivsOn/
         MI7VeXco2DWgcrp2i8zNM4I1yBlpVvq1PjIPz8Ehc08Ql1VsiK6YZBFen1o6+t6eWb
         m1NiDRxTD0cmIDWR7fWsCxo/2VpLuul3Of4N+9o4pr76mM+LV3GWOlFGWlUxzAgDrL
         rNp6/VSuMjjyA==
Date:   Fri, 14 Jul 2023 23:25:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Message-ID: <0faa7534-cd76-4678-963f-4350dbd7178e@sirena.org.uk>
References: <20230711162751.7094-1-okan.sahin@analog.com>
 <20230711162751.7094-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r/nsbsijOa9vrkbY"
Content-Disposition: inline
In-Reply-To: <20230711162751.7094-3-okan.sahin@analog.com>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r/nsbsijOa9vrkbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 07:27:48PM +0300, Okan Sahin wrote:

> Regulator driver for  MAX77857/59 and MAX77831.
> The MAX77857 is a high-efficiency, high-performance
> buck-boost converter targeted for systems requiring
> a wide input voltage range (2.5V to 16V).

This looks good, I've queued it for CI (it'll probably be Monday before
I check that though).  One minor nit:

> +struct regmap_config max77857_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = max77857_volatile_reg,
> +};

Please prefer REGCACHE_MAPLE for new devices, it probably makes no
practical difference but it's more modern code and we might want to
retire _RBTREE at some point - please send an incremental patch to
update assuming this makes it through CI OK (I'd expect it to).

--r/nsbsijOa9vrkbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxy0AACgkQJNaLcl1U
h9BkKQf/VvNJMLFok80h1swgvk7vg2A25p0jdT8jKPzhESRN9SutzdIn7GDTSsbp
y+gWR770luIWEvmjAfV2bh5+ZLh0CfCl3W+IDMyUfxcOJqSjoHJnI90sRer2/SdA
vVroSLqKc/5asmlWwCzhfwyCvD4+s23ZWPBkW9uqQrgSeIU0gtKf97KlKNB1wHfJ
fL0Syz26UsSRWYjbfxWWHvLRImXNZwHRZe1DR/JPC1PoboO5DDhNp1QiWpmRQz87
Zqy6L3OBT8rmGFnfTJOldgSfB3NXFajirHGEvTutimEdnPUFjFxi131DQSyeJijO
HfGXJ1KOoZMmY9cCWgEfxEj0MkrcWg==
=fPwt
-----END PGP SIGNATURE-----

--r/nsbsijOa9vrkbY--
