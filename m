Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C05787AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbjHXVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbjHXVxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C871C1BD4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67C96638A7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6F7C433C7;
        Thu, 24 Aug 2023 21:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692914018;
        bh=tkWHeq6k5D3EQ6/qO1M1boc34SY9YrJif+Kaz8/2ZMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEHMY23WWmJEx7oOxgVJJjj+5yWFxJiK3V+1FXoWFDpVF+FuwzROgcqxJndJF8b98
         w3fyYLMwzyxiCm12+DXiAnwSNusN+T5AFYM+Eoh13KpvQ424Cq6cYTYnTD5V+wXIFt
         ztUmAmZdmMzTqjBijsBVLd7fyp922Eu2Z83DukO2cKOZjFXcvLaNtWQB5sWXkAQCU+
         h+POOP/RSAkC+PA6fk6YTFuP8GuHPOjEl5BZPHtfjQHHtRKOwhdW6OkNZv+bj5Telz
         YMJI5bUcyhvUUK9CTX17JDBRfS8ursoQxSVZeiicgL7mUIT4fDQB/5z7/coZwYlUub
         fPBAK+eHpaARA==
Date:   Thu, 24 Aug 2023 22:53:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: es8316: Enable support for MCLK div by 2
Message-ID: <ZOfRXjuSTxSV89SC@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-3-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nohjNvg5OLaKpTCH"
Content-Disposition: inline
In-Reply-To: <20230824210135.19303-3-posteuca@mutex.one>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nohjNvg5OLaKpTCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2023 at 12:01:33AM +0300, Marian Postevca wrote:

> +/* In at least one AMD laptop the internal timing of the codec goes off
> + * if the MCLK (48Mhz) is not divided by 2. So we will divide all MCLK
> + * frequencies above and equal to 48MHz by 2.
> + */
> +#define MAX_SUPPORTED_MCLK_FREQ 48000000

Given that the datasheet quotes a maximum MCLK of 51.2MHz I suspect that
this is far too high and that performance is degrading well before this
point, it sounds like it just so happens that you noticed issues on a
machine with this MCLK rather than that's based on the spec.  I would
instead suggest applying the MCLK divider in any case where we can do so
and still generate suitable clocking for the rest of the system, or at
least hit 256fs (the datasheet quotes 256/384fs on the front page which
suggests it's targetting 256fs, that'd be a fairly normal number, and
there's mention of 12/24MHz USB clocks being directly usable).  Doing
this should either make no odds or result in better performance.

It's probably also more power efficient to use a lower MCLK, though most
likely the difference is marginal.  The earlier in the clock tree the
divider is applied the lower more of the chip is clocked and all other
things being equal a lower clock usually means lower power.

--nohjNvg5OLaKpTCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTn0V4ACgkQJNaLcl1U
h9AwVAf+NNSivaoevGjiOze1TmfH7OzLeB1PW0sdIwpa7eQxGroC1UQleHHI5+QL
wkFNWQ6to4WpwL+M2X/v7VIFN3rc5zHjF8fKJbP+22gEs8+FtReeE6dDogBFI/6u
H4A8KYh0Qjwhnmlcz7GZaC1rmbpnbHY4T1no1RPlCQmR473yfWBpf7Eo3RapR/4a
VmG+rkIrE17qAlcyj2o+eW89o9YqPR/FHhKauqbqzg7DMQusNk3VkhjhM6qmBbR6
/mbFCk36d6Jt9VKC8mVdwbCPLJdj96EHpKPHzG5sWPbxRbfcHOGRQPt7n5YlxXmr
uMu9+dBH/nte3EjXrpRi3OM9qUbVJw==
=6SaS
-----END PGP SIGNATURE-----

--nohjNvg5OLaKpTCH--
