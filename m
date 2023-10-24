Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8169D7D4603
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjJXDeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJXDeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:34:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBC90;
        Mon, 23 Oct 2023 20:34:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C5BC433C7;
        Tue, 24 Oct 2023 03:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698118456;
        bh=AUfGK4LRDTP1ffobLLgoDerJIC0MFT8bIHsXjO28BxI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r7OVIIu9siFAC7IXMJuDD4peZpTdWBfveK3RFkdN7IuTFtZgCKswhbdm7bl0ZQmfz
         9cm5+/8XPvC54PytUqB6eWS3pqgdPhvpiKTTlR0eN+9CXijSSQiR64eneyYB+IMqs/
         70OtqUeLTjsGK5to3bp1MLpT1wo4Wp2inslcej4RGFtWqdIRenFdP5ZMzXRyKCyFeC
         pgVfCVfl/xYxvyJGI/nM6cuEWI4O5FO1jdfe2lwMJHsT5weIW/PYvdpiqGA7XFjvNz
         XDRDOzSN9cUOR6B5o8AoG+PUDT5C9K2jX7v/cb8BmcobzlsBp/q2ZLfJ/3w29qX0HD
         D904LYR5RdYIg==
Message-ID: <a9756c11ea3f111d45e85e0f3928bdd8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230630183835.464216-1-sebastian.reichel@collabora.com>
References: <20230630183835.464216-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3 1/1] clk: divider: Fix divisor masking on 64 bit platforms
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
To:     David Laight <David.Laight@ACULAB.COM>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon, 23 Oct 2023 20:34:12 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sebastian Reichel (2023-06-30 11:38:35)
> The clock framework handles clock rates as "unsigned long", so u32 on
> 32-bit architectures and u64 on 64-bit architectures.
>=20
> The current code casts the dividend to u64 on 32-bit to avoid a
> potential overflow. For example DIV_ROUND_UP(3000000000, 1500000000)
> =3D (3.0G + 1.5G - 1) / 1.5G =3D =3D OVERFLOW / 1.5G, which has been
> introduced in commit 9556f9dad8f5 ("clk: divider: handle integer overflow
> when dividing large clock rates").
>=20
> On 64 bit platforms this masks the divisor, so that only the lower
> 32 bit are used. Thus requesting a frequency >=3D 4.3GHz results
> in incorrect values. For example requesting 4300000000 (4.3 GHz) will
> effectively request ca. 5 MHz. Requesting clk_round_rate(clk, ULONG_MAX)
> is a bit of a special case, since that still returns correct values as
> long as the parent clock is below 8.5 GHz.
>=20
> Fix this by introducing a new helper, which avoids the overflow
> by using a modulo operation instead of math tricks. This avoids
> any requirements on the arguments (except that divisor should not
> be 0 obviously).
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Sorry this one fell off my review list :(

> Changes since PATCHv2:
>  * https://lore.kernel.org/all/20230526171057.66876-1-sebastian.reichel@c=
ollabora.com/
>  * Drop first patch (applied)
>  * Update second patch to use newly introduced DIV_ROUND_UP_NO_OVERFLOW
>=20
> Changes since PATCHv1:
>  * https://lore.kernel.org/linux-clk/20230519190522.194729-1-sebastian.re=
ichel@collabora.com/
>  * Add Christopher Obbard's Reviewed-by to the first patch
>  * Update the second patch to use DIV_ROUND_UP instead of DIV64_U64_ROUND=
_UP
> ---
>  drivers/clk/clk-divider.c |  6 +++---
>  include/linux/math.h      | 11 +++++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index a2c2b5203b0a..94b4fb66a60f 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *=
table,
>                          unsigned long parent_rate, unsigned long rate,
>                          unsigned long flags)
>  {
> -       int div =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +       int div =3D DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
> =20
>         if (flags & CLK_DIVIDER_POWER_OF_TWO)
>                 div =3D __roundup_pow_of_two(div);
> @@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_ta=
ble *table,
>         int up, down;
>         unsigned long up_rate, down_rate;
> =20
> -       up =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +       up =3D DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
>         down =3D parent_rate / rate;
> =20
>         if (flags & CLK_DIVIDER_POWER_OF_TWO) {
> @@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long=
 parent_rate,
>  {
>         unsigned int div, value;
> =20
> -       div =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +       div =3D DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
> =20
>         if (!_is_valid_div(table, div, flags))
>                 return -EINVAL;
> diff --git a/include/linux/math.h b/include/linux/math.h
> index 2d388650c556..cf14d436fc2e 100644
> --- a/include/linux/math.h
> +++ b/include/linux/math.h
> @@ -36,6 +36,17 @@
> =20
>  #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
> =20
> +/**
> + * DIV_ROUND_UP_NO_OVERFLOW - divide two numbers and always round up
> + * @n: numerator / dividend
> + * @d: denominator / divisor
> + *
> + * This functions does the same as DIV_ROUND_UP, but internally uses a
> + * division and a modulo operation instead of math tricks. This way it
> + * avoids overflowing when handling big numbers.
> + */
> +#define DIV_ROUND_UP_NO_OVERFLOW(n, d) (((n) / (d)) + !!((n) % (d)))

Can you get someone to review/ack this macro? Maybe Andy?

> +
>  #define DIV_ROUND_DOWN_ULL(ll, d) \
>         ({ unsigned long long _tmp =3D (ll); do_div(_tmp, d); _tmp; })
>
