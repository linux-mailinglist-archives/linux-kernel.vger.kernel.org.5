Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804CB80A995
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjLHQre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjLHQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:47:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591A1706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:47:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34074C433C7;
        Fri,  8 Dec 2023 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702054055;
        bh=Nlkga6g3C7ek2d0oC2OIXcV9f1KPwOmL71pG1YCFCyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyWvRm3lPVqMBmbTvfn2JlPLT44wK+nTl5zy/RdDBxoFtPuf/f7+cIQd+Pkey9n8U
         CbzkajRmL5ptqRKloUroJn0DA7EIGF1hy4p1NKbATjRTk2BNDgS1f1pvVf8MWKRu3O
         hCJxMFdry/YAjL13n4eJWuQ/Pjh/iQtz9LdrNY583V04wCWYslx1bQOO5npipJICMt
         HGzGtMKiI9R5vjOd+CoxpXP7WvTYgGgoYb7dNdfz1cSQSryPRmCv3UuEzufA00l58S
         lYiyRjisgFNdxT8/hHifteOpYzfrAurw7gNHjCAdP1C4k+FcegLqxl/ksSwmb0OfKD
         1BzHrm7C237Fw==
Date:   Fri, 8 Dec 2023 16:47:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com, Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v6 3/4] clk: sophgo: Add SG2042 clock generator driver
Message-ID: <20231208-opposite-stand-fc92fbaaed9c@spud>
References: <cover.1701997033.git.unicorn_wang@outlook.com>
 <d1aa4f76f360ebd7b790a4786641f1b0188dbba8.1701997033.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zSaoztR3cqS2zH/d"
Content-Disposition: inline
In-Reply-To: <d1aa4f76f360ebd7b790a4786641f1b0188dbba8.1701997033.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zSaoztR3cqS2zH/d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 09:14:32AM +0800, Chen Wang wrote:

> +#define div_mask(width) ((1 << (width)) - 1)

Looks like this should be genmask.

> +#define ENCODE_PLL_CTRL(fbdiv, p1, p2, refdiv) \
> +	(((fbdiv & 0xfff) << 16) | ((p2 & 0x7) << 12) | ((p1 & 0x7) << 8) | (re=
fdiv & 0x3f))

IMO this should be a function not a macro.

> +
> +static inline int __sg2042_pll_enable(struct sg2042_pll_clock *pll, bool=
 en)

Why the __ prefixing of function names btw?

> +{
> +	unsigned int value =3D 0;
> +	unsigned long enter;
> +	struct regmap *map =3D pll->map;
> +
> +	if (en) {
> +		/* wait pll lock */
> +		enter =3D jiffies;
> +		regmap_read(map, pll->offset_status, &value);
> +		while (!((value >> pll->shift_status_lock) & 0x1)) {
> +			regmap_read(map, pll->shift_status_lock, &value);
> +			if (time_after(jiffies, enter + HZ / 10))
> +				pr_warn("%s not locked\n", pll->name);
> +		}

Can't you just use read_poll_timeout()?
https://elixir.bootlin.com/linux/latest/source/include/linux/iopoll.h#L16

> +		/* wait pll updating */
> +		enter =3D jiffies;
> +		regmap_read(map, pll->shift_status_updating, &value);
> +		while (((value >> pll->shift_status_updating) & 0x1)) {
> +			regmap_read(map, pll->shift_status_updating, &value);
> +			if (time_after(jiffies, enter + HZ / 10))
> +				pr_warn("%s still updating\n", pll->name);
> +		}
> +		/* enable pll */
> +		regmap_read(map, pll->offset_enable, &value);
> +		regmap_write(map, pll->offset_enable, value | (1 << pll->shift_enable)=
);
> +	} else {
> +		/* disable pll */
> +		regmap_read(map, pll->offset_enable, &value);
> +		regmap_write(map, pll->offset_enable, value & (~(1 << pll->shift_enabl=
e)));
> +	}
> +
> +	return 0;
> +}
> +

> +static unsigned int __sg2042_get_table_div(
> +	const struct clk_div_table *table,
> +	unsigned int val)
> +{
> +	const struct clk_div_table *clkt;
> +
> +	for (clkt =3D table; clkt->div; clkt++)
> +		if (clkt->val =3D=3D val)
> +			return clkt->div;
> +	return 0;
> +}
> +
> +static unsigned int __sg2042_get_div(
> +	const struct clk_div_table *table,
> +	unsigned int val,
> +	unsigned long flags, u8 width)
> +{
> +	if (flags & CLK_DIVIDER_ONE_BASED)
> +		return val;
> +	if (flags & CLK_DIVIDER_POWER_OF_TWO)
> +		return 1 << val;
> +	if (flags & CLK_DIVIDER_MAX_AT_ZERO)
> +		return val ? val : div_mask(width) + 1;
> +	if (table)
> +		return __sg2042_get_table_div(table, val);
> +	return val + 1;
> +}

Are these not effectively the same as clk_divider's ops?

> +
> +/*
> + * @reg_value: current register value
> + * @parent_rate: parent frequency
> + *
> + * This function is used to calculate below "rate" in equation
> + * rate =3D (parent_rate/REFDIV) x FBDIV/POSTDIV1/POSTDIV2
> + *      =3D (parent_rate x FBDIV) / (REFDIV x POSTDIV1 x POSTDIV2)
> + */
> +static unsigned long __sg2042_pll_recalc_rate(
> +	unsigned int reg_value,
> +	unsigned long parent_rate)
> +{
> +	unsigned int fbdiv, refdiv;
> +	unsigned int postdiv1, postdiv2;
> +	u64 rate, numerator, denominator;
> +
> +	fbdiv =3D (reg_value >> 16) & 0xfff;
> +	refdiv =3D reg_value & 0x3f;
> +	postdiv1 =3D (reg_value >> 8) & 0x7;
> +	postdiv2 =3D (reg_value >> 12) & 0x7;

IMO all of these are opportunities for GENMASK and defines.

> +
> +	numerator =3D parent_rate * fbdiv;
> +	denominator =3D refdiv * postdiv1 * postdiv2;
> +	do_div(numerator, denominator);
> +	rate =3D numerator;
> +
> +	return rate;
> +}
> +
> +/*
> + * Below array is the total combination lists of POSTDIV1 and POSTDIV2
> + * for example:
> + * postdiv1_2[0] =3D {2, 4, 8}
> + *           =3D=3D> div1 =3D 2, div2 =3D 4 , div1 * div2 =3D 8
> + * And POSTDIV_RESULT_INDEX point to 3rd element in the array
> + */
> +#define	POSTDIV_RESULT_INDEX	2
> +static int postdiv1_2[][3] =3D {
> +	{2, 4,  8}, {3, 3,  9}, {2, 5, 10}, {2, 6, 12},
> +	{2, 7, 14}, {3, 5, 15}, {4, 4, 16}, {3, 6, 18},
> +	{4, 5, 20}, {3, 7, 21}, {4, 6, 24}, {5, 5, 25},
> +	{4, 7, 28}, {5, 6, 30}, {5, 7, 35}, {6, 6, 36},
> +	{6, 7, 42}, {7, 7, 49}
> +};
> +
> +/*
> + * Based on input rate/prate/fbdiv/refdiv, look up the postdiv1_2 table
> + * to get the closest postdiiv combination.
> + * @rate: FOUTPOSTDIV
> + * @prate: parent rate, i.e. FREF
> + * @fbdiv: FBDIV
> + * @refdiv: REFDIV
> + * @postdiv1: POSTDIV1, output
> + * @postdiv2: POSTDIV2, output
> + * See TRM:
> + * FOUTPOSTDIV =3D FREF * FBDIV / REFDIV / (POSTDIV1 * POSTDIV2)
> + * So we get following formula to get POSTDIV1 and POSTDIV2:
> + * POSTDIV =3D (prate/REFDIV) x FBDIV/rate
> + * above POSTDIV =3D POSTDIV1*POSTDIV2
> + */
> +static int __sg2042_pll_get_postdiv_1_2(
> +	unsigned long rate,
> +	unsigned long prate,
> +	unsigned int fbdiv,
> +	unsigned int refdiv,
> +	unsigned int *postdiv1,
> +	unsigned int *postdiv2)

This is not the coding style btw.

> +{
> +	int index =3D 0;
> +	int ret =3D 0;
> +	u64 tmp0;
> +
> +	/* prate/REFDIV and result save to tmp0 */
> +	tmp0 =3D prate;
> +	do_div(tmp0, refdiv);
> +
> +	/* ((prate/REFDIV) x FBDIV) and result save to tmp0 */
> +	tmp0 *=3D fbdiv;
> +
> +	/* ((prate/REFDIV) x FBDIV)/rate and result save to tmp0 */
> +	do_div(tmp0, rate);
> +
> +	/* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 value */
> +	if (tmp0 <=3D 7) {
> +		/* (div1 * div2) <=3D 7, no need to use array search */
> +		*postdiv1 =3D tmp0;
> +		*postdiv2 =3D 1;
> +	} else {
> +		/* (div1 * div2) > 7, use array search */
> +		for (index =3D 0; index < ARRAY_SIZE(postdiv1_2); index++) {
> +			if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
> +				continue;
> +			} else {
> +				/* found it */
> +				break;
> +			}
> +		}
> +		if (index < ARRAY_SIZE(postdiv1_2)) {
> +			*postdiv1 =3D postdiv1_2[index][1];
> +			*postdiv2 =3D postdiv1_2[index][0];
> +		} else {
> +			pr_debug("%s can not find in postdiv array!\n", __func__);
> +			ret =3D -EINVAL;
> +		}
> +	}
> +
> +	return ret;
> +}

Reading this function it makes me wonder if (and I am far from the best
person to comment, someone like Stephen is vastly more qualified) you
should model this as several "stages", each implemented by the
"standard" clocks - like clk_divider etc. The code here is quite
complicated IMO as it seems to be trying to implement several stages of
division in one go.

There's quite a lot in the driver and I will admit that I have not read
it all my any means (I skimmed from here onwards), but in general my
advice would be to try and reuse the generic code as much as possible.

Thanks,
Conor.


> +
> +#define KHZ 1000UL
> +#define MHZ (KHZ * KHZ)
> +
> +#define REFDIV_MIN 1
> +#define REFDIV_MAX 63
> +#define FBDIV_MIN 16
> +#define FBDIV_MAX 320
> +
> +#define PLL_FREF_SG2042 (25 * MHZ)
> +
> +#define PLL_FOUTPOSTDIV_MIN (16 * MHZ)
> +#define PLL_FOUTPOSTDIV_MAX (3200 * MHZ)
> +
> +#define PLL_FOUTVCO_MIN (800 * MHZ)
> +#define PLL_FOUTVCO_MAX (3200 * MHZ)
> +
> +struct sg2042_pll_ctrl {
> +	unsigned long freq;
> +	unsigned int fbdiv;
> +	unsigned int postdiv1;
> +	unsigned int postdiv2;
> +	unsigned int refdiv;
> +};
> +
> +/*
> + * Based on the given FOUTPISTDIV and the input FREF to calculate
> + * the REFDIV/FBDIV/PSTDIV1/POSTDIV2 combination for pllctrl register.
> + * @req_rate: expected output clock rate, i.e. FOUTPISTDIV
> + * @parent_rate: input parent clock rate, i.e. FREF
> + * @best: output to hold calculated combination of REFDIV/FBDIV/PSTDIV1/=
POSTDIV2
> + */
> +static int __sg2042_get_pll_ctl_setting(
> +	struct sg2042_pll_ctrl *best,
> +	unsigned long req_rate,
> +	unsigned long parent_rate)
> +{
> +	int ret;
> +	unsigned int fbdiv, refdiv, postdiv1, postdiv2;
> +	unsigned long foutpostdiv;
> +	u64 tmp;
> +	u64 foutvco;
> +
> +	if (parent_rate !=3D PLL_FREF_SG2042) {
> +		pr_alert("INVALID FREF: %ld\n", parent_rate);
> +		return -EINVAL;
> +	}
> +
> +	if (req_rate < PLL_FOUTPOSTDIV_MIN || req_rate > PLL_FOUTPOSTDIV_MAX) {
> +		pr_alert("INVALID FOUTPOSTDIV: %ld\n", req_rate);
> +		return -EINVAL;
> +	}
> +
> +	memset(best, 0, sizeof(struct sg2042_pll_ctrl));
> +
> +	for (refdiv =3D REFDIV_MIN; refdiv < REFDIV_MAX + 1; refdiv++) {
> +		/* required by hardware: FREF/REFDIV must > 10 */
> +		tmp =3D parent_rate;
> +		do_div(tmp, refdiv);
> +		if (tmp <=3D 10)
> +			continue;
> +
> +		for (fbdiv =3D FBDIV_MIN; fbdiv < FBDIV_MAX + 1; fbdiv++) {
> +			/*
> +			 * FOUTVCO =3D FREF*FBDIV/REFDIV validation
> +			 * required by hardware, FOUTVCO must [800MHz, 3200MHz]
> +			 */
> +			foutvco =3D parent_rate * fbdiv;
> +			do_div(foutvco, refdiv);
> +			if (foutvco < PLL_FOUTVCO_MIN || foutvco > PLL_FOUTVCO_MAX)
> +				continue;
> +
> +			ret =3D __sg2042_pll_get_postdiv_1_2(
> +				req_rate, parent_rate, fbdiv, refdiv,
> +				&postdiv1, &postdiv2);
> +			if (ret)
> +				continue;
> +
> +			/*
> +			 * FOUTPOSTDIV =3D FREF*FBDIV/REFDIV/(POSTDIV1*POSTDIV2)
> +			 *             =3D FOUTVCO/(POSTDIV1*POSTDIV2)
> +			 */
> +			tmp =3D foutvco;
> +			do_div(tmp, (postdiv1 * postdiv2));
> +			foutpostdiv =3D (unsigned long)tmp;
> +			/* Iterative to approach the expected value */
> +			if (abs_diff(foutpostdiv, req_rate) <
> +			    abs_diff(best->freq, req_rate)) {
> +				best->freq =3D foutpostdiv;
> +				best->refdiv =3D refdiv;
> +				best->fbdiv =3D fbdiv;
> +				best->postdiv1 =3D postdiv1;
> +				best->postdiv2 =3D postdiv2;
> +				if (foutpostdiv =3D=3D req_rate)
> +					return 0;
> +			}
> +			continue;
> +		}
> +	}
> +
> +	if (best->freq =3D=3D 0)
> +		return -EINVAL;
> +	else
> +		return 0;
> +}
> +
> +/*
> + * @hw: ccf use to hook get sg2042_pll_clock
> + * @parent_rate: parent rate
> + *
> + * The is function will be called through clk_get_rate
> + * and return current rate after decoding reg value
> + */
> +static unsigned long sg2042_clk_pll_recalc_rate(
> +	struct clk_hw *hw,
> +	unsigned long parent_rate)
> +{
> +	unsigned int value;
> +	unsigned long rate;
> +	struct sg2042_pll_clock *pll =3D to_sg2042_pll_clk(hw);
> +
> +	regmap_read(pll->map, pll->offset_ctrl, &value);
> +	rate =3D __sg2042_pll_recalc_rate(value, parent_rate);
> +
> +	pr_debug("--> %s: pll_recalc_rate: val =3D %ld\n",
> +		clk_hw_get_name(hw), rate);
> +	return rate;
> +}
> +
> +static long sg2042_clk_pll_round_rate(
> +	struct clk_hw *hw,
> +	unsigned long req_rate,
> +	unsigned long *prate)
> +{
> +	unsigned int value;
> +	struct sg2042_pll_ctrl pctrl_table;
> +	long proper_rate;
> +	int ret;
> +
> +	ret =3D __sg2042_get_pll_ctl_setting(&pctrl_table, req_rate, *prate);
> +	if (ret) {
> +		proper_rate =3D 0;
> +		goto out;
> +	}
> +
> +	value =3D ENCODE_PLL_CTRL(pctrl_table.fbdiv, pctrl_table.postdiv1,
> +			     pctrl_table.postdiv2, pctrl_table.refdiv);
> +	proper_rate =3D (long)__sg2042_pll_recalc_rate(value, *prate);
> +
> +out:
> +	pr_debug("--> %s: pll_round_rate: val =3D %ld\n",
> +		clk_hw_get_name(hw), proper_rate);
> +	return proper_rate;
> +}
> +
> +static int sg2042_clk_pll_determine_rate(
> +	struct clk_hw *hw,
> +	struct clk_rate_request *req)
> +{
> +	req->rate =3D sg2042_clk_pll_round_rate(hw, min(req->rate, req->max_rat=
e),
> +					  &req->best_parent_rate);
> +	pr_debug("--> %s: pll_determine_rate: val =3D %ld\n",
> +		clk_hw_get_name(hw), req->rate);
> +	return 0;
> +}
> +
> +static int sg2042_clk_pll_set_rate(
> +	struct clk_hw *hw,
> +	unsigned long rate,
> +	unsigned long parent_rate)
> +{
> +	unsigned long flags;
> +	unsigned int value;
> +	int ret =3D 0;
> +	struct sg2042_pll_ctrl pctrl_table;
> +	struct sg2042_pll_clock *pll =3D to_sg2042_pll_clk(hw);
> +
> +	spin_lock_irqsave(pll->lock, flags);
> +	if (__sg2042_pll_enable(pll, 0)) {
> +		pr_warn("Can't disable pll(%s), status error\n", pll->name);
> +		goto out;
> +	}
> +	ret =3D __sg2042_get_pll_ctl_setting(&pctrl_table, rate, parent_rate);
> +	if (ret) {
> +		pr_warn("%s: Can't find a proper pll setting\n", pll->name);
> +		goto out2;
> +	}
> +
> +	value =3D ENCODE_PLL_CTRL(pctrl_table.fbdiv, pctrl_table.postdiv1,
> +			     pctrl_table.postdiv2, pctrl_table.refdiv);
> +
> +	/* write the value to top register */
> +	regmap_write(pll->map, pll->offset_ctrl, value);
> +
> +out2:
> +	__sg2042_pll_enable(pll, 1);
> +out:
> +	spin_unlock_irqrestore(pll->lock, flags);
> +
> +	pr_debug("--> %s: pll_set_rate: val =3D 0x%x\n",
> +		clk_hw_get_name(hw), value);
> +	return ret;
> +}
> +
> +static unsigned long sg2042_clk_divider_recalc_rate(
> +	struct clk_hw *hw,
> +	unsigned long parent_rate)
> +{
> +	struct sg2042_divider_clock *divider =3D to_sg2042_clk_divider(hw);
> +	unsigned int val;
> +	unsigned long ret_rate;
> +
> +	val =3D readl(divider->reg) >> divider->shift;
> +	val &=3D div_mask(divider->width);
> +
> +	ret_rate =3D divider_recalc_rate(hw, parent_rate, val, divider->table,
> +				   divider->div_flags, divider->width);
> +
> +	pr_debug("--> %s: divider_recalc_rate: val =3D %ld\n",
> +		clk_hw_get_name(hw), ret_rate);
> +	return ret_rate;
> +}
> +
> +static long sg2042_clk_divider_round_rate(
> +	struct clk_hw *hw,
> +	unsigned long rate,
> +	unsigned long *prate)
> +{
> +	int bestdiv;
> +	unsigned long ret_rate;
> +	struct sg2042_divider_clock *divider =3D to_sg2042_clk_divider(hw);
> +
> +	/* if read only, just return current value */
> +	if (divider->div_flags & CLK_DIVIDER_READ_ONLY) {
> +		bestdiv =3D readl(divider->reg) >> divider->shift;
> +		bestdiv &=3D div_mask(divider->width);
> +		bestdiv =3D __sg2042_get_div(divider->table, bestdiv, divider->div_fla=
gs,
> +				   divider->width);
> +		ret_rate =3D DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
> +	} else {
> +		ret_rate =3D divider_round_rate(hw, rate, prate, divider->table,
> +				  divider->width, divider->div_flags);
> +	}
> +
> +	pr_debug("--> %s: divider_round_rate: val =3D %ld\n",
> +		clk_hw_get_name(hw), ret_rate);
> +	return ret_rate;
> +}
> +
> +static int sg2042_clk_divider_set_rate(
> +	struct clk_hw *hw,
> +	unsigned long rate,
> +	unsigned long parent_rate)
> +{
> +	unsigned int value;
> +	unsigned int val, val2;
> +	unsigned long flags =3D 0;
> +	struct sg2042_divider_clock *divider =3D to_sg2042_clk_divider(hw);
> +
> +	value =3D divider_get_val(rate, parent_rate, divider->table,
> +				divider->width, divider->div_flags);
> +
> +	if (divider->lock)
> +		spin_lock_irqsave(divider->lock, flags);
> +	else
> +		__acquire(divider->lock);
> +
> +	/* div assert */
> +	val =3D readl(divider->reg);
> +	val &=3D ~0x1;
> +	writel(val, divider->reg);
> +
> +	if (divider->div_flags & CLK_DIVIDER_HIWORD_MASK) {
> +		val =3D div_mask(divider->width) << (divider->shift + 16);
> +	} else {
> +		val =3D readl(divider->reg);
> +		val &=3D ~(div_mask(divider->width) << divider->shift);
> +	}
> +
> +	val |=3D value << divider->shift;
> +	writel(val, divider->reg);
> +	val2 =3D val;
> +
> +	if (!(divider->div_flags & CLK_DIVIDER_READ_ONLY))
> +		val |=3D 1 << 3;
> +
> +	/* de-assert */
> +	val |=3D 1;
> +	writel(val, divider->reg);
> +	if (divider->lock)
> +		spin_unlock_irqrestore(divider->lock, flags);
> +	else
> +		__release(divider->lock);
> +
> +	pr_debug("--> %s: divider_set_rate: register val =3D 0x%x\n",
> +		clk_hw_get_name(hw), val2);
> +	return 0;
> +}
> +
> +static const struct clk_ops sg2042_clk_divider_ops =3D {
> +	.recalc_rate =3D sg2042_clk_divider_recalc_rate,
> +	.round_rate =3D sg2042_clk_divider_round_rate,
> +	.set_rate =3D sg2042_clk_divider_set_rate,
> +};
> +
> +static const struct clk_ops sg2042_clk_divider_ro_ops =3D {
> +	.recalc_rate =3D sg2042_clk_divider_recalc_rate,
> +	.round_rate =3D sg2042_clk_divider_round_rate,
> +};
> +
> +static const struct clk_ops sg2042_clk_pll_ops =3D {
> +	.recalc_rate =3D sg2042_clk_pll_recalc_rate,
> +	.round_rate =3D sg2042_clk_pll_round_rate,
> +	.determine_rate =3D sg2042_clk_pll_determine_rate,
> +	.set_rate =3D sg2042_clk_pll_set_rate,
> +};
> +
> +static const struct clk_ops sg2042_clk_pll_ro_ops =3D {
> +	.recalc_rate =3D sg2042_clk_pll_recalc_rate,
> +	.round_rate =3D sg2042_clk_pll_round_rate,
> +};
> +
> +#define SG2042_PLL(_id, _name, _parent_name, _r_stat, _r_enable, _r_ctrl=
, _shift) \
> +	{								\
> +		.hw.init =3D CLK_HW_INIT_PARENTS(				\
> +				_name,					\
> +				(const char *[]){_parent_name},		\
> +				&sg2042_clk_pll_ops,			\
> +				CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_NOCACHE),\
> +		.id =3D _id,						\
> +		.name =3D _name,						\
> +		.offset_ctrl =3D _r_ctrl,					\
> +		.offset_status =3D _r_stat,				\
> +		.offset_enable =3D _r_enable,				\
> +		.shift_status_lock =3D 8 + _shift,			\
> +		.shift_status_updating =3D _shift,			\
> +		.shift_enable =3D _shift,					\
> +	}
> +
> +#define SG2042_PLL_RO(_id, _name, _parent_name, _r_stat, _r_enable, _r_c=
trl, _shift) \
> +	{								\
> +		.hw.init =3D CLK_HW_INIT_PARENTS(				\
> +				_name,					\
> +				(const char *[]){_parent_name},		\
> +				&sg2042_clk_pll_ro_ops,			\
> +				CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_NOCACHE),\
> +		.id =3D _id,						\
> +		.name =3D _name,						\
> +		.offset_ctrl =3D _r_ctrl,					\
> +		.offset_status =3D _r_stat,				\
> +		.offset_enable =3D _r_enable,				\
> +		.shift_status_lock =3D 8 + _shift,			\
> +		.shift_status_updating =3D _shift,			\
> +		.shift_enable =3D _shift,					\
> +	}
> +
> +static struct sg2042_pll_clock sg2042_pll_clks[] =3D {
> +	SG2042_PLL_RO(FPLL_CLK, "fpll_clock", "cgi",
> +		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_FPLL_CONTROL, 3),
> +	SG2042_PLL_RO(DPLL0_CLK, "dpll0_clock", "cgi",
> +		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL0_CONTROL, 4),
> +	SG2042_PLL_RO(DPLL1_CLK, "dpll1_clock", "cgi",
> +		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL1_CONTROL, 5),
> +	SG2042_PLL(MPLL_CLK, "mpll_clock", "cgi",
> +		R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_MPLL_CONTROL, 0),
> +};
> +
> +#define SG2042_DIV(_id, _name, _parent_name,				\
> +		  _r_ctrl, _shift, _width,				\
> +		  _div_flag, _init_val) {				\
> +		.hw.init =3D CLK_HW_INIT_PARENTS(				\
> +				_name,					\
> +				(const char *[]){_parent_name},		\
> +				&sg2042_clk_divider_ops,		\
> +				0),					\
> +		.id =3D _id,						\
> +		.name =3D _name,						\
> +		.offset_ctrl =3D _r_ctrl,					\
> +		.shift =3D _shift,					\
> +		.width =3D _width,					\
> +		.div_flags =3D _div_flag,					\
> +		.initial_val =3D _init_val,				\
> +		.table =3D NULL,						\
> +	}
> +
> +#define SG2042_DIV_RO(_id, _name, _parent_name,				\
> +		  _r_ctrl, _shift, _width,				\
> +		  _div_flag, _init_val) {				\
> +		.hw.init =3D CLK_HW_INIT_PARENTS(				\
> +				_name,					\
> +				(const char *[]){_parent_name},		\
> +				&sg2042_clk_divider_ro_ops,		\
> +				0),					\
> +		.id =3D _id,						\
> +		.name =3D _name,						\
> +		.offset_ctrl =3D _r_ctrl,					\
> +		.shift =3D _shift,					\
> +		.width =3D _width,					\
> +		.div_flags =3D _div_flag,					\
> +		.initial_val =3D _init_val,				\
> +		.table =3D NULL,						\
> +	}
> +
> +/*
> + * DIV items in the array are sorted according to the clock-tree diagram,
> + * from top to bottom, from upstream to downstream. Read TRM for details.
> + */
> +#define DEF_DIVFLAG (CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO)
> +static struct sg2042_divider_clock sg2042_div_clks[] =3D {
> +	SG2042_DIV_RO(DIV_CLK_DPLL0_DDR01_0,
> +		"clk_div_ddr01_0", "clk_gate_ddr01_div0",
> +		R_CLKDIVREG27, 16, 5,
> +		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
> +	SG2042_DIV_RO(DIV_CLK_FPLL_DDR01_1,
> +		"clk_div_ddr01_1", "clk_gate_ddr01_div1",
> +		R_CLKDIVREG28, 16, 5,
> +		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
> +
> +	SG2042_DIV_RO(DIV_CLK_DPLL1_DDR23_0,
> +		"clk_div_ddr23_0", "clk_gate_ddr23_div0",
> +		R_CLKDIVREG29, 16, 5,
> +		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
> +	SG2042_DIV_RO(DIV_CLK_FPLL_DDR23_1,
> +		"clk_div_ddr23_1", "clk_gate_ddr23_div1",
> +		R_CLKDIVREG30, 16, 5,
> +		DEF_DIVFLAG | CLK_DIVIDER_READ_ONLY, -1),
> +
> +	SG2042_DIV(DIV_CLK_MPLL_RP_CPU_NORMAL_0,
> +		"clk_div_rp_cpu_normal_0", "clk_gate_rp_cpu_normal_div0",
> +		R_CLKDIVREG0, 16, 5, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_RP_CPU_NORMAL_1,
> +		"clk_div_rp_cpu_normal_1", "clk_gate_rp_cpu_normal_div1",
> +		R_CLKDIVREG1, 16, 5, DEF_DIVFLAG, 0),
> +
> +	SG2042_DIV(DIV_CLK_MPLL_AXI_DDR_0,
> +		"clk_div_axi_ddr_0", "clk_gate_axi_ddr_div0",
> +		R_CLKDIVREG25, 16, 5, DEF_DIVFLAG, 5),
> +	SG2042_DIV(DIV_CLK_FPLL_AXI_DDR_1,
> +		"clk_div_axi_ddr_1", "clk_gate_axi_ddr_div1",
> +		R_CLKDIVREG26, 16, 5, DEF_DIVFLAG, 5),
> +
> +	SG2042_DIV(DIV_CLK_FPLL_TOP_RP_CMN_DIV2,
> +		"clk_div_top_rp_cmn_div2", "clk_mux_rp_cpu_normal",
> +		R_CLKDIVREG3, 16, 16, DEF_DIVFLAG, 0),
> +
> +	SG2042_DIV(DIV_CLK_FPLL_50M_A53, "clk_div_50m_a53", "fpll_clock",
> +		R_CLKDIVREG2, 16, 8, DEF_DIVFLAG, 0),
> +	/* downstream of div_50m_a53 */
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER1, "clk_div_timer1", "clk_div_50m_a53",
> +		R_CLKDIVREG6, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER2, "clk_div_timer2", "clk_div_50m_a53",
> +		R_CLKDIVREG7, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER3, "clk_div_timer3", "clk_div_50m_a53",
> +		R_CLKDIVREG8, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER4, "clk_div_timer4", "clk_div_50m_a53",
> +		R_CLKDIVREG9, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER5, "clk_div_timer5", "clk_div_50m_a53",
> +		R_CLKDIVREG10, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER6, "clk_div_timer6", "clk_div_50m_a53",
> +		R_CLKDIVREG11, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER7, "clk_div_timer7", "clk_div_50m_a53",
> +		R_CLKDIVREG12, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER8, "clk_div_timer8", "clk_div_50m_a53",
> +		R_CLKDIVREG13, 16, 16, DEF_DIVFLAG, 0),
> +
> +	SG2042_DIV_RO(DIV_CLK_FPLL_UART_500M, "clk_div_uart_500m", "fpll_clock",
> +		R_CLKDIVREG4, 16, 7,
> +		CLK_DIVIDER_READ_ONLY, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_AHB_LPC, "clk_div_ahb_lpc", "fpll_clock",
> +		R_CLKDIVREG5, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_EFUSE, "clk_div_efuse", "fpll_clock",
> +		R_CLKDIVREG14, 16, 7, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_TX_ETH0, "clk_div_tx_eth0", "fpll_clock",
> +		R_CLKDIVREG16, 16, 11, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_PTP_REF_I_ETH0,
> +		"clk_div_ptp_ref_i_eth0", "fpll_clock",
> +		R_CLKDIVREG17, 16, 8, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_REF_ETH0, "clk_div_ref_eth0", "fpll_clock",
> +		R_CLKDIVREG18, 16, 8, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_EMMC, "clk_div_emmc", "fpll_clock",
> +		R_CLKDIVREG19, 16, 5, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_SD, "clk_div_sd", "fpll_clock",
> +		R_CLKDIVREG21, 16, 5, DEF_DIVFLAG, 0),
> +
> +	SG2042_DIV(DIV_CLK_FPLL_TOP_AXI0, "clk_div_top_axi0", "fpll_clock",
> +		R_CLKDIVREG23, 16, 5, DEF_DIVFLAG, 0),
> +	/* downstream of div_top_axi0 */
> +	SG2042_DIV(DIV_CLK_FPLL_100K_EMMC, "clk_div_100k_emmc", "clk_div_top_ax=
i0",
> +		R_CLKDIVREG20, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_100K_SD, "clk_div_100k_sd", "clk_div_top_axi0",
> +		R_CLKDIVREG22, 16, 16, DEF_DIVFLAG, 0),
> +	SG2042_DIV(DIV_CLK_FPLL_GPIO_DB, "clk_div_gpio_db", "clk_div_top_axi0",
> +		R_CLKDIVREG15, 16, 16, DEF_DIVFLAG, 0),
> +
> +	SG2042_DIV(DIV_CLK_FPLL_TOP_AXI_HSPERI,
> +		"clk_div_top_axi_hsperi", "fpll_clock",
> +		R_CLKDIVREG24, 16, 5, DEF_DIVFLAG, 0),
> +};
> +
> +#define SG2042_GATE(_id, _name, _parent_name, _flags, \
> +		    _r_enable, _bit_idx, _flag_r) { \
> +		.id =3D _id,			\
> +		.name =3D _name,			\
> +		.parent_name =3D _parent_name,	\
> +		.flags =3D _flags,		\
> +		.offset_enable =3D _r_enable,	\
> +		.bit_idx =3D _bit_idx,		\
> +		.flag_sysctrl =3D _flag_r,	\
> +	}
> +
> +/*
> + * GATE items in the array are sorted according to the clock-tree diagra=
m,
> + * from top to bottom, from upstream to downstream. Read TRM for details.
> + */
> +static const struct sg2042_gate_clock sg2042_gate_clks[] =3D {
> +	SG2042_GATE(GATE_CLK_DDR01_DIV0, "clk_gate_ddr01_div0", "dpll0_clock",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		R_CLKDIVREG27, 4, 0),
> +	SG2042_GATE(GATE_CLK_DDR01_DIV1, "clk_gate_ddr01_div1", "fpll_clock",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKDIVREG28, 4, 0),
> +
> +	SG2042_GATE(GATE_CLK_DDR23_DIV0, "clk_gate_ddr23_div0", "dpll1_clock",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		R_CLKDIVREG29, 4, 0),
> +	SG2042_GATE(GATE_CLK_DDR23_DIV1, "clk_gate_ddr23_div1", "fpll_clock",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKDIVREG30, 4, 0),
> +
> +	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV0, "clk_gate_rp_cpu_normal_div0",=
 "mpll_clock",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKDIVREG0, 4, 0),
> +	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV1,
> +		"clk_gate_rp_cpu_normal_div1", "fpll_clock",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKDIVREG1, 4, 0),
> +
> +	SG2042_GATE(GATE_CLK_AXI_DDR_DIV0, "clk_gate_axi_ddr_div0", "mpll_clock=
",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKDIVREG25, 4, 0),
> +	SG2042_GATE(GATE_CLK_AXI_DDR_DIV1, "clk_gate_axi_ddr_div1", "fpll_clock=
",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKDIVREG26, 4, 0),
> +
> +	/* upon are gate clocks as input source for the muxes */
> +
> +	SG2042_GATE(GATE_CLK_DDR01, "clk_gate_ddr01", "clk_mux_ddr01",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKENREG1, 14, 0),
> +
> +	SG2042_GATE(GATE_CLK_DDR23, "clk_gate_ddr23", "clk_mux_ddr23",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKENREG1, 15, 0),
> +
> +	SG2042_GATE(GATE_CLK_RP_CPU_NORMAL,
> +		"clk_gate_rp_cpu_normal", "clk_mux_rp_cpu_normal",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKENREG0, 0, 0),
> +
> +	SG2042_GATE(GATE_CLK_AXI_DDR, "clk_gate_axi_ddr", "clk_mux_axi_ddr",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKENREG1, 13, 0),
> +
> +	/* upon are gate clocks directly downstream of muxes */
> +
> +	/* downstream of clk_div_top_rp_cmn_div2 */
> +	SG2042_GATE(GATE_CLK_TOP_RP_CMN_DIV2,
> +		"clk_gate_top_rp_cmn_div2", "clk_div_top_rp_cmn_div2",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 2, 0),
> +	SG2042_GATE(GATE_CLK_HSDMA, "clk_gate_hsdma", "clk_gate_top_rp_cmn_div2=
",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 10, 0),
> +
> +	/*
> +	 * downstream of clk_gate_rp_cpu_normal
> +	 *
> +	 * FIXME: there should be one 1/2 DIV between clk_gate_rp_cpu_normal
> +	 * and clk_gate_axi_pcie0/clk_gate_axi_pcie1.
> +	 * But the 1/2 DIV is fixed and no configurable register exported, so
> +	 * when reading from these two clocks, the rate value are still the
> +	 * same as that of clk_gate_rp_cpu_normal, it's not correct.
> +	 * This just affects the value read.
> +	 */
> +	SG2042_GATE(GATE_CLK_AXI_PCIE0,
> +		"clk_gate_axi_pcie0", "clk_gate_rp_cpu_normal",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1, 8, 0),
> +	SG2042_GATE(GATE_CLK_AXI_PCIE1,
> +		"clk_gate_axi_pcie1", "clk_gate_rp_cpu_normal",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1, 9, 0),
> +
> +	/* downstream of div_50m_a53 */
> +	SG2042_GATE(GATE_CLK_A53_50M, "clk_gate_a53_50m", "clk_div_50m_a53",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 1, 0),
> +	SG2042_GATE(GATE_CLK_TIMER1, "clk_gate_timer1", "clk_div_timer1",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 12, 0),
> +	SG2042_GATE(GATE_CLK_TIMER2, "clk_gate_timer2", "clk_div_timer2",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 13, 0),
> +	SG2042_GATE(GATE_CLK_TIMER3, "clk_gate_timer3", "clk_div_timer3",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 14, 0),
> +	SG2042_GATE(GATE_CLK_TIMER4, "clk_gate_timer4", "clk_div_timer4",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 15, 0),
> +	SG2042_GATE(GATE_CLK_TIMER5, "clk_gate_timer5", "clk_div_timer5",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 16, 0),
> +	SG2042_GATE(GATE_CLK_TIMER6, "clk_gate_timer6", "clk_div_timer6",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 17, 0),
> +	SG2042_GATE(GATE_CLK_TIMER7, "clk_gate_timer7", "clk_div_timer7",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 18, 0),
> +	SG2042_GATE(GATE_CLK_TIMER8, "clk_gate_timer8", "clk_div_timer8",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 19, 0),
> +
> +	/* gate clocks downstream from div clocks one-to-one */
> +	SG2042_GATE(GATE_CLK_UART_500M, "clk_gate_uart_500m", "clk_div_uart_500=
m",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0, 4, 0),
> +	SG2042_GATE(GATE_CLK_AHB_LPC, "clk_gate_ahb_lpc", "clk_div_ahb_lpc",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 7, 0),
> +	SG2042_GATE(GATE_CLK_EFUSE, "clk_gate_efuse", "clk_div_efuse",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 20, 0),
> +	SG2042_GATE(GATE_CLK_TX_ETH0, "clk_gate_tx_eth0", "clk_div_tx_eth0",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 30, 0),
> +	SG2042_GATE(GATE_CLK_PTP_REF_I_ETH0,
> +		"clk_gate_ptp_ref_i_eth0", "clk_div_ptp_ref_i_eth0",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 0, 0),
> +	SG2042_GATE(GATE_CLK_REF_ETH0, "clk_gate_ref_eth0", "clk_div_ref_eth0",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 1, 0),
> +	SG2042_GATE(GATE_CLK_EMMC_100M, "clk_gate_emmc", "clk_div_emmc",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 3, 0),
> +	SG2042_GATE(GATE_CLK_SD_100M, "clk_gate_sd", "clk_div_sd",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 6, 0),
> +
> +	/* downstream of clk_div_top_axi0 */
> +	SG2042_GATE(GATE_CLK_AHB_ROM, "clk_gate_ahb_rom", "clk_div_top_axi0",
> +		 0, R_CLKENREG0, 8, 0),
> +	SG2042_GATE(GATE_CLK_AHB_SF, "clk_gate_ahb_sf", "clk_div_top_axi0",
> +		0, R_CLKENREG0, 9, 0),
> +	SG2042_GATE(GATE_CLK_AXI_SRAM, "clk_gate_axi_sram", "clk_div_top_axi0",
> +		CLK_IGNORE_UNUSED, R_CLKENREG0, 10, 0),
> +	SG2042_GATE(GATE_CLK_APB_TIMER, "clk_gate_apb_timer", "clk_div_top_axi0=
",
> +		CLK_IGNORE_UNUSED, R_CLKENREG0, 11, 0),
> +	SG2042_GATE(GATE_CLK_APB_EFUSE, "clk_gate_apb_efuse", "clk_div_top_axi0=
",
> +		0, R_CLKENREG0, 21, 0),
> +	SG2042_GATE(GATE_CLK_APB_GPIO, "clk_gate_apb_gpio", "clk_div_top_axi0",
> +		0, R_CLKENREG0, 22, 0),
> +	SG2042_GATE(GATE_CLK_APB_GPIO_INTR,
> +		"clk_gate_apb_gpio_intr", "clk_div_top_axi0",
> +		0, R_CLKENREG0, 23, 0),
> +	SG2042_GATE(GATE_CLK_APB_I2C, "clk_gate_apb_i2c", "clk_div_top_axi0",
> +		0, R_CLKENREG0, 26, 0),
> +	SG2042_GATE(GATE_CLK_APB_WDT, "clk_gate_apb_wdt", "clk_div_top_axi0",
> +		0, R_CLKENREG0, 27, 0),
> +	SG2042_GATE(GATE_CLK_APB_PWM, "clk_gate_apb_pwm", "clk_div_top_axi0",
> +		0, R_CLKENREG0, 28, 0),
> +	SG2042_GATE(GATE_CLK_APB_RTC, "clk_gate_apb_rtc", "clk_div_top_axi0",
> +		0, R_CLKENREG0, 29, 0),
> +	SG2042_GATE(GATE_CLK_TOP_AXI0, "clk_gate_top_axi0", "clk_div_top_axi0",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_CLKENREG1=
, 11, 0),
> +	/* downstream of DIV clocks which are sourced from clk_div_top_axi0 */
> +	SG2042_GATE(GATE_CLK_GPIO_DB, "clk_gate_gpio_db", "clk_div_gpio_db",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 24, 0),
> +	SG2042_GATE(GATE_CLK_100K_EMMC, "clk_gate_100k_emmc", "clk_div_100k_emm=
c",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 4, 0),
> +	SG2042_GATE(GATE_CLK_100K_SD, "clk_gate_100k_sd", "clk_div_100k_sd",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 7, 0),
> +
> +	/* downstream of clk_div_top_axi_hsperi */
> +	SG2042_GATE(GATE_CLK_SYSDMA_AXI,
> +		"clk_gate_sysdma_axi", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 3, 0),
> +	SG2042_GATE(GATE_CLK_APB_UART,
> +		"clk_gate_apb_uart", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 5, 0),
> +	SG2042_GATE(GATE_CLK_AXI_DBG_I2C,
> +		"clk_gate_axi_dbg_i2c", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 6, 0),
> +	SG2042_GATE(GATE_CLK_APB_SPI,
> +		"clk_gate_apb_spi", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 25, 0),
> +	SG2042_GATE(GATE_CLK_AXI_ETH0,
> +		"clk_gate_axi_eth0", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT, R_CLKENREG0, 31, 0),
> +	SG2042_GATE(GATE_CLK_AXI_EMMC,
> +		"clk_gate_axi_emmc", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 2, 0),
> +	SG2042_GATE(GATE_CLK_AXI_SD,
> +		"clk_gate_axi_sd", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT, R_CLKENREG1, 5, 0),
> +	SG2042_GATE(GATE_CLK_TOP_AXI_HSPERI,
> +		"clk_gate_top_axi_hsperi", "clk_div_top_axi_hsperi",
> +		CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL,
> +		R_CLKENREG1, 12, 0),
> +
> +	/* downstream of clk_gate_rp_cpu_normal about rxu */
> +	SG2042_GATE(GATE_CLK_RXU0, "clk_gate_rxu0", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 0, 1),
> +	SG2042_GATE(GATE_CLK_RXU1, "clk_gate_rxu1", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 1, 1),
> +	SG2042_GATE(GATE_CLK_RXU2, "clk_gate_rxu2", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 2, 1),
> +	SG2042_GATE(GATE_CLK_RXU3, "clk_gate_rxu3", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 3, 1),
> +	SG2042_GATE(GATE_CLK_RXU4, "clk_gate_rxu4", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 4, 1),
> +	SG2042_GATE(GATE_CLK_RXU5, "clk_gate_rxu5", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 5, 1),
> +	SG2042_GATE(GATE_CLK_RXU6, "clk_gate_rxu6", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 6, 1),
> +	SG2042_GATE(GATE_CLK_RXU7, "clk_gate_rxu7", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 7, 1),
> +	SG2042_GATE(GATE_CLK_RXU8, "clk_gate_rxu8", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 8, 1),
> +	SG2042_GATE(GATE_CLK_RXU9, "clk_gate_rxu9", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 9, 1),
> +	SG2042_GATE(GATE_CLK_RXU10, "clk_gate_rxu10", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 10, 1),
> +	SG2042_GATE(GATE_CLK_RXU11, "clk_gate_rxu11", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 11, 1),
> +	SG2042_GATE(GATE_CLK_RXU12, "clk_gate_rxu12", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 12, 1),
> +	SG2042_GATE(GATE_CLK_RXU13, "clk_gate_rxu13", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 13, 1),
> +	SG2042_GATE(GATE_CLK_RXU14, "clk_gate_rxu14", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 14, 1),
> +	SG2042_GATE(GATE_CLK_RXU15, "clk_gate_rxu15", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 15, 1),
> +	SG2042_GATE(GATE_CLK_RXU16, "clk_gate_rxu16", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 16, 1),
> +	SG2042_GATE(GATE_CLK_RXU17, "clk_gate_rxu17", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 17, 1),
> +	SG2042_GATE(GATE_CLK_RXU18, "clk_gate_rxu18", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 18, 1),
> +	SG2042_GATE(GATE_CLK_RXU19, "clk_gate_rxu19", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 19, 1),
> +	SG2042_GATE(GATE_CLK_RXU20, "clk_gate_rxu20", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 20, 1),
> +	SG2042_GATE(GATE_CLK_RXU21, "clk_gate_rxu21", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 21, 1),
> +	SG2042_GATE(GATE_CLK_RXU22, "clk_gate_rxu22", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 22, 1),
> +	SG2042_GATE(GATE_CLK_RXU23, "clk_gate_rxu23", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 23, 1),
> +	SG2042_GATE(GATE_CLK_RXU24, "clk_gate_rxu24", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 24, 1),
> +	SG2042_GATE(GATE_CLK_RXU25, "clk_gate_rxu25", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 25, 1),
> +	SG2042_GATE(GATE_CLK_RXU26, "clk_gate_rxu26", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 26, 1),
> +	SG2042_GATE(GATE_CLK_RXU27, "clk_gate_rxu27", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 27, 1),
> +	SG2042_GATE(GATE_CLK_RXU28, "clk_gate_rxu28", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 28, 1),
> +	SG2042_GATE(GATE_CLK_RXU29, "clk_gate_rxu29", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 29, 1),
> +	SG2042_GATE(GATE_CLK_RXU30, "clk_gate_rxu30", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 30, 1),
> +	SG2042_GATE(GATE_CLK_RXU31, "clk_gate_rxu31", "clk_gate_rp_cpu_normal",
> +		0, R_RP_RXU_CLK_ENABLE, 31, 1),
> +
> +	/* downstream of clk_gate_rp_cpu_normal about mp */
> +	SG2042_GATE(GATE_CLK_MP0, "clk_gate_mp0", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP0_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP1, "clk_gate_mp1", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP1_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP2, "clk_gate_mp2", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP2_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP3, "clk_gate_mp3", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP3_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP4, "clk_gate_mp4", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP4_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP5, "clk_gate_mp5", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP5_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP6, "clk_gate_mp6", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP6_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP7, "clk_gate_mp7", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP7_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP8, "clk_gate_mp8", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP8_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP9, "clk_gate_mp9", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP9_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP10, "clk_gate_mp10", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP10_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP11, "clk_gate_mp11", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP11_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP12, "clk_gate_mp12", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP12_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP13, "clk_gate_mp13", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP13_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP14, "clk_gate_mp14", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP14_CONTROL_REG, 0, 1),
> +	SG2042_GATE(GATE_CLK_MP15, "clk_gate_mp15", "clk_gate_rp_cpu_normal",
> +		CLK_IGNORE_UNUSED | CLK_IS_CRITICAL, R_MP15_CONTROL_REG, 0, 1),
> +};
> +
> +#define SG2042_MUX(_id, _name, _parent_names, _flags, _r_select, _shift,=
 _width) { \
> +		.id =3D _id,					\
> +		.name =3D _name,					\
> +		.parent_names =3D _parent_names,			\
> +		.num_parents =3D ARRAY_SIZE(_parent_names),	\
> +		.flags =3D _flags,				\
> +		.offset_select =3D _r_select,			\
> +		.shift =3D _shift,				\
> +		.width =3D _width,				\
> +	}
> +
> +/*
> + * Note: regarding names for mux clock, "0/1" or "div0/div1" means the
> + * first/second parent input source, not the register value.
> + * For example:
> + * "clk_div_ddr01_0" is the name of Clock divider 0 control of DDR01, and
> + * "clk_gate_ddr01_div0" is the gate clock in front of the "clk_div_ddr0=
1_0",
> + * they are both controlled by register CLKDIVREG27;
> + * "clk_div_ddr01_1" is the name of Clock divider 1 control of DDR01, and
> + * "clk_gate_ddr01_div1" is the gate clock in front of the "clk_div_ddr0=
1_1",
> + * they are both controlled by register CLKDIVREG28;
> + * While for register value of mux selection, use Clock Select for DDR01=
=E2=80=99s clock
> + * as example, see CLKSELREG0, bit[2].
> + * 1: Select in_dpll0_clk as clock source, correspondng to the parent in=
put
> + *    source from "clk_div_ddr01_0".
> + * 0: Select in_fpll_clk as clock source, corresponding to the parent in=
put
> + *    source from "clk_div_ddr01_1".
> + * So we need a table to define the array of register values correspondi=
ng to
> + * the parent index and tell CCF about this when registering mux clock.
> + */
> +static const u32 sg2042_mux_table[] =3D {1, 0};
> +
> +static const char *const clk_mux_ddr01_p[] =3D {
> +			"clk_div_ddr01_0", "clk_div_ddr01_1"};
> +static const char *const clk_mux_ddr23_p[] =3D {
> +			"clk_div_ddr23_0", "clk_div_ddr23_1"};
> +static const char *const clk_mux_rp_cpu_normal_p[] =3D {
> +			"clk_div_rp_cpu_normal_0", "clk_div_rp_cpu_normal_1"};
> +static const char *const clk_mux_axi_ddr_p[] =3D {
> +			"clk_div_axi_ddr_0", "clk_div_axi_ddr_1"};
> +
> +static struct sg2042_mux_clock sg2042_mux_clks[] =3D {
> +	SG2042_MUX(MUX_CLK_DDR01, "clk_mux_ddr01", clk_mux_ddr01_p,
> +		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_MUX_READ_ONLY,
> +		R_CLKSELREG0, 2, 1),
> +	SG2042_MUX(MUX_CLK_DDR23, "clk_mux_ddr23", clk_mux_ddr23_p,
> +		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_MUX_READ_ONLY,
> +		R_CLKSELREG0, 3, 1),
> +	SG2042_MUX(MUX_CLK_RP_CPU_NORMAL, "clk_mux_rp_cpu_normal", clk_mux_rp_c=
pu_normal_p,
> +		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
> +		R_CLKSELREG0, 0, 1),
> +	SG2042_MUX(MUX_CLK_AXI_DDR, "clk_mux_axi_ddr", clk_mux_axi_ddr_p,
> +		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
> +		R_CLKSELREG0, 1, 1),
> +};
> +
> +static DEFINE_SPINLOCK(sg2042_clk_lock);
> +
> +static int sg2042_clk_register_plls(struct sg2042_clk_data *clk_data,
> +				   struct sg2042_pll_clock pll_clks[],
> +				   int num_pll_clks)
> +{
> +	struct clk_hw *hw;
> +	struct sg2042_pll_clock *pll;
> +	int i, ret =3D 0;
> +
> +	for (i =3D 0; i < num_pll_clks; i++) {
> +		pll =3D &(pll_clks[i]);
> +		/* assign these for ops usage during registration */
> +		pll->map =3D clk_data->regmap_syscon;
> +		pll->lock =3D &sg2042_clk_lock;
> +
> +		hw =3D &pll->hw;
> +		ret =3D clk_hw_register(NULL, hw);
> +		if (ret) {
> +			pr_err("failed to register clock %s\n", pll->name);
> +			break;
> +		}
> +
> +		clk_data->onecell_data.hws[pll->id] =3D hw;
> +	}
> +
> +	/* leave unregister to outside if failed */
> +	return ret;
> +}
> +
> +static int sg2042_clk_register_divs(struct sg2042_clk_data *clk_data,
> +				   struct sg2042_divider_clock div_clks[],
> +				   int num_div_clks)
> +{
> +	struct clk_hw *hw;
> +	struct sg2042_divider_clock *div;
> +	int i, val, ret =3D 0;
> +
> +	for (i =3D 0; i < num_div_clks; i++) {
> +		div =3D &(div_clks[i]);
> +
> +		if (div->div_flags & CLK_DIVIDER_HIWORD_MASK) {
> +			if (div->width + div->shift > 16) {
> +				pr_warn("divider value exceeds LOWORD field\n");
> +				ret =3D -EINVAL;
> +				break;
> +			}
> +		}
> +
> +		div->reg =3D clk_data->iobase + div->offset_ctrl;
> +		div->lock =3D &sg2042_clk_lock;
> +
> +		hw =3D &div->hw;
> +		ret =3D clk_hw_register(NULL, hw);
> +		if (ret) {
> +			pr_err("failed to register clock %s\n", div->name);
> +			break;
> +		}
> +
> +		clk_data->onecell_data.hws[div->id] =3D hw;
> +
> +		if (div->initial_val >=3D 0) {
> +			val =3D readl(div->reg);
> +
> +			/*
> +			 * set a default divider factor,
> +			 * clk driver should not select divider clock as the
> +			 * clock source, before set the divider by right process
> +			 * (assert div, set div factor, de assert div).
> +			 */
> +			if (div->initial_val > 0)
> +				val |=3D (div->initial_val << 16 | 1 << 3);
> +			else {
> +				/*
> +				 * the div register is config to use divider
> +				 * factor, don't change divider
> +				 */
> +				if (!(val >> 3 & 0x1))
> +					val |=3D 1 << 16;
> +			}
> +
> +			writel(val, div->reg);
> +		}
> +	}
> +
> +	/* leave unregister to outside if failed */
> +	return ret;
> +}
> +
> +static int sg2042_clk_register_gates(struct sg2042_clk_data *clk_data,
> +				    const struct sg2042_gate_clock gate_clks[],
> +				    int num_gate_clks)
> +{
> +	struct clk_hw *hw;
> +	const struct sg2042_gate_clock *gate;
> +	int i, ret =3D 0;
> +	void __iomem *reg;
> +
> +	for (i =3D 0; i < num_gate_clks; i++) {
> +		gate =3D &(gate_clks[i]);
> +		if (gate->flag_sysctrl)
> +			reg =3D clk_data->iobase_syscon + gate->offset_enable;
> +		else
> +			reg =3D clk_data->iobase + gate->offset_enable;
> +		hw =3D clk_hw_register_gate(
> +			NULL,
> +			gate->name,
> +			gate->parent_name,
> +			gate->flags,
> +			reg,
> +			gate->bit_idx,
> +			0,
> +			&sg2042_clk_lock);
> +		if (IS_ERR(hw)) {
> +			pr_err("failed to register clock %s\n", gate->name);
> +			ret =3D PTR_ERR(hw);
> +			break;
> +		}
> +
> +		clk_data->onecell_data.hws[gate->id] =3D hw;
> +	}
> +
> +	/* leave unregister to outside if failed */
> +	return ret;
> +}
> +
> +static int sg2042_mux_notifier_cb(struct notifier_block *nb,
> +				unsigned long event, void *data)
> +{
> +	int ret =3D 0;
> +	struct clk_notifier_data *ndata =3D data;
> +	struct clk_hw *hw =3D __clk_get_hw(ndata->clk);
> +	const struct clk_ops *ops =3D &clk_mux_ops;
> +	struct sg2042_mux_clock *mux =3D to_sg2042_mux_nb(nb);
> +
> +	/* To switch to fpll before changing rate and restore after that */
> +	if (event =3D=3D PRE_RATE_CHANGE) {
> +		mux->original_index =3D ops->get_parent(hw);
> +
> +		/*
> +		 * "1" is the array index of the second parent input source of
> +		 * mux. For SG2042, it's fpll for all mux clocks.
> +		 * "0" is the array index of the frist parent input source of
> +		 * mux, For SG2042, it's mpll.
> +		 * FIXME, any good idea to avoid magic number?
> +		 */
> +		if (mux->original_index =3D=3D 0)
> +			ret =3D ops->set_parent(hw, 1);
> +	} else if (event =3D=3D POST_RATE_CHANGE) {
> +		ret =3D ops->set_parent(hw, mux->original_index);
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
> +static int sg2042_clk_register_muxs(struct sg2042_clk_data *clk_data,
> +				   struct sg2042_mux_clock mux_clks[],
> +				   int num_mux_clks)
> +{
> +	struct clk_hw *hw;
> +	struct sg2042_mux_clock *mux;
> +	int i, ret =3D 0;
> +
> +	for (i =3D 0; i < num_mux_clks; i++) {
> +		mux =3D &(mux_clks[i]);
> +
> +		hw =3D clk_hw_register_mux_table(
> +			NULL,
> +			mux->name,
> +			mux->parent_names,
> +			mux->num_parents,
> +			mux->flags,
> +			clk_data->iobase + mux->offset_select,
> +			mux->shift,
> +			BIT(mux->width) - 1,
> +			0,
> +			sg2042_mux_table,
> +			&sg2042_clk_lock);
> +		if (IS_ERR(hw)) {
> +			pr_err("failed to register clock %s\n", mux->name);
> +			ret =3D PTR_ERR(hw);
> +			break;
> +		}
> +
> +		clk_data->onecell_data.hws[mux->id] =3D hw;
> +
> +		/*
> +		 * FIXME: Theoretically, we should set parent for the
> +		 * mux, but seems hardware has done this for us with
> +		 * default value, so we don't set parent again here.
> +		 */
> +
> +		if (!(mux->flags & CLK_MUX_READ_ONLY)) {
> +			mux->clk_nb.notifier_call =3D sg2042_mux_notifier_cb;
> +			ret =3D clk_notifier_register(hw->clk, &(mux->clk_nb));
> +			if (ret) {
> +				pr_err("failed to register clock notifier for %s\n",
> +					mux->name);
> +				goto error_cleanup;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +
> +error_cleanup:
> +	/* unregister notifier and release the memory allocated */
> +	for (i =3D 0; i < num_mux_clks; i++) {
> +		mux =3D &(mux_clks[i]);
> +
> +		hw =3D clk_data->onecell_data.hws[mux->id];
> +
> +		if (hw !=3D NULL)
> +			clk_notifier_unregister(hw->clk, &(mux->clk_nb));
> +	}
> +
> +	/* leave clk unregister to outside if failed */
> +	return ret;
> +}
> +
> +static int __init sg2042_clk_init_clk_data(
> +	struct device_node *node,
> +	int num_clks,
> +	struct sg2042_clk_data **pp_clk_data)
> +{
> +	int ret =3D 0;
> +	struct sg2042_clk_data *clk_data =3D NULL;
> +	struct device_node *np_syscon;
> +
> +	np_syscon =3D of_parse_phandle(node, "sophgo,system-ctrl", 0);
> +	if (!np_syscon) {
> +		pr_err("failed to get system-ctrl node\n");
> +		ret =3D -EINVAL;
> +		goto error_out;
> +	}
> +
> +	clk_data =3D kzalloc(struct_size(clk_data, onecell_data.hws, num_clks),=
 GFP_KERNEL);
> +	if (!clk_data) {
> +		ret =3D -ENOMEM;
> +		goto error_out;
> +	}
> +
> +	clk_data->regmap_syscon =3D device_node_to_regmap(np_syscon);
> +	if (IS_ERR_OR_NULL(clk_data->regmap_syscon)) {
> +		pr_err("cannot get regmap_syscon %ld\n", PTR_ERR(clk_data->regmap_sysc=
on));
> +		ret =3D -ENODEV;
> +		goto cleanup;
> +	}
> +	clk_data->iobase_syscon =3D of_iomap(np_syscon, 0);
> +	clk_data->iobase =3D of_iomap(node, 0);
> +	clk_data->onecell_data.num =3D num_clks;
> +
> +	*pp_clk_data =3D clk_data;
> +	return ret;
> +
> +cleanup:
> +	kfree(clk_data);
> +
> +error_out:
> +	return ret;
> +}
> +
> +static void __init sg2042_clk_init(struct device_node *node)
> +{
> +	struct sg2042_clk_data *clk_data =3D NULL;
> +	int i, ret =3D 0;
> +	int num_clks =3D 0;
> +
> +	num_clks =3D ARRAY_SIZE(sg2042_pll_clks) +
> +		   ARRAY_SIZE(sg2042_div_clks) +
> +		   ARRAY_SIZE(sg2042_gate_clks) +
> +		   ARRAY_SIZE(sg2042_mux_clks);
> +	if (num_clks =3D=3D 0) {
> +		ret =3D -EINVAL;
> +		goto error_out;
> +	}
> +
> +	ret =3D sg2042_clk_init_clk_data(node, num_clks, &clk_data);
> +	if (ret < 0)
> +		goto error_out;
> +
> +	ret =3D sg2042_clk_register_plls(clk_data, sg2042_pll_clks,
> +				ARRAY_SIZE(sg2042_pll_clks));
> +	if (ret)
> +		goto cleanup;
> +
> +	ret =3D sg2042_clk_register_divs(clk_data, sg2042_div_clks,
> +				ARRAY_SIZE(sg2042_div_clks));
> +	if (ret)
> +		goto cleanup;
> +
> +	ret =3D sg2042_clk_register_gates(clk_data, sg2042_gate_clks,
> +				ARRAY_SIZE(sg2042_gate_clks));
> +	if (ret)
> +		goto cleanup;
> +
> +	ret =3D sg2042_clk_register_muxs(clk_data, sg2042_mux_clks,
> +				ARRAY_SIZE(sg2042_mux_clks));
> +	if (ret)
> +		goto cleanup;
> +
> +	ret =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, &clk_data->=
onecell_data);
> +	if (ret)
> +		goto cleanup;
> +
> +	return;
> +
> +cleanup:
> +	for (i =3D 0; i < num_clks; i++) {
> +		if (clk_data->onecell_data.hws[i] !=3D NULL)
> +			clk_hw_unregister(clk_data->onecell_data.hws[i]);
> +	}
> +	kfree(clk_data);
> +
> +error_out:
> +	pr_err("%s failed error number %d\n", __func__, ret);
> +}
> +
> +CLK_OF_DECLARE(sg2042_clk, "sophgo,sg2042-clkgen", sg2042_clk_init);
> diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.h b/drivers/clk/sophgo/=
clk-sophgo-sg2042.h
> new file mode 100644
> index 000000000000..651d93033547
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-sophgo-sg2042.h
> @@ -0,0 +1,226 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __CLK_SOPHGO_SG2042_H
> +#define __CLK_SOPHGO_SG2042_H
> +
> +#include <linux/regmap.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +
> +/* Registers defined in SYS_CTRL */
> +#define R_PLL_STAT		0xC0
> +#define R_PLL_CLKEN_CONTROL	0xC4
> +#define R_MPLL_CONTROL		0xE8
> +#define R_FPLL_CONTROL		0xF4
> +#define R_DPLL0_CONTROL		0xF8
> +#define R_DPLL1_CONTROL		0xFC
> +
> +#define R_RP_RXU_CLK_ENABLE	0x0368
> +#define R_MP0_STATUS_REG	0x0380
> +#define R_MP0_CONTROL_REG	0x0384
> +#define R_MP1_STATUS_REG	0x0388
> +#define R_MP1_CONTROL_REG	0x038C
> +#define R_MP2_STATUS_REG	0x0390
> +#define R_MP2_CONTROL_REG	0x0394
> +#define R_MP3_STATUS_REG	0x0398
> +#define R_MP3_CONTROL_REG	0x039C
> +#define R_MP4_STATUS_REG	0x03A0
> +#define R_MP4_CONTROL_REG	0x03A4
> +#define R_MP5_STATUS_REG	0x03A8
> +#define R_MP5_CONTROL_REG	0x03AC
> +#define R_MP6_STATUS_REG	0x03B0
> +#define R_MP6_CONTROL_REG	0x03B4
> +#define R_MP7_STATUS_REG	0x03B8
> +#define R_MP7_CONTROL_REG	0x03BC
> +#define R_MP8_STATUS_REG	0x03C0
> +#define R_MP8_CONTROL_REG	0x03C4
> +#define R_MP9_STATUS_REG	0x03C8
> +#define R_MP9_CONTROL_REG	0x03CC
> +#define R_MP10_STATUS_REG	0x03D0
> +#define R_MP10_CONTROL_REG	0x03D4
> +#define R_MP11_STATUS_REG	0x03D8
> +#define R_MP11_CONTROL_REG	0x03DC
> +#define R_MP12_STATUS_REG	0x03E0
> +#define R_MP12_CONTROL_REG	0x03E4
> +#define R_MP13_STATUS_REG	0x03E8
> +#define R_MP13_CONTROL_REG	0x03EC
> +#define R_MP14_STATUS_REG	0x03F0
> +#define R_MP14_CONTROL_REG	0x03F4
> +#define R_MP15_STATUS_REG	0x03F8
> +#define R_MP15_CONTROL_REG	0x03FC
> +
> +/* Registers defined in CLOCK */
> +#define R_CLKENREG0		0x00
> +#define R_CLKENREG1		0x04
> +#define R_CLKSELREG0		0x20
> +#define R_CLKDIVREG0		0x40
> +#define R_CLKDIVREG1		0x44
> +#define R_CLKDIVREG2		0x48
> +#define R_CLKDIVREG3		0x4C
> +#define R_CLKDIVREG4		0x50
> +#define R_CLKDIVREG5		0x54
> +#define R_CLKDIVREG6		0x58
> +#define R_CLKDIVREG7		0x5C
> +#define R_CLKDIVREG8		0x60
> +#define R_CLKDIVREG9		0x64
> +#define R_CLKDIVREG10		0x68
> +#define R_CLKDIVREG11		0x6C
> +#define R_CLKDIVREG12		0x70
> +#define R_CLKDIVREG13		0x74
> +#define R_CLKDIVREG14		0x78
> +#define R_CLKDIVREG15		0x7C
> +#define R_CLKDIVREG16		0x80
> +#define R_CLKDIVREG17		0x84
> +#define R_CLKDIVREG18		0x88
> +#define R_CLKDIVREG19		0x8C
> +#define R_CLKDIVREG20		0x90
> +#define R_CLKDIVREG21		0x94
> +#define R_CLKDIVREG22		0x98
> +#define R_CLKDIVREG23		0x9C
> +#define R_CLKDIVREG24		0xA0
> +#define R_CLKDIVREG25		0xA4
> +#define R_CLKDIVREG26		0xA8
> +#define R_CLKDIVREG27		0xAC
> +#define R_CLKDIVREG28		0xB0
> +#define R_CLKDIVREG29		0xB4
> +#define R_CLKDIVREG30		0xB8
> +
> +/*
> + * clock common data
> + * @iobase: address of clock-controller
> + * @iobase_syscon & @regmap_syscon: point to the same address of system-=
controller,
> + *  the reason we use two different type of pointer just due to PLL uses
> + *  regmap while others use iomem.
> + * @lock: clock register access lock
> + * @onecell_data: used for adding providers.
> + */
> +struct sg2042_clk_data {
> +	void __iomem *iobase;
> +	void __iomem *iobase_syscon;
> +	struct regmap *regmap_syscon;
> +	struct clk_hw_onecell_data onecell_data;
> +};
> +
> +/*
> + * PLL clock
> + * @id:				used to map clk_onecell_data
> + * @name:			used for print even when clk registration failed
> + * @map:			used for regmap read/write, regmap is more useful
> + *				then iomem address when we have multiple offsets
> + *				for different registers.
> + *				NOTE: PLL registers are all in SYS_CTRL!
> + * @lock:			spinlock to protect register access
> + * @offset_status:		offset of pll status registers
> + * @offset_enable:		offset of pll enable registers
> + * @offset_ctrl:		offset of pll control registers
> + * @shift_status_lock:		shift of XXX_LOCK in pll status register
> + * @shift_status_updating:	shift of UPDATING_XXX in pll status register
> + * @shift_enable:		shift of XXX_CLK_EN in pll enable register
> + */
> +struct sg2042_pll_clock {
> +	struct clk_hw	hw;
> +
> +	/* private data */
> +	unsigned int id;
> +	const char *name;
> +
> +	struct regmap *map;
> +	spinlock_t *lock;
> +
> +	u32 offset_status;
> +	u32 offset_enable;
> +	u32 offset_ctrl;
> +	u8 shift_status_lock;
> +	u8 shift_status_updating;
> +	u8 shift_enable;
> +};
> +
> +#define to_sg2042_pll_clk(_hw) container_of(_hw, struct sg2042_pll_clock=
, hw)
> +
> +/*
> + * Divider clock
> + * @id:			used to map clk_onecell_data
> + * @name:		used for print even when clk registration failed
> + * @reg:		used for readl/writel.
> + *			NOTE: DIV registers are ALL in CLOCK!
> + * @lock:		spinlock to protect register access
> + * @offset_ctrl:	offset of divider control registers
> + * @shift:		shift of "Clock Divider Factor" in divider control register
> + * @width:		width of "Clock Divider Factor" in divider control register
> + * @div_flags:		private flags for this clock, not for framework-specific
> + * @initial_val:	initial value of the divider, a value < 0 means ignoring
> + *			setting of initial value.
> + * @table:		the div table that the divider supports
> + */
> +struct sg2042_divider_clock {
> +	struct clk_hw	hw;
> +
> +	/* private data */
> +	unsigned int id;
> +	const char *name;
> +
> +	void __iomem *reg;
> +	spinlock_t *lock;
> +
> +	unsigned long offset_ctrl;
> +	u8 shift;
> +	u8 width;
> +	u8 div_flags;
> +	s32 initial_val;
> +	struct clk_div_table *table;
> +};
> +
> +#define to_sg2042_clk_divider(_hw)	\
> +	container_of(_hw, struct sg2042_divider_clock, hw)
> +
> +/*
> + * Gate clock
> + * @id:			used to map clk_onecell_data
> + * @name:		string of this clock name
> + * @parent_name:	string of parent clock name
> + * @flags:		framework-specific flags for this clock
> + * @offset_enable:	offset of gate enable registers
> + * @bit_idx:		which bit in the register controls gating of this clock
> + * @flag_sysctrl:	flag if this clock is controlled by registers defined
> + *			in SYS_CTRL, 1: yes, 0: no, it's in CLOCK.
> + *			NOTE: Gate registers are scattered in SYS_CTRL and CLOCK!
> + */
> +struct sg2042_gate_clock {
> +	unsigned int id;
> +	const char *name;
> +	const char *parent_name;
> +	unsigned long flags;
> +	unsigned long offset_enable;
> +	u8 bit_idx;
> +	u8 flag_sysctrl;
> +};
> +
> +/*
> + * Mux clock
> + * @id:			used to map clk_onecell_data
> + * @name:		string of this clock name
> + * @parent_name:	string array of parents' clock name
> + * @flags:		framework-specific flags for this clock
> + * @offset_select:	offset of mux selection registers
> + *			NOTE: MUX registers are ALL in CLOCK!
> + * @shift:		shift of "Clock Select" in mux selection register
> + * @width:		width of "Clock Select" in mux selection register
> + * @clk_nb:		used for notification
> + * @original_index:	set by notifier callback
> + */
> +struct sg2042_mux_clock {
> +	unsigned int id;
> +	const char *name;
> +	const char * const *parent_names;
> +	u8 num_parents;
> +	unsigned long flags;
> +	unsigned long offset_select;
> +	u8 shift;
> +	u8 width;
> +	struct notifier_block clk_nb;
> +	u8 original_index;
> +};
> +
> +#define to_sg2042_mux_nb(_nb) container_of(_nb, struct sg2042_mux_clock,=
 clk_nb)
> +
> +#endif /* __CLK_SOPHGO_SG2042_H */
> --=20
> 2.25.1
>=20

--zSaoztR3cqS2zH/d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNIoAAKCRB4tDGHoIJi
0mpMAP9n0JuQjp7oyHdRV1YqjXYb0e24EJoZ2/8wVh504kqmFQEAzvEijx2bi6nd
E7LotvccaYYPxJWa2UZPqQhGmPS4QAs=
=oUzy
-----END PGP SIGNATURE-----

--zSaoztR3cqS2zH/d--
