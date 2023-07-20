Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9B75B68B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGTSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGTSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB5135;
        Thu, 20 Jul 2023 11:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C62B61BB8;
        Thu, 20 Jul 2023 18:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5E9C433C8;
        Thu, 20 Jul 2023 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877273;
        bh=xWZNuT79nWckxP68+Fly6AA+AsZef3fv/zXx2PMynJw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bn8cEPYaU1Ktg6GA+KYs25EvtNCsMfW/IpZgX5FuwTYfEc9gtcRqNjtlfRT+j3ZN3
         UTmVLPWhIxclyzehIGOkmqW+tuWq9/ZuFT9KgkQkZRP6UdMgP9aT6IYIRl8nrgmX5j
         1Jb44u9uOWpoerkHtavQVuXh+6NI47pd82v66gdFQouR3I0JLYquzgT1N/yK3LSjnE
         HKITs5vZQ+9JLStsblnyj8uIDANpG6XQeccHZ6OYLVhFbSO5DXkSDpRcYi9gzHneza
         kqSqfhZDH8eEG2qrZpC3RwdJOyWxFOg8z054JIxN2Je7qqPLdF9FhsM/cDNgilMHK2
         TZmegHLunXZLw==
Message-ID: <6f9a6f0a4d43492604503098313c32f3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA+D8APd3n8XvC3m5fAoPxqqLzaU-RKm+e9y_G++D6KdaJJhiQ@mail.gmail.com>
References: <1689322259-13504-1-git-send-email-shengjiu.wang@nxp.com> <1689322259-13504-4-git-send-email-shengjiu.wang@nxp.com> <ad757ed215d8f098472be370e3bbd961.sboyd@kernel.org> <CAA+D8APd3n8XvC3m5fAoPxqqLzaU-RKm+e9y_G++D6KdaJJhiQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] clk: imx: imx8: add audio clock mux driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        conor+dt@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        mturquette@baylibre.com, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 20 Jul 2023 11:21:11 -0700
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

Quoting Shengjiu Wang (2023-07-20 00:31:05)
> On Thu, Jul 20, 2023 at 4:17=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> w=
rote:
>     Quoting Shengjiu Wang (2023-07-14 01:10:59)
>     > +/**
>     > + * struct imx8_acm_soc_data: soc specific data
>     > + * @sels: pointer to struct clk_imx8_acm_sel
>     > + * @num_sels: numbers of items
>     > + */
>     > +struct imx8_acm_soc_data {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk_imx8_acm_sel *sels;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int num_sels;
>     > +};
>     > +
>     > +/**
>     > + * struct imx8_acm_priv: private structure
>=20
>     Compile with W=3D1 and see that this isn't kerneldoc. Please fix.
>=20
>=20
> I have used the W=3D1,=C2=A0 but there is not error or warning from kerne=
ldoc
>=20
> My command is:
> make W=3D1 ARCH=3Darm64 CROSS_COMPILE=3D/opt/toolchain/
> gcc-linaro-14.0.0-2023.06-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-=
 -j4
>=20
> Anything I missed?

I thought W=3D1 ran kerneldoc check, but maybe not by default. Look at
the docs:

https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enume=
ration-documentation

>=20
>=20
>=20
>     > + * @dev_pm: multi power domain
>     > + * @soc_data: pointer to soc data
>     > + * @reg: base address of registers
>     > + * @regs: save registers for suspend
>     > + */
>     > +struct imx8_acm_priv {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk_imx_acm_pm_domains dev_pm;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct imx8_acm_soc_data *soc_dat=
a;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *reg;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 regs[IMX_ADMA_ACM_CLK_END];
>     > +};
>     > +
>     > +static const struct clk_parent_data imx8qm_aud_clk_sels[] =3D {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0{.fw_name =3D "aud_rec_clk0_lpcg_clk", =
.name =3D
>     "aud_rec_clk0_lpcg_clk" },
>=20
>     There should only be fw_name here, or use an index. Presumably this
>     isn't migrating old code or bindings. Also, please add space after { =
and
>     before }.
>=20
>=20
> The clock=C2=A0 "aud_rec_clk0_lpcg_clk" is not defined in this provider. =
if
> remove .name There is an issue for finding parent.

The .fw_name should be part of the DT binding. If it isn't part of the
binding as an element of clock-names then it shouldn't be in the driver
as a .fw_name. If it isn't part of the provider, then it should be
referenced by DT index or clock-names. If you use the index, you avoid a
possibly time consuming set of string comparisons. So if you can, use
the index as much as possible. If you're converting a pre-existing
binding you will have to use .name as well to fallback to the globally
unique string name for a clk.

>=20
> Should I remove .fw_name , only keep .name?

You should remove .name it sounds like.
