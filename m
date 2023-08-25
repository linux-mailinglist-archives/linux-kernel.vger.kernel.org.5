Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7585C78900D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjHYU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjHYU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A742136;
        Fri, 25 Aug 2023 13:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F584631B1;
        Fri, 25 Aug 2023 20:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B458DC433C8;
        Fri, 25 Aug 2023 20:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692997130;
        bh=g08hzV5OBUeJ7RWaVONAbcH3zygdvgpJ5wKolWeZ0zI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RIUQ/Ih2Tcz3f07wyn6v2xDJy5LgoJmrbrBsmyqX5s+3LmNUYXDADnKuZoCsnb3RQ
         PmkzpIa55YuL/n8anpNjfBkp1vDjLPotofNfZpnBlPo68AWos1lkv4Os6S+B94wb+D
         naDyKbgXmayZrBvWRuUOf08fo7t2KEuWoaxygXw8DU4HB7jTjFG6j0OL9ddJlwRFMA
         hVSJOxYILvEOq8eq/hiqJTnPnIH3EmQuu/BKNuZMVgnQiLCOsNeaVj7E37jbF9UOx9
         NgCeCo8MuLUwcJQrx6T49tIK+IJsrN2u83McU1s9HOaOgvTSTLzNTv8li9bDdFOG5/
         9Rt7kF8GxjYMw==
Message-ID: <4a00db79414dbc47a2b7792d849f7056.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230825091234.32713-2-quic_devipriy@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com> <20230825091234.32713-2-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V2 1/7] clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL support for ipq9574
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_devipriy@quicinc.com, quic_saahtoma@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        geert+renesas@glider.be, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, nfraprado@collabora.com,
        p.zabel@pengutronix.de, peng.fan@nxp.com, rafal@milecki.pl,
        richardcochran@gmail.com, robh+dt@kernel.org, will@kernel.org
Date:   Fri, 25 Aug 2023 13:58:48 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-08-25 02:12:28)
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index e4ef645f65d1..1c2a72840cd2 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -228,6 +228,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] =3D {
>                 [PLL_OFF_ALPHA_VAL] =3D 0x24,
>                 [PLL_OFF_ALPHA_VAL_U] =3D 0x28,
>         },
> +

Why the extra newline? All other types aren't this way.

> +       [CLK_ALPHA_PLL_TYPE_NSS_HUAYRA] =3D  {
> +               [PLL_OFF_L_VAL] =3D 0x04,
> +               [PLL_OFF_ALPHA_VAL] =3D 0x08,
> +               [PLL_OFF_TEST_CTL] =3D 0x0c,
> +               [PLL_OFF_TEST_CTL_U] =3D 0x10,
> +               [PLL_OFF_USER_CTL] =3D 0x14,
> +               [PLL_OFF_CONFIG_CTL] =3D 0x18,
> +               [PLL_OFF_CONFIG_CTL_U] =3D 0x1c,
> +               [PLL_OFF_STATUS] =3D 0x20,
> +       },
> +
