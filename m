Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCE76BB8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjHARn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHARnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:43:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEE10C1;
        Tue,  1 Aug 2023 10:43:51 -0700 (PDT)
Received: from mercury (dyndsl-091-248-215-079.ewe-ip-backbone.de [91.248.215.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B97486606EEE;
        Tue,  1 Aug 2023 18:43:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690911829;
        bh=zQkjvls0eCWFEOaz7N2t8qQp4hxcRcsCmrhhYhJkbrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+UPqpQKatxRJtS5p2Xm6IQcaz0PQGHFwpUkmzvBqiu0KiohYJVbH2ODd62EG2aVv
         x5OGBED6RglxAjCVfgmrjmyt7gK6kvuGTzlj/AyoAX2sEPkxbd0+FWESmXkfIfg0ET
         iivA9qI1kmpsV2QukFN6BTxpXybVlFmLmQPTevUrjpjyc2NNQfWpFZHKW76y9njFkF
         WDPABort4GPa675SAInEl2WVwT3k7mcuipds2uVjmu4eITQIH1t9l/YI8mqoUzWvHU
         NDWUSEgrv639mNGloX1van5l29O+ZBszsXYx+Z46MsxOSa2LgIaGLkkmbPpbjGU9NN
         u/YuXxoYkJkmg==
Received: by mercury (Postfix, from userid 1000)
        id 4FBE31062BC5; Tue,  1 Aug 2023 19:43:47 +0200 (CEST)
Date:   Tue, 1 Aug 2023 19:43:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject: Re: [PATCH v2 1/3] clk: rockchip: add support for gate link
Message-ID: <20230801174347.whzhqwzh7vdjqeap@mercury.elektranox.org>
References: <20230801074357.10770-1-zhangqing@rock-chips.com>
 <20230801074357.10770-2-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhivbfvldrdlg66n"
Content-Disposition: inline
In-Reply-To: <20230801074357.10770-2-zhangqing@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhivbfvldrdlg66n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2023 at 03:43:55PM +0800, Elaine Zhang wrote:
> Recent Rockchip SoCs have a new hardware block called Native Interface
> Unit (NIU), which gates clocks to devices behind them. These effectively
> need two parent clocks.
> Use GATE_LINK to handle this.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

This looks better than the current upstream solution of just
marking all linked clocks as criticial. I do have a few comments,
though.

>  drivers/clk/rockchip/Makefile        |   1 +
>  drivers/clk/rockchip/clk-gate-link.c | 189 +++++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.c           |   7 +
>  drivers/clk/rockchip/clk.h           |  22 ++++
>  4 files changed, 219 insertions(+)
>  create mode 100644 drivers/clk/rockchip/clk-gate-link.c
>=20
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index 36894f6a7022..87cc39d54f72 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -13,6 +13,7 @@ clk-rockchip-y +=3D clk-inverter.o
>  clk-rockchip-y +=3D clk-mmc-phase.o
>  clk-rockchip-y +=3D clk-muxgrf.o
>  clk-rockchip-y +=3D clk-ddr.o
> +clk-rockchip-y +=3D clk-gate-link.o
>  clk-rockchip-$(CONFIG_RESET_CONTROLLER) +=3D softrst.o
> =20
>  obj-$(CONFIG_CLK_PX30)          +=3D clk-px30.o
> diff --git a/drivers/clk/rockchip/clk-gate-link.c b/drivers/clk/rockchip/=
clk-gate-link.c
> new file mode 100644
> index 000000000000..06d25f00ec0c
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-gate-link.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Fuzhou Rockchip Electronics Co., Ltd
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include "clk.h"
> +
> +/**
> + * struct clk_gate_link - gating link clock
> + *
> + * @hw:		handle between common and hardware-specific interfaces
> + * @reg:	register controlling gate
> + * @bit_idx:	single bit controlling gate
> + * @flags:	hardware-specific flags
> + * @lock:	register lock
> + * @link:	links clk
> + */
> +struct clk_gate_link {
> +	struct clk_hw hw;
> +	void __iomem	*reg;
> +	u8		bit_idx;
> +	u8		flags;
> +	spinlock_t	*lock;
> +	struct clk	*link;
> +};
> +
> +#define to_clk_gate_link(_hw) container_of(_hw, struct clk_gate_link, hw)
> +
> +static inline u32 clk_gate_readl(struct clk_gate_link *gate)
> +{
> +	if (gate->flags & CLK_GATE_BIG_ENDIAN)
> +		return ioread32be(gate->reg);
> +
> +	return readl(gate->reg);
> +}
> +
> +static inline void clk_gate_writel(struct clk_gate_link *gate, u32 val)
> +{
> +	if (gate->flags & CLK_GATE_BIG_ENDIAN)
> +		iowrite32be(val, gate->reg);
> +	else
> +		writel(val, gate->reg);
> +}

Rockchip platform has no clocks using CLK_GATE_BIG_ENDIAN flag, so
you can just use readl/writel. But by reusing clk-gate's function
(see next comment) you don't need to directly read/write registers
anyways.

> +
> +/*
> + * It works on following logic:
> + *
> + * For enabling clock, enable =3D 1
> + *	set2dis =3D 1	-> clear bit	-> set =3D 0
> + *	set2dis =3D 0	-> set bit	-> set =3D 1
> + *
> + * For disabling clock, enable =3D 0
> + *	set2dis =3D 1	-> set bit	-> set =3D 1
> + *	set2dis =3D 0	-> clear bit	-> set =3D 0
> + *
> + * So, result is always: enable xor set2dis.
> + */
> +static void clk_gate_endisable(struct clk_hw *hw, int enable)
> +{
> +	struct clk_gate_link *gate =3D to_clk_gate_link(hw);
> +	int set =3D gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
> +	unsigned long flags;
> +	u32 reg;
> +
> +	set ^=3D enable;
> +
> +	if (gate->lock)
> +		spin_lock_irqsave(gate->lock, flags);
> +	else
> +		__acquire(gate->lock);
> +
> +	if (gate->flags & CLK_GATE_HIWORD_MASK) {
> +		reg =3D BIT(gate->bit_idx + 16);
> +		if (set)
> +			reg |=3D BIT(gate->bit_idx);
> +	} else {
> +		reg =3D clk_gate_readl(gate);
> +
> +		if (set)
> +			reg |=3D BIT(gate->bit_idx);
> +		else
> +			reg &=3D ~BIT(gate->bit_idx);
> +	}
> +
> +	clk_gate_writel(gate, reg);
> +
> +	if (gate->lock)
> +		spin_unlock_irqrestore(gate->lock, flags);
> +	else
> +		__release(gate->lock);
> +}

By changing "struct clk_gate_link" to look like this:

struct clk_gate_link {
    struct clk_gate gate;
    struct clk	*link;
}

It can be casted to be a normal struct clk_gate, which
means you can reuse clk_gate_endisable() (needs to be
exported) and clk_gate_is_enabled().

> +static int clk_gate_link_enable(struct clk_hw *hw)
> +{
> +	struct clk_gate_link *gate =3D to_clk_gate_link(hw);
> +
> +	clk_gate_endisable(hw, 1);
> +	clk_enable(gate->link);
> +
> +	return 0;
> +}
> +
> +static void clk_gate_link_disable(struct clk_hw *hw)
> +{
> +	struct clk_gate_link *gate =3D to_clk_gate_link(hw);
> +
> +	clk_gate_endisable(hw, 0);
> +	clk_disable(gate->link);
> +}
> +
> +static int clk_gate_link_is_enabled(struct clk_hw *hw)
> +{
> +	u32 reg;
> +	struct clk_gate_link *gate =3D to_clk_gate_link(hw);
> +
> +	reg =3D clk_gate_readl(gate);
> +
> +	/* if a set bit disables this clk, flip it before masking */
> +	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> +		reg ^=3D BIT(gate->bit_idx);
> +
> +	reg &=3D BIT(gate->bit_idx);
> +
> +	return reg ? 1 : 0;
> +}
> +
> +const struct clk_ops clk_gate_link_ops =3D {
> +	.enable =3D clk_gate_link_enable,
> +	.disable =3D clk_gate_link_disable,
> +	.is_enabled =3D clk_gate_link_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_gate_link_ops);

I don't think they need to be exported?

> +
> +struct clk *rockchip_clk_register_gate_link(struct rockchip_clk_provider=
 *ctx,
> +					    const char *name, const char *parent_name,
> +					    unsigned int link_id, u8 flags,
> +					    void __iomem *gate_offset, u8 gate_shift,
> +					    u8 gate_flags, spinlock_t *lock)
> +{
> +	struct clk_gate_link *gate;
> +	struct clk_init_data init =3D {};
> +	struct clk **clks;
> +	struct clk *clk_link;
> +
> +	if (gate_flags & CLK_GATE_HIWORD_MASK) {
> +		if (gate_shift > 15) {
> +			pr_err("gate bit exceeds LOWORD field\n");
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	/* allocate the gate */
> +	gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clks =3D ctx->clk_data.clks;
> +	gate->link =3D clks[link_id];
> +
> +	init.name =3D name;
> +	init.ops =3D &clk_gate_link_ops;
> +	init.flags =3D flags;
> +	init.parent_names =3D parent_name ? &parent_name : NULL;
> +	init.num_parents =3D 1;
> +
> +	/* struct clk_gate assignments */
> +	gate->reg =3D gate_offset;
> +	gate->bit_idx =3D gate_shift;
> +	gate->flags =3D gate_flags;
> +	gate->lock =3D lock;
> +	gate->hw.init =3D &init;
> +
> +	clk_link =3D clk_register(NULL, &gate->hw);
> +	if (IS_ERR(clk_link)) {
> +		kfree(gate);
> +		pr_err("%s clk_register field\n", name);
> +		return ERR_CAST(clk_link);
> +	}
> +	clk_prepare(gate->link);

So the linked clock will always be prepared? Can't we just extend clk_gate_=
link_ops with

=2Eprepare =3D clk_gate_link_prepare,
=2Eunprepare =3D clk_gate_link_unprepare,

int clk_gate_link_prepare(clk_gate_link_prepare) {
    struct clk_gate_link *gate =3D to_clk_gate_link(hw);
    return clk_prepare(gate->link);
}

void clk_gate_link_unprepare(clk_gate_link_prepare) {
    struct clk_gate_link *gate =3D to_clk_gate_link(hw);
    clk_unprepare(gate->link);
}

Greetings,

-- Sebastian

> +
> +	return clk_link;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_clk_register_gate_link);
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 4059d9365ae6..d981ef6c5487 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -509,6 +509,13 @@ void rockchip_clk_register_branches(struct rockchip_=
clk_provider *ctx,
>  				ctx->reg_base + list->gate_offset,
>  				list->gate_shift, list->gate_flags, &ctx->lock);
>  			break;
> +
> +		case branch_gate_link:
> +			clk =3D rockchip_clk_register_gate_link(ctx, list->name,
> +				list->parent_names[0], list->link_id, flags,
> +				ctx->reg_base + list->gate_offset,
> +				list->gate_shift, list->gate_flags, &ctx->lock);
> +			break;
>  		case branch_composite:
>  			clk =3D rockchip_clk_register_branch(list->name,
>  				list->parent_names, list->num_parents,
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 758ebaf2236b..b49e3cede33a 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -517,6 +517,7 @@ enum rockchip_clk_branch_type {
>  	branch_divider,
>  	branch_fraction_divider,
>  	branch_gate,
> +	branch_gate_link,
>  	branch_mmc,
>  	branch_inverter,
>  	branch_factor,
> @@ -529,6 +530,7 @@ struct rockchip_clk_branch {
>  	enum rockchip_clk_branch_type	branch_type;
>  	const char			*name;
>  	const char			*const *parent_names;
> +	unsigned int			link_id;
>  	u8				num_parents;
>  	unsigned long			flags;
>  	int				muxdiv_offset;
> @@ -842,6 +844,20 @@ struct rockchip_clk_branch {
>  		.gate_flags	=3D gf,				\
>  	}
> =20
> +#define GATE_LINK(_id, cname, pname, _linkid, f, o, b, gf) \
> +	{							\
> +		.id		=3D _id,				\
> +		.branch_type	=3D branch_gate_link,		\
> +		.name		=3D cname,			\
> +		.parent_names	=3D (const char *[]){ pname },	\
> +		.num_parents	=3D 1,				\
> +		.link_id	=3D _linkid,			\
> +		.flags		=3D f,				\
> +		.gate_offset	=3D o,				\
> +		.gate_shift	=3D b,				\
> +		.gate_flags	=3D gf,				\
> +	}
> +
>  #define MMC(_id, cname, pname, offset, shift)			\
>  	{							\
>  		.id		=3D _id,				\
> @@ -1002,6 +1018,12 @@ struct clk *rockchip_clk_register_halfdiv(const ch=
ar *name,
>  					  unsigned long flags,
>  					  spinlock_t *lock);
> =20
> +struct clk *rockchip_clk_register_gate_link(struct rockchip_clk_provider=
 *ctx,
> +					    const char *name, const char *parent_name,
> +					    unsigned int link_id, u8 flags,
> +					    void __iomem *gate_offset, u8 gate_shift,
> +					    u8 gate_flags, spinlock_t *lock);
> +
>  #ifdef CONFIG_RESET_CONTROLLER
>  void rockchip_register_softrst_lut(struct device_node *np,
>  				   const int *lookup_table,
> --=20
> 2.17.1
>=20

--zhivbfvldrdlg66n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTJRE4ACgkQ2O7X88g7
+pp6rA/+Ou6DeYKC1j1vZrGdNDBLAxOuNrhXfTX7/onXVUkSWp1/I/sVJJwbY4Sc
5zhRbfYkAd0HKmsRfsLF3cCoQAUuRRVzMY4sqpk3P4Lf37vIhyrb7TDym2cSL+TM
5WGZp36E7cnbQ0kTFNVnBD8bw7IjjnpaQfkStfWm6msliL86X2k1zqKf8D7+feGd
mwJAPcHj/il+2475cWtJTG4NyJqyEKOKDVdu55Q5FOpDI1Sp0N3OCAyKwumtsBzp
wE05hBwV//ECl7lWhJ2vEpz8snkyjiYze+P075X9KkgWt6nrRYtr95xxI6tdhs64
6vVM23wFZ5cbwO64q6WRPw0CKn+8fM6n+hTF4ey8LEsmVQU6+RUBDTEJQjJxovoK
NL2fs/rM9YDnw66VAYd/rIWuo+cs/N1+HHljn0Ib7MReaXARtm4cFhUxlE8Z91nM
vgj3INOXoT1VU6Avp/VkQcoj5ZRhgE6cHAMzTKXiGcwSBp02jHoaDoE9Q4uu6zSi
Ezi89PNP0NX/vJHcmYjtFReVUwbc3Dm5CN+WjyoIpr5ke33tEBpkblUb/ifMegbP
LtbX+mXClk1ljeETm4owdqwC6iMV8TIcXqhoc/0sLr+ZL5g48ahT2264zMKCXZJP
8CHMjZpYq+HUPBaH+wXawuZB8LMzWSVH74HMf+j+g6rIyuF0dKY=
=ihge
-----END PGP SIGNATURE-----

--zhivbfvldrdlg66n--
