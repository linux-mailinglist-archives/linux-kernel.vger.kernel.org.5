Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F28123C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442764AbjLNAP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLNAP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:15:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24896C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:15:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E27C433C8;
        Thu, 14 Dec 2023 00:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702512933;
        bh=aPg6Z+wmckOVQuqjd9R9p5MP1fl4PYkCvzrh/X3o2+k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EIV1xiGGnPi1KfF5ik21wZVX0IVcX548EChGqvxvF9o6FIUKK4MV9ZyhMVdJQc2dK
         0ZIUlL4wy5i5AIwq3ng72t1/RNH1W28daEV+1XAWfXuDHHIAS3gRj8i29VRlZth4bS
         rRURKTNF7v/1EzyN3jyivB6fjHeRogUxJ/7sNY62IDZP6faka+jHt48CL8i1Q8Ttf6
         DaZJbKuUP4qqbgtuE9FmNk9m22O6QwI6vgiwX9ReHJozTm21H5FySsoyEwpihZWvOV
         k4Q8J6KzEo6D4OZPA4NejxsU5h2WLHBd8uaGhSh+ZTKlocBC8eAO4td9O057RB+u82
         l7SBX5pOyz2tg==
Message-ID: <1b4b88035d7524ad3d6de7c6084e3f07.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231212-unnerving-rule-1052a5b7253e@wendy>
References: <cover.1701997033.git.unicorn_wang@outlook.com> <d1aa4f76f360ebd7b790a4786641f1b0188dbba8.1701997033.git.unicorn_wang@outlook.com> <20231208-opposite-stand-fc92fbaaed9c@spud> <MA0P287MB0332A937E4DF0044594B19CCFE8EA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM> <20231212-unnerving-rule-1052a5b7253e@wendy>
Subject: Re: [PATCH v6 3/4] clk: sophgo: Add SG2042 clock generator driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
To:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Date:   Wed, 13 Dec 2023 16:15:31 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2023-12-12 00:37:39)
> On Tue, Dec 12, 2023 at 10:22:28AM +0800, Chen Wang wrote:
>=20
> > On 2023/12/9 0:47, Conor Dooley wrote:
> > > On Fri, Dec 08, 2023 at 09:14:32AM +0800, Chen Wang wrote:
>=20
> > > > +#define ENCODE_PLL_CTRL(fbdiv, p1, p2, refdiv) \
> > > > + (((fbdiv & 0xfff) << 16) | ((p2 & 0x7) << 12) | ((p1 & 0x7) << 8)=
 | (refdiv & 0x3f))
> > > IMO this should be a function not a macro.
>=20
> > Would like to listen why it should be a function instead of a macro? Any
> > experiences you can share with me?
>=20
> Readability. A function, which could be inlined allows you to break this
> up and make it easier to read.
>=20
> > > > +/*
> > > > + * Based on input rate/prate/fbdiv/refdiv, look up the postdiv1_2 =
table
> > > > + * to get the closest postdiiv combination.
> > > > + * @rate: FOUTPOSTDIV
> > > > + * @prate: parent rate, i.e. FREF
> > > > + * @fbdiv: FBDIV
> > > > + * @refdiv: REFDIV
> > > > + * @postdiv1: POSTDIV1, output
> > > > + * @postdiv2: POSTDIV2, output
> > > > + * See TRM:
> > > > + * FOUTPOSTDIV =3D FREF * FBDIV / REFDIV / (POSTDIV1 * POSTDIV2)
> > > > + * So we get following formula to get POSTDIV1 and POSTDIV2:
> > > > + * POSTDIV =3D (prate/REFDIV) x FBDIV/rate
> > > > + * above POSTDIV =3D POSTDIV1*POSTDIV2
> > > > + */
> > > > +static int __sg2042_pll_get_postdiv_1_2(
> > > > + unsigned long rate,
> > > > + unsigned long prate,
> > > > + unsigned int fbdiv,
> > > > + unsigned int refdiv,
> > > > + unsigned int *postdiv1,
> > > > + unsigned int *postdiv2)
> > > This is not the coding style btw.
> > Agree, will fix this.
> > > > +{
> > > > + int index =3D 0;
> > > > + int ret =3D 0;
> > > > + u64 tmp0;
> > > > +
> > > > + /* prate/REFDIV and result save to tmp0 */
> > > > + tmp0 =3D prate;
> > > > + do_div(tmp0, refdiv);
> > > > +
> > > > + /* ((prate/REFDIV) x FBDIV) and result save to tmp0 */
> > > > + tmp0 *=3D fbdiv;
> > > > +
> > > > + /* ((prate/REFDIV) x FBDIV)/rate and result save to tmp0 */
> > > > + do_div(tmp0, rate);
> > > > +
> > > > + /* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 valu=
e */
> > > > + if (tmp0 <=3D 7) {
> > > > +         /* (div1 * div2) <=3D 7, no need to use array search */
> > > > +         *postdiv1 =3D tmp0;
> > > > +         *postdiv2 =3D 1;

why not return 0 here?

> > > > + } else {

And then de-indent this?

> > > > +         /* (div1 * div2) > 7, use array search */
> > > > +         for (index =3D 0; index < ARRAY_SIZE(postdiv1_2); index++=
) {
> > > > +                 if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX=
]) {
> > > > +                         continue;
> > > > +                 } else {
> > > > +                         /* found it */
> > > > +                         break;

This can also return?

> > > > +                 }
> > > > +         }
> > > > +         if (index < ARRAY_SIZE(postdiv1_2)) {

And this condition can be removed.

> > > > +                 *postdiv1 =3D postdiv1_2[index][1];
> > > > +                 *postdiv2 =3D postdiv1_2[index][0];
> > > > +         } else {

This can be the default after the loop.

> > > > +                 pr_debug("%s can not find in postdiv array!\n", _=
_func__);
> > > > +                 ret =3D -EINVAL;


 /* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 value */
 if (tmp0 <=3D 7) {
         /* (div1 * div2) <=3D 7, no need to use array search */
         *postdiv1 =3D tmp0;
         *postdiv2 =3D 1;
	 return 0;
 }

 /* (div1 * div2) > 7, use array search */
 for (index =3D 0; index < ARRAY_SIZE(postdiv1_2); index++) {
	 if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
		 continue;
	 } else {
		 *postdiv1 =3D postdiv1_2[index][1];
		 *postdiv2 =3D postdiv1_2[index][0];
		 return 0;
	 }
 }
 pr_debug("%s can not find in postdiv array!\n", __func__);
 return -EINVAL;

> > > Reading this function it makes me wonder if (and I am far from the be=
st
> > > person to comment, someone like Stephen is vastly more qualified) you
> > > should model this as several "stages", each implemented by the
> > > "standard" clocks - like clk_divider etc. The code here is quite
> > > complicated IMO as it seems to be trying to implement several stages =
of
> > > division in one go.
> >=20
> > The objective of __sg2042_pll_get_postdiv_1_2() is straightforward: bas=
ed on
> > the formula defined by the TRM, with input rate/prate/fbdiv/refdiv, we =
can
> > get the possiblle combination of POSTDIV1 and POSTDIV2 by looking up the
> > table of postdiv1_2. We will later use it to setup the clock register.
> >=20
> > Though the codes looks a bit complicated, but accually it is calculate =
with
> > the formula : POSTDIV =3D (prate/REFDIV) x FBDIV/rate, I just separate =
it into
> > several steps to make it easy to understand, I have listed the formula =
in
> > the comment on top of the function.
>=20
> I understand what you are doing, I did something similar myself
> previously. My suggestion/question was about using the "standard" types
> of clock that the core provides to represent as many of the clocks in
> this driver as is feasible.

I would not twist the code to conform with the basic clk types. If
possible it would be good to use the helpers for these things, but I
wouldn't split up a clk that is a complex divider with multiple stages
of division into the basic types just to make it fit. I say this because
every clk takes more effort to maintain in the clk tree, it has a name,
pointers, etc. If you can keep that self contained and logically it is
really one clk, then go for it.
