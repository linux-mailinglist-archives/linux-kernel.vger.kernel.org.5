Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D89756B46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGQSI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDB58E;
        Mon, 17 Jul 2023 11:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97AC3611BF;
        Mon, 17 Jul 2023 18:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675CDC433C7;
        Mon, 17 Jul 2023 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617306;
        bh=UT9Gp/tMRg3RNCizwduBCQGhjAx6Wg7j44XwEdN/o8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsotMPwEhQEWEX27c6AhTe2UvFJoUAcn//oytO90CB57yV/IcO3YRCWBQapnJEvCi
         7r8lGqiays1uhvk0OZSxSzkLcUuoLDzQvrMo5MsveGHQlP4mv3jhmles1X03HtVB55
         CvJCWeWycTSx9tQzrvlFaHIw9naCXHEReXmxWy67rt6bYujcO1xqT6alBl0upqozrY
         hLj1qTHyPiUs/RbkJnv50di6/hhtBi+0ENtf9rl18DDtbc2tdSWHfKl/VXkbgi+rkZ
         p0+UK5wmjGNukuqDt5Ject6D+8pEa5kc3ci9NyQFBfe6WGZgtVstxU27X7La1k0R27
         5vkr72xSCFjdQ==
Date:   Mon, 17 Jul 2023 19:08:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/ptrace: Fix an error handling path in
 sve_set_common()
Message-ID: <3f78a04c-bafe-4def-8eeb-734589fdaaa0@sirena.org.uk>
References: <aa61301ed2dfd079b74b37f7fede5f179ac3087a.1689616473.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NPez/l1+KHinqP20"
Content-Disposition: inline
In-Reply-To: <aa61301ed2dfd079b74b37f7fede5f179ac3087a.1689616473.git.christophe.jaillet@wanadoo.fr>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NPez/l1+KHinqP20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2023 at 07:55:05PM +0200, Christophe JAILLET wrote:
> All error handling paths go to 'out', except this one. Be consistent and
> also branch to 'out' here.

This looks like a reasonable cleanup.

Reviewed-by: Mark Brown <broonie@kernel.org>

> Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")

>  		default:
>  			WARN_ON_ONCE(1);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto out;
>  		}

It's not exactly a fix though (probably not worth backporting for
example, which tends to get keyed off the fixes tag) since something's
incredibly confused if this code path ever gets executed, we're setting
an unknown SVE vector type hence the WARN_ON() there.

--NPez/l1+KHinqP20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1g5QACgkQJNaLcl1U
h9A8/Af+JXJu75jwI/gRy39NDWPw+FkhjHQRmj8kzHLuDTOiij8wPld/G/DbE7Hi
xcZTeLirHTQRX38WBHssHbpyMh8PCsr9UPtmAGNY74WARmvFlNEli0FExVge0DIj
fPeJ5ljgrq7u9DDF+p01HXAFogOdh4fx5sXRbnJJUdDe9ltAiE2O2guCAkro/p0K
Da5c0LsGYzMqupJXernIg9rA8E/EVDKoFLweq3CHliRRlsDsSKQAdSffK1r50rW6
r1brrHk7vtOIzlxzRq8AEIOGigxtj+tSwVyCjxsfcarq0JZRbm/CmnQis2dbX6TZ
asCtZu1AqqePGzNtecVUS4FG/m6A7g==
=i1qh
-----END PGP SIGNATURE-----

--NPez/l1+KHinqP20--
