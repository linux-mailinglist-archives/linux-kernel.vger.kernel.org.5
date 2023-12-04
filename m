Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28ED803E35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjLDTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:16:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92253B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:17:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA600C433C8;
        Mon,  4 Dec 2023 19:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701717422;
        bh=KpfOnvTL3knkuMpE6adDfUI+NY+fIk8AM9x5Gak3Hco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfbrSAecxVkKRtOr/497Qus9viOkx7eEyf+wNjxCRI00UiQZCO/tatsxo0Uk+Hkwh
         eDkWTu8YKxsITFB/T1GKgMUDeJGEy8xKwX6nIj/+c26Z9GPRuSlgikMF1lsa+jzWI4
         Ck/h/PBKOkbmhbespSrIZdvb6qRoMFDE4JPFAKzbYojvsiqc8tDgXAeqSJqhNFAvHq
         0TC5naYn7SssteJLA96q4afb8sEsLoNbbspHrIt6CsFR1Dwsd1WX0VV6q+DL5XNP6h
         wEw9Q5T/0jamtg5E/Nk0gqNr5rlDzfHCqioY8YnnnkbD2S7izVrjrwkHRn11uGE4Em
         tlpTyjWdIfazg==
Date:   Mon, 4 Dec 2023 19:16:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <66946666-eb33-431d-9870-7046c39ffb4e@sirena.org.uk>
References: <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
 <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
 <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
 <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
 <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
 <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
 <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
 <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
 <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
 <20231204135922.0355f030945920086d21b8b6@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xVSy1rfpuORusGPL"
Content-Disposition: inline
In-Reply-To: <20231204135922.0355f030945920086d21b8b6@hugovil.com>
X-Cookie: For office use only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xVSy1rfpuORusGPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 01:59:22PM -0500, Hugo Villeneuve wrote:

> Based on tas2770.c, I am assuming I could redefine the code to look
> like this:

> /* SC16IS7XX register definitions */
> #define SC16IS7XX_REG(page, reg)        ((page * 128) + reg)
>=20
> #define SC16IS7XX_RHR_REG	SC16IS7XX_REG(0, 0x00) /* RX FIFO */
> #define SC16IS7XX_THR_REG	SC16IS7XX_REG(0, 0x00) /* TX FIFO */
> #define SC16IS7XX_IER_REG	SC16IS7XX_REG(0, 0x01) /* Interrupt enable */
> #define SC16IS7XX_IIR_REG	SC16IS7XX_REG(0, 0x02) /* Interrupt Identificat=
ion (read) */
> #define SC16IS7XX_FCR_REG	SC16IS7XX_REG(0, 0x02) /* FIFO control (write) =
*/
> #define SC16IS7XX_MCR_REG	SC16IS7XX_REG(0, 0x04) /* Modem Control */
> #define SC16IS7XX_LSR_REG	SC16IS7XX_REG(0, 0x05) /* Line Status */
> #define SC16IS7XX_MSR_REG	SC16IS7XX_REG(0, 0x06) /* Modem Status */
> #define SC16IS7XX_SPR_REG	SC16IS7XX_REG(0, 0x07) /* Scratch Pad */
> ...
> #define SC16IS7XX_EFR_REG	SC16IS7XX_REG(1, 0x02) /* Enhanced Features */
> #define SC16IS7XX_XON1_REG	SC16IS7XX_REG(1, 0x04) /* Xon1 word */
> #define SC16IS7XX_XON2_REG	SC16IS7XX_REG(1, 0x05) /* Xon2 word */
> #define SC16IS7XX_XOFF1_REG	SC16IS7XX_REG(1, 0x06) /* Xoff1 word */
> #define SC16IS7XX_XOFF2_REG	SC16IS7XX_REG(1, 0x07) /* Xoff2 word */

> static const struct regmap_range_cfg sc16is7xx_regmap_ranges[] =3D {
> 	{
> 		.range_min =3D 0,
> 		.range_max =3D 1 * 128,
> 		.selector_reg =3D SC16IS7XX_LCR_REG,
> 		.selector_mask =3D 0xff,
> 		.selector_shift =3D 0,
> 		.window_start =3D 0,
> 		.window_len =3D 128,
> 	},
> };

That looks plausible - I'd tend to make the range just completely
non-physical (eg, start at some unrepresentable value) so there's no
possible ambiguity with a physical address.  I'm also not clear why
you've made the window be 128 registers wide if it's just this range
=66rom 2-7 that gets switched around, I'd do something more like

#define SC16IS7XX_RANGE_BASE 0x1000
#define SC16IS7XX_WINDOW_LEN 6
#define SC16IS7XX_PAGED_REG(page, reg) \
	(SC16IS7XX_RANGE_BASE + (SC16IS7XX_WINDOW_LEN * page) + reg)

	.range_min =3D SC16IS7XX_RANGE_BASE,
	.range_max =3D SC16IS7XX_RANGE_BASE + (2 * SC16IS7XX_WINDOW_LEN),
	.window_start =3D 2,
	.window_len =3D SC16IS7XX_WINDOW_LEN,

You could apply a - 2 offset to reg as well to make the defines for the
registers clearer.  The above means that any untranslated register you
see in I/O traces should be immediately obvious (and more likely to trip
up error handling and tell you about it if it goes wrong) and hopefully
also makes it easier to reason about what's going on.

> But here, selecting the proper "page" is not obvious,
> because to select page 1, we need to write a fixed value of 0xBF to
> the LCR register.

> And when selecting page 0, we must write the previous value that was
> in LCR _before_ we made the switch to page 1...

> How do we do that?

That's one reason why having the range cover all the registers gets
confusing.  That said the code does have special casing for a selector
register in the middle of the range since there were some devices that
just put the paging register in the middle of the range it controls for
some innovative region, the core will notice that this is a selector
register and not do any paging for that register.

--xVSy1rfpuORusGPL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVuJagACgkQJNaLcl1U
h9BNawf+P7Lra21foVyX6Ny6bWIKe7vXq/LDIa80vV7X7bX9etQJaNNIjOK8te3k
B3qNX/yHvnF2FXOQXDqKNGXZrhAtkl6kj6BJc9uoiob4RizUdleOoFJqJ7Twq0Em
D36+VM2Fhs/JGRMj28BVLUCk65toBTLBPS7zg7KVE0ZGwMMOIKPYgDiyCPfj6EmE
g0VW2RMI9H9yzFOk6pt5TsOcFAq1P68UiyIrZv+z3louzlynLtJbvNsENJp+xPwS
laYPS9Y6SvH9OB25C4kiTHJjzyDY3cAAMQXVMPZQ6XY8S+ko3kCbGrKiSYfx0VCa
8OHQO4ZM55O2rurwulkc8YAGM9+4QA==
=b/zt
-----END PGP SIGNATURE-----

--xVSy1rfpuORusGPL--
