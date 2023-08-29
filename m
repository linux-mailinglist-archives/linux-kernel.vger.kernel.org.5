Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40D78CF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbjH2We7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbjH2Wem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D7ACC0;
        Tue, 29 Aug 2023 15:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2D6C635D6;
        Tue, 29 Aug 2023 22:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C67C433C7;
        Tue, 29 Aug 2023 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693348477;
        bh=tOdFHvFuPcwGCZDZrKyuhVm3dO9l2kKsXphWsJkPfsY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h5gQY40G72jUzWfBFPxmp9RvDVyhPPAxxyxcL1jNTOLECeie1s0kxeLtY/bzvHNcR
         S/Sdfr3L0EXGRVHQ+Nx1LfhAaWlQ+VaeGILIxSjY31oGEvh6BnSs51ffjEl8pKKRNw
         DTgTiql1nLx5cnhOSNaZc42g38BYzeo5THBkgypQmEeUbaqcQ30PPwlfxs/io3jcHm
         cl6QivTGf/IF9DbRgJ4mRbN7HVe2eAzBzMZbZ0TxEzBGSnm0SWBpImBvP+cqNgSaev
         VbyPEw9FbFyXv5de92y9JKDTqORy5mTOilCcr3tJa9pOzi7ZaADU7j3kWKbH0oX5zm
         TdzQcRf6qPRYQ==
Message-ID: <9e3fec3f3bf11ec0722f6277593d96ff.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230829095423.760641-3-quic_gokulsri@quicinc.com>
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com> <20230829095423.760641-3-quic_gokulsri@quicinc.com>
Subject: Re: [PATCH 2/3] clk: qcom: apss-ipq-pll: add support for IPQ5018
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com
To:     Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        agross@kernel.org, andersson@kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org
Date:   Tue, 29 Aug 2023 15:34:34 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gokul Sriram Palanisamy (2023-08-29 02:54:22)
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-=
pll.c
> index e170331858cc..bbc25d5eb70d 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -24,6 +24,17 @@ static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] =
=3D {
>                 [PLL_OFF_TEST_CTL] =3D 0x30,
>                 [PLL_OFF_TEST_CTL_U] =3D 0x34,
>         },
> +       [CLK_ALPHA_PLL_TYPE_STROMER] =3D {
> +               [PLL_OFF_L_VAL] =3D 0x08,
> +               [PLL_OFF_ALPHA_VAL] =3D 0x10,
> +               [PLL_OFF_ALPHA_VAL_U] =3D 0x14,
> +               [PLL_OFF_USER_CTL] =3D 0x18,
> +               [PLL_OFF_USER_CTL_U] =3D 0x1c,
> +               [PLL_OFF_CONFIG_CTL] =3D 0x20,
> +               [PLL_OFF_STATUS] =3D 0x28,
> +               [PLL_OFF_TEST_CTL] =3D 0x30,
> +               [PLL_OFF_TEST_CTL_U] =3D 0x34,
> +       },

Is anything different from STROMER_PLUS?

>         [CLK_ALPHA_PLL_TYPE_STROMER_PLUS] =3D {
>                 [PLL_OFF_L_VAL] =3D 0x08,
>                 [PLL_OFF_ALPHA_VAL] =3D 0x10,
> @@ -73,6 +84,38 @@ static struct clk_alpha_pll ipq_pll_stromer_plus =3D {
>         },
>  };
> =20
> +static struct clk_alpha_pll ipq_pll_stromer =3D {
> +       .offset =3D 0x0,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER],
> +       .flags =3D SUPPORTS_DYNAMIC_UPDATE,
> +       .clkr =3D {
> +               .enable_reg =3D 0x0,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

const?

> +                       .name =3D "a53pll",
> +                       .parent_data =3D &(const struct clk_parent_data) {
> +                               .fw_name =3D "xo",
> +                       },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_stromer_ops,
> +               },
> +       },
> +};
> +
> +static const struct alpha_pll_config ipq5018_pll_config =3D {
> +       .l =3D 0x32,
> +       .config_ctl_val =3D 0x4001075b,
> +       .config_ctl_hi_val =3D 0x304,
> +       .main_output_mask =3D BIT(0),
> +       .aux_output_mask =3D BIT(1),
> +       .early_output_mask =3D BIT(3),
> +       .alpha_en_mask =3D BIT(24),
> +       .status_val =3D 0x3,
> +       .status_mask =3D GENMASK(10, 8),
> +       .lock_det =3D BIT(2),
> +       .test_ctl_hi_val =3D 0x00400003,
> +};
> +
>  static const struct alpha_pll_config ipq5332_pll_config =3D {
>         .l =3D 0x3e,
>         .config_ctl_val =3D 0x4001075b,
> @@ -129,6 +172,12 @@ struct apss_pll_data {
>         const struct alpha_pll_config *pll_config;
>  };
> =20
> +static struct apss_pll_data ipq5018_pll_data =3D {

const?

> +       .pll_type =3D CLK_ALPHA_PLL_TYPE_STROMER,
> +       .pll =3D &ipq_pll_stromer,
> +       .pll_config =3D &ipq5018_pll_config,
> +};
> +
>  static struct apss_pll_data ipq5332_pll_data =3D {
>         .pll_type =3D CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
>         .pll =3D &ipq_pll_stromer_plus,
> @@ -183,7 +232,7 @@ static int apss_ipq_pll_probe(struct platform_device =
*pdev)
> =20
>         if (data->pll_type =3D=3D CLK_ALPHA_PLL_TYPE_HUAYRA)
>                 clk_alpha_pll_configure(data->pll, regmap, data->pll_conf=
ig);
> -       else if (data->pll_type =3D=3D CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
> +       else

Just add both STROMER and STROMER_PLUS. Or make STROMER the same as
STROMER_PLUS locally in this file?

>                 clk_stromer_pll_configure(data->pll, regmap, data->pll_co=
nfig);
> =20
>         ret =3D devm_clk_register_regmap(dev, &data->pll->clkr);
